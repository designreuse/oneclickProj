/**
 * 
 */
package com.eland.ngoc.sample.service;

import com.eland.ngoc.common.model.TokenValue;

/**
 * @author KIM_SUNGSOO01
 *
 */
public interface SampleRedisService {
	public TokenValue get(String key);
	
	public void set(String key, TokenValue value);
}
