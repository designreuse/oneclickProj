package com.eland.ngoc.member.model;

public class MemberUpd extends MemberBase {
	/**
	 * 수정 경로
	 */
	private String updateRoute;
	/**
	 * 생일유형
	 */
	private String birthdayType;
	/**
	 * 우편번호: 정제지번 주소
	 */
	private String stdZipcode;
	/**
	 * 주소1: 정제지번 주소
	 */
	private String stdAddr1;
	/**
	 * 주소2: 정제지번 주소
	 */
	private String stdAddr2;
	/**
	 * 우편번호: 정제도로명 주소
	 */
	private String roadZipcode;
	/**
	 * 주소1: 정제도로명 주소
	 */
	private String roadAddr1;
	/**
	 * 주소2: 정제도로명 주소
	 */
	private String roadAddr2;

	public String getUpdateRoute() {
		return updateRoute;
	}
	public void setUpdateRoute(String updateRoute) {
		this.updateRoute = updateRoute;
	}
	public String getBirthdayType() {
		return birthdayType;
	}
	public void setBirthdayType(String birthdayType) {
		this.birthdayType = birthdayType;
	}
	public String getStdZipcode() {
		return stdZipcode;
	}
	public void setStdZipcode(String stdZipcode) {
		this.stdZipcode = stdZipcode;
	}
	public String getStdAddr1() {
		return stdAddr1;
	}
	public void setStdAddr1(String stdAddr1) {
		this.stdAddr1 = stdAddr1;
	}
	public String getStdAddr2() {
		return stdAddr2;
	}
	public void setStdAddr2(String stdAddr2) {
		this.stdAddr2 = stdAddr2;
	}
	public String getRoadZipcode() {
		return roadZipcode;
	}
	public void setRoadZipcode(String roadZipcode) {
		this.roadZipcode = roadZipcode;
	}
	public String getRoadAddr1() {
		return roadAddr1;
	}
	public void setRoadAddr1(String roadAddr1) {
		this.roadAddr1 = roadAddr1;
	}
	public String getRoadAddr2() {
		return roadAddr2;
	}
	public void setRoadAddr2(String roadAddr2) {
		this.roadAddr2 = roadAddr2;
	}
}
