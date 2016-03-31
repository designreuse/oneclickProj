package com.eland.ngoc.terms.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import com.eland.ngoc.terms.model.Terms;

@Repository
@Primary
public class TermsDaoImpl implements TermsDao {

	private SqlSessionTemplate sqlSessionTemplate;

    @Autowired
    @Qualifier("primarySqlSessionTemplate")
    public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

	@Override
	public Terms getTerms(String termsCode, String termsSeq) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("termsCode", termsCode);
		param.put("termsSeq", termsSeq);
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectTerms", param);
	}

	@Override
	public List<Terms> getPreTermsList(String termsCode) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("termsCode", termsCode);
		return sqlSessionTemplate.selectList(sqlPrefix + "selectPreTermsList", param);
	}
}
