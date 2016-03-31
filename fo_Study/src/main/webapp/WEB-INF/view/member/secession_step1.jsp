<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

$(document).ready(function () {
	$("#li_member > a").addClass("current");
	$("#li_leaveMember > a").addClass("current");
	var strHtml = "<a href='/member/updateMember'><span>회원정보</span></a><span class='current'>회원탈퇴</span>";
	$("#header_path").append(strHtml);
});

function runMemberOutStep2(outType) {
	if (outType == "familyOut") {
		$("#selectMenu").val("1");
	} else if (outType == "onoffOut") {
		$("#selectMenu").val("2");		
	}
	
	$("#webId").val("${webId}");
	$("#siteCode").val("${siteCode}");
	
	document.membOutForm.submit();
}

</script>

<!-- 컨텐츠 상세 영역 시작 -->
<div class="content">
	<h3>회원탈퇴</h3>

	<p class="taC pageGuide mb30">탈퇴 유형을 선택해 주세요.</p>
	<form action="/member/memberOutStep2" name="membOutForm" id="membOutForm" method="POST">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<div class="certiBox type2">
			<div class="box b1">
				<a href="javascript:runMemberOutStep2('familyOut')" >
					<span class="ir_ico site"></span>
					<strong class="tit">원클릭 온라인 탈퇴</strong>
					<span class="desc t1 mt10">원클릭의 제휴사이트만 탈퇴합니다.</span>
					<span class="desc mt15">탈퇴대상 : 통합몰, 통합홈페이지</span>
				</a>
				<p class="warningBox taL">일부 사이트 탈퇴시, 이랜드 원클릭 회원은 유지되며 계속 <br />서비스를 받으실 수 있습니다.<br />전체 사이트 탈퇴시, 30일간 다시 가입하실 수 없습니다.</p>
			</div><!-- // box :: 원클릭 온라인 탈퇴 -->
			<div class="box b2">
				<a href="javascript:runMemberOutStep2('onoffOut')">
					<span class="ir_ico mem"></span>
					<strong class="tit">원클릭 온/오프라인 탈퇴</strong>
					<span class="desc t1 mt10">온/오프라인 통합탈퇴를 합니다.</span>
					<span class="desc mt15">탈퇴대상 : 통합몰, 통합홈페이지, NC백화점,<br />2001 아울렛, 뉴코아아울렛, 동아백화점 등</span>
				</a>
				<p class="warningBox taL">회원탈퇴를 하시면, 고객님의 포인트가 모두 소멸될 수도<br />있으니 주의하세요.<br />전체 사이트 탈퇴시, 30일간 다시 가입하실 수 없습니다.</p>
			</div><!-- // box :: 원클릭 온/오프라인 탈퇴-->
		</div>
		
		<input type="hidden" id="webId" name="webId" />
		<input type="hidden" id="siteCode" name="siteCode" />
		<input type="hidden" id="selectMenu" name="selectMenu" />
	</form>

</div>
<!-- // content :: 컨텐츠 상세 영역 끝 -->