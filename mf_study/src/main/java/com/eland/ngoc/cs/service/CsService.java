package com.eland.ngoc.cs.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.eland.ngoc.common.model.PageParam;
import com.eland.ngoc.cs.model.Faq;
import com.eland.ngoc.cs.model.FaqCategory;
import com.eland.ngoc.cs.model.FaqTop5;
import com.eland.ngoc.cs.model.Notice;

public interface CsService {

	public Notice getMainNotice();
	
	public Page<Notice> getNoticeList(PageParam pageParam);
	
	public Notice getNoticeDetail(String ntceSeq);
	
	public List<FaqTop5> getFaqTop5();
	
	public List<FaqCategory> getFaqCategories();
	
	public int getFaqCount(String ctgrCode);
	
	public Page<Faq> getFaqList(String ctgrCode, PageParam pageParam);
}
