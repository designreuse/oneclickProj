package com.eland.ngoc.member.model;

import com.eland.ngoc.common.OneClickConstants;
import com.eland.ngoc.common.model.Provisioning;

public class MemberOutDTO {

	String custId;
	String siteCode;
	int outSeq;
	String webId;
	String pbpId;
	String outDivCode;
	String outDesc;
	String outRsonCode;

	String custStat;
	String outSiteCodes;
	String outReasons;
	String selectMenu;
	String outReasonCodeGroupId = OneClickConstants.CODE_GROUP_ID_OUT_REASON;

	// provisioning, email 발송용 정보
	String mallOutYn;
	String retailOutYn;
	String outDate;

	public String getCustId() {
		return custId;
	}

	@Provisioning(notiYn = true, type={"out"})
	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getSiteCode() {
		return siteCode;
	}

	public void setSiteCode(String siteCode) {
		this.siteCode = siteCode;
	}

	public int getOutSeq() {
		return outSeq;
	}

	public void setOutSeq(int outSeq) {
		this.outSeq = outSeq;
	}

	public String getWebId() {
		return webId;
	}

	@Provisioning(notiYn = true, type={"out"})
	public void setWebId(String webId) {
		this.webId = webId;
	}

	public String getPbpId() {
		return pbpId;
	}

	public void setPbpId(String pbpId) {
		this.pbpId = pbpId;
	}

	public String getOutDivCode() {
		return outDivCode;
	}

	public void setOutDivCode(String outDivCode) {
		this.outDivCode = outDivCode;
	}

	public String getOutDesc() {
		return outDesc;
	}

	public void setOutDesc(String outDesc) {
		this.outDesc = outDesc;
	}

	public String getOutRsonCode() {
		return outRsonCode;
	}

	public void setOutRsonCode(String outRsonCode) {
		this.outRsonCode = outRsonCode;
	}

	public String getCustStat() {
		return custStat;
	}

	public void setCustStat(String custStat) {
		this.custStat = custStat;
	}

	public String getOutSiteCodes() {
		return outSiteCodes;
	}

	public void setOutSiteCodes(String outSiteCodes) {
		this.outSiteCodes = outSiteCodes;
	}

	public String getOutReasons() {
		return outReasons;
	}

	public void setOutReasons(String outReasons) {
		this.outReasons = outReasons;
	}

	public String getSelectMenu() {
		return selectMenu;
	}

	public void setSelectMenu(String selectMenu) {
		this.selectMenu = selectMenu;
	}

	public String getOutReasonCodeGroupId() {
		return outReasonCodeGroupId;
	}

	public void setOutReasonCodeGroupId(String outReasonCodeGroupId) {
		this.outReasonCodeGroupId = outReasonCodeGroupId;
	}

	public String getMallOutYn() {
		return mallOutYn;
	}

	@Provisioning(notiYn = true, type={"out"})
	public void setMallOutYn(String mallOutYn) {
		this.mallOutYn = mallOutYn;
	}

	public String getRetailOutYn() {
		return retailOutYn;
	}

	@Provisioning(notiYn = true, type={"out"})
	public void setRetailOutYn(String retailOutYn) {
		this.retailOutYn = retailOutYn;
	}

	public String getOutDate() {
		return outDate;
	}
	
	@Provisioning(notiYn = true, type={"out"})
	public void setOutDate(String outDate) {
		this.outDate = outDate;
	}

}
