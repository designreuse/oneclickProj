package com.eland.ngoc.common.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import com.eland.ngoc.common.model.Email;
import com.eland.ngoc.common.model.EmailTemplete;

@Repository
@Primary
public class EmailDaoImpl implements EmailDao {
	private static final String ACTIVE_SVR = System.getProperty("spring.profiles.active");
	
	private SqlSessionTemplate sqlSessionTemplate;

	@Autowired
	@Qualifier("primarySqlSessionTemplate")
    public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }
	@Override
	public EmailTemplete selectEmailTemplete(String templType) {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("templType", templType);
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectEmailTemplete", param);
	}

	@Override
	public int sendEmail(Email email) {
		int result = 0;
		if ("local".equals(ACTIVE_SVR) || "dev".equals(ACTIVE_SVR)) {
			result = sqlSessionTemplate.insert(sqlPrefix + "insertDmailInfo", email);
		} else if ("qa".equals(ACTIVE_SVR)) {
			result = sqlSessionTemplate.insert(sqlPrefix + "insertDmailInfoQa", email);
		} else if ("prod".equals(ACTIVE_SVR)) {
			result = sqlSessionTemplate.insert(sqlPrefix + "insertDmailInfoPrd", email);
		}
		
		return result;
	}

   
}
