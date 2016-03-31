package com.eland.ngoc.terms.dao;

import java.util.List;

import com.eland.ngoc.common.annotation.OnClickMapper;
import com.eland.ngoc.terms.model.Terms;

@OnClickMapper
public interface TermsDao {
	
	String sqlPrefix = TermsDao.class.getCanonicalName() + ".";
	
	public Terms getTerms(String termsCodes, String termsSeq);
	
	public List<Terms> getPreTermsList(String termsCode);
}
