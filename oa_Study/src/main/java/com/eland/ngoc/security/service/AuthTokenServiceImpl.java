package com.eland.ngoc.security.service;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eland.ngoc.common.OcOaConstants;
import com.eland.ngoc.common.model.MemberIds;
import com.eland.ngoc.common.rules.ValidationRule;
import com.eland.ngoc.common.service.token.TokenService;
import com.eland.ngoc.common.utils.StringUtil;
import com.eland.ngoc.exception.UserHandleException;
import com.eland.ngoc.member.dao.MemberDao;
import com.eland.ngoc.security.model.Token;

@Service
public class AuthTokenServiceImpl implements AuthTokenService {
	// logger 선언
	private final Logger logger = LoggerFactory.getLogger(AuthTokenServiceImpl.class);

	@Autowired
	private TokenService tokenService;

	@Autowired
	private MemberDao memberRepository;
		
	@Autowired
	private ValidationRule validationRule;

	/**
	 * <pre>
	 * accessToken을 생성하여 발급한다.
	 * 
	 * 생성일 : 2016. 2. 1.
	 * </pre>
	 * 
	 * @param request
	 *            token 생성에 필요한 정보가 담긴 객체
	 * @return Token 생성하여 발급할 토큰이 담긴 객체
	 * @exception
	 * 
	 */
	@Override
	public Token createToken(HttpServletRequest request) {
		Token token = new Token();
		String accessToken = "";

		try {
			logger.debug("createToken -> Auth: " + request.getHeader("Authorization") + ", webId: " + request.getParameter("webId"));

			// Authorization check
			String siteId = validationRule.checkAuthorization(request.getHeader("Authorization"));
			
			// Validation
			String webId = request.getParameter("webId");
			if (StringUtil.isEmpty(webId)) {
				throw new UserHandleException(OcOaConstants.INVALID_WEB_ID, OcOaConstants.INVALID_WEB_ID_MSG);
			}
			validationRule.isValidParameter(request);
	
			// Token 생성 및 Redis에 저장
			MemberIds memberIds = memberRepository.getCustInfoIds("", webId);
			if (memberIds == null) {
				throw new UserHandleException(OcOaConstants.INVALID_WEB_ID, OcOaConstants.INVALID_WEB_ID_MSG);
			}
			
			accessToken = tokenService.createToken(siteId, memberIds.getCustId(), 0);
			token.setAccessToken(accessToken);
			
			token.setResultCode(OcOaConstants.RESULT_SUCCESS);
		} catch(UserHandleException ue) {
			throw new UserHandleException(ue.getMessage(), ue.getMsgDesc()); 
		} catch(Exception e) {
			logger.debug(e.getMessage());
			throw new UserHandleException(OcOaConstants.INVALID_AUTHORIZATION, OcOaConstants.INVALID_AUTHORIZATION_MSG);
		}

		return token;
	}

}
