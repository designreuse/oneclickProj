package com.eland.ngoc.member.model;

public class Pcc {

	/*
	 * ---------------------------------------------------------------------
	 * Instance fields.
	 * ---------------------------------------------------------------------
	 */
	String retInfo		= "";																// 결과정보

	String name			= "";                                                               //성명
	String sex			= "";																//성별
	String birYMD		= "";																//생년월일
	String fgnGbn		= "";																//내외국인 구분값

	String di			= "";																//DI
	String ci1			= "";																//CI
	String ci2			= "";																//CI
	String civersion    = "";                                                               //CI Version

	String reqNum		= "";                                                               // 본인확인 요청번호
	String result		= "";                                                               // 본인확인결과 (Y/N)
	String certDate		= "";                                                               // 검증시간
	String certGb		= "";                                                               // 인증수단
	String cellNo		= "";																// 핸드폰 번호
	String cellCorp		= "";																// 이동통신사
	String addVar		= "";
	
	String reqPccInfo;
	String reqPccNum;
	String retPccUrl;
	public String getRetInfo() {
		return retInfo;
	}
	public void setRetInfo(String retInfo) {
		this.retInfo = retInfo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getBirYMD() {
		return birYMD;
	}
	public void setBirYMD(String birYMD) {
		this.birYMD = birYMD;
	}
	public String getFgnGbn() {
		return fgnGbn;
	}
	public void setFgnGbn(String fgnGbn) {
		this.fgnGbn = fgnGbn;
	}
	public String getDi() {
		return di;
	}
	public void setDi(String di) {
		this.di = di;
	}
	public String getCi1() {
		return ci1;
	}
	public void setCi1(String ci1) {
		this.ci1 = ci1;
	}
	public String getCi2() {
		return ci2;
	}
	public void setCi2(String ci2) {
		this.ci2 = ci2;
	}
	public String getCiversion() {
		return civersion;
	}
	public void setCiversion(String civersion) {
		this.civersion = civersion;
	}
	public String getReqNum() {
		return reqNum;
	}
	public void setReqNum(String reqNum) {
		this.reqNum = reqNum;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getCertDate() {
		return certDate;
	}
	public void setCertDate(String certDate) {
		this.certDate = certDate;
	}
	public String getCertGb() {
		return certGb;
	}
	public void setCertGb(String certGb) {
		this.certGb = certGb;
	}
	public String getCellNo() {
		return cellNo;
	}
	public void setCellNo(String cellNo) {
		this.cellNo = cellNo;
	}
	public String getCellCorp() {
		return cellCorp;
	}
	public void setCellCorp(String cellCorp) {
		this.cellCorp = cellCorp;
	}
	public String getAddVar() {
		return addVar;
	}
	public void setAddVar(String addVar) {
		this.addVar = addVar;
	}
	public String getReqPccInfo() {
		return reqPccInfo;
	}
	public void setReqPccInfo(String reqPccInfo) {
		this.reqPccInfo = reqPccInfo;
	}
	public String getReqPccNum() {
		return reqPccNum;
	}
	public void setReqPccNum(String reqPccNum) {
		this.reqPccNum = reqPccNum;
	}
	public String getRetPccUrl() {
		return retPccUrl;
	}
	public void setRetPccUrl(String retPccUrl) {
		this.retPccUrl = retPccUrl;
	}
}
