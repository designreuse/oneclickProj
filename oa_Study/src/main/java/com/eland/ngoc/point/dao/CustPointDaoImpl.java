package com.eland.ngoc.point.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.eland.ngoc.common.model.MemberIds;

@Repository
public class CustPointDaoImpl implements CustPointDao {
	private SqlSessionTemplate sqlSessionTemplate;

    @Autowired
    @Qualifier("primarySqlSessionTemplate")
    public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }

	@Override
	public MemberIds getCustInfoIds(String custId, String webId) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("webId", webId);
		param.put("custId", "");

		return sqlSessionTemplate.selectOne(sqlPrefix + "getCustInfoIds", param);
	}
}
