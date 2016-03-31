package com.eland.ngoc.cs.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
			if (StringUtil.isEmpty(page)) {
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
	 * 공지사항 추가 조회
	 * 
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/addNoticeList", method= RequestMethod.GET, produces = {"application/json"})
	@ResponseBody
	public List<Notice> addNoticeListJSON(@RequestParam(value="page", required=true)String page) {
		List<Notice> noticeList = new ArrayList<Notice>();
		
		PageParam pageParam = pageService.buildPageParam(page, 10);
		logger.debug("BeginIndex = " + pageParam.getBeginIndex());
		logger.debug("EndIndex = " + pageParam.getEndIndex());
		
		Page<Notice> pagingNotice = csService.getNoticeList(pageParam);
		if (pagingNotice.getSize() > 0) {
			pageService.makePageResultParam(pagingNotice, pageParam, 5);
		}
		noticeList = pagingNotice.getContent();
		
		return noticeList;
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
			, @RequestParam(value="noticeSeq",required = true) String ntceSeq) {
		try {
			Notice notice = csService.getNoticeDetail(ntceSeq);
			notice.setNtceNo(ntceNo);
			
			model.addAttribute("noticeDetail", notice);
			
		} catch (Exception e) {
			logger.debug(e.getMessage());		
		}
		
        return "/noticeDetail";
	}

	@RequestMapping(value="/faqList", method=RequestMethod.GET)
	public String getFAQTop5nCategory(Model model, HttpServletRequest request) {
		try {
			// faq Top5
			List<FaqTop5> faqTop5 = csService.getFaqTop5();
			model.addAttribute("faqTop5", faqTop5);
			
			// faq Category
			List<FaqCategory> categories = csService.getFaqCategories();
			model.addAttribute("categories", categories);
			 
		} catch (Exception e) {
			logger.debug(e.getMessage());	
		}
		
		return "/faqList";
	}
	
	@RequestMapping(value="/faqListForCategory", method=RequestMethod.GET, produces = {"application/json"})
	@ResponseBody
	public ModelMap getFAQListForCategory(@RequestParam(value="ctgrCode", required=true)String ctgrCode
			, @RequestParam(value="page")String page) {
		ModelMap map = new ModelMap();
		
		try {
			// category
			if (StringUtil.isEmpty(ctgrCode)) {
				ctgrCode = "all";
			}
			// page
			if (StringUtil.isEmpty(page)) {
				page = "1";
			}
			PageParam pageParam = pageService.buildPageParam(page, 10);
			logger.debug("BeginIndex = " + pageParam.getBeginIndex());
			logger.debug("EndIndex = " + pageParam.getEndIndex());
			
			// faqList
			Page<Faq> pagingFaq = csService.getFaqList(ctgrCode, pageParam);
			if (pagingFaq.getSize() > 0) {
				pageService.makePageResultParam(pagingFaq, pageParam, 5);
				map.addAttribute("faqList", pagingFaq.getContent());
			}
			
			// faqList TotalCount
			int faqCount = csService.getFaqCount(ctgrCode);
			map.addAttribute("faqCount", faqCount);

		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		
		return map;

	}

}
