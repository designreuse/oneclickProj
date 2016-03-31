package com.eland.ngoc.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import com.eland.ngoc.common.utils.StringUtil;
import com.eland.ngoc.member.model.AuthDtls;
import com.eland.ngoc.member.model.AutoLoginToken;
import com.eland.ngoc.member.model.CustInfo;
import com.eland.ngoc.member.model.CustSiteInfo;
import com.eland.ngoc.member.model.CustTermsAgree;
import com.eland.ngoc.member.model.Member;
import com.eland.ngoc.member.model.MemberDTO;
import com.eland.ngoc.member.model.MemberOutDTO;

/**
 * @author park.sanghyuk
 *
 */
@Repository
@Primary
public class MemberDaoImpl implements MemberDao{

	private SqlSessionTemplate sqlSessionTemplate;

	@Autowired
    @Qualifier("primarySqlSessionTemplate")
    public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }
    
    /**
     * 아이디 조회
     */
	@Override
	public int isCheckId(String webId, String checkType) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("webId", webId);
		if (StringUtil.isNotEmpty(checkType) && "findPwd".equals(checkType)) {
			param.put("custStat", "50");	
		}
		
		return sqlSessionTemplate.selectOne(sqlPrefix + "isCheckId", param);
	}
	/**
	 *  회원 정보 조회
	 */
	@Override
	public Member getMemberInfo(String webId) {
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectMemberInfo", webId);
	}
	
	/**
	 * 회원 비밀번호 조회
	 */
	@Override
	public String getMemberPwd(String custId) {
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectMemberPwd", custId);
	}
	
	@Override
	public String getMemberUsedPwd(String custId) {
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectMemberUsedPwd", custId);
	}
	
	@Override
	public int updateMemberInfo(MemberDTO memberDto) {
		return sqlSessionTemplate.update(sqlPrefix + "updateMemberInfo", memberDto);
	}
	
	@Override
	public int updateMemberSiteInfoRetailMall(MemberDTO memberDto) {
		return sqlSessionTemplate.update(sqlPrefix + "updateMemberSiteInfoRetailMall", memberDto);
	}
	
	@Override
	public int updateMemberSiteInfoCore(MemberDTO memberDto) {		
		return sqlSessionTemplate.update(sqlPrefix + "updateMemberSiteInfoCore", memberDto);
	}

	@Override
	public int insertCustInfo(CustInfo custInfo) {
		
		return sqlSessionTemplate.insert(sqlPrefix + "insertCustInfo", custInfo);
	}

	
	/**
	 * 본인 인증 내역 저장
	 * 
	 * @return authDtls
	 */
	public int insertAuthDtls(AuthDtls authDtls) {
		return sqlSessionTemplate.insert(sqlPrefix + "insertAuthDtls", authDtls);
	}
	
	@Override
	public Map<String, String> getCustnPbpId(String webId) {
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectCustnPbpId", webId);
	}
	
	@Override
	public int selectOutSeq(MemberOutDTO memberOutDto) {
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectOutSeq", memberOutDto);
	}
	
	@Override
	public int insertMemberOutDetail(MemberOutDTO memberOutDto) {
		return sqlSessionTemplate.insert(sqlPrefix + "insertMemberOutDetail", memberOutDto);
	}
	
	@Override
	public int insertMemberOutReason(MemberOutDTO memberOutDto) {
		return sqlSessionTemplate.insert(sqlPrefix + "insertMemberOutReason", memberOutDto);
	}
   
	/**
	 *  회원 약관 동의 저장
	 */
	@Override
	public void insertCustTermsAgree(List<CustTermsAgree> custTermsAgreeList) {
		
		for (CustTermsAgree custTermsAgree : custTermsAgreeList) {
			sqlSessionTemplate.insert(sqlPrefix + "insertCustTermsAgree", custTermsAgree);
		}
	}
	
	/**
	 *  본인인증 CI, 회원명으로 회원정보 조회
	 */
	@Override
	public CustInfo getFindMemberInfo(String ci, String custName) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("ci", ci);
		param.put("custName", custName);
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectFindMemberInfo", param);
	}

	@Override
	public int updateMemberStat(String custId, String custStat, String webPwd, String tempPwdYn) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("custId", custId);
		param.put("custStat", custStat);
		if (webPwd == "") {
			param.put("webPwd", null);
		} else {
			param.put("webPwd", webPwd);
		}
		if (tempPwdYn == "") {
			param.put("tempPwdYn", null);
		} else {
			param.put("tempPwdYn", tempPwdYn);
		}
		
		return sqlSessionTemplate.update(sqlPrefix + "updateMemberStat", param);
	}
	
	@Override
	public int updateMemberSiteInfo(CustSiteInfo custSiteInfo) {
		return sqlSessionTemplate.update(sqlPrefix + "updateMemberSiteInfo", custSiteInfo);
	}
	
	@Override
	public int mergeMemberSiteInfo(CustSiteInfo custSiteInfo) {
		return sqlSessionTemplate.update(sqlPrefix + "mergeMemberSiteInfo", custSiteInfo);
	}
	
	/**
	 *  자동 로그인 토큰 저장
	 */
	@Override
	public int insertAutoLoginToken(AutoLoginToken autoLoginToken) {
		return sqlSessionTemplate.insert(sqlPrefix + "insertAutoLoginToken", autoLoginToken);
	}
	
	/**
	 *  자동 로그인 토큰 업데이트
	 */
	@Override
	public int updateAutoLoginToken(AutoLoginToken autoLoginToken) {
		return sqlSessionTemplate.update(sqlPrefix + "updateAutoLoginToken", autoLoginToken);
	}
	
	/**
	 *  자동 로그인 토큰 삭제
	 */
	@Override
	public int deleteAutoLoginToken(String webId) {
		return sqlSessionTemplate.delete(sqlPrefix + "deleteAutoLoginToken", webId);
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
	 * EMAIL, SMS, DM 수신 여부 저장
	 */
	@Override
	public int insertCustSiteInfo(CustSiteInfo custSiteInfo) {
		return sqlSessionTemplate.insert(sqlPrefix + "insertCustSiteInfo", custSiteInfo);
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

	@Override
	public CustInfo selectCustStateInfo(String custId, String siteCode) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("custId", custId);
		param.put("siteCode", siteCode);
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectCustStateInfo", param);
	}

	@Override
	public CustInfo selectCustInfoCheck(String webId, String webPwd) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("webId", webId);
		param.put("webPwd", webPwd);
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectCustInfoCheck", param);
	}

	@Override
	public int updatePwdChangeDate(String webId) {
		
		return sqlSessionTemplate.update(sqlPrefix + "updatePwdChangeDate", webId);
	}

	@Override
	public int updateTempPwdYn(String webId) {
		return sqlSessionTemplate.update(sqlPrefix + "updateTempPwdYn", webId);
	}

	@Override
	public String getPbpId(String custId) {
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectPbpId", custId);
	}

	@Override
	public CustInfo selectCustInfoByCustId(String custId) {
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectCustInfoByCustId", custId);
	}
	
	@Override
	public int getCustInfoCnt(String webId) {
		return sqlSessionTemplate.selectOne(sqlPrefix + "getCustInfoCnt", webId);
	}

}
