package com.eland.ngoc.point.model;

import com.eland.ngoc.common.model.Value;

/**
 * 포인트 적립/사용 EIMS API 호출을 위한 공통 model
 * @author lee.jaehak
 */
public class CustPointHandle {
	/**
	 * User Web ID
	 */
	private String webId;
	/**
	 * 지점 코드
	 */
	private String branchCode;
	/**
	 * 적립/사용 or 취소여부
	 */
	private String cancelYn;
	/**
	 * 포인트 구분 ID
	 */
	private String pointType;

	public String getWebId() {
		return webId;
	}
	@Value(required=true, length=20)
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getBranchCode() {
		return branchCode;
	}
	@Value(required=true, length=6)
	public void setBranchCode(String branchCode) {
		this.branchCode = branchCode;
	}
	public String getCancelYn() {
		return cancelYn;
	}
	@Value(required=true, length=1)
	public void setCancelYn(String cancelYn) {
		this.cancelYn = cancelYn.toUpperCase();
	}
	public String getPointType() {
		return pointType;
	}
	@Value(required=true, length=10)
	public void setPointType(String pointType) {
		this.pointType = pointType;
	}
}
