package com.eland.ngoc.member.model;

import com.eland.ngoc.common.model.Value;

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
	private String childName;
	/**
	 * 자녀 성별
	 */
	private String childGender;
	/**
	 * 자녀 생일
	 */
	private String childBirthday;
	/**
	 * 자녀 생일 양/음력 구분
	 */
	private String childUnar;

	public String getChildName() {
		return childName;
	}
	@Value(length=10)
	public void setChildName(String childName) {
		this.childName = childName;
	}
	public String getChildGender() {
		return childGender;
	}
	@Value(length=1)
	public void setChildGender(String childGender) {
		this.childGender = childGender;
	}
	public String getChildBirthday() {
		return childBirthday;
	}
	@Value(length=8, onlyNum=true)
	public void setChildBirthday(String childBirthday) {
		this.childBirthday = childBirthday;
	}
	public String getChildUnar() {
		return childUnar;
	}
	@Value(length=1)
	public void setChildUnar(String childUnar) {
		this.childUnar = childUnar;
	}

}
