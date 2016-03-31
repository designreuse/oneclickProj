package com.eland.ngoc.member.model;

import java.util.List;

/**
 * <pre>
 * 회원 정보 모델
 *
 */
public class Member {

	/**
	 * 회원 ID
	 */
	String custId;
	/**
	 * 회원 이름
	 */
	String membName;
	/**
	 * 회원 웹 ID
	 */
	String webId;
	/**
	 * 회원 웹 비밀번호
	 */
	String webPwd;
	/**
	 * 회원 상태
	 */
	String membState;
	/**
	 * 회원 등급
	 */
	String membGrade;
	/**
	 * 최초 가입지점
	 */
	String joinRoute;
	/**
	 * 가입일자
	 */
	String joinDate;
	/**
	 * 본인 인증 유형
	 */
	String authType;
	/**
	 * 비밀번호 변경일
	 */
	String webPwdCDate;
	/**
	 * 회원정보 수정일
	 */
	String memberInfoUDate;
	/**
	 * 생년월일
	 */
	String birthYear;
	String birthMonth;
	String birthDay;
	/**
	 * 생년월일 양/음력
	 */
	String birthUnar;
	/**
	 * 회원 성별
	 */
	String gender;
	/**
	 * 휴대폰번호
	 */
	String mobileNo1;
	String mobileNo2;
	String mobileNo3;
	/**
	 * 우편번호
	 */
	String zipCode;
	/**
	 * 주소1
	 */
	String addr1;
	/**
	 * 주소2(상세주소)
	 */
	String addr2;
	/**
	 * 선택 주소
	 */
	String selectAddr;
	/**
	 * 이메일 주소
	 */
	String email1;
	String email2;
	/**
	 * EMAIL 수신 동의 여부
	 */
	String retailMallEmailYn;
	String coreEmailYn;
	/**
	 * SMS 수신 동의 여부
	 */
	String retailMallSmsYn;
	String coreSmsYn;
	/**
	 * DM 수신 동의 여부
	 */
	String coreDmYn;
	/**
	 * EDM 수신 동의 여부
	 */
	String coreEdmYn;
	/**
	 * 결혼 유무
	 */
	String weddingYn;
	/**
	 * 결혼 기념일
	 */
	String weddingYear;
	String weddingMonth;
	String weddingDay;
	/**
	 * 자녀 수
	 */
	String childNum;
	/**
	 * 자녀 정보_List
	 */
	List<MemberChildInfos> children;

	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getMembName() {
		return membName;
	}

	public void setMembName(String membName) {
		this.membName = membName;
	}

	public String getWebId() {
		return webId;
	}

	public void setWebId(String webId) {
		this.webId = webId;
	}

	public String getWebPwd() {
		return webPwd;
	}

	public void setWebPwd(String webPwd) {
		this.webPwd = webPwd;
	}

	public String getMembState() {
		return membState;
	}

	public void setMembState(String membState) {
		this.membState = membState;
	}

	public String getMembGrade() {
		return membGrade;
	}

	public void setMembGrade(String membGrade) {
		this.membGrade = membGrade;
	}

	public String getJoinRoute() {
		return joinRoute;
	}

	public void setJoinRoute(String joinRoute) {
		this.joinRoute = joinRoute;
	}

	public String getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}

	public String getAuthType() {
		return authType;
	}

	public void setAuthType(String authType) {
		this.authType = authType;
	}

	public String getWebPwdCDate() {
		return webPwdCDate;
	}

	public void setWebPwdCDate(String webPwdCDate) {
		this.webPwdCDate = webPwdCDate;
	}

	public String getMemberInfoUDate() {
		return memberInfoUDate;
	}

	public void setMemberInfoUDate(String memberInfoUDate) {
		this.memberInfoUDate = memberInfoUDate;
	}

	public String getBirthYear() {
		return birthYear;
	}

	public void setBirthYear(String birthYear) {
		this.birthYear = birthYear;
	}

	public String getBirthMonth() {
		return birthMonth;
	}

	public void setBirthMonth(String birthMonth) {
		this.birthMonth = birthMonth;
	}

	public String getBirthDay() {
		return birthDay;
	}

	public void setBirthDay(String birthDay) {
		this.birthDay = birthDay;
	}

	public String getBirthUnar() {
		return birthUnar;
	}

	public void setBirthUnar(String birthUnar) {
		this.birthUnar = birthUnar;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getMobileNo1() {
		return mobileNo1;
	}

	public void setMobileNo1(String mobileNo1) {
		this.mobileNo1 = mobileNo1;
	}

	public String getMobileNo2() {
		return mobileNo2;
	}

	public void setMobileNo2(String mobileNo2) {
		this.mobileNo2 = mobileNo2;
	}

	public String getMobileNo3() {
		return mobileNo3;
	}

	public void setMobileNo3(String mobileNo3) {
		this.mobileNo3 = mobileNo3;
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

	public String getSelectAddr() {
		return selectAddr;
	}

	public void setSelectAddr(String selectAddr) {
		this.selectAddr = selectAddr;
	}

	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
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

	public String getCoreDmYn() {
		return coreDmYn;
	}

	public void setCoreDmYn(String coreDmYn) {
		this.coreDmYn = coreDmYn;
	}

	public String getCoreEdmYn() {
		return coreEdmYn;
	}

	public void setCoreEdmYn(String coreEdmYn) {
		this.coreEdmYn = coreEdmYn;
	}

	public String getWeddingYn() {
		return weddingYn;
	}

	public void setWeddingYn(String weddingYn) {
		this.weddingYn = weddingYn;
	}

	public String getWeddingYear() {
		return weddingYear;
	}

	public void setWeddingYear(String weddingYear) {
		this.weddingYear = weddingYear;
	}

	public String getWeddingMonth() {
		return weddingMonth;
	}

	public void setWeddingMonth(String weddingMonth) {
		this.weddingMonth = weddingMonth;
	}

	public String getWeddingDay() {
		return weddingDay;
	}

	public void setWeddingDay(String weddingDay) {
		this.weddingDay = weddingDay;
	}

	public String getChildNum() {
		return childNum;
	}

	public void setChildNum(String childNum) {
		this.childNum = childNum;
	}

	public List<MemberChildInfos> getChildren() {
		return children;
	}

	public void setChildren(List<MemberChildInfos> children) {
		this.children = children;
	}

}
