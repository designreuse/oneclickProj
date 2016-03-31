
package com.eland.ngoc.common.service;

import java.util.List;

import com.eland.ngoc.common.model.Code;
import com.eland.ngoc.common.model.CodeGroup;

/**
 * Code 서비스
 */
public interface CodeService {
	
	/**
	 *  코드 그룹 조회
	 * @param codeGroupId
	 * @return
	 */
	public CodeGroup getCodeGroup(String codeGroupId);
	
	/**
	 *  코드 조회
	 * @param codeId
	 * @return
	 */
	public Code getCode(String code);
	
	/**
	 *  코드리스트 조회
	 * @param codeId
	 * @return
	 */
	public List<Code> getCodeList(String codeGroupId);

}
