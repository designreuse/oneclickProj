package com.eland.ngoc.member.service;

import java.util.Map;

import com.eland.ngoc.member.model.AuthDtls;
import com.eland.ngoc.member.model.AutoLoginToken;
import com.eland.ngoc.member.model.CustInfo;
import com.eland.ngoc.member.model.CustSiteInfo;
import com.eland.ngoc.member.model.Ipin;
import com.eland.ngoc.member.model.Member;
import com.eland.ngoc.member.model.MemberDTO;
import com.eland.ngoc.member.model.MemberOutDTO;
import com.eland.ngoc.member.model.Pcc;


public interface MemberService {

	public Boolean isCheckId(String webId, String checkType);
	
	public Member getMemberInfo(String webId, String ci) throws Exception;
	
	public CustInfo selectCustInfoCheck(String webId, String webPwd);
	
	public String getMemberPwd(String custId);
	
	public String getMemberUsedPwd(String custId);
	
	public void txUpdateMember(MemberDTO memberDto, CustSiteInfo custSiteInfo);
	
	public int updateMemberInfo(MemberDTO memberDTO);
	
	public int updateMemberSiteInfoRetailMall(MemberDTO memberDTO);
	
	public int updateMemberSiteInfoCore(MemberDTO memberDTO);
	
	public String saveMemberInfo(MemberDTO memberDTO, String siteCode, boolean isExistsMember);
	
	public Pcc setPcc(String phoneCertId, String srvNo, String returnUrl);
	
	public Pcc getPcc(String reqPccNum, String retInfo);
	
	public Ipin setIpin(String ipinCertId, String ipinSrvNo, String returnUrl);
	
	public Ipin getIpin(String reqPccNum, String retInfo);
	
	public int insertAuthDtls(AuthDtls authDtls);
	
	public Map<String, String> getCustnPbpId(String webId);
	
	public void txOutMember(MemberOutDTO memberOutDto);
	
	public void sendOutSms(String type, String mobileNo, String name);
	
	public int getOutSeq(MemberOutDTO memberOutDto);
	
	public int saveMemberOutDetail(MemberOutDTO memberOutDto);
	
	public int saveMemberOutReason(MemberOutDTO memberOutDto);
	
	public CustInfo getFindMemberInfo(String ci, String custName);
	
	public int updateMemberStat(String custId, String custStat, String webPwd, String tempPwdYn);
	
	public int updateMemberSiteInfo(String custId, String siteCode);
	
	public AutoLoginToken saveAutoLoginToken(String webId);
	
	public Map<String, String> autoLogin(String aLoginUid, String loginToken);
	
	public void deleteAutoLoginToken(String webId);
	
	public void saveLastLoginHistory(String custId, String siteCode);
	
	public String selectCustStateInfo(String custId, String siteCode);
	
	public void updatePwdChangeDate(String webId);
	
	public void updateTempPwdYn(String webId);
	
	public void addSite(String custId, String emailYn, String smsYn,String dmYn, String siteCode);
	
	public void termiteDormancy(String custId, String siteCode);
	
	public void cancelSecession(String custId, String emailYn, String smsYn, String dmYn, String siteCode);
	
	public String getPbpId(String custId);
	
	public String checkAccessToken(String accessToken);
	
	public CustInfo selectCustInfoByCustId(String custId);
	
	public String sendSearchPwdMailOrSms(String type, String webId, String pbpId, String tempPassword);
	
	public int getCustInfoCnt(String webId);
	
}