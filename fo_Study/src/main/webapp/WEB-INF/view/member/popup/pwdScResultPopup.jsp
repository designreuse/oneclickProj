<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script type="text/javascript">
$(document).ready(function() {
	
	// 팝업창 resize
	resizeWindow();

	var isMember = ${isMember};
	var receiveType = "${receiveType}";
	if (!isMember) {
		alert("가입한 회원이 아닙니다.");
		window.close();
	}
	
	if ("email" == receiveType) {
		$("#div_email").show();
	} else {
		$("#div_sms").show();
	}
	
});


function resizeWindow()    {
	this.resizeTo(436,448);
}

// 패스워드 찾기 팝업 종료
function popupClose() {
	opener.goToReturnUrl();
	window.close();
}

</script>

<div class="popupBox w1">
		<div class="popTitle taC"><h1>비밀번호 찾기</h1></div>
		<div class="popContent">
			<div id="div_email" style="display:none">
				<p class="cntGuide2 taC">고객님의 이메일 <strong class="f_point">(${email})</strong>으로<br>임시비밀번호가 발송되었습니다.<br>발송된 이메일을 확인할 수 없을 경우<br>고객센터로 문의하시기 바랍니다.</p>
			</div>
			<div id="div_sms" style="display:none">
				<p class="cntGuide2 taC">고객님의 휴대폰 <strong class="f_point">(${phoneNumber})</strong>으로<br>임시비밀번호가 발송되었습니다.<br>발송된 SMS를 확인할 수 없을 경우<br>고객센터로 문의하시기 바랍니다.</p>
			</div>
			<div class="btnDiv taC mt25">
				<button type="button" class="btn blue pop" onclick="javascript:popupClose();"><span>확인</span></button>
			</div>
			
			<div class="csCenter mt30">
				<div class="mt10"><strong class="tit"><span>고객센터</span></strong></div>
				<ul class="telBox">
					<li><span>통합몰</span><span class="tel">1588-0000</span></li>
					<li class="last"><span>통합홈페이지</span><span class="tel">1588-0001</span></li>
				</ul>
				<span>상담시간 오전 9시~오후 5시</span>
			</div>

		</div><!-- // popContent -->

		
	</div>
