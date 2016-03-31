package com.eland.ngoc.cs.dao;

import java.util.List;

import org.springframework.data.domain.Page;

import com.eland.ngoc.common.annotation.OnClickMapper;
import com.eland.ngoc.common.model.PageParam;
import com.eland.ngoc.cs.model.Faq;
import com.eland.ngoc.cs.model.FaqCategory;
import com.eland.ngoc.cs.model.FaqTop5;
import com.eland.ngoc.cs.model.Notice;

@OnClickMapper
public interface CsDao {
	
	String sqlPrefix = CsDao.class.getCanonicalName() + ".";
	
	public Notice getMainNotice();
	
	public int getNoticeCount();
	
	public Page<Notice> getNoticeList(PageParam pageParam);

	public Notice getNoticeDetail(String ntceSeq);
	
	public List<FaqTop5> getFaqTop5();
	
	public List<FaqCategory> getFaqCategories();
	
	public int getFaqCount(String ctgrCode);
	
	public Page<Faq> getFaqList(String ctgrCode, PageParam pageParam);
}
