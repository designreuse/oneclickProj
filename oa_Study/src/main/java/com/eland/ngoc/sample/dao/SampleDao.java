package com.eland.ngoc.sample.dao;

public interface SampleDao {
	
	String sqlPrefix = SampleDao.class.getCanonicalName() + ".";
	
	public void welcome();
}
