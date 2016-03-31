package com.eland.ngoc.sample.service;

import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
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
