<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function () {

});

function clickPcc() {
	$.ajax({
		type : "GET",
		url : '/member/setPccInfo?srvType=join',
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
		url : '/member/setIpinInfo?srvType=join',
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
 *  본인인증후 팝업창에서 호출
 */
function goToJoinStep2() {
	document.gForm.submit();
}

</script>
<div class="container">
	<section class="cntDiv">
	
		<div class="lineMap">
			<div class="path">
				<span class="home"><a href="/" rel="external">HOME</a></span>
				<span><a href="/member/updateMember" rel="external">회원정보</a></span>
				<span class="current">회원가입</span>
			</div>
		</div><!-- // lineMap -->
				
		<div class="pageTitle">
			<c:choose>
			<c:when test="${10 eq siteCode}">
				<h2><spring:message code="name.elandmall" /> 회원가입</h2>
			</c:when>
			<c:when test="${20 eq siteCode}">
				<h2><spring:message code="name.elandretail" /> 회원가입</h2>
			</c:when>
			<c:otherwise>
				<h2><spring:message code="name.elandoneclick" /> 회원가입</h2>
			</c:otherwise>
		</c:choose>
		
		</div>
	
		<div class="content inner">
	
			<div class="stepBox">
				<ol>
					<li class="on"><span class="num">STEP 01</span><span class="txt">본인확인</span></li>
					<li><span class="num">STEP 02</span><span class="txt">약관동의</span></li>
					<li><span class="num">STEP 03</span><span class="txt">정보입력</span></li>
					<li><span class="num">STEP 04</span><span class="txt">가입완료</span></li>
				</ol>
			</div><!-- // stepBox -->
	
			<p class="taC pageGuide2 mt10">회원님의 소중한 개인정보 보호를 위하여 본인확인이 필요합니다.<br>원하시는 본인확인 방법을 선택해주세요.</p>
			
			<div class="certiBox mt15">
				<div class="box b1">
					<a href="javascript:clickPcc();" target="_blank" class="ui-link">
						<span class="ir_ico mobile"></span>
						<strong class="tit">휴대폰 인증</strong><span class="desc mt5">공인된 인증기관을 통해<br>휴대폰 인증을<br>받을 수 있습니다 </span>
					</a>
				</div><!-- // box :: 휴대폰인증 -->
				<div class="box b2">
					<a href="javascript:clickIpin();" target="_blank" class="ui-link">
						<span class="ir_ico ipin"></span>
						<strong class="tit">아이핀 인증</strong><span class="desc mt5">공인된 인증기관을 통해<br>아이핀 실명인증을<br>받을 수 있습니다 </span>
					</a>
				</div><!-- // box :: 아이핀인증 -->
			</div><!-- // certiBox -->
	
			<div class="warningBox mt15">
				<ul>
					<li><span class="bl">·</span>14세 미만은 회원가입이 제한됩니다.</li>
					<li><span class="bl">·</span>본인확인은 휴대폰 인증과 아이핀 인증을 통해 하실 수 있습니다.</li>
					<li><span class="bl">·</span>본인확인은 공인된 인증회사에서 철저한 보안으로 진행됩니다.</li>
					<li><span class="bl">·</span>이랜드 원클릭을 이용하시더라도 직접 가입한 사이트만 이용 가능하며, 제휴 사이트에는 정보가 공유되지 않습니다.</li>
				</ul>
			</div><!-- // warningBox -->
	
		</div><!-- // content -->
	
	</section>
</div>

<form name="reqPCCForm" id="pccForm" method="post" action="https://pcc.siren24.com/pcc_V3/jsp/pcc_V3_j10.jsp" >
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

<form name="gForm" id="gForm" method="post" action="/member/joinMemberStep2">
	<input type="hidden" id="reqSiteCode" name="reqSiteCode" value="${siteCode}" />
</form>	

