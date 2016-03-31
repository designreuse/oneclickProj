<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">

$(document).ready(function () {
	$("#li_cs > a").addClass("current");
	$("#li_faqList > a").addClass("current");
	var strHtml = "<a href='/cs/noticeList'><span>고객센터</span></a><span class='current'>자주묻는 질문</span>";
	$("#header_path").append(strHtml);
});

$(window).load(function() {
	// faq
	$(".answer").hide();

	$(".faqList .quest").children("a").click(function() {
		var $obj = $(this).parents().next(".answer");

		$(this).parent().parent().parent().toggleClass("current");
		$(this).parent().parent().next(".answer").slideToggle("200");
		$(this).parent().parent().parent().siblings("li").removeClass("current");

		$(".answer").not($obj).each(function(i){
			$(this).slideUp("200");
		});
		return false;
	});

	
	// tab
	$(".tabContent").hide(); 

	$(".tabCntWrap").each(function() {
		$(this).find(".tabContent:first").show();
	});

	$(".tabMenu a").click(function() {
		if (!$(this).hasClass("on")) {
			$(this).addClass("on").parent().parent("li").siblings("li").find("a.on").removeClass("on");
			$($(this).attr("href")).show().siblings(".tabContent").hide();
		}
		return false;
	});
});

</script>


<!-- 컨텐츠 상세 영역 시작 -->
<div class="content">
	<h3>자주묻는 질문</h3>
	<h4 class="tit_bl">자주묻는 질문 TOP5</h4>
	<div class="faqList mt10" id="faq01">
		<ul>
			<c:forEach var="faq" items="${faqTop5}" varStatus="status">
				<li>
					<div class="question">
						<span class="cls">${faq.ctgrName}</span>
						<div class="quest"><a href="#">${faq.faqTitle}</a></div>
					</div><!-- // question :: 질문 -->
					<div class="answer ">
						${faq.faqCont}
					</div><!-- // answer :: 답변 -->
				</li>		
			</c:forEach>
		</ul>
	</div><!-- // faqList :: 자주묻는 질문 TOP5 -->
	
	<h4 class="blind">분류별 자주묻는 질문</h4>
	<div class="tabMenu mt50">
		<ul>
			<c:forEach var="category" items="${categories}" varStatus="status">
				<c:choose>
					<c:when test="${currentCategory eq category.code}">
						<li><h5><a href="/cs/faqList?category=${category.code}&page=1" title="${category.codeName}" class="on">${category.codeName}</a></h5></li>
					</c:when>
           			<c:otherwise>
           				<li><h5><a href="/cs/faqList?category=${category.code}&page=1" title="${category.codeName}">${category.codeName}</a></h5></li>
           			</c:otherwise>
				</c:choose>
			</c:forEach>		
		</ul>
	</div><!-- // tabMenu -->

	<div class="tabCntWrap">
		<div class="tabContent" id="all">
			<div class="faqList noLine">
				<ul>
					<c:forEach var="faq" items="${faqList}" varStatus="status">
						<li>
							<div class="question">
								<span class="cls">${faq.ctgrName}</span>
								<div class="quest"><a href="#">${faq.faqTitle}</a></div>
							</div><!-- // question :: 질문 -->
							<div class="answer">
								${faq.faqCont}
							</div><!-- // answer :: 답변 -->
						</li>
					</c:forEach>
				</ul>
			</div><!-- // faqList -->
		</div><!-- // tabContent :: 전체보기 -->
		
		<div class="bottomDiv mt30">
			<div class="pagination">
				<fmt:parseNumber var="pageCount" integerOnly="true" value="${pageParam.size()}" />
				
				<c:set var="page" value="${pageParam}" />
				<a href="/cs/faqList?page=1" class="btn_page btn_first" title="처음으로"><span class="blind">처음으로</span></a>
				<c:choose>
					<c:when test="${false eq page.firstFlag}"><a href="/cs/faqList?page=${page.currentPage - 1}" class="btn_page btn_prev" title="이전"><span class="blind">이전</span></a></c:when>
					<c:otherwise><a class="btn_page btn_prev" title="이전"><span class="blind">이전</span></a></c:otherwise>
				</c:choose>				
				<c:forEach var="i" begin="${page.displayBeginPage}" end="${page.displayEndPage}" step="1">
       				<c:choose>
           				<c:when test="${i eq page.currentPage}"><a href="#" class="current"><span>${i}</span></a></c:when>
           				<c:otherwise><a href="/cs/faqList?page=${i}"><span>${i}</span></a></c:otherwise>
       				</c:choose>
   				</c:forEach>
				<c:choose>
					<c:when test="${false eq page.lastFlag}"><a href="/cs/faqList?page=${page.currentPage + 1}" class="btn_page btn_next" title="다음"><span class="blind">다음</span></a></c:when>
					<c:otherwise><a class="btn_page btn_next" title="다음"><span class="blind">다음</span></a></c:otherwise>
				</c:choose>
				<a href="/cs/faqList?page=${page.totalPage}" class="btn_page btn_last" title="마지막"><span class="blind">마지막</span></a>
			</div>
		</div><!-- // bottomDiv -->

	</div><!-- // tabCntWrap -->

</div>
<!-- // content :: 컨텐츠 상세 영역 끝 -->