package com.eland.ngoc.point.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eland.ngoc.common.OcOaConstants;
import com.eland.ngoc.common.model.MemberIds;
import com.eland.ngoc.common.model.Result;
import com.eland.ngoc.common.rules.ValidationRule;
import com.eland.ngoc.common.util.GlobalUtil;
import com.eland.ngoc.common.utils.CommonUtil;
import com.eland.ngoc.common.utils.DateUtil;
import com.eland.ngoc.common.utils.StringUtil;
import com.eland.ngoc.exception.UserHandleException;
import com.eland.ngoc.point.dao.CustPointDao;
import com.eland.ngoc.point.model.CustPointInfo;
import com.eland.ngoc.point.model.CustPointInfoRsp;
import com.eland.ngoc.point.model.CustPointSave;
import com.eland.ngoc.point.model.CustPointUse;
import com.google.gson.Gson;

@Service
public class CustPointServiceImpl implements CustPointService {
	// logger 선언
	private final Logger logger = LoggerFactory.getLogger(CustPointServiceImpl.class);

	@Autowired
	private CustPointDao pointRepository;
	
	@Autowired
	private ValidationRule validationRule;

	/**
	 * <pre>
	 * 회원의 포인트 정보 조회
	 * use: 통합몰, 통합홈페이지
	 * 생성일 : 2016. 2. 3
	 * </pre>
	 * @param request 포인트 조회 기간
	 * @return result CustPointInfoRsp
	 * @exception UserHandleException
	 */
	@Override
	public CustPointInfoRsp getCustPointList(HttpServletRequest request, CustPointInfo cpointInfo) {
		CustPointInfoRsp cpointRsp = new CustPointInfoRsp();

		try {
			//request validation check
			String clientId = validationRule.checkAuthorization(request.getHeader("Authorization"));
	
			//parameter validation check
			validationRule.checkParamModel(cpointInfo);
			
			String webId = cpointInfo.getWebId();
			String startDate = cpointInfo.getStartDate();
			String endDate = cpointInfo.getEndDate();
			logger.debug("Header:[" + clientId + "], Request:[" + webId + "|" + startDate + "|" + endDate + "]");
	
			//조회날짜 check
			int diffMonths = DateUtil.getDiffMonths(startDate, endDate);
			if(diffMonths < 0 || diffMonths > 3) {
				throw new UserHandleException(OcOaConstants.INVALID_SEARCH_PERIOD, OcOaConstants.INVALID_SEARCH_PERIOD_MSG);
			}
	
			//site code 설정(통합몰, 통합홈페이지만 허용)
			String siteCode = CommonUtil.getSiteCode(clientId);
			if(!"10".equals(siteCode) && !"20".equals(siteCode)) {
				throw new UserHandleException(OcOaConstants.INVALID_SITE_CODE, OcOaConstants.INVALID_SITE_CODE_MSG);
			}
	
			//고객조회용 종류별 ID 값들 추출(custId, webId)
			MemberIds memberIds = pointRepository.getCustInfoIds("", webId);
			if (null == memberIds) {
				throw new UserHandleException(OcOaConstants.INVALID_WEB_ID, OcOaConstants.INVALID_WEB_ID_MSG);
			}
			logger.debug("custID: " + memberIds.getCustId() + ", pbpID: " + memberIds.getPbpId());
			
			String pbpId = memberIds.getPbpId();
			if (StringUtil.isEmpty(pbpId)) {
				throw new UserHandleException(OcOaConstants.INVALID_PBP_ID, OcOaConstants.INVALID_PBP_ID_MSG);
			}
			//EIMS 포인트 조회 API call
			Map<String, String> eimsParam = new HashMap<String, String>();
			eimsParam.put("pbpId", pbpId);
			eimsParam.put("siteCode", siteCode);
			eimsParam.put("startDate", cpointInfo.getStartDate());
			eimsParam.put("endDate", cpointInfo.getEndDate());
			String eimsResult = GlobalUtil.makeHttpConnectionEims(OcOaConstants.GET_POINT_INFO, CommonUtil.convertObjectToJson(eimsParam));
			logger.debug("EIMS Result: " + eimsResult);
			if ("ERR".equals(eimsResult) || "EXP".equals(eimsResult)) {
				throw new UserHandleException(OcOaConstants.EIMS_API_PROCESS_ERROR, OcOaConstants.EIMS_API_PROCESS_ERROR_MSG);
			}
			Gson gsonEims = new Gson();
			cpointRsp = gsonEims.fromJson(eimsResult, CustPointInfoRsp.class);
		} catch(UserHandleException ue) {
			throw new UserHandleException(ue.getMessage(), ue.getMsgDesc());
		} catch(Exception e) {
			throw new UserHandleException(OcOaConstants.INTERNAL_SERVER_ERROR, OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}

		return cpointRsp;
	}
	
	/**
	 * <pre>
	 * 회원의 포인트 적립/취소 처리
	 * use: 통합몰, 통합홈페이지
	 * 생성일 : 2016. 2. 3
	 * </pre>
	 * @param request 포인트 조회 기간
	 * @return result CustPointInfoRsp
	 * @exception UserHandleException
	 */
	@Override
	public Result addOrCancelCustPoint(HttpServletRequest request, CustPointSave cpointSave) {
		Result pointRsp = new Result();
		
		try {
			//Authorization check
			String clientId = validationRule.checkAuthorization(request.getHeader("Authorization"));
	
			//request validation check
			validationRule.checkParamModel(cpointSave);
			validationRule.isValidParameter(request);
	
			String webId = cpointSave.getWebId();
			String cancelYn = cpointSave.getCancelYn();
			int pointValue = Integer.parseInt(cpointSave.getAddPoint());
			logger.debug("Header:[" + clientId + "], Request:[" + webId + "|" + cpointSave.getBranchCode() +
					"|" + cancelYn + "|" + cpointSave.getPointType() + "|" + pointValue + "|" + cpointSave.getAddDesc() + "]");
	
			// add or cancel flag check
			if("N".equals(cancelYn) && pointValue < 0) {
				throw new UserHandleException(OcOaConstants.INVALID_CANCEL_YN, OcOaConstants.INVALID_CANCEL_YN_MSG);
			}
			if("Y".equals(cancelYn) && pointValue > 0) {
				throw new UserHandleException(OcOaConstants.INVALID_CANCEL_YN, OcOaConstants.INVALID_CANCEL_YN_MSG);
			}
	
			//site code 설정(통합몰, 통합홈페이지만 허용)
			String siteCode = CommonUtil.getSiteCode(clientId);
			if(!"10".equals(siteCode) && !"20".equals(siteCode)) {
				throw new UserHandleException(OcOaConstants.INVALID_SITE_CODE, OcOaConstants.INVALID_SITE_CODE_MSG);
			}
	
			//고객조회용 종류별 ID 값들 추출(custId, webId)
			MemberIds memberIds = pointRepository.getCustInfoIds("", webId);
			if (null == memberIds) {
				throw new UserHandleException(OcOaConstants.INVALID_WEB_ID, OcOaConstants.INVALID_WEB_ID_MSG);
			}
			
			String pbpId = memberIds.getPbpId();
			if (StringUtil.isEmpty(pbpId)) {
				throw new UserHandleException(OcOaConstants.INVALID_PBP_ID, OcOaConstants.INVALID_PBP_ID_MSG);
			}

			//EIMS 포인트 사용 API call
			Map<String, String> eimsParam = new HashMap<String, String>();
			eimsParam.put("pbpId", pbpId);
			eimsParam.put("siteCode", siteCode);
			eimsParam.put("branchCode", cpointSave.getBranchCode());
			eimsParam.put("cancelYn", cpointSave.getCancelYn());
			eimsParam.put("pointType", cpointSave.getPointType());
			eimsParam.put("addPoint", cpointSave.getAddPoint());
			eimsParam.put("addDesc", cpointSave.getAddDesc());
			String eimsResult = GlobalUtil.makeHttpConnectionEims(OcOaConstants.ADD_POINT, CommonUtil.convertObjectToJson(eimsParam));
			logger.debug("EIMS Result: " + eimsResult);
			if ("ERR".equals(eimsResult) || "EXP".equals(eimsResult)) {
				throw new UserHandleException(OcOaConstants.EIMS_API_PROCESS_ERROR, OcOaConstants.EIMS_API_PROCESS_ERROR_MSG);
			}
			Gson gson = new Gson();
			pointRsp = gson.fromJson(eimsResult, Result.class);
		} catch(UserHandleException ue) {
			throw new UserHandleException(ue.getMessage(), ue.getMsgDesc());
		} catch(Exception e) {
			throw new UserHandleException(OcOaConstants.INTERNAL_SERVER_ERROR, OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}

		return pointRsp;
	}
	
	/**
	 * <pre>
	 * 회원의 포인트 사용/취소 처리
	 * use: 통합몰, 통합홈페이지
	 * 생성일 : 2016. 2. 3
	 * </pre>
	 * @param request 포인트 조회 기간
	 * @return result CustPointInfoRsp
	 * @exception UserHandleException
	 */
	@Override
	public Result useOrCancelCustPoint(HttpServletRequest request, CustPointUse cpointUse) {
		Result pointRsp = new Result();

		try {
			//Authorization check
			String clientId = validationRule.checkAuthorization(request.getHeader("Authorization"));
	
			//request validation check
			validationRule.checkParamModel(cpointUse);
			validationRule.isValidParameter(request);
	
			String webId = cpointUse.getWebId();
			String cancelYn = cpointUse.getCancelYn();
			int pointValue = Integer.parseInt(cpointUse.getUsePoint());
			logger.debug("Header:[" + clientId + "], Request:[" + webId + "|" + cpointUse.getBranchCode() +
					"|" + cancelYn + "|" + cpointUse.getPointType() + "|" + pointValue + "|" + cpointUse.getUseDesc() + "]");
	
			//use or cancel flag check
			if("N".equals(cancelYn) && pointValue < 0) {
				throw new UserHandleException(OcOaConstants.INVALID_CANCEL_YN, OcOaConstants.INVALID_CANCEL_YN_MSG);
			}
			if("Y".equals(cancelYn) && pointValue > 0) {
				throw new UserHandleException(OcOaConstants.INVALID_CANCEL_YN, OcOaConstants.INVALID_CANCEL_YN_MSG);
			}
	
			// site code 설정(통합몰, 통합홈페이지만 허용)
			String siteCode = CommonUtil.getSiteCode(clientId);
			if(!"10".equals(siteCode) && !"20".equals(siteCode)) {
				throw new UserHandleException(OcOaConstants.INVALID_SITE_CODE, OcOaConstants.INVALID_SITE_CODE_MSG);
			}
	
			//고객조회용 종류별 ID 값들 추출(custId, webId)
			MemberIds memberIds = pointRepository.getCustInfoIds("", webId);
			if (null == memberIds) {
				throw new UserHandleException(OcOaConstants.INVALID_WEB_ID, OcOaConstants.INVALID_WEB_ID_MSG);
			}
			
			String pbpId = memberIds.getPbpId();
			if (StringUtil.isEmpty(pbpId)) {
				throw new UserHandleException(OcOaConstants.INVALID_PBP_ID, OcOaConstants.INVALID_PBP_ID_MSG);
			}
	
			//EIMS 포인트 사용 API call
			Map<String, String> eimsParam = new HashMap<String, String>();
			eimsParam.put("pbpId", pbpId);
			eimsParam.put("siteCode", siteCode);
			eimsParam.put("branchCode", cpointUse.getBranchCode());
			eimsParam.put("cancelYn", cpointUse.getCancelYn());
			eimsParam.put("pointType", cpointUse.getPointType());
			eimsParam.put("usePoint", cpointUse.getUsePoint());
			eimsParam.put("useDesc", cpointUse.getUseDesc());
			String eimsResult = GlobalUtil.makeHttpConnectionEims(OcOaConstants.USE_POINT, CommonUtil.convertObjectToJson(eimsParam));
			logger.debug("EIMS Result: " + eimsResult);
			if ("ERR".equals(eimsResult) || "EXP".equals(eimsResult)) {
				throw new UserHandleException(OcOaConstants.EIMS_API_PROCESS_ERROR, OcOaConstants.EIMS_API_PROCESS_ERROR_MSG);
			}
			Gson gson = new Gson();
			pointRsp = gson.fromJson(eimsResult, Result.class);
		}  catch(UserHandleException ue) {
			throw new UserHandleException(ue.getMessage(), ue.getMsgDesc());
		} catch(Exception e) {
			throw new UserHandleException(OcOaConstants.INTERNAL_SERVER_ERROR, OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}
		
		return pointRsp;
	}
}
