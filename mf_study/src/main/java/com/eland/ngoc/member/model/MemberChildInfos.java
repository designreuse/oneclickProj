package com.eland.ngoc.member.model;

/**
 * <pre>
 * 회원 부가 정보_ 자녀 정보용 모델
 * 
 * 생성일 : 2016. 2. 2.
 * </pre>
 * 
 * @author kim.hyemi04
 *
 */
public class MemberChildInfos {

	/**
	 * 자녀 이름
	 */
	String childName;
	/**
	 * 자녀 성별
	 */
	String childGender;
	/**
	 * 자녀 생일
	 */
	String childBirthYear;
	String childBirthMonth;
	String childBirthDay;
	/**
	 * 자녀 생일 양/음력 구분
	 */
	String childUnar;

	public String getChildName() {
		return childName;
	}
	
	public void setChildName(String childName) {
		this.childName = childName;
	}

	public String getChildGender() {
		return childGender;
	}

	public void setChildGender(String childGender) {
		this.childGender = childGender;
	}

	public String getChildBirthYear() {
		return childBirthYear;
	}

	public void setChildBirthYear(String childBirthYear) {
		this.childBirthYear = childBirthYear;
	}

	public String getChildBirthMonth() {
		return childBirthMonth;
	}

	public void setChildBirthMonth(String childBirthMonth) {
		this.childBirthMonth = childBirthMonth;
	}

	public String getChildBirthDay() {
		return childBirthDay;
	}

	public void setChildBirthDay(String childBirthDay) {
		this.childBirthDay = childBirthDay;
	}

	public String getChildUnar() {
		return childUnar;
	}

	public void setChildUnar(String childUnar) {
		this.childUnar = childUnar;
	}

}
