<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(document).ready(function () {

});

</script>

<!-- 사이트맵 시작 -->
<div class="container">
	<section class="cntDiv">

		<div class="lineMap">
			<div class="path">
				<span class="home"><a href="/" rel="external">HOME</a></span>
				<span>고객센터</span>
				<span class="current">사이트맵</span>
			</div>
		</div><!-- // lineMap -->

		<div class="pageTitle">
			<h2>사이트맵</h2>
		</div>

		<div class="content inner">
				<div class="mapList">
					<h3>이랜드리테일 원클릭 소개</h3>
					<ul>
						<li><a href="/introduction/intro">이랜드리테일 원클릭이란?</a></li>
						<li><a href="/introduction/guide">회원 가입/탈퇴 안내</a></li>
						<li><a href="/introduction/membership">이랜드리테일 멤버십 소개</a></li>
					</ul>
				</div><!-- // mapList :: 이랜드리테일 원클릭 소개 -->

				<div class="mapList">
					<h3>약관</h3>
					<ul>
						<li><a href="/terms/memberShipClubTerms">이랜드리테일 멤버십 이용약관</a></li>
						<li><a href="/terms/onlineServiceTerms">온라인 서비스 이용약관</a></li>
						<li><a href="/terms/privacyTerms">개인정보 취급방침</a></li>
						<li><a href="/terms/mediaTerms">영상정보처리기기운영, 관리방침</a></li>
						<li><a href="/terms/entryCounselAgree">입점상담 동의사항</a></li>
					</ul>
				</div><!-- // mapList :: 약관 -->

				<div class="mapList">
					<h3>회원정보</h3>
					<ul>
						<li><a href="/member/updateMember">회원정보 수정</a></li>
						<li><a href="/member/findId">아이디/비밀번호 찾기</a></li>
						<li><a href="/member/joinMember">회원가입</a></li>				
						<li><a href="/member/memberOut">회원탈퇴</a></li>
					</ul>
				</div><!-- // mapList :: 회원정보 -->

				<div class="mapList">
					<h3>고객센터</h3>
					<ul>
						<li><a href="/cs/noticeList">공지사항</a></li>
						<li><a href="/cs/faqList">자주묻는 질문</a></li>
					</ul>
				</div><!-- // mapList :: 고객센터 -->

			</div><!-- // content -->


	</section>
</div><!-- // container -->
