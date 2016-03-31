package com.eland.ngoc.sample.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.eland.ngoc.common.model.TokenValue;
import com.eland.ngoc.common.model.TokenValue.TokenType;
import com.eland.ngoc.sample.service.SampleRedisService;
import com.eland.ngoc.sample.service.SampleService;

@RestController
public class SampleController {

	@Autowired
	private SampleService sampleService;
	
	@Autowired
	private SampleRedisService sampleRedisService;
	
	private final Logger logger = LoggerFactory.getLogger(SampleController.class);
	
	@RequestMapping("/")
    public String welcome() {
		
		logger.warn("test");
		
        return "index";
    }
	
	@RequestMapping(value = "/testredis")
	public @ResponseBody TokenValue testRedis() {
		sampleRedisService.set("merong", new TokenValue("123456", TokenType.CREATE));
		return (TokenValue) sampleRedisService.get("merong"); 
	}
}
