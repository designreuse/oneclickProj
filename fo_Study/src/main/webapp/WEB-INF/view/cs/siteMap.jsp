<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	$(document).ready(function () {
		$("#li_cs > a").addClass("current");
		$("#leftTitle").text("사이트맵");
		var strHtml = "<span class='current'>사이트맵</span>";
		$("#header_path").append(strHtml);
	});

</script>

<div class="content">
	<h3>이랜드리테일 원클릭 사이트맵</h3>
	<div class="sitemapBnr">
		<strong>E:LAND RETAIL OneClick</strong>
		<p class="txt">원하는 서비스를 빠르고 쉽게 찾아가세요!</p>
	</div><!-- // sitemapBnr -->

	<div class="mapListWrap mt30">
		<div class="mapList m1">
			<h4>이랜드리테일 원클릭 소개</h4>
			<ul>
				<li><a href="/introduction/intro">이랜드리테일 원클릭이란?</a></li>
				<li><a href="/introduction/guide">회원가입/탈퇴안내</a></li>
				<li><a href="/introduction/membershipInfo">이랜드리테일 멤버십 소개</a></li>
			</ul>
		</div><!-- // mapList -->
		<div class="mapList m2">
			<h4>약관</h4>
			<ul>
				<li><a href="/terms/memberShipClubTerms">이랜드리테일 멤버십 이용약관</a></li>
				<li><a href="/terms/onlineServiceTerms">온라인 서비스 이용약관</a></li>
				<li><a href="/terms/privacyTerms">개인정보 취급방침</a></li>
				<li><a href="/terms/mediaTerms">영상정보처리기기운영, 관리방침</a></li>
<!-- 				<li><a href="/terms/customerCounselAgree">고객상담 동의사항</a></li> -->
				<li><a href="/terms/entryCounselAgree">입점상담 동의사항</a></li>
			</ul>
		</div><!-- // mapList -->
		<div class="mapList m3">
			<h4>회원정보</h4>
			<ul>
				<li><a href="/member/updateMember">회원정보 수정</a></li>
				<li><a href="/member/findId">아이디/비밀번호 찾기</a></li>
				<li><a href="/member/joinMember">회원가입</a></li>
				<li><a href="/member/memberOut">회원탈퇴</a></li>
			</ul>
		</div><!-- // mapList -->
		<div class="mapList m4">
			<h4>고객센터</h4>
			<ul>
				<li><a href="/cs/noticeList">공지사항</a></li>
				<li><a href="/cs/faqList">자주묻는 질문</a></li>
			</ul>
		</div><!-- // mapList -->
	</div><!-- // mapListWrap -->

</div>

