package com.eland.ngoc.common;

public class OneClickConstants {
	
	// site별 client ID, client secret 정의
	// TODO: (2016.03.07) QA, 운영용으로 PWD 따로 발급됐으니, properties에서 관리할 필요 있음!
	public static final String ELANDMALL_ID = "elandmall";
	public static final String ELANDMALL_PWD = "BBfBGCOsI3";
	public static final String ECORE_ID = "ecorepage";
	public static final String ECORE_PWD = "88IE7rahGF";
	public static final String EIMSCS_ID = "eimscs";
	public static final String EIMSCS_PWD = "78m3WoaJMr";
	public static final String ONECLICK_ID = "oneclick";
	public static final String ONECLICK_PWD = "Vk9SrMOew6";	
	
	// oneclick 사용 공통 constants
	public static final String CREATE_TOKEN_PREFIX = "oneClick";
	
	// 사이트 코드
	public static final String ELAND_RETAIL_MALL_SITE_CODE = "10";
	public static final String ECORE_SITE_CODE = "20";
	public static final String ONECLICK_SITE_CODE = "30";
	
	// 고객 상태
	public static final String CUST_STATUS_NORMAL = "10";
	public static final String CUST_STATUS_RESTING = "20";
	public static final String CUST_STATUS_ACCOUNT_LOCKED = "30";
	public static final String CUST_STATUS_MEMBER_PART_OUT = "40";
	public static final String CUST_STATUS_MEMBER_WHOLE_OUT = "50";
	
	// 원클릭 사용 코드 그룹ID
	public static final String CODE_GROUP_ID_OUT_REASON = "outReason";
	
	// 이메일 템플릿 타입
	public static final String EMAIL_TEMPL_TYPE_MEMBER_JOIN = "member join";
	public static final String EMAIL_TEMPL_TYPE_CHANGE_INFO = "change info";
	public static final String EMAIL_TEMPL_TYPE_TEMP_PASSWORD = "temp password";
	public static final String EMAIL_TEMPL_TYPE_CHANGE_PASSWORD = "change password";
	public static final String EMAIL_TEMPL_TYPE_RESTING_RELEASE = "resting release";
	public static final String EMAIL_TEMPL_TYPE_MEMBER_OUT = "member out";
	public static final String EMAIL_TEMPL_TYPE_RESTING_WAITING = "resting waiting";
	public static final String EMAIL_TEMPL_TYPE_RESTING_CONFIRM = "resting confirm";
	public static final String EMAIL_TEMPL_TYPE_MEMBER_SITEOUT = "member siteout";
	public static final String EMAIL_TEMPL_TYPE_MEMBER_ONLINEOUT = "member onlineout";
	
	// EIMS 연동_ 회원 탈퇴
	public static final String OFFLINK_CS_SITE_CODE = "50";
	public static final String OUT_TYPE_ONLINE_MEMBER_OUT = "ON";
	public static final String OUT_TYPE_OFFLINE_MEMBER_OUT = "AL";
	public static final String EIMS_OUT_DIV_SELF_OUT = "01";
	public static final String EIMS_OUT_DIV_ETC = "99";	
	
	// 에러 메시지 정의
	public static final String RESULT_SUCCESS = "0";
	public static final String RESULT_FAIL = "1";
	
	public static final String INVALID_AUTHORIZATION = "100";
	public static final String INVALID_AUTHORIZATION_MSG = "Invalid Autorization";	
	public static final String INVALID_ACCESS_TOKEN = "200";
	public static final String INVALID_ACCESS_TOKEN_MSG = "Invalid Access Token";	
	public static final String INVALID_SITE_CODE = "201";
	public static final String INVALID_SITE_CODE_MSG = "Invalid Site Code";
	public static final String INVALID_WEB_ID = "202";
	public static final String INVALID_WEB_ID_MSG = "Invalid Web ID";
	public static final String INVALID_PASSWORD = "203";
	public static final String INVALID_PASSWORD_MSG = "Invalid Password";
	public static final String INVALID_MEMBER_GRADE = "204";
	public static final String INVALID_MEMBER_GRADE_MSG = "Invalid Member Grade";
	public static final String INVALID_TELEPHONE_NUMBER = "205";
	public static final String INVALID_TELEPHONE_NUMBER_MSG = "Invalid Telephone Number";
	public static final String INVALID_MOBILE_NUMBER = "206";
	public static final String INVALID_MOBILE_NUMBER_MSG = "Invalid Mobile Number";
	public static final String INVALID_ZIP_CODE = "207";
	public static final String INVALID_ZIP_CODE_MSG = "Invalid Zip Code";
	public static final String INVALID_ADDRESS1 = "208";
	public static final String INVALID_ADDRESS1_MSG = "Invalid Address1";
	public static final String INVALID_ADDRESS2 = "209";
	public static final String INVALID_ADDRESS2_MSG = "Invalid Address2";
	public static final String INVALID_ADDRESS_TYPE = "210";
	public static final String INVALID_ADDRESS_TYPE_MSG = "Invalid Address Type";
	public static final String INVALID_EMAIL = "211";
	public static final String INVALID_EMAIL_MSG = "Invalid Email";
	public static final String INVALID_EMAIL_YN = "212";
	public static final String INVALID_EMAIL_YN_MSG = "Invalid Email YN";
	public static final String INVALID_SMS_YN = "213";
	public static final String INVALID_SMS_YN_MSG = "Invalid SMS YN";
	public static final String INVALID_DM_YN = "214";
	public static final String INVALID_DM_YN_MSG = "Invalid DM YN";
	public static final String INVALID_EDM_YN = "215";
	public static final String INVALID_EDM_YN_MSG = "Invalid EDM YN";
	public static final String INVALID_WEDDING_YN = "216";
	public static final String INVALID_WEDDING_YN_MSG = "Invalid Wedding YN";
	public static final String INVALID_WEDDING_DAY = "217";
	public static final String INVALID_WEDDING_DAY_MSG = "Invalid Wedding Day";
	public static final String INVALID_CHILD_COUNT = "218";
	public static final String INVALID_CHILD_COUNT_MSG = "Invalid Child Count";
	public static final String INVALID_CHILD_NAME = "219";
	public static final String INVALID_CHILD_NAME_MSG = "Invalid Child Name";
	public static final String INVALID_CHILD_GENDER = "220";
	public static final String INVALID_CHILD_GENDER_MSG = "Invalid Child Gender";
	public static final String INVALID_CHILD_BIRTHDAY = "221";
	public static final String INVALID_CHILD_BIRTHDAY_MSG = "Invalid Child Birthday";
	public static final String INVALID_CHILD_UNAR = "222";
	public static final String INVALID_CHILD_UNAR_MSG = "Invalid Child Unar";
	public static final String INVALID_OUT_TYPE = "223";
	public static final String INVALID_OUT_TYPE_MSG = "Invalid Out Type";
	public static final String INVALID_OUT_DESC = "224";
	public static final String INVALID_OUT_DESC_MSG = "Invalid Out Desc";
	public static final String INVALID_REASON_CODE = "225"; 
	public static final String INVALID_REASON_CODE_MSG = "Invalid Reason Code";
	public static final String INVALID_START_DATE = "226";
	public static final String INVALID_START_DATE_MSG = "Invalid Start Date";
	public static final String INVALID_END_DATE = "227";
	public static final String INVALID_END_DATE_MSG = "Invalid End Date";
	public static final String INVALID_SEARCH_PERIOD = "228";
	public static final String INVALID_SEARCH_PERIOD_MSG = "Invalid Search Period";
	public static final String INVALID_COMPANY_CODE = "229";
	public static final String INVALID_COMPANY_CODE_MSG = "Invalid Company Code";
	public static final String INVALID_POINT_TYPE_ID = "230";
	public static final String INVALID_POINT_TYPE_ID_MSG = "Invalid Point Type ID";
	public static final String INVALID_ADD_POINT = "231";
	public static final String INVALID_ADD_POINT_MSG = "Invalid Add Point";
	public static final String INVALID_ADD_POINT_DESC = "232";
	public static final String INVALID_ADD_POINT_DESC_MSG = "Invalid Add Point Desc";
	public static final String INVALID_USE_POINT = "233";
	public static final String INVALID_USE_POINT_MSG = "Invalid Use Point";
	public static final String INVALID_USE_POINT_DESC = "234";
	public static final String INVALID_USE_POINT_DESC_MSG = "Invalid Use Point Desc";
	public static final String DATABASE_ACCESS_ERROR = "235";
	public static final String DATABASE_ACCESS_ERROR_MSG = "Database Access Error";	
	public static final String INVALID_BRANCH_CODE = "236";
	public static final String INVALID_BRANCH_CODE_MSG = "Invalid Branch Code";
	public static final String INVALID_PBP_ID = "237";
	public static final String INVALID_PBP_ID_MSG = "Invalid Pbp ID";
	public static final String INVALID_PARAMETER = "238";
	public static final String INVALID_PARAMETER_MSG = "Invalid Parameter";
	public static final String INVALID_CANCEL_YN = "239";
	public static final String INVALID_CANCEL_YN_MSG = "Invalid Cancel YN";
	public static final String INVALID_CUST_ID = "240";
	public static final String INVALID_CUST_ID_MSG = "Invalid Cust ID";
	public static final String INVALID_TX_DIV = "241";
	public static final String INVALID_TX_DIV_MSG = "Invalid Tx Div";
	public static final String INVALID_AUTO_LOGIN_UID = "242";
	public static final String INVALID_AUTO_LOGIN_UID_MSG = "Invalid Auto LogIn UID";
	public static final String INVALID_AUTO_LOGIN_TOKEN = "243";
	public static final String INVALID_AUTO_LOGIN_TOKEN_MSG = "Invalid Auto LogIn Token";
	public static final String INVALID_ACCESS = "244";
	public static final String INVALID_ACCESS_MSG = "INVALID ACCESS";
	
	public static final String INTERNAL_SERVER_ERROR = "300";
	public static final String INTERNAL_SERVER_ERROR_MSG = "Internal Server Error";
}
