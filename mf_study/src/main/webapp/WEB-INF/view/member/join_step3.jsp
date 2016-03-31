<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<script type="text/javascript">
var addrList = [];
var siteCode = "${siteCode}";
$(document).on("pageinit", "#dvwrap", function(event) {
	
	var invalidAccess = ${invalidAccess};
	if (invalidAccess) {
		commonAlert("잘못된 접근입니다. 메인페이지로 이동합니다.");
		location.replace("/");
	}
	
	$(".popClose").click(function () {
		popupClose();
		// 입력 폼 및 결과 리스트 초기화
		resetAddrForm();
	});
	
	// 본인인증 휴대폰 번호 세팅
	var phoneNumber = "${phoneNumber}";
	if (phoneNumber != "") {
		$("#phoneNumber").val(phoneNumber);
	}
	
	// 본인인증으로부터 받은 생년월일 세팅
	var birth = "${birth}";
	if (birth != "") {
		$("#birth").val(birth.substring(0,4) + "-" + birth.substring(4,6) + "-" + birth.substring(6,8));
	} else {
		$("#birth").val("1980-01-01");
	}
	
	// 비밀번호 입력시 웹아이디 validation 메세지 삭제 (유효한 아이디 입니다 일경우만)
	$("#password").focusin(function() {
		if ($("#div_webId > em").hasClass("valid")) {
			$("#div_webId > em").remove();
		}
	});
	
	// 성별
	$("#sel_solarlunar").change(function() {
		if ( $("#sel_solarlunar option:selected").val() != "" ) {
			$("#div_solarlunar > em").remove();
		}
		
	});
	
	// 전화번호
	$("#phoneNumber").blur(function() {
		// 핸드폰 번호 입력 여부
		 if ($("#phoneNumber").val() == "") {
			 strHtml = "<em class='fail'>핸드폰 번호를 입력해 주세요.</em>";
			 $("#div_phone > em").remove();
			 $("#div_phone").append(strHtml);
			 $("#phoneNumber").focus();
			 return false;
		 } else {
			 if ($("#phoneNumber").val().length < 10) {
				 strHtml = "<em class='fail'>핸드폰 번호 자리수가 부족합니다.</em>";
				 $("#div_phone > em").remove();
				 $("#div_phone").append(strHtml);
				 $("#phoneNumber").focus();
				 return false;
			 } else {
				 if ("010" == $("#phoneNumber").val().substring(0,3)) {
					 if ($("#phoneNumber").val().length < 11) {
						 strHtml = "<em class='fail'>핸드폰 번호 자리수가 부족합니다.</em>";
						 $("#div_phone > em").remove();
						 $("#div_phone").append(strHtml);
						 $("#phoneNumber").focus();
						 return false;
					 }
				 }
			 }
		 }
		 $("#div_phone > em").remove();
	});
	
	// 전화번호
	$("#email").blur(function() {
		var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		 if (!reg_email.test( $("#email").val())) {
			 strHtml = "<em class='fail'>잘못된 이메일 형식입니다.</em>";
			 $("#div_email > em").remove();
			 $("#div_email").append(strHtml);
			 $("#email").focus();
			 return false;
		 } else {
			 $("#div_email > em").remove();
		 }
	});

	// 패스워드 유효성 검사
	$("#password").blur(function() {
		if ($("#password").val() != "") {
			$("#em_pwdValidMsg").html("");
			var pwdCheck = validatePassword($("#password").val(), $("#webId").val());
			if (!pwdCheck) {
				$("#hidPwdCheck").val(pwdCheck);
			}
		}
	});
	
	// 패스워드 재입력 유효성 검사
	$("#confirmPassword").blur(function() {
		if ($("#confirmPassword").val() != "") {
			if ($("#password").val() != $("#confirmPassword").val()) {
				var strHtml = "<em class='fail'>비밀번호가 같지 않습니다.</em>";
				$("#em_pwdValidMsg2 > em").remove();
		 		$("#em_pwdValidMsg2").append(strHtml);
		 		$("#hidPwdCheck").val(false);
			} else {
				$("#em_pwdValidMsg2 > em").remove();
				$("#hidPwdCheck").val(true);
			}		
		}
	});
	
	// 제휴사이트 모두 선택
	$("#check_site").click(function(){
		if (!$(this).hasClass("on")) {
			$(this).addClass("on").children().text("전체해제");
			$("input[name=partnerShip]").prop("checked", true);
			$("#div_receiveDm").show();
			 $("#div_wedding").show();
			 $("#div_childInfo").show();
			
			 if ("10" == siteCode) {
				 $("#coreEmail").removeAttr("disabled");
				 $("#coreSms").removeAttr("disabled");
			 } else if ("20" == siteCode) {
				 $("#retailMallEmail").removeAttr("disabled");
				 $("#retailMallSms").removeAttr("disabled");
			 } else {
				 $("#retailMallEmail").removeAttr("disabled");
				 $("#retailMallSms").removeAttr("disabled");
				 $("#coreEmail").removeAttr("disabled");
				 $("#coreSms").removeAttr("disabled");
			 }
			 
			 
		} else {
			$(this).removeClass("on").children().text("전체선택");
			$("input[name=partnerShip]").prop("checked", false);
 			 $("#div_wedding").hide();
			 
			 if ("10" == siteCode) {
				 $("#coreEmail").attr("disabled", true);
				 $("#coreSms").attr("disabled", true);
				 $("#div_childInfo").hide();
				 $("#div_receiveDm").hide();
			 } else if ("20" == siteCode) {
				 $("#retailMallEmail").attr("disabled", true);
				 $("#retailMallSms").attr("disabled", true);
			 } else {
				 $("#retailMallEmail").attr("disabled", true);
				 $("#retailMallSms").attr("disabled", true);
				 $("#coreEmail").attr("disabled", true);
				 $("#coreSms").attr("disabled", true);
				 $("#div_receiveDm").hide();
			 }
		}
	});
	
	// 이메일 수신 모두 선택
	$("#check_email").click(function(){
		if (!$(this).hasClass("on")) {
			$(this).addClass("on").children().text("전체해제");
			$("input[name=receiveEmail]").prop("checked", true).parent().addClass("selected");
		} else {
			$(this).removeClass("on").children().text("전체선택");
			$("input[name=receiveEmail]").prop("checked", false).parent().removeClass("selected");
		}
	});
	
	// 문자 수신 모두 선택
	$("#check_sms").click(function(){
		if (!$(this).hasClass("on")) {
			$(this).addClass("on").children().text("전체해제");
			$("input[name=receiveSms]").prop("checked", true).parent().addClass("selected");
		} else {
			$(this).removeClass("on").children().text("전체선택");
			$("input[name=receiveSms]").prop("checked", false).parent().removeClass("selected");
		}
	});

	initDate();
	
	// 자녀정보 추가
	$(".childWrap").on("click",".childAdd",function() {
		addDiv();
	});
	// 삭제
	$(".childWrap").on("click",".childRemove",function() {
		$(this).closest(".childDiv").remove();
	});
	
	
	// siteId별 제휴사이트, 마케팅 수신 정보 동의 순서 조정
	var strHtml = "";
	
	// 리테일몰
	if (siteCode == '10') {
		$("#div_receiveDm").hide();
		$("#div_childInfo").hide();
		
	// 통합홈페이지
	} else if (siteCode == '20') {
		
		$("#span_partnership1").html("");
		$("#span_partnership2").html("");
		
		// 제휴사 설정
		strHtml = '<input type="checkbox" id="corePartnerShip" class="checkBox readonly" name="partnerShip" onclick="javascript:marketingShowAndHide(this);" checked="" data-role="none">';
		strHtml += '<label for="select_site1" class="label_txt"><spring:message code="name.elandretail" /></label>';
		$("#span_partnership1").html(strHtml);
		strHtml = '<input type="checkbox" id="retailMallPartnerShip" name="partnerShip" class="checkBox" data-role="none" onclick="javascript:marketingShowAndHide(this);">';
		strHtml += '<label for="select_site1-1" class="label_txt"><spring:message code="name.elandmall" /></label>';
		$("#span_partnership2").html(strHtml);
		
		// 이메일 설정
		$("#span_email1").html("");
		$("#span_email2").html("");
		strHtml = '<input type="checkbox" id="coreEmail" class="checkBox" name="receiveEmail" checked="" data-role="none" onclick="javascript:clickReceiveEmail();">'; 
		strHtml += '<label for="select_site2" class="label_txt"><spring:message code="name.elandretail" /></label>';
		$("#span_email1").html(strHtml);
		strHtml = '<input type="checkbox" id="retailMallEmail" name="receiveEmail" class="checkBox" data-role="none" onclick="javascript:clickReceiveEmail();">'; 
		strHtml += '<label for="select_site2-1" class="label_txt"><spring:message code="name.elandmall" /></label>';
		$("#span_email2").html(strHtml);	
		

		// 문자 수신
		$("#span_sms1").html("");
		$("#span_sms2").html("");
		
		strHtml = '<input type="checkbox" id="coreSms" name="receiveSms" class="checkBox" checked="" data-role="none" onclick="javascript:clickReceiveSms();">';
		strHtml += '<label for="select_site3" class="label_txt"><spring:message code="name.elandretail" /></label>';
		$("#span_sms1").html(strHtml);
		strHtml = '<input type="checkbox" id="retailMallSms" name="receiveSms" class="checkBox" data-role="none" onclick="javascript:clickReceiveSms();">';
		strHtml += '<label for="select_site3" class="label_txt"><spring:message code="name.elandmall" /></label>'
		$("#span_sms2").html(strHtml);

		
	// 원클릭
	} else {
		$("#span_partnership1").html("");
		$("#span_partnership2").html("");
		
		// 제휴사 설정
		strHtml = '<input type="checkbox" id="retailMallPartnerShip" name="partnerShip" class="checkBox"  checked="" data-role="none" onclick="javascript:marketingShowAndHide(this);">';
		strHtml += '<label for="select_site1-1" class="label_txt"><spring:message code="name.elandmall" /></label>';
		strHtml += '<input type="checkbox" id="corePartnerShip" class="checkBox" name="partnerShip" checked="" data-role="none" onclick="javascript:marketingShowAndHide(this);">';
		strHtml += '<label for="select_site1" class="label_txt"><spring:message code="name.elandretail" /></label>';
		$("#span_partnership2").html(strHtml);
		
		// 이메일 설정
		$("#span_email1").html("");
		$("#span_email2").html("");
		strHtml = '<input type="checkbox" id="retailMallEmail" name="receiveEmail" class="checkBox" checked="" data-role="none" onclick="javascript:clickReceiveEmail();">'; 
		strHtml += '<label for="select_site2-1" class="label_txt"><spring:message code="name.elandmall" /></label>';
		strHtml += '<input type="checkbox" id="coreEmail" class="checkBox" name="receiveEmail" checked="" data-role="none" onclick="javascript:clickReceiveEmail();">'; 
		strHtml += '<label for="select_site2" class="label_txt"><spring:message code="name.elandretail" /></label>';
		$("#span_email2").html(strHtml);	
		

		// 문자 수신
		$("#span_sms1").html("");
		$("#span_sms2").html("");
		
		strHtml = '<input type="checkbox" id="retailMallSms" name="receiveSms" class="checkBox" checked="" data-role="none" onclick="javascript:clickReceiveSms();">';
		strHtml += '<label for="select_site3" class="label_txt"><spring:message code="name.elandmall" /></label>'
		strHtml += '<input type="checkbox" id="coreSms" name="receiveSms" class="checkBox" checked="" data-role="none" onclick="javascript:clickReceiveSms();">';
		strHtml += '<label for="select_site3" class="label_txt"><spring:message code="name.elandretail" /></label>';
		$("#span_sms2").html(strHtml);
		
		$("#check_site").addClass("on");
 		$("#check_site > span").text("전체해제");
 		
 		$("#check_email").addClass("on");
 		$("#check_email > span").text("전체해제");
 		
 		$("#check_sms").addClass("on");
 		$("#check_sms > span").text("전체해제");
		
	}
	
	
	// 오프라인 회원정보 사용 여부 팝업
	var isExistsMember = ${isExistsMember};
	if ( isExistsMember ) {
		// 레이어 팝업 호출
		commonConfirm("이랜드원클릭 <br>오프라인 가입내역이 있습니다.<br>기존 회원정보를 사용하시겠습니까?", useExistMemberInfo);
	}
	
	
});
	
	/**
	 *  오프라인 가입 정보 사용
	 */
	function useExistMemberInfo() {
		// 주소
		var addr1 = "${existsMemberInfo.addr1}";
		var addr2 = "${existsMemberInfo.addr2}";
		var zipCode = "${existsMemberInfo.zipCode}";
		var addrType = "${existsMemberInfo.selectAddr}";
		$("#addr1").val("(" + zipCode + ") " + addr1);
		$("#addr2").val(addr2);
		
		
		 $("#hidAddress1_1").val(addr1);
		 $("#hidAddress1_2").val(addr2);
		 $("#hidPostNo1").val(zipCode);
		 
		 if ("1" == addrType) {
			$("#hidAddrType1").val("inputJibun");
		 } else if ("2" == addrType) {
			 $("#hidAddrType1").val("inputRoad");
		 } else if ("3" == addrType) {
			 $("#hidAddrType1").val("jibun");
		 } else {
			 $("#hidAddrType1").val("road");
		 }
		 
		// 생년월일
		var birthYear = "${existsMemberInfo.birthYear}";
		var birthMonth = "${existsMemberInfo.birthMonth}";
		var birthDay = "${existsMemberInfo.birthDay}";
		
		// label 삭제
		$("#birth").parent("div").children("label").remove();
		$("#birth").val(birthYear + "-" + birthMonth + "-" + birthDay);
		
		// 양 음력
		var birthUnar = "${existsMemberInfo.birthUnar}";
		
		if ("S" == birthUnar) {
			$("#sel_solarlunar").val("solar");
		} else {
			$("#sel_solarlunar").val("lunar");
		}
		
		// 이메일
		var email1 = "${existsMemberInfo.email1}";
		var email2 = "${existsMemberInfo.email2}";
		$("#email").val(email1 + "@" + email2);
		
		// 휴대전화
		var mobilNo1 = "${existsMemberInfo.mobileNo1}";
		var mobilNo2 = "${existsMemberInfo.mobileNo2}";
		var mobilNo3 = "${existsMemberInfo.mobileNo3}";
		
		$("#phoneNumber").val(mobilNo1 + mobilNo2 + mobilNo3);
		
		
		// 결혼 여부
		var weddingYn = "${existsMemberInfo.weddingYn}";
		
		// 결혼 기념일
		var weddingYear = "${existsMemberInfo.weddingYear}";
		var weddingMonth = "${existsMemberInfo.weddingMonth}";
		var weddingDay = "${existsMemberInfo.weddingDay}";
		
		// 결혼 유무
		$("input[name='isWedding']").each(function() {  $(this).removeAttr("checked")  });
		if ("Y" == weddingYn) {
			$("#wedding").attr("checked", true);
			
			// 결혼 기념일
			if (weddingYear != null && weddingMonth != null && weddingDay != null) {
				$("#weddingday").parent("div").children("label").remove();
				$("#weddingday").val(weddingYear + "-" + weddingMonth + "-" + weddingDay);
			}
			
		} else {
			$("#single").attr("checked", true);
			$("#wedding_anniversary").hide();
	  		$("#div_childInfo").hide();
		}
		

		
		if ("10" != "${siteCode}") {
			// DM 수신 여부
			$("input[name='dm']").each(function() {  
				$(this).removeAttr("checked");
			});
			var dmYn = "${existsMemberInfo.coreDmYn}";
			if ("N" == dmYn || null == dmYn) {
				$("#notReceiveDm").attr("checked", true);
			} else {
				$("#receiveDm").attr("checked", true);
			}
			
			// 자녀
			if ("Y" == weddingYn) {
				var childNum =  "${existsMemberInfo.childNum}";
				childNum = Number(childNum);
				if (childNum > 0) {
					<c:forEach items="${existsMemberInfo.children}"  var="child"  varStatus="i">
						if ("${i.index}" == 0) {
							//성별 초기화
							var childGender = "${child.childGender}";
							if ("M" == childGender) {
								$("#childGender1").val("male");
								
							} else {
								$("#childGender1").val("female");
							}
							
							// 양음력 초기화
							var childUnar = "${child.childUnar}";
							if ("S" == childUnar) {
								$("#solarlunar1").val("solar");
							} else {
								$("#solarlunar1").val("lunar");
							}
							
							var childName = "${child.childName}";
							$("#childName1").val(childName);
							
							var childBirthDay = "${child.childBirthDay}";	
							var childBirthMonth	= "${child.childBirthMonth}";	
							var childBirthYear = "${child.childBirthYear}";	
							
							$("#childBirth1").parent("div").children("label").remove();
							$("#childBirth1").val(childBirthYear + "-" + childBirthMonth + "-" + childBirthDay);
							
						} else {
							
							addChildTr();
							
							var childGender = "${child.childGender}";
							if ("M" == childGender) {
								$("#childGender" + ("${i.index+1}")).val("male");
							} else {
								$("#childGender" + ("${i.index+1}")).val("female");
							}
							
							// 양음력 초기화
							
							var childUnar = "${child.childUnar}";
							if ("S" == childUnar) {
								$("#solarlunar"+("${i.index+1}")).val("solar");
							} else {
								$("#solarlunar"+("${i.index+1}")).val("lunar");
							}
							var childName = "${child.childName}";
							$("#childName"+("${i.index+1}")).val(childName);
							
							var childBirthDay = "${child.childBirthDay}";	
							var childBirthMonth	= "${child.childBirthMonth}";	
							var childBirthYear = "${child.childBirthYear}";	
							
							$("#childBirth"+("${i.index+1}")).parent("div").children("label").remove();
							$("#childBirth"+("${i.index+1}")).val(childBirthYear + "-" + childBirthMonth + "-" + childBirthDay);
							customRadio();
						}
					</c:forEach>
				}
			}
		} 
	}
	
	
	

	function initDate() {
		// placeholder :: input type=date일 경우 placeholder 기능
		var placeholderTarget = $(".placeholderBox input");
		
		placeholderTarget.each(function(){
			if(!$(this).val() == ""){
				$(this).siblings("label").hide();
			}
		});

		placeholderTarget.focus(function(){
			$(this).siblings("label").fadeOut("100");
		});

		placeholderTarget.focusout(function(){
			if($(this).val() == ""){
				$(this).siblings("label").fadeIn("100");
			}
		});
	}

//자녀 추가
function addDiv() {
		
		var childDivNum = $(".childInfo > .childDiv").length + 1;
		
		var add = '';
		add += '<div class="childDiv">';
		add += '<div class="childDiv">';
		add += '	<div class="tit">';
		add += '		<strong>자녀정보</strong><button type="button" class="btn white w40 childRemove"><span>삭제</span></button>';
		add += '	</div>';
		add += '	<div class="element">';
		add += '		<div class="ui-grid-a">';
		add += '			<div class="ui-block-a w30">';
		add += '				<select class="selectBox" id="childGender'+childDivNum+'"  data-role="none">';
		add += '					<option value="">선택</option>';
		add += '					<option value="male">남</option>';
		add += '					<option value="female">여</option>';
		add += '				</select>';
		add += '			</div>';
		add += '			<div class="ui-block-b w70">';
		add += '				<input type="text" id="childName'+childDivNum+'" name="childName'+childDivNum+'" class="input_text" placeholder="이름" data-role="none" />';
		add += '			</div>';
		add += '		</div>';
		add += '	</div>';
		add += '	<div class="element">';
		add += '		<div class="ui-grid-a">';
		add += '			<div class="ui-block-a w30">';
		add += '				<select class="selectBox" id="solarlunar'+childDivNum+'" data-role="none">';
		add += '					<option value="">선택</option>';
		add += '					<option value="solar">양력</option>';
		add += '					<option value="lunar">음력</option>';
		add += '				</select>';
		add += '			</div>';
		add += '			<div class="ui-block-b w70">';
		add += '				<div class="placeholderBox">';
		add += '					<label for="childBirth'+childDivNum+'" class="placeholder">생년월일</label>';
		add += '					<input type="date" id="childBirth'+childDivNum+'" name="childBirth'+childDivNum+'" class="input_text" placeholder="생년월일" data-role="none" />';
		add += '				</div>';
		add += '			</div>';
		add += '		</div>';
		add += '	</div>';
		add += '</div>';

		$(".childInfo").append(add);
		
		initDate();

}


 /**
  * 아이디 중복 체크
  */
 function isCheckId() {
	 
	var inputWebId = $("#webId").val();
	// ID Validation 정규표현식
	var regType = /^[a-z]+[a-z-_0-9]{4,19}$/g;
	
	if (inputWebId == "") {
		var strHtml = "<em class='fail'>아이디를 입력해주세요.</em>";
		// valdation 이전 메세지 삭제
		 $("#div_webId > em").remove();
		// valdation 메세지 삽입
		 $("#div_webId").append(strHtml);
		 return false;
	}
	
	if (!regType.test(inputWebId)) { 
		 var strHtml = "<em class='fail'>아이디는 영문자로 시작하는 5~20자 영문자 또는 숫자이어야 합니다.</em>";
		// valdation 이전 메세지 삭제
		 $("#div_webId > em").remove();
		// valdation 메세지 삽입
		 $("#div_webId").append(strHtml);
		 return false;
	}
	 
	$.ajax({
		type : "GET",
		url : '/member/isCheckId?webId=' + inputWebId,
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
 
 function idCheckResult(result) {
	 
	 // 중복된 아이디
	 var strHtml = "";
	 if (result) {
		 strHtml = "<em class='fail'>이미 사용중인 아이디입니다.</em>";
		 $("#hidIdCheck").val(false);
	 } else {
		 strHtml = "<em class='valid'>사용 가능한 아이디입니다.</em>";
		 $("#hidIdCheck").val(true);
	 }
	 // valdation 이전 메세지 삭제
	 $("#div_webId > em").remove();
	// valdation 메세지 삽입
	 $("#div_webId").append(strHtml);
 }
 
 /**
  * 입력폼 validation
  */
 function formValidation() {
	 var strHtml = "";
	 
	 // id 입력 및 중복 체크 여부
	 if ($("#webId").val() == "") {
		strHtml = "<em class='fail'>아이디를 입력해 주세요.</em>";
		$("#div_webId > em").remove();
		$("#div_webId").append(strHtml);
		$("#webId").focus();
		return false;
	 }
	 if ($("#hidIdCheck").val() == "") {
		strHtml = "<em class='fail'>아이디 중복 체크를 해주세요.</em>";
		$("#div_webId > em").remove();
		$("#div_webId").append(strHtml);
		$("#webId").focus();
		return false;
	 }
	 
	 var birthData = $("#birth").val();
	 birth.push(birthData.replace(/-/gi, ""));
	 phone.push($("#phoneNumber").val());
	 
	if (!validatePassword($("#password").val(), $("#webId").val())) {
		return false;
	}
	 
	 // 비밀번호 입력 및 유효성 여부
	 if ($("#passwword").val() == "") {
		strHtml = "<em class='fail'>비밀번호를 입력해 주세요.</em>";
		$("#div_password > em").remove();
		$("#div_password").append(strHtml);
		$("#password").focus();
		return false;
	 }
	 if ($("#hidPwdCheck").val() == "") {
 		strHtml = "<em class='fail'>비밀번호를 다시 입력해 주세요.</em>";
 		$("#div_confirmPassword > em").remove();
		$("#div_confirmPassword").append(strHtml);
		$("#password").focus();
	 	return false;
	 }
	 
	 // 양음력, 생년월일 선택 여부
	 if ( $("#sel_solarlunar option:selected").val() == "" ) {
		 strHtml = "<em class='fail'>양음력을 선택해주세요.</em>";
		 $("#div_solarlunar > em").remove();
		 $("#div_solarlunar").append(strHtml);
		 $("#sel_solarlunar").focus();
		 return false;
	 }
	 
	 if ( $("#birth").val() == "" ) {
		 strHtml = "<em class='fail'>생년월일을 입력해 주세요.</em>";
		 $("#div_solarlunar > em").remove();
		 $("#div_solarlunar").append(strHtml);
		 $("#birth").focus();
		 return false;
	 }
	 
	 // 핸드폰 번호 입력 여부
	 if ($("#phoneNumber").val() == "") {
		 strHtml = "<em class='fail'>핸드폰 번호를 입력해 주세요.</em>";
		 $("#div_phone > em").remove();
		 $("#div_phone").append(strHtml);
		 $("#phoneNumber").focus();
		 return false;
	 } else {
		 if ($("#phoneNumber").val().length < 10) {
			 strHtml = "<em class='fail'>핸드폰 번호 자리수가 부족합니다.</em>";
			 $("#div_phone > em").remove();
			 $("#div_phone").append(strHtml);
			 $("#phoneNumber").focus();
			 return false;
		 } else {
			 if ("010" == $("#phoneNumber").val().substring(0,3)) {
				 if ($("#phoneNumber").val().length < 11) {
					 strHtml = "<em class='fail'>핸드폰 번호 자리수가 부족합니다.</em>";
					 $("#div_phone > em").remove();
					 $("#div_phone").append(strHtml);
					 $("#phoneNumber").focus();
					 return false;
				 }
			 }
		 }
	 }
	 
	 
	 // 주소 입력 여부
	 if ($("#addr1").val() == "") {
		 strHtml = "<em class='fail'>주소를 입력해 주세요.</em>";
		 $("#div_addr > em").remove();
		 $("#div_addr").append(strHtml);
		 $("#addr2").focus();
		 return false;
	 }
	 // 이메일
	 var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	 if (!reg_email.test( $("#email").val())) {
		 strHtml = "<em class='fail'>잘못된 이메일 형식입니다.</em>";
		 $("#div_email > em").remove();
		 $("#div_email").append(strHtml);
		 $("#email").focus();
		 return false;
	 }
	 
	 
	 // 제휴 사이트 선택 여부
	 if (!$("input[name=partnerShip]").is(":checked")) {
		strHtml = "<em class='fail'>제휴사이트를 선택해 주세요.</em>";
		$("#field_partnership > em").remove();
		$("#field_partnership").append(strHtml);
		$("#retailMallPartnerShip").focus();
		return false;
	}
	 
	 setHiddenValue();
	 
	// submit
	checkUnload = false;
	document.joinForm.submit();
 }
 
 /**
  * 히든값 설정
  */
 function setHiddenValue() {
	 
	 // 양력, 음력
	$("#hidBirthUnar").val( $("#sel_solarlunar option:selected").val() );
	 
	 var birth = $("#birth").val();
	 // 생년월일
	 $("#hidBirth").val( birth.replace(/-/gi, "") );
	 
	 // 전화번호
	 $("#hidPhone").val( $("#phoneNumber").val() );

	 // 제휴사이트
	if ( $("#retailMallPartnerShip").is(":checked") ) {
		$("#hidRetailMallPartnerShipYn").val("Y");
	} else {
		$("#hidRetailMallPartnerShipYn").val("N");
	}
	
	if ( $("#corePartnerShip").is(":checked") ) {
		$("#hidCorePartnerShipYn").val("Y");
	} else {
		$("#hidCorePartnerShipYn").val("N");
	}
	
	// 이메일 수신
	if ( $("#retailMallEmail").is(":checked") ) {
		$("#hidRetailMallEmailYn").val("Y");
	} else {
		$("#hidRetailMallEmailYn").val("N");
	}
	
	if ( $("#coreEmail").is(":checked") ) {
		$("#hidCoreEmailYn").val("Y");
	} else {
		$("#hidCoreEmailYn").val("N");
	} 
	 
	 
	// 문자 수신
	if ($("#retailMallSms").is(":checked")) {
		$("#hidRetailMallSmsYn").val("Y");
	} else {
		$("#hidRetailMallSmsYn").val("N");
	}
	
	if ($("#coreSms").is(":checked")) {
		$("#hidCoreSmsYn").val("Y");
	} else {
		$("#hidCoreSmsYn").val("N");
	}
		
	// DM 수신
	if ("receiveDm" == $("input[name=dmRadio]:checked").attr("id")) {
		$("#hidDmYn").val("Y");
	} else {
		$("#hidDmYn").val("N");
	}
	 
	// 부가정보
	// 기혼, 미혼
	if ( "wedding" == $("input[name=isWedding]:checked").attr("id")) {
		$("#hidWeddingYn").val("Y");
	} else {
		$("#hidWeddingYn").val("N");
	}
	
	// 결혼 기념일
	var wd = $("#weddingday").val().replace(/-/gi, "");
	$("#hidWeddingDay").val(wd);
	
	// 자녀 정보
	var childCnt = $(".childInfo > .childDiv").length
	var childgenders = "";
	var childUnars = "";
	var childNames = "";
	var childBirth = "";
	
	for (var i=0; i < childCnt; i++) {
		if ( $("#childName" + (i+1)).val() != "" && $("#childGender" + (i+1) + " option:selected").val() != "" 
				&& $("#solarlunar" + (i+1) + " option:selected").val() != "" && $("#childBirth" + (i+1)).val() != "") {
			
			// 성별
			if ($("#childGender" + (i+1) + " option:selected").val() == 'male') {
				childgenders += "M,";
			} else {
				childgenders += "F,";
			}
			
			// 양력, 음력
			if ($("#solarlunar" + (i+1) + " option:selected").val() == 'solar') {
				childUnars += "S,";
			} else {
				childUnars += "L,";
			}
			
			// 자녀 이름
			childNames += $("#childName"+(i+1)).val() + ",";
			
			// 생년월일
			childBirth += $("#childBirth" + (i+1)).val() + ",";;
		}
	}
	
	$("#hidChildGender").val(childgenders);
	$("#hidChildName").val(childNames);
	$("#hidChildBirth").val(childBirth);
	$("#hidChildUnar").val(childUnars);
	
	
 }
 
 /**
  * 전화번호만 입력
  */
  function showKeyCode(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || keyID == 9 || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) {
		return;
	} else {
		return false;
	}
  }

 
  /**
   * 제휴사이트 DM 수신 DIV 노출, 마케팅 수신 동의 (부가정보도 포함)
   */
   function marketingShowAndHide(args) {
  	 if (args.id == "retailMallPartnerShip" ) {
  		 if (args.checked) {
  			 $("#retailMallEmail").removeAttr("disabled");
  			 $("#retailMallSms").removeAttr("disabled");
  		 } else {
  			 $("#retailMallEmail").attr("disabled", true);
  			 $("#retailMallSms").attr("disabled", true);
  			 
  			 $("#div_wedding").show();
  		 }
  	 } else {
  		 if (args.checked) {
  			$("#coreEmail").removeAttr("disabled");
  			$("#coreSms").removeAttr("disabled");
  			$("#coreEmail").attr("checked", true);
  			$("#coreSms").attr("checked", true);
  			 
  			$("#div_receiveDm").show();
  			$("#div_wedding").show();
  			$("#div_childInfo").show();
  			
  		 } else {
  			
  			$("#coreEmail").attr("disabled", true);
  			$("#coreSms").attr("disabled", true);
  			 $("#div_receiveDm").hide();
  			 $("#div_childInfo").hide();
  			 
  		 }
  	 }
   }
  
   /**
    * 이메일 수신 여부 클릭에따라 전체해제 텍스트 변경
    */
   function clickReceiveEmail() {
  	 if (!$("input[name=receiveEmail]").is(":checked")) {
  		 $("#check_email").removeClass("on");
  		 $("#check_email").children("span").text("전체선택");
  	 } else {
  		 $("#check_email").addClass("on");
  		 $("#check_email").children("span").text("전체해제");
  	 }
   }
   
   /**
    * SMS 수신 여부 클릭에따라 전체해제 텍스트 변경
    */
   function clickReceiveSms() {
  	 if (!$("input[name=receiveSms]").is(":checked")) {
  		 $("#check_sms").removeClass("on");
  		 $("#check_sms").children("span").text("전체선택");
  	 } else {
  		 $("#check_sms").addClass("on");
  		 $("#check_sms").children("span").text("전체해제");
  	 }
   }
   
   /**
    * 결혼 유무에 따라 결혼 기념일, 자녀수 노출
    */
   function isWeddingCheck(args) {
  	 if ("single" == args) {
  		$("#hidWeddingYn").val("N");
  		$("#wedding_anniversary").hide();
  		$("#div_childInfo").hide();
  	 } else {
  		$("#hidWeddingYn").val("Y");
  		$("#wedding_anniversary").show();
  		$("#div_childInfo").show();
  	 }
  	 
   }
   
   
   $(window).load(function () {
  	if("10" == siteCode) {
  		$("#coreEmail").attr("disabled", true);
  		 $("#coreSms").attr("disabled", true);
  	} else if ("20" == siteCode) {
  		 $("#retailMallEmail").attr("disabled", true);
  		 $("#retailMallSms").attr("disabled", true);
  	}
  	
  });
   
   var checkUnload = true;
   $(window).on("beforeunload", function(){
       if(checkUnload && !invalidAccess) return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
   });
  
   /*//////////////////////////////////////////////////////////////////////////////////////*/
   /*/////////////////////////////////// 주소 검색 ////////////////////////////////////////*/
   /*//////////////////////////////////////////////////////////////////////////////////////*/

   /**
    * 탭 변경
    */
   function changeTab(args) {
   	if (args == 'J') {
   		$("#road_tab").removeClass("ui-btn-active");
   		$("#road_tab").removeClass("current");
   		$("#juso_tab").addClass("ui-btn-active");
   		$("#juso_tab").addClass("current");
   		
   		$("#popContent1").show();
   		$("#popContent2").hide();
   		$("#popContent3").hide();
   		
   		resetAddrForm();
   	} else if (args == 'R'){
   		$("#juso_tab").removeClass("ui-btn-active");
   		$("#juso_tab").removeClass("current");
   		$("#road_tab").addClass("ui-btn-active");
   		$("#road_tab").addClass("current");
   		
   		$("#popContent1").hide();
   		$("#popContent2").show();
   		$("#popContent3").hide();
   		
   		resetAddrForm();
   	}
   }


   function searchAddr(param) {
   	
   	if ("J" == param) {
   		var cityNm = $("#juso_sido option:selected").val();
   		var schNm = $("#searchKeyword").val();
   		
   		if (cityNm == "") {
   			commonAlert("시/도를 선택해주세요.");
   			return false;
   		}
   		if (schNm == "") {
   			commonAlert("동/읍/면을 입력해주세요.");
   			return false;
   		}
   		// 주소찾기
   		searchPostNo("${elandmallUrl}", "J", cityNm, "", schNm);
   	} else if ("N" == param) {
   		var cityNm = $("#road_sido option:selected").val();
   		var guNm = $("#sigunguList option:selected").val();
   		var roadNm = $("#roadNm").val();
   		
   		if (cityNm == "") {
   			commonAlert("시/도를 선택해주세요.");
   			return false;
   		} 
   		if (guNm == "") {
   			commonAlert("시/군/구을 선택해주세요.");
   			return false;
   		}
   		if (roadNm == "") {
   			commonAlert("도로명을 입력해주세요.");
   			return false;
   		}
   		
   		
   		var schNm = roadNm;  

   		// 주소찾기
   		searchPostNo("${elandmallUrl}", "N", cityNm, guNm, schNm);
   	}
   	
   	
   	
   }

   function searchAddrCallBack(result) {
   	
   	if ($("#juso_tab").hasClass("current")) {
   		 var gubunCode = $("#juso_sido option:selected").data("code");
   		 var obj = JSON.parse(result);
   		 var strHtml = "";
   		 
   		 if (obj.results.length > 0) {
   			 for (var i=0; i<obj.results.length; i++) {
   				 if (gubunCode == obj.results[i].AREA_DIVI_CD) {
   					 strHtml += "<tr>";
   					 strHtml += "<td><span>"+obj.results[i].POST_NO +"</span></td>";
   					 strHtml += "<td class='taL'>";
   					 strHtml += "<a href=\"javascript:inputAddrDetail('" + obj.results[i].POST_NO +"','" + obj.results[i].ADDR + "');\">" + obj.results[i].ADDR + "</a>";
   					 strHtml += "</td>";
   					 strHtml += "</tr>";
   				 }
   			 }
   			 
   			 if (strHtml == "") {
   				 strHtml += "<tr>";
   				 strHtml += "<td colspan='2' class='result_none'>";
   				 strHtml += "<p class='taC'>우편번호 검색 결과가 없습니다.<br>동/읍/면을 입력해 주세요</p>";
   				 strHtml += "</td>";
   				 strHtml += "</tr>";
   			 }
   		 } else {
   			 strHtml += "<tr>";
   			 strHtml += "<td colspan='2' class='result_none'>";
   			 strHtml += "<p class='taC'>우편번호 검색 결과가 없습니다.<br>동/읍/면을 입력해 주세요</p>";
   			 strHtml += "</td>";
   			 strHtml += "</tr>";
   		 }
   		 
   		 $("#tbody_addr").html("");
   		 $("#tbody_addr").append(strHtml);
   		 $("#div_addrList").css("display", "block");
   		
   	} else {
   		 var obj = JSON.parse(result);
   		 var strHtml = "";
   		 
   		 if (obj.results.length > 0) {
   			 for (var i=0; i<obj.results.length; i++) {
   				strHtml += "<tr>";
   				strHtml += "<td><span>"+obj.results[i].POST_NO +"</span></td>";
   				strHtml += "<td class='taL'>";
   				strHtml += "<a href=\"javascript:inputAddrDetail('" + obj.results[i].POST_NO +"','" + obj.results[i].ADDR + "');\">" + obj.results[i].ADDR + "</a>";
   				strHtml += "</td>";
   				strHtml += "</tr>";
   				 
   			 }
   		 } else {
   			 strHtml += "<tr>";
   			 strHtml += "<td colspan='2' class='result_none'>";
   			 strHtml += "<p class='taC'>도로명 검색 결과가 없습니다.</p>";
   			 strHtml += "</tr>";
   		 }
   		 
   		 $("#tbody_addr2").html("");
   		 $("#tbody_addr2").append(strHtml);
   		 $("#div_addrList2").css("display", "block");
   	}
   	
   }

   function getSiGunGu(option) {
   	
   	var cityNm = option.value;
   	if (cityNm == "") {
   		return false;
   	}
   	
   	// 주소찾기
   	searchGuNm("${elandmallUrl}", cityNm);
   }


   function getSiGunGuCallBack(result) {
   	var obj = JSON.parse(result);
   	var strHtml = "";
   	 
   	if (obj.arrGuList.length > 0) {
   		 for (var i=0; i<obj.arrGuList.length; i++) {
   			strHtml += "<option value='"+obj.arrGuList[i]+"'>"+obj.arrGuList[i]+"</option>";
   		 }
   		 
   		 $("#sigunguList").html("");
   		 $("#sigunguList").append(strHtml);
   	 }
   }


   function inputAddrDetail(postNo, addr) {
   	
   	
   	// TODO : 도로명, 주소 팝업 hide, 및 입력 및 결과 초기화
   	$("#popContent1").hide();
   	$("#popContent2").hide();
   	
   	// TODO : 상세 입력 레이어 활성화
   	$("#popContent3").show();
   	
   	// TODO: 우편번호 , 주소 입력
   	$("#span_postNo").text(postNo);
   	$("#span_addr").text(addr);
   }

   /**
    * 주소 결과 리스트 및 선택값 초기화
    */
   function resetAddrForm() {
   	$("#tbody_addr").html("");
   	$("#tbody_addr2").html("");
   	$("#ul_addrList").html("");
   	
   	$("#searchKeyword").val("");
   	$("#roadNm").val("");
   	$("#juso_sido").find('option:first').attr('selected', 'selected'); 
   	$("#road_sido").find('option:first').attr('selected', 'selected'); 
   	$("#sigunguList").find('option:first').attr('selected', 'selected');
   	
   	$("#detailAddress").val("");
   	
   	$("#div_addrList").css("display", "none");
   	$("#div_addrList2").css("display", "none");
   	$("#div_inputDetailAddr").show();
   	$("#div_selectAddr").hide();
   }

   /**
    *  다시 검색
    */
   function reSeachAddr() {
	   if ($("#road_tab").hasClass("current")) {
   			changeTab("R"); 
	   } else {
		   changeTab("J");
	   }
   }


   /**
    * 
    */
    function confirm() {
   	
    addrList = [];
   	if ($("#div_selectAddr").css("display") ==  "block") {
   		
   		var selectAddr = $(':radio[name="radio-item"]:checked').closest("li").children("div.addr").data("addr");
   		var selectAddr2 = $(':radio[name="radio-item"]:checked').closest("li").children("div.addr").data("addr2");
   		var postNo = $(':radio[name="radio-item"]:checked').closest("li").children("div.addr").children(".post").text();
   		var addrType = $(':radio[name="radio-item"]:checked').data("name");
   		
   		var object = {};
   		
   		if ("input" == addrType) {
   			if ($("#roadTab").hasClass("current")) {
   				addrType = addrType + "Road"; 
   			} else {
   				addrType = addrType + "Jibun";
   			}
   		}
   		object.addrType = addrType; 
   		object.postNo = postNo; 
   		object.addr = selectAddr; 
   		object.addr2 = selectAddr2;
   		addrList[0] = object;
   		
   		// 입력주소 선택시
   		if ("inputRoad" == addrType || "inputJibun" == addrType) {

   			if ($("#ul_addrList > li").eq(1).length > 0) {
   				if ($("#ul_addrList > li").eq(2).length == 0) {
   					 var object = {};
   					 var addr = $("#ul_addrList > li").eq(1).closest("li").children("div.addr").data("addr");
   					 var addr2 = $("#ul_addrList > li").eq(1).closest("li").children("div.addr").data("addr2");
   					 var postNo = $("#ul_addrList > li").closest("li").eq(1).children("div.addr").children("span").text();
   					 var addrType = $("#ul_addrList > li").eq(1).data("name");
   					 
   					 object.addrType = addrType;
   					 object.postNo = postNo;
   					 object.addr = addr; 
   					 object.addr2 = addr2; 
   					 addrList[1] = object;
   				} else {
   					for (var i=0; i < 2; i++) {
   						 var object = {};
   						 var addr = $("#ul_addrList > li").eq(i).closest("li").children("div.addr").data("addr");
   						 var addr2 = $("#ul_addrList > li").eq(i).closest("li").children("div.addr").data("addr2");
   						 var postNo = $("#ul_addrList > li").closest("li").eq(i).children("div.addr").children("span").text();
   						 var addrType = $("#ul_addrList > li").eq(i).data("name");
   						 
   						 object.addrType = addrType;
   						 object.postNo = postNo;
   						 object.addr = addr; 
   						 object.addr2 = addr2; 
   						 addrList[i+1] = object;
   					}
   				}
   			}
   		} 
   		// 지번 주소 선택시
   		else if ("jibun" == addrType) {
   			
   			
   			// 정제 도로명 주소 존재시 
   			var index = $(':radio[name="radio-item"]:checked').closest("li").index();
   			if ($("#ul_addrList > li").eq(index+1).length > 0) {
   							 
   				var roadAddr = $("#ul_addrList > li").eq(index+1).closest("li").children("div.addr").data("addr")
   				var roadAddr2 = $("#ul_addrList > li").eq(index+1).closest("li").children("div.addr").data("addr2")
   				var roadPostNo = $("#ul_addrList > li").closest("li").eq(index+1).children("div.addr").children("span").text();
   				
   				 var object = {};
   				 object.addrType = "road"; 
   				 object.postNo = roadPostNo; 
   				 object.addr = roadAddr; 
   				 object.addr2 = roadAddr2; 
   				 addrList[1] = object;
   			}
   		} else if ("road" == addrType) {
   			
   			// 정제 지번 주소 존재시 		
   			var index = $(':radio[name="radio-item"]:checked').closest("li").index();
   			for (var i= index; 0 < i ; i--) {
   				if ("jibun" == $("#ul_addrList > li").closest("li").eq(i).find("input").data("name")) {
   					var jibunAddr = $("#ul_addrList > li").eq(i).closest("li").children("div.addr").data("addr")
   					var jibunAddr2 =  $("#ul_addrList > li").eq(i).closest("li").children("div.addr").data("addr2")
   					var jibunPostNo = $("#ul_addrList > li").closest("li").eq(i).children("div.addr").children("span").text();
   					
   					 var object = {};
   					 object.addrType = "jibun"; 
   					 object.postNo = jibunPostNo; 
   					 object.addr = jibunAddr; 
   					 object.addr2 = jibunAddr2; 
   					 addrList[1] = object;
   				}	
   			}
   		}
   		
   		for (var i=0; i< addrList.length; i++) {
   		 if (i == 0) {
   			 $("#addr1").val("(" + addrList[i].postNo + ")" + addrList[i].addr);
   			 $("#addr2").val(addrList[i].addr2);
   			 
   			 $("#hidAddress1_1").val(addrList[i].addr);
   			 $("#hidAddress1_2").val(addrList[i].addr2);
   			 $("#hidPostNo1").val(addrList[i].postNo);
   			 $("#hidAddrType1").val(addrList[i].addrType);
   		 } else {
   			 $("#hidAddress"+(i+1)+"_1").val(addrList[i].addr);
   			 $("#hidAddress"+(i+1)+"_2").val(addrList[i].addr2);
   			 $("#hidPostNo"+(i+1)).val(addrList[i].postNo);
   			 $("#hidAddrType"+(i+1)).val(addrList[i].addrType);
   		 }
   	 }
   		popupClose();
   		resetAddrForm();
   		return false;
   	}
   	
   	
   	if ($("#detailAddress").val() == "") {
   		commonAlert("상세주소를 입력해주세요.");
   		return false;
   	}
   	
   	searchConvertAddr("${elandmallUrl}", "N", $("#span_postNo").text(), $("#span_addr").text(), $("#detailAddress").val());
   }

    function searchAddrConvertCallBack(result) {
   		// 주소 정제 데이터
   		var obj = JSON.parse(result);
   		var RCD1 = obj.convertAddr.RCD1;
   		var RCD3 = obj.convertAddr.RCD3;
   		
   		var strHtml = "";
   		// 입력 주소
   		strHtml += '<li>';
   		strHtml += '<div class="slct"><input type="radio" id="radio-item-0" name="radio-item" data-name="input" class="radioBtn"><label for="radio-item-0" class="label_txt">입력 주소</label></div>';
   		strHtml += '<div class="addr" data-addr="'+$("#span_addr").text()+'" data-addr2="'+$("#detailAddress").val()+'"><span class="post">'+$("#span_postNo").text()+'</span><p>'+$("#span_addr").text()+' '+$("#detailAddress").val() +'</p></div>';
   		strHtml += '</li>';
   		
   		// 1:1 매핑일때 자동 설정 (자식노드의 지번, 도로명 사용) 
   		if (RCD3 == 'I' || RCD3 == 'H') {
   			strHtml += '<li>';
   			strHtml += '<div class="slct"><span class="customRadio"><input type="radio" id="radio-item-2" data-name="jibun" name="radio-item" class="radioBtn"></span><label for="radio-item-2" class="label_txt">표준지번 주소</label></div>';
   			strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[1].ADDR1H+'" data-addr2="'+obj.convertAddr.DATA[1].STDADDR+'"><span class="post">'+obj.convertAddr.DATA[1].ZIPM6+'</span><p>'+obj.convertAddr.DATA[1].ADDR1H+""+obj.convertAddr.DATA[1].STDADDR+'</p></div>';
   			strHtml += '</li>';
   			strHtml += '<li>';
   			strHtml += '<div class="slct"><span class="customRadio"><input type="radio" id="radio-item-3" data-name="road" name="radio-item" class="radioBtn"></span><label for="radio-item-3" class="label_txt">도로명 주소</label></div>';
   			strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[1].NADR1+'" data-addr2="'+obj.convertAddr.DATA[1].NBKM+'-'+obj.convertAddr.DATA[1].NBKS+" "+obj.convertAddr.DATA[1].NADREM+" "+obj.convertAddr.DATA[1].NADR3S+'"><span class="post">'+obj.convertAddr.DATA[1].ZIPM6+'</span><p>'+obj.convertAddr.DATA[1].NADR1S +""+obj.convertAddr.DATA[1].NADREM +""+obj.convertAddr.DATA[1].NADR3S +'</p></div>';
   			strHtml += '</li>';
   		// 멀티 선택 케이스 (지번은 부모노드, 도로명은 자식 노드 사용)
   		} else if(RCD3 == 'C' || RCD3 == 'D' || RCD3 == 'E' || RCD3 == 'F' || RCD3 == 'G') {
   			for (var i=0; i < obj.convertAddr.DATA.length; i++) {
   				if (obj.convertAddr.DATA[i].NODE == "D") {
   					strHtml += '<li>';
   					strHtml += '<div class="slct"><span class="customRadio"><input type="radio" data-name="jibun" id="radio-item-'+(i+1)+'" name="radio-item" class="radioBtn"></span><label for="radio-item-'+(i+1)+'" class="label_txt">표준지번 주소</label></div>';
   					strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[i].ADDR1H+'" data-addr2="'+obj.convertAddr.DATA[i].STDADDR+'"><span class="post">'+obj.convertAddr.DATA[i].ZIPM6+'</span><p>'+obj.convertAddr.DATA[i].ADDR1H+""+obj.convertAddr.DATA[i].STDADDR+'</p></div>';
   					strHtml += '</li>';	
   				}
   				if (obj.convertAddr.DATA[i].NODE == "P") {
   					strHtml += '<li>';
   					strHtml += '<div class="slct"><span class="customRadio"><input type="radio" data-name="road" id="radio-item-'+(i+1)+'" name="radio-item" class="radioBtn"></span><label for="radio-item-'+(i+1)+'" class="label_txt">도로명 주소</label></div>';
   					strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[i].NADR1+'" data-addr2="'+obj.convertAddr.DATA[i].NBKM+'-'+obj.convertAddr.DATA[i].NBKS+" "+obj.convertAddr.DATA[i].NADREM+" "+obj.convertAddr.DATA[i].NADR3S+'"><span class="post">'+obj.convertAddr.DATA[i].ZIPM6+'</span><p>'+obj.convertAddr.DATA[i].NADR1S +""+obj.convertAddr.DATA[i].NADREM +""+obj.convertAddr.DATA[i].NADR3S +'</p></div>';
   					strHtml += '</li>';
   				}
   			}
   			
   		// 지번주소만 정제 성공 케이스
   		} else if(RCD3 == '6' || RCD3 == '8') {
   			strHtml += '<li>';
   			strHtml += '<div class="slct"><span class="customRadio"><input type="radio" data-name="jibun" id="radio-item-'+(i+1)+'" name="radio-item" class="radioBtn"></span><label for="radio-item-'+(i+1)+'" class="label_txt">표준지번주소</label></div>';
   			strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[0].ADDR1H+'" data-addr2="'+obj.convertAddr.DATA[0].STDADDR+'"><span class="post">'+obj.convertAddr.DATA[0].ZIPM6+'</span><p>'+obj.convertAddr.DATA[0].ADDR1H+""+obj.convertAddr.DATA[0].STDADDR+'</p></div>';
   			strHtml += '</li>';
//   	 		strHtml += '<li>';
//   	 		strHtml += '<div class="slct"><span class="customRadio"><input type="radio" id="radio-item-'+(i+1)+'" name="radio-item" class="radioBtn"></span><label for="radio-item-'+(i+1)+'" class="label_txt">도로명주소</label></div>';
//   	 		strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[0].NADR1+'" data-addr2="'+obj.convertAddr.DATA[0].NBKM+'-'+obj.convertAddr.DATA[0].NBKS+" "+obj.convertAddr.DATA[0].NADREM+'"><span class="post">'+obj.convertAddr.DATA[0].ZIPM6+'</span><p>'+obj.convertAddr.DATA[0].NADR1S +""+obj.convertAddr.DATA[0].NADREM +'</p></div>';
//   	 		strHtml += '</li>';
   		// 통신장애 케이스
   		} else if(RCD3 == 'EXP') {
   			
   		}
   			
   		
   		$("#ul_addrList").append(strHtml);
   		
   		$("#div_inputDetailAddr").hide();
   		$("#div_selectAddr").show();
   		
   		
   		if ($("#road_tab").hasClass("current")) {
   		// 디폴트 선택 처리
   			if ($("#radio-item-3").data("name") == "road") {
   				$("#radio-item-3").parent("span").addClass("selected");
   				$("#radio-item-3").attr("checked", true);
   			} else {
   				$("#radio-item-0").parent("span").addClass("selected");
   				$("#radio-item-0").attr("checked", true);
   			}
   		} else {
   		// 디폴트 선택 처리
   			if ($("#radio-item-2").data("name") == "jibun") {
   				$("#radio-item-2").parent("span").addClass("selected");
   				$("#radio-item-2").attr("checked", true);
   			} else {
   				$("#radio-item-0").parent("span").addClass("selected");
   				$("#radio-item-0").attr("checked", true);
   			}
   		}
   		
   	}
    
    function popupClose() {
   		$('#pagePopup1').popup("close");
   		$('#pagePopup2').popup("close");
   		
   		$("#juso_tab").addClass("ui-btn-active");
   		$("#juso_tab").addClass("current");
   		$("#road_tab").removeClass("ui-btn-active");
   		$("#road_tab").removeClass("current");
   		
   		$('#popContent1').show();
   		$('#popContent2').hide();
   		$('#popContent3').hide();
   	}
</script>

<div class="container">
<section class="cntDiv">

	<div class="lineMap">
		<div class="path">
			<span class="home"><a href="/" rel="external">HOME</a></span>
			<span><a href="/member/updateMember" rel="external">회원정보</a></span>
			<c:choose>
				<c:when test="${10 eq siteCode}">
					<span class="current"><spring:message code="name.elandmall" /> 회원가입</span>
				</c:when>
				<c:when test="${20 eq siteCode}">
					<span class="current"><spring:message code="name.elandretail" /> 회원가입</span>
				</c:when>
				<c:otherwise>
					<span class="current"><spring:message code="name.elandoneclick" /> 회원가입</span>
				</c:otherwise>
			</c:choose>
		</div>
	</div><!-- // lineMap -->
	
	<c:choose>
		<c:when test="${10 eq siteCode}">
			<div class="pageTitle">
				<h2><spring:message code="name.elandmall" /> 회원가입</h2>
			</div>
		</c:when>
		<c:when test="${20 eq siteCode}">
			<div class="pageTitle">
				<h2><spring:message code="name.elandretail" /> 회원가입</h2>
			</div>
		</c:when>
		<c:when test="${30 eq siteCode}">
			<div class="pageTitle">
				<h2><spring:message code="name.elandoneclick" /> 회원가입</h2>
			</div>
		</c:when>
	</c:choose>

<form action="/member/joinMemberSuccess" name="joinForm" id="joinForm" method="POST">
	<div class="content inner">

		<div class="stepBox">
			<ol>
				<li><span class="num">STEP 01</span><span class="txt">본인확인</span></li>
				<li><span class="num">STEP 02</span><span class="txt">약관동의</span></li>
				<li class="on"><span class="num">STEP 03</span><span class="txt">정보입력</span></li>
				<li><span class="num">STEP 04</span><span class="txt">가입완료</span></li>
			</ol>
		</div><!-- // stepBox -->
		
		<!-- 기본정보 입력 -->
		<div class="fieldDiv bLine mt15">
			<fieldset>
				<legend class="tit_bl">기본정보</legend>
				<p class="guide"><span class="ns"></span>필수입력항목</p>
				<div class="elemWrap">
					<div class="element">
						<label for="">이름</label>
						<input type="text" id="custName" name="custName" class="input_text" data-role="none" readonly="" value="<c:out value="${userName}" />">
					</div><!-- // element -->
					<div class="element">
						<div class="block" id="div_webId">
							<span class="ns" title="필수입력"></span><!-- 필수입력 아이콘 -->
							<label for="idCheck">회원아이디</label>
							<input type="text" id="webId" name="webId" class="input_text check" placeholder="아이디 입력" data-role="none"><!-- 필수입력 인풋에 addClass .check -->
							<button type="button" class="btn grey btn_idCheck ui-btn ui-shadow ui-corner-all" onclick="javascript:isCheckId();"><span>아이디 중복체크</span></button>
							<em class="fail" style="display: none;">이미 사용중인 아이디입니다.</em>
						</div>
					</div><!-- // element -->
					<div class="element" id="div_password">
						<span class="ns" title="필수입력"></span>
						<label for="pwCheck">비밀번호</label>
						<input type="password" id="password" name="password" class="input_text check" placeholder="비밀번호" data-role="none">
						<div id="em_pwdValidMsg"></div>
					</div><!-- // element -->
					<div class="element" id="div_confirmPassword">
						<span class="ns" title="필수입력"></span>
						<label for="pwCheck_re">비밀번호 재입력</label>
						<input type="password" id="confirmPassword" name="confirmPassword" class="input_text check" placeholder="비밀번호 재입력" data-role="none">
						<div id="em_pwdValidMsg2"></div>
					</div><!-- // element -->
					<div class="warn">
						연속적인 숫자나 생일, 전화번호등 추측하기 쉬운 개인정보 및 아이디와 비슷한 비밀번호 사용을 피하시기 바랍니다.<br>비밀번호는 영대문자, 영소문자, 숫자, 특	수문자 중 3종류 이상을 조합하여, 총 8~16자리로 구성하셔야 합니다.
					</div><!-- // warn -->
					<div class="element">
						<div class="ui-grid-a" id="div_solarlunar">
							<div class="ui-block-a w30">
								<span class="ns" title="필수입력"></span>
								<select class="selectBox check" id="sel_solarlunar" data-role="none">
									<option value="">선택</option>
									<option value="solar">양력</option>
									<option value="lunar">음력</option>
								</select>
							</div>
							<div class="ui-block-b w70 placeholderBox">
								<label for="birth" class="placeholder">생년월일</label>
								<input type="date" id="birth" name="" class="input_text" placeholder="생년월일" data-role="none">
							</div>
						</div>
					</div><!-- // element -->
					<div class="element" id = "div_phone">
						<span class="ns" title="필수입력"></span>
						<label for="">핸드폰번호</label>
						<input type="tel" id="phoneNumber" name="phoneNumber" class="input_text check" maxlength="11" placeholder="핸드폰번호" onkeydown="return showKeyCode(event);" data-role="none">
					</div><!-- // element -->
					<div class="element" id="div_addr">
						<div class="block">
							<span class="ns" title="필수입력"></span>
							<label for="">주소</label>
							<input type="text" id="addr1" name="addr1" class="input_text check" placeholder="주소" disabled="" data-role="none" value="">
							<a href="#pagePopup1" data-rel="popup" data-transition="fade" class="btn grey ui-link"><span>주소찾기</span></a>
						</div>
						<div class="elem mt10">
							<span class="ns" title="필수입력"></span>
							<label for="">상세주소</label>
							<input type="text" id="addr2" name="addr2" class="input_text check" placeholder="상세주소" data-role="none">
						</div>
					</div><!-- // element -->
					<div class="element" id="div_email">
						<span class="ns" title="필수입력"></span>
						<label for="">이메일</label>
						<input type="email" id="email" name="email" class="input_text check" placeholder="이메일" data-role="none">
					</div><!-- // element -->
				</div><!-- // elemWrap -->
			</fieldset>
		</div><!-- // fieldDiv :: 기본정보 입력 -->
		
		<!-- 이랜드리테일 제휴 사이트 선택 -->
		<div class="fieldDiv mt15">
			<fieldset id="field_partnership">
				<legend class="tit_bl">이랜드리테일 제휴 사이트 선택</legend>
				<div class="allCheckLine">
					<span class="chk fl" id="span_partnership1">
						<input type="checkbox" id="retailMallPartnerShip" class="checkBox readonly" name="partnerShip" onclick="javascript:marketingShowAndHide(this);" checked="" data-role="none">
						<label for="select_site1" class="label_txt"><spring:message code="name.elandmall" /></label>
					</span>
					<button type="button" class="btn white w60 ui-btn ui-shadow ui-corner-all" id="check_site"><span>전체선택</span></button>
				</div><!-- // allCheckLine -->
				<div class="checkArea">
					<span class="chk" id="span_partnership2">
						<input type="checkbox" id="corePartnerShip" name="partnerShip" class="checkBox" data-role="none" onclick="javascript:marketingShowAndHide(this);">
						<label for="select_site1-1" class="label_txt"><spring:message code="name.elandretail" /></label>
					</span>
				</div><!-- // checkArea -->
			</fieldset>
		</div><!-- // fieldDiv :: 이랜드리테일 제휴 사이트 선택 -->

		<!-- 마케팅 정보 수신동의 -->
		<div class="fieldDiv mt15">
			<fieldset>
				<legend class="tit_bl">마케팅 정보 수신동의</legend>
				<div class="tit mt5"><strong>이메일 수신</strong></div>
				<div class="allCheckLine">
					<span class="chk fl" id="span_email1">
						<input type="checkbox" id="retailMallEmail" class="checkBox" name="receiveEmail" checked="" data-role="none" onclick="javascript:clickReceiveEmail();">
						<label for="select_site2" class="label_txt"><spring:message code="name.elandmall" /></label>
					</span>
					<button type="button" class="btn white w60 ui-btn ui-shadow ui-corner-all" id="check_email"><span>전체선택</span></button>
				</div><!-- // allCheckLine -->
				<div class="checkArea">
					<span class="chk" id="span_email2">
						<input type="checkbox" id="coreEmail" name="receiveEmail" class="checkBox" data-role="none" onclick="javascript:clickReceiveEmail();">
						<label for="select_site2-1" class="label_txt"><spring:message code="name.elandretail" /></label>
					</span>
				</div><!-- // checkArea -->
				<!-- // 이메일 수신 -->

				<div class="tit mt5"><strong>문자 수신</strong></div>
				<div class="allCheckLine">
					<span class="chk fl" id="span_sms1">
						<input type="checkbox" id="retailMallSms" name="receiveSms" class="checkBox" checked="" data-role="none" onclick="javascript:clickReceiveSms();">
						<label for="select_site3" class="label_txt"><spring:message code="name.elandmall" /></label>
					</span>
					<button type="button" class="btn white w60 ui-btn ui-shadow ui-corner-all" id="check_sms"><span>전체선택</span></button>
				</div><!-- // allCheckLine -->
				<div class="checkArea">
					<span class="chk" id="span_sms2">
						<input type="checkbox" id="coreSms" name="receiveSms" class="checkBox" data-role="none" onclick="javascript:clickReceiveSms();">
						<label for="select_site3-1" class="label_txt"><spring:message code="name.elandretail" /></label>
					</span>
				</div><!-- // checkArea -->
				<!-- // 문자 수신 -->
				
				<!-- dm 수신 -->
				<div id="div_receiveDm">
					<div class="tit mt5"><strong>DM 수신</strong></div>
					<div class="radioArea">
						<div class="chkLine"><input type="radio" id="receiveDm" name="dm" class="radioBtn" data-role="none"><label for="dm1" class="label_txt">우편수신</label></div>
						<div class="chkLine"><input type="radio" id="notReceiveDm" name="dm" class="radioBtn"  checked="" data-role="none"><label for="dm2" class="label_txt">수신안함</label></div>
					</div><!-- // radioArea -->
				</div>
				<!-- // DM 수신 -->
			</fieldset>
		</div><!-- // fieldDiv :: 마케팅 정보 수신동의 -->

		<!-- 부가정보 -->
		<div class="fieldDiv bLine mt15">
			<fieldset>
				<legend class="tit_bl">부가정보</legend>
				<div class="radioArea" id="div_wedding">
					<span class="chk">
						<input type="radio" id="wedding" name="isWedding" class="radioBtn" data-role="none" onclick="isWeddingCheck('wedding');">
						<label for="wedding" class="label_txt">기혼</label>
					</span>
					<span class="chk">
						<input type="radio" id="single" name="isWedding" class="radioBtn" data-role="none" onclick="isWeddingCheck('single');">
						<label for="single" class="label_txt">미혼</label>
					</span>
				</div><!-- // radioArea -->
				<div class="element m1 placeholderBox" id="wedding_anniversary">
					<label for="weddingday" class="placeholder">결혼기념일</label>
					<input type="date" id="weddingday" name="weddingday" class="input_text" data-role="none" placeholder="결혼기념일">
				</div><!-- // element -->
				
				<!-- 자녀정보 -->
				<div class="childWrap mt5" id="div_childInfo">
					<div class="tit">
						<strong>자녀정보</strong>
						<button type="button" class="btn white w40 childAdd ui-btn ui-shadow ui-corner-all" title="추가"><span>추가</span></button>
					</div>

					<div class="childInfo">
						<div class="childDiv">
							<div class="tit">
								<strong>자녀정보</strong><button type="button" class="btn white w40 childRemove ui-btn ui-shadow ui-corner-all"><span>삭제</span></button>
							</div>
							<div class="element">
								<div class="ui-grid-a">
									<div class="ui-block-a w30">
										<select class="selectBox" id="childGender1" data-role="none">
											<option value="">선택</option>
											<option value="male">남</option>
											<option value="female">여</option>
										</select>
									</div>
									<div class="ui-block-b w70">
										<input type="text" id="childName1" name="childName" class="input_text" placeholder="이름" data-role="none">
									</div>
								</div>
							</div><!-- // element -->
							<div class="element">
								<div class="ui-grid-a">
									<div class="ui-block-a w30">
										<select class="selectBox" id="solarlunar1" data-role="none">
											<option value="">선택</option>
											<option value="solar">양력</option>
											<option value="lunar">음력</option>
										</select>
									</div>
									<div class="ui-block-b w70">
										<div class="placeholderBox">
											<label for="childBirth1" class="placeholder">생년월일</label>
											<input type="date" id="childBirth1" name="childBirth" class="input_text" placeholder="생년월일" data-role="none">
										</div>
									</div>
								</div>
							</div><!-- // element -->
						</div><!-- // childDiv -->

					</div><!-- // childInfo -->

				</div><!-- // childWrap :: 자녀정보 -->
			</fieldset>
		</div><!-- // fieldDiv :: 부가정보 -->

		<div class="btnDiv taC mt20 ui-grid-a">
			<div class="ui-block-a"><a href="#" class="btn white large ui-link"><span>취소</span></a></div>
			<div class="ui-block-b"><a href="javascript:formValidation();" class="btn blue large ui-link"><span>다음</span></a></div>
		</div>

	</div><!-- // content -->
	
	<!-- Hidden Value //S -->
	<input type="hidden" id="hidSiteCode" name="siteCode" value="${siteCode}" />
	<input type="hidden" id="hidIdCheck" name="hidIdCheck" />
	<input type="hidden" id="hidPwdCheck" name="hidPwdCheck" />
	
	
	<input type="hidden" id="hidName" name="name" value="${userName}"/>
	<input type="hidden" id="hidBirth" name="birth" />
	<input type="hidden" id="hidBirthUnar" name="birthUnar" />
	<input type="hidden" id="hidPhone" name="phone" />
	
	<input type="hidden" id="hidAddress1_1" name="address1_1" />
	<input type="hidden" id="hidAddress1_2" name="address1_2" />
	<input type="hidden" id="hidPostNo1" name="postNo1" />
	<input type="hidden" id="hidAddrType1" name="addrType1" />
	
	<input type="hidden" id="hidAddress2_1" name="address2_1" />
	<input type="hidden" id="hidAddress2_2" name="address2_2" />
	<input type="hidden" id="hidPostNo2" name="postNo2" />
	<input type="hidden" id="hidAddrType2" name="addrType2" />
	
	<input type="hidden" id="hidAddress3_1" name="address3_1" />
	<input type="hidden" id="hidAddress3_2" name="address3_2" />
	<input type="hidden" id="hidPostNo3" name="postNo3" />
	<input type="hidden" id="hidAddrType3" name="addrType3" />

	<input type="hidden" id="hidRetailMallPartnerShipYn" name="retailMallPartnerShipYn" />
	<input type="hidden" id="hidCorePartnerShipYn" name="corePartnerShipYn" />
	
	<input type="hidden" id="hidRetailMallEmailYn" name="retailMallEmailYn" />
	<input type="hidden" id="hidCoreEmailYn" name="coreEmailYn" />
	
	<input type="hidden" id="hidRetailMallSmsYn" name="retailMallSmsYn" />
	<input type="hidden" id="hidCoreSmsYn" name="coreSmsYn" />
	
	<input type="hidden" id="hidDmYn" name="coreDmYn" />
	
	<!-- 부가정보 -->
	<input type="hidden" id="hidWeddingYn" name="weddingYn" value="Y"/>
	<input type="hidden" id="hidWeddingDay" name="weddingDay" />
	<input type="hidden" id="hidChildName" name="childName" />
	<input type="hidden" id="hidChildGender" name="childGender" />
	<input type="hidden" id="hidChildBirthday" name="childBirthDay" />
	<input type="hidden" id="hidChildUnar" name="childUnar" />
<!-- Hidden Value //E -->
	
	<!-- Hidden Value //E -->
</form>
</section>
</div>


<!-- 팝업 page 시작 -->
	<div data-role="popup" id="pagePopup1" data-url="pagePopup1" data-overlay-theme="a">
		<div class="popWrap">

			<div class="popHeader">
				<div class="heads">
					<h1>주소검색</h1>
					<a href="#dvwrap" class="btn_head popClose"><span class="blind">닫기</span></a>
				</div>
			</div>
			
			<div data-role="main">
				<div class="container pop" id="tabs">
					
					<div class="srchTabMenu">
						<ul>
							<li><h2><a href="javascript:changeTab('J');" id="juso_tab" class="ui-btn-active current">지번 주소로 찾기</a></h2></li>
							<li><h2><a href="javascript:changeTab('R');" id="road_tab">도로명 주소로 찾기</a></h2></li>
						</ul>
					</div><!-- // srchTabMenu -->

					<div id="popContent1" class="popContent">
						<p class="guideTxt t1">찾고자 하는 지역의 동(읍/면)명을 입력해 주세요. <br /><span class="f_point">예) 삼성동</span></p>
						<div class="addrSearch mt10">
							<fieldset>
								<div class="ui-grid-a">
									<div class="ui-block-a">
										<select class="selectBox" id="juso_sido" data-role="none">
											<option value="">시/도 선택</option>
											<option value="서울" data-code="16">서울</option>
											<option value="경기" data-code="18">경기</option>
											<option value="인천" data-code="15">인천</option>
											<option value="대전" data-code="23">대전</option>
											<option value="대구" data-code="27">대구</option>
											<option value="부산" data-code="12">부산</option>
											<option value="광주" data-code="24">광주</option>
											<option value="울산" data-code="21">울산</option>
											<option value="충북" data-code="11">충북</option>
											<option value="충남" data-code="26">충남</option>
											<option value="경북" data-code="19">경북</option>
											<option value="경남" data-code="17">경남</option>
											<option value="전북" data-code="13">전북</option>
											<option value="전남" data-code="14">전남</option>
											<option value="강원" data-code="22">강원</option>
											<option value="세종" data-code="25">세종</option>
											<option value="제주" data-code="20">제주</option>
										</select>
									</div>
									<div class="ui-block-b"><input type="text" id="searchKeyword" name="searchKeyword" class="input_text" placeholder="동/읍/면" title="동/읍/면" data-role="none" /></div>
								</div>
							</fieldset>
						</div><!-- // addrSearch -->

						<div class="btnDiv taC mt10">
							<button type="button" class="btn blue pop" onclick="javascript:searchAddr('J');"><span>조회</span></button>
						</div>
						
						<!-- 결과 리스트 -->
						<div id="div_addrList" style="display:none">
							<p class="guideTxt mt40">해당하는 주소를 선택하세요.</p>
							<div class="boardList mt10">
								<table cellspacing="0" summary="우편번호, 주소">
									<caption>목록</caption>
									<colgroup>
										<col width="110px">
										<col width="*">
									</colgroup>
									<thead>
										<tr>
											<th>우편번호</th>
											<th>주소</th>
										</tr>
									</thead>
									<tbody id="tbody_addr">
	
									</tbody>
								</table>
							</div>
						</div>
						<!-- // 결과리스트 -->
						
					</div><!-- // popContent :: popContent1 :: 지번주소로 찾기 -->

					<div id="popContent2" class="popContent" style="display:none">
						<p class="guideTxt t1">찾고자 하는 지역의 동이름 / 도로명 / 건물명을 입력해 주세요.<br /><span class="f_point">예) 삼성동 / 올림픽로 / IT 프리미엄 타워</span></p>
						<div class="addrSearch mt10">
							<fieldset>
								<div class="ui-grid-a">
									<div class="ui-block-a">
										<select class="selectBox" id="road_sido" data-role="none" onchange="javascript:getSiGunGu(this);">
											<option value="">시/도 선택</option>
											<option value="서울" data-code="16">서울</option>
											<option value="경기" data-code="18">경기</option>
											<option value="인천" data-code="15">인천</option>
											<option value="대전" data-code="23">대전</option>
											<option value="대구" data-code="27">대구</option>
											<option value="부산" data-code="12">부산</option>
											<option value="광주" data-code="24">광주</option>
											<option value="울산" data-code="21">울산</option>
											<option value="충북" data-code="11">충북</option>
											<option value="충남" data-code="26">충남</option>
											<option value="경북" data-code="19">경북</option>
											<option value="경남" data-code="17">경남</option>
											<option value="전북" data-code="13">전북</option>
											<option value="전남" data-code="14">전남</option>
											<option value="강원" data-code="22">강원</option>
											<option value="세종" data-code="25">세종</option>
											<option value="제주" data-code="20">제주</option>
										</select>
									</div>
									<div class="ui-block-b">
										<select class="selectBox" id="sigunguList" data-role="none">
											<option value="">시/군/구 선택</option>
										</select>
									</div>
								</div>
								<div class="mt10">
									<input type="text" id="roadNm" name="roadNm" class="input_text" placeholder="도로명" title="도로명" data-role="none" />
								</div>
							</fieldset>
						</div><!-- // addrSearch -->

						<div class="btnDiv taC mt10">
							<button type="button" class="btn blue pop" onclick="javascript:searchAddr('N');"><span>조회</span></button>
						</div>
						
						<!-- 결과 리스트 -->
						<div id="div_addrList2" style="display:none">
							<p class="guideTxt mt40">해당하는 주소를 선택하세요.</p>
							<div class="boardList mt10">
								<table cellspacing="0" summary="우편번호, 주소">
									<caption>목록</caption>
									<colgroup>
										<col width="110px">
										<col width="*">
									</colgroup>
									<thead>
										<tr>
											<th>우편번호</th>
											<th>주소</th>
										</tr>
									</thead>
									<tbody id="tbody_addr2">
	
									</tbody>
								</table>
							</div>
						</div>
						<!-- // 결과리스트 -->
					</div><!-- // popContent :: popContent2 :: 도로명주소로 찾기 -->
					
					
					<!-- 상세주소 입력 레이어 -->
					<div id="popContent3" class="popContent" style="display:none">
						<h3 class="guideTxt">검색된 주소</h3>
						<div class="boardList mt10">
							<table cellspacing="0" summary="우편번호, 주소">
								<caption>목록</caption>
								<colgroup>
									<col width="110px">
									<col width="*">
								</colgroup>
								<thead>
									<tr>
										<th>우편번호</th>
										<th>주소</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td><span id="span_postNo"></span></td>
										<td class="taL"><span id="span_addr"></span></td>
									</tr>
								</tbody>
							</table>
						</div><!-- // boardList -->
						<div id="div_inputDetailAddr">
							<label for="address" class="guideTxt mt15">나머지 주소를 입력해 주세요.</label>
							<input type="text" id="detailAddress" name="detailAddress" class="input_text mt10" placeholder="상세주소" title="상세주소 입력" data-role="none">
						</div>
						<div id="div_selectAddr" style="display:none">
							<p class="guideTxt mt15">저장할 주소를 선택해 주세요.</p>
							<div class="addrList">
								<ul id="ul_addrList">
								</ul>
							</div><!-- addrList -->
						</div>
						
						<div class="btnDiv taC mt10 ui-grid-a">
							<div class="ui-block-a"><button type="button" class="btn white pop ui-btn ui-shadow ui-corner-all" onclick="javascript:reSeachAddr();"><span>다시검색</span></button></div>
							<div class="ui-block-b"><button type="button" class="btn blue pop ui-btn ui-shadow ui-corner-all" onclick="javascript:confirm();"><span>확인</span></button></div>
						</div>
				
					</div>
					<!-- // 상세주소 입력 레이어 -->	
					

				</div><!-- // container -->
			</div>

		</div><!-- // popWrap -->
	</div><!-- // pagePopup1 :: 팝업 page 끝 -->
	
	



