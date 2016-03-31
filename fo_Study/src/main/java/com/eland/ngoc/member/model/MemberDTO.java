package com.eland.ngoc.member.model;


public class MemberDTO {

	String custId;
	String webId;
	String name;
	String password;
	String birth;
	String birthUnar;
	String tel;
	String phone;
	String address;
	String email;
	String pbpId;
	String gender;
	String joinDate;

	String retailMallPartnerShipYn;
	String corePartnerShipYn;

	String retailMallEmailYn;
	String coreEmailYn;

	String retailMallSmsYn;
	String coreSmsYn;

	String edmYn;
	String dmBookYn;

	String retailMallDmYn;
	String coreDmYn;

	String weddingYn;
	String weddingDay;
	String[] childName;
	String[] childGender;
	String[] childBirthday;
	String[] childUnar;

	// 약관 동의
	String memberShipTerms;
	String onlineTerms;
	String memberInfoTerms;
	String offerMemberInfoTerms;

	// 비밀번호 변경 시 체크용 기존 비밀번호
	String inputOldPassword;

	// 현재 접속한 사이트
	String currentSiteCode;
	String outSiteCode;

	String tempPassword;
	String operDate;

	String ci;
	String di;

	String address1_1;
	String address1_2;
	String postNo1;
	String addrType1;

	String address2_1;
	String address2_2;
	String postNo2;
	String addrType2;

	String address3_1;
	String address3_2;
	String postNo3;
	String addrType3;
	String nationality;
	String partnerUrl;
	String partnerName;

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public String getAddress1_1() {
		return address1_1;
	}

	public void setAddress1_1(String address1_1) {
		this.address1_1 = address1_1;
	}

	public String getAddress1_2() {
		return address1_2;
	}

	public void setAddress1_2(String address1_2) {
		this.address1_2 = address1_2;
	}

	public String getPostNo1() {
		return postNo1;
	}

	public void setPostNo1(String postNo1) {
		this.postNo1 = postNo1;
	}

	public String getAddrType1() {
		return addrType1;
	}

	public void setAddrType1(String addrType1) {
		this.addrType1 = addrType1;
	}

	public String getAddress2_1() {
		return address2_1;
	}

	public void setAddress2_1(String address2_1) {
		this.address2_1 = address2_1;
	}

	public String getAddress2_2() {
		return address2_2;
	}

	public void setAddress2_2(String address2_2) {
		this.address2_2 = address2_2;
	}

	public String getPostNo2() {
		return postNo2;
	}

	public void setPostNo2(String postNo2) {
		this.postNo2 = postNo2;
	}

	public String getAddrType2() {
		return addrType2;
	}

	public void setAddrType2(String addrType2) {
		this.addrType2 = addrType2;
	}

	public String getAddress3_1() {
		return address3_1;
	}

	public void setAddress3_1(String address3_1) {
		this.address3_1 = address3_1;
	}

	public String getAddress3_2() {
		return address3_2;
	}

	public void setAddress3_2(String address3_2) {
		this.address3_2 = address3_2;
	}

	public String getPostNo3() {
		return postNo3;
	}

	public void setPostNo3(String postNo3) {
		this.postNo3 = postNo3;
	}

	public String getAddrType3() {
		return addrType3;
	}

	public void setAddrType3(String addrType3) {
		this.addrType3 = addrType3;
	}

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

	public String getTempPassword() {
		return tempPassword;
	}

	public void setTempPassword(String tempPassword) {
		this.tempPassword = tempPassword;
	}

	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getWebId() {
		return webId;
	}

	public void setWebId(String webId) {
		this.webId = webId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getBirthUnar() {
		return birthUnar;
	}

	public void setBirthUnar(String birthUnar) {
		this.birthUnar = birthUnar;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPbpId() {
		return pbpId;
	}

	public void setPbpId(String pbpId) {
		this.pbpId = pbpId;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getRetailMallPartnerShipYn() {
		return retailMallPartnerShipYn;
	}

	public void setRetailMallPartnerShipYn(String retailMallPartnerShipYn) {
		this.retailMallPartnerShipYn = retailMallPartnerShipYn;
	}

	public String getCorePartnerShipYn() {
		return corePartnerShipYn;
	}

	public void setCorePartnerShipYn(String corePartnerShipYn) {
		this.corePartnerShipYn = corePartnerShipYn;
	}

	public String getRetailMallEmailYn() {
		return retailMallEmailYn;
	}

	public void setRetailMallEmailYn(String retailMallEmailYn) {
		this.retailMallEmailYn = retailMallEmailYn;
	}

	public String getCoreEmailYn() {
		return coreEmailYn;
	}

	public void setCoreEmailYn(String coreEmailYn) {
		this.coreEmailYn = coreEmailYn;
	}

	public String getRetailMallSmsYn() {
		return retailMallSmsYn;
	}

	public void setRetailMallSmsYn(String retailMallSmsYn) {
		this.retailMallSmsYn = retailMallSmsYn;
	}

	public String getCoreSmsYn() {
		return coreSmsYn;
	}

	public void setCoreSmsYn(String coreSmsYn) {
		this.coreSmsYn = coreSmsYn;
	}

	public String getEdmYn() {
		return edmYn;
	}

	public void setEdmYn(String edmYn) {
		this.edmYn = edmYn;
	}

	public String getDmBookYn() {
		return dmBookYn;
	}

	public void setDmBookYn(String dmBookYn) {
		this.dmBookYn = dmBookYn;
	}

	public String getRetailMallDmYn() {
		return retailMallDmYn;
	}

	public void setRetailMallDmYn(String retailMallDmYn) {
		this.retailMallDmYn = retailMallDmYn;
	}

	public String getCoreDmYn() {
		return coreDmYn;
	}

	public void setCoreDmYn(String coreDmYn) {
		this.coreDmYn = coreDmYn;
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

	public String[] getChildName() {
		return childName;
	}

	public void setChildName(String childName) {
		this.childName = childName.split(",");
	}

	public String[] getChildGender() {
		return childGender;
	}

	public void setChildGender(String childGender) {
		this.childGender = childGender.split(",");
	}

	public String[] getChildBirthday() {
		return childBirthday;
	}

	public void setChildBirthday(String childBirthday) {
		this.childBirthday = childBirthday.split(",");
	}

	public String[] getChildUnar() {
		return childUnar;
	}

	public void setChildUnar(String childUnar) {
		this.childUnar = childUnar.split(",");
	}

	public String getMemberShipTerms() {
		return memberShipTerms;
	}

	public void setMemberShipTerms(String memberShipTerms) {
		this.memberShipTerms = memberShipTerms;
	}

	public String getOnlineTerms() {
		return onlineTerms;
	}

	public void setOnlineTerms(String onlineTerms) {
		this.onlineTerms = onlineTerms;
	}

	public String getMemberInfoTerms() {
		return memberInfoTerms;
	}

	public void setMemberInfoTerms(String memberInfoTerms) {
		this.memberInfoTerms = memberInfoTerms;
	}

	public String getOfferMemberInfoTerms() {
		return offerMemberInfoTerms;
	}

	public void setOfferMemberInfoTerms(String offerMemberInfoTerms) {
		this.offerMemberInfoTerms = offerMemberInfoTerms;
	}

	public String getInputOldPassword() {
		return inputOldPassword;
	}

	public void setInputOldPassword(String inputOldPassword) {
		this.inputOldPassword = inputOldPassword;
	}

	public String getCurrentSiteCode() {
		return currentSiteCode;
	}

	public void setCurrentSiteCode(String currentSiteCode) {
		this.currentSiteCode = currentSiteCode;
	}

	public String getOutSiteCode() {
		return outSiteCode;
	}

	public void setOutSiteCode(String outSiteCode) {
		this.outSiteCode = outSiteCode;
	}

	public String getOperDate() {
		return operDate;
	}

	public void setOperDate(String operDate) {
		this.operDate = operDate;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public String getPartnerUrl() {
		return partnerUrl;
	}

	public void setPartnerUrl(String partnerUrl) {
		this.partnerUrl = partnerUrl;
	}

	public String getPartnerName() {
		return partnerName;
	}

	public void setPartnerName(String partnerName) {
		this.partnerName = partnerName;
	}

}
