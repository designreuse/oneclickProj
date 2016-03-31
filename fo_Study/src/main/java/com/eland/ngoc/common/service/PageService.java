
package com.eland.ngoc.common.service;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.eland.ngoc.common.model.PageParam;

/**
 * 페이지 처리를 위한 기본 서비스.
 */
@Service
public interface PageService {
	
	public void makePageResult(Page page, Model model);
	
	public void makePageResultParam(Page page, PageParam param);
	
	public void makePageResult(Page page, Model model, int pageRange);
	
	public void makePageResultParam(Page page, PageParam pageParam, int pageRange);
	
	public PageParam buildPageParam(String pageNo);

	public PageParam buildPageParam(String pageNo, int pageSize);

}
