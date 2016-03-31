package com.eland.ngoc.terms.model;

public class Terms {
	
	/**
	 *  약관 순번
	 */
	int termsSeq;
	/**
	 *  약관 코드
	 */
	String termsCode;
	/**
	 *  약관 버전
	 */
	String termsVer;
	/**
	 *  약관 내용
	 */
	String termsCont;
	/**
	 *  약관 동의 필수 여부
	 */
	String reqdYn;
	/**
	 *  공고일
	 */
	String pblanDate;
	/**
	 *  시행일
	 */
	String operDate;
	/**
	 *  사용 여부
	 */
	String useYn;
	/**
	 *  등록일
	 */
	String insDate;
	/**
	 *  등록자
	 */
	String insUser;
	/**
	 *  수정일
	 */
	String updDate;
	/**
	 *  수정자
	 */
	String updUser;
	/**
	 * 약관 수정 일자
	 * @return
	 */
	String termsUpdDate;
	
	
	
	public int getTermsSeq() {
		return termsSeq;
	}
	public void setTermsSeq(int termsSeq) {
		this.termsSeq = termsSeq;
	}
	public String getTermsCode() {
		return termsCode;
	}
	public void setTermsCode(String termsCode) {
		this.termsCode = termsCode;
	}
	public String getTermsVer() {
		return termsVer;
	}
	public void setTermsVer(String termsVer) {
		this.termsVer = termsVer;
	}
	public String getTermsCont() {
		return termsCont;
	}
	public void setTermsCont(String termsCont) {
		this.termsCont = termsCont;
	}
	public String getReqdYn() {
		return reqdYn;
	}
	public void setReqdYn(String reqdYn) {
		this.reqdYn = reqdYn;
	}
	public String getPblanDate() {
		return pblanDate;
	}
	public void setPblanDate(String pblanDate) {
		this.pblanDate = pblanDate;
	}
	public String getOperDate() {
		return operDate;
	}
	public void setOperDate(String operDate) {
		this.operDate = operDate;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
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
	public String getTermsUpdDate() {
		return termsUpdDate;
	}
	public void setTermsUpdDate(String termsUpdDate) {
		this.termsUpdDate = termsUpdDate;
	}
}
