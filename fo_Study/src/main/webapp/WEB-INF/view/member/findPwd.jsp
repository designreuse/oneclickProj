<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var $idCheckYn;

	$(document).ready(function() {
		$("#li_member > a").addClass("current");
		$("#li_idAndPwd > a").addClass("current");
		var strHtml = "<a href='/member/findId'><span>회원정보</span></a><span class='current'>아이디/비밀번호 찾기</span>";
		$("#header_path").append(strHtml);

		 $("#searchId").keydown(function (key) {
		        if (key.keyCode == 13) {
		        	checkWebId();
		        }
		    });
		
		customRadio();
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
			alert("아이디를 입력해 주세요.");
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
				openPCCWindow();
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
			alert("아이디를 입력해 주세요.");
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
				openCBAWindow();
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
			alert("아이디 체크를 먼저 해주세요");
			return false;
		}
		
	}
	
	/**
	 * 아이디 유효성 체크
	 */
	function checkWebId() {
		var inputWebId = $("#searchId").val();
		
		if (inputWebId == "") {
			alert("아이디를 입력해 주세요.");
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
			alert("유효한 아이디입니다.");
		} else {
			$idCheckYn = false;
			alert("유효한 아이디가 아닙니다.");
			return false;
		}
	}
	
	/**
	 *  팝업창에서 호출, returnUrl 존재시 이동
	 */
	function goToReturnUrl() {
		var returnUrl = "${returnUrl}";
		if (returnUrl != null && returnUrl != "") {
			location.href = returnUrl;
		}
	}
	
	
</script>




<div class="content">
	<h3>아이디/비밀번호 찾기</h3>

	<div class="tabMenu type2">
		<ul>
			<li><h4>
					<a href="/member/findId">아이디 찾기</a>
				</h4></li>
			<li><h4>
					<a href="#" class="on">비밀번호 찾기</a>
				</h4></li>
		</ul>
	</div>
	<!-- tabMenu -->

	<div class="tabContent mt40">
		<p class="taC pageGuide mb30">
			회원님의 소중한 개인정보 보호를 위하여 본인확인이 필요합니다.<br>원하시는 본인확인 방법을 선택해주세요.
		</p>
		<div class="inputArea">
			<div class="elem">
				<label for="" class="txt_label mt5">아이디</label><input type="text" 
					id="searchId" name="searchId" class="input_text">				
				<button type="button" id="checkIdBtn" class="btn grey w57" onclick="checkWebId();"><span>확인</span></button>
			</div>
			<div class="elem mt15">
				<span class="txt_label">비밀번호 안내</span> 
				<input type="radio" id="email" name="radio_item" checked class="radioBtn">
				<label for="radio_email" class="label_txt">이메일</label> 
				
				
				<input type="radio" id="sms" name="radio_item" class="radioBtn">
				<label for="radio_sms" class="label_txt">문자</label>
			</div>
		</div>
		<!-- // inputArea -->
		<div class="certiBox">
			<!-- 아이디 입력 / 비밀번호 안내 체크시 removeClass off (활성화) -->
			<div class="box">
				<a href="javascript:clickPcc();"><span class="ir_ico mobile"></span>
					<strong class="tit">휴대폰 인증</strong><span class="desc mt5">공인된
						인증기관을 통해<br>휴대폰 인증을<br>받을 수 있습니다
				</span></a>
			</div>
			<!-- // box :: 휴대폰인증 -->
			<div class="box">
				<a href="javascript:clickIpin();"><span class="ir_ico ipin"></span> <strong
					class="tit">아이핀 인증</strong><span class="desc mt5">공인된 인증기관을
						통해<br>아이핀 실명인증을<br>받을 수 있습니다
				</span></a>
			</div>
			<!-- // box :: 아이핀인증 -->
		</div>

		<div class="warningBox mt50">
			<ul>
				<li><span class="bl">-</span> 아이디/비밀번호 관리의 책임은 본인에게 있습니다.</li>
				<li><span class="bl">-</span> 타인에게 알려줄 경우 불이익을 당할 수 있으므로 관리에
					주의하여 주십시오.</li>
				<li><span class="bl">-</span> 아이디/비밀번호 관리 소홀로 인한 피해는 본 사이트에서
					책임지지 않습니다.</li>
			</ul>
		</div>
		<!-- // warningBox -->

	</div>
	<!-- // tabContent -->

</div>

<form name="reqPCCForm" id="gForm" method="post" action="" >
	<input type="hidden" id="reqInfo" name="reqInfo" value="${bizSiren.reqInfo }" />
	<!-- 요청정보 -->
	<input type="hidden" id="retUrl" name="retUrl" value="${bizSiren.retUrl }" />
	<!-- 리턴받을URL -->
</form>

<!--아이핀  -->
<form name="ipinForm" id="ipinForm" method="post">
	<input type="hidden" id="reqIpinInfo" name="reqInfo" value="" />
	<!-- 요청정보 -->
	<input type="hidden" id="retIpinUrl" name="retUrl" value="" />
	<!-- 리턴받을URL -->
</form>


