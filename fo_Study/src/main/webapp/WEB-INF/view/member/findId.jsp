<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
$(document).ready(function () {
	$("#li_member > a").addClass("current");
	$("#li_idAndPwd > a").addClass("current");
	var strHtml = "<a href='/member/findId'><span>회원정보</span></a><span class='current'>아이디/비밀번호 찾기</span>";
	$("#header_path").append(strHtml);
	
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
		url : '/member/setIpinInfo?srvType=scId',
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
 *  팝업창에서 호출, 비밀번호 찾기 페이지로 이동
 */
function goToFindPwd() {
	location.href = "/member/findPwd";
}

/**
 *  팝업창에서 호출, returnUrl 존재시 이동
 */
function goToReturnUrl() {
	var returnUrl = "${returnUrl}";
	if (returnUrl != null && returnUrl != "") {
		location.href = returnUrl;
	}
}
	
</script>

<div class="content">
	<h3>아이디/비밀번호 찾기</h3>

	<div class="tabMenu type2">
		<ul>
			<li><h4>
					<a href="#" class="on">아이디 찾기</a>
				</h4></li>
			<li><h4>
					<a href="/member/findPwd">비밀번호 찾기</a>
				</h4></li>
		</ul>
	</div>
	<!-- tabMenu -->

	<div class="tabContent mt40">

		<p class="taC pageGuide mb30">
			회원님의 소중한 개인정보 보호를 위하여 본인확인이 필요합니다.<br>원하시는 본인확인 방법을 선택해주세요.
		</p>
		<div class="certiBox">
			<div class="box">
				<a href="javascript:clickPcc();"><span class="ir_ico mobile"></span>
					<strong class="tit">휴대폰 인증</strong><span class="desc mt5">공인된
						인증기관을 통해<br>휴대폰 인증을<br>받을 수 있습니다
				</span></a>
			</div>
			<!-- // box :: 휴대폰인증 -->
			<div class="box">
				<a href="javascript:clickIpin();"><span class="ir_ico ipin"></span> <strong
					class="tit">아이핀 인증</strong><span class="desc mt5">공인된 인증기관을
						통해<br>아이핀 실명인증을<br>받을 수 있습니다
				</span></a>
			</div>
			<!-- // box :: 아이핀인증 -->
		</div>

		<div class="warningBox mt50">
			<ul>
				<li><span class="bl">-</span> 아이디/비밀번호 관리의 책임은 본인에게 있습니다.</li>
				<li><span class="bl">-</span> 타인에게 알려줄 경우 불이익을 당할 수 있으므로 관리에
					주의하여 주십시오.</li>
				<li><span class="bl">-</span> 아이디/비밀번호 관리 소홀로 인한 피해는 본 사이트에서
					책임지지 않습니다.</li>
			</ul>
		</div>
		<!-- // warningBox -->
	</div>
	<!-- // tabContent -->

</div>

<form name="reqPCCForm" id="gForm" method="post" action="" >
	<input type="hidden" id="reqInfo" name="reqInfo" value="${bizSiren.reqInfo }" />
	<!-- 요청정보 -->
	<input type="hidden" id="retUrl" name="retUrl" value="${bizSiren.retUrl }" />
	<!-- 리턴받을URL -->
</form>

<!--아이핀  -->
<form name="ipinForm" id="ipinForm" method="post">
	<input type="hidden" id="reqIpinInfo" name="reqInfo" value="" />
	<!-- 요청정보 -->
	<input type="hidden" id="retIpinUrl" name="retUrl" value="" />
	<!-- 리턴받을URL -->
</form>


