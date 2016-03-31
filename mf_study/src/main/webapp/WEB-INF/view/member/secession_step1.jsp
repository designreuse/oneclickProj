<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

$(document).ready(function () {

});

function runMemberOutStep2(outType) {
	if (outType == "familyOut") {
		$("#selectMenu").val("1");
	} else if (outType == "onoffOut") {
		$("#selectMenu").val("2");		
	}
	
	$("#webId").val("${webId}");
	$("#siteCode").val("${siteCode}");
	
	document.membOutForm.submit();
}

</script>

<div class="container">
	<section class="cntDiv">

		<div class="lineMap">
			<div class="path">
				<span class="home"><a href="/" rel="external">HOME</a></span>
				<span><a href="/member/updateMember" rel="external">회원정보</a></span>
				<span class="current">회원탈퇴</span>
			</div>
		</div><!-- // lineMap -->
		
		<div class="pageTitle">
			<h2>회원탈퇴</h2>
		</div>

		<div class="content inner">
			<p class="pageGuide2 taC mt10">탈퇴 유형을 선택해 주세요.</p>
			
			<form action="/member/memberOutStep2" name="membOutForm" id="membOutForm" method="POST">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<div class="certiBox2 mt15">
					<div class="box">
						<a href="javascript:runMemberOutStep2('familyOut');">
							<div class="icoArea">
								<span class="ir_ico sece"></span>
								<strong class="tit">원클릭 온라인 탈퇴</strong><span class="desc mt5">원클릭의 제휴사이트만 탈퇴합니다.</span>
							</div>
							<p class="taC">탈퇴대상 : 통합몰, 통합홈페이지</p>
							<div class="warningBox">
								<ul>
									<li><span class="bl">&middot;</span> 일부 사이트 탈퇴시, 이랜드 원클릭 회원은 유지되며 계속 서비스를 받으실 수 있습니다.</li>
									<li><span class="bl">&middot;</span> 전체 사이트 탈퇴시, 30일간 다시 가입하실 수 없습니다.</li>
								</ul>
							</div>
						</a>
					</div><!-- // box -->
					<div class="box mt10">
						<a href="javascript:runMemberOutStep2('onoffOut');">
							<div class="icoArea">
								<span class="ir_ico site"></span>
								<strong class="tit">원클릭 온/오프라인 탈퇴</strong><span class="desc mt5">온/오프라인 통합탈퇴를 합니다.</span>
							</div>
							<p class="taC">탈퇴대상 : 통합몰, 통합홈페이지, NC백화점, <br />2001 아울렛, 뉴코아아울렛, 동아백화점 등</p>
							<div class="warningBox">
								<ul>
									<li><span class="bl">&middot;</span> 회원탈퇴를 하시면, 고객님의 포인트가 모두 소멸될 수도 있으니 주의하세요. </li>
									<li><span class="bl">&middot;</span> 전체 사이트 탈퇴시, 30일간 다시 가입하실 수 없습니다.</li>
								</ul>
							</div>
						</a>
					</div><!-- // box -->
				</div>
				
		<input type="hidden" id="webId" name="webId" />
		<input type="hidden" id="siteCode" name="siteCode" />
		<input type="hidden" id="selectMenu" name="selectMenu" />
			</form>
		</div>
	</section>
</div><!-- // container -->
