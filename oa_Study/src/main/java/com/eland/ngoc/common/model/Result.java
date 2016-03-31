package com.eland.ngoc.common.model;

public class Result {
	/**
	 * 처리결과 코드
	 */
	private String resultCode;
	/**
	 * 에러발생시 에러 코드
	 */
	private String errorCode;
	/**
	 * 에러발생시 에러 메세지
	 */
	private String errorMsg;

	public String getResultCode() {
		return resultCode;
	}
	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}
	public String getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
}
