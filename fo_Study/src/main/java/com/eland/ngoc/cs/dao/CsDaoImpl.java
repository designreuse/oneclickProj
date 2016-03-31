package com.eland.ngoc.cs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Primary;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.stereotype.Repository;

import com.eland.ngoc.common.model.PageParam;
import com.eland.ngoc.cs.model.Faq;
import com.eland.ngoc.cs.model.FaqCategory;
import com.eland.ngoc.cs.model.FaqTop5;
import com.eland.ngoc.cs.model.Notice;

@Repository
@Primary
public class CsDaoImpl implements CsDao{
	
	private SqlSessionTemplate sqlSessionTemplate;

	@Autowired
    @Qualifier("primarySqlSessionTemplate")
    public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
        this.sqlSessionTemplate = sqlSessionTemplate;
    }
   
	@Override
	public Notice getMainNotice() {
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectNotice");
	}
	
	@Override
	public int getNoticeCount() {
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectNoticeCount");
	}

	@Override
	public Page<Notice> getNoticeList(PageParam pageParam) {
		int ntceCnt = getNoticeCount();
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("beginIndex", pageParam.getBeginIndex());
		param.put("endIndex", pageParam.getEndIndex());
		param.put("ntceCnt", ntceCnt);
		List<Notice> noticeList = sqlSessionTemplate.selectList(sqlPrefix + "selectNoticeList", param);

		return new PageImpl<Notice>(noticeList, pageParam.getPageable(), ntceCnt);
	}
	
	@Override
	public Notice getNoticeDetail(String ntceSeq) {
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectNoticeDetail", ntceSeq);
	}
	
	@Override
	public List<FaqTop5> getFaqTop5() {
		return sqlSessionTemplate.selectList(sqlPrefix + "selectFaqTop5");
	}
	
	@Override
	public List<FaqCategory> getFaqCategories() {
		return sqlSessionTemplate.selectList(sqlPrefix + "selectFaqCategories");
	}
	
	@Override
	public int getFaqCount(String ctgrCode) {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("ctgrCode", ctgrCode);
		return sqlSessionTemplate.selectOne(sqlPrefix + "selectFaqCount", paramMap);
	}
	
	@Override
	public Page<Faq> getFaqList(String ctgrCode, PageParam pageParam) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("beginIndex", pageParam.getBeginIndex());
		paramMap.put("endIndex", pageParam.getEndIndex());
		paramMap.put("ctgrCode", ctgrCode);
		List<Faq> faqList = sqlSessionTemplate.selectList(sqlPrefix + "selectFaqList", paramMap);
		
		return new PageImpl<Faq>(faqList, pageParam.getPageable(), getFaqCount(ctgrCode));
	}

}
