var searchGuNameUrl = "/popup/searchGuNm.action";
var searchPostNoUrl = "/popup/searchPostNoBodyListAjax.action";
var searchConvertAddrUrl = "/popup/searchConvertAddrAjax.action";

/**
 * 시군구 찾기
 * @param cityNm
 */
function searchGuNm(url, cityNm) {
	var encodeCityNm = encodeURIComponent(cityNm);
	jQuery.support.cors = true;
	gatewayURL = location.protocol + "//" + location.host + "/gateway.html";
    jQuery.ajax({
          type:"GET",
          url : url + "/popup/searchGuNm.action?&city_nm="+ encodeCityNm,
		  crossDomain : true,
          dataType:"JSON", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
          success : function(result) {
        	  var jsonAddr = JSON.stringify(result);
        	  getSiGunGuCallBack(jsonAddr);
          },
          complete : function(result) {
                // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
          },
          error : function(xhr, status, error) {
                alert("에러발생"+status+error);
          }
    });
}

function searchPostNo(url, isNewAddr, cityNm, guNm, schNm) {
	var encodeIsNewAddr = encodeURIComponent(isNewAddr);
	var encodeCityNm = encodeURIComponent(cityNm);
	var encodeGuNm = encodeURIComponent(guNm);
	var encodeSchNm = encodeURIComponent(schNm);
	
	$.support.cors = true;
	gatewayURL = location.protocol + "//" + location.host + "/gateway.html";
    $.ajax({
          type:"GET",
          url : url + "/popup/searchPostNoBodyListAjax.action?isNewAddr="+ encodeIsNewAddr +"&city_nm="+ encodeCityNm +"&gu_nm="+ encodeGuNm +"&sch_nm="+ encodeSchNm,
		  crossDomain : true,
          dataType:"JSON", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
          success : function(result) {
        	 var jsonAddr = JSON.stringify(result);
        	  searchAddrCallBack(jsonAddr);
          },
          complete : function(result) {
                // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
          },
          error : function(xhr, status, error) {
                alert("에러발생"+status+error);
          }
    });
}

function searchConvertAddr(url, isNewAddr, postNo, addr, addrDetail) {
	
	var encodeIsNewAddr = encodeURIComponent(isNewAddr);
	var encodePostNo = encodeURIComponent(postNo);
	var encodeAddr = encodeURIComponent(addr);
	var encodeAddrDetail = encodeURIComponent(addrDetail);
	
	jQuery.support.cors = true;
	gatewayURL = location.protocol + "//" + location.host + "/gateway.html";
    jQuery.ajax({
          type:"GET",
          url : url + "/popup/searchConvertAddrAjax.action?isNewAddr="+ encodeIsNewAddr +"&post_no="+ encodePostNo +"&addr="+ encodeAddr +"&addrDetail="+ encodeAddrDetail,
		  crossDomain : true,
		  dataType:"JSON", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
          success : function(result) {
        	  var jsonAddr = JSON.stringify(result);
        	  searchAddrConvertCallBack(jsonAddr);
          },
          complete : function(result) {
                // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
          },
          error : function(xhr, status, error) {
                alert("에러발생"+status+error);
          }
    });
}
