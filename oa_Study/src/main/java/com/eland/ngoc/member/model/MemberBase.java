package com.eland.ngoc.member.model;

import java.util.List;

public class MemberBase {
	/**
	 * Web ID
	 */
	private String webId;
	/**
	 * 생일: YYYYMMDD
	 */
	private String birthday;
	/**
	 * 전화번호
	 */
	private String telNo;
	/**
	 * 휴대폰번호
	 */
	private String mobileNo;
	/**
	 * 우편번호
	 */
	private String zipCode;
	/**
	 * 주소1
	 */
	private String addr1;
	/**
	 * 주소2
	 */
	private String addr2;
	/**
	 * 주소구분
	 */
	private String addrDiv;
	/**
	 * 이메일
	 */
	private String email;
	/**
	 * 이메일 수신여부
	 */
	private String emailYn;
	/**
	 * 문자 수신여부
	 */
	private String smsYn;
	/**
	 * DM 수신여부
	 */
	private String dmYn;
	/**
	 * 결혼유무
	 */
	private String weddingYn;
	/**
	 * 결혼기념일
	 */
	private String weddingDay;
	/**
	 * 자녀수
	 */
	private int childNum;
	/**
	 * 자녀 정보_List
	 */
	private List<MemberChildInfos> children;

	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getTelNo() {
		return telNo;
	}
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getZipCode() {
		return zipCode;
	}
	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getAddrDiv() {
		return addrDiv;
	}
	public void setAddrDiv(String addrDiv) {
		this.addrDiv = addrDiv;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmailYn() {
		return emailYn;
	}
	public void setEmailYn(String emailYn) {
		this.emailYn = emailYn;
	}
	public String getSmsYn() {
		return smsYn;
	}
	public void setSmsYn(String smsYn) {
		this.smsYn = smsYn;
	}
	public String getDmYn() {
		return dmYn;
	}
	public void setDmYn(String dmYn) {
		this.dmYn = dmYn;
	}
	public String getWeddingYn() {
		return weddingYn;
	}
	public void setWeddingYn(String weddingYn) {
		this.weddingYn = weddingYn;
	}
	public String getWeddingDay() {
		return weddingDay;
	}
	public void setWeddingDay(String weddingDay) {
		this.weddingDay = weddingDay;
	}
	public int getChildNum() {
		return childNum;
	}
	public void setChildNum(int childNum) {
		this.childNum = childNum;
	}
	public List<MemberChildInfos> getChildren() {
		return children;
	}
	public void setChildren(List<MemberChildInfos> children) {
		this.children = children;
	}
}
