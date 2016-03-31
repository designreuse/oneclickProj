package com.eland.ngoc.sample.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.eland.ngoc.sample.service.SampleService;

@Controller
public class SampleController {

	@Autowired
	private SampleService sampleService;
	
	@RequestMapping("/sample")
    public String welcome() {
		
		sampleService.welcome();
        return "index";
    }
}
