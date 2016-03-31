<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var $idCheckYn;

$(document).ready(function() {

	var receiveType = "${receiveType}";
	var isMember = "${isMember}";
	
	if (isMember != "") {
		pwdSearchResult(isMember, receiveType);
	}
	
	
	$("input[name='radio_item']").click(function() {
		if ($(this).prop("checked")) {
			$(".certiBox").removeClass("off");
		}
	});
	
});

		
	
	
	/**
	 * 본인인증 팝업 호출
	 */
	function clickPcc() {
		if (!checkEmailNSmsRadio()) {
			return false;
		}
		var receiveType = $("input[name=radio_item]:checked").attr("id");
		var searchId = $("#searchId").val();
		
		if (searchId == "") {
			commonAlert("아이디를 입력해 주세요.");
			return false;
		}
		
		$.ajax({
			type : "GET",
			url : '/member/setPccInfo?srvType=scPwd&searchId='+searchId+'&receiveType=' + receiveType,
			async : false,
			cache : false,
			success : function(result) {
				$("#reqInfo").val(result.reqPccInfo);
				$("#retUrl").val(result.retPccUrl);
// 				openPCCWindow();
				document.reqPCCForm.submit();
			},
			error : function(e) {
				alert(e.responseText);
			}
		});
	}
	
	/**
	 * IPIN 팝업 호출
	 */
	function clickIpin() {
		if (!checkEmailNSmsRadio()) {
			return false;
		}
		var receiveType = $("input[name=radio_item]:checked").attr("id");
		var searchId = $("#searchId").val();
		
		if (searchId == "") {
			commonAlert("아이디를 입력해 주세요.");
			return false;
		}
		
		$.ajax({
			type : "GET",
			url : '/member/setIpinInfo?srvType=scPwd&searchId='+searchId+'&receiveType=' + receiveType,
			async : false,
			cache : false,
			success : function(result) {
				$("#reqIpinInfo").val(result.reqIpinInfo);
				$("#retIpinUrl").val(result.retIpinUrl);
// 				openCBAWindow();
				document.ipinForm.submit();
			},
			error : function(e) {
				alert(e.responseText);
			}
		});
	}
	
	/**
	 * 이메일, 문자 라디오 버튼 미체크시 팝업 미노출 
	 */
	function checkEmailNSmsRadio() {
		if ($idCheckYn) {
			return $("input[name=radio_item]").is(":checked");
		} else {
			commonAlert("아이디 체크를 먼저 해주세요");
			return false;
		}
		
	}
	
	/**
	 * 아이디 유효성 체크
	 */
	function checkWebId() {
		var inputWebId = $("#searchId").val();
		
		if (inputWebId == "") {
			commonAlert("아이디를 입력해 주세요.");
			return false;
		}
		$.ajax({
			type : "GET",
			url : '/member/isCheckId?webId=' + inputWebId + '&checkType=findPwd',
			async : false,
			cache : false,
			success : function(result) {
				idCheckResult(result.isCheckId);
			},
			error : function(e) {
				alert(e.responseText);
			}
		});
	}
	
	/**
	 * 아이디 유효성 체크_ 결과 메시지 출력
	 */
	function idCheckResult(isCheckId) {
		if (isCheckId) {
			$idCheckYn = true;
			commonAlert("유효한 아이디입니다.");
		} else {
			$idCheckYn = false;
			commonAlert("유효한 아이디가 아닙니다.");
			return false;
		}
	}
	
	
	function pwdSearchResult(isMember, receiveType) {
		if (isMember == "N") {
			commonAlert("가입한 회원이 아닙니다.");
		} else {
			if ("email" == receiveType) {
				normalPopup("findPWdEmail");
			} else {
				normalPopup("findPWdSms");
			}
		}
	}
	
	/**
	 *  returnUrl 존재시 이동
	 */
	function goToReturnUrl() {
		var returnUrl = "${scPwdReturnUrl}";
		if (returnUrl != null && returnUrl != "") {
			location.href = returnUrl;
		}
	}
</script>


<section class="cntDiv">

	<div class="lineMap">
		<div class="path">
			<span class="home"><a href="/" rel="external">HOME</a></span>
			<span><a href="/member/updateMember" rel="external">회원정보</a></span>
			<span class="current">비밀번호 찾기</span>
		</div>
	</div><!-- // lineMap -->
	
	<div class="pageTitle">
		<h2>아이디/비밀번호 찾기</h2>
	</div>

	<div class="tabMenu ui-navbar" data-role="navbar" role="navigation">
		<ul class="ui-grid-a">
			<li class="ui-block-a"><h3><a href="/member/findId" rel="external" class="ui-link ui-btn">아이디 찾기</a></h3></li>
			<li class="ui-block-b"><h3><a href="#" rel="external" class="ui-btn-active ui-link ui-btn current">비밀번호 찾기</a></h3></li>
		</ul>
	</div><!-- // tabMenu -->
	
	<div class="content member">

		<p class="taC pageGuide2">회원님의 소중한 개인정보 보호를 위하여 본인확인이 필요합니다.<br>원하시는 본인확인 방법을 선택해주세요.</p>

		<fieldset class="mt15">
					<legend class="blind">본인확인방법 선택</legend>
					<div class="element">
						<div class="block b1">
							<label for="idCheck">회원아이디</label>
							<input type="text" id="searchId" name="searchId" class="input_text" title="아이디 입력" placeholder="아이디 입력" data-role="none"><!-- 필수입력 인풋에 addClass .check -->
							<button type="button" class="btn grey btn_idCheck ui-btn ui-shadow ui-corner-all" onclick="javascript:checkWebId();"><span>확인</span></button>
						</div>
					</div><!-- // element -->
					<div class="ui-grid-a nowrap taC mt15">
						<div class="ui-block-a">
							<input type="radio" id="email" name="radio_item" class="radioBtn" data-role="none" checked>
							<label for="radio_item1" class="label_txt">이메일로 안내받기</label>
						</div>
						<div class="ui-block-b">
							<input type="radio" id="sms" name="radio_item" class="radioBtn" data-role="none">
							<label for="radio_item2" class="label_txt">문자로 안내받기</label>
						</div>
					</div><!-- // ui-grid-a -->
				</fieldset>
		

		<div class="certiBox mt15">
			<div class="box b1">
				<a href="javascript:clickPcc();" target="_blank" class="ui-link"><span class="ir_ico mobile"></span>
				<strong class="tit">휴대폰 인증</strong><span class="desc mt5">공인된 인증기관을 통해<br>휴대폰 인증을<br>받을 수 있습니다 </span></a>
			</div><!-- // box :: 휴대폰인증 -->
			<div class="box b2">
				<a href="javascript:clickIpin();" target="_blank" class="ui-link"><span class="ir_ico ipin"></span>
				<strong class="tit">아이핀 인증</strong><span class="desc mt5">공인된 인증기관을 통해<br>아이핀 실명인증을<br>받을 수 있습니다 </span></a>
			</div><!-- // box :: 아이핀인증 -->
		</div>
		
		<div class="warningBox mt15">
			<ul>
				<li><span class="bl">·</span> 아이디/비밀번호 관리의 책임은 본인에게 있습니다.</li>
				<li><span class="bl">·</span> 타인에게 알려줄 경우 불이익을 당할 수 있으므로 관리에 주의하여 주십시오.</li>
				<li><span class="bl">·</span> 아이디/비밀번호 관리 소홀로 인한 피해는 본 사이트에서 책임지지 않습니다.</li>
			</ul>
		</div><!-- // warningBox -->
	</div><!-- // content -->

</section>

<form name="reqPCCForm" id="gForm" method="post" action="https://pcc.siren24.com/pcc_V3/jsp/pcc_V3_j10.jsp" >
	<input type="hidden" id="reqInfo" name="reqInfo" value="" />
	<!-- 요청정보 -->
	<input type="hidden" id="retUrl" name="retUrl" value="" />
	<!-- 리턴받을URL -->
</form>

<!--아이핀  -->
<form name="ipinForm" id="ipinForm" method="post" action="https://ipin.siren24.com/i-PIN/jsp/ipin_j10.jsp">
	<input type="hidden" id="reqIpinInfo" name="reqInfo" value="" />
	<!-- 요청정보 -->
	<input type="hidden" id="retIpinUrl" name="retUrl" value="" />
	<!-- 리턴받을URL -->
</form>






<!-- 팝업 시작 -->
<div id="findPWdEmail" class="popupBox normal"><!-- 바닥 클릭시 닫히기 방지 :: data-dismissible="false" -->
	<div class="popupHead"><strong>비밀번호 찾기</strong></div>
	<div class="popupContent">
		<div class="txt taC">고객님의 이메일 (<span class="f_point">${email}</span>) 으로<br />임시비밀번호가 발송되었습니다.<br />발송된 이메일을 확인할 수 없을 경우<br />고객센터로 문의하시기 바랍니다.</div>

		<!-- 2016-03-15 수정 -->
		<div class="csCenter mt15">
			<em><span>고객센터</span></em>
			<div class="telBox">
				<a href="tel:1588-0000" rel="external"><span class="txt">통합몰</span><span class="tel">1588-0000</span></a>
				<a href="tel:1588-0001" rel="external"><span class="txt">통합홈페이지</span><span class="tel">1588-0001</span></a>
			</div>
			<div class="f_small mt5">상담시간 오전 9시~오후 6시</div>
		</div>
		<!-- // 2016-03-15 수정 -->

		<div class="btnDiv mt15">
			<a href="javascript:goToReturnUrl();" class="btn blue pop layerClose"><span>확인</span></a>
		</div><!-- // btnDiv -->
	</div><!-- // popupContent -->
	<a href="#" class="btn_popClose layerClose"><span class="blind">닫기</span></a>
</div><!-- // popup :: 팝업 끝 -->

<!-- 팝업 시작 -->
<div id="findPwdSms" class="popupBox normal"><!-- 바닥 클릭시 닫히기 방지 :: data-dismissible="false" -->
	<div class="popupHead"><strong>비밀번호 찾기</strong></div>
	<div class="popupContent">
		<div class="txt taC">고객님의 휴대폰 (<span class="f_point">${phoneNumber}</span>) 으로<br />임시비밀번호가 발송되었습니다.<br />발송된 SMS를 확인할 수 없을 경우<br />고객센터로 문의하시기 바랍니다.</div>
		
		<!-- 2016-03-15 수정 -->
		<div class="csCenter mt15">
			<em><span>고객센터</span></em>
			<div class="telBox">
				<a href="tel:1588-0000" rel="external"><span class="txt">통합몰</span><span class="tel">1588-0000</span></a>
				<a href="tel:1588-0001" rel="external"><span class="txt">통합홈페이지</span><span class="tel">1588-0001</span></a>
			</div>
			<div class="f_small mt5">상담시간 오전 9시~오후 6시</div>
		</div>
		<!-- // 2016-03-15 수정 -->

		<div class="btnDiv mt15">
			<a href="javascript:goToReturnUrl();" class="btn blue pop layerClose"><span>확인</span></a>
		</div><!-- // btnDiv -->
	</div><!-- // popupContent -->
	<a href="#" class="btn_popClose layerClose"><span class="blind">닫기</span></a>
</div><!-- // popup :: 팝업 끝 -->

</div><!-- // dvwrap -->

