/**
 * 
 */
package com.eland.ngoc.sample.service;

import java.util.concurrent.TimeUnit;

import javax.annotation.Resource;

import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

import com.eland.ngoc.common.model.TokenValue;

/**
 * @author KIM_SUNGSOO01
 *
 */
@Service
public class SampleRedisServiceImpl implements SampleRedisService {
	
	@Resource(name="redisTemplateForToken")
	private ValueOperations<String, TokenValue> valueOps;
	
	public TokenValue get(String key) {
		return valueOps.get(key);
	}
	
	public void set(String key, TokenValue value) {
		
		valueOps.set(key, value, 30, TimeUnit.SECONDS);
	}
}
