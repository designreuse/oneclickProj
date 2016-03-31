<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
var currentPage = 0;

$(document).ready(function () {
	$("#li_cs > a").addClass("current");
	$("#li_noticeList > a").addClass("current");
	var strHtml = "<a href='/cs/noticeList'><span>고객센터</span></a><span class='current'>공지사항</span>";
	$("#header_path").append(strHtml);
});

function viewNoticeDetail(ntceNo, ntceSeq) {
	$("#noticeNo").val(ntceNo);
	$("#noticeSeq").val(ntceSeq);
	$("#currentPage").val("${pageParam.currentPage}");
	
	document.noticeForm.submit();
}

</script>

<!-- 컨텐츠 상세 영역 시작 -->
<div class="content">
	<h3>공지사항</h3>

	<form action="/cs/noticeDetail" name="noticeForm" id="noticeForm" method="POST">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<div class="boardList">
			<table cellspacing="0"  summary="NO, 제목, 작성자, 작성일자">
				<caption>목록</caption>
				<colgroup>
					<col width="70px" />
					<col width="*" />
					<col width="100px" />
					<col width="140px" />
				</colgroup>
				<thead>
					<tr>
						<th>NO</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="notice" items="${noticeList}" varStatus="status">
						<tr>
							<td>${notice.ntceNo}</td>
							<td class="subject ellipsis"><a href="javascript:viewNoticeDetail(${notice.ntceNo}, ${notice.ntceSeq});">${notice.ntceTitle}</a></td>
							<td>${notice.insUser}</td>
							<td>${notice.insDate}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div><!-- // boardList -->
		<input type="hidden" id="noticeNo" name="noticeNo" />
		<input type="hidden" id="noticeSeq" name="noticeSeq" />
		<input type="hidden" id="currentPage" name="currentPage" />
	</form>

	<div class="bottomDiv mt30">
		<div class="pagination">
			<c:set var="page" value="${pageParam}" />
			<a href="/cs/noticeList?page=1" class="btn_page btn_first" title="처음으로"><span class="blind">처음으로</span></a>
			<c:choose>
				<c:when test="${false eq page.firstFlag}"><a href="/cs/noticeList?page=${page.currentPage - 1}" class="btn_page btn_prev" title="이전"><span class="blind">이전</span></a></c:when>
				<c:otherwise><a class="btn_page btn_prev" title="이전"><span class="blind">이전</span></a></c:otherwise>
			</c:choose>				
			<c:forEach var="i" begin="${page.displayBeginPage}" end="${page.displayEndPage}" step="1">
      				<c:choose>
          				<c:when test="${i eq page.currentPage}"><a href="#" class="current"><span>${i}</span></a></c:when>
          				<c:otherwise><a href="/cs/noticeList?page=${i}"><span>${i}</span></a></c:otherwise>
      				</c:choose>
  				</c:forEach>
			<c:choose>
				<c:when test="${false eq page.lastFlag}"><a href="/cs/noticeList?page=${page.currentPage + 1}" class="btn_page btn_next" title="다음"><span class="blind">다음</span></a></c:when>
				<c:otherwise><a class="btn_page btn_next" title="다음"><span class="blind">다음</span></a></c:otherwise>
			</c:choose>
			<a href="/cs/noticeList?page=${page.totalPage}" class="btn_page btn_last" title="마지막"><span class="blind">마지막</span></a>
		</div>
	</div><!-- // bottomDiv -->

</div>
<!-- // content :: 컨텐츠 상세 영역 끝 -->