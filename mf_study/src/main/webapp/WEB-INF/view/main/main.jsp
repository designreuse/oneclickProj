<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

$(document).ready(function(){ 
	var swiper = new Swiper('.swiper-container-main', {
		pagination: '.swiper-pagination',
		paginationClickable: true,
		loop: true
	});
	
	if( $(".slideList li").length <= 1 ){
		var swiper = new Swiper('.swiper-container-footer', {
			autoplay: false,
			loop: false
		});
		$(".btn_slide").hide();
	} else {
		var swiper = new Swiper('.swiper-container-footer', {
			//pagination: '.swiper-pagination',
			nextButton: '.swiper-button-next',
			prevButton: '.swiper-button-prev',
			paginationClickable: true,
			spaceBetween: 30,
			centeredSlides: true,
			autoplay: 2500,
			autoplayDisableOnInteraction: false,
			loop: true
		});
	}
});

function viewNoticeDetail(ntceNo, ntceSeq) {
	$("#noticeNo").val(ntceNo);
	$("#noticeSeq").val(ntceSeq);
	$("#currentPage").val("1");
	
	document.noticeForm.submit();
}

</script>

<div class="container main">
	<div class="mainWrap">
			<h2 class="blind">이랜드원클릭 주요서비스</h2>
			
			<div class="swiper-container-main">
				<div class="visualArea swiper-wrapper">
					<div class="swiper-slide">
						<div class="visualBox v1">
							<a href="/introduction/intro">
								<span class="ir_main icon mouse"></span>
								<strong class="title"><span class="t1">이랜드리테일</span><br><span class="t2"><em>원클릭</em>이란?</span></strong>
								<span class="ir_main plus blue"></span>
								<span class="tit"><em><spring:message code="name.elandoneclick" /></em>이란,</span>
								<span class="desc">한 개의 아이디와 패스워드로 이랜드리테일<br />온라인 제휴사이트를 모두 이용하실 수 있는<br />온라인 통합 멤버십입니다.</span>
							</a>
						</div><!-- // visualBox -->
					</div><!-- // swiper-slide :: 이랜드리테일 원클릭이란? -->
					<div class="swiper-slide">
						<div class="visualBox v2">
							<a href="/introduction/membershipInfo">
								<span class="ir_main icon card"></span>
								<strong class="title"><span class="t1">이랜드리테일</span><br><span class="t2"><em>멤버십포인트</em>란?</span></strong>
								<span class="ir_main plus green"></span>
								<span class="tit"><em>이랜드리테일 멤버십포인트</em>란,</span>
								<span class="desc">쇼핑시 적립된 포인트를 <br />현금처럼 사용할 수 있는 이랜드 유통의<br />새로운 통합포인트입니다.</span>
							</a>
						</div><!-- // visualBox -->
					</div><!-- // swiper-slide :: 이랜드리테일 멤버십 포인트란? -->
					<div class="swiper-slide">
						<div class="visualBox v3">
							<a href="/member/joinMember">
								<span class="ir_main icon pen"></span>
								<strong class="title"><span class="t1">이랜드리테일</span><br><span class="t2"><em>간편 회원가입</em>하기</span></strong>
								<span class="ir_main plus yellow"></span>
								<span class="tit"><em>이랜드리테일 원클릭</em>은</span>
								<span class="desc">최소한의 정보 입력과 간편한 가입절차를 통해 <br />쉽고 빠르게 이랜드리테일 서비스를<br />이용하실 수 있습니다.</span>
							</a>
						</div><!-- // visualBox -->
					</div><!-- // swiper-slide :: 이랜드리테일 원클릭 간편회원가입하기  -->
				</div>
				<div class="swiper-pagination"></div>
			</div><!-- // swiper-container -->

		<div class="mainNoticeArea">
			<div class="mainNotice">
				<h3><a href="/cs/noticeList" rel="external"><spring:message code="main.notice" /></a></h3>
				<form action="/cs/noticeDetail" name="noticeForm" id="noticeForm" method="POST">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					<div class="viewDiv ellipsis">
						<a href="javascript:viewNoticeDetail(${mainNotice.ntceNo}, ${mainNotice.ntceSeq});">${mainNotice.ntceTitle}</a>
					</div>
					<input type="hidden" id="noticeNo" name="noticeNo" />
					<input type="hidden" id="noticeSeq" name="noticeSeq" />
					<input type="hidden" id="currentPage" name="currentPage" />
				</form>
			</div>
		</div><!-- // mainNoticeArea-->
	</div><!-- // mainWrap -->
</div>