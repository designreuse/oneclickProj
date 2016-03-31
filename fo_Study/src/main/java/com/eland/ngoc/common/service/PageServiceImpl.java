
package com.eland.ngoc.common.service;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.eland.ngoc.common.model.PageParam;

/**
 * 페이지 처리를 위한 기본 서비스.
 */
@Service
public class PageServiceImpl implements PageService {
	
	// logger 선언
    private final static Logger logger = LoggerFactory.getLogger(PageServiceImpl.class);
    
	// ~ Instance fields. ~~~~~~~~~~~~~~

	/** 페이지 시작 번호. */
	static final int FIRST_PAGE_NO = 1;

	/** 한페이지에 보여주는 row 수. */
	static final int DEFAULT_PAGE_SIZE = 30;

	/** 화면 하단에 노출되는 페이지 수. */
	static final int DEFAULT_PAGE_RANGE_SIZE = 10;

	// ~ Constructors. ~~~~~~~~~~~~~~~~~
	// ~ Implementation Method. ~~~~~~~~
	// ~ Public Methods. ~~~~~~~~~~~~~~~

	/**
	 * MVC Model 오브젝트에 페이징 결과를 리턴 한다. 스프링 page는 0부터 시작을 하기 때문에 화면에서는 +1을 해줘야 한다.
	 * 그래서 currentPage를 1증가 시킨다.
	 *
	 * @param page the page
	 * @param model the model
	 * @throws Exception the exception
	 */
	public void makePageResult(Page page, Model model) {

		makePageResult(page, model, DEFAULT_PAGE_RANGE_SIZE);
	}
	/**
	 * MVC Model 오브젝트에 페이징 결과를 리턴 한다. 스프링 page는 0부터 시작을 하기 때문에 화면에서는 +1을 해줘야 한다.
	 * 그래서 currentPage를 1증가 시킨다.
	 *
	 * @param page the page
	 * @param model the model
	 */
	public void makePageResultParam(Page page, PageParam param) {
		
		makePageResultParam(page, param, DEFAULT_PAGE_RANGE_SIZE);
	}

	/**
	 * Make page result.
	 *
	 * @param page the page
	 * @param model the model
	 * @param pageRageSizee the page rage sizee
	 * @throws Exception the exception
	 */
	public void makePageResult(Page page, Model model, int pageRange) {


		int currentPage = page.getNumber() + 1;
		int pagePerRowSize = page.getSize();
		// 전체 row 수
		long totalRow = page.getTotalElements();
		// 전체 페이지수
		int totalPage = page.getTotalPages();
		// 첫 페이지
		boolean firstFlag = page.isFirst();
		// 마지막 페이지
		boolean lastFlag = page.isLast();
	
		
		int displayBeginPage = 0;
		int displayEndPage = 0;
		int displayPrePage = 0;
		int displayNextPage = 0;
		
		//전체 페이지 range 사이즈
		int totalPageRange = totalPage/pageRange;
		if ((totalPage%pageRange) >= 1) {
			totalPageRange++;
		}
		
		//이전(pre), 다음(next) 버튼에 설정할 페이지 번호
		int currentPageRange = 0;
		if ((currentPage%pageRange) == 0) {
			currentPageRange = (currentPage/pageRange);
		} else {
			currentPageRange = (currentPage/pageRange) + 1;
		}
		
		boolean preFlag = true;
		if (currentPageRange <= 1 ) {
			displayBeginPage = 1;
			preFlag = false;
		} else {
			displayBeginPage = (currentPageRange * pageRange) - (pageRange - 1);
			displayPrePage = displayBeginPage - 1;
		}
		
		boolean nextFlag = true;
		if (currentPageRange >= totalPageRange ) {
			displayEndPage = totalPage;
			nextFlag = false;
		} else {
			displayEndPage = (currentPageRange * pageRange);
			displayNextPage = displayEndPage + 1;
		}
		
		//페이지 하단에 노출되는 페이지 수
		model.addAttribute("pageRangeSize", pageRange);
		// 현재 페이지
		model.addAttribute("currentPage", currentPage);
		// 한페이지에 노출되는 row수
		model.addAttribute("pagePerRowSize", pagePerRowSize);
		// 전체 row 수
		model.addAttribute("totalRow", totalRow);
		// 전체 페이지수
		model.addAttribute("totalPage", totalPage);
		// 첫 페이지 플래그
		model.addAttribute("firstFlag", firstFlag);
		// 마지막 페이지 플래그
		model.addAttribute("lastFlag", lastFlag);
		// pre 버튼 페이지 플래그
		model.addAttribute("preFlag", preFlag);
		// next 버튼 페이지 플래그
		model.addAttribute("nextFlag", nextFlag );
		//preFlag 값이 true일 경우 pre 페이지 번호
		model.addAttribute("displayPrePage", displayPrePage);
		//nextFlag 값이 true일 경우 next 페이지 번호
		model.addAttribute("displayNextPage", displayNextPage);
		//현재 페이지 range 페이지 시작 번호
		model.addAttribute("displayBeginPage", displayBeginPage);
		//현재 페이지 range 페이지 끝 번호
		model.addAttribute("displayEndPage", displayEndPage);

		logger.debug("pageRangeSize : " + pageRange);
		logger.debug("currentPage : " + currentPage);
		logger.debug("pagePerRowSize : " + pagePerRowSize);
		logger.debug("totalRow : " + totalRow);
		logger.debug("totalPage : " + totalPage);
		logger.debug("firstFlag : " + firstFlag);
		logger.debug("lastFlag : " + lastFlag);
		logger.debug("preFlag : " + preFlag);
		logger.debug("nextFlag : " + nextFlag);
		logger.debug("displayPrePage : " + displayPrePage);
		logger.debug("displayNextPage : " + displayNextPage);
		logger.debug("displayBeginPage : " + displayBeginPage);
		logger.debug("displayEndPage : " + displayEndPage);
		
		
	}
	/**
	 * Make page result.
	 *
	 * @param page the page
	 * @param model the model
	 * @param pageRageSizee the page rage sizee
	 */
	public void makePageResultParam(Page page, PageParam pageParam, int pageRange) {
		
		
		int currentPage = page.getNumber() + 1;
		int pagePerRowSize = page.getSize();
		// 전체 row 수
		long totalRow = page.getTotalElements();
		// 전체 페이지수
		int totalPage = page.getTotalPages();
		// 첫 페이지
		boolean firstFlag = page.isFirst();
		// 마지막 페이지
		boolean lastFlag = page.isLast();
		
		
		int displayBeginPage = 0;
		int displayEndPage = 0;
		int displayPrePage = 0;
		int displayNextPage = 0;
		
		//전체 페이지 range 사이즈
		int totalPageRange = totalPage/pageRange;
		if ((totalPage%pageRange) >= 1) {
			totalPageRange++;
		}
		
		//이전(pre), 다음(next) 버튼에 설정할 페이지 번호
		int currentPageRange = 0;
		if ((currentPage%pageRange) == 0) {
			currentPageRange = (currentPage/pageRange);
		} else {
			currentPageRange = (currentPage/pageRange) + 1;
		}
		
		boolean preFlag = true;
		if (currentPageRange <= 1 ) {
			displayBeginPage = 1;
			preFlag = false;
		} else {
			displayBeginPage = (currentPageRange * pageRange) - (pageRange - 1);
			displayPrePage = displayBeginPage - 1;
		}
		
		boolean nextFlag = true;
		if (currentPageRange >= totalPageRange ) {
			displayEndPage = totalPage;
			nextFlag = false;
		} else {
			displayEndPage = (currentPageRange * pageRange);
			displayNextPage = displayEndPage + 1;
		}
		
		//페이지 하단에 노출되는 페이지 수
//		model.addAttribute("pageRangeSize", pageRange);
//		// 현재 페이지
//		model.addAttribute("currentPage", currentPage);
//		// 한페이지에 노출되는 row수
//		model.addAttribute("pagePerRowSize", pagePerRowSize);
//		// 전체 row 수
//		model.addAttribute("totalRow", totalRow);
//		// 전체 페이지수
//		model.addAttribute("totalPage", totalPage);
//		// 첫 페이지 플래그
//		model.addAttribute("firstFlag", firstFlag);
//		// 마지막 페이지 플래그
//		model.addAttribute("lastFlag", lastFlag);
//		// pre 버튼 페이지 플래그
//		model.addAttribute("preFlag", preFlag);
//		// next 버튼 페이지 플래그
//		model.addAttribute("nextFlag", nextFlag );
//		//preFlag 값이 true일 경우 pre 페이지 번호
//		model.addAttribute("displayPrePage", displayPrePage);
//		//nextFlag 값이 true일 경우 next 페이지 번호
//		model.addAttribute("displayNextPage", displayNextPage);
//		//현재 페이지 range 페이지 시작 번호
//		model.addAttribute("displayBeginPage", displayBeginPage);
//		//현재 페이지 range 페이지 끝 번호
//		model.addAttribute("displayEndPage", displayEndPage);
		
		pageParam.setPageRange(pageRange);       
		pageParam.setCurrentPage(currentPage);     
		pageParam.setPagePerRowSize(pagePerRowSize);  
		pageParam.setTotalRow(totalRow);        
		pageParam.setTotalPage( totalPage);       
		pageParam.setFirstFlag(firstFlag);       
		pageParam.setLastFlag(lastFlag);        
		pageParam.setPreFlag(preFlag);         
		pageParam.setNextFlag (nextFlag );       
		pageParam.setDisplayPrePage(displayPrePage);  
		pageParam.setDisplayNextPage(displayNextPage); 
		pageParam.setDisplayBeginPage(displayBeginPage);
		pageParam.setDisplayEndPage(displayEndPage);  
		
		logger.debug("pageRangeSize : " + pageRange);
		logger.debug("currentPage : " + currentPage);
		logger.debug("pagePerRowSize : " + pagePerRowSize);
		logger.debug("totalRow : " + totalRow);
		logger.debug("totalPage : " + totalPage);
		logger.debug("firstFlag : " + firstFlag);
		logger.debug("lastFlag : " + lastFlag);
		logger.debug("preFlag : " + preFlag);
		logger.debug("nextFlag : " + nextFlag);
		logger.debug("displayPrePage : " + displayPrePage);
		logger.debug("displayNextPage : " + displayNextPage);
		logger.debug("displayBeginPage : " + displayBeginPage);
		logger.debug("displayEndPage : " + displayEndPage);
		
		
	}

	/**
	 * PageParam를 초기화 후 리턴 한다.
	 *
	 * @param pageNo the page no
	 * @return the page param
	 */
	public PageParam buildPageParam(String pageNo) {
		return buildPageParam(pageNo, DEFAULT_PAGE_SIZE);
	}

	/**
	 * 페이지 사이즈를 명시적으로 설정 할때 사용.
	 *
	 * @param pageNo the page no
	 * @param pageSize the page size
	 * @return the page param
	 */
	public PageParam buildPageParam(String pageNo, int pageSize) {

		PageParam pageParam;
		int currentPage = FIRST_PAGE_NO;
		if (!StringUtils.isEmpty(pageNo)) {
			currentPage = Integer.parseInt(pageNo);
		}
		pageParam = new PageParam(currentPage, pageSize);

		return pageParam;
	}

	// ~ Private Methods. ~~~~~~~~~~~~~~

	public static void main(String[] vars) throws Exception {
		
		int currentPage = 2;
		int pageRange = 30;
		int totalPage = 5;
		
		int displayBeginPage = 0;
		int displayEndPage = 0;
		int displayPrePage = 0;
		int displayNextPage = 0;
		
		//전체 페이지 range 사이즈
		int totalPageRange = totalPage/pageRange;
		if ((totalPage%pageRange) >= 1) {
			totalPageRange++;
		}
		
		//이전(pre), 다음(next) 버튼에 설정할 페이지 번호
		int currentPageRange = 0;
		if ((currentPage%pageRange) == 0) {
			currentPageRange = (currentPage/pageRange);
		} else {
			currentPageRange = (currentPage/pageRange) + 1;
		}
		
		boolean preFlag = true;
		if (currentPageRange <= 1 ) {
			displayBeginPage = 1;
			preFlag = false;
		} else {
			displayBeginPage = (currentPageRange * pageRange) - (pageRange - 1);
			displayPrePage = displayBeginPage - 1;
		}
		
		boolean nextFlag = true;
		if (currentPageRange >= totalPageRange ) {
			displayEndPage = totalPage;
			nextFlag = false;
		} else {
			displayEndPage = (currentPageRange * pageRange);
			displayNextPage = displayEndPage + 1;
		}
		
		System.out.println(pageRange);
		System.out.println(currentPageRange);
		System.out.println("------------------");
		System.out.println(currentPage);
		System.out.println("------------------");
		System.out.println(preFlag);
		System.out.println(nextFlag);
		System.out.println("------------------");
		System.out.println(displayBeginPage);
		System.out.println(displayEndPage);
		System.out.println("------------------");
		System.out.println(displayPrePage);
		System.out.println(displayNextPage);
		
	}
	
}
