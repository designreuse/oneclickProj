package com.eland.ngoc.common.dao;

import com.eland.ngoc.common.annotation.OnClickMapper;
import com.eland.ngoc.common.model.Email;
import com.eland.ngoc.common.model.EmailTemplete;

@OnClickMapper
public interface EmailDao {

	String sqlPrefix = EmailDao.class.getCanonicalName() + ".";
	
	public EmailTemplete selectEmailTemplete(String emailType);
	
	public int sendEmail(Email email);
}
