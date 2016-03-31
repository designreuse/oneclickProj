<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(document).ready(function(){ 

});

</script>

<div class="container">
	
	<div class="lineMap">
		<div class="path">
			<span class="home"><a href="/" rel="external">HOME</a></span>
			<span><a href="/terms/memberShipClubTerms" rel="external">약관</a></span>
			<span class="current">영상정보처리기기운영, 관리방침</span>
		</div>
	</div><!-- // lineMap -->
	
	<section class="terms">
		<div class="pageTitle">
			<h2>영상정보처리기기운영, 관리방침</h2>
		</div>

		<nav class="toolbar">
			<ul class="toolList">
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
			</ul>
		</nav><!-- // toolbar -->

		<div class="content termsView">
			<h3>영상정보처리기기운영, 관리방침 약관 세부 내용 </h3>
			<p class="first">㈜이랜드리테일(이하 당사라 함)는 영상정보처리기기 운영, 관리 방침을 통해 당사에서 처리하는 영상정보가 어떠한 용도와 방식으로 이용, 관리되고 있는지 알려드립니다.</p>
			<p class="adden">
				<c:if test="${mediaTerms.pblanDate ne null}">
					<fmt:parseDate var="parseDate" value="${mediaTerms.pblanDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate pattern="yyyy년 MM월 dd일" type="both" value="${parseDate}" var="pblanDate"/>
					공고일자 : ${pblanDate}  
					<c:if test="${mediaTerms.operDate ne null}">
						/
					</c:if>
				</c:if>
				<c:if test="${mediaTerms.operDate ne null}">
					<fmt:parseDate var="parseDate" value="${mediaTerms.operDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate pattern="yyyy년 MM월 dd일" type="both" value="${parseDate}" var="operDate"/>
					시행일자 : ${operDate}
					<c:if test="${mediaTerms.termsUpdDate ne null}">
						/
					</c:if>
				</c:if>
				<c:if test="${mediaTerms.termsUpdDate ne null}">
					<fmt:parseDate var="parseDate" value="${mediaTerms.termsUpdDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate pattern="yyyy년 MM월 dd일" type="both" value="${parseDate}" var="termsUpdDate"/>
					수정일자 : ${termsUpdDate}
				</c:if>	
			</p>			
			${mediaTerms.termsCont}
		</div><!-- // content -->
	</section><!-- // terms -->

</div><!-- // container -->