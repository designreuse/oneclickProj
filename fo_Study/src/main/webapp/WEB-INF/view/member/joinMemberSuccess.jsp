<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(document).ready(function () {
	// Path 및 LeftTitle 설정
	$("#li_member > a").addClass("current");
	$("#li_joinMember > a").addClass("current");
	var strHtml = "<a href='/member/updateMember'><span>회원정보</span></a><span class='current'>회원가입</span>";
	$("#header_path").append(strHtml);
	$("#leftTitle").text("회원가입");
	
	var invalidAccess = ${invalidAccess};
	if (invalidAccess) {
		alert("잘못된 접근입니다. 메인페이지로 이동합니다.");
		location.replace("/");
	}
	
	
	var empJoinYn = "${empJoinYn}";
	var siteCode = "${siteCode}";
	if ("Y" == empJoinYn) {
		$("#div_staff").show();
	} else {
		if ("10" == siteCode) {
			$("#div_partnership").show();
			$("#retailMall").show();
			countdown();
		} else if ("20" == siteCode) {
			$("#div_partnership").show();
			$("#ecore").show();
			countdown();
		} else if ("30" == siteCode) {
			$("#div_oneclick").show();
// 			countdown();
		}
	}
	
});

function locateKap() {
	if ("30" == "${siteCode}") {
		location.replace("/");
	} else {
		goToPartnerShip();
	}	
}

cnt = 5; // 카운트다운 시간 초단위로 표시
function countdown() {
 if (cnt == 0) {
	// 시간이 0일경우
	locateKap();
 } else {
	// 시간이 남았을 경우 카운트다운을 지속한다.
	if ("10" == "${siteCode}") {
		$("#countDown1").text(cnt + "초후에 <spring:message code='name.elandmall' />(으)로 이동합니다.");
		setTimeout("countdown()",1000);
		cnt--;
	} else if ("20" == "${siteCode}") {
		$("#countDown2").text(cnt + "초후에 <spring:message code='name.elandretail' />(으)로 이동합니다.");
		setTimeout("countdown()",1000);
		cnt--;
	} else if ("30" == "${siteCode}") {
		$("#countDown3").text(cnt + "초후에 E:LAND OneClick(으)로 이동합니다.");
		setTimeout("countdown()",1000);
		cnt--;
	}

 }
}

function goToPartnerShip() {
	location.href = "${joinReturnUrl}"; 
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
			<li><span>STEP 01</span>본인확인</li>
			<li><span>STEP 02</span>약관동의</li>
			<li><span>STEP 03</span>정보입력</li>
			<li class="on"><span>STEP 04</span>가입완료</li>
		</ol>
	</div><!-- // stepBox -->
	
	<!-- 제휴 사이트 회원 가입 완료-->
	<div class="tabContent mt40" style="display:none" id="div_partnership">
		<p class="taC pageGuide">이랜드리테일 원클릭 회원가입이 정상적으로 이루어졌습니다.<br>앞으로 고객님께 알찬 정보, 다양한 이벤트와<br>혜택을 드리고자 최선을 다하겠습니다.</p>
		<div class="btnDiv taC mt35">
			<a href="javascript:goToPartnerShip();" class="btn blue large w305" style="display:none" id="retailMall"><span id="countDown1">5초후에 <spring:message code="name.elandmall" />(으)로 이동합니다.</span></a>
			<a href="javascript:goToPartnerShip();" class="btn blue large w305" style="display:none" id="ecore"><span id="countDown2">5초후에 <spring:message code="name.elandretail" />(으)로 이동합니다.</span></a>
		</div>

	</div><!-- // tabContent -->
	
	<!-- 원클릭 회원가입 완료 -->
	<div class="tabContent mt40" style="display:none" id="div_oneclick">
		<p class="taC pageGuide mb30">이랜드리테일 원클릭 회원가입이 정상적으로 이루어졌습니다.<br>앞으로 고객님께 알찬 정보, 다양한 이벤트와<br>혜택을 드리고자 최선을 다하겠습니다.</p>
	</div>
	
	<!-- 임직원 회원 가입 완료 -->
	<div class="tabContent mt40" style="display:none" id="div_staff">
		<p class="taC pageGuide mb30">이랜드리테일 원클릭 회원가입이 정상적으로 이루어졌습니다.<br>앞으로 고객님께 알찬 정보, 다양한 이벤트와<br>혜택을 드리고자 최선을 다하겠습니다.</p>
		<div class="btnDiv taC mt35">
			<a href="#" class="btn blue large" target="_blank"><span>임직원 인증하러 가기</span></a>
		</div>

	</div>
</div>