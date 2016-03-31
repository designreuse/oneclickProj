<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

$(document).ready(function () {
	$("#li_introduction > a").addClass("current");
	$("#li_intro > a").addClass("current");
	var strHtml = "<a href='/introduction/intro'><span>이랜드리테일 원클릭 소개</span></a><span class='current'>이랜드리테일 원클릭이란?</span>";
	$("#header_path").append(strHtml);
});

</script>

<!-- 컨텐츠 상세 영역 시작 -->
<div class="content">
	<h3>이랜드리테일 원클릭이란?</h3>
		<strong class="tit_bl">'이랜드리테일 원클릭'이란?</strong>
		<p class="taC pageGuide mt35"><strong class="f_point">이랜드리테일 원클릭</strong>(<strong class="f_point f_en"><spring:message code="name.elandoneclick" /></strong>)은 한 개의 아이디와 패스워드로<br />이랜드리테일 온라인 사이트를 모두 이용하실 수 있는 <strong class="f_point">온라인 통합 멤버십</strong>입니다.</p>
		
		<div class="introBox">
			<strong class="tit"><spring:message code="name.elandoneclick" /></strong>
			<ul class="eland">
				<li class="e1"><spring:message code="name.elandmall" /></li>
				<li class="e2"><spring:message code="name.elandretail" /></li>
			</ul>
			<div class="partnerList mt30">
				<ul>
					<li><img src="../../img/images/bnr_partner01.gif" alt="New Core" /></li>
					<li><img src="../../img/images/bnr_partner02.gif" alt="Modern House" /></li>
					<li><img src="../../img/images/bnr_partner03.gif" alt="NC" /></li>
					<li><img src="../../img/images/bnr_partner04.gif" alt="New Core Outlet" /></li>
					<li><img src="../../img/images/bnr_partner05.gif" alt="DONGA" /></li>
					<li><img src="../../img/images/bnr_partner06.gif" alt="2001 Outlet" /></li>
					<li><img src="../../img/images/bnr_partner07.gif" alt="E:LAND RETAIL" /></li>
					<li><img src="../../img/images/bnr_partner08.gif" alt="엔씨 백화점 문화센터" /></li>
					<li><img src="../../img/images/bnr_partner09.gif" alt="Kids Hall" /></li>
					<li><img src="../../img/images/bnr_partner10.gif" alt="뉴코아아울렛 문화센터" /></li>
					<li><img src="../../img/images/bnr_partner11.gif" alt="이천일 아울렛 문화센터" /></li>
					<li><img src="../../img/images/bnr_partner12.gif" alt="동아문화센터" /></li>
					<li><img src="../../img/images/bnr_partner13.gif" alt="New Core 소극장" /></li>
				</ul>
			</div>
		</div><!-- // introBox -->
		<div class="btnDiv taC mt30">
			<a href="/member/joinMember" class="btn blue large"><span>이랜드리테일 원클릭 가입</span></a>
		</div>

</div>
<!-- // content :: 컨텐츠 상세 영역 끝 -->