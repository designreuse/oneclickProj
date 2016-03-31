package com.eland.ngoc.security.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eland.ngoc.common.OneClickConstants;
import com.eland.ngoc.common.util.GlobalUtil;
import com.eland.ngoc.common.utils.CommonUtil;

@Controller
public class LoginController {
	// logger 선언
    private final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
    @RequestMapping("/login")
    public String login(Model model, HttpServletRequest request) {
    	HttpSession session = request.getSession();

		Object dest = session.getAttribute("dest");
		Object destSiteCode = session.getAttribute("destSiteCode");
		
		String returnUrl = (dest != null ? (String)dest:"/");
		String returnSiteCode = (destSiteCode != null ? (String)destSiteCode:"30");
		model.addAttribute("returnUrl", returnUrl);
		model.addAttribute("returnSiteCode", returnSiteCode);
    	model.addAttribute("authorization", GlobalUtil.makeAuthorization(OneClickConstants.ONECLICK_ID));
    	return "/login";
    }
}
