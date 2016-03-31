<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	
	$(document).ready(function () {
		$("#li_terms > a").addClass("current");
		$("#li_privacy > a").addClass("current");
		var strHtml = "<a href='/terms/memberShipClubTerms'><span>약관</span></a><span class='current'>개인정보 취급방침</span>";
		$("#header_path").append(strHtml);

		var termsSeq = "${termsSeq}";
		
		if (termsSeq != "") {
			$("#select_terms").val(termsSeq).attr("selected", "selected");
			$("#select_label").text($("#select_terms option:selected").text());
		}
		
	});
	
		function preTerms(selectObj) {
			location.href="/terms/privacyTerms?termsSeq="+selectObj.value;
		}
	
</script>



<div class="content">
	<h3>개인정보 취급방침</h3>
	<p class="first">㈜ 이랜드리테일(이하 회사)는 이랜드클럽 회원의 개인정보를 매우 중요하게 생각하며,
		회원께서 제공하는 모든 개인정보를 철저히 보호하기 위해서 “정보통신망이용촉진 및 정보보호 등에 관한 법률”과 '개인정보보호법'
		시행에 따라 규정을 준수하며, 관련 법령에 의거한 개인정보취급방침을 정하여 고객의 권익 보호에 최선을 다하고 있습니다.
		회원께서 제공하신 개인정보가 어떠한 용도와 방식으로 이용되고 있고, 개인정보 보호를 위하여 어떤 조치가 취해지고 있는지
		뉴코아아울렛, 이천일아울렛, NC백화점, 동아백화점 웹 사이트나 전국 뉴코아아울렛, 이천일아울렛, NC백화점, 동아백화점
		지점을 통해 공지되오니 수시로 확인해 주시기 바랍니다.</p>

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
	
	<div class="txtBox mt30">${privacyTerms.termsCont }</div>

	<div class="adden mt10">
		
		<p class="fl">
			<c:if test="${privacyTerms.pblanDate ne null}">
				<fmt:parseDate var="parseDate" value="${privacyTerms.pblanDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate pattern="yyyy년 MM월 dd일" type="both" value="${parseDate}" var="pblanDate"/>
				공고일자 : ${pblanDate}  
				<c:if test="${privacyTerms.operDate ne null}">
					/
				</c:if>
			</c:if>
			<c:if test="${privacyTerms.operDate ne null}">
				<fmt:parseDate var="parseDate" value="${privacyTerms.operDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate pattern="yyyy년 MM월 dd일" type="both" value="${parseDate}" var="operDate"/>
				시행일자 : ${operDate}
				<c:if test="${privacyTerms.termsUpdDate ne null}">
					/
				</c:if>
			</c:if>
			<c:if test="${privacyTerms.termsUpdDate ne null}">
				<fmt:parseDate var="parseDate" value="${privacyTerms.termsUpdDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
				<fmt:formatDate pattern="yyyy년 MM월 dd일" type="both" value="${parseDate}" var="termsUpdDate"/>
				수정일자 : ${termsUpdDate}
			</c:if>
		</p>
		<div class="selectBox fr">
			<label for="select_terms" id="select_label">이전약관보기</label> 
			<select class="select" id="select_terms" onChange="javascript:preTerms(this)">
				<c:forEach items="${prePrivacyTerms}" var="preTerms">
					<fmt:parseDate var="parseDate" value="${preTerms.operDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate pattern="yyyy년 MM월 dd일" type="both" value="${parseDate}" var="operDate"/>
					<option value="${preTerms.termsSeq}">${operDate} 약관 보기</option>
				</c:forEach>
			</select>
		</div>
	</div>
	<!-- // adden -->

</div>



