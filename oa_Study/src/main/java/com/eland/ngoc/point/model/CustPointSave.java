package com.eland.ngoc.point.model;

import com.eland.ngoc.common.model.Value;

/**
 * 포인트 적립/취소 EIMS API 호출을 위한 model
 * @author lee.jaehak
 */
public class CustPointSave extends CustPointHandle {
	/**
	 * 적립 또는 취소할 포인트값
	 */
	private String addPoint;
	/**
	 * 포인트 적립 또는 취소 상세내역
	 */
	private String addDesc;

	public String getAddPoint() {
		return addPoint;
	}
	@Value(required=true, onlyNum=true)
	public void setAddPoint(String addPoint) {
		this.addPoint = addPoint;
	}
	public String getAddDesc() {
		return addDesc;
	}
	public void setAddDesc(String addDesc) {
		this.addDesc = addDesc;
	}
}
