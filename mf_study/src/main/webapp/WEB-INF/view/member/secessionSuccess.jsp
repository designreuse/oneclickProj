<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(document).ready(function () {
	countdown();
});

function locateKap() {
	if ("10" == "${siteCode}" || "20" == "${siteCode}") {
		var retUrl = "${returnUrl}";
		if (retUrl.indexOf("?") >= 0) {
			location.replace(retUrl + "&accessToken=${accessToken}");
		} else {
			location.replace(retUrl + "?accessToken=${accessToken}");
		}
 		
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
			$("#countDown").text(cnt + "초후에 <spring:message code='name.elandmall' />(으)로 이동합니다.");
			setTimeout("countdown()",1000);
			cnt--;
		} else if ("20" == "${siteCode}") {
			$("#countDown").text(cnt + "초후에 <spring:message code='name.elandretail' />(으)로 이동합니다.");
			setTimeout("countdown()",1000);
			cnt--;
		} else if ("30" == "${siteCode}" || "40" == "${siteCode}") {
			$("#countDown").parent().hide();
		}
	}
}

</script>

<div class="container">
	<section class="cntDiv">

		<div class="lineMap">
			<div class="path">
				<span class="home"><a href="/" rel="external">HOME</a></span>
				<span><a href="/member/updateMember" rel="external">회원정보</a></span>
				<span class="current">회원탈퇴</span>
			</div>
		</div><!-- // lineMap -->
		
		<div class="pageTitle">
			<h2>회원탈퇴</h2>
		</div>

		<div class="content inner">

			<div class="pageGuide taC mt20">
				<div class="icoArea">
					<span class="ir_ico modify"></span>
				</div>
				<p class="important mt15"><strong>회원탈퇴가<br />정상적으로 이루어졌습니다.</strong></p>
				<c:choose>
					<c:when test="${('1' eq selectMenu) && ('40' eq custStat)}">
						<p class="mt10">이랜드리테일 원클릭 제휴사이트의 서비스는 기존대로 이용하실 수 있습니다.<br />다른 제휴사이트의 회원탈퇴를 원하실 경우 각 사이트에서 회원탈퇴를 신청해주시기 바랍니다.<br />재가입을 원하실 경우 이랜드리테일 원클릭에서 간단한 동의절차 후 가입이 가능합니다. </p>
					</c:when>
					<c:when test="${('1' eq selectMenu) && ('50' eq custStat)}">
						<p class="mt10">회원정보는 30일간 보관되며, 30일 이내에 고객센터를 통해 탈퇴 철회하실 수 있습니다.<br />30일 이후, 회원정보는 삭제되며, 원상복구가 불가합니다. </p>
					</c:when>
					<c:when test="${'2' eq selectMenu}">
						<p class="mt10">회원정보는 30일간 보관되며, 30일 이내에 고객센터를 통해 탈퇴 철회하실 수 있습니다.<br />30일 이후, 회원정보는 삭제되며, 원상복구가 불가합니다. </p>
					</c:when>
				</c:choose>
			</div>

			<div class="btnDiv taC mt35">
				<a href="javascript:locateKap();" class="btn blue large w305"><span id="countDown">5초후에 <spring:message code="name.elandmall" />(으)로 이동합니다</span></a><!-- 2016-02-25 수정 -->
			</div>
		</div><!-- // content -->

	</section>
</div><!-- // container -->

