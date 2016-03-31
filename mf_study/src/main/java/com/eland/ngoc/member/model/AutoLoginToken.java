package com.eland.ngoc.member.model;

import com.eland.ngoc.common.model.BaseModel;

public class AutoLoginToken extends BaseModel {

	private String alUid;
	private String loginToken;
	private String webId;
	private String exprDate;
	public String getAlUid() {
		return alUid;
	}
	public void setAlUid(String alUid) {
		this.alUid = alUid;
	}
	public String getLoginToken() {
		return loginToken;
	}
	public void setLoginToken(String loginToken) {
		this.loginToken = loginToken;
	}
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getExprDate() {
		return exprDate;
	}
	public void setExprDate(String exprDate) {
		this.exprDate = exprDate;
	}
}
