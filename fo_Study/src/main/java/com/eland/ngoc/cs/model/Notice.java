package com.eland.ngoc.cs.model;

public class Notice {

	/**
	 * 유형 구분
	 */
	String ntceTypeDiv;
	/**
	 * 순번
	 */
	int ntceSeq;
	/**
	 * 게시물 제목
	 */
	String ntceTitle;
	/**
	 * 게시물 내용
	 */
	String ntceCont;
	/**
	 * 등록일
	 */
	String insDate;
	/**
	 * 등록자
	 */
	String insUser;
	/**
	 * 수정일
	 */
	String updDate;
	/**
	 * 수정자
	 */
	String updUser;
	/**
	 * 게시물 (재정렬)순번
	 */
	String ntceNo;
	
	/**
	 * 메인 공지 노출 여부
	 */
	String mainNtceYn;
	

	public String getMainNtceYn() {
		return mainNtceYn;
	}

	public void setMainNtceYn(String mainNtceYn) {
		this.mainNtceYn = mainNtceYn;
	}

	public String getNtceTypeDiv() {
		return ntceTypeDiv;
	}

	public void setNtceTypeDiv(String ntceTypeDiv) {
		this.ntceTypeDiv = ntceTypeDiv;
	}

	public int getNtceSeq() {
		return ntceSeq;
	}

	public void setNtceSeq(int ntceSeq) {
		this.ntceSeq = ntceSeq;
	}

	public String getNtceTitle() {
		return ntceTitle;
	}

	public void setNtceTitle(String ntceTitle) {
		this.ntceTitle = ntceTitle;
	}

	public String getNtceCont() {
		return ntceCont;
	}

	public void setNtceCont(String ntceCont) {
		this.ntceCont = ntceCont;
	}

	public String getInsDate() {
		return insDate;
	}

	public void setInsDate(String insDate) {
		this.insDate = insDate;
	}

	public String getInsUser() {
		return insUser;
	}

	public void setInsUser(String insUser) {
		this.insUser = insUser;
	}

	public String getUpdDate() {
		return updDate;
	}

	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}

	public String getUpdUser() {
		return updUser;
	}

	public void setUpdUser(String updUser) {
		this.updUser = updUser;
	}

	public String getNtceNo() {
		return ntceNo;
	}

	public void setNtceNo(String ntceNo) {
		this.ntceNo = ntceNo;
	}

}
