package com.eland.ngoc.cs.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.eland.ngoc.common.model.PageParam;
import com.eland.ngoc.common.service.PageService;
import com.eland.ngoc.common.utils.StringUtil;
import com.eland.ngoc.cs.model.Faq;
import com.eland.ngoc.cs.model.FaqCategory;
import com.eland.ngoc.cs.model.FaqTop5;
import com.eland.ngoc.cs.model.Notice;
import com.eland.ngoc.cs.service.CsService;

@Controller
@RequestMapping("/cs")
public class CsController {

	// logger 선언
    private final Logger logger = LoggerFactory.getLogger(CsController.class);
    
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	PageService pageService;
	
	@Autowired
	private CsService csService;
	
	/**
	 * siteMap
	 * @return
	 */
	@RequestMapping(value="/siteMap", method=RequestMethod.GET)
    public String getSiteMap() {
		
		try {
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
        return "/siteMap";
    }

	
	/**
	 * 공지사항 목록 조회
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/noticeList", method=RequestMethod.GET)
    public String getNoticeList(Model model, HttpServletRequest request) {
		try {
			String page = request.getParameter("page");
			if(StringUtil.isEmpty(page)) {
				page = "1";
			}						
			PageParam pageParam = pageService.buildPageParam(page, 10);
			logger.debug("BeginIndex = " + pageParam.getBeginIndex());
			logger.debug("EndIndex = " + pageParam.getEndIndex());
			
			Page<Notice> noticeList = csService.getNoticeList(pageParam);
			if (noticeList.getSize() > 0) {
				pageService.makePageResultParam(noticeList, pageParam, 5);
			}
			model.addAttribute("noticeList", noticeList.getContent());
			model.addAttribute("pageParam", pageParam);
			
		} catch (Exception e) {
			logger.debug(e.getMessage());		
		}
		
        return "/noticeList";
    }
	
	/**
	 * 공지사항 상세 조회
	 * 
	 * @param model
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/noticeDetail", method=RequestMethod.POST)
	public String getNoticeDetail(Model model, HttpServletRequest request
			, @RequestParam(value="noticeNo",required = true) String ntceNo
			, @RequestParam(value="noticeSeq",required = true) String ntceSeq
			, @RequestParam(value="currentPage",required = true) String currentPage) {
		try {
			Notice notice = csService.getNoticeDetail(ntceSeq);
			notice.setNtceNo(ntceNo);
			
			model.addAttribute("noticeDetail", notice);
			model.addAttribute("currentPage", currentPage);
			
		} catch (Exception e) {
			logger.debug(e.getMessage());		
		}
		
        return "/noticeDetail";
	}

	@RequestMapping(value="/faqList", method=RequestMethod.GET)
	public String getFAQList(Model model, HttpServletRequest request) {
		try {
			// faq Top5
			List<FaqTop5> faqTop5 = csService.getFaqTop5();
			model.addAttribute("faqTop5", faqTop5);
			
			// faq Category
			List<FaqCategory> categories = csService.getFaqCategories();
			model.addAttribute("categories", categories);
			
			// faq List
			String ctgrCode = request.getParameter("category");
			if (StringUtil.isEmpty(ctgrCode)) {
				ctgrCode = "all";
			}
			model.addAttribute("currentCategory", ctgrCode);
			
			String page = request.getParameter("page");
			if (StringUtil.isEmpty(page)) {
				page = "1";
			}
			PageParam pageParam = pageService.buildPageParam(page, 10);
			logger.debug("BeginIndex = " + pageParam.getBeginIndex());
			logger.debug("EndIndex = " + pageParam.getEndIndex());
			
			Page<Faq> faqList = csService.getFaqList(ctgrCode, pageParam);
			if (faqList.getSize() > 0) {
				pageService.makePageResultParam(faqList, pageParam, 5);
			}
			model.addAttribute("faqList", faqList.getContent());
			model.addAttribute("pageParam", pageParam);
			 
			 
		} catch (Exception e) {
			logger.debug(e.getMessage());	
		}
		
		return "/faqList";
	}

}
