package com.eland.ngoc.config;

import java.util.List;

import jvfw.web.support.MessageUtil;

import org.springframework.boot.context.embedded.ConfigurableEmbeddedServletContainer;
import org.springframework.boot.context.embedded.EmbeddedServletContainerCustomizer;
import org.springframework.boot.context.embedded.ErrorPage;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.web.PageableHandlerMethodArgumentResolver;
import org.springframework.data.web.SortHandlerMethodArgumentResolver;
import org.springframework.data.web.config.EnableSpringDataWebSupport;
import org.springframework.data.web.config.SpringDataWebConfiguration;
import org.springframework.http.HttpStatus;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;

@Configuration
@EnableSpringDataWebSupport
public class WebConfiguration extends SpringDataWebConfiguration {
	
	@Override
	public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
		SortHandlerMethodArgumentResolver sortHandlerMethodArgumentResolver = new SortHandlerMethodArgumentResolver();
		sortHandlerMethodArgumentResolver.setSortParameter("sord");
		
		PageableHandlerMethodArgumentResolver pageableHandlerMethodArgumentResolver = new PageableHandlerMethodArgumentResolver(sortHandlerMethodArgumentResolver);
		pageableHandlerMethodArgumentResolver.setPageParameterName("page");
		pageableHandlerMethodArgumentResolver.setSizeParameterName("rows");
		
		argumentResolvers.add(pageableHandlerMethodArgumentResolver);
		argumentResolvers.add(sortHandlerMethodArgumentResolver);
	};

	@Bean
	public MessageUtil messageUtil(){
		return new MessageUtil();
	}

	@Bean
	public EmbeddedServletContainerCustomizer containerCustomizer(){
		return new EmbeddedServletContainerCustomizer() {			
			@Override
			public void customize(ConfigurableEmbeddedServletContainer container) {
				container.addErrorPages(new ErrorPage(HttpStatus.FORBIDDEN, "/error/403.html"));
				container.addErrorPages(new ErrorPage(HttpStatus.NOT_FOUND, "/error/404.html"));
				container.addErrorPages(new ErrorPage(HttpStatus.INTERNAL_SERVER_ERROR, "/error/404.html"));
			}
		};
	}

}
