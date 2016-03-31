<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(document).ready(function () {
	$("#li_cs > a").addClass("current");
	$("#li_noticeList > a").addClass("current");
	var strHtml = "<a href='/cs/noticeList'><span>고객센터</span></a><span class='current'>공지사항</span>";
	$("#header_path").append(strHtml);
});

</script>

<!-- 컨텐츠 상세 영역 시작 -->
<div class="content">
	<h3>공지사항</h3>
	
		<div class="boardView">
			<table cellspacing="0"  summary="NO, 제목, 작성자, 작성일자">
				<caption>내용보기</caption>
				<colgroup>
					<col width="70px" />
					<col width="*" />
					<col width="100px" />
					<col width="140px" />
				</colgroup>
				<thead>
					<tr>
						<th>${noticeDetail.ntceNo}</th>
						<th class="taL">${noticeDetail.ntceTitle}</th>
						<th>${noticeDetail.insUser}</th>
						<th>${noticeDetail.insDate}</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="4" class="viewLine">
							<div class="viewDiv">
								${noticeDetail.ntceCont}
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div><!-- // boardView -->

		<div class="btnDiv taC mt30">
			<a href="/cs/noticeList?page=${currentPage}" class="btn blue large"><span>목록</span></a>
		</div>
</div>
<!-- // content :: 컨텐츠 상세 영역 끝 -->