package com.eland.ngoc.introduction.web;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/introduction")
public class IntroductionController {

	// logger 선언
    private final Logger logger = LoggerFactory.getLogger(IntroductionController.class);
    
	@Autowired
	private MessageSource messageSource;
	
	@RequestMapping(value="/intro", method=RequestMethod.GET)
    public String getIntro(Model model, HttpServletRequest request) {	
		try {
			
			
		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		
        return "/intro";
    }
	
	@RequestMapping(value="/guide", method=RequestMethod.GET)
	public String getGuide(Model model, HttpServletRequest request) {
		try {
			
		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		
		return "/guide";
	}
	
	@RequestMapping(value="/membershipInfo", method=RequestMethod.GET)
	public String getMembershipInfo(Model model, HttpServletRequest request) {
		try {
			
		} catch (Exception e) {
			logger.debug(e.getMessage());
		}
		
		return "/membershipInfo";
	}
}
