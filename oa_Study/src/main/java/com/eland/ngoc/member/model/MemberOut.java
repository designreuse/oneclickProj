package com.eland.ngoc.member.model;

import com.eland.ngoc.common.model.MemberIds;
import com.eland.ngoc.common.model.Value;

/**
 * <pre>
 * 회원 탈퇴 내부처리용 모델
 * 생성일 : 2016. 2. 3
 * </pre>
 * @author lee.jaehak
 */
public class MemberOut extends MemberIds {
	/**
	 * 탈퇴 유형 
	 */
	private String outType;
	/**
	 * 탈퇴 구분 
	 */
	private String outDiv;
	/**
	 * 탈퇴 상세
	 */
	private String outDesc;
	/**
	 * 사유코드
	 */
	private String outReasons;
	/**
	 * 탈퇴 처리 직원 ID
	 */
	private String empId;
	/**
	 * 탈퇴 사이트 코드
	 */
	private String siteCode;
	/**
	 * 탈퇴 순번
	 */
	private int outSeq;
	/**
	 * 등록자(원클릭 DB용)
	 */
	private String insUser;

	public String getOutType() {
		return outType;
	}
	@Value(required=true, length=2)
	public void setOutType(String outType) {
		this.outType = outType;
	}
	public String getOutDiv() {
		return outDiv;
	}
	@Value(required=true, length=2)
	public void setOutDiv(String outDiv) {
		this.outDiv = outDiv;
	}
	public String getOutDesc() {
		return outDesc;
	}
	@Value(required=false, length=3000)
	public void setOutDesc(String outDesc) {
		this.outDesc = outDesc;
	}
	public String getOutReasons() {
		return outReasons;
	}
	@Value(required=false, length=30)
	public void setOutReasons(String outReasons) {
		this.outReasons = outReasons;
	}
	public String getEmpId() {
		return empId;
	}
	@Value(required=false, length=50)
	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getSiteCode() {
		return siteCode;
	}
	public void setSiteCode(String siteCode) {
		this.siteCode = siteCode;
	}
	public int getOutSeq() {
		return outSeq;
	}
	public void setOutSeq(int outSeq) {
		this.outSeq = outSeq;
	}
	public String getInsUser() {
		return insUser;
	}
	public void setInsUser(String insUser) {
		this.insUser = insUser;
	}
}
