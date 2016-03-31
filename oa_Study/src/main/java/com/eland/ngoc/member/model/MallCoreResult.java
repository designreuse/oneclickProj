package com.eland.ngoc.member.model;

import com.eland.ngoc.common.model.Result;

public class MallCoreResult extends Result {
	/**
	 * 탈퇴 가능여부
	 */
	private String outPossibleYn;
	/**
	 * 탈퇴 불가 사유
	 */
	private String outImpossibleReason;

	public String getOutPossibleYn() {
		return outPossibleYn;
	}
	public void setOutPossibleYn(String outPossibleYn) {
		this.outPossibleYn = outPossibleYn;
	}
	public String getOutImpossibleReason() {
		return outImpossibleReason;
	}
	public void setOutImpossibleReason(String outImpossibleReason) {
		this.outImpossibleReason = outImpossibleReason;
	}
}
