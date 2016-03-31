
package com.eland.ngoc.common.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eland.ngoc.common.dao.CodeDao;
import com.eland.ngoc.common.model.Code;
import com.eland.ngoc.common.model.CodeGroup;

/**
 * 페이지 처리를 위한 기본 서비스.
 */
@Service
public class CodeServiceImpl implements CodeService {
	
	// logger 선언
    private final static Logger logger = LoggerFactory.getLogger(CodeServiceImpl.class);

    @Autowired
    CodeDao codeRepository;
    
	@Override
	public CodeGroup getCodeGroup(String codeGroupId) {
		return codeRepository.getCodeGroup(codeGroupId);
	}

	@Override
	public Code getCode(String code) {
		return codeRepository.getCode(code);
	}

	@Override
	public List<Code> getCodeList(String codeGroupId) {
		return codeRepository.getCodeList(codeGroupId);
	}
	
}
