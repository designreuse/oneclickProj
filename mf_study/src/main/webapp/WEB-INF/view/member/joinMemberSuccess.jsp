<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(document).ready(function () {
	
	var invalidAccess = ${invalidAccess};
	if (invalidAccess) {
		commonAlert("잘못된 접근입니다. 메인페이지로 이동합니다.");
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





<div class="container">
		<section class="cntDiv">

			<div class="lineMap">
				<div class="path">
					<span class="home">HOME</span>
					<span><a href="/member/updateMember" rel="external">회원정보</a></span>
					<c:choose>
						<c:when test="${10 eq siteCode}">
							<span class="current"><spring:message code="name.elandmall" /> 회원가입</span>
						</c:when>
						<c:when test="${20 eq siteCode}">
							<span class="current"><spring:message code="name.elandretail" /> 회원가입</span>
						</c:when>
						<c:otherwise>
							<span class="current"><spring:message code="name.elandoneclick" /> 회원가입</span>
						</c:otherwise>
					</c:choose>
					
				</div>
			</div><!-- // lineMap -->
			
			<c:choose>
				<c:when test="${10 eq siteCode}">
					<div class="pageTitle">
						<h2><spring:message code="name.elandmall" /> 회원가입</h2>
					</div>
				</c:when>
				<c:when test="${20 eq siteCode}">
					<div class="pageTitle">
						<h2><spring:message code="name.elandretail" /> 회원가입</h2>
					</div>
				</c:when>
				<c:otherwise>
					<div class="pageTitle">
						<h2><spring:message code="name.elandoneclick" /> 회원가입</h2>
					</div>
				</c:otherwise>
			</c:choose>			

			<div class="content inner">

				<div class="stepBox">
					<ol>
						<li><span class="num">STEP 01</span><span class="txt">본인확인</span></li>
						<li><span class="num">STEP 02</span><span class="txt">약관동의</span></li>
						<li><span class="num">STEP 03</span><span class="txt">정보입력</span></li>
						<li class="on"><span class="num">STEP 04</span><span class="txt">가입완료</span></li>
					</ol>
				</div><!-- // stepBox -->
				
				<!-- 제휴사 가입 완료 -->
				<div style="display:none" id="div_partnership">
					<div class="pageGuide taC mt35" >
						<p class="important"><strong>이랜드리테일 원클릭 회원가입이<br />정상적으로 이루어졌습니다.</strong></p>
						<p class="mt10">앞으로 고객님께 알찬 정보, 다양한 이벤트와<br />혜택을 드리고자 최선을 다하겠습니다.</p>
					</div>
	
					<div class="btnDiv taC mt35">
						<a href="javascript:goToPartnerShip();" class="btn blue large" style="display:none" id="retailMall"><span id="countDown1">5초후에 E:LAND MALL(으)로 이동합니다.</span></a>
						<a href="javascript:goToPartnerShip();" class="btn blue large" style="display:none" id="ecore"><span id="countDown2">5초후에 E:CORE(으)로 이동합니다.</span></a>
					</div>
				</div>
				
				<!-- 원클릭 가입 완료 -->
				<div class="pageGuide taC mt35" style="display:none" id="div_oneclick">
					<p class="important"><strong>이랜드리테일 원클릭 회원가입이<br />정상적으로 이루어졌습니다.</strong></p>
					<p class="mt10">앞으로 고객님께 알찬 정보, 다양한 이벤트와<br />혜택을 드리고자 최선을 다하겠습니다.</p>
				</div>
				
				<div style="display:none" id="div_staff">
					<div class="pageGuide taC mt35">
						<p class="important"><strong>이랜드리테일 원클릭 회원가입이<br />정상적으로 이루어졌습니다.</strong></p>
						<p class="mt10">앞으로 고객님께 알찬 정보, 다양한 이벤트와<br />혜택을 드리고자 최선을 다하겠습니다.</p>
					</div>
	
					<div class="btnDiv taC mt35">
						<a href="#" class="btn blue large" target="_blank"><span>임직원 인증하러 가기</span></a>
					</div>
				</div>
			</div><!-- // content -->
		</section>
	</div><!-- // container -->
