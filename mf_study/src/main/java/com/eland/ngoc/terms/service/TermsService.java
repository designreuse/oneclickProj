package com.eland.ngoc.terms.service;

import java.util.List;

import com.eland.ngoc.terms.model.Terms;

public interface TermsService {

	public Terms getTerms(String termsCode, String termsSeq);
	
	public List<Terms> getPreTermsList(String termsCode);
}
