<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
$(document).ready(function(){ 

});
</script>

<div class="container">
	<section class="cntDiv">

		<div class="lineMap">
			<div class="path">
				<span class="home"><a href="/" rel="external">HOME</a></span>
				<span><a href="/introduction/intro" rel="external">이랜드리테일 원클릭 소개</a></span>
				<span class="current">회원 가입/탈퇴 안내</span>
			</div>
		</div><!-- // lineMap -->
		
		<div class="pageTitle">
			<h2>회원 가입/탈퇴 안내</h2>
		</div>
		
		<div class="content inner">

			<h3 class="tit_bl">회원 가입 안내</h3>
			<p class="pageGuide mt10">이랜드 온라인 제휴사이트에서 '회원 가입'을 클릭하시면, 간편하게 이랜드 원클릭 가입 신청을 하실 수 있습니다.</p>
			<div class="memStepBox mt15">
				<strong><spring:message code="name.elandmall" /><br /><spring:message code="name.elandretail" /></strong>
				<ol class="t1">
					<li><span>본인확인</span></li>
					<li><span>약관동의</span></li>
					<li><span>정보입력</span></li>
					<li><span>가입완료</span></li>
				</ol>
			</div><!-- // stepBox -->
			<div class="btnDiv mt10">
				<a href="/member/joinMember" class="btn blue large" rel="external"><span>이랜드리테일 원클릭 가입</span></a>
			</div>

			<h3 class="tit_bl mt10">회원 탈퇴 안내</h3>
			<p class="pageGuide mt10">이랜드 온라인 제휴사이트에서 ‘회원 탈퇴’를 클릭하시면, 간편하고 안전하게 이랜드 원클릭 탈퇴 신청을 하실 수 있습니다</p>
			<div class="memStepBox mt15">
				<strong><spring:message code="name.elandmall" /><br /><spring:message code="name.elandretail" /></strong>
				<ol class="t2">
					<li><span>회원탈퇴<br />신청</span></li>
					<li><span>회원탈퇴<br />완료</span></li>
				</ol>
			</div><!-- // stepBox -->
			<p class="mt5 f_noti f_small">탈퇴하지 않은 제휴 사이트는 기존의 아이디와 비밀번호로 동일하게 이용이 가능합니다.</p>

		</div><!-- // content -->

	</section>
</div><!-- // container -->

