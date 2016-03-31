<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="sideArea">
	<h2>회원정보</h2>
	<div class="sideMenu">
		<ul class="menuList">
			<li class="dep1" id="li_updateMember"><a href="/member/updateMember">회원정보 수정</a></li>
			<li class="dep1" id="li_idAndPwd" ><a href="/member/findId">아이디/비밀번호 찾기</a></li><!-- 메뉴 활성화시 a에 addClass current -->
			<li class="dep1" id="li_joinMember"><a href="/member/joinMember">회원가입</a></li>
			<li class="dep1" id="li_leaveMember"><a href="/member/memberOut">회원탈퇴</a></li>
		</ul>
	</div>
</div><!-- // sideArea -->