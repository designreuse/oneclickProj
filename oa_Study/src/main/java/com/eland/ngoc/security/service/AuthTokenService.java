package com.eland.ngoc.security.service;

import javax.servlet.http.HttpServletRequest;

import com.eland.ngoc.security.model.Token;

public interface AuthTokenService {
	
	public Token createToken(HttpServletRequest request);

}
