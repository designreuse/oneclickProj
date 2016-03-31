package com.eland.ngoc.cs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import com.eland.ngoc.common.model.PageParam;
import com.eland.ngoc.cs.dao.CsDao;
import com.eland.ngoc.cs.model.Faq;
import com.eland.ngoc.cs.model.FaqCategory;
import com.eland.ngoc.cs.model.FaqTop5;
import com.eland.ngoc.cs.model.Notice;

@Service
public class CsServiceImpl implements CsService{

	@Autowired
	private CsDao csRepository;

	@Override
	public Notice getMainNotice() {
		// TODO Auto-generated method stub
		return csRepository.getMainNotice();
	}
	
	@Override
	public Page<Notice> getNoticeList(PageParam pageParam) {
		return csRepository.getNoticeList(pageParam);
	}
	
	@Override
	public Notice getNoticeDetail(String ntceSeq) {
		return csRepository.getNoticeDetail(ntceSeq);
	}
	
	@Override
	public List<FaqTop5> getFaqTop5() {
		return csRepository.getFaqTop5();
	}
	
	@Override
	public List<FaqCategory> getFaqCategories() {
		return csRepository.getFaqCategories();
	}
	
	@Override
	public Page<Faq> getFaqList(String ctgrCode, PageParam pageParam) {
		return csRepository.getFaqList(ctgrCode, pageParam);
	}
}
