package com.eland.ngoc.member.model;

public class MemberUpdOc extends MemberUpd {
	/**
	 * 고객이름
	 */
	private String membName;
	/**
	 * 성별
	 */
	private String gender;
	/**
	 * 고객 고유 ID
	 */
	private String custId;
	/**
	 * 수정 USER
	 */
	private String updUser;
	
	public String getMembName() {
		return membName;
	}
	public void setMembName(String membName) {
		this.membName = membName;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getUpdUser() {
		return updUser;
	}
	public void setUpdUser(String updUser) {
		this.updUser = updUser;
	}
}
