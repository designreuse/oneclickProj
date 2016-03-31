<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
$(function(){
	
	// 로그인 유효성
	var reg_id = /id/;  // 아이디
	var reg_pw = /pw/;  // 비밀번호

	var u_id = $('#userID'),
		u_pw = $('#userPW');

	$(".inputArea").after("<em class='fail'></em>");

	$(".btn_login").click(function() { // form.submit
		
		if ($(u_id).val()=="") {
			$(this).parent().siblings(".fail").text("아이디를 입력해주세요.").show();
			u_id.focus();
			return false;
		} else if ($(u_pw).val()=="") {
			$(this).parent().siblings(".fail").text("비밀번호를 입력해주세요.").show();
			u_pw.focus();
			return false;
		} 
	
		$.ajax({
			type : "POST",
			beforeSend: function (request)
	        {
				request.setRequestHeader("Authorization", "${Authorization}");
	        },
			url : '/member/loginAjax',
			data: { webId: $("#userID").val(), webPwd : $("#userPW").val(), authorization : "${authorization}"} ,
			async : false,
			cache : false,
			success : function(result) {
				loginResult(result);
			},
			error : function(e) {
				alert(e.responseText);
			}
		});

	}); //
	
	// placeholder
	var placeholderTarget = $(".inputBox input");
	
	placeholderTarget.each(function(){
		if(!$(this).val() == ""){
			$(this).siblings("label").hide();
		}
	});

	placeholderTarget.focus(function(){
		$(this).siblings("label").fadeOut("100");
		$(this).parent().addClass("focusLine");
	});

	placeholderTarget.focusout(function(){
		if($(this).val() == ""){
			$(this).siblings("label").fadeIn("100");
		}
		$(this).parent().removeClass("focusLine");
	});
	
	
	// siteCode별 메세지 노출 
	var siteCode = "${destSiteCode}";
	if (siteCode == "10") {
		$("#span_retailMall").show();
		$("#p_text").show();
	} else if (siteCode == "20") {
		$("#span_ecore").show();
		$("#p_text").show();
	} 
	

});
	
	/**
	 * 상태별 이동 및 팝업 노출
	 */
	function loginResult(result) {
		if (result.resultCode == 0) {
			if (result.membState == "00") {
				commonAlert("미가입 회원입니다.");
			} else if (result.membState == "10" || result.membState == "40") {
				goToReturnUrl();
			} else if (result.membState == "20") {
				// 휴면 해지
				$("#pagePopup1").popup("open");
			} else if (result.membState == "30") {
				// 계정 잠금
				$("#pagePopup2").popup("open");
			} else if (result.membState == "50") {
				// 탈퇴 취소
				$("#pagePopup5").popup("open");
			} 
			else if (result.membState == "60") {
				// 장기 비밀번호
				$("#pagePopup3").popup("open");
			} else if (result.membState == "70") {
				// 임시 비밀번호 로그인
				$("#pagePopup4").popup("open");
			}
			$("#act").val(result.accessToken);
			
		} else {
			if (result.errorCode == "202") {
				commonAlert("회원가입이 필요합니다.");
			} else if (result.errorCode == "203") {
				commonAlert("잘못된 비밀번호 입니다.");
			} 
		}
	}

function goToReturnUrl() {
	
	var url = "${returnUrl}";
	if ("/" == url) {
		location.href = "/";
	} else {
		document.gForm.action = url;
		document.gForm.submit();
	}
}


/**
 *  임시 비밀번호 다음에 변경
 */
 function chgTempPwdNext() {
	 
	$.ajax({
			type : "POST",
			beforeSend: function (request)
	        {
				request.setRequestHeader("Authorization", "${Authorization}");
	        },
			url : '/member/holdTempPasswordAjax',
			data: { webId: $("#userID").val(), authorization : "${authorization}"} ,
			async : false,
			cache : false,
			success : function(data) {
				if (data.resultCode == "0") {
					goToReturnUrl();
				}
			},
			error : function(e) {
				alert(e.responseText);
			}
		});
}

/**
 *  비밀번호 90일 이후 변경
 */

function ninetyAfter() {
	$.ajax({
		type : "POST",
		beforeSend: function (request)
        {
			request.setRequestHeader("Authorization", "${Authorization}");
        },
		url : '/member/extendPwdChangeAjax',
		data: { webId: $("#userID").val(), authorization : "${authorization}"} ,
		async : false,
		cache : false,
		success : function(data) {
			if (data.resultCode == "0") {
				goToReturnUrl();
			}
		},
		error : function(e) {
			alert(e.responseText);
		}
	});
}

/**
 * 휴면 해제
 */
function idDormant() {
	$.ajax({
		type : "POST",
		url : '/member/loginAjax',
		data: { authorization : "${authorization}", accessToken: $("#act").val(), txDiv : "RR"} ,
		async : false,
		cache : false,
		success : function(result) {
			loginResult(result);
		},
		error : function(e) {
			alert(e.responseText);
		}
	});
}

</script>



<form name="gForm" method="GET" id="gFrom" action="">
	<input type="hidden" name="siteCode" value="${returnSiteCode}">
</form>
<input type="hidden" name="act" id="act" value="" /> 
<div class="container">
	<section class="loginDiv">
		<div class="loginHead">
			<h2>로그인</h2>
			<span class="r_txt" id="span_retailMall" style="display:none"><spring:message code="name.elandmall" /></span>
			<span class="r_txt" id="span_ecore" style="display:none"><spring:message code="name.elandretail" /></span>
		</div>
		<div class="loginBox">
			<p class="guide taC" id="p_text" style="display:none">고객님의 소중한 정보 보안을 위해<br />다시 한 번 로그인 해주시기 바랍니다.</p>

			<form id="">
				<div class="loginWrap">
					<fieldset>
						<legend>아이디 비밀번호 입력</legend>
						<div class="inputArea">
							<label for="userID" class="blind">아이디</label><input type="text" class="input_login" id="userID" name="webId" placeholder="아이디" data-role="none" />
							<label for="userPW" class="blind">비밀번호</label><input type="password" class="input_login" id="userPW" name="webPwd" placeholder="비밀번호" data-role="none" />
							<input type="button" class="btn_login" value="로그인"  id="" name="" data-role="none" />
						</div>
						<!--<em class="valid">아이디/비밀번호가 일치하지 않습니다. 다시 입력해주세요.</em>-->
					</fieldset>
				</div><!-- // loginWrap -->
			</form>

			<ul class="logInfo">
				<li><span class="txt">아이디/비밀번호를 잊으셨나요?</span><a href="/member/findId" class="btn2"><span>아이디/비밀번호 찾기</span></a></li>
				<li><span class="txt">아직 이랜드 원클릭 회원이 아니신가요?</span><a href="/member/joinMember" class="btn2"><span>회원가입</span></a></li>
			</ul>
		</div><!-- // loginBox -->
	</section><!-- // loginDiv -->
</div>



<!-- 휴면 팝업 -->
<div data-role="popup" id="pagePopup1" data-url="pagePopup1" data-overlay-theme="a">

	<div class="popWrap">

		<div class="popHeader">
			<div class="heads">
				<h1>휴면 계정 안내</h1>
				<a href="#dvwrap" data-rel="back" class="btn_head popClose"><span class="blind">닫기</span></a>
			</div>
		</div>

		<div class="container pop">
			
			<div class="popContent popGuide">
				
				<div class="taC">
					<p class="cntGuide3 f_point"><strong>현재 고객님의 계정은 휴면 계정 입니다.</strong></p>
					<p class="cntGuide mt15">확인을 누르시면 휴면이 해지되며, <br />원클릭에 입력된 정보로 사용이 가능합니다.</p>
				</div>
				<div class="popGuideBox mt20">
					<dl class="desc">
						<dt class="f_point">* 휴면계정이란?</dt>
						<dd><span class="bl">&middot;</span> 1년동안 로그인이나 구매를 하지 않아 휴면상태로 전환된 계정입니다.</dd>
						<dd><span class="bl">&middot;</span> 휴면계정 전환시 아래 개인정보가 별도 관리됩니다.<br />- 회원가입시 입력한 모든 정보 : 이름/아이디/비밀번호/휴대폰번호/주소/이메일</dd>
					</dl>
				</div>
				<div class="btnDiv mt40 ui-grid-a taC">
					<div class="ui-block-a"><a href="#" class="btn white pop" data-rel="back"><span>취소</span></a></div>
					<div class="ui-block-b"><a href="javascript:idDormant();" class="btn blue pop"><span>확인</span></a></div>
				</div><!-- // btnDiv -->

			</div><!-- // content -->

		</div><!-- // container -->

	</div><!-- // popWrap -->

</div><!-- // pagePopup2 :: 팝업 page 끝 -->


<!-- 계정 잠금 팝업 -->
<div data-role="popup" id="pagePopup2" data-url="pagePopup2" data-overlay-theme="a" >

	<div class="popWrap">

		<div class="popHeader">
			<div class="heads">
				<h1>계정 잠금 안내</h1>
				<a href="#dvwrap" data-rel="back" class="btn_head popClose"><span class="blind">닫기</span></a>
			</div>
		</div>

		<div class="container pop">
			
			<div class="popContent popGuide">
				
				<div class="taC">
					<p class="cntGuide3 f_point"><strong>현재 고객님의 계정은 잠금 상태 입니다.</strong></p>
					<p class="cntGuide mt15">잠금 해제는 고객센터로 문의하시기 바랍니다.</p>
				</div>

				<div class="csCenter mt20">
					<strong class="txtBox">고객센터 1588-0000</strong><p class="mt5">상담시간 오전 9시 ~ 오후 5시</p>
				</div>

				<div class="btnDiv mt40 taC">
					<a href="#" class="btn blue pop ui-link" data-rel="back"><span>확인</span></a>
				</div>

			</div><!-- // content -->

		</div><!-- // container -->

	</div><!-- // popWrap -->

</div><!-- // pagePopup2 :: 팝업 page 끝 -->


<!-- 장기 비밀번호 미변경 -->
<div data-role="popup" id="pagePopup3" data-url="pagePopup3" data-overlay-theme="a" >

	<div class="popWrap">

		<div class="popHeader">
			<div class="heads">
				<h1>장기간 비밀번호 미변경 안내</h1>
				<a href="#dvwrap" data-rel="back" class="btn_head popClose"><span class="blind">닫기</span></a>
			</div>
		</div>

		<div class="container pop">
			
			<div class="popContent popGuide">
				
				<div class="taC">
					<p class="cntGuide3 f_point"><strong>90일 동안 비밀번호를<br />변경하지 않으셨습니다.</strong></p>
					<p class="cntGuide mt15">지금 변경하시겠습니까?</p>
				</div>
				<div class="popGuideBox mt20">
					<dl class="desc">
						<dt class="f_point">* 비밀번호 변경시 참고하세요!</dt>
						<dd><span class="bl">&middot;</span> 연속적인 숫자나 생일, 전화번호 등 추측하기 쉬운 개인정보 및 아이디와 비슷한 비밀번호 사용을 피하시기 바랍니다.</dd>
						<dd><span class="bl">&middot;</span> 비밀번호는 영대문자, 영소문자, 숫자, 특수문자 중 3종류 이상을 조합하여, 총 8~16자리로 구성하셔야 합니다.</dd>
					</dl>
				</div>
				<div class="btnDiv mt40 ui-grid-a taC">
					<div class="ui-block-a"><a href="javascript:ninetyAfter();" class="btn white pop"><span>90일 후에 변경</span></a></div>
					<div class="ui-block-b"><a href="javascript:goToReturnUrl();" class="btn blue pop"><span>지금 변경</span></a></div>
				</div><!-- // btnDiv -->

			</div><!-- // content -->

		</div><!-- // container -->

	</div><!-- // popWrap -->

</div><!-- // pagePopup2 :: 팝업 page 끝 -->


<!-- 임시 비밀번호 사용 -->
<div data-role="popup" id="pagePopup4" data-url="pagePopup4" data-overlay-theme="a" >

	<div class="popWrap">

		<div class="popHeader">
			<div class="heads">
				<h1>임시 비밀번호 로그인 안내</h1>
				<a href="#dvwrap" data-rel="back" class="btn_head popClose"><span class="blind">닫기</span></a>
			</div>
		</div>

		<div class="container pop">
			
			<div class="popContent popGuide">
				
				<div class="taC">
					<p class="cntGuide3 f_point"><strong>고객님은 임시 발급된 비밀번호로<br />로그인 하셨습니다.</strong></p>
					<p class="cntGuide mt15">안전한 비밀번호로 변경해주세요!</p>
				</div>
				<div class="popGuideBox mt20">
					<p class="f_point">* 안전한 개인정보 보호를 위해 임시 비밀번호를 변경해주세요.</p>
				</div>
				<div class="btnDiv mt40 ui-grid-a taC">
					<div class="ui-block-a"><a href="javascript:chgTempPwdNext();" class="btn white pop"><span>다음에 변경</span></a></div>
					<div class="ui-block-b"><a href="javascript:goToReturnUrl();" class="btn blue pop"><span>지금 변경</span></a></div>
				</div><!-- // btnDiv -->

			</div><!-- // content -->

		</div><!-- // container -->

	</div><!-- // popWrap -->

</div><!-- // pagePopup2 :: 팝업 page 끝 -->

<!-- 탈퇴 취소 -->

<div data-role="popup" id="pagePopup5" data-url="pagePopup5"  data-overlay-theme="b" data-position-to="window" class="popupBox ui-popup ui-body-inherit ui-overlay-shadow ui-corner-all"><!-- 바닥 클릭시 닫히기 방지 :: data-dismissible="false" -->
	<div class="popupHead"><strong>탈퇴 취소신청 안내</strong></div>
	<div class="popupContent">
		<div class="txt taC">현재 고객님의 계정은 <span class="f_point">탈퇴 상태</span>입니다.<br>탈퇴 취소 신청은 고객센터로 문의하시기 바랍니다.</div>
		
		<!-- 2016-03-15 수정 -->
		<div class="csCenter mt15">
			<em><span>고객센터</span></em>
			<div class="telBox">
				<a href="tel:1899-9500" rel="external" class="ui-link"><span class="txt">통합몰</span><span class="tel">1899-9500</span></a>
				<a href="tel:1588-0001" rel="external" class="ui-link"><span class="txt">통합홈페이지</span><span class="tel">1588-0001</span></a>
			</div>
			<div class="f_small mt5">상담시간 오전 9시~오후 6시</div>
		</div>
		<!-- // 2016-03-15 수정 -->

		<div class="btnDiv mt15">
			<a href="#" class="btn blue pop ui-link" data-rel="back"><span>확인</span></a>
		</div><!-- // btnDiv -->
	</div><!-- // popupContent -->
	<a href="#" class="btn_popClose ui-link" data-rel="back"><span class="blind">닫기</span></a>
</div>



