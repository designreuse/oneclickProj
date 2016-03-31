package com.eland.ngoc.common;

public class OcOaConstants {
	// site별 client ID 정의
	public static final String ELANDMALL_ID = "elandmall";
	public static final String ECORE_ID = "ecorepage";
	public static final String EIMSCS_ID = "eimscs";
	public static final String ONCLICK_ID = "oneclick";
	public static final String ONCLICK_FO_ID = "oneclickfo";
	public static final String ONCLICK_BO_ID = "oneclickbo";

	// site별 client Secret 정의
	/*public static final String ELANDMALL_PWD_DEV = "BBfBGCOsI3";
	public static final String ECORE_PWD_DEV = "88IE7rahGF";
	public static final String EIMSCS_PWD_DEV = "78m3WoaJMr";
	public static final String ONCLICK_PWD_DEV = "Vk9SrMOew6";
	public static final String ONCLICK_FO_PWD_DEV = "JAKPYaihrN";
	public static final String ONCLICK_BO_PWD_DEV = "vt6llvnIuK";
	public static final String ELANDMALL_PWD_QA = "sd3uDWJsMX";
	public static final String ECORE_PWD_QA = "8IGrsDKpzT";
	public static final String EIMSCS_PWD_QA = "zYEsJKBkYf";
	public static final String ONCLICK_PWD_QA = "VZT9EHYc7q";
	public static final String ONCLICK_FO_PWD_QA = "gHX2qf6GEL";
	public static final String ONCLICK_BO_PWD_QA = "fptI5Z9f1k";
	public static final String ELANDMALL_PWD_PRD = "mLYgraEUa4";
	public static final String ECORE_PWD_PRD = "EobaJvOxcT";
	public static final String EIMSCS_PWD_PRD = "0jMpxkAaOC";
	public static final String ONCLICK_PWD_PRD = "eodvtvftGU";
	public static final String ONCLICK_FO_PWD_PRD = "Cd4bA35Ab3";
	public static final String ONCLICK_BO_PWD_PRD = "gT2oyvmmCY";*/
	
	// EIMS API URL 정의
	public static final String GET_MEMBER_INFO = "/member/getMemberInfo";
	public static final String UPDATE_MEMBER_INFO = "/member/updateMemberInfo";
	public static final String MEMBER_OUT = "/member/memberOut";
	public static final String UPDATE_MEMBER_STATE = "/member/updateMemberState";
	public static final String CANCEL_MEMBER_OUT = "/member/cancelMemberOut";
	public static final String GET_POINT_INFO = "/point/getPointInfo";
	public static final String ADD_POINT = "/point/addPointTx";
	public static final String USE_POINT = "/point/usePointTx";

	// 에러 메시지 정의
	public static final String RESULT_SUCCESS = "0";
	public static final String RESULT_FAIL = "1";
	
	public static final String INVALID_AUTHORIZATION = "100";
	public static final String INVALID_AUTHORIZATION_MSG = "Invalid Authorization";	
	public static final String INVALID_ACCESS_TOKEN = "200";
	public static final String INVALID_ACCESS_TOKEN_MSG = "Invalid Token";	
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
	public static final String INVALID_POINT_TYPE = "230";
	public static final String INVALID_POINT_TYPE_MSG = "Invalid Point Type";
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
	public static final String INVALID_PARAMETER_MSG = "Invalid Parameter Name";
	public static final String INVALID_CANCEL_YN = "239";
	public static final String INVALID_CANCEL_YN_MSG = "Invalid Cancel Yn";
	public static final String INVALID_CUST_ID = "240";
	public static final String INVALID_CUST_ID_MSG = "Invalid Cust ID";
	public static final String INVALID_TX_DIV = "241";
	public static final String INVALID_TX_DIV_MSG = "Invalid tx Div";
	public static final String INVALID_AUTO_LOGIN_UID = "242";
	public static final String INVALID_AUTO_LOGIN_UID_MSG = "Invalid Auto LogIn UID";
	public static final String INVALID_AUTO_LOGIN_TOKEN = "243";
	public static final String INVALID_AUTO_LOGIN_TOKEN_MSG = "Invalid Auto LogIn Token";
	
	public static final String EIMS_API_PROCESS_ERROR = "300";
	public static final String EIMS_API_PROCESS_ERROR_MSG = "EIMS API Process Error";
	public static final String INVALID_CUST_GENDER = "301";
	public static final String INVALID_CUST_GENDER_MSG = "Invalid Cust Gender";
	public static final String INVALID_OUT_DIV = "302";
	public static final String INVALID_OUT_DIV_MSG = "Invalid Out Div";
	public static final String INVALID_BIRTHDAY_TYPE = "303";
	public static final String INVALID_BIRTHDAY_TYPE_MSG = "Invalid Cust Birthday Type";
	public static final String INVALID_ADDR_DIV = "304";
	public static final String INVALID_ADDR_DIV_MSG = "Invalid Addr Div";
	public static final String INVALID_CUST_INFO = "305";
	public static final String INVALID_CUST_INFO_MSG = "Invalid Cust Info";
	public static final String PROVISIONING_ERROR = "306";
	public static final String PROVISIONING_ERROR_MSG = "provisioning Error";
	public static final String ELANDMALL_API_PROCESS_ERROR = "307";
	public static final String ELANDMALL_API_PROCESS_ERROR_MSG = "ELANDMALL API Process Error";
	public static final String ECORE_API_PROCESS_ERROR = "308";
	public static final String ECORE_API_PROCESS_ERROR_MSG = "ECORE API Process Error";
	public static final String NOT_JOIN_SITE_ACCESS_ERROR = "309";
	public static final String NOT_JOIN_SITE_ACCESS_ERROR_MSG = "Not Join Site Access Error";
	public static final String CANNOT_CANCEL_OVER_30_DAYS = "310";
	public static final String CANNOT_CANCEL_OVER_30_DAYS_MSG = "Cannot Cancel Over 30 days";
	public static final String INVALID_EMP_ID = "311";
	public static final String INVALID_EMP_ID_MSG = "Invalid Emp ID";
	public static final String INVALID_CUST_STAT = "312";
	public static final String INVALID_CUST_STAT_MSG = "Invalid Cust State";
	
	public static final String INTERNAL_SERVER_ERROR = "500";
	public static final String INTERNAL_SERVER_ERROR_MSG = "Internal Server Error";

	// oneclick 사용 공통 constants
	public static final String CREATE_TOKEN_PREFIX = "oneClick";
	
	// 각종 코드 정의
	public static final String CUST_STAT_NORMAL = "10";
	public static final String CUST_STAT_REST = "20";
	public static final String CUST_STAT_LOCK = "30";
	public static final String CUST_STAT_OUT = "50";
	
	public static final String SITE_CODE_MALL = "10";
	public static final String SITE_CODE_CORE = "20";
}
