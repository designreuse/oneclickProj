package com.eland.ngoc.common.dao;

import java.util.List;

import com.eland.ngoc.common.annotation.OnClickMapper;
import com.eland.ngoc.common.model.Code;
import com.eland.ngoc.common.model.CodeGroup;

@OnClickMapper
public interface CodeDao {

	String sqlPrefix = CodeDao.class.getCanonicalName() + ".";
	
	public CodeGroup getCodeGroup(String codeGroupId);
	
	public Code getCode(String code);
	
	public List<Code> getCodeList(String codeGroupId);
}
