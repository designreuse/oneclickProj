package com.eland.ngoc.exception;

import com.eland.ngoc.common.utils.StringUtil;

public class UserHandleException extends RuntimeException {
	private static final long serialVersionUID = 1L;
	private String msg;
	private String args;

	public UserHandleException(String errorCode) {
		super(errorCode);
	}

	public UserHandleException(String errorCode, String args) {
		super(errorCode);
		this.msg = args;
	}
	
	public UserHandleException(String errorCode, String args, String descMsg) {
		super(errorCode);
		this.msg = addDescMsg(args, descMsg);
		this.args = args;
	}

	public String getArgs() {
		return this.args;
	}
	
	public String getMsgDesc() {
		return this.msg;
	}
	
	private String addDescMsg(String args, String descMsg) {
		StringBuffer strBuff = null;
		if (StringUtil.isEmpty(args)) {
			strBuff = new StringBuffer(args);
			strBuff.append("(" + descMsg + ")");		
		} else {
			strBuff = new StringBuffer();
			strBuff.append("(" + descMsg + ")");
		}
		
		return strBuff.toString();
	}
}
