<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
var currentPage = 1;

var faqCount = 0;
var addFaqCount = 0;

var preCategory;
var currentCategory;

$(document).ready(function() {
	//스크롤 하단 닿을 경우 공지사항 더 가져옴 
	$(window).scroll(function() {
		var winScrollTop = $(window).scrollTop()+1;
		var docHeight = $(document).height();
		var winHeight = $(window).height();
		
		if (winScrollTop == docHeight - winHeight) {
			moreFaqList(currentCategory); 
		}
	});
});

$(document).on("pageinit", "#dvwrap", function(event) {
	// faq
	$(".answer").hide();

	$(".faqList .question").children("a").click(function() {
		var $obj = $(this).parents().next(".answer");

		$(this).parent().parent().toggleClass("current");
		$(this).parent().next(".answer").slideToggle("fast");
		//$(this).parent().parent().parent().siblings("li").removeClass("current");

		$(".answer").not($obj).each(function(i){
			$(this).slideUp("fast").parent("li").removeClass("current");
		});
		//return false;
	});
});

function answerToggle() {
	// faq
	$(".answer").hide();
	
	$(".faqList .question").children("a").unbind("click");
	$(".faqList .question").children("a").click(function() {
		var $obj = $(this).parents().next(".answer");

		$(this).parent().parent().toggleClass("current");
		$(this).parent().next(".answer").slideToggle("fast");
		//$(this).parent().parent().parent().siblings("li").removeClass("current");

		$(".answer").not($obj).each(function(i){
			$(this).slideUp("fast").parent("li").removeClass("current");
		});
		//return false;
	});
}

function getFaqListForCategory(resetYn, ctgrCode, currentPage, ctgrName) {
	addFaqCount = 0;
	
	$.ajax({
	    url: '/cs/faqListForCategory',
	    type : "GET",
	    data : {'ctgrCode': ctgrCode, 'page': currentPage},
		async : false,
		cache : false,
	    success: function(result) {
	    	currentCategory = ctgrCode;
	    	faqCount = result["faqCount"];
	    	
	    	if (ctgrName != null && ctgrName != "") {
	    		$(".pageTitle > h2").text(ctgrName);
	    	}
	   			
	    	addContents(resetYn, result);
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

function faqListReset() {
	$(".faqList").children().remove();
}

function addContents(resetYn, resultMap) {
	// faqList 초기화
	if (resetYn) {
		faqListReset();
	}
	
	var addHtml = "";
	
	var faqList = resultMap["faqList"];
	for(var i=0; i<faqList.length; i++) {
		addHtml += '<li>';
		addHtml += '	<div class="question">';
		addHtml += '		<a href="#">';
		addHtml += '			<span class="cls">'+faqList[i].ctgrName+'</span>';
		addHtml += '			<em class="subject"><span class="ico_faq qu">Question</span>'+faqList[i].faqTitle+'</em>';
		addHtml += '		</a>';
		addHtml += '	</div>';
		addHtml += '	<div class="answer">';
		addHtml += '		<span class="ico_faq an">Answer</span>';
		addHtml += '		<div class="txt">'+faqList[i].faqCont+'</div>';
		addHtml += '	</div>';
		addHtml += '</li>';	
	}
	$(".faqList").append(addHtml);
	answerToggle();
	
	addFaqCount += faqList.length;
}

function moreFaqList(ctgrCode) {
	if (faqCount > addFaqCount) {
		if (preCategory != null && preCategory != "") {
			if (currentCategory != preCategory) {
				currentPage = 1;
			} else {
				currentPage++;
			}
		} else {
			currentPage++;
		}
		
		getFaqListForCategory(false, ctgrCode, currentPage, "");
	} else {
		currentPage = 1;
	}
}


</script>

<div class="container">
	<section class="cntDiv">

		<div class="lineMap">
			<div class="path">
				<span class="home"><a href="/" rel="external">HOME</a></span>
				<span><a href="/cs/noticeList" rel="external">고객센터</a></span>
				<span class="current">자주묻는 질문</span>
			</div>
		</div><!-- // lineMap -->
		
		<div class="pageTitle">
			<h2>자주묻는 질문</h2>
		</div>
		
		<nav class="toolbar">
			<ul class="toolList one">
				<li>
					<a href="#termList1" class="link_tab">자주묻는 질문 TOP5</a>
					<div class="list" id="faqTermList">
						<ul>					
							<li><a href="/cs/faqList" rel="external">자주묻는 질문 TOP5</a></li><!-- data-ajax="false" -->
							<c:forEach var="category" items="${categories}" varStatus="status">
								<li><a href='javascript:getFaqListForCategory(true, "${category.code}", "1", "${category.codeName}");' 
										rel="external">${category.codeName}</a></li>
							</c:forEach>
						</ul>
					</div><!-- // list -->
				</li>
			</ul>
		</nav><!-- // toolbar :: 자주묻는 질문 TOP5 -->

		<div class="content">

			<ul class="faqList">
				<c:forEach var="faq" items="${faqTop5}" varStatus="status">
					<li>
						<div class="question">
							<a href="#">
								<span class="cls">${faq.ctgrName}</span>
								<em class="subject"><span class="ico_faq qu">Question</span>${faq.faqTitle}</em>
							</a>
						</div><!-- // question :: 질문 -->
						<div class="answer">
							<span class="ico_faq an">Answer</span>
							<div class="txt">
								${faq.faqCont}
							</div>
						</div>
					</li>
				</c:forEach>
			</ul><!-- // faqList -->

		</div><!-- // content -->

	</section>
</div><!-- // container -->
