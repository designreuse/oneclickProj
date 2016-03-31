package com.eland.ngoc.security.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.eland.ngoc.common.OcOaConstants;
import com.eland.ngoc.exception.UserHandleException;
import com.eland.ngoc.security.model.Token;
import com.eland.ngoc.security.service.AuthTokenService;

@RestController
@RequestMapping("/auth")
public class AuthTokenController {

	// logger 선언
	private final Logger logger = LoggerFactory
			.getLogger(AuthTokenController.class);

	@Autowired
	private AuthTokenService authTokenService;

	/**
	 * <pre>
	 * auth/createToken[POST]
	 * 
	 * 원클릭 API 사용을 위해 필요한 Token을 생성하는 기능 제공
	 * </pre>
	 * 
	 * @param model
	 * @param request
	 * @param response
	 * @return Token
	 * 
	 */
	@RequestMapping(value = "/createToken", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public Token createToken(Model model, HttpServletRequest request, HttpServletResponse response) {
		Token token = new Token();
		try {
			token = authTokenService.createToken(request);
		} catch (UserHandleException ue) {
			token.setResultCode(OcOaConstants.RESULT_FAIL);
			token.setErrorCode(ue.getMessage());
			token.setErrorMsg(ue.getMsgDesc());

			logger.debug("{errorCode : " + token.getErrorCode() + ", errorMsg : " + token.getErrorMsg() + "}");
		} catch(Exception e) {
			e.printStackTrace();
			token.setResultCode(OcOaConstants.RESULT_FAIL);
			token.setErrorCode(OcOaConstants.INTERNAL_SERVER_ERROR);
			token.setErrorMsg(OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}

		return token;
	}

}
