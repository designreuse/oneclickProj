package com.eland.ngoc.sample.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eland.ngoc.sample.dao.SampleDao;

@Service
public class SampleServiceImpl implements SampleService{

	@Autowired
	private SampleDao sampleRepository;
	
	@Override
	public void welcome() {
		sampleRepository.welcome();
	}
}
