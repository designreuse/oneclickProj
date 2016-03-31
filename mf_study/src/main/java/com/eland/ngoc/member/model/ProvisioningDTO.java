package com.eland.ngoc.member.model;

import com.eland.ngoc.common.model.Provisioning;

public class ProvisioningDTO {

	private String birthday;
	private String membName;
	private String mobileNo;
	private String email;
	private String gender;
	private String custId;
	private String birthUnar;
	private String webId;
	private String joinDate;
	private String telNo;
	private String weddingDay;

	private String mallOutYn;
	private String coreOutYn;
	private String outDate;

	private String lockDate;

	public String getBirthday() {
		return birthday;
	}

	@Provisioning(notiYn=true, type={"update"})
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getMembName() {
		return membName;
	}

	@Provisioning(notiYn=true, type={"update"})
	public void setMembName(String membName) {
		this.membName = membName;
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

	public String getGender() {
		return gender;
	}

	@Provisioning(notiYn=true, type={"update"})
	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getCustId() {
		return custId;
	}

	@Provisioning(notiYn=true, type={"update", "out", "lock"})
	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getBirthUnar() {
		return birthUnar;
	}

	@Provisioning(notiYn=true, type={"update"})
	public void setBirthUnar(String birthUnar) {
		this.birthUnar = birthUnar;
	}

	public String getWebId() {
		return webId;
	}

	@Provisioning(notiYn=true, type={"update", "out", "lock"})
	public void setWebId(String webId) {
		this.webId = webId;
	}

	public String getJoinDate() {
		return joinDate;
	}
	
	@Provisioning(notiYn=true, type={"update"})
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public String getTelNo() {
		return telNo;
	}

	@Provisioning(notiYn=true, type={"update"})
	public void setTelNo(String telNo) {
		this.telNo = telNo;
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

	public String getCoreOutYn() {
		return coreOutYn;
	}

	@Provisioning(notiYn=true, type={"out"})
	public void setCoreOutYn(String coreOutYn) {
		this.coreOutYn = coreOutYn;
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

}
