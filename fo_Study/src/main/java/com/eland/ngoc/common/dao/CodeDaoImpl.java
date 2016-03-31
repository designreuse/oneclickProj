package com.eland.ngoc.common.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import com.eland.ngoc.common.model.Code;
import com.eland.ngoc.common.model.CodeGroup;

@Repository
@Primary
public class CodeDaoImpl implements CodeDao {
	private SqlSessionTemplate sqlSessionTemplate;

	@Autowired
    @Qualifier("primarySqlSessionTemplate")
    public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }
    
	@Override
	public CodeGroup getCodeGroup(String codeGroupId) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("codeGroupId", codeGroupId);
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectCodeGroup", param);
	}

	@Override
	public Code getCode(String code) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("code", code);
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectCode", param);
	}

	@Override
	public List<Code> getCodeList(String codeGroupId) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("codeGroupId", codeGroupId);
		return sqlSessionTemplate.selectList(sqlPrefix + "selectCodeList", param);
	}
}
