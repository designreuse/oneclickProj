<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

$(document).ready(function () {
	$("#li_introduction > a").addClass("current");
	$("#li_guide > a").addClass("current");
	var strHtml = "<a href='/introduction/intro'><span>이랜드리테일 원클릭 소개</span></a><span class='current'>회원가입/탈퇴안내</span>";
	$("#header_path").append(strHtml);
});

</script>

<!-- 컨텐츠 상세 영역 시작 -->
<div class="content">
	<h3>회원가입/탈퇴안내</h3>

	<h4 class="tit_bl">회원 가입 안내</h4>
	<p class="taC pageGuide mt35">이랜드 온라인 제휴사이트에서 ‘<strong class="f_point">회원 가입</strong>’을 클릭하시면,<br />간편하게 이랜드리테일 원클릭 가입 신청을 하실 수 있습니다.</p>
	<div class="memStepBox p1 mt35">
		<strong><spring:message code="name.elandmall" /><br /><spring:message code="name.elandretail" /></strong>
		<ol class="t1">
			<li><span>본인확인</span></li>
			<li><span>약관동의</span></li>
			<li><span>정보입력</span></li>
			<li><span>가입완료</span></li>
		</ol>
	</div><!-- // stepBox -->
	<div class="btnDiv taC mt30">
		<a href="/member/joinMember" class="btn blue large"><span>이랜드리테일 원클릭 가입</span></a>
	</div>

	<h4 class="tit_bl mt30">회원 탈퇴 안내</h4>
	<p class="taC pageGuide mt35">이랜드 온라인 제휴사이트에서 ‘<strong class="f_point">회원 탈퇴</strong>’를 클릭하시면,<br />간편하게 이랜드리테일 원클릭 탈퇴 신청을 하실 수 있습니다.</p>
	<div class="memStepBox p2 mt35">
		<strong><spring:message code="name.elandmall" /><br /><spring:message code="name.elandretail" /></strong>
		<ol class="t2">
			<li><span>회원탈퇴<br />신청</span></li>
			<li><span>회원탈퇴<br />완료</span></li>
		</ol>
	</div><!-- // stepBox -->
	<p class="taC mt10 f_noti">탈퇴하지 않은 제휴 사이트는 기존의 아이디와 비밀번호로 동일하게 이용이 가능합니다.</p>

</div>
<!-- // content :: 컨텐츠 상세 영역 끝 -->