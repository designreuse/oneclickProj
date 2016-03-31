<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
var currentPage = 1;

$(document).ready(function () {
	//스크롤 하단 닿을 경우 공지사항 더 가져옴 
	$(window).scroll(function() {
		var winScrollTop = $(window).scrollTop()+1;
		var docHeight = $(document).height();
		var winHeight = $(window).height();
		
		if (winScrollTop == docHeight - winHeight) {
			moreNoticeList(); 
		}
	});
});

function moreNoticeList() {
	currentPage++;
	
	$.ajax({
	    url: '/cs/addNoticeList',
	    type : "GET",
	    data : {'page':currentPage},
		async : false,
		cache : false,
	    success: function(result) {
	    	addNoticeList(result);
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
function addNoticeList(addList) {
	var addHtml = "";

	for (var i=0; i<addList.length; i++) {
		addHtml += '<li>';
		addHtml	+= '	<a href="javascript:viewNoticeDetail('+addList[i].ntceNo+', '+addList[i].ntceSeq+');" class="titDiv">';
		addHtml	+= '		<div class="postInfo"><span class="num">'+addList[i].ntceNo+'</span><span class="date">'+addList[i].insDate+'</span></div>';
		addHtml += '		<em class="subject ellipsis">'+addList[i].ntceTitle+'</em>';
		addHtml += '	</a>';
		addHtml += '</li>';
	}
	
	$(".noticeList").append(addHtml);
}
function viewNoticeDetail(ntceNo, ntceSeq) {
	$("#noticeNo").val(ntceNo);
	$("#noticeSeq").val(ntceSeq);
	
	document.noticeForm.submit();
}

</script>

<div class="container">
	<section class="cntDiv">

		<div class="lineMap">
			<div class="path">
				<span class="home"><a href="/" rel="external">HOME</a></span>
				<span><a href="/cs/noticeList" rel="external">고객센터</a></span>
				<span class="current">공지사항</span>
			</div>
		</div><!-- // lineMap -->

		<div class="pageTitle">
			<h2>공지사항</h2>
		</div>

		<div class="content">
			<form action="/cs/noticeDetail" name="noticeForm" id="noticeForm" method="POST">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<ul class="noticeList">
					<c:forEach var="notice" items="${noticeList}" varStatus="status">
						<li>
							<a href="javascript:viewNoticeDetail(${notice.ntceNo}, ${notice.ntceSeq});" class="titDiv">
								<div class="postInfo"><span class="num">${notice.ntceNo}</span><span class="date">${notice.insDate}</span></div>
								<em class="subject ellipsis">${notice.ntceTitle}</em>
							</a>
						</li>
					</c:forEach>
				</ul><!-- // noticeList -->
				<input type="hidden" id="noticeNo" name="noticeNo" />
				<input type="hidden" id="noticeSeq" name="noticeSeq" />
			</form>
		</div><!-- // content -->

	</section>
</div><!-- // container -->
