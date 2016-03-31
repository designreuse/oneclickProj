<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
$(function(){
	
	var returnUrl = "${returnUrl}";
	var strHtml ="";
	$("#li_member > a").addClass("current");
	if (returnUrl.indexOf("/member/updateMember") > -1) {
		$("#li_updateMember > a").addClass("current");
		strHtml = "<a href='/member/updateMember'><span>회원정보</span></a><span class='current'>회원정보 수정</span>";
	} else if (returnUrl.indexOf("/member/memberOut") > -1) {
		$("#li_leaveMember > a").addClass("current");
		strHtml = "<a href='/member/updateMember'><span>회원정보</span></a><span class='current'>회원탈퇴</span>";
	}
	$("#header_path").append(strHtml);
	
	$("#userPW").keydown(function (key) {
        if (key.keyCode == 13) {
        	loginAjax();
        }
    });
	
	$(".btn_login").click(function() { // form.submit
		loginAjax();
	}); 
	
	function loginAjax() {
		if ($('#userID').val()=="") {
			$('.fail').text("아이디를 입력해주세요.");
			$('#userID').focus();
			return false;
		} else if ($('#userPW').val()=="") {
			$('.fail').text("비밀번호를 입력해주세요.");
			$('#userPW').focus();
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
	}
	
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
	
	function loginResult(result) {
		if (result.resultCode == 0) {
			if (result.membState == "00") {
				alert("미가입 회원입니다.");
			} else if (result.membState == "10" || result.membState == "40" || result.membState == "80") {
				goToReturnUrl();
			} else {
				var params = {'webId' : $("#userID").val(),'membState' : result.membState,'accessToken' : result.accessToken};
				openCommonPopup("/member/infoPopup", params, 420, 364, "");
			}
			
			
		} else {
			if (result.errorCode == "202") {
				alert("회원가입이 필요합니다.");
			} else if (result.errorCode == "203") {
				alert("잘못된 비밀번호 입니다.");
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

function goToUpdateMember() {
	location.href = "/member/updateMember";
}

</script>


<div class="content">
<form name="gForm" method="GET" id="gFrom" action="">
	<input type="hidden" name="siteCode" value="${returnSiteCode}">
</form>
	<div class="loginDiv">
		<div class="loginHead">
			<h2>로그인</h2>
			<span class="r_txt" id="span_retailMall" style="display:none"><spring:message code="name.elandmall" /></span>
			<span class="r_txt" id="span_ecore" style="display:none"><spring:message code="name.elandretail" /></span>
		</div>
		<div class="loginBox">
			<p class="guide taC" id="p_text" style="display:none">
				고객님의 소중한 정보 보안을 위해<br>다시 한 번 로그인 해주시기 바랍니다.
			</p>

				<div class="loginWrap">
					<fieldset>
						<legend>아이디 비밀번호 입력</legend>
						<div class="inputArea">
							<div class="inputBox">
								<label for="userID">아이디</label><input type="text" class="input_login" id="userID" name="webId">
							</div>
							<div class="inputBox mt10">
								<label for="userPW">비밀번호</label><input type="password" class="input_login" id="userPW" name="webPwd">
							</div>
							<input type="button" class="btn_login" value="로그인" id="" name="">
						</div>
						<em class="fail"></em>
					</fieldset>
				</div>
				<!-- // loginWrap -->
  				<input type="hidden" id="membState" name="membState" value=""/>

			<ul class="logInfo">
				<li><span class="txt">아이디/비밀번호를 잊으셨나요?</span>
				<a href="/member/findId" class="btn white "><span>아이디/비밀번호 찾기</span></a></li>
				<li class="mt10">
					<span class="txt">아직 이랜드리테일 원클릭 회원이 아니신가요?</span>
						<a href="/member/joinMember" class="btn white">
							<span>회원가입</span>
						</a>
				</li>
			</ul>
		</div>
		<!-- // loginBox -->
	</div>
	<!-- // loginDiv -->

</div>


