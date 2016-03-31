package com.eland.ngoc.member.dao;

import java.util.List;
import java.util.Map;

import com.eland.ngoc.common.annotation.OnClickMapper;
import com.eland.ngoc.member.model.AuthDtls;
import com.eland.ngoc.member.model.AutoLoginToken;
import com.eland.ngoc.member.model.CustInfo;
import com.eland.ngoc.member.model.CustSiteInfo;
import com.eland.ngoc.member.model.CustTermsAgree;
import com.eland.ngoc.member.model.Member;
import com.eland.ngoc.member.model.MemberDTO;
import com.eland.ngoc.member.model.MemberOutDTO;

@OnClickMapper
public interface MemberDao {
	
	String sqlPrefix = MemberDao.class.getCanonicalName() + ".";
	
	public int isCheckId(String webId, String checkType);
	
	public Member getMemberInfo(String webId);
	
	public CustInfo selectCustInfoCheck(String webId, String webPwd);
	
	public String getMemberPwd(String custId);
	
	public String getMemberUsedPwd(String custId);
	
	public int updateMemberInfo(MemberDTO memberDto);
	
	public int updateMemberSiteInfoRetailMall(MemberDTO memberDto);
	
	public int updateMemberSiteInfoCore(MemberDTO memberDto);
	
	public int insertCustInfo(CustInfo custInfo);
	
	public int insertAuthDtls(AuthDtls authDtls);
	
	public Map<String, String> getCustnPbpId(String webId);
	
	public int selectOutSeq(MemberOutDTO memberOutDto);
	
	public int insertMemberOutDetail(MemberOutDTO memberOutDto);
	
	public int insertMemberOutReason(MemberOutDTO memberOutDto);

	public void insertCustTermsAgree(List<CustTermsAgree> custTermsAgreeList);
	
	public CustInfo getFindMemberInfo(String ci, String custName);
	
	public int updateMemberStat(String custId, String custStat, String webPwd, String tempPwdYn);
	
	public int updateMemberSiteInfo(CustSiteInfo custSiteInfo);
	
	public int mergeMemberSiteInfo(CustSiteInfo custSiteInfo);
	
	public int insertAutoLoginToken(AutoLoginToken autoLoginToken);
	
	public int updateAutoLoginToken(AutoLoginToken autoLoginToken);
	
	public int deleteAutoLoginToken(String webId);
	
	public AutoLoginToken selectAutoLoginToken(String aLoginUid, String loginToken);
	
	public int insertCustSiteInfo(CustSiteInfo custSiteInfo);
	
	public int insertLastLoginHistory(String custId, String siteCode);
	
	public int updateLastLoginHistory(String custId, String siteCode);
	
	public int selectLastLoginHistory(String custId);
	
	public CustInfo selectCustStateInfo(String custId, String siteCode);
	
	public int updatePwdChangeDate(String webId);
	
	public int updateTempPwdYn(String webId);
	
	public String getPbpId(String custId);
	
	public CustInfo selectCustInfoByCustId(String custId);
	
	public int getCustInfoCnt(String webId);
}
