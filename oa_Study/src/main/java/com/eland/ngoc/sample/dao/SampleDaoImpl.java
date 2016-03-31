package com.eland.ngoc.sample.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class SampleDaoImpl implements SampleDao{

	private SqlSessionTemplate sqlSessionTemplate;

    @Autowired
    @Qualifier("primarySqlSessionTemplate")
    public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }
   
	@Override
	public void welcome() {
		// TODO Auto-generated method stub
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("condition", "value");
		
		// sqlSessionTemplate.selectOne(sqlPrefix + "find", param);
	}

}
