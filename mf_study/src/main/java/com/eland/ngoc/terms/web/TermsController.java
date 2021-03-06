package com.eland.ngoc.terms.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eland.ngoc.common.service.PageService;
import com.eland.ngoc.cs.service.CsService;
import com.eland.ngoc.terms.model.Terms;
import com.eland.ngoc.terms.service.TermsService;

@Controller
@RequestMapping("/terms")
public class TermsController {

	// logger 선언
    private final Logger logger = LoggerFactory.getLogger(TermsController.class);
    
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	TermsService termsService;
	
	@Autowired
	CsService csService;
	
	@Autowired
	PageService pageService;
	
	/**
	 * 이랜드리테일 멤버십 약관
	 * @return
	 */
	@RequestMapping(value="/memberShipClubTerms", method=RequestMethod.GET)
    public String getMemberShipClubTerms(Model model, HttpServletRequest request) {
		
		try {
			
			String termsSeq = "";
			if (!StringUtils.isEmpty(request.getParameter("termsSeq"))) {
				termsSeq = request.getParameter("termsSeq");
			}
			
			// 현재 약관
			Terms memberShipClubTerms = termsService.getTerms("10", termsSeq);
			model.addAttribute("memberShipClubTerms", memberShipClubTerms);
			
			// Terms 세부 타이틀 목록
			Document doc = Jsoup.parse(memberShipClubTerms.getTermsCont());
			Elements rows = doc.select("h5.mt5");
			
			List<String> termsDetailTitList = new ArrayList<String>();
			for (Element element : rows) {
				String temp = element.text();
				termsDetailTitList.add(temp.substring(temp.indexOf("(") + 1, temp.length()-1));
			}
			model.addAttribute("termsDetailTitList", termsDetailTitList);
			
			// 이전 약관 리스트 조회
			List<Terms> preTerms = new ArrayList<Terms>();
			
			List<Terms> preMemberShipClubTerms = termsService.getPreTermsList("10");
			for (Terms terms : preMemberShipClubTerms) {
				if (StringUtils.isNotEmpty(terms.getTermsCont())) {
					preTerms.add(terms);
				}
			}
			model.addAttribute("preMemberShipClubTerms", preTerms);
			model.addAttribute("termsSeq", termsSeq);
			
		} catch (Exception e) {
			logger.debug(e.getMessage());
			e.printStackTrace();
		}
		
        return "/memberShipClubTerms";
    }
	
	/**
	 * 이랜드리테일 멤버십 약관_ 이전 약관 내용 조회
	 * 
	 * @param termsSeq
	 * @return
	 */
	@RequestMapping(value="/getPreMembershipTerms", method= RequestMethod.GET, produces = {"application/json"})
	@ResponseBody
	public ModelMap getPreMembershipTermsJSON(@RequestParam(value="termsSeq", required=true)String termsSeq) {
		ModelMap map = new ModelMap();
		
		try {
			// 이전 약관 조회
			Terms terms = termsService.getTerms("10", termsSeq);
			if (terms.getTermsCont() != null) {
				map.addAttribute("terms", terms);
				
				// Terms 세부 타이틀 목록
				Document doc = Jsoup.parse(terms.getTermsCont());
				Elements rows = doc.select("h5.mt5");
				
				List<String> termsDetailTitList = new ArrayList<String>();
				for (Element element : rows) {
					String temp = element.text();
					termsDetailTitList.add(temp.substring(temp.indexOf("(") + 1, temp.length()-1));
				}
				map.addAttribute("termsDetailTitList", termsDetailTitList);
			} else {
				map.addAttribute("terms", "");
				map.addAttribute("termsDetailTitList", "");
			}
			
			
		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		return map; 
	}
	
	
	/**
	 * 온라인 서비스 약관
	 * @return
	 */
	@RequestMapping(value="/onlineServiceTerms", method=RequestMethod.GET)
    public String getOnlineServiceTerms(Model model, HttpServletRequest request) {
		
		try {
			
			String termsSeq = "";
			if (!StringUtils.isEmpty(request.getParameter("termsSeq"))) {
				termsSeq = request.getParameter("termsSeq");
			}
			
			Terms onlineServiceTerms = termsService.getTerms("20",termsSeq);
			model.addAttribute("onlineServiceTerms", onlineServiceTerms);
			
			// Terms 세부 타이틀 목록
			Document doc = Jsoup.parse(onlineServiceTerms.getTermsCont());
			Elements rows = doc.select("h4.mt5");
			
			List<String> termsDetailTitList = new ArrayList<String>();
			for (Element element : rows) {
				String temp = element.text();
				termsDetailTitList.add(temp.substring(temp.indexOf("(") + 1, temp.length()-1));
			}
			model.addAttribute("termsDetailTitList", termsDetailTitList);
			
			// 이전 약관 리스트 조회
			List<Terms> preTerms = new ArrayList<Terms>();
			
			List<Terms> preOnlineServiceTerms = termsService.getPreTermsList("20");
			for (Terms terms : preOnlineServiceTerms) {
				if (StringUtils.isNotEmpty(terms.getTermsCont())) {
					preTerms.add(terms);
				}
			}
			model.addAttribute("preOnlineServiceTerms", preTerms);
			model.addAttribute("termsSeq", termsSeq);
			
		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		
        return "/onlineServiceTerms";
    }
	
	/**
	 * 온라인 서비스 이용 약관_ 이전 약관 내용 조회
	 * 
	 * @param termsSeq
	 * @return
	 */
	@RequestMapping(value="/getPreOnServiceTerms", method= RequestMethod.GET, produces = {"application/json"})
	@ResponseBody
	public ModelMap getPreOnServiceTermsJSON(@RequestParam(value="termsSeq", required=true)String termsSeq) {
		ModelMap map = new ModelMap();
		
		try {
			// 이전 약관 조회
			Terms onlineServiceTerms = termsService.getTerms("20",termsSeq);
			if (onlineServiceTerms.getTermsCont() != null) {
				map.addAttribute("onlineServiceTerms", onlineServiceTerms);
				
				// Terms 세부 타이틀 목록
				Document doc = Jsoup.parse(onlineServiceTerms.getTermsCont());		
				Elements rows = doc.select("h4.mt5");
				
				List<String> termsDetailTitList = new ArrayList<String>();
				for (Element element : rows) {
					String temp = element.text();
					termsDetailTitList.add(temp.substring(temp.indexOf("(") + 1, temp.length()-1));
				}
				map.addAttribute("termsDetailTitList", termsDetailTitList);
			} else {
				map.addAttribute("onlineServiceTerms", "");
				map.addAttribute("termsDetailTitList", "");
			}
			
			
		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		return map; 
	}	
	
	/**
	 *  개인 정보 취급 방침
	 * @return
	 */
	@RequestMapping(value="/privacyTerms", method=RequestMethod.GET)
    public String getPrivacyTerms(Model model, HttpServletRequest request) {
		
		try {
			
			String termsSeq = "";
			if (!StringUtils.isEmpty(request.getParameter("termsSeq"))) {
				termsSeq = request.getParameter("termsSeq");
			}
			
			Terms privacyTerms = termsService.getTerms("30",termsSeq);
			model.addAttribute("privacyTerms", privacyTerms);
			
			// Terms 세부 타이틀 목록
			Document doc = Jsoup.parse(privacyTerms.getTermsCont());
			Elements rows = doc.select("h4.mt5");
			
			List<String> termsDetailTitList = new ArrayList<String>();
			for (Element element : rows) {
				String temp = element.text();
				termsDetailTitList.add(temp.substring(temp.indexOf("(") + 1, temp.length()-1));
			}
			model.addAttribute("termsDetailTitList", termsDetailTitList);
			
			// 이전 약관 리스트 조회
			List<Terms> preTerms = new ArrayList<Terms>();
			
			List<Terms> prePrivacyTerms = termsService.getPreTermsList("30");
			for (Terms terms : prePrivacyTerms) {
				if (StringUtils.isNotEmpty(terms.getTermsCont())) {
					preTerms.add(terms);
				}
			}
			model.addAttribute("prePrivacyTerms", preTerms);
			model.addAttribute("termsSeq", termsSeq);
			
		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		
        return "/privacyTerms";
    }
	
	/**
	 * 개인 정보 취급 방침_ 이전 약관 내용 조회
	 * 
	 * @param termsSeq
	 * @return
	 */
	@RequestMapping(value="/getPrePrivacyTerms", method= RequestMethod.GET, produces = {"application/json"})
	@ResponseBody
	public ModelMap getPrePrivacyTermsJSON(@RequestParam(value="termsSeq", required=true)String termsSeq) {
		ModelMap map = new ModelMap();
		
		try {
			// 이전 약관 조회
			Terms privacyTerms = termsService.getTerms("30",termsSeq);
			if (privacyTerms.getTermsCont() != null) {
				map.addAttribute("privacyTerms", privacyTerms);
				
				// Terms 세부 타이틀 목록
				Document doc = Jsoup.parse(privacyTerms.getTermsCont());			
				Elements rows = doc.select("h4.mt5");
				
				List<String> termsDetailTitList = new ArrayList<String>();
				for (Element element : rows) {
					String temp = element.text();
					termsDetailTitList.add(temp.substring(temp.indexOf("(") + 1, temp.length()-1));
				}
				map.addAttribute("termsDetailTitList", termsDetailTitList);
			} else {
				map.addAttribute("privacyTerms", "");
				map.addAttribute("termsDetailTitList", "");
			}
			
			
		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		return map; 
	}		
	
	/**
	 * 영상 정보처리 기기 운영, 관리방침
	 * @return
	 */
	@RequestMapping(value="/mediaTerms", method=RequestMethod.GET)
    public String getMediaTerms(Model model, HttpServletRequest request) {
		
		try {
			String termsSeq = "";
			if (!StringUtils.isEmpty(request.getParameter("termsSeq"))) {
				termsSeq = request.getParameter("termsSeq");
			}
			
			Terms mediaTerms = termsService.getTerms("40",termsSeq);
			model.addAttribute("mediaTerms", mediaTerms);
			
			// Terms 세부 타이틀 목록
			Document doc = Jsoup.parse(mediaTerms.getTermsCont());
			Elements rows = doc.select("h4.mt5");
			
			List<String> termsDetailTitList = new ArrayList<String>();
			for (Element element : rows) {
				String temp = element.text();
				termsDetailTitList.add(temp.substring(temp.indexOf("(") + 1, temp.length()-1));
			}
			model.addAttribute("termsDetailTitList", termsDetailTitList);
			
			// 이전 약관 리스트 조회
			List<Terms> preTerms = new ArrayList<Terms>();
			
			List<Terms> preMediaTerms = termsService.getPreTermsList("40");
			for (Terms terms : preMediaTerms) {
				if (StringUtils.isNotEmpty(terms.getTermsCont())) {
					preTerms.add(terms);
				}
			}
			model.addAttribute("preMediaTerms", preTerms);
			model.addAttribute("termsSeq", termsSeq);
			
		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		
        return "/mediaTerms";
    }
	
	/**
	 *  입점 상담 동의사항
	 * @return
	 */
	@RequestMapping(value="/entryCounselAgree", method=RequestMethod.GET)
    public String getEntryCounselAgree(Model model, HttpServletRequest request) {
		
		try {
			Terms entryCounselAgree = termsService.getTerms("60", "");
			model.addAttribute("entryCounselAgree", entryCounselAgree);
			
		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		
        return "/entryCounselAgree";
    }
	
}
