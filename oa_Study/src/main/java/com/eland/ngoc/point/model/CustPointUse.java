package com.eland.ngoc.point.model;

import com.eland.ngoc.common.model.Value;

/**
 * 포인트 사용/취소 EIMS API 호출을 위한 model
 * @author lee.jaehak
 */
public class CustPointUse extends CustPointHandle {
	/**
	 * 사용 또는 취소할 포인트값
	 */
	private String usePoint;
	/**
	 * 포인트 사용 또는 취소 상세내역
	 */
	private String useDesc;

	public String getUsePoint() {
		return usePoint;
	}
	@Value(required=true, onlyNum=true)
	public void setUsePoint(String usePoint) {
		this.usePoint = usePoint;
	}
	public String getUseDesc() {
		return useDesc;
	}
	public void setUseDesc(String useDesc) {
		this.useDesc = useDesc;
	}
}
