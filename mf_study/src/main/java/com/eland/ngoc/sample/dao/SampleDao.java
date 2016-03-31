package com.eland.ngoc.sample.dao;

import com.eland.ngoc.common.annotation.OnClickMapper;

@OnClickMapper
public interface SampleDao {
	
	String sqlPrefix = SampleDao.class.getCanonicalName() + ".";
	
	public void welcome();
}
