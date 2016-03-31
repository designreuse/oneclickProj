<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>   

<script>
	$(document).ready(function () {
		// 제휴사 슬라이드 배너
		if( $(".slideList li").length <= 2 ){
			fn_rollToEx('slider', 'banner', 'control', 0, false);
			$(".btn_slide").hide();
		} else {
			fn_rollToEx('slider', 'banner', 'control', 2, true);
		}
	});
</script>    
    
<div id="footer">
	<div class="bnrArea">
		<div class="familySite">
			<strong>E:LAND FAMILY SITE</strong>
			<div class="slideBnr" id="slider">
				<button type="button" class="btn_slide prev" id="prev2">
					<span class="blind">이전</span>
				</button>
				
				<div class="slideWrap">
						<ul class="slideList" id="banner" style="width: 1460px; left: 0px;">
							<li><a href="${elandMallUrl}"><spring:message code="name.elandmall" /></a></li>
							<li><a href="${elandCoreUrl}"><spring:message code="name.elandretail" /></a></li>
						</ul>
					</div>
				<button type="button" class="btn_slide next" id="next2">
					<span class="blind">다음</span>
				</button>
			</div>
		</div>
	</div>
	<!-- // bnrArea -->
	<div class="footerInfo">
		<strong class="f_logo"><spring:message code="name.elandoneclick" /></strong>
		<div class="infoMenu">
			<ul>
				<li class="first"><a href="/terms/onlineServiceTerms">서비스이용약관</a></li>
				<li><a href="/terms/privacyTerms">개인정보취급방침</a></li>
				<li><a href="/terms/mediaTerms">영상정보처리기기 운영, 관리방침</a></li>
				<li><a href="http://ethic.elandretail.com/" target="_blank">윤리사무국</a></li>
				<li><a href="/cs/siteMap">사이트맵</a></li>
			</ul>
			<address>
				<span class="addr">(주)이랜드리테일 서울 서초구 잠원동 70-2</span> <span>개인정보보호
					책임자 : 대표이사 김연배</span>
			</address>
			<p class="copy">COPYRIGHT &copy;2016 by E:LAND Group All rights reserved.</p>
		</div>
		<!-- // infoMenu -->
		<div class="customerBox">
			<div class="tit"><strong>고객센터</strong><span class="f_small">상담시간 오전 9시~오후 6시</span></div>
			<div class="telBox">
				<ul>
					<li><span class="txt">통합몰</span> <span class="tel">1899-9500</span></li>
					<li><span class="txt">통합홈페이지</span> <span class="tel">1588-0001</span></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- // footerInfo -->
</div>
<!-- // footer -->