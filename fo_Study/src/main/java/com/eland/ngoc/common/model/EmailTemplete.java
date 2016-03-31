package com.eland.ngoc.common.model;

public class EmailTemplete extends BaseModel {
	
	private int templeteSeq;
	private String templType;
	private String templTitle;
	private String templCont;
	private String useYn;
	
	public int getTempleteSeq() {
		return templeteSeq;
	}
	public void setTempleteSeq(int templeteSeq) {
		this.templeteSeq = templeteSeq;
	}
	public String getTemplType() {
		return templType;
	}
	public void setTemplType(String templType) {
		this.templType = templType;
	}
	public String getTemplTitle() {
		return templTitle;
	}
	public void setTemplTitle(String templTitle) {
		this.templTitle = templTitle;
	}
	public String getTemplCont() {
		return templCont;
	}
	public void setTemplCont(String templCont) {
		this.templCont = templCont;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
}
