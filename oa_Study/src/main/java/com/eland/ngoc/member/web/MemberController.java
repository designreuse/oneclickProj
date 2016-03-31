package com.eland.ngoc.member.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.eland.ngoc.common.OcOaConstants;
import com.eland.ngoc.common.model.Result;
import com.eland.ngoc.common.rules.ValidationRule;
import com.eland.ngoc.common.service.RedisService;
import com.eland.ngoc.common.service.token.TokenService;
import com.eland.ngoc.common.utils.CommonUtil;
import com.eland.ngoc.exception.UserHandleException;
import com.eland.ngoc.member.model.MemberGet;
import com.eland.ngoc.member.model.MemberOut;
import com.eland.ngoc.member.service.MemberService;

@RestController
@RequestMapping(value="/member")
public class MemberController {
	
	// logger 선언
    private final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private RedisService redisService;
	
	@Autowired
	private TokenService tokenService;

	/**
	 * <pre>
	 * 회원정보 수정 API: member/updateMemberInfo[POST]
	 * 1. EIMS와 연동하여 회원정보를 수정하는 기능 제공
	 * - 온라인 고객센터에서 회원정보 수정을 원할 경우, 원클릭 API를 호출, EIMS와 연동하여 회원정보 수정 처리를 함
 	 * 2. 정보 수정이 끝나면, 통합몰/통합홈페이지로 provisioning 처리
	 * </pre>
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @param member
	 * @return Result
	 */
	@RequestMapping(value = "/updateMemberInfo", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public String updateMemberInfo(Model model, HttpServletRequest request, HttpServletResponse response) {
		Result result = new Result();
		
		try {
			result = memberService.updateMemberInfo(request);
			if (OcOaConstants.RESULT_SUCCESS.equals(result.getResultCode())) {
				response.setStatus(200);
			} else {
				response.setStatus(400);
			}
		} catch(UserHandleException ue) {
			result.setResultCode(OcOaConstants.RESULT_FAIL);
			result.setErrorCode(ue.getMessage());
			result.setErrorMsg(ue.getMsgDesc());

			logger.debug("{errorCode : " + result.getErrorCode() + ", errorMsg : " + result.getErrorMsg() + "}");
		} catch(Exception e) {
			e.printStackTrace();
			result.setResultCode(OcOaConstants.RESULT_FAIL);
			result.setErrorCode(OcOaConstants.INTERNAL_SERVER_ERROR);
			result.setErrorMsg(OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}
		
		return CommonUtil.convertObjectToJson(result);
	}
	
	/**
	 * <pre>
	 * 회원정보 조회 API: member/getMemberInfo[POST]
	 * 1. EIMS와 연동하여 회원의 개인 정보를 조회하는 기능 제공
	 * 2. 온라인/오프라인 가입 구분, 가입 일자 정보 포함
	 * </pre>
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return Member
	 */
	@RequestMapping(value = "/getMemberInfo", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public String getMemberInfo(Model model, HttpServletRequest request, HttpServletResponse response) {
		MemberGet memberGet = new MemberGet();
		try {
			memberGet = memberService.getMemberInfo(request);
			logger.debug("Member Child Num: " + memberGet.getChildNum());
			if (OcOaConstants.RESULT_SUCCESS.equals(memberGet.getResultCode())) {
				response.setStatus(200);
			} else {
				response.setStatus(400);
			}
		} catch(UserHandleException ue) {
			memberGet.setResultCode(OcOaConstants.RESULT_FAIL);
			memberGet.setErrorCode(ue.getMessage());
			memberGet.setErrorMsg(ue.getMsgDesc());

			logger.debug("{errorCode : " + memberGet.getErrorCode() + ", errorMsg : " + memberGet.getErrorMsg() + "}");
		} catch(Exception e) {
			e.printStackTrace();
			memberGet.setResultCode(OcOaConstants.RESULT_FAIL);
			memberGet.setErrorCode(OcOaConstants.INTERNAL_SERVER_ERROR);
			memberGet.setErrorMsg(OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}
		
		return CommonUtil.convertObjectToJson(memberGet);
	}
	
	/**
	 * <pre>
	 * 회원상태 변경 API: member/updateMemberState[POST]
	 * 1. EIMS와 연동하여 회원상태 변경에 따른 처리 기능 제공
	 * 2. 온라인 고객센터 또는 EIMS CS에서 회원의 상태를 변경할 경우
	 * 3. 계정잠금 시에는, 통합몰/통합홈페이지로 provisioning 처리
	 * </pre>
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return Result
	 */
	@RequestMapping(value = "/updateMemberState", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public String updateMemberState(Model model, HttpServletRequest request, HttpServletResponse response) {
		Result result = new Result();
		try {
			result = memberService.updateMemberState(request);
			if(OcOaConstants.RESULT_SUCCESS.equals(result.getResultCode())) {
				response.setStatus(200);
			} else {
				response.setStatus(400);
			}
		} catch(UserHandleException ue) {
			result.setResultCode(OcOaConstants.RESULT_FAIL);
			result.setErrorCode(ue.getMessage());
			result.setErrorMsg(ue.getMsgDesc());

			logger.debug("{errorCode : " + result.getErrorCode() + ", errorMsg : " + result.getErrorMsg() + "}");
		} catch(Exception e) {
			e.printStackTrace();
			result.setResultCode(OcOaConstants.RESULT_FAIL);
			result.setErrorCode(OcOaConstants.INTERNAL_SERVER_ERROR);
			result.setErrorMsg(OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}
		
		return CommonUtil.convertObjectToJson(result);
	}

	/**
	 * <pre>
	 * 회원 탈퇴 API: member/memberOut[POST]
	 * 1. 회원 탈퇴 처리를 하는 기능 제공
 	 *  - 탈퇴 유형에 따라 온라인 탈퇴처리 및 전체(오프라인까지) 탈퇴처리
 	 *  - 고객 자의탈퇴, 온라인CS 탈퇴 : 온라인탈퇴, 전체탈퇴 모두 가능
 	 *  - 휴면 자동탈퇴, EIMS CS탈퇴 : 전체탈퇴만 가능
 	 *  - 원클릭 가입회원이 오프라인 탈퇴까지 원할 경우, 원클릭과 EIMS 모두 탈퇴 처리를 함
 	 * 2. 탈퇴 처리 전, 먼저 통합몰, 통합홈페이지에 탈퇴 가능여부 확인 필요
 	 *  - 회원탈퇴확인(통합몰/통합홈페이지) API 호출
 	 * 3. 정보 수정이 끝나면, 통합몰/통합홈페이지로 provisioning 처리
	 * </pre>
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return Result
	 */
	@RequestMapping(value = "/memberOut", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public String membershipOut(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("mbOut") MemberOut mbOut) {
		Result result = new Result();

		try {
			result = memberService.membershipOut(request, mbOut);
			if(OcOaConstants.RESULT_SUCCESS.equals(result.getResultCode())) {
				response.setStatus(200);
			} else {
				response.setStatus(400);
			}
		} catch(UserHandleException ue) {
			result.setResultCode(OcOaConstants.RESULT_FAIL);
			result.setErrorCode(ue.getMessage());
			result.setErrorMsg(ue.getMsgDesc());

			logger.debug("{errorCode : " + result.getErrorCode() + ", errorMsg : " + result.getErrorMsg() + "}");
		} catch(Exception e) {
			e.printStackTrace();
			result.setResultCode(OcOaConstants.RESULT_FAIL);
			result.setErrorCode(OcOaConstants.INTERNAL_SERVER_ERROR);
			result.setErrorMsg(OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}
		
		return CommonUtil.convertObjectToJson(result);
	}
	
	/**
	 * <pre>
	 * 회원 탈퇴 취소 API: member/cancelMemberOut[POST]
	 * 1. 회원 탈퇴 취소를 처리하는 기능 제공
 	 *  - 탈퇴 유형에 따라 온라인 탈퇴취소 및 전체(오프라인까지) 탈퇴취소
	 * </pre>
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return Result
	 */
	@RequestMapping(value = "/cancelMemberOut", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public String cancelMemberOut(HttpServletRequest request, HttpServletResponse response) {
		Result result = new Result();

		try {
			result = memberService.cancelMemberOut(request);
			if(OcOaConstants.RESULT_SUCCESS.equals(result.getResultCode())) {
				response.setStatus(200);
			} else {
				response.setStatus(400);
			}
		} catch(UserHandleException ue) {
			result.setResultCode(OcOaConstants.RESULT_FAIL);
			result.setErrorCode(ue.getMessage());
			result.setErrorMsg(ue.getMsgDesc());

			logger.debug("{errorCode : " + result.getErrorCode() + ", errorMsg : " + result.getErrorMsg() + "}");
		} catch(Exception e) {
			e.printStackTrace();
			result.setResultCode(OcOaConstants.RESULT_FAIL);
			result.setErrorCode(OcOaConstants.INTERNAL_SERVER_ERROR);
			result.setErrorMsg(OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}
		
		return CommonUtil.convertObjectToJson(result);
	}
	
	/**
	 * <pre>
	 *  자동 로그인
	 * </pre>
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return Result
	 */
	@RequestMapping(value = "/autoLogin", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public ModelMap autoLogin(HttpServletRequest request, HttpServletResponse response) {
		Result result = new Result();
		
		String siteCode= "";
		String newLoginToken = "";
		String custId = "";
		String membState = "";
		String accessToken = "";
		String resultCode = "0";
		String errorCode = "0";
		String errorMsg = "";
		String authorization = request.getHeader("Authorization");
		String aLoginUid = request.getParameter("aLoginUid");
		String loginToken = request.getParameter("loginToken");
		
		try {
			Map<String, String> autoLoginMap = new HashMap<String, String>();
			
			if (authorization != null) {
				String clientId = CommonUtil.checkAuthorization(authorization);
				siteCode = CommonUtil.getSiteCode(clientId);
			} else { 
				throw new UserHandleException(OcOaConstants.INVALID_AUTHORIZATION, OcOaConstants.INVALID_AUTHORIZATION_MSG);
			}
			
			// Reqeust Parameter Validation
			ValidationRule validationRule = new ValidationRule();
			validationRule.isValidParameter(request);
			
			autoLoginMap = memberService.autoLogin(aLoginUid, loginToken);
			newLoginToken = autoLoginMap.get("newLoginToken");
			custId = autoLoginMap.get("custId");
			
			// 회원상태 조회(정상, 탈퇴, 휴면, 계정잠금, 탈퇴사이트 로그인, 미가입사이트 로그인, 장기비밀번호 미변경, 임시 비밀번호 로그인
			membState = memberService.selectCustStateInfo(custId, siteCode);
			
			// 최종 로그인 정보 insert OR update
			memberService.saveLastLoginHistory(custId, siteCode);
						
			// AccessToken 토큰 생성
			accessToken = tokenService.createToken(siteCode, custId, 300);
			
		} catch(UserHandleException ue) {
			logger.debug(OcOaConstants.RESULT_FAIL);
			logger.debug(ue.getMessage());
			logger.debug(ue.getArgs());
			resultCode = OcOaConstants.RESULT_FAIL;
			errorCode = ue.getMessage();
			String errorParam = ue.getArgs();
			errorMsg = ue.getMsgDesc();
			
			// 자동로그인 토큰 맞지 않을시 자동로그인정보 전체 삭제
			if (OcOaConstants.INVALID_AUTO_LOGIN_TOKEN.equals(errorCode)) {
				memberService.deleteAutoLoginToken(errorParam);
			}
			
			logger.debug("{errorCode : " + errorCode + ", errorMsg : " + errorMsg + "}");
		} catch(Exception e) {
			e.printStackTrace();
			result.setResultCode(OcOaConstants.RESULT_FAIL);
			result.setErrorCode(OcOaConstants.INTERNAL_SERVER_ERROR);
			result.setErrorMsg(OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}
		
		response.setHeader("Access-Control-Allow-Origin", "*");
		// Response
		ModelMap map = new ModelMap();
		map.addAttribute("resultCode", resultCode);
		map.addAttribute("errorCode", errorCode);
		map.addAttribute("errorMsg", errorMsg);
		map.addAttribute("accessToken", accessToken);
		map.addAttribute("aLoginUid", aLoginUid);
		map.addAttribute("loginToken", newLoginToken);
		map.addAttribute("membState", membState);
		
		return map;
	}
}
