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
				<span class="current">이랜드리테일 원클릭이란?</span>
			</div>
		</div><!-- // lineMap -->
		
		<div class="pageTitle">
			<h2>이랜드리테일 원클릭이란?</h2>
		</div>
		
		<div class="content inner">

			<h3 class="tit_bl">이랜드리테일 원클릭이란?</h3>
			<p class="pageGuide mt10">이랜드리테일 원클릭(<spring:message code="name.elandoneclick" />)은 한 개의 아이디와 패스워드로 이랜드리테일 온라인 사이트를 모두 이용하실 수 있는 온라인 통합 멤버십입니다.</p>

			<div class="introBox mt15">
				<strong class="tit"><spring:message code="name.elandoneclick" /></strong>
				<div class="eland">
					<ul>
						<li class="e1"><span><spring:message code="name.elandmall" /></span></li>
						<li class="e2"><span><spring:message code="name.elandretail" /></span></li>
					</ul>
				</div>
				<div class="partnerList mt15">
					<ul>
						<li><img src="../../images/img/bnr_partner01.gif" alt="New Core" /></li>
						<li><img src="../../images/img/bnr_partner02.gif" alt="Modern House" /></li>
						<li><img src="../../images/img/bnr_partner03.gif" alt="NC" /></li>
						<li><img src="../../images/img/bnr_partner04.gif" alt="New Core Outlet" /></li>
						<li><img src="../../images/img/bnr_partner05.gif" alt="DONGA" /></li>
						<li><img src="../../images/img/bnr_partner06.gif" alt="2001 Outlet" /></li>
						<li><img src="../../images/img/bnr_partner07.gif" alt="E:LAND RETAIL" /></li>
						<li><img src="../../images/img/bnr_partner08.gif" alt="엔씨 백화점 문화센터" /></li>
						<li><img src="../../images/img/bnr_partner09.gif" alt="Kids Hall" /></li>
						<li><img src="../../images/img/bnr_partner10.gif" alt="뉴코아아울렛 문화센터" /></li>
						<li><img src="../../images/img/bnr_partner11.gif" alt="이천일 아울렛 문화센터" /></li>
						<li><img src="../../images/img/bnr_partner12.gif" alt="동아문화센터" /></li>
						<li><img src="../../images/img/bnr_partner13.gif" alt="New Core 소극장" /></li>
					</ul>
				</div>
			</div><!-- // introBox -->
			<div class="btnDiv mt10">
				<a href="/member/joinMember" class="btn blue large" rel="external"><span>이랜드리테일 원클릭 가입</span></a>
			</div>

		</div><!-- // content -->

	</section>
</div><!-- // container -->
