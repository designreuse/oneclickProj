package com.eland.ngoc.member.dao;

import java.util.List;
import java.util.Map;

import com.eland.ngoc.common.model.MemberIds;
import com.eland.ngoc.member.model.AutoLoginToken;
import com.eland.ngoc.member.model.CustInfo;
import com.eland.ngoc.member.model.Member;
import com.eland.ngoc.member.model.MemberOut;
import com.eland.ngoc.member.model.MemberUpdOc;

public interface MemberDao {
	
	String sqlPrefix = MemberDao.class.getCanonicalName() + ".";
	
	public MemberIds getCustInfoIds(String custId, String webId);
	
	public String getCustOutCancelCanYn(String custId);
	
	public Map<String, String> getMemberInfo(String custId);
	
	public Map<String, String> getMemberSiteInfo(String custId, String siteCd);
	
	public int updateMemberInfo(MemberUpdOc member);
	
	public int updateMemberSiteInfo(MemberUpdOc member);
	
	public int updateMemberState(Map<String, String> paramMap);
	
	public List<String> getCustSiteInfoList(String custId);
	
	public int getMaxOutOrderNo(MemberOut memberOut);
	
	public int insertOcCustOutDtls(MemberOut memberOut);
	
	public int insertOcCustOutRson(Map<String, Object> paramMap);
	
	public int updateOcCustLastLogin(String custId, String siteCode);
	
	public int updateOcCustSiteInfo(Map<String, String> paramMap);
	
	public AutoLoginToken selectAutoLoginToken(String aLoginUid, String loginToken);
	
	public int updateAutoLoginToken(AutoLoginToken autoLoginToken);
	
	public Member getMemberInfoByWebId(String webId);
	
	public CustInfo selectCustStateInfo(String custId, String siteCode);
	
	public int insertLastLoginHistory(String custId, String siteCode);
	
	public int updateLastLoginHistory(String custId, String siteCode);
	
	public int selectLastLoginHistory(String custId);
	
	public int deleteAutoLoginToken(String webId);
}
