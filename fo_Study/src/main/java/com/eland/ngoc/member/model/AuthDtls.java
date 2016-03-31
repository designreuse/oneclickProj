package com.eland.ngoc.member.model;

import com.eland.ngoc.common.model.BaseModel;

/**
 * <pre>
 * 본인 인증 내역
 *
 */
public class AuthDtls extends BaseModel {

	private String ci;
	private String di;
	private String custName;
	private String siteCode;
	private String authTypeDiv;
	
	public String getCi() {
		return ci;
	}
	public void setCi(String ci) {
		this.ci = ci;
	}
	public String getDi() {
		return di;
	}
	public void setDi(String di) {
		this.di = di;
	}
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getSiteCode() {
		return siteCode;
	}
	public void setSiteCode(String siteCode) {
		this.siteCode = siteCode;
	}
	public String getAuthTypeDiv() {
		return authTypeDiv;
	}
	public void setAuthTypeDiv(String authTypeDiv) {
		this.authTypeDiv = authTypeDiv;
	}
}
