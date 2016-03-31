<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
    
<script type="text/javascript">
$(document).ready(function(){ 
	// footer slide
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
});
</script>
 
<footer id="footer" data-role="footer">
	<div class="bnrArea">
		<div class="familySite">
			<strong>E:LAND FAMILY SITE</strong>
			<div class="slideBnr">
				<button type="button" class="btn_slide prev swiper-button-prev" data-role="none" ><span class="blind">이전</span></button>
				<div class="slideWrap swiper-container-footer">
					<ul class="slideList swiper-wrapper">
						<li class="swiper-slide"><a href="${elandMallUrl}" rel="external" target="_blank"><spring:message code="name.elandmall" /></a></li>
						<li class="swiper-slide"><a href="${elandCoreUrl}" rel="external" target="_blank"><spring:message code="name.elandretail" /></a></li>
					</ul>
				</div>
				<button type="button" class="btn_slide next swiper-button-next" data-role="none"><span class="blind">다음</span></button>
			</div>
		</div>
	</div><!-- // bnrArea -->
	<div class="footerInfo">
		<div class="infoMenu">
			<ul>
				<li><a href="/terms/onlineServiceTerms" rel="external">서비스이용약관</a></li>
				<li><a href="/terms/privacyTerms" rel="external" class="f_st">개인정보취급방침</a></li>
				<li><a href="/terms/mediaTerms" rel="external">영상정보처리기기 운영, 관리방침</a></li>
				<li><a href="http://ethic.elandretail.com/" target="_blank" rel="external">윤리사무국</a></li>
				<li><a href="/cs/siteMap" rel="external">사이트맵</a></li>
			</ul>
			<address><span class="addr">(주)이랜드리테일 서울 서초구 잠원동 70-2</span><span>개인정보보호 책임자 : 대표이사 김연배</span></address>
			<p class="copy">COPYRIGHT &copy;2016 by E.LAND Group All rights reserved.</p>
		</div><!-- // infoMenu -->
	</div><!-- // footerInfo -->
</footer><!-- // footer -->