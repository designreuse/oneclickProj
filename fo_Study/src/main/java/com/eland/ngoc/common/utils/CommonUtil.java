package com.eland.ngoc.common.utils;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Enumeration;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import sun.misc.BASE64Decoder;

import com.eland.ngoc.common.OneClickConstants;
import com.eland.ngoc.common.util.GlobalUtil;

public class CommonUtil {
	// logger 선언
    private static final Logger logger = LoggerFactory.getLogger(CommonUtil.class);

	/**
	 * Debug Request Parameter
	 *
	 * @param request
	 * @return String
	 */
	public static String debugRequestParameters(HttpServletRequest request) {
		
		StringBuffer buffer = new StringBuffer();
		buffer.append(request.getServerName() + request.getRequestURI());
		Enumeration<?> paramNames = request.getParameterNames();
		int cnt = 0;
		while (paramNames.hasMoreElements()) {
			String paramName = (String) paramNames.nextElement();
			if (cnt == 0) {
				buffer.append("?");
			} else {
				buffer.append("&");
			}
			buffer.append(paramName + "=");
			String[] paramValues = request.getParameterValues(paramName);
			if (paramValues.length == 1) {
				buffer.append(paramValues[0]);
			} else {
				for (int i = 0; i < paramValues.length; i++) {
					if (i > 0) {
						buffer.append(",");
					}
					buffer.append(paramValues[i]);
				}
			}
			cnt++;
		}
 
		return buffer.toString();
	}

	/**
	 * Authorization Check
	 * 
	 * @param authValue
	 * @return boolean
	 */
	public static String checkAuthorization(String authValue) {
		/* base64 decoding */
/*		String decoded = StringUtils.newStringUtf8(Base64.decodeBase64(authValue));
		logger.debug("Authorization [" + authValue + "] decoded [" + decoded + "]");*/
		
		BASE64Decoder decoder = new BASE64Decoder();
		String decoded = "";
		String[] decodedArray = new String[2]; 
        try {
        	decoded = new String(decoder.decodeBuffer(authValue));
        	decodedArray = decoded.split(":");
        	if (decodedArray.length < 2) {
        		return null;
        	}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        logger.debug("Authorization [" + authValue + "] decoded [" + decoded + "]");
        
		return getSiteCode(decodedArray[0], decodedArray[1]);
	}
	
	/**
	 * Authorization Check
	 * 
	 * @param authValue
	 * @return boolean
	 */
	public static String checkAuthorizationAjax(String authValue) {
		/* base64 decoding */
/*		String decoded = StringUtils.newStringUtf8(Base64.decodeBase64(authValue));
		logger.debug("Authorization [" + authValue + "] decoded [" + decoded + "]");*/
		
		BASE64Decoder decoder = new BASE64Decoder();
		String decoded = "";
        try {
        	decoded = new String(decoder.decodeBuffer(authValue));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        logger.debug("Authorization [" + authValue + "] decoded [" + decoded + "]");
        
		return getSiteCode(decoded);
	}

	/**
	 * Compare authorization Info
	 * 
	 * @param clientValue
	 * @return result
	 */
    private static String getSiteCode(String clientId, String clientPwd) {
    	
    	String siteSecret = GlobalUtil.getSiteSecret(clientId);
    	if (StringUtil.isEmpty(siteSecret)) {
    		return null;
    	} else {
    		if (siteSecret.equals(clientPwd)) {
    			if (OneClickConstants.ELANDMALL_ID.equals(clientId)) {
    	    		return "10";
    	    	} else if (OneClickConstants.ECORE_ID.equals(clientId)) {
    	    		return "20";
    	    	} else if (OneClickConstants.ONECLICK_ID.equals(clientId)) {
    	    		return "30";
    	    	}
    		} else {
    			return null;
    		}
    	}
    	
    	return null;
    }
    
    /**
	 * get site code
	 * 
	 * @param client ID
	 * @return site code
	 */
	public static String getSiteCode(String clientId) {
		String siteCode = "";

		if (OneClickConstants.ELANDMALL_ID.equals(clientId)) {
    		siteCode = "10";
    	} else if (OneClickConstants.ECORE_ID.equals(clientId)) {
    		siteCode = "20";
    	} else if (OneClickConstants.ONECLICK_ID.equals(clientId)) {
    		siteCode = "30";
    	} else {
    		return null;
    	}
		logger.debug("Client ID: " + clientId + ", Site Code: " + siteCode);

		return siteCode;
	}
	
	/**
	 * get siteId
	 * 
	 * @param siteCode
	 * @return
	 */
	public static String getSiteId(String siteCode) {
		String siteId = "";
		
		switch(siteCode) {
		case OneClickConstants.ELAND_RETAIL_MALL_SITE_CODE: //통합몰
			siteId = OneClickConstants.ELANDMALL_ID;
			break;
		case OneClickConstants.ECORE_SITE_CODE: //통합홈페이지
			siteId = OneClickConstants.ECORE_ID;
			break;
		case OneClickConstants.ONECLICK_SITE_CODE:
			siteId = OneClickConstants.ONECLICK_ID;
		default:	// 오류
			siteId = null;
			break;
		}
		logger.debug("Site Code: " + siteCode + ", Site Id: " + siteId);
		
		return siteId;
	}
	
	 /*region SHA-256 Hash
     /// <summary>
     /// SHA-256 Hash
     /// </summary>
     /// <param name="val"></param>
     /// <returns></returns>
     * */
	public static String encyriptSHA256(String str){
		String SHA = ""; 
		try{
			MessageDigest sh = MessageDigest.getInstance("SHA-256"); 
			sh.update(str.getBytes()); 
			byte byteData[] = sh.digest();
			StringBuffer sb = new StringBuffer(); 
			for(int i = 0 ; i < byteData.length ; i++){
				sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
			}
			SHA = sb.toString();
		}catch(NoSuchAlgorithmException e){
			e.printStackTrace(); 
			SHA = null; 
		}
		return SHA;
	}
	
	/**
	 *  임시비밀 번호 생성
	 * @return
	 */
	public static String temporaryPassword() {
		String tempPassword = "";

		for(int i=0; i<8; i++) {
			int rndVal = (int)(Math.random() * 62);
			if (rndVal < 10) {
				tempPassword += rndVal;
			} else if(rndVal > 35) {
				tempPassword += (char)(rndVal + 61);
			} else {
				tempPassword += (char)(rndVal + 55);
			}
		}
		return tempPassword;
	}
	
	/**
	 *  인증 호출시 저장한 쿠키값 조회
	 * @param request
	 * @return
	 */
	public static String[] getCookieReqNum(HttpServletRequest request) {
		//쿠키값 가져 오기
		Cookie[] cookies = request.getCookies();
		String reqName = "";
		String[] reqNum = new String[2];
		if(cookies!=null){
			for (int i = 0; i < cookies.length; i++){
				Cookie c = cookies[i];
				reqName = c.getName();
				reqNum = c.getValue().split(",");
				if(reqName.compareTo("reqNum")==0) break;
				
				reqNum = null;
			}
		}
		return reqNum;
	}
	
	/**
	 * 자동 로그인 토큰 생성
	 * @return
	 */
	public static String createLoginToken() {
		// TODO : 타임스탬프 
		String timeStamp = DateUtil.getCurrentDate("yyyyMMddHHmmssSSS");
		logger.debug(timeStamp);
		
		String loginToken = encyriptSHA256(timeStamp);
		logger.debug(loginToken);
		
		return loginToken;
	}
	
	
	/**
	 *  자동 로그인 UID 생성
	 * @return
	 */
	public static String createLoginUid(String webId) {
		// TODO : weibId + 타임스탬프 + 랜덤값
		String timeStamp = DateUtil.getCurrentDate("yyyyMMddHHmmssSSS");
		
		String loginUid = encyriptSHA256(webId+timeStamp+RandomStringUtils.randomAlphanumeric(10));
		logger.debug(loginUid);
		return loginUid;
	}
	
	/**
	 *  14세 미만 체크
	 * @param birth ("20010304")
	 * @return
	 */
	public static boolean checkUnderFourTeen(String birth) {
		
		boolean isUnderFourTeen = false;
		
		int userBirthYear = Integer.parseInt(birth.substring(0, 4));
		int userBirthMonth = Integer.parseInt(birth.substring(4, 6));
		int userBirthDay = Integer.parseInt(birth.substring(6, 8));
		
		int currentYear = DateUtil.getYear();
		int currentMonth = DateUtil.getMonth() + 1;
		int curretnDay = DateUtil.getDate();
		
		if ( (currentYear - userBirthYear) < 15 ) {
			isUnderFourTeen = true;
		} else if ((currentYear - userBirthYear) == 15) {
			if (currentMonth < userBirthMonth && curretnDay < userBirthDay) {
				isUnderFourTeen = true;
			} 
		}
		
		return isUnderFourTeen;
	}
	
	
	public static String getSessionSiteCode(HttpServletRequest request) {
		String siteCode = "";
		
		siteCode = (String) request.getSession().getAttribute("siteCode");
		
		if (StringUtil.isEmpty(siteCode)) {
			siteCode = "30";
		}
		
		return siteCode;
	}
}
