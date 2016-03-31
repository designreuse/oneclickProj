package com.eland.ngoc.member.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.eland.ngoc.common.model.Result;
import com.eland.ngoc.member.model.MemberGet;
import com.eland.ngoc.member.model.MemberOut;

public interface MemberService {

	public Result updateMemberInfo(HttpServletRequest request);
	
	public MemberGet getMemberInfo(HttpServletRequest request);
	
	public Result updateMemberState(HttpServletRequest request);
	
	public Result membershipOut(HttpServletRequest request, MemberOut mbOut);
	
	public Result cancelMemberOut(HttpServletRequest request);
	
	public Map<String, String> autoLogin(String aLoginUid, String loginToken);
	
	public String selectCustStateInfo(String custId, String siteCode);
	
	public void saveLastLoginHistory(String custId, String siteCode);
	
	public void deleteAutoLoginToken(String webId);
}
