<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	
	$(document).ready(function () {
		$("#li_terms > a").addClass("current");
		$("#li_entryAgree > a").addClass("current");
		var strHtml = "<a href='/terms/memberShipClubTerms'><span>약관</span></a><span class='current'>입점상담 동의사항</span>";
		$("#header_path").append(strHtml);
	});
	
	
</script>



<div class="content">
	<h3>입점상담 동의사항</h3>
	<div class="txtBox nomal">${entryCounselAgree.termsCont }</div>
</div>



