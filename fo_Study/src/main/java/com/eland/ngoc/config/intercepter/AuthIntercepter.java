package com.eland.ngoc.config.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.eland.ngoc.common.utils.CommonUtil;
import com.eland.ngoc.common.utils.StringUtil;

public class AuthIntercepter extends HandlerInterceptorAdapter {

	private final Logger logger = LoggerFactory
			.getLogger(AuthIntercepter.class);

	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {

		logger.debug("===========PreHandle===========");

		HttpSession session = request.getSession();
		String authorization = request.getParameter("authorization");
		String uri = request.getRequestURI();
		try {
			if (session.getAttribute("CustInfo") == null) {
				if (uri.contains("/member/updateMember")) {
					if (authorization != null) {
						String siteCode = CommonUtil.checkAuthorizationAjax(authorization);
						if (siteCode != null) {
							saveDest(request);
							return true;
						} else {
							saveDest(request);
							response.sendRedirect("/login");
							return false;
						}
					} else {
						saveDest(request);
						response.sendRedirect("/login");
						return false;
					}
				} else {
					saveDest(request);
					response.sendRedirect("/login");
					return false;
				}
			}

		} catch (Exception e) {

		}

		return true;
	}

	private void saveDest(HttpServletRequest request) {

		String uri = request.getRequestURI();
		String returnUrl = request.getParameter("returnUrl");
		if (StringUtil.isEmpty(returnUrl)) {
			returnUrl = (String) request.getAttribute("returnUrl");
		}
		request.getSession().setAttribute("returnUrl", returnUrl);

		request.getSession().setAttribute("dest", uri);
		if (StringUtil.isEmpty(request.getParameter("siteCode"))) {
			request.getSession().setAttribute("destSiteCode", request.getSession().getAttribute("siteCode"));
		} else {
			request.getSession().setAttribute("destSiteCode", request.getParameter("siteCode"));
		}

		request.getSession().setAttribute("authorization", request.getParameter("authorization"));
	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		request.getSession().removeAttribute("CustInfo");
		request.getSession().removeAttribute("siteCode");
//		request.getSession().removeAttribute("dest");

		logger.debug("===========PostHandle===========");

	}
}
