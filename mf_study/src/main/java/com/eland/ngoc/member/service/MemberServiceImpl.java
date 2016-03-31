package com.eland.ngoc.member.service;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.TimeZone;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.amazonaws.util.json.JSONException;
import com.amazonaws.util.json.JSONObject;
import com.eland.ngoc.common.OcCommonConstants;
import com.eland.ngoc.common.OneClickConstants;
import com.eland.ngoc.common.dao.CodeDao;
import com.eland.ngoc.common.model.TokenValue;
import com.eland.ngoc.common.service.EmailService;
import com.eland.ngoc.common.service.ProvisioningService;
import com.eland.ngoc.common.service.RedisService;
import com.eland.ngoc.common.service.SmsService;
import com.eland.ngoc.common.util.GlobalUtil;
//import com.eland.ngoc.common.service.ProvisioningService;
import com.eland.ngoc.common.utils.CommonUtil;
import com.eland.ngoc.common.utils.StringUtil;
import com.eland.ngoc.exception.UserHandleException;
import com.eland.ngoc.member.dao.MemberDao;
import com.eland.ngoc.member.model.AuthDtls;
import com.eland.ngoc.member.model.AutoLoginToken;
import com.eland.ngoc.member.model.CustInfo;
import com.eland.ngoc.member.model.CustSiteInfo;
import com.eland.ngoc.member.model.CustTermsAgree;
import com.eland.ngoc.member.model.EimsChildrenInfo;
import com.eland.ngoc.member.model.EimsCustInfo;
import com.eland.ngoc.member.model.EimsCustOut;
import com.eland.ngoc.member.model.Ipin;
import com.eland.ngoc.member.model.Member;
import com.eland.ngoc.member.model.MemberChildInfos;
import com.eland.ngoc.member.model.MemberDTO;
import com.eland.ngoc.member.model.MemberOutDTO;
import com.eland.ngoc.member.model.Pcc;
import com.eland.ngoc.member.model.ProvisioningDTO;
import com.google.gson.Gson;
import com.sci.v2.pcc.secu.hmac.SciHmac;

@Service
public class MemberServiceImpl implements MemberService{
	
	private final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);

	@Autowired
	private MemberDao memberRepository;
	
	@Autowired
	private CodeDao codeRepository;
	
	@Autowired
	private ProvisioningService provisioningService;
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private RedisService redisService; 
	
	@Autowired
	private SmsService smsService;
	
	@Autowired
	private MessageSource messageSource;
	
	@Value("${eims.join.url}")
	private String eimsJoinUrl;
	
	@Value("${eims.updMem.state}")
	private String eimsUpdMemStateUrl;
	
	@Value("${eims.getMemberInfo.url}")
	private String eimsGetMemberInfoUrl;
	
	@Value("${eims.updateMemberInfo.url}")
	private String eimsUpdateMemberInfoUrl;
	
	@Value("${eims.memberOut.url}")
	private String eimsMemberOutUrl;
	
	@Value("${eims.memberOutCancel.url")
	private String eimsMemberOutCancelUrl;

	@Override
	public Boolean isCheckId(String webId, String checkType) {
		int count = memberRepository.isCheckId(webId, checkType);
		
		if (count > 0) {
			return true;
		} 
		return false;
	}

	@Override
	public Member getMemberInfo(String webId, String ci) throws Exception {
		Member memberInfo = new Member(); 
		Map<String, String> paramMap = new HashMap<String, String>();

		if (StringUtil.isNotEmpty(webId)) {
			memberInfo = memberRepository.getMemberInfo(webId);
			paramMap.put("eimsId", memberInfo.getPbpId());
			paramMap.put("idDiv", "P");
		} else {
			paramMap.put("eimsId", ci);
			paramMap.put("idDiv", "C");
		}
		
		Gson gson = new Gson();
		String jsonParam = gson.toJson(paramMap);

		// EIMS_ getMemberInfo
		String jsonMemberInfo = GlobalUtil.makeHttpConnectionEims(eimsGetMemberInfoUrl, jsonParam);
		String resultCode = "";
		try {
			JSONObject obj = new JSONObject(jsonMemberInfo);
			logger.debug(obj.toString());
			resultCode = (String) obj.get("resultCode");
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if (resultCode.equals(OneClickConstants.RESULT_SUCCESS)) {				
			HashMap<String, Object> resultMap = returnMap(jsonMemberInfo);
						
			// PBP ID
			memberInfo.setPbpId((String)resultMap.get("pbpid"));
			
			// 이름
			memberInfo.setMembName((String)resultMap.get("membName"));
			
			// 가입 일자
			memberInfo.setJoinDate((String)resultMap.get("joinDate"));
			
			// 성별
			memberInfo.setGender((String)resultMap.get("gender"));
			
			// 생일
			String custBirthday = (String)resultMap.get("birthday");
			memberInfo.setBirthYear(custBirthday.substring(0,4));
			memberInfo.setBirthMonth(custBirthday.substring(4,6));
			memberInfo.setBirthDay(custBirthday.substring(6,8));
			memberInfo.setBirthUnar((String)resultMap.get("birthdayType"));
			
			// 전화번호
			memberInfo.setTelNo((String)resultMap.get("telNo"));
			
			// 핸드폰번호
			String custMobile = (String)resultMap.get("mobileNo");
			memberInfo.setMobileNo1(custMobile.substring(0,3));
			if (custMobile.length() == 10) {				
				memberInfo.setMobileNo2(custMobile.substring(3,6));
				memberInfo.setMobileNo3(custMobile.substring(6,10));
			} else { 
				memberInfo.setMobileNo2(custMobile.substring(3,7));
				memberInfo.setMobileNo3(custMobile.substring(7,11));
			}
			
			// 주소
			memberInfo.setZipCode((String)resultMap.get("zipCode"));
			memberInfo.setAddr1((String)resultMap.get("addr1"));
			memberInfo.setAddr2((String)resultMap.get("addr2"));
			memberInfo.setSelectAddr((String)resultMap.get("addrDiv"));
			
			// 이메일
			String[] custEmail = ((String)resultMap.get("email")).split("@");
			memberInfo.setEmail1(custEmail[0]);
			memberInfo.setEmail2(custEmail[1]);
			
			// 부가정보_ 결혼 유무
			memberInfo.setWeddingYn((String)resultMap.get("weddingYn"));
			
			// 부가정보_ 결혼 기념일
			String custWeddingDay = (String)resultMap.get("weddingDay");
			if (StringUtil.isNotEmpty(custWeddingDay)) {
				if (StringUtil.isNotEmpty(custWeddingDay.trim())) {
					memberInfo.setWeddingYear(custWeddingDay.substring(0,4));
					memberInfo.setWeddingMonth(custWeddingDay.substring(4,6));
					memberInfo.setWeddingDay(custWeddingDay.substring(6,8));
				}
			}
						
			// 부가정보_ 자녀 정보
			List<MemberChildInfos> childrens = new ArrayList<MemberChildInfos>();
			List<Map<String, String>> childrenList = (List<Map<String, String>>)resultMap.get("children");
			if (childrenList.size() > 0) {
				for (int i=0; i<childrenList.size(); i++) {
					MemberChildInfos child = new MemberChildInfos();
					
					child.setChildName(childrenList.get(i).get("childName"));
					child.setChildGender(childrenList.get(i).get("childGender"));
					child.setChildUnar(childrenList.get(i).get("childUnar"));
					
					String childBirthday = childrenList.get(i).get("childBirthday");
					child.setChildBirthYear(childBirthday.substring(0,4));
					child.setChildBirthMonth(childBirthday.substring(4,6));
					child.setChildBirthDay(childBirthday.substring(6,8));
					
					childrens.add(child);
				}
				memberInfo.setChildNum(childrenList.size());
				memberInfo.setChildren(childrens);
			} else {
				memberInfo.setChildNum(0);
				memberInfo.setChildren(childrens);
			}
			// EIMS

		} else {			
			logger.debug("CustInfo is Not Exists in EIMS_ Error:" + OneClickConstants.INVALID_PBP_ID_MSG);
		}
		
		return memberInfo;
	}
	
	@Override
	public String getMemberPwd(String custId) {
		
		return memberRepository.getMemberPwd(custId);
	}
	
	@Override
	public String getMemberUsedPwd(String custId) {
		return memberRepository.getMemberUsedPwd(custId);
	}
		
	/**
	 * 회원 정보 수정 후 업데이트
	 */
	@Override
	@Transactional(value = "primaryTransactionManager")
	public void txUpdateMember(MemberDTO memberDto, CustSiteInfo custSiteInfo) {
		try {
			// EIMS_ updateMemberInfo
			EimsCustInfo custInfo = convertEimsParam(memberDto, memberDto.getCurrentSiteCode());
			custInfo.setUpdateRoute(memberDto.getCurrentSiteCode());
			custInfo.setPbpId(memberDto.getPbpId());
			
			Gson gson = new Gson();
			String jsonParam = gson.toJson(custInfo);
	
			String jsonResult = GlobalUtil.makeHttpConnectionEims(eimsUpdateMemberInfoUrl, jsonParam);
			HashMap<String, Object> resultMap = returnMap(jsonResult);
			
			if (((String)resultMap.get("resultCode")).equals(OneClickConstants.RESULT_SUCCESS)) {				
				/*
				 *  제휴사이트 추가 및 삭제_ CUST_SITE_INFO 추가
				 *  부분탈퇴 후, 사이트 추가하는 경우를 위해 CUST_STAT도 업데이트
				 */
				String retailMallYn = memberDto.getRetailMallPartnerShipYn();
				String coreYn = memberDto.getCorePartnerShipYn();
				if (StringUtil.isNotEmpty(retailMallYn)) {
					if ("Y".equals(retailMallYn)) {
						custSiteInfo.setSiteCode(OneClickConstants.ELAND_RETAIL_MALL_SITE_CODE);
						custSiteInfo.setEmailRcptnYn(memberDto.getRetailMallEmailYn());
						custSiteInfo.setSmsRcptnYn(memberDto.getRetailMallSmsYn());
						custSiteInfo.setDmRcptnYn("N");
						custSiteInfo.setDelYn("N");
						memberRepository.mergeMemberSiteInfo(custSiteInfo);						
						memberRepository.updateMemberStat(memberDto.getCustId(), OneClickConstants.CUST_STATUS_NORMAL, "", "");
					} else {
						updateMemberSiteInfo(memberDto.getCustId(), OneClickConstants.ELAND_RETAIL_MALL_SITE_CODE);
					}
				}
				if (StringUtil.isNotEmpty(coreYn)) {
					if ("Y".equals(coreYn)) {
						custSiteInfo.setSiteCode(OneClickConstants.ECORE_SITE_CODE);
						custSiteInfo.setEmailRcptnYn(memberDto.getCoreEmailYn());
						custSiteInfo.setSmsRcptnYn(memberDto.getCoreSmsYn());
						custSiteInfo.setDmRcptnYn(memberDto.getCoreDmYn());
						custSiteInfo.setDelYn("N");
						memberRepository.mergeMemberSiteInfo(custSiteInfo);
						memberRepository.updateMemberStat(memberDto.getCustId(), OneClickConstants.CUST_STATUS_NORMAL, "", "");
					} else {
						updateMemberSiteInfo(memberDto.getCustId(), OneClickConstants.ECORE_SITE_CODE);
					}
				}
				
				// 비밀번호 변경_ CUST_INFO 업데이트
				if (StringUtils.isNotEmpty(memberDto.getPassword())) {
					memberDto.setPassword(CommonUtil.encyriptSHA256(memberDto.getPassword()));
					memberDto.setInputOldPassword(CommonUtil.encyriptSHA256(memberDto.getInputOldPassword()));
					updateMemberInfo(memberDto);
				}
				
				// 마케팅 수신 동의 여부 변경_ CUST_SITE_INFO 업데이트
				updateMemberSiteInfoRetailMall(memberDto);
				updateMemberSiteInfoCore(memberDto);
				
				// provisioning
				ProvisioningDTO provisioning = new ProvisioningDTO();
				provisioning.setBirthday(memberDto.getBirth());
				provisioning.setMembName(memberDto.getName());
				provisioning.setMobileNo(memberDto.getPhone());
				provisioning.setEmail(memberDto.getEmail());
				provisioning.setGender(memberDto.getGender());
				provisioning.setCustId(memberDto.getCustId());
				provisioning.setBirthUnar(memberDto.getBirthUnar());
				provisioning.setWebId(memberDto.getWebId());
				provisioning.setJoinDate(memberDto.getJoinDate());
				provisioning.setTelNo(memberDto.getTel());
				provisioning.setWeddingDay(memberDto.getWeddingDay());
				provisioningService.publishedMsg(OcCommonConstants.PROVISIONING_TYPE_UPDATE, provisioning);
				
				/*
				 * 회원정보 수정 완료 메일 발송
				 *  - partnershipYn은 변경사항이 있을때만 Y/N 값이 들어오도록 화면에서 세팅하기 때문에
				 *    메일 발송시에는, 수신 동의 여부가 있는지 확인해서 가입 여부를 세팅함(수신 동의 여부 있으면 가입한 것으로 간주함)
				 */
				if (StringUtil.isNotEmpty(memberDto.getRetailMallEmailYn())) {
					memberDto.setRetailMallPartnerShipYn("Y");
				}
				if (StringUtil.isNotEmpty(memberDto.getCoreEmailYn())) {
					memberDto.setCorePartnerShipYn("Y");
				}
				emailService.sendEmail(memberDto, OneClickConstants.EMAIL_TEMPL_TYPE_CHANGE_INFO, "01");
	
			} else {
				logger.debug("EIMS Error_ " + (String)resultMap.get("errorMsg"));
				throw new UserHandleException(OneClickConstants.INTERNAL_SERVER_ERROR, OneClickConstants.INTERNAL_SERVER_ERROR_MSG);
			}
		} catch (Exception e) {
			logger.debug(e.getMessage());
			throw new UserHandleException(OneClickConstants.INTERNAL_SERVER_ERROR, OneClickConstants.INTERNAL_SERVER_ERROR_MSG);
		}
	}
	
	@Override
	public int updateMemberInfo(MemberDTO memberDto) {				
		int iResult = memberRepository.updateMemberInfo(memberDto);
		
		return iResult;
	}
	
	@Override
	public int updateMemberSiteInfoRetailMall(MemberDTO memberDto) {		
		int iResult = memberRepository.updateMemberSiteInfoRetailMall(memberDto);
		
		return iResult;
	}
	
	@Override
	public int updateMemberSiteInfoCore(MemberDTO memberDto) {
		int iResult = memberRepository.updateMemberSiteInfoCore(memberDto);
		
		return iResult;
	}

	@Override
	@Transactional(value = "primaryTransactionManager")
	public String saveMemberInfo(MemberDTO memberDto, String siteCode, boolean isExistsMember) {
		// EIMS 회원 정보 저장 및 PBPID 조회
		String pbpId = "";
		EimsCustInfo eimsCustInfo = convertEimsParam(memberDto, siteCode);
		eimsCustInfo.setMainStoreId("7601");
		
		if ("N".equals(eimsCustInfo.getNationality())) {
			eimsCustInfo.setNationality("0");
		} else {
			eimsCustInfo.setNationality("1");
		}
		
		Gson gson = new Gson();
		String jsonCustInfo = gson.toJson(eimsCustInfo);
		logger.debug("jsonCustInfo=" + jsonCustInfo);
		
		
		if (isExistsMember) {
			
			eimsCustInfo.setUpdateRoute(siteCode);
			eimsCustInfo.setPbpId(memberDto.getPbpId());
			
			String jsonParam = gson.toJson(eimsCustInfo);
			String jsonResult = GlobalUtil.makeHttpConnectionEims(eimsUpdateMemberInfoUrl, jsonParam);
			logger.debug(jsonResult);
			
			pbpId = memberDto.getPbpId();
			
		} else {
			String jsonResult = GlobalUtil.makeHttpConnectionEims(eimsJoinUrl, jsonCustInfo);		
			logger.debug(jsonResult);
			
			try {
				JSONObject obj = new JSONObject(jsonResult);
				pbpId = (String) obj.get("pbpId");
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		// 회원 정보 저장
		CustInfo custInfo = new CustInfo();
		String encyriptPassword = CommonUtil.encyriptSHA256(memberDto.getPassword());
		custInfo.setWebPwd(encyriptPassword);
		custInfo.setWebId(memberDto.getWebId());
		custInfo.setCustName(memberDto.getName());
		custInfo.setPbpId(pbpId); // EMIS PBPID 세팅
		
		if ("Y".equals(memberDto.getRetailMallPartnerShipYn()) && "Y".equals(memberDto.getCorePartnerShipYn())) {
			custInfo.setInsSiteCode("30");
		} else if ("Y".equals(memberDto.getRetailMallPartnerShipYn()) && "N".equals(memberDto.getCorePartnerShipYn())) {
			custInfo.setInsSiteCode("10");
		} else if ("Y".equals(memberDto.getCorePartnerShipYn()) && "N".equals(memberDto.getRetailMallPartnerShipYn())) {
			custInfo.setInsSiteCode("20");
		}
		
		int custId = memberRepository.insertCustInfo(custInfo);
		
		// 회원 약관 동의 여부 저장
		List<CustTermsAgree> custTermsAgreeList = new ArrayList<CustTermsAgree>(); 
		CustTermsAgree memberShipTermsAgree = new CustTermsAgree();
		CustTermsAgree onlineTermsAgree = new CustTermsAgree();
		CustTermsAgree memberInfoTermsAgree = new CustTermsAgree();
		CustTermsAgree offerMemberInfoTermsAgree = new CustTermsAgree();
		
		String termsAgreeSiteCode = "";
		if ("Y".equals(memberDto.getRetailMallPartnerShipYn()) && "Y".equals(memberDto.getCorePartnerShipYn())) {
			termsAgreeSiteCode = "00";
		} else if ("Y".equals(memberDto.getRetailMallPartnerShipYn()) && "N".equals(memberDto.getCorePartnerShipYn())) {
			termsAgreeSiteCode = "10";
		} else {
			termsAgreeSiteCode = "20";
		}
		memberShipTermsAgree.setCustId(custInfo.getCustId());
		memberShipTermsAgree.setSiteCode(termsAgreeSiteCode);
		memberShipTermsAgree.setTermsCode("10"); // 멤버십 동의 여부
		memberShipTermsAgree.setTermsAgreeYn(memberDto.getMemberShipTerms());
		memberShipTermsAgree.setInsUser(String.valueOf(custInfo.getCustId()));
		memberShipTermsAgree.setUpdUser(String.valueOf(custInfo.getCustId()));
		custTermsAgreeList.add(memberShipTermsAgree);
		
		onlineTermsAgree.setCustId(custInfo.getCustId());
		onlineTermsAgree.setSiteCode(termsAgreeSiteCode);
		onlineTermsAgree.setTermsCode("20"); // 온라인 서비스 동의 여부
		onlineTermsAgree.setTermsAgreeYn(memberDto.getMemberShipTerms());
		onlineTermsAgree.setInsUser(String.valueOf(custInfo.getCustId()));
		onlineTermsAgree.setUpdUser(String.valueOf(custInfo.getCustId()));
		custTermsAgreeList.add(onlineTermsAgree);
		
		memberInfoTermsAgree.setCustId(custInfo.getCustId());
		memberInfoTermsAgree.setSiteCode(termsAgreeSiteCode);
		memberInfoTermsAgree.setTermsCode("70"); // 개인정보 수집항목, 목적 및 이용기간 동의
		memberInfoTermsAgree.setTermsAgreeYn(memberDto.getMemberShipTerms());
		memberInfoTermsAgree.setInsUser(String.valueOf(custInfo.getCustId()));
		memberInfoTermsAgree.setUpdUser(String.valueOf(custInfo.getCustId()));
		custTermsAgreeList.add(memberInfoTermsAgree);
		
		offerMemberInfoTermsAgree.setCustId(custInfo.getCustId());
		offerMemberInfoTermsAgree.setSiteCode(termsAgreeSiteCode);
		offerMemberInfoTermsAgree.setTermsCode("80"); // 개인정보 수집항목, 목적 및 이용기간 동의
		offerMemberInfoTermsAgree.setTermsAgreeYn(memberDto.getMemberShipTerms());
		offerMemberInfoTermsAgree.setInsUser(String.valueOf(custInfo.getCustId()));
		offerMemberInfoTermsAgree.setUpdUser(String.valueOf(custInfo.getCustId()));
		custTermsAgreeList.add(offerMemberInfoTermsAgree);
		
		memberRepository.insertCustTermsAgree(custTermsAgreeList);
		
		// 사이트별 email, sms, dm 수신 여부 저장
		if ("Y".equals(memberDto.getRetailMallPartnerShipYn())) {
			CustSiteInfo siteInfo = new CustSiteInfo();
			siteInfo.setCustId(custInfo.getCustId());
			siteInfo.setSiteCode("10");
			siteInfo.setEmailRcptnYn(memberDto.getRetailMallEmailYn());
			siteInfo.setSmsRcptnYn(memberDto.getRetailMallSmsYn());
			siteInfo.setDmRcptnYn("N");
			siteInfo.setDelYn("N");
			siteInfo.setInsUser(String.valueOf(custInfo.getCustId()));
			siteInfo.setUpdUser(String.valueOf(custInfo.getCustId()));
			memberRepository.insertCustSiteInfo(siteInfo);
		}
		
		if ("Y".equals(memberDto.getCorePartnerShipYn())) {
			CustSiteInfo siteInfo = new CustSiteInfo();
			siteInfo.setCustId(custInfo.getCustId());
			siteInfo.setSiteCode("20");
			siteInfo.setEmailRcptnYn(memberDto.getCoreEmailYn());
			siteInfo.setSmsRcptnYn(memberDto.getCoreSmsYn());
			siteInfo.setDmRcptnYn(memberDto.getCoreDmYn());
			siteInfo.setDelYn("N");
			siteInfo.setInsUser(String.valueOf(custInfo.getCustId()));
			siteInfo.setUpdUser(String.valueOf(custInfo.getCustId()));
			memberRepository.insertCustSiteInfo(siteInfo);
		}
		
		// 회원가입 메일 발송
		emailService.sendEmail(memberDto, OneClickConstants.EMAIL_TEMPL_TYPE_MEMBER_JOIN, "01");
		
		// 회원가입 SMS 발송
		Object args[] = new Object[1];
		args[0] = memberDto.getName();
		String msg = messageSource.getMessage("sms.join.message", args, Locale.KOREA);
		
		logger.debug(msg);
		smsService.insertTblSubmitQueue(memberDto.getPhone(), msg);
		
		
		return String.valueOf(custInfo.getCustId());
	}

	@Override
	public Pcc setPcc(String id, String srvNo, String returnUrl) {
		Pcc pcc = new Pcc();
		
		 //날짜 생성
		TimeZone tz = TimeZone.getTimeZone("GMT+09:00");
        Calendar today = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        sdf.setTimeZone(tz);
        String day = sdf.format(today.getTime());
        
        logger.debug(day);
        java.util.Random ran = new Random();
        //랜덤 문자 길이
        int numLength = 6;
        String randomStr = "";

        for (int i = 0; i < numLength; i++) {
            //0 ~ 9 랜덤 숫자 생성
            randomStr += ran.nextInt(10);
        }

		//reqNum은 최대 40byte 까지 사용 가능
        String reqNum = day + randomStr;
		String certDate=day;
		
		String certGb = "H"; 				// 인증수단  H : 휴대폰 인증 화면 사용
		String exVar = "0000000000000000";  // 복호화용 임시필드
		String addVar = "";				    // 본인실명확인 추가 파라메터
		
		//01. 암호화 모듈 선언
		com.sci.v2.pcc.secu.SciSecuManager seed  = new com.sci.v2.pcc.secu.SciSecuManager();

		//02. 1차 암호화
		String reqInfo = id+"^"+srvNo+"^"+reqNum+"^"+certDate+"^"+certGb+"^"+exVar;  // 데이터 암호화
		String encStr = seed.getEncPublic(reqInfo);

		//03. 위변조 검증 값 생성
		com.sci.v2.pcc.secu.hmac.SciHmac hmac = new com.sci.v2.pcc.secu.hmac.SciHmac();
		String hmacMsg = hmac.HMacEncriptPublic(encStr);

		//03. 2차 암호화
		reqInfo  = seed.getEncPublic(encStr + "^" + hmacMsg + "^" + "0000000000000000");  //2차암호화
		
		pcc.setReqPccInfo(reqInfo);
		pcc.setReqPccNum(reqNum);
		pcc.setRetPccUrl(returnUrl);
		
		
		return pcc;
	}
	
	public Pcc getPcc(String reqPccNum, String retInfo) {
		
		// 변수 --------------------------------------------------------------------------------
		String name			= "";                                                          //성명

		//복화화용 변수
		String encPara		= "";
		String encMsg		= "";
		String msgChk       = "N";  
	    //--------------------------------------------------------------------------------------
	    
        // Parameter 수신 --------------------------------------------------------------------
        // 1. 암호화 모듈 (jar) Loading
        com.sci.v2.pcc.secu.SciSecuManager sciSecuMg = new com.sci.v2.pcc.secu.SciSecuManager();
        //쿠키에서 생성한 값을 Key로 생성 한다.
        retInfo  = sciSecuMg.getDec(retInfo, reqPccNum);

        // 2.1차 파싱---------------------------------------------------------------
        String[] aRetInfo1 = retInfo.split("\\^");

		encPara  = aRetInfo1[0];         //암호화된 통합 파라미터
        encMsg   = aRetInfo1[1];    //암호화된 통합 파라미터의 Hash값
		
		String  encMsg2   = sciSecuMg.getMsg(encPara);
			// 3.위/변조 검증 ---------------------------------------------------------------
        if(encMsg2.equals(encMsg)){
            msgChk = "Y";
        }

		if(msgChk.equals("N")){
            logger.info("비정상적인 접근입니다.!!<%=msgChk%>");
		}

        // 복호화 및 위/변조 검증 
		retInfo  = sciSecuMg.getDec(encPara, reqPccNum);

        String[] aRetInfo = retInfo.split("\\^");
		
        Pcc pcc= new Pcc();
        try {
			name = URLDecoder.decode(aRetInfo[0],"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		pcc.setName(name);
		pcc.setBirYMD(aRetInfo[1]);
		pcc.setSex(aRetInfo[2]);
		pcc.setFgnGbn(aRetInfo[3]);
		pcc.setDi(aRetInfo[4]);
		pcc.setCi1(aRetInfo[5]);
		pcc.setCi2(aRetInfo[6]);
		pcc.setCiversion(aRetInfo[7]);
		pcc.setReqNum(aRetInfo[8]);
		pcc.setResult(aRetInfo[9]);
		pcc.setCertGb(aRetInfo[10]);
		pcc.setCellNo(aRetInfo[11]);
		pcc.setCellCorp(aRetInfo[12]);
		pcc.setCertDate(aRetInfo[13]);
		pcc.setAddVar(aRetInfo[14]);
		
		return pcc;
	}

	@Override
	public Ipin setIpin(String ipinCertId, String ipinSrvNo, String returnUrl) {
		
		 //날짜 생성
		TimeZone tz = TimeZone.getTimeZone("GMT+09:00");
        Calendar today = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        sdf.setTimeZone(tz);
        String day = sdf.format(today.getTime());

        java.util.Random ran = new Random();
        //랜덤 문자 길이
        int numLength = 6;
        String randomStr = "";

        for (int i = 0; i < numLength; i++) {
            //0 ~ 9 랜덤 숫자 생성
            randomStr += ran.nextInt(10);
        }

		//reqNum은 최대 40byte 까지 사용 가능
        String reqNum = day + randomStr;
		
		//결과 수신 URL
		 String exVar = "0000000000000000"; // 복호화용 임시필드
		
		 // 암호화 모듈 선언
		 com.sci.v2.ipin.secu.SciSecuManager seed = new com.sci.v2.ipin.secu.SciSecuManager();
		
		 // 1차 암호화
		 String encStr = "";
		 String reqInfo = reqNum+"/"+ipinCertId+"/"+ipinSrvNo+"/"+exVar; // 데이터 암호화
		 encStr = seed.getEncPublic(reqInfo);
		
		 // 위변조 검증 값 등록
		 SciHmac hmac = new SciHmac();
		 String hmacMsg = hmac.HMacEncriptPublic(encStr);
		
		 // 2차 암호화
		 reqInfo = seed.getEncPublic(encStr + "/" + hmacMsg + "/" + "00000000"); //2차암호화
		 //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//		 IPIN SETTING END
		
		 Ipin ipin =new Ipin();
		 
		ipin.setReqIpinInfo(reqInfo);
		ipin.setRetIpinUrl(returnUrl);
		ipin.setReqIpinNum(reqNum);
		
		return ipin;
	}

	
	public Ipin getIpin(String reqIpinNum, String retInfo) {
		logger.info("getIPIN  Start >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ");
		
		//IPIN변수
//		String retInfo      = "";       
		String encPara      = "";
		String decPara      = "";
	    String encMsg       = "";                                                       // HMAC 메세지
	    String reqNum       = "";                                                       // 요청번호(복호화)
	    String vDiscrNo     = "";                                                       // 가상식별번호
	    String name         = "";                                                       // 성명
	    String result       = "";                                                       // 결과값 (1인경우에만 정상)
		String age          = "";														//연령대
	    String sex          = "";														//성별
		String ip           = "";														//접속IP
	    String authInfo     = "";														// 발급수단정보	
	    String birth        = "";														//생년월일
	    String fgn          = "";                                                       // 외국인구분
		String discrHash    = "";                                                       // 중복가입확인정보
		String ciVersion	= "";														// 연계정보 버젼
		String ciscrHash    = "";                                                     	// 연계정보
		String msgChk       = "N";                                                    	// 위조/변조 검증 결과
		
		//IPIN 인증결과 START >>>
        
        // 1. 암호화 모듈 (jar) Loading
		com.sci.v2.ipin.secu.SciSecuManager sciSecuMg = new com.sci.v2.ipin.secu.SciSecuManager();

        retInfo  = sciSecuMg.getDec(retInfo, reqIpinNum);

        // 2.1차 파싱---------------------------------------------------------------
        int inf1 = retInfo.indexOf("/",0);
        int inf2 = retInfo.indexOf("/",inf1+1);

		encPara  = retInfo.substring(0,inf1);         //암호화된 통합 파라미터
        encMsg   = retInfo.substring(inf1+1,inf2);    //암호화된 통합 파라미터의 Hash값

        // 3.위/변조 검증 ---------------------------------------------------------------
        if(sciSecuMg.getMsg(encPara).equals(encMsg)){
            msgChk="Y";
        }
		logger.info( "encPara="+sciSecuMg.getMsg(encPara));
		logger.info( "encMsg="+encMsg);
			
		if(msgChk.equals("N")){
			logger.info( "비정상적인 접근입니다.!!");
		}
		
		// 4.파라미터별 값 가져오기 ---------------------------------------------------------------
        decPara  = sciSecuMg.getDec(encPara, reqIpinNum);
		logger.info( "[decPara] : "+decPara);

		int info1 = decPara.indexOf("/",0);
        int info2 = decPara.indexOf("/",info1+1);
        int info3 = decPara.indexOf("/",info2+1);
        int info4 = decPara.indexOf("/",info3+1);
    	int info5 = decPara.indexOf("/",info4+1);
        int info6 = decPara.indexOf("/",info5+1);
        int info7 = decPara.indexOf("/",info6+1);
        int info8 = decPara.indexOf("/",info7+1);
        int info9 = decPara.indexOf("/",info8+1);
        int info10 = decPara.indexOf("/",info9+1);
        int info11 = decPara.indexOf("/",info10+1);
        int info12 = decPara.indexOf("/",info11+1);
        int info13 = decPara.indexOf("/",info12+1);

		reqNum     = decPara.substring(0,info1);
        vDiscrNo   = decPara.substring(info1+1,info2);
        try {
			name       = URLDecoder.decode(decPara.substring(info2+1,info3),"UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		};
        result     = decPara.substring(info3+1,info4);
        age        = decPara.substring(info4+1,info5);
        sex        = decPara.substring(info5+1,info6);
        ip         = decPara.substring(info6+1,info7);
        authInfo   = decPara.substring(info7+1,info8);
        birth      = decPara.substring(info8+1,info9);
        fgn        = decPara.substring(info9+1,info10);
        discrHash  = decPara.substring(info10+1,info11);
        ciVersion  = decPara.substring(info11+1,info12);
		ciscrHash  = decPara.substring(info12+1,info13);	
		
		discrHash  = sciSecuMg.getDec(discrHash, reqIpinNum); //중복가입확인정보는 한번더 복호화
		ciscrHash  = sciSecuMg.getDec(ciscrHash, reqIpinNum); //연계정보는 한번더 복호화

		
		if ("1".equals(result)) {
			
			result = "Y";
		} else {
			result = "N";
		}
		
		String age_yn = "";

		Ipin ipin = new Ipin();
		
		ipin.setReqnum(reqNum);
		ipin.setVdiscrno(vDiscrNo);
		ipin.setName(name);
		ipin.setResult(result);
		ipin.setAge(age);
		ipin.setSex(sex);
		ipin.setIp(ip);
		ipin.setAuthinfo(authInfo);
		ipin.setBirth(birth);
		ipin.setFgn(fgn);
		ipin.setDiscrhash(discrHash);
		ipin.setCiversion(ciVersion);
		ipin.setCiscrhash(ciscrHash);
		ipin.setBirthday(birth.substring(0, 4) + "-" + birth.substring(4, 6) + "-" + birth.substring(6, 8));
		ipin.setCertGb("21");
		ipin.setAge_yn(age_yn);

		//<<<< IPIN 인증결과 END	
		logger.info( "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< getIPIN  END");
		return ipin;
	}
	
	@Override
	@Transactional(value = "primaryTransactionManager")
	public int insertAuthDtls(AuthDtls authDtls) {
		
		return memberRepository.insertAuthDtls(authDtls);
	}
	
	@Override
	public Map<String, String> getCustnPbpId(String webId) {
		return memberRepository.getCustnPbpId(webId);
	}
	
	/**
	 * 회원 탈퇴 요청 후 정보 업데이트
	 */
	@Override
	@Transactional(value = "primaryTransactionManager")
	public void txOutMember(MemberOutDTO memberOutDto) {
		try {
			String[] selOutRsons = memberOutDto.getOutReasons().split("&");
			String[] outSites = memberOutDto.getOutSiteCodes().split("&");
			
			if (StringUtils.isNotEmpty(outSites[0])) {
				Gson gson = new Gson();
				
				String currentSiteCode = "";
				if (outSites.length == 2) { 
					currentSiteCode = OneClickConstants.ONECLICK_SITE_CODE;
				} else {
					if (outSites[0].equals(OneClickConstants.ELAND_RETAIL_MALL_SITE_CODE)) {
						currentSiteCode = OneClickConstants.ELAND_RETAIL_MALL_SITE_CODE;
					} else if (outSites[0].equals(OneClickConstants.ECORE_SITE_CODE)) {
						currentSiteCode = OneClickConstants.ECORE_SITE_CODE;
					}
				}
				
				// 1. 탈퇴 가능여부 먼저 조회
					// - RETAIL MALL
//				String retailMallResponse = GlobalUtil.elandMallMemberOutAllowYn(memberOutDto.getWebId());
//				logger.debug("E:LAND MALL Result: " + retailMallResponse);
//				String retailMallAllowYn = (String)returnMap(retailMallResponse).get("outPossibleYn");					
//					// - CORE PAGE
//				Map<String, String> outAllowMap = new HashMap<String, String>();
//				outAllowMap.put("webId", memberOutDto.getWebId());
//				String coreResponse = GlobalUtil.ecoreMemberOutAllowYn(gson.toJson(outAllowMap));
//				logger.debug("E:CORE Result: " + coreResponse);
//				String coreAllowYn = (String)returnMap(coreResponse).get("outPossibleYn");
//				
//				if ("Y".equals(retailMallAllowYn) && "Y".equals(coreAllowYn)) {
					// 2. EIMS_ memberOut
					HashMap<String, Object> resultMap = new HashMap<String, Object>();				
					if (memberOutDto.getCustStat().equals(OneClickConstants.CUST_STATUS_MEMBER_WHOLE_OUT)) {
						EimsCustOut custOut = new EimsCustOut();
						custOut.setPbpId(memberOutDto.getPbpId());
						custOut.setOutDiv(OneClickConstants.EIMS_OUT_DIV_SELF_OUT);
						custOut.setSiteCode(OneClickConstants.ONECLICK_SITE_CODE);
						if ("2".equals(memberOutDto.getSelectMenu())) {														
							custOut.setOutType(OneClickConstants.OUT_TYPE_OFFLINE_MEMBER_OUT);
						} else if ("1".equals(memberOutDto.getSelectMenu())) {
							custOut.setOutType(OneClickConstants.OUT_TYPE_ONLINE_MEMBER_OUT);
						}
						try {
							String jsonParam = gson.toJson(custOut);					
							String jsonResult = GlobalUtil.makeHttpConnectionEims(eimsMemberOutUrl, jsonParam);
							resultMap = returnMap(jsonResult);
						} catch (Exception e) {
							logger.debug(e.getMessage());
							throw new UserHandleException(OneClickConstants.INVALID_PBP_ID, OneClickConstants.INVALID_PBP_ID_MSG);
						}
					}
						
					if (resultMap.size() == 0 
							|| ((String)resultMap.get("resultCode")).equals(OneClickConstants.RESULT_SUCCESS)) {
						/*
						 * 3. 탈퇴 요청 사이트 수 만큼 CUST_OUT_DTLS 업데이트
						 * 4. 탈퇴 요청 사이트에 대해 DEL_YN = 'Y' 처리
						 * 5. 탈퇴 요청 사이트 수 * OUT_RSON_CODE 수 만큼 CUST_OUT_RSON 업데이트
						 */
						for (int j=0; j<outSites.length; j++) {	
							memberOutDto.setSiteCode(outSites[j]);
							memberOutDto.setOutSeq(getOutSeq(memberOutDto));
							if (StringUtils.isEmpty(memberOutDto.getOutDesc())) {
								memberOutDto.setOutDesc(null);
							}
							saveMemberOutDetail(memberOutDto);
							updateMemberSiteInfo(memberOutDto.getCustId(), memberOutDto.getSiteCode());
	
							if (StringUtils.isNotEmpty(selOutRsons[0])) {
								for (int k=0; k<selOutRsons.length; k++) {
									memberOutDto.setOutRsonCode(selOutRsons[k]);
									saveMemberOutReason(memberOutDto);
								}
							}
						}
						
						/*
						 * 6. 회원 상태 업데이트
						 */
						updateMemberStat(memberOutDto.getCustId(), memberOutDto.getCustStat(), "", "");
						
						/*
						 * 7. provisioning
						 */
						for(int i=0; i<outSites.length; i++) {
							if (outSites[i].equals(OneClickConstants.ELAND_RETAIL_MALL_SITE_CODE)) {
								memberOutDto.setMallOutYn("Y");
							}
							if (outSites[i].equals(OneClickConstants.ECORE_SITE_CODE)) {
								memberOutDto.setRetailOutYn("Y");						
							}
						}
						SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ("yyyyMMdd", Locale.KOREA);
				        Date currentTime = new Date();
				        String mTime = mSimpleDateFormat.format(currentTime);
				        memberOutDto.setOutDate(mTime);	
				        
						provisioningService.publishedMsg(OcCommonConstants.PROVISIONING_TYPE_OUT, memberOutDto);
						
						/*
						 * 8. 회원 탈퇴 완료 메일 발송
						 * EIMS_ getMemberInfo : 이름, 이메일 주소 조회를 위해 EIMS 회원조회 API 호출 
						 */
						Map<String, String> paramMap = new HashMap<String, String>();
						paramMap.put("eimsId", memberOutDto.getPbpId());
						paramMap.put("idDiv", "P");
						
						HashMap<String, Object> resultMap2 = new HashMap<String, Object>();
						try {
							String jsonParam = gson.toJson(paramMap);
							String jsonMemberInfo = GlobalUtil.makeHttpConnectionEims(eimsGetMemberInfoUrl, jsonParam);
							
							resultMap2 = returnMap(jsonMemberInfo);
						} catch (Exception e) {
							logger.debug("CustInfo is Not Exists in EIMS_ Error:" + OneClickConstants.INVALID_PBP_ID_MSG);
							throw new UserHandleException(OneClickConstants.INVALID_PBP_ID, OneClickConstants.INVALID_PBP_ID_MSG);
						}
						
						if (((String)resultMap2.get("resultCode")).equals(OneClickConstants.RESULT_SUCCESS)) {
							MemberDTO memberDto = new MemberDTO();
							memberDto.setName((String)resultMap2.get("membName"));
							memberDto.setWebId(memberOutDto.getWebId());
							memberDto.setEmail((String)resultMap2.get("email"));
							memberDto.setCurrentSiteCode(currentSiteCode);
							
							// 1: 온라인 부분 탈퇴, 2: 원클릭 전체 탈퇴
							String outType = memberOutDto.getCustStat();
							if ("40".equals(outType)) {
								if (memberOutDto.getOutSiteCodes().contains("10")) {
									if (memberOutDto.getOutSiteCodes().contains("20")) {										
										emailService.sendEmail(memberDto, OneClickConstants.EMAIL_TEMPL_TYPE_MEMBER_ONLINEOUT, "05");
//									sendOutSms("30", (String)resultMap2.get("mobileNo"), (String)resultMap2.get("membName"));
									} else {
										memberDto.setOutSiteCode("E:LAND MALL");
										emailService.sendEmail(memberDto, OneClickConstants.EMAIL_TEMPL_TYPE_MEMBER_SITEOUT, "04");
//									sendOutSms("10", (String)resultMap2.get("mobileNo"), (String)resultMap2.get("membName"));
									}					
								} else {
									memberDto.setOutSiteCode("E:CORE");
									emailService.sendEmail(memberDto, OneClickConstants.EMAIL_TEMPL_TYPE_MEMBER_SITEOUT, "04");
//								sendOutSms("20", (String)resultMap2.get("mobileNo"), (String)resultMap2.get("membName"));
								}
							} else if ("50".equals(outType)) {
								if ("1".equals(memberOutDto.getSelectMenu())) {
									emailService.sendEmail(memberDto, OneClickConstants.EMAIL_TEMPL_TYPE_MEMBER_ONLINEOUT, "05");
//								sendOutSms("40", (String)resultMap2.get("mobileNo"), (String)resultMap2.get("membName"));
								} else if ("2".equals(memberOutDto.getSelectMenu())){
									emailService.sendEmail(memberDto, OneClickConstants.EMAIL_TEMPL_TYPE_MEMBER_OUT, "05");
//								sendOutSms("40", (String)resultMap2.get("mobileNo"), (String)resultMap2.get("membName"));									
								}
	
							}
						} else {
							logger.debug("CustInfo is Not Exists in EIMS_ Error:" + OneClickConstants.INVALID_PBP_ID_MSG);
							throw new UserHandleException(OneClickConstants.INVALID_PBP_ID, OneClickConstants.INVALID_PBP_ID_MSG);
						}
					}
//				}

			}
		} catch (Exception e) {
			logger.debug(e.getMessage());
			throw new UserHandleException(OneClickConstants.INTERNAL_SERVER_ERROR, OneClickConstants.INTERNAL_SERVER_ERROR_MSG);
		}
		
	}
	
	@Override
	public void sendOutSms(String type, String mobileNo, String name) {
		String msg = "";
		
		Object args[] = new Object[2];
		args[0] = name;
		if ("10".equals(type)) {
			args[1] = "E:LAND MALL";
			msg = messageSource.getMessage("sms.partial.online.secession", args, Locale.KOREA);
		} else if ("20".equals(type)) {
			args[1] = "E:CORE";
			msg = messageSource.getMessage("sms.partial.online.secession", args, Locale.KOREA);
		} else if ("30".equals(type)){
			msg = messageSource.getMessage("sms.all.online.secession", args, Locale.KOREA);
		} else if ("40".equals(type)) {
			msg = messageSource.getMessage("sms.all.oneclick.secession", args, Locale.KOREA);
		}
		
		logger.debug(msg);
		smsService.insertTblSubmitQueue(mobileNo, msg);
	}
	
	@Override
	public int getOutSeq(MemberOutDTO memberOutDto) {
		return memberRepository.selectOutSeq(memberOutDto);
	}
	
	@Override
	public int saveMemberOutDetail(MemberOutDTO memberOutDto) {
		return memberRepository.insertMemberOutDetail(memberOutDto);
	}
	
	@Override
	public int saveMemberOutReason(MemberOutDTO memberOutDto) {
		return memberRepository.insertMemberOutReason(memberOutDto);
	}

	@Override
	public CustInfo getFindMemberInfo(String ci, String custName) {
		return memberRepository.getFindMemberInfo(ci, custName);
	}
	
	@Override
	public int updateMemberStat(String custId, String custStat, String webPwd, String tempPwdYn) {
		return memberRepository.updateMemberStat(custId, custStat, webPwd, tempPwdYn);
	}
	
	@Override
	public int updateMemberSiteInfo(String custId, String siteCode) {
		CustSiteInfo custSiteInfo = new CustSiteInfo();
		custSiteInfo.setCustId(Integer.parseInt(custId));
		custSiteInfo.setSiteCode(siteCode);
		custSiteInfo.setDelYn("Y");
		return memberRepository.updateMemberSiteInfo(custSiteInfo);
	}

	@Override
	@Transactional(value = "primaryTransactionManager")
	public AutoLoginToken saveAutoLoginToken(String webId) {
		
		AutoLoginToken autoLoginToken = new AutoLoginToken();
		autoLoginToken.setWebId(webId);
		autoLoginToken.setAlUid(CommonUtil.createLoginUid(webId));
		autoLoginToken.setLoginToken(CommonUtil.createLoginToken());
		
		memberRepository.insertAutoLoginToken(autoLoginToken);
		return autoLoginToken;
	}

	@Override
	@Transactional(value = "primaryTransactionManager")
	public Map<String, String> autoLogin(String aLoginUid, String loginToken) {
		Map<String, String> returnMap = new HashMap<String, String>();
		
		// 자동 로그인 토큰 조회
		AutoLoginToken token =  memberRepository.selectAutoLoginToken(aLoginUid, "");
		String newLoginToken = "";
		
		if (token == null) {
			throw new UserHandleException(OneClickConstants.INVALID_AUTO_LOGIN_UID, OneClickConstants.INVALID_AUTO_LOGIN_UID_MSG);
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

				Member member = memberRepository.getMemberInfo(token.getWebId());
				
				returnMap.put("newLoginToken", newLoginToken);
				returnMap.put("custId", member.getCustId());
			} 
			// 토큰이 다르면 정보가 유출된것으로 판단 기존 UID 삭제(WEB_ID 기준으로 전체 삭제)
			else {
				throw new UserHandleException(OneClickConstants.INVALID_AUTO_LOGIN_TOKEN, token.getWebId(), OneClickConstants.INVALID_AUTO_LOGIN_TOKEN_MSG);
			}
		}
		
		return returnMap;
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
	public String selectCustStateInfo(String custId, String siteCode) {
		String membState = "";
		CustInfo custInfo = memberRepository.selectCustStateInfo(custId, siteCode);
		
		if (custInfo != null) {
			
			if (custInfo != null) {
				if ("30".equals(siteCode)) {
					if ("10".equals(custInfo.getMembState()) || "40".equals(custInfo.getMembState())) {
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
				} else {
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
			}
		}
		
		return membState;
	}

	@Override
	public CustInfo selectCustInfoCheck(String webId, String webPwd) {
		String encyriptPwd = CommonUtil.encyriptSHA256(webPwd);
		return memberRepository.selectCustInfoCheck(webId, encyriptPwd);
	}

	@Override
	@Transactional(value = "primaryTransactionManager")
	public void deleteAutoLoginToken(String webId) {
		memberRepository.deleteAutoLoginToken(webId);
	}

	@Override
	public void updatePwdChangeDate(String webId) {
		memberRepository.updatePwdChangeDate(webId);
	}

	@Override
	public void updateTempPwdYn(String webId) {
		memberRepository.updateTempPwdYn(webId);
	}

	@Override
	public void addSite(String custId, String emailYn, String smsYn, String dmYn, String siteCode) {
		CustSiteInfo custSiteInfo = new CustSiteInfo();
		custSiteInfo.setCustId(Integer.parseInt(custId));
		custSiteInfo.setSiteCode(siteCode);
		custSiteInfo.setEmailRcptnYn(emailYn == null ? "N" : emailYn);
		custSiteInfo.setSmsRcptnYn(smsYn == null ? "N" : smsYn);
		custSiteInfo.setDmRcptnYn(dmYn == null ? "N" : dmYn);
		custSiteInfo.setInsUser(custId);
		custSiteInfo.setUpdUser(custId);
		
		// siteInfo 인서트
		memberRepository.insertCustSiteInfo(custSiteInfo);
	}

	@Override
	public void termiteDormancy(String custId, String siteCode) {
		// 회원테이블 상태 "10:정상" 업데이트 및 비밀번호 ChangeDate 변경 및 임시비밀번호 "N"
		String pbpId = memberRepository.getPbpId(custId);
		memberRepository.updateMemberStat(custId, "10", "", "N");
	}

	@Override
	public void cancelSecession(String custId, String emailYn, String smsYn, String dmYn, String siteCode) {
		// 회원테이블 상태 "10:정상" 업데이트
		memberRepository.updateMemberStat(custId, "10", "", "N");
		
		// TODO : siteInfo 테이블 DelYn "N" 업데이트 및 마케팅 수신 동의 업데이트
		CustSiteInfo custSiteInfo = new CustSiteInfo();
		custSiteInfo.setCustId(Integer.parseInt(custId));
		custSiteInfo.setEmailRcptnYn(emailYn);
		custSiteInfo.setSmsRcptnYn(smsYn);
		custSiteInfo.setDmRcptnYn(dmYn);
		custSiteInfo.setSiteCode(siteCode);
		custSiteInfo.setDelYn("N");
		memberRepository.updateMemberSiteInfo(custSiteInfo);
		
	}

	@Override
	public String getPbpId(String custId) {
		
		return memberRepository.getPbpId(custId);
	}	
	
	/**
	 * EIMS JSON 형태 결과를 Map으로 변환
	 * 
	 * @param jsonStr
	 * @return
	 */
	private HashMap<String, Object> returnMap(String jsonStr) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			resultMap = new ObjectMapper().readValue(jsonStr, HashMap.class);
		} catch (Exception e) {
			logger.debug("json to hashMap Error_ Error:" + OneClickConstants.INTERNAL_SERVER_ERROR_MSG);
			throw new UserHandleException(OneClickConstants.INTERNAL_SERVER_ERROR, OneClickConstants.INTERNAL_SERVER_ERROR_MSG);
		}
		
		return resultMap;
	}
	
	/**
	 * MemberDTO 모델에 있는 값을 EIMS에 보낼 모델에 set
	 * @param memberDto
	 * @return
	 */
	private EimsCustInfo convertEimsParam(MemberDTO memberDto, String siteCode) {
		
		EimsCustInfo eimsCustInfo = new EimsCustInfo();
		eimsCustInfo.setSiteCode(siteCode);
		eimsCustInfo.setWebId(memberDto.getWebId());
		eimsCustInfo.setCi(memberDto.getCi());
		eimsCustInfo.setDi(memberDto.getDi());
		eimsCustInfo.setMembName(memberDto.getName());
		eimsCustInfo.setBirthdayType(memberDto.getBirthUnar());
		eimsCustInfo.setBirthday(memberDto.getBirth());
		eimsCustInfo.setGender(memberDto.getGender());
		eimsCustInfo.setTelNo(memberDto.getTel());
		eimsCustInfo.setMobileNo(memberDto.getPhone());
		eimsCustInfo.setEmail(memberDto.getEmail());
		
		if ("inputJibun".equals(memberDto.getAddrType1())) {
			eimsCustInfo.setAddrDiv("1");
		} else if ("inputRoad".equals(memberDto.getAddrType1())) {
			eimsCustInfo.setAddrDiv("2");
		} else if ("jibun".equals(memberDto.getAddrType1())) {
			eimsCustInfo.setAddrDiv("3");
		} else if ("road".equals(memberDto.getAddrType1())) {
			eimsCustInfo.setAddrDiv("4");
		}
		
		if (memberDto.getAddrType1().equals("inputJibun") || memberDto.getAddrType1().equals("inputRoad")) {
			eimsCustInfo.setAddr1(memberDto.getAddress1_1());
			eimsCustInfo.setAddr2(memberDto.getAddress1_2());
			eimsCustInfo.setZipCode(memberDto.getPostNo1());
		} else if (memberDto.getAddrType1().equals("jibun")) {
			eimsCustInfo.setStdAddr1(memberDto.getAddress1_1());
			eimsCustInfo.setStdAddr2(memberDto.getAddress1_2());
			eimsCustInfo.setStdZipcode(memberDto.getPostNo1());
		} else if (memberDto.getAddrType1().equals("road")) {
			eimsCustInfo.setRoadAddr1(memberDto.getAddress1_1());
			eimsCustInfo.setRoadAddr2(memberDto.getAddress1_2());
			eimsCustInfo.setRoadZipcode(memberDto.getPostNo1());
		}
		
		if (StringUtil.isNotEmpty(memberDto.getAddrType2())) {
			if (memberDto.getAddrType2().equals("inputJibun") || memberDto.getAddrType2().equals("inputRoad")) {
				eimsCustInfo.setAddr1(memberDto.getAddress2_1());
				eimsCustInfo.setAddr2(memberDto.getAddress2_2());
				eimsCustInfo.setZipCode(memberDto.getPostNo2());
			} else if (memberDto.getAddrType2().equals("jibun")) {
				eimsCustInfo.setStdAddr1(memberDto.getAddress2_1());
				eimsCustInfo.setStdAddr2(memberDto.getAddress2_2());
				eimsCustInfo.setStdZipcode(memberDto.getPostNo2());
			} else if (memberDto.getAddrType2().equals("road")) {
				eimsCustInfo.setRoadAddr1(memberDto.getAddress2_1());
				eimsCustInfo.setRoadAddr2(memberDto.getAddress2_2());
				eimsCustInfo.setRoadZipcode(memberDto.getPostNo2());
			}
		}
		
		if (StringUtil.isNotEmpty(memberDto.getAddrType3())) {
			if (memberDto.getAddrType3().equals("inputJibun") || memberDto.getAddrType3().equals("inputRoad")) {
				eimsCustInfo.setAddr1(memberDto.getAddress3_1());
				eimsCustInfo.setAddr2(memberDto.getAddress3_2());
				eimsCustInfo.setZipCode(memberDto.getPostNo3());
			} else if (memberDto.getAddrType3().equals("jibun")) {
				eimsCustInfo.setStdAddr1(memberDto.getAddress3_1());
				eimsCustInfo.setStdAddr2(memberDto.getAddress3_2());
				eimsCustInfo.setStdZipcode(memberDto.getPostNo3());
			} else if (memberDto.getAddrType3().equals("road")) {
				eimsCustInfo.setRoadAddr1(memberDto.getAddress3_1());
				eimsCustInfo.setRoadAddr2(memberDto.getAddress3_2());
				eimsCustInfo.setRoadZipcode(memberDto.getPostNo3());
			}
		}

		if (siteCode.equals(OneClickConstants.ELAND_RETAIL_MALL_SITE_CODE)) {
			eimsCustInfo.setEmailYn(memberDto.getRetailMallEmailYn());
			eimsCustInfo.setSmsYn(memberDto.getRetailMallSmsYn());
		} else if (siteCode.equals(OneClickConstants.ECORE_SITE_CODE)){
			eimsCustInfo.setEmailYn(memberDto.getCoreEmailYn());
			eimsCustInfo.setSmsYn(memberDto.getCoreSmsYn());
			eimsCustInfo.setDmYn(memberDto.getDmBookYn());
		} else {
			// 원클릭 사이트 경우 통합홈페이지 데이터 전송
			eimsCustInfo.setEmailYn(memberDto.getCoreEmailYn());
			eimsCustInfo.setSmsYn(memberDto.getCoreSmsYn());
			eimsCustInfo.setDmYn(memberDto.getDmBookYn());
		}
		
		eimsCustInfo.setWeddingYn(memberDto.getWeddingYn());
		eimsCustInfo.setWeddingDay(memberDto.getWeddingDay());
	
		String[] childNames = memberDto.getChildName();
		if (childNames.length > 0) {
			if (StringUtil.isEmpty(childNames[0])) {
				eimsCustInfo.setChildNum(0);
			} else {
				eimsCustInfo.setChildNum(childNames.length);
			}
		}
		
		
		List<EimsChildrenInfo> childrens = new ArrayList<EimsChildrenInfo>();
		if (childNames.length > 0) {
			if (!StringUtil.isEmpty(childNames[0])) {
				for (int i=0; i<childNames.length; i++) {
					EimsChildrenInfo eimsChildrenInfo = new EimsChildrenInfo();
					eimsChildrenInfo.setChildName(childNames[i]);
					eimsChildrenInfo.setChildGender(memberDto.getChildGender()[i]);
					eimsChildrenInfo.setChildUnar(memberDto.getChildUnar()[i]);
					eimsChildrenInfo.setChildBirthday(memberDto.getChildBirthday()[i]);
					
					childrens.add(eimsChildrenInfo);
				}
				eimsCustInfo.setChildren(childrens);		
			}
		}
		
		return eimsCustInfo;
	}
	
	/**
	 * AccessToken 체크
	 * 
	 * @param accessToken
	 * @return custId accessToken으로 얻을 수 있는 custId
	 */
	public String checkAccessToken(String accessToken) {
		String custId = "";

		if (StringUtil.isEmpty(accessToken)) {
			logger.debug("accessToken is Mandatory Request!!");
			throw new UserHandleException(OneClickConstants.INVALID_ACCESS_TOKEN, OneClickConstants.INVALID_ACCESS_TOKEN_MSG);
		}
		try {
			TokenValue value = redisService.get(accessToken);
			if (value != null) {
				custId = value.getCustId();
			} else {
				logger.debug("accessToken(" + accessToken + ") is Not Available");
				throw new UserHandleException(OneClickConstants.INVALID_ACCESS_TOKEN, OneClickConstants.INVALID_ACCESS_TOKEN_MSG);
			}
		} catch (Exception e) {
			logger.debug("Error checkAccessToken accessToken : " + accessToken);
			throw new UserHandleException(OneClickConstants.INVALID_ACCESS_TOKEN, OneClickConstants.INVALID_ACCESS_TOKEN_MSG);
		}

		return custId;
	}

	@Override
	public CustInfo selectCustInfoByCustId(String custId) {
		return memberRepository.selectCustInfoByCustId(custId);
	}
	
	/**
	 *  비밀 번호 찾기 이메일 OR 문자 전송
	 */
	public String sendSearchPwdMailOrSms(String type, String webId, String pbpId, String tempPassword) {
		String returnValue = "";
		try {
			
			
			Map<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("eimsId", pbpId);
			paramMap.put("idDiv", "P");
			
			Gson gson = new Gson();
			String jsonParam = gson.toJson(paramMap);
	
			// EIMS_ getMemberInfo
			String jsonMemberInfo = GlobalUtil.makeHttpConnectionEims(eimsGetMemberInfoUrl, jsonParam);
			String resultCode = "";
			JSONObject obj = new JSONObject(jsonMemberInfo);
			resultCode = (String) obj.get("resultCode");
			
			if ("0".equals(resultCode)) {
				// EMAIL 발송
				if ("email".equals(type)) {
					returnValue = (String) obj.get("email");
					String name = (String) obj.get("membName");
					
					MemberDTO memberDto = new MemberDTO();
					memberDto.setWebId(webId);
					memberDto.setName(name);
					memberDto.setEmail(returnValue);
					memberDto.setTempPassword(tempPassword);
					
					emailService.sendEmail(memberDto, OneClickConstants.EMAIL_TEMPL_TYPE_TEMP_PASSWORD, "03");
					
				} 
				// SMS 발송
				else {
					
					returnValue = (String) obj.get("mobileNo");
					String name = (String) obj.get("membName");
					Object args[] = new Object[2];
					args[0] = name;
					args[1] = tempPassword;
					String msg = messageSource.getMessage("sms.temppwd.message", args, Locale.KOREA);
					logger.debug(msg);
					smsService.insertTblSubmitQueue(returnValue, msg);
				}
			}
			
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		return returnValue;
	}
	
	@Override
	public int getCustInfoCnt(String webId) {
		return memberRepository.getCustInfoCnt(webId);
	}
}
