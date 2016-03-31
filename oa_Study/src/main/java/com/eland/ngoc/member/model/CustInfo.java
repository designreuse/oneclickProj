package com.eland.ngoc.member.model;

import com.eland.ngoc.common.model.BaseModel;

/**
 * <pre>
 * 회원 정보 모델
 *
 */
public class CustInfo extends BaseModel {

	int custId;
	String webId;
	String webPwd;
	String pbpId;
	String custName;
	String custStat;
	String insSiteCode;
	String pwdChngDate;
	String mberInfoUpdDate;
	String delYn;
	String bforWebPwd;
	String tempPwdYn;
	String joinYn;
	String validPwd;
	String longTermPwdYn;
	String membState;
	
	public String getValidPwd() {
		return validPwd;
	}
	public void setValidPwd(String validPwd) {
		this.validPwd = validPwd;
	}
	public int getCustId() {
		return custId;
	}
	public void setCustId(int custId) {
		this.custId = custId;
	}
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getWebPwd() {
		return webPwd;
	}
	public void setWebPwd(String webPwd) {
		this.webPwd = webPwd;
	}
	public String getPbpId() {
		return pbpId;
	}
	public void setPbpId(String pbpId) {
		this.pbpId = pbpId;
	}
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getInsSiteCode() {
		return insSiteCode;
	}
	public void setInsSiteCode(String insSiteCode) {
		this.insSiteCode = insSiteCode;
	}
	public String getPwdChngDate() {
		return pwdChngDate;
	}
	public void setPwdChngDate(String pwdChngDate) {
		this.pwdChngDate = pwdChngDate;
	}
	public String getMberInfoUpdDate() {
		return mberInfoUpdDate;
	}
	public void setMberInfoUpdDate(String mberInfoUpdDate) {
		this.mberInfoUpdDate = mberInfoUpdDate;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	public String getBforWebPwd() {
		return bforWebPwd;
	}
	public void setBforWebPwd(String bforWebPwd) {
		this.bforWebPwd = bforWebPwd;
	}
	public String getJoinYn() {
		return joinYn;
	}
	public void setJoinYn(String joinYn) {
		this.joinYn = joinYn;
	}
	public String getCustStat() {
		return custStat;
	}
	public void setCustStat(String custStat) {
		this.custStat = custStat;
	}
	public String getTempPwdYn() {
		return tempPwdYn;
	}
	public void setTempPwdYn(String tempPwdYn) {
		this.tempPwdYn = tempPwdYn;
	}
	public String getLongTermPwdYn() {
		return longTermPwdYn;
	}
	public void setLongTermPwdYn(String longTermPwdYn) {
		this.longTermPwdYn = longTermPwdYn;
	}
	public String getMembState() {
		return membState;
	}
	public void setMembState(String membState) {
		this.membState = membState;
	}
	
}
