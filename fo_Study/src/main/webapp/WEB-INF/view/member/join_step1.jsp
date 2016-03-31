<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function () {

	$("#li_member > a").addClass("current");
	$("#li_joinMember > a").addClass("current");
	var strHtml = "<a href='/member/updateMember'><span>회원정보</span></a><span class='current'>회원가입</span>";
	$("#header_path").append(strHtml);
	
	$("#leftTitle").text("회원가입");
	
	
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
			openPCCWindow();
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
			openCBAWindow();
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

<div class="content">
	<c:choose>
		<c:when test="${10 eq siteCode}">
			<h3><span class="en"><spring:message code="name.elandmall" /></span> 회원가입</h3>
		</c:when>
		<c:when test="${20 eq siteCode}">
			<h3><span class="en"><spring:message code="name.elandretail" /></span> 회원가입</h3>
		</c:when>
		<c:otherwise>
			<h3><span class="en"><spring:message code="name.elandoneclick" /></span> 회원가입</h3>
		</c:otherwise>
	</c:choose>
	<div class="stepBox">
		<ol>
			<li class="on"><span>STEP 01</span>본인확인</li>
			<li><span>STEP 02</span>약관동의</li>
			<li><span>STEP 03</span>정보입력</li>
			<li><span>STEP 04</span>가입완료</li>
		</ol>
	</div><!-- // stepBox -->

	<div class="tabContent mt40">
		<p class="taC pageGuide mb30">회원님의 소중한 개인정보 보호를 위하여 본인확인이 필요합니다.<br>원하시는 본인확인 방법을 선택해주세요.</p>
		<div class="certiBox">
			<div class="box">
				<a href="javascript:clickPcc();"><span class="ir_ico mobile"></span>
				<strong class="tit">휴대폰 인증</strong><span class="desc mt5">공인된 인증기관을 통해<br>휴대폰 인증을<br>받을 수 있습니다 </span></a>
			</div><!-- // box :: 휴대폰인증 -->
			<div class="box">
				<a href="javascript:clickIpin();"><span class="ir_ico ipin"></span>
				<strong class="tit">아이핀 인증</strong><span class="desc mt5">공인된 인증기관을 통해<br>아이핀 실명인증을<br>받을 수 있습니다 </span></a>
			</div><!-- // box :: 아이핀인증 -->
		</div>
		
		<div class="warningBox mt50">
			<ul>
				<li><span class="bl">-</span> 만14세 미만은 회원가입이 제한됩니다.</li>
				<li><span class="bl">-</span> 본인확인은 휴대폰 인증과 아이핀 인증을 통해 하실 수 있습니다.</li>
				<li><span class="bl">-</span> 본인확인은 공인된 인증회사에서 철저한 보안으로 진행됩니다.</li>
				<li><span class="bl">-</span> 이랜드 원클릭을 이용하시더라도 직접 가입한 사이트만 이용 가능하며, 제휴 사이트에는 정보가 공유되지 않습니다.</li>
			</ul>
		</div><!-- // warningBox -->
	</div><!-- // tabContent -->

</div>

<form name="reqPCCForm" id="pccForm" method="post" action="" >
	<input type="hidden" id="reqInfo" name="reqInfo" value="" />
	<!-- 요청정보 -->
	<input type="hidden" id="retUrl" name="retUrl" value="" />
	<!-- 리턴받을URL -->
</form>

<!--아이핀  -->
<form name="ipinForm" id="ipinForm" method="post">
	<input type="hidden" id="reqIpinInfo" name="reqInfo" value="" />
	<!-- 요청정보 -->
	<input type="hidden" id="retIpinUrl" name="retUrl" value="" />
	<!-- 리턴받을URL -->
</form>	

<form name="gForm" id="gForm" method="post" action="/member/joinMemberStep2">
	<input type="hidden" id="reqSiteCode" name="reqSiteCode" value="${siteCode}" />
</form>	

