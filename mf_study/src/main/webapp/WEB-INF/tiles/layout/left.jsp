<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>    

<!-- left menu :: 왼쪽 슬라이드 gnb 영역 시작 -->
<div id="leftpanel" class="leftMenu" data-dismissible="false" data-role="panel" data-position="left" data-display="overlay">
	<div class="menuWrap">

		<div class="leftTop">
			<h2><a href="/" rel="external"><spring:message code="name.elandoneclick" /></a></h2>
			<a href="javascript:;" class="btn_head close" data-rel="close"><span class="blind">전체메뉴닫기</span></a>
		</div><!-- // leftTop -->

		<div class="tabWrap" >
			<div id="leftMenu1" class="scroller">
				<nav class="left_list_cont">
					<ul class="leftList">
						<li>
							<a href="#" rel="external" class="tit">이랜드리테일 원클릭 소개</a> 
							<ul class="dep2">
								<li><a href="/introduction/intro" rel="external">이랜드리테일 원클릭이란?</a></li>
								<li><a href="/introduction/guide" rel="external">회원 가입/탈퇴 안내</a></li>
								<li><a href="/introduction/membershipInfo" rel="external">이랜드리테일 멤버십 소개</a></li>
							</ul>							
						</li>
						<li>
							<a href="#" rel="external" class="tit">약관</a> 
							<ul class="dep2">
								<li><a href="/terms/memberShipClubTerms" rel="external">이랜드리테일 멤버십 이용약관</a></li>
								<li><a href="/terms/onlineServiceTerms" rel="external">온라인 서비스 이용약관</a></li>
								<li><a href="/terms/privacyTerms" rel="external">개인정보 취급방침</a></li>
								<li><a href="/terms/mediaTerms" rel="external">영상정보처리기기운영, 관리방침</a></li>
								<li><a href="/terms/entryCounselAgree" rel="external">입점상담 동의사항</a></li>
							</ul>							
						</li>
						<li>
							<a href="#" rel="external" class="tit">회원정보</a> 
							<ul class="dep2">
								<li><a href="/member/updateMember" rel="external">회원정보 수정</a></li>
								<li><a href="/member/findId" rel="external">아이디/비밀번호 찾기</a></li>
								<li><a href="/member/joinMember" rel="external">회원가입</a></li>							
								<li><a href="/member/memberOut" rel="external">회원탈퇴</a></li>
							</ul>							
						</li>	
						<li>
							<a href="#" rel="external" class="tit">고객센터</a> 
							<ul class="dep2">
								<li><a href="/cs/noticeList" rel="external">공지사항</a></li>
								<li><a href="/cs/faqList" rel="external">자주묻는 질문</a></li>
							</ul>							
						</li>	
					</ul><!--  // leftList -->
				</nav><!--  // left_list_cont -->
			</div><!-- // leftMenu1 :: 스크롤영역 -->
			
			<div class="customerBox">
				<div class="tit" style="padding-bottom:5px;"><span>고객센터</span></div>
				<div class="telBox">
					<a href="tel:1899-9500" rel="external"><span class="txt">통합몰</span><span class="tel">1899-9500</span></a>
					<a href="tel:1588-0001" rel="external"><span class="txt">통합홈페이지</span><span class="tel">1588-0001</span></a>
				</div>
				<span class="f_small">상담시간 오전 9시~오후 6시</span>
			</div><!-- // customerBox :: 고객센터 -->
		</div><!-- // tabWrap -->

	</div><!-- // menuWrap -->
</div><!-- // left menu :: 왼쪽 슬라이드 gnb 끝 -->
