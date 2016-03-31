package com.eland.ngoc.member.model;

import com.eland.ngoc.common.model.BaseModel;

public class CustSiteInfo extends BaseModel {
	
	private int custId;
	private String siteCode;
	private String emailRcptnYn;
	private String smsRcptnYn;
	private String dmRcptnYn;
	private String edmRcptnYn;
	private String delYn;
	
	
	
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
	public String getEmailRcptnYn() {
		return emailRcptnYn;
	}
	public void setEmailRcptnYn(String emailRcptnYn) {
		this.emailRcptnYn = emailRcptnYn;
	}
	public String getSmsRcptnYn() {
		return smsRcptnYn;
	}
	public void setSmsRcptnYn(String smsRcptnYn) {
		this.smsRcptnYn = smsRcptnYn;
	}
	public String getDmRcptnYn() {
		return dmRcptnYn;
	}
	public void setDmRcptnYn(String dmRcptnYn) {
		this.dmRcptnYn = dmRcptnYn;
	}
	public String getEdmRcptnYn() {
		return edmRcptnYn;
	}
	public void setEdmRcptnYn(String edmRcptnYn) {
		this.edmRcptnYn = edmRcptnYn;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	
}
