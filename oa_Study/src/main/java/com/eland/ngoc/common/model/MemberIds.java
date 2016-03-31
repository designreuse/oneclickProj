package com.eland.ngoc.common.model;

public class MemberIds {
	/**
	 * 회원 고객 ID
	 */
	private String custId;
	/**
	 * 회원 EIMS ID
	 */
	private String pbpId;
	/**
	 * 회원 Web ID
	 */
	private String webId;
	/**
	 * 회원 상태 코드
	 */
	private String custStat;

	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getPbpId() {
		return pbpId;
	}

	public void setPbpId(String pbpId) {
		this.pbpId = pbpId;
	}

	public String getWebId() {
		return webId;
	}

	public void setWebId(String webId) {
		this.webId = webId;
	}

	public String getCustStat() {
		return custStat;
	}

	public void setCustStat(String custStat) {
		this.custStat = custStat;
	}

}
