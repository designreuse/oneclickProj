package com.eland.ngoc.member.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eland.ngoc.common.OneClickConstants;
import com.eland.ngoc.common.model.TokenValue;
import com.eland.ngoc.common.rules.ValidationRule;
import com.eland.ngoc.common.service.EmailService;
import com.eland.ngoc.common.service.RedisService;
import com.eland.ngoc.common.service.SmsService;
import com.eland.ngoc.common.service.token.TokenService;
import com.eland.ngoc.common.util.GlobalUtil;
import com.eland.ngoc.common.utils.CommonUtil;
import com.eland.ngoc.common.utils.StringUtil;
import com.eland.ngoc.exception.UserHandleException;
import com.eland.ngoc.member.model.AuthDtls;
import com.eland.ngoc.member.model.AutoLoginToken;
import com.eland.ngoc.member.model.CustInfo;
import com.eland.ngoc.member.model.CustSiteInfo;
import com.eland.ngoc.member.model.Ipin;
import com.eland.ngoc.member.model.Member;
import com.eland.ngoc.member.model.MemberDTO;
import com.eland.ngoc.member.model.MemberOutDTO;
import com.eland.ngoc.member.model.Pcc;
import com.eland.ngoc.member.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

	// logger 선언
    private final Logger logger = LoggerFactory.getLogger(MemberController.class);
    
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	TokenService tokenService;
	
	@Autowired
	EmailService emailService; 
	
	@Autowired
	SmsService smsService;
	
	@Autowired
	RedisService redisService;
	
	@Value("${phone.cert.id}")
	private String phoneCertId;
	
	@Value("${phone.cert.join.srvNo}")
	private String phoneJoinSrvNo;
	
	@Value("${phone.cert.join.retUrl}")
	private String phoneJoinRetUrl;
	
	@Value("${phone.cert.scId.srvNo}")
	private String phoneScIdSrvNo;
	
	@Value("${phone.cert.scId.retUrl}")
	private String phoneScIdRetUrl;
	
	@Value("${phone.cert.scPwd.srvNo}")
	private String phoneScPwdSrvNo;
	
	@Value("${phone.cert.scPwd.retUrl}")
	private String phoneScPwdRetUrl;
	
	@Value("${ipin.cert.id}")
	private String ipinCertId;
	
	@Value("${ipin.cert.join.srvNo}")
	private String ipinJoinSrvNo;
	
	@Value("${ipin.cert.join.retUrl}")
	private String ipinJoinRetUrl;
	
	@Value("${ipin.cert.scId.srvNo}")
	private String ipinScIdSrvNo;
	
	@Value("${ipin.cert.scId.retUrl}")
	private String ipinScIdRetUrl;
	
	@Value("${ipin.cert.scPwd.srvNo}")
	private String ipinScPwdSrvNo;
	
	@Value("${ipin.cert.scPwd.retUrl}")
	private String ipinScPwdRetUrl;
	
	@Value("${elandMall.searchAddr.host}")
	private String elandmallUrl;
	
	/**
	 * 아이디 찾기
	 * @return
	 */
	@RequestMapping(value="/findId", method=RequestMethod.GET)
    public String getFindId(HttpServletRequest request, Model model) {
		
		String siteCode = request.getParameter("siteCode");
		String returnUrl = request.getParameter("returnUrl");
		
		if (StringUtils.isEmpty(siteCode)) {
			request.getSession().setAttribute("siteCode", "30");
		} else {
			request.getSession().setAttribute("siteCode", siteCode);
		}
		model.addAttribute("returnUrl", returnUrl);
		
        return "/findId";
    }
	
	/**
	 * 패스워드 찾기
	 * @return
	 */
	@RequestMapping(value="/findPwd", method=RequestMethod.GET)
    public String getFindPwd(HttpServletRequest request, Model model) {
		
		String siteCode = request.getParameter("siteCode");
		String returnUrl = request.getParameter("returnUrl");
	
		if (StringUtils.isEmpty(siteCode)) {
			request.getSession().setAttribute("siteCode", "30");
		} else {
			request.getSession().setAttribute("siteCode", siteCode);
		}
		model.addAttribute("returnUrl", returnUrl);
        return "/findPwd";
    }
	
	/**
	 * 회원가입 - step1
	 * @return
	 */
	@RequestMapping(value="/joinMember", method=RequestMethod.GET)
    public String getJoinMember(HttpServletRequest request, Model model) {
		
		String siteCode = request.getParameter("siteCode");
		String joinReturnUrl = request.getParameter("returnUrl");
		String empJoinYn = request.getParameter("empJoinYn");
		
		if (StringUtils.isEmpty(siteCode)) {
			request.getSession().setAttribute("siteCode", "30");
		} else {
			request.getSession().setAttribute("siteCode", siteCode);
		}
		
		// 가입 요청한 사이트명 출력
		model.addAttribute("siteCode", siteCode);
		// 제휴사 리턴 URL
		request.getSession().setAttribute("joinReturnUrl", joinReturnUrl);
		// 임직원 여부
		request.getSession().setAttribute("empJoinYn", empJoinYn);
		
        return "/join_step1";
    }
	
	
	/**
	 * 회원가입 - step2
	 * @return
	 */
	@RequestMapping(value="/joinMemberStep2", method=RequestMethod.POST)
    public String getJoinMemberStep2(HttpServletRequest request, Model model) {
		
		try {
			model.addAttribute("siteCode", request.getSession().getAttribute("siteCode"));
			MemberDTO memberDto = (MemberDTO) request.getSession().getAttribute("memberDto");
			
			if (memberDto == null) {
				throw new UserHandleException(OneClickConstants.INVALID_ACCESS);
			}
			model.addAttribute("invalidAccess", false);
		} catch (UserHandleException ue) {
			model.addAttribute("invalidAccess", true);
		}
		
		return "/join_step2";

    }
	
	/**
	 * 회원가입 - step3
	 * @return
	 */
	@RequestMapping(value="/joinMemberStep3", method=RequestMethod.POST)
    public String getJoinMemberStep3(HttpServletRequest request
    		, @RequestParam(value="memberShipTerms",required = true) String memberShipTerms 
    		, @RequestParam(value="onlineTerms",required = true) String onlineTerms 
    		, @RequestParam(value="memberInfoTerms",required = true) String memberInfoTerms 
    		, @RequestParam(value="offerMemberInfoTerms",required = true) String offerMemberInfoTerms 
    		, Model model) {
		
		boolean isExistsMember = false;

		try {
			
			// 약관 정보 세션 저장
			MemberDTO memberDto = (MemberDTO) request.getSession().getAttribute("memberDto");
			
			if (memberDto == null) {
				throw new UserHandleException(OneClickConstants.INVALID_ACCESS);
			}
			
			memberDto.setMemberShipTerms(memberShipTerms);
			memberDto.setOnlineTerms(onlineTerms);
			memberDto.setMemberInfoTerms(memberInfoTerms);
			memberDto.setOfferMemberInfoTerms(offerMemberInfoTerms);
			
			
			String custName = memberDto.getName();
			String birth = memberDto.getBirth().replaceAll("-", "");
			String phoneNumber = memberDto.getPhone();
			
			model.addAttribute("siteCode", request.getSession().getAttribute("siteCode"));
			model.addAttribute("userName", custName);
			model.addAttribute("birth", birth);
			model.addAttribute("phoneNumber", phoneNumber);
			
			// EIMS 회원정보 유무 확인
			String ci = memberDto.getCi();
			Member existsMemberInfo = memberService.getMemberInfo("", ci);
			
			if (existsMemberInfo.getPbpId() != null) {
				isExistsMember = true;
				memberDto.setPbpId(existsMemberInfo.getPbpId());
			}
			
			request.getSession().setAttribute("memberDto", memberDto);
			request.getSession().setAttribute("isExistsMember", isExistsMember);
			model.addAttribute("isExistsMember", isExistsMember);
			model.addAttribute("existsMemberInfo", existsMemberInfo);
			model.addAttribute("invalidAccess", false);
		} catch (UserHandleException ue) {
			model.addAttribute("invalidAccess", true);
			model.addAttribute("isExistsMember", isExistsMember);
		} catch (Exception e) { 
			logger.debug(e.getMessage());
			return "errors/404";
		}
		
		
        return "/join_step3";
    }
	
	/**
	 * 회원가입 완료
	 * @return
	 */
	@RequestMapping(value="/joinMemberSuccess", method=RequestMethod.POST)
    public String joinMemberSuccess(HttpServletRequest request, MemberDTO memberDto, Model model) {
		
		try {
			
			// 리턴페이지 이동후 백이동시 재저장 되는 오류 막기
			// DB 저장 여부 확인
			int cnt = memberService.getCustInfoCnt(memberDto.getWebId());
			if (cnt > 0) {
				throw new UserHandleException(OneClickConstants.INVALID_ACCESS);
			}
			
			MemberDTO sessionMemberDTO= (MemberDTO) request.getSession().getAttribute("memberDto");
			String siteCode = CommonUtil.getSessionSiteCode(request);
			boolean isExistsMember = (boolean) request.getSession().getAttribute("isExistsMember");
			
			if (isExistsMember) {
				memberDto.setPbpId(sessionMemberDTO.getPbpId());
			}
			
			memberDto.setMemberShipTerms(sessionMemberDTO.getMemberShipTerms());
			memberDto.setMemberInfoTerms(sessionMemberDTO.getMemberInfoTerms());
			memberDto.setOnlineTerms(sessionMemberDTO.getOnlineTerms());
			memberDto.setOfferMemberInfoTerms(sessionMemberDTO.getOfferMemberInfoTerms());
			
			// ci, di, 외국인 여부 저장
			memberDto.setCi(sessionMemberDTO.getCi());
			memberDto.setDi(sessionMemberDTO.getDi());
			memberDto.setNationality(sessionMemberDTO.getNationality());
			memberDto.setGender(sessionMemberDTO.getGender());
			
			// 회원정보 저장
			String custId = memberService.saveMemberInfo(memberDto, siteCode, isExistsMember);
			String joinReturnUrl = "";
		
			String accessToken = tokenService.createToken(siteCode, custId, 0);
			if (!"30".equals(siteCode)) {
				joinReturnUrl = (String) request.getSession().getAttribute("joinReturnUrl");
				
				if (joinReturnUrl.contains("?")) {
					joinReturnUrl += "&accessToken=" + accessToken;
				} else {
					joinReturnUrl += "?accessToken=" + accessToken;
				}
			}
			
			// 가입 요청한 사이트명 출력
			model.addAttribute("siteCode", siteCode);
			model.addAttribute("joinReturnUrl", joinReturnUrl);
			model.addAttribute("invalidAccess", false);
			
			// 세션의 회원정보 삭제
			request.getSession().removeAttribute("memberDto");
		} catch (UserHandleException ue) {
			// model
			model.addAttribute("invalidAccess", true);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "errors/404";
		}
		
        return "/joinMemberSuccess";
    }
	
	
	/**
	 *  지번 주소찾기 팝업
	 * @return
	 */
	@RequestMapping(value="/searchAddrPopup", method=RequestMethod.GET)
    public String searchAddrPopup(HttpServletRequest request, Model model) {
		model.addAttribute("elandmallUrl", elandmallUrl);
        return "/searchAddrPopup";
    }
	
	/**
	 *  도로명 주소찾기 팝업
	 * @return
	 */
	@RequestMapping(value="/searchRoadAddrPopup", method=RequestMethod.GET)
	public String searchRoadAddrPopup(HttpServletRequest request, Model model) {
		model.addAttribute("elandmallUrl", elandmallUrl);
		return "/searchRoadAddrPopup";
	}
	
	/**
	 *  상세 주소 입력 팝업
	 * @return
	 */
	@RequestMapping(value="/inputAddrDetailPopup", method=RequestMethod.GET)
	public String inputAddrDetail(HttpServletRequest request, Model model
			, @RequestParam(value="isRoadAddr",required = true) Boolean isRoadAddr
			, @RequestParam(value="postNo",required = true) String postNo
			, @RequestParam(value="addr",required = true) String addr) {
		
		model.addAttribute("isRoadAddr", isRoadAddr);
		model.addAttribute("postNo", postNo);
		model.addAttribute("addr", addr);
		return "/inputAddrDetailPopup";
	}
	
	/**
	 *  상세 주소 입력 팝업
	 * @return
	 */
	@RequestMapping(value="/selectAddrPopup", method=RequestMethod.GET)
	public String selectAddress(HttpServletRequest request, Model model
			, @RequestParam(value="isRoadAddr",required = true) String isRoadAddr
			, @RequestParam(value="postNo",required = true) String postNo
			, @RequestParam(value="addr",required = true) String addr
			, @RequestParam(value="addrDetail",required = true) String addrDetail) {
		
		model.addAttribute("isRoadAddr", isRoadAddr);
		model.addAttribute("postNo", postNo);
		model.addAttribute("addr", addr);
		model.addAttribute("addrDetail", addrDetail);
		model.addAttribute("elandmallUrl", elandmallUrl);
		return "/selectAddrPopup";
	}
	
	
	/**
	 * 
	 *  아이디 중복 체크
	 *  
	 * @param request
	 * @param model
	 * @param webId
	 */
	@RequestMapping(value="/isCheckId", method= RequestMethod.GET, produces = {"application/json"})
	@ResponseBody
	public ModelMap duplicateCheckId(HttpServletRequest request, Model model
			, @RequestParam(value="webId",required = true) String webId
			, @RequestParam(value="checkType",required = false) String checkType) {
		
		boolean isDuplicateId = memberService.isCheckId(webId, checkType);
		logger.debug(""+isDuplicateId);
		
		ModelMap map = new ModelMap();
		map.addAttribute("isCheckId", isDuplicateId);
		return map;
	}
	
	
	/**
	 * 회원정보 수정
	 * 
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/updateMember", method={RequestMethod.GET, RequestMethod.POST})
	public String updateMember(Model model, HttpServletRequest request) throws Exception {
		try {
			String webId = "";
			String membState = "";
			
			/*
			 * 1. 통합몰, 통합홈페이지 통해서 들어온 경우, accessToken & authorization 유효성 체크함
			 *  -> site 체크 먼저 해서 분기 처리함.
			 * 2. 원클릭 로그인 한 경우, session에 custInfo 존재하는지 체크 
			 */
			
			// authorization과 parameter로 넘어온 siteCode 비교하여 사이트 체크하고 분기 처리
			String siteCode = request.getParameter("siteCode");
			if (StringUtil.isEmpty(siteCode)) {
				siteCode = (String)request.getSession().getAttribute("destSiteCode");
				if (StringUtil.isEmpty(siteCode)) {
					siteCode = OneClickConstants.ONECLICK_SITE_CODE;
				}
			}
			String authorization = request.getParameter("authorization");
			if (StringUtil.isEmpty(authorization)) {
				authorization = GlobalUtil.makeAuthorization(OneClickConstants.ONECLICK_ID);
			}
			String siteCodeFromAuth = CommonUtil.checkAuthorizationAjax(authorization);
			if (!siteCode.equals(siteCodeFromAuth)) {
				logger.debug("siteCode is Not Matched_ siteCode: " + siteCode + ", siteCode from Authorization: " + siteCodeFromAuth);
				return "errors/404";			
			} 				
			// 통합몰 & 통합홈페이지
			// TODO: 사이트 추가될 경우 if절에 조건 추가 해야함
			if (siteCodeFromAuth.equals(OneClickConstants.ELAND_RETAIL_MALL_SITE_CODE)
					|| siteCodeFromAuth.equals(OneClickConstants.ECORE_SITE_CODE)) {
				membState = request.getParameter("membState");
				
				// accessToken과 parameter로 넘어온 webId 비교하여 고객 체크
				String accessToken = request.getParameter("accessToken");
				
				if (StringUtil.isNotEmpty(accessToken)) {
					TokenValue value = redisService.get(accessToken);
					if (value != null) {
						String custId = value.getCustId();
						CustInfo custInfo = memberService.selectCustInfoByCustId(custId);					
						if (StringUtil.isEmpty(custInfo.getWebId())) {
							logger.debug("accessToken(" + accessToken + ") is Not Available");
							return "errors/404";
						} else {
							webId = custInfo.getWebId();
						}
					} else {
						logger.debug("accessToken(" + accessToken + ") is Not Available");
						return "errors/404";
					}
				} else {
					logger.debug("accessToken is NULL");
					return "errors/404";
				}
			
			// 원클릭
			} else if (siteCodeFromAuth.equals(OneClickConstants.ONECLICK_SITE_CODE)) {
				CustInfo sessionCustInfo = (CustInfo)request.getSession().getAttribute("CustInfo");
				if (StringUtil.isEmpty(String.valueOf(sessionCustInfo.getCustId()))) {
					logger.debug("CustInfo(from Session) is NULL");
					return "errors/404";
				}
				webId = sessionCustInfo.getWebId();					
				membState = sessionCustInfo.getCustStat();					
			}

			Member memberInfo = memberService.getMemberInfo(webId, "");
			// EIMS에서 조회 가능한, 필수 정보인 생년월일 존재 여부로 EIMS와의 연동 확인
			if (StringUtil.isEmpty(memberInfo.getBirthYear())) {
				throw new UserHandleException(OneClickConstants.INVALID_PBP_ID, OneClickConstants.INVALID_PBP_ID_MSG);
			}
			memberInfo.setMembState(membState);
			
			// 가입한 사이트만 마케팅 수신 동의 수정 가능하도록, 사이트 가입 여부 확인
			// TODO : 사이트 추가되면 로직 수정 해야함
			if (StringUtils.isNotEmpty(memberInfo.getRetailMallEmailYn())) {
				model.addAttribute("retailMallJoinYn", true);
			} else {
				model.addAttribute("retailMallJoinYn", false);
			}
			if (StringUtils.isNotEmpty(memberInfo.getCoreEmailYn())) {
				model.addAttribute("coreJoinYn", true);
			} else {
				model.addAttribute("coreJoinYn", false);
			}
			
			model.addAttribute("memberInfo", memberInfo);
			model.addAttribute("siteCode", siteCode);
			model.addAttribute("returnUrl", (String)request.getSession().getAttribute("returnUrl"));
			
		} catch (UserHandleException e) {
			logger.debug(e.getMessage());
			return "errors/404";
		} catch (Exception e) {
			logger.debug(e.getMessage());
			return "errors/404";
		}
		
		return "/updateMember";
	}
	
	/**
	 * 회원 정보 수정 - 기존 비밀번호 유효성 체크
	 * 
	 * @param custId
	 * @param inputOldPassword
	 * @return
	 */
	@RequestMapping(value="/checkOldPwd", method= RequestMethod.GET, produces = {"application/json"})
	@ResponseBody
	public ModelMap checkOldPwd(@RequestParam(value="custId", required=true)String custId, 
			@RequestParam(value="inputOldPassword", required=true)String inputOldPassword) {
		ModelMap map = new ModelMap();
		
		String encodedPWD = CommonUtil.encyriptSHA256(inputOldPassword);		
		String oldPassword = memberService.getMemberPwd(custId);
		
		if (encodedPWD.equals(oldPassword)) {
			map.addAttribute("isMatched", true);
		} else {
			map.addAttribute("isMatched", false);
		}
		
		return map;
	}
	
	/**
	 * 회원 정보 수정 - 변경 비밀번호 중복 체크
	 * 
	 * @param custId
	 * @param inputPassword
	 * @return
	 */
	@RequestMapping(value="/checkbfUsedPwd", method= RequestMethod.GET, produces = {"application/json"})
	@ResponseBody
	public ModelMap checkbfUsedPwd(@RequestParam(value="custId", required=true)String custId, 
			@RequestParam(value="inputPassword", required=true)String inputPassword) {
		ModelMap map = new ModelMap();
		
		String encodedPWD = CommonUtil.encyriptSHA256(inputPassword);		
		String bfUsedPwd = memberService.getMemberUsedPwd(custId);
		
		if (encodedPWD.equals(bfUsedPwd)) {
			map.addAttribute("alreadyUsed", true);
		} else {
			map.addAttribute("alreadyUsed", false);
		}
		
		return map;
	}
	
	/**
	 * 회원정보 수정 완료
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/updateMemberSuccess", method=RequestMethod.POST)
	public String updateInfoComplete(Model model, HttpServletRequest request, MemberDTO memberDto, CustSiteInfo custSiteInfo) {
		try {
			
			// CUST_INFO 업데이트
			memberService.txUpdateMember(memberDto, custSiteInfo);
			
			model.addAttribute("returnUrl", (String)request.getSession().getAttribute("returnUrl"));
			model.addAttribute("currentSiteCode", memberDto.getCurrentSiteCode());	
			
			// AccessToken 생성
			if (!"30".equals(memberDto.getCurrentSiteCode())) {
				String siteId = CommonUtil.getSiteId(memberDto.getCurrentSiteCode());
				String accessToken = tokenService.createToken(siteId, memberDto.getCustId(), 0);
				model.addAttribute("accessToken", accessToken);
			}
			
		} catch (Exception e) {
			logger.debug(e.getMessage());
			return "errors/404";
		}
		
		return "/updateMemberSuccess";
	}

	/**
	 *  휴대폰 인증시 ajax로 PCC에서 필요한 데이터 세팅
	 * @return
	 */
	@RequestMapping(value="/setPccInfo", method=RequestMethod.GET)
	@ResponseBody
	public Pcc setPccInfo(HttpServletRequest request, HttpServletResponse response) {

		String srvType = request.getParameter("srvType");
		String receiveType = request.getParameter("receiveType");
		String searchId = request.getParameter("searchId");
		
		String srvNo = "";
		String returnUrl = "";
		if (srvType.equals("join")) {
			srvNo = phoneJoinSrvNo;
			returnUrl = phoneJoinRetUrl;
		} else if (srvType.equals("scId")) {
			srvNo = phoneScIdSrvNo;
			returnUrl = phoneScIdRetUrl;
		} else if (srvType.equals("scPwd")) {
			srvNo = phoneScPwdSrvNo;
			returnUrl = phoneScPwdRetUrl;
			request.getSession().setAttribute("searchId", searchId);
			request.getSession().setAttribute("receiveType", receiveType);
		}
		Pcc pcc = memberService.setPcc(phoneCertId, srvNo, returnUrl);
		
		Cookie c = new Cookie("reqNum", pcc.getReqPccNum() + ", pcc");
		// c.setMaxAge(600); // <==초단위로 설정됩니다.
		// c.setSecure(true);
		response.addCookie(c);
		return pcc;
	}
	
	/**
	 *  아이핀 인증시 ajax로 PCC에서 필요한 데이터 세팅
	 * @return
	 */
	@RequestMapping(value="/setIpinInfo", method=RequestMethod.GET)
	@ResponseBody
	public Ipin setIpinInfo(HttpServletRequest request, HttpServletResponse response) {
		
		String srvType = request.getParameter("srvType");
		String receiveType = request.getParameter("receiveType");
		String searchId = request.getParameter("searchId");
		
		String srvNo = "";
		String returnUrl = "";
		if (srvType.equals("join")) {
			srvNo = ipinJoinSrvNo;
			returnUrl = ipinJoinRetUrl;
		} else if (srvType.equals("scId")) {
			srvNo = ipinScIdSrvNo;
			returnUrl = ipinScIdRetUrl;
		} else if (srvType.equals("scPwd")) {
			srvNo = ipinScPwdSrvNo;
			returnUrl = ipinScPwdRetUrl;
			request.getSession().setAttribute("searchId", searchId);
			request.getSession().setAttribute("receiveType", receiveType);
		}
		Ipin ipin = memberService.setIpin(ipinCertId, srvNo, returnUrl);
		logger.debug("reqNum="+ ipin.getReqIpinNum());
		Cookie c = new Cookie("reqNum", ipin.getReqIpinNum() + ", ipin");
		// c.setMaxAge(600); // <==초단위로 설정됩니다.
		// c.setSecure(true);
		response.addCookie(c);
		return ipin;
	}
	
	/**
	 * 본인인증 gate 페이지 
	 * 
	 * <p/>
	 * 
	 */
	@RequestMapping(value="/authResultPopup")
	public String authResultPopup(Model model, HttpServletRequest request) throws Exception{
		
		//쿠키값 가져 오기
		String[] reqNum = CommonUtil.getCookieReqNum(request);
		String retInfo = request.getParameter("retInfo");
		
		String siteCode = CommonUtil.getSessionSiteCode(request);
		AuthDtls authDtls = new AuthDtls();
		Pcc pcc;
		Ipin ipin;
		String ci = "";
		String di = "";
		String gender= "";
		String custName = "";
		String foreignerYn = "N";
		String birth = "";
		String phoneNumber = "";
		// 만 14세 가입 제한 체크
		boolean isUnderFourteen = false;
		
		if (reqNum[1].trim().equals("pcc")) {
			pcc = memberService.getPcc(reqNum[0], retInfo);
			ci = pcc.getCi1();
			di = pcc.getDi();
			custName = pcc.getName();
			gender = pcc.getSex();
			birth = pcc.getBirYMD();
			phoneNumber = pcc.getCellNo();
			// 1-내국인, 2-외국인
			if ("2".equals(pcc.getFgnGbn())) {
				foreignerYn = "Y";
			}
			
			authDtls.setCi(pcc.getCi1());
			authDtls.setDi(pcc.getDi());
			authDtls.setCustName(pcc.getName());
			authDtls.setSiteCode(siteCode);
			authDtls.setAuthTypeDiv("SMS");
			
			isUnderFourteen = CommonUtil.checkUnderFourTeen(pcc.getBirYMD());
		} else {
			ipin = memberService.getIpin(reqNum[0], retInfo);
			ci = ipin.getCiscrhash();
			di = ipin.getDiscrhash();
			custName = ipin.getName();
			gender = ipin.getSex();
			birth = ipin.getBirthday();
			// 0:내국인, 1:외국인
			if ("1".equals(ipin.getFgn())) {
				foreignerYn = "Y";
			}
			
			authDtls.setCi(ipin.getCiscrhash());
			authDtls.setDi(ipin.getDiscrhash());
			authDtls.setCustName(ipin.getName());
			authDtls.setSiteCode(siteCode);
			authDtls.setAuthTypeDiv("IPIN");
			
			isUnderFourteen = CommonUtil.checkUnderFourTeen(ipin.getBirth());
		}
		// 본인인증 내역 저장
		memberService.insertAuthDtls(authDtls);
		
		// CI(DI) & 이름 값으로 회원정보 조회
		CustInfo custInfo = memberService.getFindMemberInfo(ci, custName);
		Boolean isMember = false;
		Boolean thirtyCheck = false;
		String custStat = "";
		
		// 이미 가입한 회원 여부 체크 및 탈퇴후 재가입 여부 체크(30일)
		if (custInfo != null) {
			isMember = true;
			custStat = custInfo.getCustStat();
			if ("N".equals(custInfo.getJoinYn())) {
				thirtyCheck = false;
			} else {
				thirtyCheck = true;
			}
		} 
		
		MemberDTO memberDto = new MemberDTO();
		memberDto.setName(custName);
		memberDto.setCi(ci);
		memberDto.setDi(di);
		memberDto.setNationality(foreignerYn);
		memberDto.setGender(gender);
		memberDto.setPhone(phoneNumber);
		memberDto.setBirth(birth);
		
		request.getSession().setAttribute("memberDto", memberDto);
				
		model.addAttribute("retInfo", request.getParameter("retInfo"));
		model.addAttribute("reqNum", reqNum[0]);
		model.addAttribute("isMember", isMember);
		model.addAttribute("isReJoin", thirtyCheck);
		model.addAttribute("custStat", custStat);
		model.addAttribute("isUnderFourteen", isUnderFourteen);
		
		return "/authResultPopup";
		
	}
	
	/**
	 * ID 찾기 본인인증 완료 
	 * 
	 * <p/>
	 * 
	 */
	@RequestMapping(value="/idScResultPopup")
	public String idScResultPopup(Model model, HttpServletRequest request) throws Exception{
		
		String retInfo = request.getParameter("retInfo");
		String[] reqNum = CommonUtil.getCookieReqNum(request);
		
		String siteCode = CommonUtil.getSessionSiteCode(request);
		AuthDtls authDtls = new AuthDtls();
		Pcc pcc;
		Ipin ipin;
		String ci = "";
		String custName = "";
		if (reqNum[1].trim().equals("pcc")) {
			pcc = memberService.getPcc(reqNum[0], retInfo);
			ci = pcc.getCi1();
			custName = pcc.getName();
			
			authDtls.setCi(pcc.getCi1());
			authDtls.setDi(pcc.getDi());
			authDtls.setCustName(pcc.getName());
			authDtls.setSiteCode(siteCode);
			authDtls.setAuthTypeDiv("SMS");
		} else {
			ipin = memberService.getIpin(reqNum[0], retInfo);
			ci = ipin.getCiscrhash();
			custName = ipin.getName();
			
			authDtls.setCi(ipin.getCiscrhash());
			authDtls.setDi(ipin.getDiscrhash());
			authDtls.setCustName(ipin.getName());
			authDtls.setSiteCode(siteCode);
			authDtls.setAuthTypeDiv("IPIN");
		}
		
		// 본인인증 내역 저장
		memberService.insertAuthDtls(authDtls);
		
		// CI(DI) & 이름 값으로 회원정보 조회
		CustInfo custInfo = memberService.getFindMemberInfo(ci, custName);
		Boolean isMember = true; 
		if (custInfo != null) {
			model.addAttribute("webId", custInfo.getWebId());
		} else {
			isMember = false;
		}
		
		model.addAttribute("isMember", isMember);
		
		return "/idScResultPopup";
		
	}
	
	/**
	 * 비밀번호 찾기 본인인증 완료 
	 * 
	 * <p/>
	 * 
	 */
	@RequestMapping(value="/pwdScResultPopup")
	public String pwdScResultPopup(Model model, HttpServletRequest request) throws Exception{
		
		String retInfo = request.getParameter("retInfo");
		String[] reqNum = CommonUtil.getCookieReqNum(request);
		
		String siteCode = CommonUtil.getSessionSiteCode(request);
		AuthDtls authDtls = new AuthDtls();
		Pcc pcc;
		Ipin ipin;
		String ci = "";
		String custName = "";
		String phoneNumber = "";
		String email = "";
		if (reqNum[1].trim().equals("pcc")) {
			pcc = memberService.getPcc(reqNum[0], retInfo);
			ci = pcc.getCi1();
			custName = pcc.getName();
			phoneNumber = pcc.getCellNo();
			
			authDtls.setCi(pcc.getCi1());
			authDtls.setDi(pcc.getDi());
			authDtls.setCustName(pcc.getName());
			authDtls.setSiteCode(siteCode);
			authDtls.setAuthTypeDiv("SMS");
		} else {
			ipin = memberService.getIpin(reqNum[0], retInfo);
			ci = ipin.getCiscrhash();
			custName = ipin.getName();
			authDtls.setCi(ipin.getCiscrhash());
			authDtls.setDi(ipin.getDiscrhash());
			authDtls.setCustName(ipin.getName());
			authDtls.setSiteCode(siteCode);
			authDtls.setAuthTypeDiv("IPIN");
		}
		
		// 본인인증 내역 저장
		memberService.insertAuthDtls(authDtls);
		
		
		// CI(DI) & 이름 값으로 회원정보 조회
		CustInfo custInfo = memberService.getFindMemberInfo(ci, custName);
		String receiveType = (String)request.getSession().getAttribute("receiveType");
		String searchId = (String)request.getSession().getAttribute("searchId");
		Boolean isMember = true;
		String tempPassword = "";
		if (custInfo != null) {
			if (searchId.equals(custInfo.getWebId())) {
				model.addAttribute("webId", custInfo.getWebId());
				// 임시 비밀번호 생성
				tempPassword = CommonUtil.temporaryPassword();
				
				// 메일 발송 OR SMS 발송
				email =	memberService.sendSearchPwdMailOrSms(receiveType, custInfo.getWebId(), custInfo.getPbpId(), tempPassword);
				
			} else {
				isMember = false;
			}
		} else {
			isMember = false;
		}
		
		if (isMember) {
			// cust_info 테이블에 tempPassword, TEMP_PWD_YN 업데이트
			memberService.updateMemberStat(String.valueOf(custInfo.getCustId()), null, CommonUtil.encyriptSHA256(tempPassword), "Y");
		}
		
		model.addAttribute("isMember", isMember);
		
		model.addAttribute("receiveType", receiveType);
		model.addAttribute("email", email);		
		model.addAttribute("phoneNumber", phoneNumber);		
		return "/pwdScResultPopup";
		
	}
	
	/**
	 * 회원 탈퇴
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/memberOut", method={RequestMethod.GET, RequestMethod.POST})
	public String memberOut(Model model, HttpServletRequest request) {
		try {
			// 탈퇴 요청은 무조건 로그인 하도록 구성됨 -> session에 정보 있음
			CustInfo custInfo = (CustInfo)request.getSession().getAttribute("CustInfo");
			model.addAttribute("webId", custInfo.getWebId());
			
			String siteCode = (String)request.getSession().getAttribute("destSiteCode");
			if (StringUtil.isEmpty(siteCode)) {
				siteCode = OneClickConstants.ONECLICK_SITE_CODE;
			}
			model.addAttribute("siteCode", siteCode);
			
		} catch (Exception e) {
			logger.debug(e.getMessage());
			return "errors/404";
		}
		
		return "/secession_step1";
	}
	
	/**
	 * 회원 탈퇴 - STEP2
	 * 
	 * @param model
	 * @param request
	 * @param webId
	 * @param siteCode
	 * @return
	 */
	@RequestMapping(value="/memberOutStep2", method=RequestMethod.POST)
	public String memberOutStep2(Model model, HttpServletRequest request, 
			@RequestParam(value="webId", required=true)String webId,
			@RequestParam(value="siteCode", required=true) String siteCode,
			@RequestParam(value="selectMenu", required=true) String selectMenu) {
		
		try {		
			model.addAttribute("webId", webId);
			model.addAttribute("siteCode", siteCode);
			model.addAttribute("selectMenu", selectMenu);
			logger.debug("outSelectMenu: " + selectMenu);
			
			// 가입한 사이트만 탈퇴 선택 가능하도록, 사이트 가입 여부 확인
			// TODO : 사이트 추가되면 로직 수정 해야함
			Member memberInfo = memberService.getMemberInfo(webId, "");
			if (StringUtils.isNotEmpty(memberInfo.getRetailMallEmailYn())) {
				model.addAttribute("retailMallJoinYn", true);
			} else {
				model.addAttribute("retailMallJoinYn", false);
			}
			if (StringUtils.isNotEmpty(memberInfo.getCoreEmailYn())) {
				model.addAttribute("coreJoinYn", true);
			} else {
				model.addAttribute("coreJoinYn", false);
			}
		} catch (Exception e) {
			logger.debug(e.getMessage());
			return "errors/404";
		}
		
		return "/secession_step2";
	}
	
	/**
	 * 회원 탈퇴 완료
	 * 
	 * @param model
	 * @param request
	 * @param memberOutDto
	 * @return
	 */
	@RequestMapping(value="/memberOutSuccess", method=RequestMethod.POST)
	public String memberOutSuccess(Model model, HttpServletRequest request, MemberOutDTO memberOutDto) {
		try {
			// CUST_OUT 데이터 등록을 위해 custId, pbpId 조회
			Map<String, String> idMap = memberService.getCustnPbpId(memberOutDto.getWebId());
			memberOutDto.setCustId(String.valueOf(idMap.get("CUST_ID")));
			memberOutDto.setPbpId(String.valueOf(idMap.get("PBP_ID")));
			
			// CUST_OUT_DTLS, CUST_OUT_RSON 업데이트
			String siteCode = memberOutDto.getSiteCode();
			model.addAttribute("siteCode", siteCode);
			model.addAttribute("custStat", memberOutDto.getCustStat());
			model.addAttribute("selectMenu", memberOutDto.getSelectMenu());
			
			memberService.txOutMember(memberOutDto);
						
			// AccessToken 생성
			if (!"30".equals(siteCode) && !"40".equals(siteCode)) {
				String siteId = CommonUtil.getSiteId(siteCode);
				String accessToken = tokenService.createToken(siteId, memberOutDto.getCustId(), 300);
				model.addAttribute("returnUrl", (String) request.getSession().getAttribute("returnUrl"));
				model.addAttribute("accessToken", accessToken);
			}	
		} catch (Exception e) {
			logger.debug(e.getMessage());
			return "errors/404";
		}
		
		return "/secessionSuccess";
	}
	
	/**
	 * 회원 상태별 팝업
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/infoPopup")
	public String infoPopup(Model model, HttpServletRequest request) {
		
		String siteCode = CommonUtil.getSessionSiteCode(request);
		
		model.addAttribute("membState", request.getParameter("membState"));
		model.addAttribute("webId", request.getParameter("webId"));
		model.addAttribute("accessToken", request.getParameter("accessToken"));
		model.addAttribute("siteCode", siteCode == null ? "30":siteCode);
		model.addAttribute("Authorization", GlobalUtil.makeAuthorization(OneClickConstants.ONECLICK_ID));
		return "/infoPopup";
	}
	
	/**
	 *  AJAX 로그인
	 * @return
	 */
	@RequestMapping(value="/loginAjax", produces = {"application/json"})
	@ResponseBody
	public ModelMap login(HttpServletRequest request, HttpServletResponse response) {
		
		String siteCode = "";
		String membState = "";
		String newLoginToken = "";
		String newALoginUid = "";
		String accessToken = "";
		String resultCode = "0";
		String errorCode = "0";
		String errorMsg = "";
		String custId = "";
		
		try {
			// Request Parameter
			String authorization = request.getParameter("authorization");
			String webId = request.getParameter("webId");
			String webPwd = request.getParameter("webPwd");
			String autoLoginYn = request.getParameter("autoLoginYn");
			String aLoginUid = request.getParameter("aLoginUid");
			String loginToken = request.getParameter("loginToken");
			String txDiv = request.getParameter("txDiv");
			String reqAccessToken = request.getParameter("accessToken");
			String emailYn = request.getParameter("emailYn");
			String smsYn = request.getParameter("smsYn");
			String dmYn = request.getParameter("dmYn");
			
			// authorization Valdation
			if (authorization != null) {
				siteCode = CommonUtil.checkAuthorizationAjax(authorization);
				if (StringUtil.isEmpty(siteCode)) {
					throw new UserHandleException(OneClickConstants.INVALID_AUTHORIZATION, OneClickConstants.INVALID_AUTHORIZATION_MSG);
				}
			} else { 
				throw new UserHandleException(OneClickConstants.INVALID_AUTHORIZATION, OneClickConstants.INVALID_AUTHORIZATION_MSG);
			}
			
			// Reqeust Parameter Validation
			ValidationRule validationRule = new ValidationRule();
			validationRule.isValidParameter(request);
			
			CustInfo custInfo = new CustInfo();
			Map<String, String> autoLoginMap = new HashMap<String, String>(); 
			
			// 자동 로그인 처리
			if (!StringUtil.isEmpty(aLoginUid) && !StringUtil.isEmpty(loginToken)) {
				autoLoginMap = memberService.autoLogin(aLoginUid, loginToken);
				newLoginToken = autoLoginMap.get("newLoginToken");
				custId = autoLoginMap.get("custId");
			} 
			else if (StringUtil.isNotEmpty(txDiv) && StringUtil.isNotEmpty(reqAccessToken)) {
				// AccessToken validation
				custId = memberService.checkAccessToken(reqAccessToken);

				custInfo = memberService.selectCustInfoByCustId(custId);
				// 휴면 해제 처리
				if ("RR".equals(txDiv)) {
					memberService.termiteDormancy(custId, siteCode);
				} 
				// 부부탈퇴 취소 처리
				else if ("CO".equals(txDiv)) {
					memberService.cancelSecession(custId, emailYn, smsYn, dmYn, siteCode);
				} 
				// 사이트 추가 처리
				else if ("AS".equals(txDiv)) {
					// siteInfo 테이블 인서트
					memberService.addSite(custId, emailYn, smsYn, dmYn, siteCode);
				}
			}
			
			// 일반 로그인 처리
			else {
				// 회원 정보 조회 
				custInfo = memberService.selectCustInfoCheck(webId, webPwd);
				if (custInfo == null) {
					// 존재하지 않은 아이디
					throw new UserHandleException(OneClickConstants.INVALID_WEB_ID, OneClickConstants.INVALID_WEB_ID_MSG);
				}
				
				if ("N".equals(custInfo.getValidPwd())) {
					// 잘못된 비밀번호 입력
					throw new UserHandleException(OneClickConstants.INVALID_PASSWORD, OneClickConstants.INVALID_PASSWORD_MSG);
				}
				custId = String.valueOf(custInfo.getCustId());
			}
			
			// 회원상태 조회(정상, 탈퇴, 휴면, 계정잠금, 탈퇴사이트 로그인, 미가입사이트 로그인, 장기비밀번호 미변경, 임시 비밀번호 로그인
			membState = memberService.selectCustStateInfo(custId, siteCode);
			
			
			// 자동 로그인 여부에 따라 자동로그인 처리(자동로그인UID, loginToken 생성)
			if (!StringUtil.isEmpty(autoLoginYn)) {
				if ("Y".equals(autoLoginYn)) {
					AutoLoginToken autoLoginToken = memberService.saveAutoLoginToken(webId);
					newALoginUid = autoLoginToken.getAlUid();
					newLoginToken = autoLoginToken.getLoginToken();
				}
			}
			
			// 최종 로그인 정보 insert OR update
			memberService.saveLastLoginHistory(custId, siteCode);
			
			// AccessToken 토큰 생성
			accessToken = tokenService.createToken(siteCode, custId, 300);
			
			// 회원정보 세션 저장
			if ("30".equals(siteCode)) {
				if ("10".equals(membState) || "40".equals(membState) || "60".equals(membState) || "70".equals(membState) || "80".equals(membState)) {
					request.getSession().setAttribute("CustInfo", custInfo);
				}
			} else {
				if ("10".equals(membState)) {
					request.getSession().setAttribute("CustInfo", custInfo);
				}
			}
			
		} catch(UserHandleException ue) {
			logger.debug(OneClickConstants.RESULT_FAIL);
			logger.debug(ue.getMessage());
			logger.debug(ue.getArgs());
			resultCode = OneClickConstants.RESULT_FAIL;
			errorCode = ue.getMessage();
			String errorParam = ue.getArgs();
			errorMsg = ue.getMsgDesc();
			
			// 자동로그인 토큰 맞지 않을시 자동로그인정보 전체 삭제
			if (OneClickConstants.INVALID_AUTO_LOGIN_TOKEN.equals(errorCode)) {
				memberService.deleteAutoLoginToken(errorParam);
			}
			
		} catch (Exception e) {
			resultCode = OneClickConstants.RESULT_FAIL;
			e.printStackTrace();
		}
		
		response.setHeader("Access-Control-Allow-Origin", "*");
		// Response
		ModelMap map = new ModelMap();
		map.addAttribute("resultCode", resultCode);
		map.addAttribute("errorCode", errorCode);
		map.addAttribute("errorMsg", errorMsg);
		map.addAttribute("accessToken", accessToken);
		map.addAttribute("aLoginUid", newALoginUid);
		map.addAttribute("loginToken", newLoginToken);
		map.addAttribute("membState", membState);
		
		return map;
	}
	
	/**
	 *  비밀번호변경 연장 처리
	 * @return
	 */
	@RequestMapping(value="/extendPwdChangeAjax", produces = {"application/json"})
	@ResponseBody
	public ModelMap extendPwdChangeAjax(HttpServletRequest request, HttpServletResponse response) {
		
		String siteCode = "";
		String resultCode = "0";
		String errorCode = "";
		String errorMsg = "";
		try {
			
			// Request Parameter
			String authorization = request.getParameter("authorization");
			String webId = request.getParameter("webId");
			
			// authorization Valdation
			if (authorization != null) {
				siteCode = CommonUtil.checkAuthorizationAjax(authorization);
				if (StringUtil.isEmpty(siteCode)) {
					throw new UserHandleException(OneClickConstants.INVALID_AUTHORIZATION, OneClickConstants.INVALID_AUTHORIZATION_MSG);
				}
			} else { 
				throw new UserHandleException(OneClickConstants.INVALID_AUTHORIZATION, OneClickConstants.INVALID_AUTHORIZATION_MSG);
			}
			
			// Reqeust Parameter Validation
			ValidationRule validationRule = new ValidationRule();
			validationRule.isValidParameter(request);
			
			// 비밀번호 연장  		++			
			memberService.updatePwdChangeDate(webId);
			response.setHeader("Access-Control-Allow-Origin", "*");
		} catch(UserHandleException ue) {
			resultCode = OneClickConstants.RESULT_FAIL;
			errorCode = ue.getMessage();
			errorMsg = ue.getMsgDesc();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// Response
		ModelMap map = new ModelMap();
		map.addAttribute("resultCode", resultCode);
		map.addAttribute("errorCode", errorCode);
		map.addAttribute("errorMsg", errorMsg);
		return map;
	}
	/**
	 *  임시 비밀 번호 유지
	 * @return
	 */
	@RequestMapping(value="/holdTempPasswordAjax", produces = {"application/json"})
	@ResponseBody
	public ModelMap holdTempPasswordAjax(HttpServletRequest request, HttpServletResponse response) {
		
		String siteCode = "";
		String resultCode = "0";
		String errorCode = "";
		String errorMsg = "";
		try {
			// Request Parameter
			String authorization = request.getParameter("authorization");
			String webId = request.getParameter("webId");
			
			// authorization Valdation
			if (authorization != null) {
				siteCode = CommonUtil.checkAuthorizationAjax(authorization);
				if (StringUtil.isEmpty(siteCode)) {
					throw new UserHandleException(OneClickConstants.INVALID_AUTHORIZATION, OneClickConstants.INVALID_AUTHORIZATION_MSG);
				}
			} else { 
				throw new UserHandleException(OneClickConstants.INVALID_AUTHORIZATION, OneClickConstants.INVALID_AUTHORIZATION_MSG);
			}
			
			// Reqeust Parameter Validation
			ValidationRule validationRule = new ValidationRule();
			validationRule.isValidParameter(request);
			
			// 임시 비밀번호 유지 처리
			memberService.updateTempPwdYn(webId);
			response.setHeader("Access-Control-Allow-Origin", "*");
		} catch(UserHandleException ue) {
			resultCode = OneClickConstants.RESULT_FAIL;
			errorCode = ue.getMessage();
			errorMsg = ue.getMsgDesc();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// Response
		ModelMap map = new ModelMap();
		map.addAttribute("resultCode", resultCode);
		map.addAttribute("errorCode", errorCode);
		map.addAttribute("errorMsg", errorMsg);
		return map;
	}
	
}
