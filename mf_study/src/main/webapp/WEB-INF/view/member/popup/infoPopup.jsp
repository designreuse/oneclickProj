<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function () {
	
	var membState = "${membState}";
	
	
	// 휴면	
	if (membState == '20') {
		$("#dormanr").show();
		 window.resizeTo( 436, 446 );
	} 
	// 계정 잠금
	else if (membState == '30') {
		$("#idLock").show();
		window.resizeTo( 436, 345 );
	} 
	// 부분 탈퇴
	else if (membState == '40') {
		$("#siteReUse").show();
	} 
	// 장기 비밀번호 미변경
	else if (membState == '60') {
		$("#longTermPwd").show();
		window.resizeTo( 436, 426 );
	} 
	// 임시 비밀번호 로그인
	else if (membState == '70') {
		$("#tempPawdLogin").show();
	}
	// 사이트 재사용
	else if (membState == '80') {
		$("#siteAdd").show();
		window.resizeTo( 436, 306 );
	}
	
});

/**
 * 90일 이후에 변경
 */
function laterPwdChange() {
	$.ajax({
		type : "POST",
		beforeSend: function (request)
        {
			request.setRequestHeader("Authorization", "${Authorization}");
        },
		url : '/member/extendPwdChangeAjax',
		data: { webId: "${webId}"} ,
		async : false,
		cache : false,
		success : function(result) {
			if (result.resultCode == 0) {
				opener.goToReturnUrl();
				window.close();
			}
		},
		error : function(e) {
			alert(e.responseText);
		}
	});
}

/**
* 휴면 해지
*/
function termiteDormancy() {
	$.ajax({
		type : "POST",
		beforeSend: function (request)
        {
			request.setRequestHeader("Authorization", "${Authorization}");
        },
		url : '/member/loginAjax',
		data: { accessToken: "${accessToken}", txDiv : "RR"} ,
		async : false,
		cache : false,
		success : function(result) {
			if (result.resultCode == 0) {
				opener.goToReturnUrl();
				window.close();
			}
		},
		error : function(e) {
			alert(e.responseText);
		}
	});
}

</script>

<div class="popupBox w1">
	<!-- 장기 비밀번호 미변경 -->
	<div id="longTermPwd" style="display:none">
		<div class="popTitle taC"><h1>장기간 비밀번호 미변경안내</h1></div>
		<div class="popContent">
			<p class="cntGuide2 taC">90일 동안 비밀번호를 변경하지 않으셨습니다.<br>지금 변경하시겠습니까?</p><!-- 2016-02-25 수정 -->
			<div class="popGuideBox mt15">
				<strong class="tit">비밀번호 변경시 참고하세요!</strong>
				<p class="mt5">연속적인 숫자나 생일, 전화번호 등 추측하기 쉬운 개인정보 및 아이디와<br>비슷한 비밀번호 사용을 피하시기 바랍니다.<br>비밀번호는 영대문자, 영소문자 , 숫자, 특수문자 중 3종류 이상을 조합하여, 총 8~6 자리로 구성하셔야 합니다. </p><!-- 2016-02-25 수정 -->
			</div>
			<div class="btnDiv taC mt25">
				<a href="javascript:laterPwdChange();" class="btn white pop"><span>90일 후에 변경</span></a><!-- 2016-02-25 수정 -->
				<a href="/member/updateMember" class="btn blue pop"><span>지금 변경</span></a>
			</div>
		</div><!-- // popContent -->
	</div>
	
	<!-- 휴면 -->
	<div id="dormanr" style="display:none">
		<div class="popTitle taC"><h1>휴면 계정 안내</h1></div>
			<div class="popContent">
				<p class="cntGuide2 taC">현재 고객님의 계정은 <strong class="f_point">휴면계정</strong> 입니다.<br>확인을 누르시면 휴면이 해지되며, <br>원클릭에 입력된 정보로 사용이 가능합니다.</p><!-- 2016-02-25 수정 -->
			<div class="popGuideBox mt15">
				<strong class="tit">휴면계정이란?</strong>
				<p class="mt5">1년동안 로그인이나 구매를 하지 않아 휴면상태로 전환된 계정입니다.<br>휴면계정 전환시 아래 개인정보가 별도 관리됩니다.</p>
				<p class="clr"><span class="t1">회원가입시 입력한 모든 정보 : </span><span class="t2">이름/아이디/비밀번호/휴대폰번호/주소/이메일</span></p>
			</div>
			<div class="btnDiv taC mt25">
				<a href="#" class="btn white pop" onclick="window.close();"><span>취소</span></a>
				<a href="#" class="btn blue pop" onclick="javascript:termiteDormancy();"><span>확인</span></a><!-- 2016-02-25 수정 -->
			</div>
		</div><!-- // popContent -->
	</div>
	
	<!-- 계정잠금 -->
	<div id="idLock" style="display:none">
		<div class="popTitle taC"><h1>계정 잠금 안내</h1></div>
		<div class="popContent">
			<p class="cntGuide2 taC">현재 고객님의 계정은 <strong class="f_point">잠금 상태</strong> 입니다.<br>잠금 해제는 고객센터로 문의하시기 바랍니다.</p><!-- 2016-02-25 수정 -->
		
			<div class="btnDiv taC mt25">
				<button type="button" class="btn blue pop" onclick="window.close();"><span>확인</span></button>
			</div>
			
			<div class="csCenter mt30"><em>고객센터 1588-000</em><span>상담시간 오전 9시 ~ 오후5시</span></div>
	
		</div><!-- // popContent -->
	</div>
	
	<!-- 사이트 재사용 -->
	<div id="siteReUse" style="display:none">
		<div class="popTitle taC"><h1>사이트 재사용 안내</h1></div>
		<div class="popContent">
			<p class="cntGuide2 taC">탈퇴한 사이트에 로그인하셨습니다.<br>확인을 누르시면, 원클릭에 입력된 기본 정보로<br>사용이 가능합니다.</p><!-- 2016-02-25 수정 -->
			
			<div class="btnDiv taC mt25">
				<button type="button" class="btn white pop" onclick="window.close();"><span>취소</span></button>
				<button type="button" class="btn blue pop" onclick=""><span>확인</span></button><!-- 2016-02-25 수정 -->
			</div>
			
		</div><!-- // popContent -->
	</div>
	
	<!-- 임시 비밀번호 로그인 -->
	<div id="tempPawdLogin" style="display:none">
		<div class="popTitle taC"><h1>임시 비밀번호 로그인 안내</h1></div>
		<div class="popContent">
			<p class="cntGuide2 taC">고객님은 임시 발급된 비밀번호로 로그인하셨습니다.
					<br>안전한 비밀번호로 변경해주세요!
					<br>* 안전한 개인정보보호를 위해 임시 비밀번호를 변경해주세요.
			</p><!-- 2016-02-25 수정 -->
			
			<div class="btnDiv taC mt25">
				<button type="button" class="btn white pop" onclick=""><span>취소</span></button>
				<button type="button" class="btn blue pop"><span>확인</span></button><!-- 2016-02-25 수정 -->
			</div>
			
		</div><!-- // popContent -->
	</div>
	
	<!-- 사이트 추가 -->
	<div id="siteAdd" style="display:none">
		<div class="popTitle taC"><h1>제휴사이트 추가 이용 안내</h1></div>
		<div class="popContent">
			<p class="cntGuide2 taC">이랜드 리테일 원클릭에 가입된 정보가 있습니다.<br>기존 정보 확인 후, 사용이 가능합니다.</p>
			
			<div class="btnDiv taC mt25">
				<button type="button" class="btn white pop" onclick="window.close();"><span>취소</span></button>
				<button type="button" class="btn blue pop"><span>정보 수정하기</span></button>
			</div>
			
		</div><!-- // popContent -->
	</div>
	
</div>