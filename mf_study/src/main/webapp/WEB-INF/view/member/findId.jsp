<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
$(document).ready(function () {
	
	var webId = "${webId}";
	var isMember = "${isMember}";
	if (isMember != "") {
		idSearchResult(isMember, webId);
	}
});


function clickPcc() {
	$.ajax({
		type : "GET",
		url : '/member/setPccInfo?srvType=scId',
		async : false,
		cache : false,
		success : function(result) {
			$("#reqInfo").val(result.reqPccInfo);
			$("#retUrl").val(result.retPccUrl);
// 			openPCCWindow();
			document.reqPCCForm.submit();
		},
		error : function(e) {
			alert(e.responseText);
		}
	});
}

function clickIpin() {
	$.ajax({
		type : "GET",
		url : '/member/setIpinInfo?srvType=scId',
		async : false,
		cache : false,
		success : function(result) {
			$("#reqIpinInfo").val(result.reqIpinInfo);
			$("#retIpinUrl").val(result.retIpinUrl);
// 			openCBAWindow();
			document.ipinForm.submit();
		},
		error : function(e) {
			alert(e.responseText);
		}
	});
}

/**
 *  아이디 찾기 결과 호출
 */
function idSearchResult(isMember, webId) {
	
	if (isMember == "N") {
		commonAlert("가입한 회원이 아닙니다.");
	} else {
		$("#span_webId").text(webId);
// 		$("#findID").show(function () {
			normalPopup ("findID");
// 		});
	}
}



/**
 *  비밀번호 찾기 페이지로 이동
 */
function goToFindPwd() {
	location.href = "/member/findPwd";
}

/**
 *  returnUrl 존재시 이동
 */
function goToReturnUrl() {
	var returnUrl = "${scIdReturnUrl}";
	if (returnUrl != null && returnUrl != "") {
		location.href = returnUrl;
	}
}

	
</script>

<div class="container">
<section class="cntDiv">

	<div class="lineMap">
		<div class="path">
			<span class="home"><a href="/" rel="external">HOME</a></span>
			<span><a href="/member/updateMember" rel="external">회원정보</a></span>
			<span class="current">아이디 찾기</span>
		</div>
	</div><!-- // lineMap -->

	<div class="pageTitle">
		<h2>아이디/비밀번호 찾기</h2>
	</div>

	<div class="tabMenu ui-navbar" data-role="navbar" role="navigation">
		<ul class="ui-grid-a">
			<li class="ui-block-a"><h3><a href="#" rel="external" class="ui-btn-active current ui-link ui-btn">아이디 찾기</a></h3></li>
			<li class="ui-block-b"><h3><a href="javascript:goToFindPwd();" rel="external" class="ui-link ui-btn">비밀번호 찾기</a></h3></li>
		</ul>
	</div><!-- // tabMenu -->

	<div class="content member">

		<p class="taC pageGuide2">회원님의 소중한 개인정보 보호를 위하여 본인확인이 필요합니다.<br>원하시는 본인확인 방법을 선택해주세요.</p>
		<div class="certiBox mt15">
			<div class="box b1">
				<a href="javascript:clickPcc();" class="ui-link"><span class="ir_ico mobile"></span>
				<strong class="tit">휴대폰 인증</strong><span class="desc mt5">공인된 인증기관을 통해<br>휴대폰 인증을<br>받을 수 있습니다 </span></a>
			</div><!-- // box :: 휴대폰인증 -->
			<div class="box b2">
				<a href="javascript:clickIpin();" class="ui-link"><span class="ir_ico ipin"></span>
				<strong class="tit">아이핀 인증</strong><span class="desc mt5">공인된 인증기관을 통해<br>아이핀 실명인증을<br>받을 수 있습니다 </span></a>
			</div><!-- // box :: 아이핀인증 -->
		</div>
		
		<div class="warningBox mt15">
			<ul>
				<li><span class="bl">·</span> 아이디/비밀번호 관리의 책임은 본인에게 있습니다.</li>
				<li><span class="bl">·</span> 타인에게 알려줄 경우 불이익을 당할 수 있으므로 관리에 주의하여 주십시오.</li>
				<li><span class="bl">·</span> 아이디/비밀번호 관리 소홀로 인한 피해는 본 사이트에서 책임지지 않습니다.</li>
			</ul>
		</div><!-- // warningBox -->
	</div><!-- // content -->

</section>

<!-- 팝업 시작 -->
<div id="findID" class="popupBox normal"><!-- 바닥 클릭시 닫히기 방지 :: data-dismissible="false" -->
	<div class="popupHead"><strong>아이디 찾기</strong></div>
	<div class="popupContent">
		<div class="txt taC">회원님의 아이디는<br /><span class="f_point" id="span_webId"></span>입니다.</div>
		<div class="btnDiv mt15 ui-grid-a taC">
			<div class="ui-block-a"><a href="/member/findPwd" class="btn white pop"><span>비밀번호 찾기</span></a></div>
			<div class="ui-block-b"><a href="javascript:goToReturnUrl();" class="btn blue pop layerClose"><span>확인</span></a></div>
		</div><!-- // btnDiv -->
	</div><!-- // popupContent -->
	<a href="#" class="btn_popClose layerClose"><span class="blind">닫기</span></a>
</div>
<!-- // popup :: 팝업 끝 -->

</div>
<form name="reqPCCForm" id="gForm" method="post" action="https://pcc.siren24.com/pcc_V3/jsp/pcc_V3_j10.jsp" >
	<input type="hidden" id="reqInfo" name="reqInfo" value="" />
	<!-- 요청정보 -->
	<input type="hidden" id="retUrl" name="retUrl" value="" />
	<!-- 리턴받을URL -->
</form>

<!--아이핀  -->
<form name="ipinForm" id="ipinForm" method="post" action="https://ipin.siren24.com/i-PIN/jsp/ipin_j10.jsp">
	<input type="hidden" id="reqIpinInfo" name="reqInfo" value="" />
	<!-- 요청정보 -->
	<input type="hidden" id="retIpinUrl" name="retUrl" value="" />
	<!-- 리턴받을URL -->
</form>


