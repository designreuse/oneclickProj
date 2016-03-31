package com.eland.ngoc.point.dao;

import com.eland.ngoc.common.model.MemberIds;

public interface CustPointDao {

	String sqlPrefix = CustPointDao.class.getCanonicalName() + ".";
	
	public MemberIds getCustInfoIds(String custId, String webId);

}
