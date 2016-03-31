package com.eland.ngoc.member.model;

public class MemberGet extends MemberBase {
	/**
	 * 결과 코드
	 */
	private String resultCode;
	/**
	 * 에러 코드
	 */
	private String errorCode;
	/**
	 * 에러 메세지
	 */
	private String errorMsg;
	/**
	 * 고객 고유 ID
	 */
	private String custId;
	/**
	 * 고객이름
	 */
	private String membName;
	/**
	 * 회원등급
	 */
	private String membGrade;
	/**
	 * 가입경로
	 */
	private String joinRoute;
	/**
	 * 가입일자
	 */
	private String joinDate;
	/**
	 * 비밀번호 변경일
	 */
	private String webPwdCDate;
	/**
	 * 회원정보 수정일
	 */
	private String membInfoUDate;
	/**
	 * 최종 로그인 일자
	 */
	private String lastLoginDate;
	/**
	 * 생일 유형
	 */
	private String birthdayType;
	/**
	 * 성별
	 */
	private String gender;
	/**
	 * 총 누적 포인트
	 */
	private int allPoints;
	/**
	 * 총 가용 포인트
	 */
	private int validPoints;
	/**
	 * 탈퇴 여부
	 */
	private String outYn;

	public String getResultCode() {
		return resultCode;
	}
	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}
	public String getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
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
	public String getWebPwdCDate() {
		return webPwdCDate;
	}
	public void setWebPwdCDate(String webPwdCDate) {
		this.webPwdCDate = webPwdCDate;
	}
	public String getMembInfoUDate() {
		return membInfoUDate;
	}
	public void setMembInfoUDate(String membInfoUDate) {
		this.membInfoUDate = membInfoUDate;
	}
	public String getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(String lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
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
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getAllPoints() {
		return allPoints;
	}
	public void setAllPoints(int allPoints) {
		this.allPoints = allPoints;
	}
	public int getValidPoints() {
		return validPoints;
	}
	public void setValidPoints(int validPoints) {
		this.validPoints = validPoints;
	}
	public String getOutYn() {
		return outYn;
	}
	public void setOutYn(String outYn) {
		this.outYn = outYn;
	}
}
