package com.eland.ngoc.member.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eland.ngoc.common.OcOaConstants;
import com.eland.ngoc.common.model.MemberIds;
import com.eland.ngoc.common.model.Result;
import com.eland.ngoc.common.rules.ValidationRule;
import com.eland.ngoc.common.service.ProvisioningService;
import com.eland.ngoc.common.util.GlobalUtil;
import com.eland.ngoc.common.utils.CommonUtil;
import com.eland.ngoc.common.utils.StringUtil;
import com.eland.ngoc.exception.UserHandleException;
import com.eland.ngoc.member.dao.MemberDao;
import com.eland.ngoc.member.model.AutoLoginToken;
import com.eland.ngoc.member.model.CustInfo;
import com.eland.ngoc.member.model.MallCoreResult;
import com.eland.ngoc.member.model.Member;
import com.eland.ngoc.member.model.MemberChildInfos;
import com.eland.ngoc.member.model.MemberGet;
import com.eland.ngoc.member.model.MemberOut;
import com.eland.ngoc.member.model.MemberProvision;
import com.eland.ngoc.member.model.MemberUpdEims;
import com.eland.ngoc.member.model.MemberUpdOc;
import com.google.gson.Gson;

@Service
public class MemberServiceImpl implements MemberService {

	//logger 선언
	private final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);

	@Autowired
	private MemberDao memberRepository;

	@Autowired
	private ValidationRule validationRule;
	
	@Autowired
	private ProvisioningService provisioningSvc;
	
	/**
	 * <pre>
	 * 회원의 정보를 수정한다.
	 * use: EIMS CS
	 * 생성일 : 2016. 2. 1.
	 * </pre>
	 * 
	 * @param request 조회할 회원 정보의 조건이 담겨 있는 객체
	 * @param member 조회할 회원 정보의 조건이 담겨 있는 객체
	 * @return result 조회된 회원 정보가 담긴 모델 객체
	 * @exception UserHandleException
	 */
	@Override
	@Transactional(value = "primaryTransactionManager")
	public Result updateMemberInfo(HttpServletRequest request) {
		Result result = new Result();

		try {
			//Authorization check
			String clientId = validationRule.checkAuthorization(request.getHeader("Authorization"));
			
			//Site Code 가져오기(EIMS CS만 허용)
			String siteCode = CommonUtil.getSiteCode(clientId);
			if(!"50".equals(siteCode)) {
				throw new UserHandleException(OcOaConstants.INVALID_SITE_CODE, OcOaConstants.INVALID_SITE_CODE_MSG);
			}
	
			//request -> model
			String jsonParam = request.getParameter("custInfo");
			if (StringUtil.isEmpty(jsonParam)) {
				throw new UserHandleException(OcOaConstants.INVALID_CUST_INFO, OcOaConstants.INVALID_CUST_INFO_MSG);
			}
			
			MemberUpdOc memberOc = new MemberUpdOc();
			MemberUpdEims memberEims = new MemberUpdEims();
			Gson gson = new Gson();
			memberOc = gson.fromJson(jsonParam, MemberUpdOc.class);
			memberEims = gson.fromJson(jsonParam, MemberUpdEims.class);
	
			//parameter validation
			String webId = memberOc.getWebId();
			if (StringUtil.isEmpty(webId)) {
				throw new UserHandleException(OcOaConstants.INVALID_WEB_ID, OcOaConstants.INVALID_WEB_ID_MSG);
			}
			checkUpdMemberParamValue(memberOc);
	
			memberOc.setUpdateRoute(siteCode);
			memberOc.setUpdUser(clientId);
	
			memberEims.setUpdateRoute(siteCode);
	
			//고객조회용 ID values 추출(custId, webId)
			MemberIds memberIds = memberRepository.getCustInfoIds("", memberOc.getWebId());
			if (null == memberIds) {
				throw new UserHandleException(OcOaConstants.INVALID_WEB_ID, OcOaConstants.INVALID_WEB_ID_MSG);
			}
	
			memberOc.setCustId(memberIds.getCustId());
			if (StringUtil.isEmpty(memberOc.getCustId())) {
				throw new UserHandleException(OcOaConstants.INVALID_CUST_ID, OcOaConstants.INVALID_CUST_ID_MSG);
			}
			memberEims.setPbpId(memberIds.getPbpId());
			if (StringUtil.isEmpty(memberEims.getPbpId())) {
				throw new UserHandleException(OcOaConstants.INVALID_PBP_ID, OcOaConstants.INVALID_PBP_ID_MSG);
			}
			
			String custStat = memberIds.getCustStat();

			//EIMS 회원정보 수정 API call: EIMS 요청으로 삭제
			/*String eimsData = gson.toJson(memberEims);
			logger.debug("EIMS Data: " + eimsData);
			String eimsResult = GlobalUtil.makeHttpConnectionEims(OcOaConstants.UPDATE_MEMBER_INFO, eimsData);
			logger.debug("EIMS Result: " + eimsResult);
			if ("ERR".equals(eimsResult) || "EXP".equals(eimsResult)) {
				throw new UserHandleException(OcOaConstants.EIMS_API_PROCESS_ERROR, OcOaConstants.EIMS_API_PROCESS_ERROR_MSG);
			}
			Gson gsonEims = new Gson();
			result = gsonEims.fromJson(eimsResult, Result.class);*/

			//EIMS 처리결과가 성공이고 원클릭 고객상태가 탈퇴가 아닌 경우일 때만 원클릭 DB 및 provisioning 작업 진행
			//if (OcOaConstants.RESULT_SUCCESS.equals(result.getResultCode()) && !OcOaConstants.CUST_STAT_OUT.equals(custStat)) {
			//원클릭 고객상태가 탈퇴가 아닌 경우일 때만 원클릭 DB 및 provisioning 작업 진행
			if (!OcOaConstants.CUST_STAT_OUT.equals(custStat)) {
				//원클릭 고객정보 테이블 update
				int updCustInfo = memberRepository.updateMemberInfo(memberOc);
				if (updCustInfo <= 0) {
					logger.error("updateMemberInfo() -> updat OC_CUST_INFO Error: ", memberOc.getCustId());
					throw new UserHandleException(OcOaConstants.DATABASE_ACCESS_ERROR, OcOaConstants.DATABASE_ACCESS_ERROR_MSG);
				}
				
				//EIMS CS에서 오는 마케팅 동의 정보는 의미가 없으므로 주석처리
				/*if ("40".equals(siteCode)) {
					if (OcOaConstants.SITE_CODE_MALL.equals(memberOc.getUpdateRoute()) || OcOaConstants.SITE_CODE_CORE.equals(memberOc.getUpdateRoute())) {
						int updSiteInfo = memberRepository.updateMemberSiteInfo(memberOc);
						if (updSiteInfo <= 0) {
							logger.error("updateMemberInfo() -> updat OC_CUST_SITE_INFO Error: ", memberOc.getCustId());
							throw new UserHandleException(OcOaConstants.DATABASE_ACCESS_ERROR, OcOaConstants.DATABASE_ACCESS_ERROR_MSG);
						}
					}
				}*/
				
				//provisioning: EIMS 회원정보 조회 API 호출
				MemberProvision updProv = makeProvisionData(memberEims.getPbpId());
				if (null != updProv) {
					updProv.setCustId(memberOc.getCustId());
					updProv.setWebId(webId);
					
					provisioningSvc.publishedMsg("update", updProv);
					logger.debug("updateMemberInfo Provisioning");
				} else {
					throw new UserHandleException(OcOaConstants.PROVISIONING_ERROR, OcOaConstants.PROVISIONING_ERROR_MSG);
				}
			} else { //회원상태 오류
				throw new UserHandleException(OcOaConstants.INVALID_CUST_STAT, OcOaConstants.INVALID_CUST_STAT_MSG);
			}
		} catch(UserHandleException ue) {
			throw new UserHandleException(ue.getMessage(), ue.getMsgDesc());
		} catch(Exception e) {
			throw new UserHandleException(OcOaConstants.INTERNAL_SERVER_ERROR, OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}
		
		result.setResultCode(OcOaConstants.RESULT_SUCCESS);
		result.setErrorCode("");
		result.setErrorMsg("");

		return result;
	}

	/**
	 * <pre>
	 * 회원 정보를 조회한다.
	 * use: 통합몰, 통합홈페이지
	 * 생성일 : 2016. 2. 1.
	 * </pre>
	 * 
	 * @param request 조회할 회원 정보의 조건이 담겨 있는 객체
	 * @return member 조회된 회원 정보가 담긴 모델 객체
	 * @exception UserHandleException
	 */
	@Override
	public MemberGet getMemberInfo(HttpServletRequest request) {
		MemberGet ocResp = new MemberGet();

		try {
			//Authorization check
			String clientId = validationRule.checkAuthorization(request.getHeader("Authorization"));
			
			//site code check(통합몰, 통합홈페이지만 허용)
			String siteCode = CommonUtil.getSiteCode(clientId);
			if (!"10".equals(siteCode) && !"20".equals(siteCode)) {
				throw new UserHandleException(OcOaConstants.INVALID_SITE_CODE, OcOaConstants.INVALID_SITE_CODE_MSG);
			}
	
			//accessToken check
			MemberIds memberIds = new MemberIds();
			String token = request.getHeader("AccessToken");
			String custId = "";
			if (null != token && !"".equals(token)) {
				logger.debug("AccessToken: " + token);
				custId = validationRule.checkAccessToken(token);
				if (StringUtil.isEmpty(custId)) {
					throw new UserHandleException(OcOaConstants.INVALID_CUST_ID, OcOaConstants.INVALID_CUST_ID_MSG);
				}
				//고객조회용 ID values 추출(custId, webId)
				memberIds = memberRepository.getCustInfoIds(custId, "");
				if (null == memberIds) {
					throw new UserHandleException(OcOaConstants.INVALID_CUST_ID, OcOaConstants.INVALID_CUST_ID_MSG);
				}
			} else {
				//accessToken 없으면 webId check
				String webId = request.getParameter("webId");
				logger.debug("webId: " + webId);
				if (null != webId && !"".equals(webId)) {
					//고객조회용 ID values 추출(custId, webId)
					memberIds = memberRepository.getCustInfoIds("", webId);
					if (null == memberIds) {
						throw new UserHandleException(OcOaConstants.INVALID_WEB_ID, OcOaConstants.INVALID_WEB_ID_MSG);
					}
					custId = memberIds.getCustId();
					if (StringUtil.isEmpty(custId)) {
						throw new UserHandleException(OcOaConstants.INVALID_CUST_ID, OcOaConstants.INVALID_CUST_ID_MSG);
					}
				} else {
					throw new UserHandleException(OcOaConstants.INVALID_PARAMETER, OcOaConstants.INVALID_PARAMETER_MSG);
				}
			}
			logger.debug("CUST ID: " + custId);
	
			String eimsId = memberIds.getPbpId();
			if (StringUtil.isEmpty(eimsId)) {
				throw new UserHandleException(OcOaConstants.INVALID_PBP_ID, OcOaConstants.INVALID_PBP_ID_MSG);
			}

			//EIMS 회원정보 조회 API call
			Map<String, String> eimsParam = new HashMap<String, String>();
			eimsParam.put("eimsId", eimsId);
			eimsParam.put("idDiv", "P");
			String eimsResult = GlobalUtil.makeHttpConnectionEims(OcOaConstants.GET_MEMBER_INFO, CommonUtil.convertObjectToJson(eimsParam));
			logger.debug("EIMS Result: " + eimsResult);
			if ("ERR".equals(eimsResult) || "EXP".equals(eimsResult)) {
				throw new UserHandleException(OcOaConstants.EIMS_API_PROCESS_ERROR, OcOaConstants.EIMS_API_PROCESS_ERROR_MSG);
			}
            Gson gsonEims = new Gson();
			ocResp = gsonEims.fromJson(eimsResult, MemberGet.class);
			
			//EIMS 결과가 성공일 때만
			if (OcOaConstants.RESULT_SUCCESS.equals(ocResp.getResultCode())) {
				ocResp.setCustId(custId);
	
				//고객 정보 가져오기
				Map<String, String> custInfoMap = memberRepository.getMemberInfo(ocResp.getCustId());
				ocResp.setWebId(custInfoMap.get("WEBID"));
				ocResp.setWebPwdCDate(custInfoMap.get("WEBPWDCDATE"));
				ocResp.setLastLoginDate(custInfoMap.get("LASTLOGINDATE"));
				
				//해당 사이트의 마케팅 동의 여부 가져오기
				Map<String, String> siteInfoMap = memberRepository.getMemberSiteInfo(ocResp.getCustId(), siteCode);
				if (null == siteInfoMap) {
					throw new UserHandleException(OcOaConstants.NOT_JOIN_SITE_ACCESS_ERROR, OcOaConstants.NOT_JOIN_SITE_ACCESS_ERROR_MSG);
				} else {
					ocResp.setEmailYn(siteInfoMap.get("EMAILRCPTNYN"));
					ocResp.setSmsYn(siteInfoMap.get("SMSRCPTNYN"));
					ocResp.setDmYn(siteInfoMap.get("DMRCPTNYN"));
					ocResp.setOutYn(siteInfoMap.get("DELYN"));
				}
			}
		} catch(UserHandleException ue) {
			throw new UserHandleException(ue.getMessage(), ue.getMsgDesc());
		} catch(Exception e) {
			throw new UserHandleException(OcOaConstants.INTERNAL_SERVER_ERROR, OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}

		return ocResp;
	}

	/**
	 * <pre>
	 * 회원 상태를 변경한다.
	 * use: 원클릭 어드민, EIMS CS
	 * 생성일 : 2016. 2. 1.
	 * </pre>
	 * 
	 * @param request 조회할 회원 정보의 조건이 담겨 있는 객체
	 * @return member 조회된 회원 정보가 담긴 모델 객체
	 * @exception UserHandleException
	 */
	@Override
	@Transactional(value = "primaryTransactionManager")
	public Result updateMemberState(HttpServletRequest request) {
		Result result = new Result();
		
		try {
			//Authorization check
			String clientId = validationRule.checkAuthorization(request.getHeader("Authorization"));
	
			//site code check(원클릭 어드민, EIMS CS만 허용)
			String siteCode = CommonUtil.getSiteCode(clientId);
			if (!"40".equals(siteCode) && !"50".equals(siteCode)) {
				throw new UserHandleException(OcOaConstants.INVALID_SITE_CODE, OcOaConstants.INVALID_SITE_CODE_MSG);
			}

			//parameter validation
			validationRule.isValidParameter(request);
			
			String webId = request.getParameter("webId");
			String txDiv = request.getParameter("txDiv");
	
			//고객조회용 ID values 추출(custId, webId)
			MemberIds memberIds = memberRepository.getCustInfoIds("", webId);
			if (null == memberIds) {
				throw new UserHandleException(OcOaConstants.INVALID_WEB_ID, OcOaConstants.INVALID_WEB_ID_MSG);
			}

			String custId = memberIds.getCustId();
			if (StringUtil.isEmpty(custId)) {
				throw new UserHandleException(OcOaConstants.INVALID_CUST_ID, OcOaConstants.INVALID_CUST_ID_MSG);
			}
			String pbpId = memberIds.getPbpId();
			if (StringUtil.isEmpty(pbpId)) {
				throw new UserHandleException(OcOaConstants.INVALID_PBP_ID, OcOaConstants.INVALID_PBP_ID_MSG);
			}
			String custStat = memberIds.getCustStat();
	
			//EIMS 회원상태 변경 API call(계정잠금:LO, 잠금해제:UL, NP:무실적, RN:무실적해제 시에만 EIMS 호출) -> EIMS 요청으로 호출 삭제
			/*if ("LO".equals(txDiv) || "UL".equals(txDiv) || "NP".equals(txDiv) || "RN".equals(txDiv)) {
				Map<String, String> eimsParam = new HashMap<String, String>();
				eimsParam.put("pbpId", pbpId);
				eimsParam.put("siteCode", siteCode);
				eimsParam.put("txDiv", txDiv);
				String eimsResult = GlobalUtil.makeHttpConnectionEims(OcOaConstants.UPDATE_MEMBER_STATE, CommonUtil.convertObjectToJson(eimsParam));
				logger.debug("EIMS Result: " + eimsResult);
				if ("ERR".equals(eimsResult) || "EXP".equals(eimsResult)) {
					throw new UserHandleException(OcOaConstants.EIMS_API_PROCESS_ERROR, OcOaConstants.EIMS_API_PROCESS_ERROR_MSG);
				}
				Gson gsonEims = new Gson();
				result = gsonEims.fromJson(eimsResult, Result.class);
			} else {
				result.setResultCode(OcOaConstants.RESULT_SUCCESS);
				result.setErrorCode("");
				result.setErrorMsg("");
			}*/
			
			//원클릭 회원상태가 탈퇴가 아닐때만 계속 진행
			if (!OcOaConstants.CUST_STAT_OUT.equals(custStat)) {
				//휴면(RS)이거나 휴면해제(RR)이거나 EIMS 처리결과가 성공일 때만 원클릭 DB 및 provisioning 작업 진행
				/*if ( ("RS".equals(txDiv) || "RR".equals(txDiv)) ||
					 (("LO".equals(txDiv) || "UL".equals(txDiv) || "NP".equals(txDiv) || "RN".equals(txDiv)) && OcOaConstants.RESULT_SUCCESS.equals(result.getResultCode())) ) {*/
				//고객 상태 코드 설정
				String custState = "";
				switch(txDiv) {
					case "RS":	//휴면
						custState = OcOaConstants.CUST_STAT_REST;
						break;
					case "LO":	//게정잠금
						custState = OcOaConstants.CUST_STAT_LOCK;
						break;
					case "RR":	//휴면해제
					case "UL":	//잠금해제
					default:
						custState = OcOaConstants.CUST_STAT_NORMAL;
						break;
				}
				logger.debug("updateMemberState() -> custState: " + custState);
				
				//원클릭 cust_info 테이블 변경(RR,UL의 경우 임시비번여부, 비번변경일도 변경)
				Map<String, String> updParam = new HashMap<String, String>();
				updParam.put("custId", custId);
				updParam.put("custStat", custState);
				updParam.put("updUser", clientId);
				if ("NP".equals(txDiv)) {
					updParam.put("noPrchsYn", "Y");
				} else if ("RN".equals(txDiv)) {
					updParam.put("noPrchsYn", "N");
				} else {
					updParam.put("noPrchsYn", "");
				}
				
				//회원정보 테이블 회원상태 변경 처리
				int updCustInfo = memberRepository.updateMemberState(updParam);
				if (updCustInfo <= 0) {
					logger.error("updateMemberState() -> update OC_CUST_INFO Error: ", custId);
					throw new UserHandleException(OcOaConstants.DATABASE_ACCESS_ERROR, OcOaConstants.DATABASE_ACCESS_ERROR_MSG);
				}
				
				//휴면해제, 잠금해제로 인해 정상으로 복귀시 최종 로그인 일자 변경
				if ("RR".equals(txDiv) || "UL".equals(txDiv)) {
					int updLastLogin = memberRepository.updateOcCustLastLogin(custId, CommonUtil.getSiteCode(clientId));
					if (updLastLogin <= 0) {
						logger.error("updateMemberState() -> update OC_CUST_LAST_LOGIN Error: ", custId);
						throw new UserHandleException(OcOaConstants.DATABASE_ACCESS_ERROR, OcOaConstants.DATABASE_ACCESS_ERROR_MSG);
					}
				}
				
				//provisioning: 계정잠금(LO)시에만
				if ("LO".equals(txDiv)) {
					MemberProvision lockProv = new MemberProvision();
					lockProv.setCustId(custId);
					lockProv.setWebId(webId);
					SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ("yyyyMMdd", Locale.KOREA);
			        Date currentTime = new Date();
			        String mTime = mSimpleDateFormat.format(currentTime);
			        lockProv.setLockDate(mTime);
	
					provisioningSvc.publishedMsg("lock", lockProv);
					logger.debug("updateMemberState() Lock Provisioning");
				}
				//}
			} else { //회원상태 오류
				throw new UserHandleException(OcOaConstants.INVALID_CUST_STAT, OcOaConstants.INVALID_CUST_STAT_MSG);
			}
		} catch(UserHandleException ue) {
			throw new UserHandleException(ue.getMessage(), ue.getMsgDesc());
		} catch(Exception e) {
			throw new UserHandleException(OcOaConstants.INTERNAL_SERVER_ERROR, OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}
		
		result.setResultCode(OcOaConstants.RESULT_SUCCESS);
		result.setErrorCode("");
		result.setErrorMsg("");

		return result;
	}

	/**
	 * <pre>
	 * 회원 탈퇴를 처리한다.
	 * 온라인 회원은 무조건 전체 탈퇴로 처리한다.
	 * use: EIMS CS
	 * 생성일 : 2016. 2. 1.
	 * </pre>
	 * 
	 * @param request 조회할 회원 정보의 조건이 담겨 있는 객체
	 * @return Result 탈퇴처리 결과가 담긴 모델 객체
	 * @exception UserHandleException
	 */
	@Override
	@Transactional(value = "primaryTransactionManager")
	public Result membershipOut(HttpServletRequest request, MemberOut mbOut) {
		Result result = new Result();
		
		try {
			//Authorization check
			String clientId = validationRule.checkAuthorization(request.getHeader("Authorization"));
	
			//site code check(원클릭 어드민, EIMS CS만 허용)
			String siteCode = CommonUtil.getSiteCode(clientId);
			if (!"50".equals(siteCode)) {
				throw new UserHandleException(OcOaConstants.INVALID_SITE_CODE, OcOaConstants.INVALID_SITE_CODE_MSG);
			}

			//request validation check
			validationRule.checkParamModel(mbOut);
			validationRule.isValidParameter(request);
	
			logger.debug("Header:[" + clientId + "], Request:[" + mbOut.getWebId() + "|" + mbOut.getOutType() + "|" +
					mbOut.getOutDiv() + "|" + mbOut.getOutDesc() + "|" + mbOut.getOutReasons() + "]");

			//고객조회용 ID values 추출
			MemberIds memberIds = memberRepository.getCustInfoIds("", mbOut.getWebId());
			if (null == memberIds) {
				throw new UserHandleException(OcOaConstants.INVALID_WEB_ID, OcOaConstants.INVALID_WEB_ID_MSG);
			}
	
			mbOut.setCustId(memberIds.getCustId());
			if (StringUtil.isEmpty(mbOut.getCustId())) {
				throw new UserHandleException(OcOaConstants.INVALID_CUST_ID, OcOaConstants.INVALID_CUST_ID_MSG);
			}
			mbOut.setPbpId(memberIds.getPbpId());
			if (StringUtil.isEmpty(mbOut.getPbpId())) {
				throw new UserHandleException(OcOaConstants.INVALID_PBP_ID, OcOaConstants.INVALID_PBP_ID_MSG);
			}
			String custStat = memberIds.getCustStat();
			
			//원클릭 회원정보상태가 탈퇴가 아닐때만 처리
			if (!OcOaConstants.CUST_STAT_OUT.equals(custStat)) {
				//통합몰 탈퇴가능여부 조회 api call
				String mallResult = GlobalUtil.elandMallMemberOutAllowYn(mbOut.getWebId());
				logger.debug("ELAND MALL Result: " + mallResult);
				Gson gsonMall = new Gson();
				MallCoreResult mallResp = gsonMall.fromJson(mallResult, MallCoreResult.class);
				if (OcOaConstants.RESULT_FAIL.equals(mallResp.getResultCode())) {
					if ("N".equals(mallResp.getOutPossibleYn())) {
						throw new UserHandleException(mallResp.getErrorCode(), mallResp.getOutImpossibleReason());
					}
				}

				//통합홈페이지 탈퇴가능여부 조회 api call
				Map<String, String> ecoreParam = new HashMap<String, String>();
				ecoreParam.put("webId", mbOut.getWebId());
				String ecoreResult = GlobalUtil.ecoreMemberOutAllowYn(CommonUtil.convertObjectToJson(ecoreParam));
				logger.debug("ECORE Result: " + ecoreResult);
				Gson gsonEcore = new Gson();
				MallCoreResult ecoreResp = gsonEcore.fromJson(ecoreResult, MallCoreResult.class);
				if (OcOaConstants.RESULT_FAIL.equals(ecoreResp.getResultCode())) {
					throw new UserHandleException(OcOaConstants.ECORE_API_PROCESS_ERROR, OcOaConstants.ECORE_API_PROCESS_ERROR_MSG);
				} else {
					if ("N".equals(ecoreResp.getOutPossibleYn())) {
						switch(ecoreResp.getOutImpossibleReason()) {
							case "001":
								throw new UserHandleException(ecoreResp.getErrorCode(), "문화센터 강좌 수강중");
							case "002":
								throw new UserHandleException(ecoreResp.getErrorCode(), "소극장 연회원");
							default:
								throw new UserHandleException(ecoreResp.getErrorCode(), "정의되지 않은 사유");
						}
					}
				}
			}
			
			//EIMS API call
			Map<String, String> eimsParam = new HashMap<String, String>();
			eimsParam.put("pbpId", mbOut.getPbpId());
			eimsParam.put("siteCode", siteCode);
			eimsParam.put("outType", mbOut.getOutType());
			eimsParam.put("outDiv", mbOut.getOutDiv());
			eimsParam.put("outDesc", mbOut.getOutDesc());
			eimsParam.put("empId", mbOut.getEmpId());
			String eimsResult = GlobalUtil.makeHttpConnectionEims(OcOaConstants.MEMBER_OUT, CommonUtil.convertObjectToJson(eimsParam));
			logger.debug("EIMS Result: " + eimsResult);
			if ("ERR".equals(eimsResult) || "EXP".equals(eimsResult)) {
				throw new UserHandleException(OcOaConstants.EIMS_API_PROCESS_ERROR, OcOaConstants.EIMS_API_PROCESS_ERROR_MSG);
			}
			Gson gsonEims = new Gson();
			result = gsonEims.fromJson(eimsResult, Result.class);

			//EIMS 처리결과가 성공이고 원클릭 회원상태가 탈퇴가 아닐 때만 원클릭 DB 및 provisioning 작업 진행
			if (OcOaConstants.RESULT_SUCCESS.equals(result.getResultCode()) && !OcOaConstants.CUST_STAT_OUT.equals(custStat)) {
				//원클릭 DB에는 탈퇴 구분을 모두 EIMS CS 탈퇴로 처리
				mbOut.setOutDiv("40");

				//고객이 가입한 전체 사이트 코드 가져오기
				List<String> siteCodeList = memberRepository.getCustSiteInfoList(mbOut.getCustId());
				logger.debug("SiteCodeList: " + siteCodeList.size());
				if (null != siteCodeList && siteCodeList.size() > 0) {
					//탈퇴 요청 User 설정
					mbOut.setInsUser(clientId);
		
					for (String siteId : siteCodeList) {
						//사이트 코드 설정
						mbOut.setSiteCode(siteId);
						//탈퇴 순번 설정
						int outOrderNo = memberRepository.getMaxOutOrderNo(mbOut);
						mbOut.setOutSeq(outOrderNo + 1);
		
						//탈퇴 정보 입력
						int insOutDtls = memberRepository.insertOcCustOutDtls(mbOut);
						if (insOutDtls <= 0) {
							logger.error("membershipOut() -> insert OC_CUST_OUT_DTLS Error: ", mbOut.getCustId());
							throw new UserHandleException(OcOaConstants.DATABASE_ACCESS_ERROR, OcOaConstants.DATABASE_ACCESS_ERROR_MSG);
						}
						
						//탈퇴 사유 입력
						if (null != mbOut.getOutReasons() && mbOut.getOutReasons().length() > 0) {
							String[] outReason = mbOut.getOutReasons().split(":");
							logger.debug("Out Reason: " + outReason.length);
							if (null != outReason && outReason.length > 0) {
								Map<String, Object> insParam = new HashMap<String, Object>();
								insParam.put("custId", mbOut.getCustId());
								insParam.put("siteCode", mbOut.getSiteCode());
								insParam.put("outSeq", mbOut.getOutSeq());
								for (int i=0; i<outReason.length; i++) {
									logger.debug("Out Reason: " + outReason[i]);
									insParam.put("outRsonCode", outReason[i]);
									int insOutRson = memberRepository.insertOcCustOutRson(insParam);
									if (insOutRson <= 0) {
										logger.error("membershipOut() -> insert OC_CUST_OUT_RSON Error: ", mbOut.getCustId());
										throw new UserHandleException(OcOaConstants.DATABASE_ACCESS_ERROR, OcOaConstants.DATABASE_ACCESS_ERROR_MSG);
									}
								}
							}
						}
					}
	
					//회원 사이트 정보 탈퇴 처리
					Map<String, String> updParam1 = new HashMap<String, String>();
					updParam1.put("custId", mbOut.getCustId());
					updParam1.put("delYn", "Y");
					updParam1.put("updUser", clientId);
					int updSiteInfo = memberRepository.updateOcCustSiteInfo(updParam1);
					if (updSiteInfo <= 0) {
						logger.error("membershipOut() -> update OC_CUST_SITE_INFO Error: ", mbOut.getCustId());
						throw new UserHandleException(OcOaConstants.DATABASE_ACCESS_ERROR, OcOaConstants.DATABASE_ACCESS_ERROR_MSG);
					}
					
					//회원정보 탈퇴 처리: 탈퇴(50)
					Map<String, String> updParam2 = new HashMap<String, String>();
					updParam2.put("custId", mbOut.getCustId());
					updParam2.put("custStat", OcOaConstants.CUST_STAT_OUT);
					updParam2.put("updUser", clientId);
					int updCustInfo = memberRepository.updateMemberState(updParam2);
					if (updCustInfo <= 0) {
						logger.error("membershipOut() -> update OC_CUST_INFO Error: ", mbOut.getCustId());
						throw new UserHandleException(OcOaConstants.DATABASE_ACCESS_ERROR, OcOaConstants.DATABASE_ACCESS_ERROR_MSG);
					}
				}
				
				//provisioning
				MemberProvision outProv = new MemberProvision();
				outProv.setCustId(mbOut.getCustId());
				outProv.setWebId(mbOut.getWebId());
				outProv.setMallOutYn("Y");
				outProv.setRetailOutYn("Y");
				SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ("yyyyMMdd", Locale.KOREA);
		        Date currentTime = new Date();
		        String mTime = mSimpleDateFormat.format(currentTime);
				outProv.setOutDate(mTime);

				provisioningSvc.publishedMsg("out", outProv);
				logger.debug("memberOut Provisioning");
			}
		} catch(UserHandleException ue) {
			throw new UserHandleException(ue.getMessage(), ue.getMsgDesc());
		} catch(Exception e) {
			throw new UserHandleException(OcOaConstants.INTERNAL_SERVER_ERROR, OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}
		
		return result;
	}
	
	/**
	 * <pre>
	 * 회원 탈퇴 취소를 처리한다.
	 * 온라인 회원은 무조건 전체 탈퇴 취소하고 EIMS 탈퇴 취소는 API로 넘긴다.
	 * 회원탈퇴는 온라인 탈퇴 후 30일 이내에만 가능
	 * use: 원클릭 어드민, EIMS CS
	 * 생성일 : 2016. 2. 1.
	 * </pre>
	 * 
	 * @param request 조회할 회원 정보의 조건이 담겨 있는 객체
	 * @return Result 탈퇴처리 결과가 담긴 모델 객체
	 * @exception UserHandleException
	 */
	@Override
	@Transactional(value = "primaryTransactionManager")
	public Result cancelMemberOut(HttpServletRequest request) {
		Result result = new Result();

		try {
			//Authorization check
			String clientId = validationRule.checkAuthorization(request.getHeader("Authorization"));
	
			//site code check(원클릭 어드민, EIMS CS만 허용)
			String siteCode = CommonUtil.getSiteCode(clientId);
			if (!"40".equals(siteCode) && !"50".equals(siteCode)) {
				throw new UserHandleException(OcOaConstants.INVALID_SITE_CODE, OcOaConstants.INVALID_SITE_CODE_MSG);
			}

			String webId = request.getParameter("webId");
			if (StringUtil.isEmpty(webId)) {
				throw new UserHandleException(OcOaConstants.INVALID_WEB_ID, OcOaConstants.INVALID_WEB_ID_MSG);
			}
	
			logger.debug("Header:[" + clientId + "], Request:[" + webId + "]");
	
			//고객조회용 ID values 추출(custId, webId)
			MemberIds memberIds = memberRepository.getCustInfoIds("", webId);
			if (null == memberIds) {
				throw new UserHandleException(OcOaConstants.INVALID_WEB_ID, OcOaConstants.INVALID_WEB_ID_MSG);
			}
			
			String custId = memberIds.getCustId();
			if (StringUtil.isEmpty(custId)) {
				throw new UserHandleException(OcOaConstants.INVALID_CUST_ID, OcOaConstants.INVALID_CUST_ID_MSG);
			}
			String pbpId = memberIds.getPbpId();
			if (StringUtil.isEmpty(pbpId)) {
				throw new UserHandleException(OcOaConstants.INVALID_PBP_ID, OcOaConstants.INVALID_PBP_ID_MSG);
			}
			String custStat = memberIds.getCustStat();
			
			//EIMS API call
			Map<String, String> eimsParam = new HashMap<String, String>();
			eimsParam.put("pbpId", pbpId);
			eimsParam.put("siteCode", siteCode);
			eimsParam.put("webId", webId);
			String eimsResult = GlobalUtil.makeHttpConnectionEims(OcOaConstants.CANCEL_MEMBER_OUT, CommonUtil.convertObjectToJson(eimsParam));
			logger.debug("EIMS Result: " + eimsResult);
			if ("ERR".equals(eimsResult) || "EXP".equals(eimsResult)) {
				throw new UserHandleException(OcOaConstants.EIMS_API_PROCESS_ERROR, OcOaConstants.EIMS_API_PROCESS_ERROR_MSG);
			}
			Gson gsonEims = new Gson();
			result = gsonEims.fromJson(eimsResult, Result.class);

			//EIMS 처리결과가 성공이고 원클릭 회원상태가 탈퇴일 때만 원클릭 DB 작업 진행
			if (OcOaConstants.RESULT_SUCCESS.equals(result.getResultCode())) {
				if (OcOaConstants.CUST_STAT_OUT.equals(custStat)) {
					//원클릭 회원탈퇴 후 30일 이후이면 탈퇴취소 불가
					if ("N".equals(memberRepository.getCustOutCancelCanYn(custId))) {
						throw new UserHandleException(OcOaConstants.CANNOT_CANCEL_OVER_30_DAYS, OcOaConstants.CANNOT_CANCEL_OVER_30_DAYS_MSG);
					}
	
					//회원정보의 회원상태 탈퇴취소 처리: 정상(10)
					Map<String, String> updParam1 = new HashMap<String, String>();
					updParam1.put("custId", custId);
					updParam1.put("custStat", OcOaConstants.CUST_STAT_NORMAL);
					updParam1.put("updUser", clientId);
					int updCustInfo = memberRepository.updateMemberState(updParam1);
					if (updCustInfo <= 0) {
						logger.error("cancelMemberOut() -> update OC_CUST_INFO Error: ", custId);
						throw new UserHandleException(OcOaConstants.DATABASE_ACCESS_ERROR, OcOaConstants.DATABASE_ACCESS_ERROR_MSG);
					}
			
					//최종 로그인 일자 변경
					int updLastLogin = memberRepository.updateOcCustLastLogin(custId, siteCode);
					if (updLastLogin <= 0) {
						logger.error("cancelMemberOut() -> update OC_CUST_LAST_LOGIN Error: ", custId);
						throw new UserHandleException(OcOaConstants.DATABASE_ACCESS_ERROR, OcOaConstants.DATABASE_ACCESS_ERROR_MSG);
					}
					
					//고객이 가입된 전체 사이트 코드 탈퇴 취소 처리
					Map<String, String> updParam2 = new HashMap<String, String>();
					updParam2.put("custId", custId);
					updParam2.put("delYn", "N");
					updParam2.put("updUser", clientId);
					int updSiteInfo = memberRepository.updateOcCustSiteInfo(updParam2);
					if (updSiteInfo <= 0) {
						logger.error("cancelMemberOut() -> update OC_CUST_SITE_INFO Error: ", custId);
						throw new UserHandleException(OcOaConstants.DATABASE_ACCESS_ERROR, OcOaConstants.DATABASE_ACCESS_ERROR_MSG);
					}
				} else { //회원상태 오류
					throw new UserHandleException(OcOaConstants.INVALID_CUST_STAT, OcOaConstants.INVALID_CUST_STAT_MSG);
				}
			}
		} catch(UserHandleException ue) {
			throw new UserHandleException(ue.getMessage(), ue.getMsgDesc());
		} catch(Exception e) {
			throw new UserHandleException(OcOaConstants.INTERNAL_SERVER_ERROR, OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}

		return result;
	}

	/**
	 * provisioning 을 위한 데이터 생성
	 * EIMS 회원정보 조회 API call
	 * @param pbpId
	 * @return MemberProvision
	 */
	private MemberProvision makeProvisionData(String pbpId) {
		MemberProvision provision = new MemberProvision();
		try {
			Map<String, String> getEims = new HashMap<String, String>();
			getEims.put("eimsId", pbpId);
			getEims.put("idDiv", "P");
			String getResult = GlobalUtil.makeHttpConnectionEims(OcOaConstants.GET_MEMBER_INFO, CommonUtil.convertObjectToJson(getEims));
			logger.debug("EIMS Result: " + getResult);
			if ("ERR".equals(getResult) || "EXP".equals(getResult)) {
				throw new UserHandleException(OcOaConstants.EIMS_API_PROCESS_ERROR, OcOaConstants.EIMS_API_PROCESS_ERROR_MSG);
			}
	
	        String resultCd = "";
			try {
				JSONParser jsonParser = new JSONParser();
		        //JSON string 데이터를 넣어 JSON Object 로 만들어 준다.
		        JSONObject jsonObject = null;
				jsonObject = (JSONObject) jsonParser.parse(getResult);
				resultCd = (String) jsonObject.get("resultCode");
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        logger.debug("makeProvisionData -> Result Code: " + resultCd);
			
	        //EIMS 처리결과가 성공일 때만 provisioning 작업 진행
	        if (OcOaConstants.RESULT_SUCCESS.equals(resultCd)) {
				Gson gson = new Gson();
				provision = gson.fromJson(getResult, MemberProvision.class);
				provision.setBirthUnar(provision.getBirthdayType());
	        } else {
				provision = null;
			}
		} catch(UserHandleException ue) {
			provision = null;
			throw new UserHandleException(ue.getMessage(), ue.getMsgDesc());
		} catch(Exception e) {
			provision = null;
			e.printStackTrace();
		}

		return provision;
	}
	
	private void checkUpdMemberParamValue(MemberUpdOc umOc) {
		if (null != umOc.getGender() && !"".equals(umOc.getGender())) {
			if (!"M".equals(umOc.getGender()) && !"F".equals(umOc.getGender())) {
				throw new UserHandleException(OcOaConstants.INVALID_CUST_GENDER, OcOaConstants.INVALID_CUST_GENDER_MSG);
			}
		}
		if (null != umOc.getBirthdayType() && !"".equals(umOc.getBirthdayType())) {
			if (!"S".equals(umOc.getBirthdayType()) && !"L".equals(umOc.getBirthdayType())) {
				throw new UserHandleException(OcOaConstants.INVALID_BIRTHDAY_TYPE, OcOaConstants.INVALID_BIRTHDAY_TYPE_MSG);
			}
		}
		if (null != umOc.getAddrDiv() && !"".equals(umOc.getAddrDiv())) {
			if (!"1".equals(umOc.getAddrDiv()) && !"2".equals(umOc.getAddrDiv()) && !"3".equals(umOc.getAddrDiv()) && !"4".equals(umOc.getAddrDiv())) {
				throw new UserHandleException(OcOaConstants.INVALID_ADDR_DIV, OcOaConstants.INVALID_ADDR_DIV_MSG);
			}
		}
		if (null != umOc.getChildren() && !"".equals(umOc.getChildren())) {
			for (MemberChildInfos child : umOc.getChildren()) {
				if (null != child.getChildGender() && !"".equals(child.getChildGender())) {
					if (!"M".equals(child.getChildGender()) && !"F".equals(child.getChildGender())) {
						throw new UserHandleException(OcOaConstants.INVALID_CHILD_GENDER, OcOaConstants.INVALID_CHILD_GENDER_MSG);
					}
				}
				if (null != child.getChildUnar() && !"".equals(child.getChildUnar())) {
					if (!"S".equals(child.getChildUnar()) && !"L".equals(child.getChildUnar())) {
						throw new UserHandleException(OcOaConstants.INVALID_CHILD_UNAR, OcOaConstants.INVALID_CHILD_UNAR_MSG);
					}
				}
			}
		}
	}
	
	@Override
	@Transactional(value = "primaryTransactionManager")
	public Map<String, String> autoLogin(String aLoginUid, String loginToken) {
		Map<String, String> returnMap = new HashMap<String, String>();
		
		// 자동 로그인 토큰 조회
		AutoLoginToken token =  memberRepository.selectAutoLoginToken(aLoginUid, "");
		String newLoginToken = "";
		
		if (token == null) {
			throw new UserHandleException(OcOaConstants.INVALID_AUTO_LOGIN_UID, OcOaConstants.INVALID_AUTO_LOGIN_UID_MSG);
		} else {
			// 로그인 토큰이 같으면 토큰 갱신 
			if (loginToken.equals(token.getLoginToken())) {
				// 로그인 토큰 신규 생성하여 인서트
				newLoginToken = CommonUtil.createLoginToken();
				AutoLoginToken autoLoginToken = new AutoLoginToken();
				autoLoginToken.setWebId(token.getWebId());
				autoLoginToken.setAlUid(aLoginUid);
				autoLoginToken.setLoginToken(newLoginToken);
				
				memberRepository.updateAutoLoginToken(autoLoginToken);

				Member member = memberRepository.getMemberInfoByWebId(token.getWebId());
				
				returnMap.put("newLoginToken", newLoginToken);
				returnMap.put("custId", member.getCustId());
			} 
			// 토큰이 다르면 정보가 유출된것으로 판단 기존 UID 삭제(WEB_ID 기준으로 전체 삭제)
			else {
				throw new UserHandleException(OcOaConstants.INVALID_AUTO_LOGIN_TOKEN, token.getWebId(), OcOaConstants.INVALID_AUTO_LOGIN_TOKEN_MSG);
			}
		}
		
		return returnMap;
	}
	
	@Override
	public String selectCustStateInfo(String custId, String siteCode) {
		String membState = "";
		CustInfo custInfo = memberRepository.selectCustStateInfo(custId, siteCode);
		
		if (custInfo != null) {
			
			if ("10".equals(custInfo.getMembState())) {
				// 임시 비밀 번호 사용여부 체크
				membState = custInfo.getMembState();
				if ("Y".equals(custInfo.getTempPwdYn())) {
					membState = "70";
				}
				// 장기 비밀번호 미변경
				if ("Y".equals(custInfo.getLongTermPwdYn())) {
					membState = "60";
				}
			} else {
				membState = custInfo.getMembState();
			}
		}
		
		return membState;
	}
	
	@Override
	@Transactional(value = "primaryTransactionManager")
	public void saveLastLoginHistory(String custId, String siteCode) {
		
		int count = memberRepository.selectLastLoginHistory(custId);
		
		if (count > 0) {
			memberRepository.updateLastLoginHistory(custId, siteCode);
		} else {
			memberRepository.insertLastLoginHistory(custId, siteCode);
		}
	}
	
	@Override
	@Transactional(value = "primaryTransactionManager")
	public void deleteAutoLoginToken(String webId) {
		memberRepository.deleteAutoLoginToken(webId);
	}
}
