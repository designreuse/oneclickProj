<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script type="text/javascript">
$(document).ready(function() {
	

	var isMember = ${isMember};

	if (!isMember) {
		alert("가입한 회원이 아닙니다.");
		window.close();
	} else {
		$(".popupBox").show();
	}
	// 팝업창 resize
	resizeWindow();
	
});


function resizeWindow()    {
	this.resizeTo(436,285);
}

// 비밀번호 찾기 이동
function searchPwd() {
	opener.goToFindPwd();
	window.close();
}

// 아이디 찾기 팝업 종료
function popupClose() {
	opener.goToReturnUrl();
	window.close();
}

</script>

<div class="popupBox w1" style="display: none">
		<div class="popTitle taC"><h1>아이디 찾기</h1></div>
		<div class="popContent">
			<p class="cntGuide2 taC">회원님의 아이디는<br><strong class="f_point"><c:out value="${webId}" /> </strong> 입니다</p>
			
			<div class="btnDiv taC mt25">
				<button type="button" class="btn white pop" onclick="javascript:searchPwd();"><span>비밀번호 찾기</span></button>
				<button type="button" class="btn blue pop" onclick="javascirpt:popupClose();"><span>확인</span></button>
			</div>
			
		</div><!-- // popContent -->
</div>
