package com.eland.ngoc.point.model;

/**
 * 포인트 조회 결과 이력항목을 위한 model
 * @author lee.jaehak
 */
public class CustPointItem {
	/**
	 * 포인트이력: 거래일시
	 */
	private String transDate;
	/**
	 * 포인트이력: 거래구분
	 */
	private String transType;
	/**
	 * 포인트이력: 거래내역
	 */
	private String transDesc;
	/**
	 * 포인트이력: 포인트
	 */
	private int point;

	public String getTransDate() {
		return transDate;
	}
	public void setTransDate(String transDate) {
		this.transDate = transDate;
	}
	public String getTransType() {
		return transType;
	}
	public void setTransType(String transType) {
		this.transType = transType;
	}
	public String getTransDesc() {
		return transDesc;
	}
	public void setTransDesc(String transDesc) {
		this.transDesc = transDesc;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
}
