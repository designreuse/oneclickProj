<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	
	$(document).ready(function () {
		$("#li_terms > a").addClass("current");
		$("#li_memberTerms > a").addClass("current");
		var strHtml = "<a href='/terms/memberShipClubTerms'><span>약관</span></a><span class='current'>이랜드리테일 멤버십 이용약관</span>";
		$("#header_path").append(strHtml);
		
		var termsSeq = "${termsSeq}";

		if (termsSeq != "") {
			$("#select_terms").val(termsSeq).attr("selected", "selected");
			$("#select_label").text($("#select_terms option:selected").text());
		}
	});
	
	
	function preTerms(selectObj) {
		location.href="/terms/memberShipClubTerms?termsSeq="+selectObj.value;
	}
	
</script>

<div class="content">
	<h3>이랜드리테일 멤버십 이용약관</h3>
	<strong class="tit_bl">이랜드리테일 멤버십 (E:land RETAIL Membership) 약관 세부 내용</strong>
	<div class="titGroup mt10">
	
		
		<fmt:parseNumber var="liCount" integerOnly= "true" value="${termsDetailTitList.size() / 3 + 1}" />
		
		<c:set var="tempCount" value="1"/>
		<c:forEach var="titleList" items="${termsDetailTitList}" varStatus="i">
			<c:if test="${i.first}">
				<ul class="list${tempCount}">
				<c:set var="tempCount" value="${tempCount + 1}"/>	
			</c:if>
			
			<li><span>제 ${i.index + 1}조</span>
				<c:if test="${i.index + 1< 10}">
					<a href="#t0${i.index + 1}">${titleList}</a>
				</c:if>
				<c:if test="${i.index + 1 >= 10}">
					<a href="#t${i.index + 1}">${titleList}</a>
				</c:if>
			</li>
			<c:if test="${(i.index + 1) % liCount eq 0 && tempCount ne 4}">
				</ul>
				<c:if test="${not i.last }">
					<ul class="list${tempCount}">
					<c:set var="tempCount" value="${tempCount + 1}"/>
				</c:if>	
			</c:if>
			<c:if test="${i.last }">
				</ul>
			</c:if>
		
		</c:forEach>
	</div>
	<!-- // titGroup -->

	<div class="txtBox mt30">
		${memberShipClubTerms.termsCont }
	</div>
	<!-- // txtBox -->

	<div class="adden mt10">
		<p class="fl">
			<c:if test="${memberShipClubTerms.pblanDate ne null}">
				<fmt:parseDate var="parseDate" value="${memberShipClubTerms.pblanDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate pattern="yyyy년 MM월 dd일" type="both" value="${parseDate}" var="pblanDate"/>
				공고일자 : ${pblanDate}  
				<c:if test="${memberShipClubTerms.operDate ne null}">
					/
				</c:if>
			</c:if>
			<c:if test="${memberShipClubTerms.operDate ne null}">
				<fmt:parseDate var="parseDate" value="${memberShipClubTerms.operDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate pattern="yyyy년 MM월 dd일" type="both" value="${parseDate}" var="operDate"/>
				시행일자 : ${operDate}
				<c:if test="${memberShipClubTerms.termsUpdDate ne null}">
					/
				</c:if>
			</c:if>
			<c:if test="${memberShipClubTerms.termsUpdDate ne null}">
				<fmt:parseDate var="parseDate" value="${memberShipClubTerms.termsUpdDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate pattern="yyyy년 MM월 dd일" type="both" value="${parseDate}" var="termsUpdDate"/>
				수정일자 : ${termsUpdDate}
			</c:if>
		 </p>
		<div class="selectBox fr">
			<label for="select_terms" id="select_label">이전약관보기</label> 
			<select class="select" id="select_terms" onChange="javascript:preTerms(this)">
				<c:forEach items="${preMemberShipClubTerms}" var="preTerms">
					<fmt:parseDate var="parseDate" value="${preTerms.operDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate pattern="yyyy년 MM월 dd일" type="both" value="${parseDate}" var="operDate"/>
					<option value="${preTerms.termsSeq}">${operDate} 약관 보기</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<!-- // adden -->

</div>



