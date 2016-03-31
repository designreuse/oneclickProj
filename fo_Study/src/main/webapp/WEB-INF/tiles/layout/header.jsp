<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="header">
	<div class="topHead">
		<h1><a href="/"><spring:message code="name.elandoneclick" /></a></h1>
		<div class="gnb">
			<ul class="gnbList">
				<li id="li_introduction"><a href="/introduction/intro"><spring:message code="header.menu.introduction" /></a></li>
				<li id="li_terms"><a href="/terms/memberShipClubTerms"><spring:message code="header.menu.policy" /></a></li>
				<li id="li_member"><a href="/member/updateMember"><spring:message code="header.menu.memberinfo" /></a></li>
				<li id="li_cs"><a href="/cs/noticeList"><spring:message code="header.menu.customercenter" /></a></li>
			</ul>
		</div><!-- gnb -->
	</div><!-- // topHead -->
</div><!-- // header -->