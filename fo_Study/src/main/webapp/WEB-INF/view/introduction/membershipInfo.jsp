<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

$(document).ready(function () {
	$("#li_introduction > a").addClass("current");
	$("#li_membershipInfo > a").addClass("current");
	var strHtml = "<a href='/introduction/intro'><span>이랜드리테일 원클릭 소개</span></a><span class='current'>이랜드리테일 멤버십소개</span>";
	$("#header_path").append(strHtml);
});

</script>

<!-- 컨텐츠 상세 영역 시작 -->
<div class="content">
	<h3>이랜드리테일 멤버십소개</h3>

	<h4 class="tit_bl">이랜드리테일 멤버십 서비스란?</h4>
	<div class="pointCard mt30">
		<div class="txt">
			<strong>이랜드리테일 멤버십<br />뉴코아아울렛, NC백화점, 2001아울렛, 동아백화점 포인트를 하나로!</strong>
			<p class="mt5">전국 제휴사 어디서나 현금처럼 사용하실 수 있는 포인트 서비스입니다.</p>
		</div>
		<div class="img"><img src="../../img/images/img_card.jpg" alt="E:LAND CLUB membership card" /></div>
	</div>

	<h4 class="tit_bl mt30">이랜드리테일 멤버십 혜택</h4>
	<ul class="benefits">
		<li><span class="num">1</span><strong>포인트 적립</strong><p>사용하신 만큼 차곡차곡 마일리지가 적립되어 고객님의 지갑이 두꺼워집니다.</p></li>
		<li><span class="num">2</span><strong>포인트 혜택</strong><p>포인트가 쌓이면 현금처럼 사용할 수 있는 상품권으로 교환이 가능합니다.</p></li>
		<li><span class="num">3</span><strong>프리미엄 서비스 </strong><p>우수 고객에는 쿠폰 발송 및 사은품을 증정합니다.</p></li>
		<li><span class="num">4</span><strong>최신 쇼핑정보 제공 </strong><p>항상 최신의 쇼핑정보를 고객님께 제공하여 드립니다.</p></li>
		<li><span class="num">5</span><strong>확대되는 서비스</strong><p>이랜드 그룹의 전계열사로 서비스를 확대해 나갈 것입니다.</p></li>
	</ul>
	<div class="btnDiv taC mt20">
		<a href="http://www.ncshopping.com/club/Eclub_intro.aspx" class="btn blue large" 
			onclick="window.open(this.href, '_black'); return false;"><span>멤버십 자세히 보기</span></a>
	</div>
</div>
<!-- // content :: 컨텐츠 상세 영역 끝 -->
