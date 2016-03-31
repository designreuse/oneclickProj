package com.eland.ngoc.point.model;

import java.util.List;

import com.eland.ngoc.common.model.Result;

public class CustPointInfoRsp extends Result {
	/**
	 * 총 누적 포인트
	 */
	private int allPoints;
	/**
	 * 총 가용 포인트
	 */
	private int validPoints;
	/**
	 * 고객 포인트 이력
	 */
	private List<CustPointItem> pointHistory;

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
	public List<CustPointItem> getPointHistory() {
		return pointHistory;
	}
	public void setPointHistory(List<CustPointItem> pointHistory) {
		this.pointHistory = pointHistory;
	}
}
