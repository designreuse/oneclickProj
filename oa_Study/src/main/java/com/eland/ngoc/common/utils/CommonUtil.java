package com.eland.ngoc.common.utils;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.RandomStringUtils;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.support.PropertiesLoaderUtils;

import sun.misc.BASE64Decoder;

import com.eland.ngoc.common.OcOaConstants;
import com.eland.ngoc.common.util.GlobalUtil;

public class CommonUtil {
	// logger 선언
    private static final Logger logger = LoggerFactory.getLogger(CommonUtil.class);

    // 서버 환경
    private static final String ENV_PATH = "config/application-" + System.getProperty("spring.profiles.active")+".properties";
    private static final String ACTIVE_SVR = System.getProperty("spring.profiles.active");
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
        try {
        	decoded = new String(decoder.decodeBuffer(authValue));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        logger.debug("Authorization [" + authValue + "] decoded [" + decoded + "]");
		
		/* devide clientID:clientPasswd */
		String[] clientInfo = decoded.split(":");
		logger.debug("id: " + clientInfo[0] + ", pwd: " + clientInfo[1]);

		return authorizationYN(clientInfo[0], clientInfo[1]);
	}

	/**
	 * Compare authorization Info
	 * 
	 * @param clientValue
	 * @return result
	 */
    private static String authorizationYN(String clientId, String clientPwd) {
//    	Map<String, String> clientMap = new HashMap<String, String>();
//    	//환경변수값 가져오기
//		Properties props = null;
//		try {
//			props = PropertiesLoaderUtils.loadAllProperties(ENV_PATH);
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//    	clientMap.put(OcOaConstants.ELANDMALL_ID, props.getProperty("elandmall.secret"));
//    	clientMap.put(OcOaConstants.ECORE_ID, props.getProperty("elandcore.secret"));
//    	clientMap.put(OcOaConstants.EIMSCS_ID, props.getProperty("eimscs.secret"));
//    	clientMap.put(OcOaConstants.ONCLICK_ID, props.getProperty("oneclick.secret"));
//    	clientMap.put(OcOaConstants.ONCLICK_FO_ID, props.getProperty("oneclickfo.secret"));
//    	clientMap.put(OcOaConstants.ONCLICK_BO_ID, props.getProperty("oneclickbo.secret"));
    	
    	String siteSecret = GlobalUtil.getSiteSecret(clientId);
    	if (StringUtil.isEmpty(siteSecret)) {
    		return null;
    	} else {
    		if (siteSecret.equals(clientPwd)) {
    			return clientId;
    		} else {
    			return null;
    		}
    	}
    }
    
    /**
	 * get site code
	 * 
	 * @param client ID
	 * @return site code
	 */
	public static String getSiteCode(String clientId) {
		String siteCode = "";

		switch(clientId) {
			case OcOaConstants.ELANDMALL_ID: //통합몰
				siteCode = "10";
				break;
			case OcOaConstants.ECORE_ID: //통합홈페이지
				siteCode = "20";
				break;
			case OcOaConstants.ONCLICK_ID: //원클릭
				siteCode = "30";
				break;
			case OcOaConstants.ONCLICK_BO_ID: //원클릭 어드민(온라인 고객센터)
				siteCode = "40";
				break;
			case OcOaConstants.EIMSCS_ID: //EIMS CS
				siteCode = "50";
				break;
			default:
				siteCode = "00";
				break;
		}
		logger.debug("Client ID: " + clientId + ", Site Code: " + siteCode);

		return siteCode;
	}
	
	public static String convertObjectToJson(Object target) {
		ObjectMapper mapper = new ObjectMapper();
		String convData = null;
		try {
			convData = mapper.writeValueAsString(target);
		} catch (JsonGenerationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return convData;
	}
	
	/**
	 * 자동 로그인 토큰 생성
	 * @return
	 */
	public static String createLoginToken() {
		// 타임스탬프 
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
		// weibId + 타임스탬프 + 랜덤값
		String timeStamp = DateUtil.getCurrentDate("yyyyMMddHHmmssSSS");
		
		String loginUid = encyriptSHA256(webId+timeStamp+RandomStringUtils.randomAlphanumeric(10));
		logger.debug(loginUid);
		return loginUid;
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
}
