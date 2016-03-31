package com.eland.ngoc.point.model;

import com.eland.ngoc.common.model.Value;

/**
 * 포인트 조회 Request model 
 * @author lee.jaehak
 */
public class CustPointInfo {
	/**
	 * User Web ID
	 */
	private String webId;
	/**
	 * 조회 시작일시
	 */
	private String startDate;
	/**
	 * 조회 종료일시
	 */
	private String endDate;

	public String getWebId() {
		return webId;
	}
	@Value(required=true, length=20)
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getStartDate() {
		return startDate;
	}
	@Value(required=true, length=8, onlyNum=true)
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	@Value(required=true, length=8, onlyNum=true)
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
}
