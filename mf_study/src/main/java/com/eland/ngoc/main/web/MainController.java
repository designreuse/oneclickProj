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

import com.eland.ngoc.common.OneClickConstants;
import com.eland.ngoc.cs.model.Notice;
import com.eland.ngoc.cs.service.CsService;
import com.eland.ngoc.exception.UserHandleException;

@Controller
public class MainController {

	// logger 선언
    private final Logger logger = LoggerFactory.getLogger(MainController.class);
    
	@Autowired
	private MessageSource messageSource;
	
	@Autowired
	private CsService csService;
	
	@Value("${elandMall.url}")
	private String elandMallUrl;
	
	@Value("${elandCore.url}")
	private String elandCoreUrl;
	
	@RequestMapping(value="/")
    public String getMain(Model model, HttpServletRequest request) {		
		try {
			// 최근 공지사항 1개 조회
			Notice mainNotice = csService.getMainNotice();
			model.addAttribute("mainNotice", mainNotice);
			model.addAttribute("elandMallUrl", elandMallUrl);
			model.addAttribute("elandCoreUrl", elandCoreUrl);
		} catch (Exception e) {
			logger.debug(e.getMessage());
			throw new UserHandleException(OneClickConstants.INTERNAL_SERVER_ERROR, OneClickConstants.INTERNAL_SERVER_ERROR_MSG);
		}
				
        return "/main";
    }
}
