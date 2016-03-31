package com.eland.ngoc.member.model;

import com.eland.ngoc.common.model.BaseModel;

/**
 * <pre>
 * 회원 정보 모델
 *
 */
public class CustTermsAgree extends BaseModel {

	/**
	 * 회원 ID
	 */
	int custId;
	/**
	 *  사이트 코드
	 */
	String siteCode;
	/**
	 *  약관 코드
	 */
	String termsCode;
	/**
	 * 약관 동의 여부
	 */
	String termsAgreeYn;

	public int getCustId() {
		return custId;
	}
	public void setCustId(int custId) {
		this.custId = custId;
	}
	public String getSiteCode() {
		return siteCode;
	}
	public void setSiteCode(String siteCode) {
		this.siteCode = siteCode;
	}
	public String getTermsCode() {
		return termsCode;
	}
	public void setTermsCode(String termsCode) {
		this.termsCode = termsCode;
	}
	public String getTermsAgreeYn() {
		return termsAgreeYn;
	}
	public void setTermsAgreeYn(String termsAgreeYn) {
		this.termsAgreeYn = termsAgreeYn;
	}
}
