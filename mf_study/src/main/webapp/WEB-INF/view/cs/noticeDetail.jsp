<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(document).ready(function () {

});

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

		<div class="content">

			<div class="noticeView">
				<div class="titDiv">
					<div class="postInfo"><span class="num">${noticeDetail.ntceNo}</span><span class="date">${noticeDetail.insDate}</span></div>
					<em class="subject ellipsis f_point">${noticeDetail.ntceTitle}</em>
				</div><!-- // titDiv -->
				<div class="viewArea">
					${noticeDetail.ntceCont}
				</div><!-- // viewArea -->
			</div><!-- // noticeView -->

			<div class="btnDiv taC inner mt10">
				<a href="/cs/noticeList" class="btn blue large"><span>목록</span></a>
			</div>

		</div><!-- // content -->

	</section>
</div><!-- // container -->
