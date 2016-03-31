package com.eland.ngoc.point.service;

import javax.servlet.http.HttpServletRequest;

import com.eland.ngoc.common.model.Result;
import com.eland.ngoc.point.model.CustPointInfo;
import com.eland.ngoc.point.model.CustPointInfoRsp;
import com.eland.ngoc.point.model.CustPointSave;
import com.eland.ngoc.point.model.CustPointUse;

public interface CustPointService {
	
	public CustPointInfoRsp getCustPointList(HttpServletRequest request, CustPointInfo cpointInfo);
	
	public Result addOrCancelCustPoint(HttpServletRequest request, CustPointSave cpointSave);
	
	public Result useOrCancelCustPoint(HttpServletRequest request, CustPointUse cpointUse);

}
