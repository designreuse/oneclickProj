package com.eland.ngoc.point.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.eland.ngoc.common.OcOaConstants;
import com.eland.ngoc.common.model.Result;
import com.eland.ngoc.common.service.RedisService;
import com.eland.ngoc.common.utils.CommonUtil;
import com.eland.ngoc.exception.UserHandleException;
import com.eland.ngoc.point.model.CustPointInfo;
import com.eland.ngoc.point.model.CustPointInfoRsp;
import com.eland.ngoc.point.model.CustPointSave;
import com.eland.ngoc.point.model.CustPointUse;
import com.eland.ngoc.point.service.CustPointService;

@RestController
@RequestMapping(value="/point")
public class CustPointController {
	// logger 선언
    private final Logger logger = LoggerFactory.getLogger(CustPointController.class);

	@Autowired
	private CustPointService custPointService;
	
	@Autowired
	private RedisService redisService;

	/**
	 * <pre>
	 * 포인트 이력 조회: EIMS로부터 정보를 받아서 bypass
	 * 1. EIMS와 연동하여 가용/누적 포인트, 포인트 사용 이력을 조회할 수 있는 기능 제공
	 * 2. 회원의 상태가 무실적,탈퇴 시에도 일정 기간은 조회가 가능함
	 * </pre>
	 * @param request
	 * @param response
	 * @return CustPointRsp model
	 */
	@RequestMapping(value = "/getPointInfo", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public String getCustPointList(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("cpoint") CustPointInfo cpoint) {
		CustPointInfoRsp cpointInfoRsp = new CustPointInfoRsp();

		try {
			cpointInfoRsp = custPointService.getCustPointList(request, cpoint);
			if (OcOaConstants.RESULT_SUCCESS.equals(cpointInfoRsp.getResultCode())) {
				response.setStatus(200);
			} else {
				response.setStatus(400);
			}
		} catch (UserHandleException ue) {
			cpointInfoRsp.setResultCode(OcOaConstants.RESULT_FAIL);
			cpointInfoRsp.setErrorCode(ue.getMessage());
			cpointInfoRsp.setErrorMsg(ue.getMsgDesc());

			logger.debug("{errorCode : " + cpointInfoRsp.getErrorCode() + ", errorMsg : " + cpointInfoRsp.getErrorMsg() + "}");
		} catch(Exception e) {
			e.printStackTrace();
			cpointInfoRsp.setResultCode(OcOaConstants.RESULT_FAIL);
			cpointInfoRsp.setErrorCode(OcOaConstants.INTERNAL_SERVER_ERROR);
			cpointInfoRsp.setErrorMsg(OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}

		return CommonUtil.convertObjectToJson(cpointInfoRsp);
	}
	
	/**
	 * <pre>
	 * 포인트 적립 처리: 적립 또는 취소 처리
	 * </pre>
	 * @param request
	 * @param response
	 * @return Result model
	 */
	@RequestMapping(value = "/addPointTx", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public String addOrCancelCustPoint(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("cpointSave") CustPointSave cpointSave) {
		Result result = new Result();

		try {
			result = custPointService.addOrCancelCustPoint(request, cpointSave);
			if (OcOaConstants.RESULT_SUCCESS.equals(result.getResultCode())) {
				response.setStatus(200);
			} else {
				response.setStatus(400);
			}
		} catch (UserHandleException ue) {
			result.setResultCode(OcOaConstants.RESULT_FAIL);
			result.setErrorCode(ue.getMessage());
			result.setErrorMsg(ue.getMsgDesc());

			logger.debug("{errorCode : " + result.getErrorCode() + ", errorMsg : " + result.getErrorMsg() + "}");
		} catch(Exception e) {
			e.printStackTrace();
			result.setResultCode(OcOaConstants.RESULT_FAIL);
			result.setErrorCode(OcOaConstants.INTERNAL_SERVER_ERROR);
			result.setErrorMsg(OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}

		return CommonUtil.convertObjectToJson(result);
	}
	
	/**
	 * <pre>
	 * 포인트 사용 처리: 사용 또는 취소 처리
	 * </pre>
	 * @param request
	 * @param response
	 * @return Result model
	 */
	@RequestMapping(value = "/usePointTx", method = RequestMethod.POST, produces = { "application/json; charset=UTF-8" })
	public String useOrCancelCustPoint(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("cpointUse") CustPointUse cpointUse) {
		Result result = new Result();

		try {
			result = custPointService.useOrCancelCustPoint(request, cpointUse);
			if (OcOaConstants.RESULT_SUCCESS.equals(result.getResultCode())) {
				response.setStatus(200);
			} else {
				response.setStatus(400);
			}
		} catch (UserHandleException ue) {
			result.setResultCode(OcOaConstants.RESULT_FAIL);
			result.setErrorCode(ue.getMessage());
			result.setErrorMsg(ue.getMsgDesc());

			logger.debug("{errorCode : " + result.getErrorCode() + ", errorMsg : " + result.getErrorMsg() + "}");
		} catch(Exception e) {
			e.printStackTrace();
			result.setResultCode(OcOaConstants.RESULT_FAIL);
			result.setErrorCode(OcOaConstants.INTERNAL_SERVER_ERROR);
			result.setErrorMsg(OcOaConstants.INTERNAL_SERVER_ERROR_MSG);
		}

		return CommonUtil.convertObjectToJson(result);
	}
}
