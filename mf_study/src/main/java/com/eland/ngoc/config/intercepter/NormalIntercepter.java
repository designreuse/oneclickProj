package com.eland.ngoc.config.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.eland.ngoc.common.utils.StringUtil;
import com.eland.ngoc.member.model.CustInfo;

public class NormalIntercepter extends HandlerInterceptorAdapter {

	private final Logger logger = LoggerFactory
			.getLogger(NormalIntercepter.class);

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		logger.debug("===========PreHandle===========");

		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		CustInfo custInfo = (CustInfo)request.getSession().getAttribute("CustInfo");
		String dest = (String) request.getSession().getAttribute("dest");
		String siteCode = (String) request.getSession().getAttribute("siteCode");
		String uri = request.getRequestURI();
		if (!uri.contains("/member/loginAjax") && !uri.contains("/member/infoPopup") 
				&& !uri.contains("/member/extendPwdChangeAjax") && !uri.contains("/member/holdTempPasswordAjax")) {
			if (custInfo != null) {
				request.getSession().removeAttribute("CustInfo");
			}
			if (StringUtil.isNotEmpty(dest)) {
				request.getSession().removeAttribute("dest");
			}
		}

		logger.debug("===========PostHandle===========");

	}
}
