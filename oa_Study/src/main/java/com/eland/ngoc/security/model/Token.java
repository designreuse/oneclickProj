package com.eland.ngoc.security.model;

import com.eland.ngoc.common.model.Result;

/**
 * <pre>
 * 토큰 생성 API respone용 모델
 * 
 * 생성일 : 2016. 2. 1.
 * </pre>
 * 
 * @author kim.hyemi04
 *
 */
public class Token extends Result {

	private String accessToken;

	public String getAccessToken() {
		return accessToken;
	}

	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}

}
