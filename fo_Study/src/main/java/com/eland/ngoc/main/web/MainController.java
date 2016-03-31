package com.eland.ngoc.main.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eland.ngoc.common.dao.SmsDao;
import com.eland.ngoc.common.service.AddrService;
import com.eland.ngoc.cs.model.Notice;
import com.eland.ngoc.cs.service.CsService;

@Controller
public class MainController {

	// logger 선언
    private final Logger logger = LoggerFactory.getLogger(MainController.class);
    
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	CsService csService;
	
	@Value("${elandMall.url}")
	private String elandMallUrl;
	
	@Value("${elandCore.url}")
	private String elandCoreUrl;
	
	@RequestMapping(value="/")
    public String getMain(Model model, HttpServletRequest request) {
		
		try {
			
			Notice notice;
			// 공지사항 1건 조회
			notice = csService.getMainNotice();
			model.addAttribute("notice", notice);
			model.addAttribute("elandMallUrl", elandMallUrl);
			model.addAttribute("elandCoreUrl", elandCoreUrl);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
        return "/main";
    }
}
