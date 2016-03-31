<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(document).ready(function(){ 

});

function getPreMembershipTerms(termsSeq) {
	$.ajax({
	    url: '/terms/getPreMembershipTerms',
	    type : "GET",
	    data : {'termsSeq': termsSeq},
		async : false,
		cache : false,
	    success: function(result) {
	    	viewTermsTitList(result["termsDetailTitList"]);
	    	viewPreTerms(result["terms"]);
	    },
	    error: function(e) {
	    	alert(e.responseText);	
	    },
	    beforeSend: function() {
	    	$.mobile.loading("show");
	    },
	    complete: function() { 
	    	$.mobile.loading("hide");
	    }
	});
}

function viewTermsTitList(termsDetailTitList) {
	var termsTitHtml = "";
	
	if (termsDetailTitList != "") {
		for (var i=0; i<termsDetailTitList.length; i++) {
			if (i < 10) {
				termsTitHtml += '<li>';
				termsTitHtml += '	<a href="#t0'+(i+1)+'" rel="external">';
				termsTitHtml += '		<span class="num">제 '+(i+1)+'조</span>';
				termsTitHtml += '		<span class="txt">'+termsDetailTitList[i]+'</span>';
				termsTitHtml += '	</a>';
				termsTitHtml += '</li>'
			} else {
				termsTitHtml += '<li>';
				termsTitHtml += '	<a href="#t'+(i+1)+'" rel="external">';
				termsTitHtml += '		<span class="num">제 '+(i+1)+'조</span>';
				termsTitHtml += '		<span class="txt">'+termsDetailTitList[i]+'</span>';
				termsTitHtml += '	</a>';
				termsTitHtml += '</li>'
			}
		}
	}
	
	$("#termList1").children().children().remove();
	$("#termList1").children().append(termsTitHtml);
	
}

function viewPreTerms(terms) {
	var termsViewHtml = "";
	
	if (terms != null && terms != "") {
		var operDate = "";
		var pblanDate = "";
		var termsUpdDate = "";
		
		termsViewHtml += '<h3>이랜드클럽 멤버십 (E-land Club Membership) 약관 세부 내용</h3>';
		termsViewHtml += '<p class="adden">';
		
		if (terms.pblanDate != "" && terms.pblanDate != null) {
			pblanDate = (terms.pblanDate).substring(0,4)+'년 '+ (terms.pblanDate).substring(5,7)+'월 '+ (terms.pblanDate).substring(8,10)+'일';
			termsViewHtml += "공고 일자 : " + pblanDate;
			if (terms.operDate != "" && terms.operDate != null) {
				termsViewHtml += " / ";	
			}
		}
		if (terms.operDate != "" && terms.operDate != null) {
			operDate = (terms.operDate).substring(0,4)+'년 '+(terms.operDate).substring(5,7)+'월 '+(terms.operDate).substring(8,10)+'일';
			termsViewHtml += "시행 일자 : " + operDate; 
			if (terms.termsUpdDate != "" && terms.termsUpdDate != null) {
				termsViewHtml += " / ";	
			}
		}
		if (terms.termsUpdDate != "" && terms.termsUpdDate != null) {
			termsUpdDate = (terms.termsUpdDate).substring(0,4)+'년 '+(terms.termsUpdDate).substring(5,7)+'월 '+(terms.termsUpdDate).substring(8,10)+'일';
			termsViewHtml += "수정 일자 : " + termsUpdDate; 
		}
		termsViewHtml += '</p>';
		
	} else {
		termsViewHtml += '<h3>이랜드클럽 멤버십 (E-land Club Membership) 약관 세부 내용</h3>';
		termsViewHtml += '<p class="adden"></p>';
		termsContent = "";
	}
		
	$(".termsView").children().remove();
	$(".termsView").append(termsViewHtml);
	$(".termsView").append(terms.termsCont);
	
	$('html,body').animate({scrollTop:0}, 500);
	
	$("#termList1 .termsList li").children("a").click(function(event){
		event.preventDefault();
		$('html,body').animate({scrollTop:$(this.hash).offset().top - 50}, 500);
	});
}
</script>

<div class="container">
	<div class="lineMap">
		<div class="path">
			<span class="home"><a href="/" rel="external">HOME</a></span>
			<span><a href="/terms/memberShipClubTerms" rel="external">약관</a></span>
			<span class="current">이랜드 멤버십 클럽 이용약관</span>
		</div>
	</div><!-- // lineMap -->
	
	<section class="terms">
		<div class="pageTitle">
			<h2>이랜드 멤버십 클럽 이용약관</h2>
		</div>

		<nav class="toolbar">
			<ul class="toolList two">
				<li>
					<a href="#termList1" class="link_tab" rel="external">목록보기</a>
					<div class="list" id="termList1">
						<ul class="termsList">
							<c:forEach var="titleList" items="${termsDetailTitList}" varStatus="i">
								<li>
									<c:if test="${i.index + 1< 10}">
										<a href="#t0${i.index + 1}" rel="external">
											<span class="num">제 ${i.index + 1}조</span>
											<span class="txt">${titleList}</span>
										</a>
									</c:if>
									<c:if test="${i.index + 1 >= 10}">
										<a href="#t${i.index + 1}" rel="external">
											<span class="num">제 ${i.index + 1}조</span>
											<span class="txt">${titleList}</span>
										</a>
									</c:if>										
								</li>
							</c:forEach>
						</ul>
					</div><!-- // list -->
				</li>
				<li>
					<a href="#termList2" class="link_tab" rel="external">이전 약관보기</a>
					<div class="list" id="termList2">
						<ul class="termsList">
							<c:forEach items="${preMemberShipClubTerms}" var="preTerms">
								<fmt:parseDate var="parseDate" value="${preTerms.operDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
								<fmt:formatDate pattern="yyyy년 MM월 dd일" type="both" value="${parseDate}" var="operDate"/>
								<li><a href="javascript:getPreMembershipTerms(${preTerms.termsSeq});" rel="external"><span class="num">v ${preTerms.termsVer}</span><span class="txt">${operDate}</span></a></li>
							</c:forEach>
						</ul>
					</div><!-- // list -->
				</li>
			</ul>
		</nav><!-- // toolbar -->

		<div class="content termsView">		
			<h3>이랜드클럽 멤버십 (E-land Club Membership) 약관 세부 내용</h3>
			<p class="adden">
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
					<c:if test="${termsUpdDate ne null}">
						/
					</c:if>
				</c:if>
				<c:if test="${memberShipClubTerms.termsUpdDate ne null}">
					<fmt:parseDate var="parseDate" value="${memberShipClubTerms.termsUpdDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate pattern="yyyy년 MM월 dd일" type="both" value="${parseDate}" var="termsUpdDate"/>
					수정일자 : ${termsUpdDate}
				</c:if>
			</p>
			${memberShipClubTerms.termsCont}
		</div><!-- // content -->
	</section><!-- // terms -->

</div><!-- // container -->
