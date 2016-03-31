package com.eland.ngoc.member.model;

import com.eland.ngoc.common.model.Provisioning;

public class MemberProvision {
	/**
	 * 고객 고유 ID
	 */
	private String custId;
	/**
	 * Web ID
	 */
	private String webId;
	/**
	 * 고객 이름
	 */
	private String membName;
	/**
	 * 가입 일자
	 */
	private String joinDate;
	/**
	 * 생년월일
	 */
	private String birthday;
	/**
	 * 생일 양력,음력 구분(EIMS 수신용)
	 */
	private String birthdayType;
	/**
	 * 성별
	 */
	private String gender;
	/**
	 * 전화번호
	 */
	private String telNo;
	/**
	 * 핸드폰번호
	 */
	private String mobileNo;
	/**
	 * 이메일
	 */
	private String email;
	/**
	 * 결혼기념일
	 */
	private String weddingDay;

	/**
	 * 통합몰 탈퇴여부
	 */
	private String mallOutYn;
	/**
	 * 통합홈페이지 탈퇴여부
	 */
	private String retailOutYn;
	/**
	 * 탈퇴일자
	 */
	private String outDate;
	
	/**
	 * 계정잠금여부
	 */
	private String lockDate;
	
	/**
	 * 생일 양력,음력 구분(통합몰,통합홈페이지용)
	 */
	private String birthUnar;

	public String getCustId() {
		return custId;
	}
	@Provisioning(notiYn=true, type={"update", "out", "lock"})
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getWebId() {
		return webId;
	}
	@Provisioning(notiYn=true, type={"update", "out", "lock"})
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getMembName() {
		return membName;
	}
	@Provisioning(notiYn=true, type={"update"})
	public void setMembName(String membName) {
		this.membName = membName;
	}
	public String getJoinDate() {
		return joinDate;
	}
	@Provisioning(notiYn=true, type={"update"})
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public String getBirthday() {
		return birthday;
	}
	@Provisioning(notiYn=true, type={"update"})
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getBirthdayType() {
		return birthdayType;
	}
	public void setBirthdayType(String birthdayType) {
		this.birthdayType = birthdayType;
	}
	public String getGender() {
		return gender;
	}
	@Provisioning(notiYn=true, type={"update"})
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getTelNo() {
		return telNo;
	}
	@Provisioning(notiYn=true, type={"update"})
	public void setTelNo(String telNo) {
		this.telNo = telNo;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	@Provisioning(notiYn=true, type={"update"})
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getEmail() {
		return email;
	}
	@Provisioning(notiYn=true, type={"update"})
	public void setEmail(String email) {
		this.email = email;
	}
	public String getWeddingDay() {
		return weddingDay;
	}
	@Provisioning(notiYn=true, type={"update"})
	public void setWeddingDay(String weddingDay) {
		this.weddingDay = weddingDay;
	}
	
	public String getMallOutYn() {
		return mallOutYn;
	}
	@Provisioning(notiYn=true, type={"out"})
	public void setMallOutYn(String mallOutYn) {
		this.mallOutYn = mallOutYn;
	}
	public String getRetailOutYn() {
		return retailOutYn;
	}
	@Provisioning(notiYn=true, type={"out"})
	public void setRetailOutYn(String retailOutYn) {
		this.retailOutYn = retailOutYn;
	}
	public String getOutDate() {
		return outDate;
	}
	@Provisioning(notiYn=true, type={"out"})
	public void setOutDate(String outDate) {
		this.outDate = outDate;
	}
	
	public String getLockDate() {
		return lockDate;
	}
	@Provisioning(notiYn=true, type={"lock"})
	public void setLockDate(String lockDate) {
		this.lockDate = lockDate;
	}
	
	public String getBirthUnar() {
		return birthUnar;
	}
	@Provisioning(notiYn=true, type={"update"})
	public void setBirthUnar(String birthUnar) {
		this.birthUnar = birthUnar;
	}
}
