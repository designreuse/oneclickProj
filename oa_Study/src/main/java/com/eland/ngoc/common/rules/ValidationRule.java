package com.eland.ngoc.common.rules;

import java.lang.reflect.Method;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.eland.ngoc.common.OcOaConstants;
import com.eland.ngoc.common.model.TokenValue;
import com.eland.ngoc.common.model.Value;
import com.eland.ngoc.common.service.RedisService;
import com.eland.ngoc.common.utils.CommonUtil;
import com.eland.ngoc.common.utils.StringUtil;
import com.eland.ngoc.exception.UserHandleException;

@Component
public class ValidationRule {
	// logger 선언
	private final Logger logger = LoggerFactory.getLogger(ValidationRule.class);
	
	private Class[] stringType = {String.class};
	private Class[] intType = {Integer.class};

	@Autowired
	RedisService redisService;

	/**
	 * Authorization 체크
	 * 
	 * @param authorization
	 * @return siteId Authorization 디코딩으로 얻을 수 있는 siteId
	 */
	public String checkAuthorization(String authorization) {
		String siteId = "";

		if (StringUtil.isEmpty(authorization)) {
			logger.debug("authorization is Mandatory Request!!");
			throw new UserHandleException(OcOaConstants.INVALID_AUTHORIZATION, OcOaConstants.INVALID_AUTHORIZATION_MSG);
		}
		try {
			siteId = CommonUtil.checkAuthorization(authorization);
			if (StringUtil.isEmpty(siteId)) {
				logger.debug("authorization(" + authorization + ") is Not Available");
				throw new UserHandleException(OcOaConstants.INVALID_AUTHORIZATION, OcOaConstants.INVALID_AUTHORIZATION_MSG);
			}
		} catch (Exception e) {
			logger.debug("Error checkAuthorization_ authorization : " + authorization);
			throw new UserHandleException(OcOaConstants.INVALID_AUTHORIZATION, OcOaConstants.INVALID_AUTHORIZATION_MSG);
		}

		return siteId;
	}

	/**
	 * AccessToken 체크
	 * 
	 * @param accessToken
	 * @return custId accessToken으로 얻을 수 있는 custId
	 */
	public String checkAccessToken(String accessToken) {
		String custId = "";

		if (StringUtil.isEmpty(accessToken)) {
			logger.debug("accessToken is Mandatory Request!!");
			throw new UserHandleException(OcOaConstants.INVALID_ACCESS_TOKEN, OcOaConstants.INVALID_ACCESS_TOKEN_MSG);
		}
		try {
			TokenValue value = redisService.get(accessToken);
			if (value != null) {
				custId = value.getCustId();
			} else {
				logger.debug("accessToken(" + accessToken + ") is Not Available");
				throw new UserHandleException(OcOaConstants.INVALID_ACCESS_TOKEN, OcOaConstants.INVALID_ACCESS_TOKEN_MSG);
			}
		} catch (Exception e) {
			logger.debug("Error checkAccessToken accessToken : " + accessToken);
			throw new UserHandleException(OcOaConstants.INVALID_ACCESS_TOKEN, OcOaConstants.INVALID_ACCESS_TOKEN_MSG);
		}

		return custId;
	}

	/**
	 * parameters validation 필수 여부, 길이, 문자 & 숫자 체크
	 * 
	 * @param request
	 * @return isValid 체크 여부
	 */
	public void isValidParameter(HttpServletRequest request) {
		Map<String, String[]> paramMap = request.getParameterMap();
		for (Entry<String, String[]> entry : paramMap.entrySet()) {
			String name = entry.getKey();
			String value = entry.getValue()[0];

			switch (name) {
				case "webId":
					if (!checkParamValue(value, true, false, 20, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_WEB_ID,
								OcOaConstants.INVALID_WEB_ID_MSG);
					} else {
						break;
					}
				case "outType":
					if (!checkParamValue(value, true, false, 2, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_OUT_TYPE,
								OcOaConstants.INVALID_OUT_TYPE_MSG);
					} else {
						if (!"ON".equals(value) && !"AL".equals(value)) {
							throw new UserHandleException(
									OcOaConstants.INVALID_OUT_TYPE,
									OcOaConstants.INVALID_OUT_TYPE_MSG);
						} else {
							break;
						}
					}
				case "outDiv":
					if (!checkParamValue(value, true, false, 2, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_OUT_DIV,
								OcOaConstants.INVALID_OUT_DIV_MSG);
					} else {
						if (!"01".equals(value) && !"02".equals(value) && !"99".equals(value)) {
							throw new UserHandleException(
									OcOaConstants.INVALID_OUT_DIV,
									OcOaConstants.INVALID_OUT_DIV_MSG);
						} else {
							break;
						}
					}
				case "outDesc":
					if (!checkParamValue(value, false, false, 3000, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_OUT_DESC,
								OcOaConstants.INVALID_OUT_DESC_MSG);
					} else {
						break;
					}
				case "outReasons":
					if (!checkParamValue(value, false, false, 30, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_REASON_CODE,
								OcOaConstants.INVALID_REASON_CODE_MSG);
					} else {
						break;
					}
				case "empId":
					if (!checkParamValue(value, false, false, 50, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_EMP_ID,
								OcOaConstants.INVALID_EMP_ID_MSG);
					} else {
						break;
					}
				case "startDate":
					if (!checkParamValue(value, true, false, 8, true)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_START_DATE,
								OcOaConstants.INVALID_START_DATE_MSG);
					} else {
						break;
					}
				case "endDate":
					if (!checkParamValue(value, true, false, 8, true)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_END_DATE,
								OcOaConstants.INVALID_END_DATE_MSG);
					} else {
						break;
					}
				case "branchCode":
					if (!checkParamValue(value, true, false, 6, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_BRANCH_CODE,
								OcOaConstants.INVALID_BRANCH_CODE_MSG);
					} else {
						break;
					}
				case "cancelYn":
					if (!checkParamValue(value, true, false, 1, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_CANCEL_YN,
								OcOaConstants.INVALID_CANCEL_YN_MSG);
					} else {
						if (!"Y".equals(value) && !"N".equals(value)) {
							throw new UserHandleException(
									OcOaConstants.INVALID_CANCEL_YN,
									OcOaConstants.INVALID_CANCEL_YN_MSG);
						} else {
							break;
						}
					}
				case "pointType":
					if (!checkParamValue(value, true, false, 10, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_POINT_TYPE,
								OcOaConstants.INVALID_POINT_TYPE_MSG);
					} else {
						break;
					}
				case "addPoint":
					String addValue = value.substring(0, 1);
					if (!StringUtil.isNumeric(addValue)) {
						if (!"-".equals(addValue)) {
							throw new UserHandleException(
									OcOaConstants.INVALID_ADD_POINT,
									OcOaConstants.INVALID_ADD_POINT_MSG);
						} else {
							value = value.substring(1, value.length());
							if (!checkParamValue(value, true, true, 0, true)) {
								throw new UserHandleException(
										OcOaConstants.INVALID_ADD_POINT,
										OcOaConstants.INVALID_ADD_POINT_MSG);
							} else {
								break;
							}
						}
					} else {
						if (!checkParamValue(value, true, true, 0, true)) {
							throw new UserHandleException(
									OcOaConstants.INVALID_ADD_POINT,
									OcOaConstants.INVALID_ADD_POINT_MSG);
						} else {
							break;
						}
					}		
				case "addDesc":
					if (!checkParamValue(value, false, false, 50, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_ADD_POINT_DESC,
								OcOaConstants.INVALID_ADD_POINT_DESC_MSG);
					} else {
						break;
					}
				case "usePoint":
					String useValue = value.substring(0, 1);
					if (!StringUtil.isNumeric(useValue)) {
						if (!"-".equals(useValue)) {
							throw new UserHandleException(
									OcOaConstants.INVALID_USE_POINT,
									OcOaConstants.INVALID_USE_POINT_MSG);
						} else {
							value = value.substring(1, value.length());
							if (!checkParamValue(value, true, true, 0, true)) {
								throw new UserHandleException(
										OcOaConstants.INVALID_USE_POINT,
										OcOaConstants.INVALID_USE_POINT_MSG);
							} else {
								break;
							}
						}
					} else {
						if (!checkParamValue(value, true, true, 0, true)) {
							throw new UserHandleException(
									OcOaConstants.INVALID_USE_POINT,
									OcOaConstants.INVALID_USE_POINT_MSG);
						} else {
							break;
						}
					}
				case "useDesc":
					if (!checkParamValue(value, false, false, 50, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_USE_POINT_DESC,
								OcOaConstants.INVALID_USE_POINT_DESC_MSG);
					} else {
						break;
					}
				case "txDiv":
					if (!checkParamValue(value, true, false, 2, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_TX_DIV,
								OcOaConstants.INVALID_TX_DIV_MSG);
					} else {
						if (!"RS".equals(value) && !"RR".equals(value) && !"LO".equals(value) && !"UL".equals(value) && !"NP".equals(value) && !"RN".equals(value)) {
							throw new UserHandleException(
									OcOaConstants.INVALID_TX_DIV,
									OcOaConstants.INVALID_TX_DIV_MSG);
						} else {
							break;
						}
					}
				case "aLoginUid":
					if (!checkParamValue(value, true, false, 100, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_AUTO_LOGIN_UID,
								OcOaConstants.INVALID_AUTO_LOGIN_UID_MSG);
					} else {
						break;
					}
				case "loginToken":
					if (!checkParamValue(value, true, false, 100, false)) {
						throw new UserHandleException(
								OcOaConstants.INVALID_AUTO_LOGIN_TOKEN,
								OcOaConstants.INVALID_AUTO_LOGIN_TOKEN_MSG);
					} else {
						break;
					}
				default:
					throw new UserHandleException(OcOaConstants.INVALID_PARAMETER, OcOaConstants.INVALID_PARAMETER_MSG, name);
			}
		}
	}

	/**
	 * 필수 여부, 길이, 문자&숫자 체크 공통 메소드
	 * 
	 * @param value parameter 값
	 * @param required 필수 여부
	 * @param length 길이
	 * @param onlyNum 숫자로만 되어 있는지 체크
	 * @return boolean 유효여부
	 */
	private static boolean checkParamValue(String value, boolean required, boolean numYn, int length, boolean onlyNum) {
		// 1-1. 필수 여부 체크
		if (required) {
			if (StringUtil.isEmpty(value)) {
				return false;
			} else {					
				if (numYn) {	// 2-1. int 체크
					if (Integer.parseInt(value) < 0) {
						return false;
					}
				} else {	// 2-2. string 체크
					if (length > 0) {
						if (value.length() > length) {	// 3. length 체크
							return false;
						} else {						
							if (onlyNum) {	// 4. 숫자로만 되어 있는지 체크
								if (!StringUtil.isNumeric(value)) {
									return false;
								}
							}						
						}
					} else {
						if (onlyNum) {	// 4. 숫자로만 되어 있는지 체크
							if (!StringUtil.isNumeric(value)) {
								return false;
							}
						}
					}
				}
			}
		} 
		// 1-2. 필수가 아니여도 값이 있다면 유효성 체크
		else {
			if (StringUtil.isNotEmpty(value)) {				
				if (numYn) {	// 2-1. int 체크
					if (Integer.parseInt(value) < 0) {
						return false;
					}
				} else {	// 2-2. string 체크
					if (length > 0) {
						if (value.length() > length) {	// 3. length 체크
							return false;
						} else {						
							if (onlyNum) {	// 4. 숫자로만 되어 있는지 체크
								if (!StringUtil.isNumeric(value)) {
									return false;
								}
							}						
						}
					} else {
						if (onlyNum) {	// 4. 숫자로만 되어 있는지 체크
							if (!StringUtil.isNumeric(value)) {
								return false;
							}
						}
					}
				}
			}
		}
		
		return true;
	}
	
	/**
	 * Model 자체를 request로 받는 API 사용 VALIDATION
	 * 
	 * @param paramModel
	 * @return boolean
	 */
	public void checkParamModel(Object paramModel) {
		String nameNCause = "";
		Method tempM = null;
		
		for (Method method : paramModel.getClass().getMethods()) {
			if (method.isAnnotationPresent(Value.class)) {
				try {
					Value value = method.getAnnotation(Value.class);
					
					String str = "get" + method.getName().substring(3);
					tempM = getMethod(paramModel, str);
					
					if (tempM != null) {
						int intValue = 0;
                        String strReturn = "";
                        Class ret = tempM.getReturnType();
                         
                        if (ret.toString().indexOf("int") >=0 || ret.toString().indexOf("Integer") >=0){
                            intValue = (Integer)tempM.invoke(paramModel, null);
                            logger.debug("chkValidation " + intValue);
                   
                            if (value.min() > intValue || intValue > value.max()) {
                                logger.debug("chkValidation NotMatchValue\t" + method.getName().substring(3) 
                                		+ " __ " + value.min() + " < " + intValue + " < " + value.max());
                                nameNCause = "NotMatchValue_ " + method.getName().substring(3);
                                break;
                            }                    
                        } else if (ret.toString().indexOf("String") >= 0) {
                            strReturn = (String)tempM.invoke(paramModel, null);
                            logger.debug("chkValidation " + strReturn);
                             
                            if(strReturn == null){
                                if(value.required()){
                                    logger.debug("chkValidation Required Error\t" + method.getName().substring(3));
                                    nameNCause = method.getName().substring(3) + " is Mandatory Request";
                                    break;
                                }
                                strReturn = value.value();
                                Object[] args = {strReturn};
                                method.invoke(paramModel, args);
                            }
                             
                            if (strReturn.length() > value.length()){
                                logger.debug("chkValidation Over Length\t" + method.getName().substring(3));
                                nameNCause = "Over Length_ " + method.getName().substring(3);
                                break;
                            }
                            if (StringUtil.isNotEmpty(strReturn) && value.onlyNum()) {
                            	if (!StringUtil.isNumeric(strReturn)) {
                            		logger.debug("chkValidation NotNumeric Error\t" + method.getName().substring(3));
                                    nameNCause = "NotNumeric_ " + method.getName().substring(3);
                                    break;
                            	}
                            }
                        }
                    }else{
                        logger.debug("chkValidation Not Method " + str);
                    }				
				} catch (Exception e) {
					logger.debug(e.getMessage());
				}
			}			
		};

		if (StringUtil.isNotEmpty(nameNCause)) {
			throw new UserHandleException(OcOaConstants.INVALID_PARAMETER, OcOaConstants.INVALID_PARAMETER_MSG, nameNCause);
		}
	}
	
	/**
	 * 메소드 타입을 판별한다.
	 * 
	 * @param dto
	 * @param methodName
	 * @return
	 */
	private Method getMethod(Object dto, String methodName){
		Method method = null;
		try {
			method = dto.getClass().getMethod(methodName, stringType);
		} catch (Exception e) {
			
        }
		
		if(method == null){
			try {
				method = dto.getClass().getMethod(methodName, intType);
			} catch (Exception e) {
				
			}
		}
			
		if (method == null) {
			try {
				method = dto.getClass().getMethod(methodName, null);
			} catch (Exception e) {
				
			}
		}
		
		return method;
	}

}
