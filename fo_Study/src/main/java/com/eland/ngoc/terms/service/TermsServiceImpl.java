package com.eland.ngoc.terms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eland.ngoc.terms.dao.TermsDao;
import com.eland.ngoc.terms.model.Terms;

@Service
public class TermsServiceImpl implements TermsService{

	@Autowired
	private TermsDao termsRepository;

	@Override
	public Terms getTerms(String termsCode, String termsSeq) {
		// TODO Auto-generated method stub
		return termsRepository.getTerms(termsCode, termsSeq);
	}

	@Override
	public List<Terms> getPreTermsList(String termsCode) {
		// TODO Auto-generated method stub
		return termsRepository.getPreTermsList(termsCode);
	}
	
}
