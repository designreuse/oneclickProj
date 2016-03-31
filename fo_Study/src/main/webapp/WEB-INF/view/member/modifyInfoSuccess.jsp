<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var retUrl;

$(document).ready(function () {
	$("#li_member > a").addClass("current");
	$("#li_updateMember > a").addClass("current");
	var strHtml = "<a href='/member/updateMember'><span>회원정보</span></a><span class='current'>회원정보 수정</span>";
	$("#header_path").append(strHtml);
	
	retUrl = $.trim("${returnUrl}");
	countdown();
});

function locateKap() {
	if ("30" != "${currentSiteCode}") {	
		if (retUrl != null && retUrl != "") {
			if (retUrl.indexOf("?") >= 0) {
				location.replace(retUrl + "&accessToken=${accessToken}");
			} else {
				location.replace(retUrl + "?accessToken=${accessToken}");
			}
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
	if (retUrl != null && retUrl != "") {
		if ("10" == "${currentSiteCode}") {
			$("#countDown").text(cnt + "초후에 <spring:message code='name.elandmall' />(으)로 이동합니다.");
			setTimeout("countdown()",1000);
			cnt--;
		} else if ("20" == "${currentSiteCode}") {
			$("#countDown").text(cnt + "초후에 <spring:message code='name.elandretail' />(으)로 이동합니다.");
			setTimeout("countdown()",1000);
			cnt--;
		} else if ("30" == "${currentSiteCode}") {
			$("#countDown").parent().hide();
		}
	} else {
		$("#countDown").parent().hide();
	}
	
 }
}
	
</script>

<!-- 컨텐츠 상세 영역 시작 -->
<div class="content">
	<h3>회원정보 수정</h3>
	<div class="icoArea">
		<span class="ir_ico modify"></span>
	</div>
	<p class="taC pageGuide mt40">이랜드리테일 원클릭 회원정보 수정이 정상적으로 이루어졌습니다.<br />앞으로 고객님께 알찬 정보, 다양한 이벤트와<br />혜택을 드리고자 최선을 다하겠습니다.</p>
	<div class="btnDiv taC mt35">
		<a href="javascript:locateKap();" class="btn blue large w305"><span id="countDown">5초후에 <spring:message code="name.elandmall" />(으)로 이동합니다</span></a>
	</div>

</div>
<!-- // content :: 컨텐츠 상세 영역 끝 -->
