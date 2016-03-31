package com.eland.ngoc.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.eland.ngoc.common.model.MemberIds;
import com.eland.ngoc.common.utils.StringUtil;
import com.eland.ngoc.member.model.AutoLoginToken;
import com.eland.ngoc.member.model.CustInfo;
import com.eland.ngoc.member.model.Member;
import com.eland.ngoc.member.model.MemberOut;
import com.eland.ngoc.member.model.MemberUpdOc;

@Repository
public class MemberDaoImpl implements MemberDao{

	private SqlSessionTemplate sqlSessionTemplate;

    @Autowired
    @Qualifier("primarySqlSessionTemplate")
    public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }
   
	@Override
	public MemberIds getCustInfoIds(String custId, String webId) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("custId", custId);
		param.put("webId", webId);

		return sqlSessionTemplate.selectOne(sqlPrefix + "getCustInfoIds", param);
	}
	
	@Override
	public String getCustOutCancelCanYn(String custId) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("custId", custId);

		return sqlSessionTemplate.selectOne(sqlPrefix + "getCustOutCancelCanYn", param);
	}
	
	@Override
	public Map<String, String> getMemberInfo(String custId) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("custId", custId);

		return sqlSessionTemplate.selectOne(sqlPrefix + "getMemberInfo", param);
	}
	
	@Override
	public Map<String, String> getMemberSiteInfo(String custId, String siteCd) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("custId", custId);
		param.put("siteCode", siteCd);

		return sqlSessionTemplate.selectOne(sqlPrefix + "getMemberSiteInfo", param);
	}
	
	@Override
	public int updateMemberInfo(MemberUpdOc member) {
		return sqlSessionTemplate.update(sqlPrefix + "updateMemberInfo", member);
	}
	
	@Override
	public int updateMemberSiteInfo(MemberUpdOc member) {
		return sqlSessionTemplate.update(sqlPrefix + "updateMemberSiteInfo", member);
	}
	
	@Override
	public int updateMemberState(Map<String, String> paramMap) {
		return sqlSessionTemplate.update(sqlPrefix + "updateMemberState", paramMap);
	}

	@Override
	public List<String> getCustSiteInfoList(String custId) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("custId", custId);

		return sqlSessionTemplate.selectList(sqlPrefix + "getCustSiteInfoList", param);
	}
	
	@Override
	public int getMaxOutOrderNo(MemberOut memberOut) {
		return sqlSessionTemplate.selectOne(sqlPrefix + "getMaxOutOrderNo", memberOut);
	}
	
	@Override
	public int insertOcCustOutDtls(MemberOut memberOut) {
		return sqlSessionTemplate.insert(sqlPrefix + "insertOcCustOutDtls", memberOut);
	}
	
	@Override
	public int insertOcCustOutRson(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert(sqlPrefix + "insertOcCustOutRson", paramMap);
	}
	
	@Override
	public int updateOcCustLastLogin(String custId, String siteCode) {
		Map<String, String> param = new HashMap<String, String>();
		param.put("custId", custId);
		param.put("siteCode", siteCode);

		return sqlSessionTemplate.update(sqlPrefix + "updateOcCustLastLogin", param);
	}
	
	@Override
	public int updateOcCustSiteInfo(Map<String, String> paramMap) {
		return sqlSessionTemplate.update(sqlPrefix + "updateOcCustSiteInfo", paramMap);
	}
	
	/**
	 *  자동 로그인 토큰 조회
	 */
	@Override
	public AutoLoginToken selectAutoLoginToken(String aLoginUid, String loginToken) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		
		param.put("alUid", aLoginUid);
		if (!StringUtil.isEmpty(loginToken)) {
			param.put("loginToken", loginToken);
		}
		
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectAutoLoginToken", param);
	}
	
	/**
	 *  자동 로그인 토큰 업데이트
	 */
	@Override
	public int updateAutoLoginToken(AutoLoginToken autoLoginToken) {
		return sqlSessionTemplate.update(sqlPrefix + "updateAutoLoginToken", autoLoginToken);
	}
	
	/**
	 *  회원 정보 조회
	 */
	@Override
	public Member getMemberInfoByWebId(String webId) {
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectMemberInfoByWebId", webId);
	}
	
	/**
	 * 회원 상태 조회
	 */
	@Override
	public CustInfo selectCustStateInfo(String custId, String siteCode) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("custId", custId);
		param.put("siteCode", siteCode);
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectCustStateInfo", param);
	}
	
	/**
	 *  최종 로그인 내역 저장
	 */
	@Override
	public int insertLastLoginHistory(String custId, String siteCode) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("custId", custId);
		param.put("siteCode", siteCode);
		
		int temp = sqlSessionTemplate.insert(sqlPrefix + "insertLastLoginHistory", param);
		return temp;
	}
	/**
	 *  최종 로그인 내역 수정
	 */
	@Override
	public int updateLastLoginHistory(String custId, String siteCode) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("custId", custId);
		param.put("siteCode", siteCode);
		return sqlSessionTemplate.update(sqlPrefix + "updateLastLoginHistory", param);
	}
	/**
	 *  최종 로그인 내역 조회
	 */
	@Override
	public int selectLastLoginHistory(String custId) {
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectLastLoginHistory", custId);
	}
	
	/**
	 *  자동 로그인 토큰 삭제
	 */
	@Override
	public int deleteAutoLoginToken(String webId) {
		return sqlSessionTemplate.delete(sqlPrefix + "deleteAutoLoginToken", webId);
	}
}
