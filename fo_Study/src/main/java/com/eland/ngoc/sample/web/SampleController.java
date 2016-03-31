package com.eland.ngoc.sample.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import zipit.rfnCustCommonAddrList;

import com.eland.ngoc.sample.service.SampleService;

@Controller
public class SampleController {

	// logger 선언
    private final Logger logger = LoggerFactory.getLogger(SampleController.class);
    
	@Autowired
	private SampleService sampleService;
	
	@Autowired
	private MessageSource messageSource;
	
	@RequestMapping("/sample")
    public String welcome() {
		
		
		rfnCustCommonAddrList rfn = new rfnCustCommonAddrList();
		List arMacList = null;
		ArrayList retData = null;
		
		try {
			
			 
//			String temp = messageSource.getMessage("header.menu.introduction",
//					null, Locale.KOREA);
//			logger.debug(temp);
//			rfn.setServerProp("116.193.93.54", "15556", "UTF-8");
//
//			Map retList = rfn.getRfnAddrMap("08393", "서울 수로구 구로3동", "1129-29",
//					"UTF-8", "J");
//
//			String[] strConvHashKeys = { "STDADDR", "NADR3S", "NADRE", "NADREH" };
//			String[] strConvChars = { "&", "<", ">", "%", "#" };
//			rfn.convertAddrMapCharTo2BytesChar((List) retList.get("DATA"),
//					strConvHashKeys, strConvChars);
//
//			if (arMacList == null)
//				arMacList = rfn.getMacroList(1);
//
//			if (retList != null) {
//				logger.debug("[RESULT] ============= [헤더영역] =============");
//				logger.debug("[RESULT] <RCD1>      : " + retList.get("RCD1"));
//				logger.debug("[RESULT] <RCD2>      : " + retList.get("RCD2"));
//				logger.debug("[RESULT] <RCD3>      : " + retList.get("RCD3"));
//				logger.debug("[RESULT] <RMG1>      : " + retList.get("RMG1"));
//				logger.debug("[RESULT] <RMG2>      : " + retList.get("RMG2"));
//				logger.debug("[RESULT] <RMG3>      : " + retList.get("RMG3"));
//				logger.debug("[RESULT] <DATA_CNT>  : "
//						+ retList.get("DATA_CNT") + "\n");
//
//				retData = (ArrayList) retList.get("DATA");
//
//				retData.get(0);
//
//			}
			
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		logger.warn("Test===============================");
        return "test";
    }
}
