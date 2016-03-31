<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(document).on("pageinit", "#dvwrap", function(event) {

	// 비밀번호 변경
	$(".change_pw").hide();
	$(".btn_change").click(function () {
		//$(".change_pw").toggle();
		 $(this).parent().parent().find(".change_pw").toggle().toggleClass("on");
		if (!$(this).hasClass("on")) {
			$(this).addClass("on").children().text("비밀번호 변경취소");
		} else {
			$(this).removeClass("on").children().text("비밀번호 변경");
		}
	});

	// 비밀번호 재입력
	$(".fieldTable .valid").hide();

	var checkOldPW = $("#old_pwd");
	checkOldPW.focusout(function() {
		if (checkOldPW.val() == null || checkOldPW.val() == "") {
			$("#old_valid").fadeIn().text("비밀번호 변경을 원하면 기존 비밀번호를 먼저 입력해주세요.");
			checkOldPW.focus();
		} else {
			$("#old_valid").fadeOut();
			$.ajax({
			    url: '/member/checkOldPwd',
			    type : "GET",
			    data : {'custId':"${memberInfo.custId}", 'inputOldPassword':$("#old_pwd").val()},
				async : false,
				cache : false,
			    success: function(result) {
			    	if (!result.isMatched) {
			    		$("#old_valid").fadeIn().text("기존 비밀번호가 맞지 않습니다.");
			    		checkOldPW.focus();
			    	} else {
			    		$("#old_valid").fadeOut();
			    	}
			    },
			    error: function(e) {
			    	commonAlert(e.responseText);	
			    }
			});
		}
	});
	
	var checkPW = $("#pwCheck");
	var checkPW_re = $("#pwCheck_re");
	
	checkPW.focusout(function(){
		if ($(checkPW).val() == $(checkOldPW).val()) {
			$("#em_pwdValidMsg").fadeIn().text("기존 비밀번호와 신규 비밀번호가 같습니다");
			checkPW.focus();
		}
		if ($(checkPW_re).val() != "") {
			if ($(checkPW).val()!=$(checkPW_re).val()) {
				$("#em_pwdValidMsg").fadeIn().text("비밀번호가 맞지 않습니다.");
				checkPW.focus();
			}
		}
	});

	checkPW_re.focusout(function(){
		if ($(checkPW).val() == $(checkOldPW).val()) {
			$("#em_pwdValidMsg").fadeIn().text("기존 비밀번호와 신규 비밀번호가 같습니다");
			checkPW.focus();
		} else {
			if ($(checkPW).val()!=$(checkPW_re).val()) {
				$("#em_pwdValidMsg").fadeIn().text("비밀번호가 맞지 않습니다.");
				checkPW_re.focus();
			} else {
				$.ajax({
				    url: '/member/checkbfUsedPwd',
				    type : "GET",
				    data : {'custId':"${memberInfo.custId}", 'inputPassword':$(checkPW_re).val()},
					async : false,
					cache : false,
				    success: function(result) {
				    	if (result.alreadyUsed) {
				    		$("#em_pwdValidMsg").fadeIn().text("사용했던 비밀번호는 재사용할 수 없습니다.");
				    		checkPW.focus();
				    	} else {
				    		$("#em_pwdValidMsg").fadeOut();
				    	}
				    },
				    error: function(e) {
				    	commonAlert(e.responseText);	
				    }
				});
			}
		}
		birth.push($("#inputBirth").val().replace(/-/gi, ""));
		phone.push($("#mobile").val().replace(/-/gi, ""));
		if (!validatePassword($("#pwCheck_re").val(), "${memberInfo.webId}")) {
 			$("#em_pwdValidMsg").fadeIn().text($("#em_pwdValidMsg").text());
 			checkPW.focus();
			return;
		}
	});	
	
	// 이메일 수신 모두 선택
	$("#check_email").click(function(){
		if (!$(this).hasClass("on")) {
			$(this).addClass("on").children().text("전체해제");
			$("input[name=check2]").prop("checked", true).parent().addClass("selected");
		} else {
			$(this).removeClass("on").children().text("전체선택");
			$("input[name=check2]").prop("checked", false).parent().removeClass("selected");
		}
	});
	
	// 문자 수신 모두 선택
	$("#check_sms").click(function(){
		if (!$(this).hasClass("on")) {
			$(this).addClass("on").children().text("전체해제");
			$("input[name=check3]").prop("checked", true).parent().addClass("selected");
		} else {
			$(this).removeClass("on").children().text("전체선택");
			$("input[name=check3]").prop("checked", false).parent().removeClass("selected");
		}
	});
	
	if ("10" == "${siteCode}") {
		if ("false" == "${coreJoinYn}") {
			$("#dmDiv").hide();
			$("#dmRadioDiv").hide();
			$(".childWrap").hide();
		}		
	} else {
		if ("false" == "${retailMallJoinYn}") {
			$("#select_site2").attr("disabled", true);
			$("#select_site3").attr("disabled", true);
		}
		if ("false" == "${coreJoinYn}") {
			$("#select_site2-1").attr("disabled", true);
			$("#select_site3-1").attr("disabled", true);
			
			$("#dmDiv").hide();
			$("#dmRadioDiv").hide();
			$(".childWrap").hide();
		}
	}

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
	
}); // pageinit

$(document).on("pageshow", "#dvwrap", function(event) {
	
	// 생년월일_ 양/음력
	if ("S" == "${memberInfo.birthUnar}") {
		$("#birthUnarSelect option[value=unarS]").attr("selected", true);
	} else if ("L" == "${memberInfo.birthUnar}") {
		$("#birthUnarSelect option[value=unarL]").attr("selected", true);
	} else {
		$("#birthUnarSelect option[value=unarDef]").attr("selected", true);
	}
	
	// 생년월일
	var custBirthday = "${memberInfo.birthYear}-${memberInfo.birthMonth}-${memberInfo.birthDay}";
	if (custBirthday == "--") {
		$("#inputBirth").val(custBirthday.replace(/-/gi, ""));
	} else {
		$("label[for=birth]").remove();
	}
		
	// 제휴사이트
	var retailMallJoinYn = "${retailMallJoinYn}";
	var coreJoinYn = "${coreJoinYn}";
	if ("true" == retailMallJoinYn) {
		if ("10" == "${siteCode}") {
			$("#select_site1").addClass("readonly");
			$("#select_site1").attr("disabled", true);
		}
		$("#select_site1").attr("checked", true);	
	}
	if ("true" == coreJoinYn) {
		if ("20" == "${siteCode}") {
			$("#select_site1-1").addClass("readonly");
			$("#select_site1-1").attr("disabled", true);
		}
		$("#select_site1-1").attr("checked", true);
	}
	if ("30" == "${siteCode}") {
		$("#field_partnership > .checkArea").css("border-top", "1px dashed #fff");	
		$("#field_partnership > .allCheckLine").hide();
	}
	
	// 이메일 수신
	var retailMallEmailYn = "${memberInfo.retailMallEmailYn}";
	var coreEmailYn = "${memberInfo.coreEmailYn}";
	if ("Y" == retailMallEmailYn) {
		$("#select_site2").attr("checked", true);
	} else {
		$("#select_site2").attr("checked", false);
	}	
	if ("Y" == coreEmailYn) {
		$("#select_site2-1").attr("checked", true);
	} else {
		$("#select_site2-1").attr("checked", false);
	}
	if ("Y" == retailMallEmailYn && "Y" == coreEmailYn) {
		$("#check_email").addClass("on").children().text("전체해제");
	}

	// 문자 수신
	var retailMallSmsYn = "${memberInfo.retailMallSmsYn}";
	var coreSmsYn = "${memberInfo.coreSmsYn}";
	if ("Y" == retailMallSmsYn) {
		$("#select_site3").attr("checked", true);
	} else {
		$("#select_site3").attr("checked", false);
	}	
	if ("Y" == coreSmsYn) {
		$("#select_site3-1").attr("checked", true);
	} else {
		$("#select_site3-1").attr("checked", false);
	}
	if ("Y" == retailMallSmsYn && "Y" == coreSmsYn) {
		$("#check_sms").addClass("on").children().text("전체해제");
	}
	
	// DM 수신
	if ("Y" == "${memberInfo.coreDmYn}") {
		$("#rj_dm").attr("checked", false);
		$("#dm").attr("checked", true);
	} else {
		$("#dm").attr("checked", false);
		$("#rj_dm").attr("checked", true);
	}
		
	// 결혼 유무
	if("N" == "${memberInfo.weddingYn}") {
		$("#wedding2").attr("checked", true);
		$("label[for=weddingday]").parent().hide();
		$(".childWrap").hide();
	} else {
		$("#wedding1").attr("checked", true);
	}
	
	// 결혼 기념일	
	var weddingdayStr = "${memberInfo.weddingYear}-${memberInfo.weddingMonth}-${memberInfo.weddingDay}";
	if (weddingdayStr == "--") {
		$("#weddingday").val(weddingdayStr.replace(/-/gi, ""));
	} else {
		$("#weddingday").val(weddingdayStr);
		$("label[for=weddingday]").remove();
	}
	
	// 자녀 성별 & 생일_양/음력 & 생일
	var childCnt = $(".childInfo .childDiv").size();
 	for (var i=0; i<childCnt; i++) {
 		var childGender = $(".childInfo .childDiv:eq("+i+") .element:eq(0) #hidChildGender").val();
 		var childBirthUnar = $(".childInfo .childDiv:eq("+i+") .element:eq(1) #hidChildBirthUnar").val();
 		
 		if ("M" == childGender) {
 			$("#childGenderSelBox"+(i+1)+" option[value=childGenderM]").attr("selected", true);
 		} else if ("F" == childGender) {
 			$("#childGenderSelBox"+(i+1)+" option[value=childGenderF]").attr("selected", true);
 		}
 		if ("S" == childBirthUnar) {
 			$("#childBirthUnarSelBox"+(i+1)+" option[value=childBirthS]").attr("selected", true);
 		} else if ("L" == childBirthUnar) {
 			$("#childBirthUnarSelBox"+(i+1)+" option[value=childBirthL]").attr("selected", true);
 		}
 		
 		var childBirthday = $.trim($("#childBirth"+(i+1)).val());
 		if (childBirthday != "") {
 			$("#childBirth"+(i+1)).val(childBirthday.substring(0,4)+"-"+childBirthday.substring(4,6)+"-"+childBirthday.substring(6,8));
 			$("label[for=childBirth"+(i+1)+"]").remove();
 		}
 	}
	
});

/**
 * 제휴사이트 선택 시, 수신 동의 여부도 제어
 */
function partnerSiteClick(siteNm) {
	if ("mall" == siteNm) {
  		if ($("#select_site1").is(":checked")) {
  			$("#select_site2").removeAttr("disabled");
  			$("#select_site3").removeAttr("disabled");
  			$("#select_site2").attr("checked", true);
 			$("#select_site3").attr("checked", true);
  		} else {
  			$("#select_site2").attr("disabled", true);
  			$("#select_site3").attr("disabled", true);
  		}
		allSiteAgreeBtn('email');
 		allSiteAgreeBtn('sms');
  	 } else {
  		if ($("#select_site1-1").is(":checked")) {
  			$("#select_site2-1").removeAttr("disabled");
  			$("#select_site3-1").removeAttr("disabled");
  			$("#select_site2-1").attr("checked", true);
  			$("#select_site3-1").attr("checked", true);
  			
  			$("#dmDiv").show();
			$("#dmRadioDiv").show();
			
			if ($("#wedding1").is(":checked")) {
				$(".childWrap").show();
			}
  		} else { 			
  			$("#select_site2-1").attr("disabled", true);
  			$("#select_site3-1").attr("disabled", true);
  			
  			$("#dmDiv").hide();
			$("#dmRadioDiv").hide(); 
			
			if ($("#wedding1").is(":checked")) {
				$(".childWrap").hide();
			}
  		}
		allSiteAgreeBtn('email');
 		allSiteAgreeBtn('sms');
  	 }
}

/**
 * 마케팅 정보 수신동의 버튼 제어
 */
function allSiteAgreeBtn(controlField) {
	if ("email" == controlField) {
		var emailAgreeCnt = 0;
		if ($("#select_site2").is(":checked") && !$("#select_site2").is(":disabled")) {
			emailAgreeCnt++;
		}
		if ($("#select_site2-1").is(":checked") && !$("#select_site2-1").is(":disabled")) {
			emailAgreeCnt++;
		}
		if (emailAgreeCnt == 2) {
			$("#check_email").addClass("on").children().text("전체해제");
		} else {
			$("#check_email").addClass("on").children().text("전체선택");
		}
	} else if ("sms" == controlField) {
		var smsAgreeCnt = 0;
		if ($("#select_site3").is(":checked") && !$("#select_site3").is(":disabled")) {
			smsAgreeCnt++;
		}
		if ($("#select_site3-1").is(":checked") && !$("#select_site3-1").is(":disabled")) {
			smsAgreeCnt++;
		}
		if (smsAgreeCnt == 2) {
			$("#check_sms").addClass("on").children().text("전체해제");
		} else {
			$("#check_sms").addClass("on").children().text("전체선택");
		}
	}

}

/**
 * 히든값 설정
 */
 function setHiddenValue() {
 	
 	// 비밀번호
 	if ($("#changePwdBtn").text() == "비밀번호 변경취소") {
 		if ($("#pwCheck").val() != null && $("#pwCheck").val() != "") {
 	 		$("#password").val($("#pwCheck").val());
 	 		$("#inputOldPassword").val($("#old_pwd").val());
 	 	}
 	}
 		
 	// 생년월일 양/음력
 	if ("unarS" == $("#birthUnarSelect option:selected").val()) {
 		$("#birthUnar").val("S");
 	} else if ("unarL" == $("#birthUnarSelect option:selected").val()) {
 		$("#birthUnar").val("L");
 	}
 		
 	// 생년월일 	
 	$("#birth").val($("#inputBirth").val().replace(/-/gi, ""));
 	
	// 이름
	$("#name").val("${memberInfo.membName}");
	
	// 전화번호
	$("#tel").val("${memberInfo.telNo}");
 	
 	// 핸드폰
 	$("#phone").val($("#mobile").val().replace(/-/gi, ""));
 	 
 	// 주소
	if ($("#address1_1").val() == null || $("#address1_1").val() == "") {
		var numAddrType = $("#hidAddrType").val();
		if ("1" == numAddrType) {
			$("#addrType1").val("inputJibun");
		} else if ("2" == numAddrType) {
			$("#addrType1").val("inputRoad");
		} else if ("3" == numAddrType) {
			$("#addrType1").val("jibun");
		} else if ("4" == numAddrType) {
			$("#addrType1").val("road");
		}
	
		var inputAddr1 = $("#addr1").val();
		$("#postNo1").val(inputAddr1.split(")")[0].replace("(", ""));
		$("#address1_1").val(inputAddr1.split(")")[1]);
		$("#address1_2").val($("#addr2").val());
	}
 	
 	// 이메일
 	$("#email").val($("#inputEmail").val());
 	
	// 회원 성별
	$("#gender").val("${memberInfo.gender}");
	
	// 제휴사이트
	if (!$("#select_site1").is(":checked") && !$("#select_site1-1").is(":checked")) {
		commonAlert("제휴사이트는 한 곳 이상 선택해주세요");
		return;
	} else {
		if ("false" == "${retailMallJoinYn}" && $("#select_site1").is(":checked")) {
			$("#retailMallPartnerShipYn").val("Y");
		} else if ("true" == "${retailMallJoinYn}" && !$("#select_site1").is(":checked")) {
			$("#retailMallPartnerShipYn").val("N");
		}
		if ("false" == "${coreJoinYn}" && $("#select_site1-1").is(":checked")) {
			$("#corePartnerShipYn").val("Y");
		} else if ("true" == "${coreJoinYn}" && !$("#select_site1-1").is(":checked")) {
			$("#corePartnerShipYn").val("N");
		}
	}
 	
 	// 이메일 수신 여부
 	if (!$("#select_site2").is(":disabled") && $("#select_site2").is(":checked")) {
 		$("#retailMallEmailYn").val("Y");
 	} else {
 		$("#retailMallEmailYn").val("N");
 	}
 	if (!$("#select_site2-1").is(":disabled") && $("#select_site2-1").is(":checked")) {
 		$("#coreEmailYn").val("Y");
 	} else {
 		$("#coreEmailYn").val("N");
 	}
 	
 	// SMS 수신 여부
 	if (!$("#select_site3").is(":disabled") && $("#select_site3").is(":checked")) {
 		$("#retailMallSmsYn").val("Y");
 	} else {
 		$("#retailMallSmsYn").val("N");
 	}	
 	if (!$("#select_site3-1").is(":disabled") && $("#select_site3-1").is(":checked")) {
 		$("#coreSmsYn").val("Y");
 	} else {
 		$("#coreSmsYn").val("N");
 	}
 	
 	// DM 수신 여부
 	if ($("#dmDiv").is(":visible")) {
	 	if ($("#dm").parent().is(":checked")) {
	 		$("#coreDmYn").val("Y");
	 	} else {
	 		$("#coreDmYn").val("N");
	 	}
 	}
 	
 	// 결혼유무
 	if ($("#wedding1").parent().is(":checked")) {
 		$("#weddingYn").val("Y");
 	} else if ($("#wedding2").is(":checked")) {
 		$("#weddingYn").val("N");
 	}
 	
 	// 결혼기념일
 	if("Y" == $("#weddingYn").val()) {
 		var wedDay = $("#weddingday").val().trim();
 		if (wedDay != null && wedDay != "") {
 			$("#weddingDay").val(wedDay.replace(/-/gi, ""));
 		}
 	}
		
 	// 자녀 정보
 	if("Y" == $("#weddingYn").val()) {
	 	var cNames = "";
	 	var cGenders = "";
	 	var cBirthdays = "";
	 	var cUnars = "";
	 	
	 	var nullCnt = 0;
	 	var childCnt = $(".childInfo .childDiv").size();
	 	
	 	for (var i=0; i<childCnt; i++) {
	 		var childInfos = $(".childInfo .childDiv:eq("+i+")");
	 		
	 		var childName = childInfos.find("#childName"+(i+1)).val();	
	 		if (childName != null && childName != "") {
	 			cNames += childName+",";	 			
	 		} else {
	 			nullCnt++;
	 		}
	 		
 			var childGender = $("#childGenderSelBox"+(i+1)+" option:selected").val();
 			if ("childGenderM" == childGender) {
 				cGenders += "M,";
 			} else if ("childGenderF" == childGender) {
 				cGenders += "F,";
 			}
 			
 			var childBirthUnar = $("#childBirthUnarSelBox"+(i+1)+" option:selected").val();
 			if ("childBirthS" == childBirthUnar) {
 				cUnars += "S,";
 			} else if ("childBirthL" == childBirthUnar) {
 				cUnars += "L,";
 			}
	 			
 			var childBirthday = $("#childBirth"+(i+1)).val();
 			if (childBirthday != null && childBirthday != "") {
 				cBirthdays += childBirthday.replace(/-/gi,"") + ",";	
 			} else {
 				nullCnt++;
 			}
	 				
	 	}
	 	
	 	if (nullCnt == 0) {
	 		$("#childName").val(cNames);
		 	$("#childGender").val(cGenders);
		 	$("#childBirthday").val(cBirthdays);
		 	$("#childUnar").val(cUnars);
	 	} 	
 	}
 	
 	if (($("#old_valid").is(":hidden") && $("#em_pwdValidMsg").is(":hidden"))) {
 		$("#currentSiteCode").val("${siteCode}");
	 	$("#pbpId").val("${memberInfo.pbpId}")
	 	$("#joinDate").val("${memberInfo.joinDate}");
		
		// 수정 정보 submit
	 	document.modifyForm.submit();
	} else {
		commonAlert("회원정보를 수정할 수 없습니다. 다시 확인해주세요");
		$("#pwCheck").focus();
		return;
	}
 	
}

/**
 * 입력 항목 validation
 */
function requiredCheck() {
	if ($("#birthUnarSelect option:selected").val() == "unarDef") {
		commonAlert("생일 양/음력을 선택해주세요");
		$("#birthUnarSelect").focus();
 		return;
	}
	
 	if ($("#inputBirth").val() == "") {
 		commonAlert("생년월일을 입력하여 주세요");
 		$("#inputBirth").focus();
 		return;
 	}
 	
 	if ($("#mobile").val() == "") {
 		commonAlert("핸드폰 번호를 입력하여 주세요");
 		$("#mobile").focus();
 		return;
 	} else {
 		var mobileNo = $("#mobile").val().replace(/-/gi, "");
 		if (!$.isNumeric(mobileNo)) {
 			commonAlert("핸드폰 번호를 확인하여 주세요");
 			$("#mobile").focus();
 	 		return;
 		} else {
 			var mobileNo1 = mobileNo.substring(0, 3);
 			if ("010" == mobileNo1) {
 				var mobileNo2 = mobileNo.substring(3, 7);
 				if (mobileNo2.length != 4) {
 					commonAlert("핸드폰 번호를 확인하여 주세요");
 					$("#mobile").focus();
 		 	 		return;
 				} else {
 					var mobileNo3 = mobileNo.substring(7, 11);
 					if (mobileNo3.length != 4) {
 	 					commonAlert("핸드폰 번호를 확인하여 주세요");
 	 					$("#mobile").focus();
 	 		 	 		return;
 					}
 				}
 				
 			} else {
 				if (mobileNo.length < 10 || mobileNo.length > 11) {
 					commonAlert("핸드폰 번호를 확인하여 주세요");
 					$("#mobile").focus();
	 		 	 	return;
 				}
 			}
 		}
 	}
 	
 	if ($("#addr2").val() == "") {
 		commonAlert("주소를 입력하여 주세요");
 		$("#addr2").focus();
 		return;
 	}
 	
 	if ($("#inputEmail").val() == "") {
 		commonAlert("이메일를 입력하여 주세요");
 		$("#inputEmail").focus();
 		return;
 	} else {
 		var emailAddr = $("#inputEmail").val();
 		if (emailAddr.indexOf("@") < 0) {
 			commonAlert("이메일를 확인하여 주세요");
 			$("#inputEmail").focus();
 	 		return;
 		}
 		if (emailAddr.indexOf(".com") < 0) {
 			if (emailAddr.indexOf(".co.kr") < 0) {
 				if (emailAddr.indexOf("net") < 0) {
 					commonAlert("이메일를 확인하여 주세요");
 					$("#inputEmail").focus();
 		 	 		return;
 				}
 			}
 		}
 	}
 	
 	if ($("#changePwdBtn").text() == "비밀번호 변경취소") {
		if ($("#pwCheck_re").val() != null && $("#pwCheck_re").val() != "") {
			birth.push($("#inputBirth").val().replace(/-/gi, ""));
			phone.push($("#mobile").val().replace(/-/gi, ""));
			
	 		if (!validatePassword($("#pwCheck_re").val(), "${memberInfo.webId}")) {
	 			commonAlert("비밀번호를 다시 확인해주세요.");
	 			$("#pwCheck").focus();
	 			return;
	 		};
	 	}
 	}
 	
 	setHiddenValue();
}

/**
 * 주소 찾기 팝업 띄우기
 */
function searchAddr() {
 	openCommonPopup("/member/searchAddrPopup", "", "", "", "주소 찾기");
}

/**
 * 주소 찾기 팝업에서 넘어오는 값 세팅
 */
function setAddr(addrList) { 
	for (var i=0; i< addrList.length; i++) {
		if (i == 0) {
			$("#addr1").val("(" + addrList[i].postNo + ")" + addrList[i].addr);
			$("#addr2").val(addrList[i].addr2);
			 
			$("#address1_1").val(addrList[i].addr);
			$("#address1_2").val(addrList[i].addr2);
			$("#postNo1").val(addrList[i].postNo);
			$("#addrType1").val(addrList[i].addrType);
		} else {
			$("#address"+(i+1)+"_1").val(addrList[i].addr);
			$("#address"+(i+1)+"_2").val(addrList[i].addr2);
			$("#postNo"+(i+1)).val(addrList[i].postNo);
			$("#addrType"+(i+1)).val(addrList[i].addrType);
		}
	}
}

/**
 * 결혼 유무 변경
 */
function chgWeddingYn(wedType) {
	if ("married" == wedType) {
 		$("#wedding2").attr("checked", false);
 		$("#wedding1").attr("checked", true);
 		if ("10" == "${siteCode}") {
 			$("label[for=weddingday]").parent().show();
 			if (!$("#select_site1-1").is(":checked")) {
 				$(".childWrap").hide();
 			} else {
 				$(".childWrap").show();
 			}
 			
 		} else {
 			if (!$("#select_site1-1").is(":checked")) {
 				$("label[for=weddingday]").parent().show();
 				$(".childWrap").hide();
 			} else {
 				$("label[for=weddingday]").parent().show();
 				$(".childWrap").show();
 			}			
 		}		
 		
 	} else {
 		$("#wedding1").attr("checked", false);
 		$("#wedding2").attr("checked", true);
 		$("label[for=weddingday]").parent().hide();
 		$(".childWrap").hide();
 	} 	
}

/**
 * 자녀 정보 추가
 */
function addChildDiv() {
 	var divCount = $(".childInfo > .childDiv").size() + 1;
 	
 	var strHtml = "";
 	strHtml += '<div class="childDiv">';
 	strHtml += '	<div class="tit">';
 	strHtml += '		<strong>자녀정보</strong><button type="button" class="btn white w40 childRemove" onclick="removeChildDiv(this);"><span>삭제</span></button>';
 	strHtml += '	</div>';
 	strHtml += '	<div class="element">';
 	strHtml += '		<div class="ui-grid-a">';
 	strHtml += '			<div class="ui-block-a w30">';
 	strHtml += '				<select class="selectBox" id="childGenderSelBox'+divCount+'" data-role="none">';
 	strHtml += '					<option value="childGenderDef">선택</option>';
 	strHtml += '					<option value="childGenderM">남</option>';
 	strHtml += '					<option value="childGenderF">여</option>';
	strHtml += '				</select>'; 	
 	strHtml += '			</div>';
 	strHtml += '			<div class="ui-block-b w70">';
 	strHtml += '				<input type="text" id="childName'+divCount+'" name="childName'+divCount+'" class="input_text" placeholder="이름" data-role="none" />';
 	strHtml += '			</div>';
 	strHtml += '		</div>';	
 	strHtml += '	</div><!-- // element -->';
 	strHtml += '	<div class="element">';
 	strHtml += '		<div class="ui-grid-a">';
 	strHtml += '			<div class="ui-block-a w30">';
 	strHtml += '				<select class="selectBox" id="childBirthUnarSelBox'+divCount+'" data-role="none">';
 	strHtml += '					<option value="childBirthDef">선택</option>';
 	strHtml += '					<option value="childBirthS">양력</option>';
	strHtml += '					<option value="childBirthL">음력</option>';		
 	strHtml += '				</select>';
 	strHtml += '			</div>';
 	strHtml += '			<div class="ui-block-b w70">';
 	strHtml += '				<div class="placeholderBox">';
 	strHtml += '					<label for="childBirth'+divCount+'" class="placeholder">생년월일</label>';
 	strHtml += '					<input type="date" id="childBirth'+divCount+'" name="childBirth'+divCount+'" class="input_text" placeholder="생년월일" data-role="none" />';
	strHtml += '				</div>';
	strHtml += '			</div>';
 	strHtml += '		</div>';
 	strHtml += '	</div><!-- // element -->';
 	strHtml += '</div><!-- // childDiv -->';
 	
 	$(".childInfo").append(strHtml);
 	
 	var select = $("select.select");
 	select.change(function(){
 		var select_name = $(this).children("option:selected").text();
 		$(this).siblings("label").text(select_name);
 	}); 	
 	
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

/**
  * 자녀 정보 삭제
  */
function removeChildDiv(args) {
	$(args).parent().parent().remove();
}

/**
 * 회원정보 수정 취소
 */
function modifyCancel() {
	commonConfirm("회원정보 수정을 취소하시겠습니까?", goToMain);
}

function goToMain() {
	if ("30" == "${siteCode}") {
 		location.replace("/");
 	} else {
 		location.replace("${returnUrl}");
 	}
}

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
			return;
		}
		if (schNm == "") {
			commonAlert("읍/면/동을 입력해주세요.");
			return;
		}
		// 주소찾기
		searchPostNo("${elandmallUrl}", "J", cityNm, "", schNm);
	} else if ("N" == param) {
		var cityNm = $("#road_sido option:selected").val();
		var guNm = $("#sigunguList option:selected").val();
		var roadNm = $("#roadNm").val();
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
			 strHtml += "<p class='taC'>우편번호 검색 결과가 없습니다.<br>동/읍/면을 입력해 주세요</p>";
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
		return;
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
	$("#buildingNo").val("");
	$("#buildingNm").val("");
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
	
	if ($("#div_selectAddr").css("display") ==  "block") {
		popupClose();
		
		var selectAddr = $(':radio[name="radio-item"]:checked').closest("li").children("div.addr").data("addr");
		var selectAddr2 = $(':radio[name="radio-item"]:checked').closest("li").children("div.addr").data("addr2");
		var postNo = $(':radio[name="radio-item"]:checked').closest("li").children("div.addr").children(".post").text();
		
		$("#addr1").val("("+postNo+")"+selectAddr);
		$("#addr2").val(selectAddr2);
		
		resetAddrForm();
		return;
	}
	
	
	if ($("#detailAddress").val() == "") {
		commonAlert("상세주소를 입력해주세요.");
		return;
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
		strHtml += '<div class="slct"><input type="radio" id="radio-item-0" name="radio-item" class="radioBtn"><label for="radio-item-0" class="label_txt">입력주소</label></div>';
		strHtml += '<div class="addr" data-addr="'+$("#span_addr").text()+'" data-addr2="'+$("#detailAddress").val()+'"><span class="post">'+$("#span_postNo").text()+'</span><p>'+$("#span_addr").text()+' '+$("#detailAddress").val() +'</p></div>';
		strHtml += '</li>';
		
		// 1:1 매핑일때 자동 설정 (자식노드의 지번, 도로명 사용) 
		if (RCD3 == 'I' || RCD3 == 'H') {
			strHtml += '<li>';
			strHtml += '<div class="slct"><span class="customRadio"><input type="radio" id="radio-item-2" name="radio-item" class="radioBtn"></span><label for="radio-item-2" class="label_txt">표준번지주소</label></div>';
			strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[1].ADDR1H+'" data-addr2="'+obj.convertAddr.DATA[1].STDADDR+'"><span class="post">'+obj.convertAddr.DATA[1].ZIPM6+'</span><p>'+obj.convertAddr.DATA[1].ADDR1H+""+obj.convertAddr.DATA[1].STDADDR+'</p></div>';
			strHtml += '</li>';
			strHtml += '<li>';
			strHtml += '<div class="slct"><span class="customRadio"><input type="radio" id="radio-item-3" name="radio-item" class="radioBtn"></span><label for="radio-item-3" class="label_txt">도로명주소</label></div>';
			strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[1].NADR1+'" data-addr2="'+obj.convertAddr.DATA[1].NBKM+'-'+obj.convertAddr.DATA[1].NBKS+" "+obj.convertAddr.DATA[1].NADREM+" "+obj.convertAddr.DATA[1].NADR3S+'"><span class="post">'+obj.convertAddr.DATA[1].ZIPM6+'</span><p>'+obj.convertAddr.DATA[1].NADR1S +""+obj.convertAddr.DATA[1].NADREM +""+obj.convertAddr.DATA[1].NADR3S +'</p></div>';
			strHtml += '</li>';
		// 멀티 선택 케이스 (지번은 부모노드, 도로명은 자식 노드 사용)
		} else if(RCD3 == 'C' || RCD3 == 'D' || RCD3 == 'E' || RCD3 == 'F' || RCD3 == 'G') {
			for (var i=0; i < obj.convertAddr.DATA.length; i++) {
				if (obj.convertAddr.DATA[i].NODE == "D") {
					strHtml += '<li>';
					strHtml += '<div class="slct"><span class="customRadio"><input type="radio" id="radio-item-'+(i+1)+'" name="radio-item" class="radioBtn"></span><label for="radio-item-'+(i+1)+'" class="label_txt">표준번지주소</label></div>';
					strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[i].ADDR1H+'" data-addr2="'+obj.convertAddr.DATA[i].STDADDR+'"><span class="post">'+obj.convertAddr.DATA[i].ZIPM6+'</span><p>'+obj.convertAddr.DATA[i].ADDR1H+""+obj.convertAddr.DATA[i].STDADDR+'</p></div>';
					strHtml += '</li>';	
				}
				if (obj.convertAddr.DATA[i].NODE == "P") {
					strHtml += '<li>';
					strHtml += '<div class="slct"><span class="customRadio"><input type="radio" id="radio-item-'+(i+1)+'" name="radio-item" class="radioBtn"></span><label for="radio-item-'+(i+1)+'" class="label_txt">도로명주소</label></div>';
					strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[i].NADR1+'" data-addr2="'+obj.convertAddr.DATA[i].NBKM+'-'+obj.convertAddr.DATA[i].NBKS+" "+obj.convertAddr.DATA[i].NADREM+'"><span class="post">'+obj.convertAddr.DATA[i].ZIPM6+'</span><p>'+obj.convertAddr.DATA[i].NADR1S +""+obj.convertAddr.DATA[i].NADREM +'</p></div>';
					strHtml += '</li>';
				}
			}
			
		// 지번주소만 정제 성공 케이스
		} else if(RCD3 == '6' || RCD3 == '8') {
			strHtml += '<li>';
			strHtml += '<div class="slct"><span class="customRadio"><input type="radio" id="radio-item-'+(i+1)+'" name="radio-item" class="radioBtn"></span><label for="radio-item-'+(i+1)+'" class="label_txt">표준번지주소</label></div>';
			strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[0].ADDR1H+'" data-addr2="'+obj.convertAddr.DATA[0].STDADDR+'"><span class="post">'+obj.convertAddr.DATA[0].ZIPM6+'</span><p>'+obj.convertAddr.DATA[0].ADDR1H+""+obj.convertAddr.DATA[0].STDADDR+'</p></div>';
			strHtml += '</li>';
//	 		strHtml += '<li>';
//	 		strHtml += '<div class="slct"><span class="customRadio"><input type="radio" id="radio-item-'+(i+1)+'" name="radio-item" class="radioBtn"></span><label for="radio-item-'+(i+1)+'" class="label_txt">도로명주소</label></div>';
//	 		strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[0].NADR1+'" data-addr2="'+obj.convertAddr.DATA[0].NBKM+'-'+obj.convertAddr.DATA[0].NBKS+" "+obj.convertAddr.DATA[0].NADREM+'"><span class="post">'+obj.convertAddr.DATA[0].ZIPM6+'</span><p>'+obj.convertAddr.DATA[0].NADR1S +""+obj.convertAddr.DATA[0].NADREM +'</p></div>';
//	 		strHtml += '</li>';
		// 통신장애 케이스
		} else if(RCD3 == 'EXP') {
			
		}
			
		
		$("#ul_addrList").append(strHtml);
		
		$("#div_inputDetailAddr").hide();
		$("#div_selectAddr").show();
		
	}
 
 function popupClose() {
		$('#pagePopup1').popup("close");
		$('#pagePopup2').popup("close");
		
		$("#juso_tab").addClass("ui-btn-active");
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
				<span class="current">회원정보 수정</span>
			</div>
		</div><!-- // lineMap -->

		<div class="content inner">
			
			<!-- 기본정보 입력 -->
			<form action="/member/updateMemberSuccess" name="modifyForm" id="modifyForm" method="POST">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<div class="fieldDiv bLine mt15">
					<fieldset>
						<legend class="tit_bl">기본정보</legend>
						<p class="guide"><span class="ns"></span>필수입력항목</p>
						<div class="elemWrap">
							<div class="element">
								<label for="">이름</label>
								<input type="text" id="" name="" class="input_text" data-role="none" readonly value="${memberInfo.membName}" />
							</div><!-- // element -->
							<div class="element">
								<label for="">회원아이디</label>
								<input type="text" id="" name="" class="input_text" data-role="none" readonly value="${memberInfo.webId}" />
							</div><!-- // element -->
	
							<!-- 비밀번호 변경 -->
							<div class="passwordDiv">
								<div class="element">
									<button id="changePwdBtn" type="button" class="btn grey btn_change"><span>비밀번호 변경</span></button>
								</div><!-- // element -->
								<div class="change_pw">
									<div class="element">
										<span class="ns" title="필수입력"></span>
										<label for="pw">기존 비밀번호</label>
										<input type="password" id="old_pwd" name="old_pwd" class="input_text check" placeholder="기존 비밀번호" data-role="none" /><em id='old_valid' class='fail'></em>
									</div><!-- // element -->
									<div class="element">
										<span class="ns" title="필수입력"></span>
										<label for="pwCheck">신규 비밀번호</label>
										<input type="password" id="pwCheck" name="pwCheck" class="input_text check" placeholder="신규 비밀번호" data-role="none" />
									</div><!-- // element -->
									<div class="element">
										<span class="ns" title="필수입력"></span>
										<label for="pwCheck_re">신규 비밀번호 재입력</label>
										<input type="password" id="pwCheck_re" name="pwCheck_re" class="input_text check" placeholder="신규 비밀번호 재입력" data-role="none" /><em id='em_pwdValidMsg' class='fail'></em>
										<em class="valid"></em>
									</div><!-- // element -->
									<div class="warn">
										연속적인 숫자나 생일, 전화번호등 추측하기 쉬운 개인정보 및 아이디와 비슷한 비밀번호 사용을 피하시기 바랍니다.<br />비밀번호는 영대문자, 영소문자, 숫자, 특	수문자 중 3종류 이상을 조합하여, 총 8~16자리로 구성하셔야 합니다.
									</div><!-- // warn -->
								</div><!-- // pwChange -->
							</div><!-- // passwordDiv -->
							<!-- // 비밀번호 변경 -->
	
							<div class="element">
								<div class="ui-grid-a">
									<div class="ui-block-a w30">
										<span class="ns" title="필수입력"></span>
										<select class="selectBox check" id="birthUnarSelect" data-role="none">
											<option value="unarDef">선택</option>
											<option value="unarS">양력</option>
											<option value="unarL">음력</option>										
										</select>
									</div>
									<div class="ui-block-b w70 placeholderBox">
										<label for="birth" class="placeholder">생년월일</label>
										<input type="date" id="inputBirth" name="inputBirth" class="input_text" value="${memberInfo.birthYear}-${memberInfo.birthMonth}-${memberInfo.birthDay}" data-role="none" placeholder="생년월일"/>
									</div>
								</div>
							</div><!-- // element -->
							<div class="element">
								<span class="ns" title="필수입력"></span>
								<label for="mobile">${memberInfo.mobileNo1}-${memberInfo.mobileNo2}-${memberInfo.mobileNo3}</label>
								<input type="tel" id="mobile" name="mobile" class="input_text check" value="${memberInfo.mobileNo1}-${memberInfo.mobileNo2}-${memberInfo.mobileNo3}" data-role="none" />
							</div><!-- // element -->
							<div class="element">
								<div class="block">
									<span class="ns" title="필수입력"></span>
									<label for="">주소</label>
									<input type="text" id="addr1" name="addr1" class="input_text check" disabled value="(${memberInfo.zipCode})${memberInfo.addr1}" data-role="none" />
									<a href="#pagePopup1" data-rel="popup" data-transition="fade" class="btn grey ui-link"><span>주소찾기</span></a>
								</div>
								<div class="elem mt10">
									<span class="ns" title="필수입력"></span>
									<label for="">상세주소</label>
									<input type="text" id="addr2" name="addr2" class="input_text check" value="${memberInfo.addr2}" data-role="none" />
									<input type="hidden" id="hidAddrType" name="hidAddrType" value="${memberInfo.selectAddr}" />
								</div>
							</div><!-- // element -->
							<div class="element">
								<span class="ns" title="필수입력"></span>
								<label for="email">${memberInfo.email1}@${memberInfo.email2}</label>
								<input type="email" id="inputEmail" name="inputEmail" class="input_text check" value="${memberInfo.email1}@${memberInfo.email2}" data-role="none" />
							</div><!-- // element -->
						</div><!-- // elemWrap -->
					</fieldset>
				</div><!-- // fieldDiv :: 기본정보 입력 -->
				
				<!-- 이랜드리테일 제휴 사이트 선택 -->
				<div class="fieldDiv mt15">
					<fieldset id="field_partnership">
						<legend class="tit_bl">이랜드리테일 제휴 사이트 선택</legend>
						<div class="allCheckLine">
							<c:choose>
								<c:when test="${10 eq siteCode}">
									<span class="chk fl">
										<input type="checkbox" id="select_site1" name="partnerShip" class="checkBox" data-role="none" onclick="javascript:partnerSiteClick('mall');"/><label for="select_site1" class="label_txt"><spring:message code="name.elandmall" /></label>
									</span>
								</c:when>
								<c:when test="${20 eq siteCode}">
									<span class="chk fl">
										<input type="checkbox" id="select_site1-1" name="partnerShip" class="checkBox" data-role="none" onclick="javascript:partnerSiteClick('core');"/><label for="select_site1-1" class="label_txt"><spring:message code="name.elandretail" /></label>
									</span>
								</c:when>
							</c:choose>
<!-- 							<button type="button" class="btn white w60" id="check_email"><span>전체선택</span></button> -->
						</div>
						<div class="checkArea">
							<c:choose>
								<c:when test="${10 eq siteCode}">
									<span class="chk">
										<input type="checkbox" id="select_site1-1" name="partnerShip" class="checkBox" data-role="none" onclick="javascript:partnerSiteClick('core');"/><label for="select_site1-1" class="label_txt"><spring:message code="name.elandretail" /></label>
									</span>
								</c:when>
								<c:when test="${20 eq siteCode}">
									<span class="chk">
										<input type="checkbox" id="select_site1" name="partnerShip" class="checkBox" data-role="none" onclick="javascript:partnerSiteClick('mall');"/><label for="select_site1" class="label_txt"><spring:message code="name.elandmall" /></label>
									</span>
								</c:when>
								<c:when test="${30 eq siteCode}">
									<span class="chk">
										<input type="checkbox" id="select_site1" name="partnerShip" class="checkBox" data-role="none" onclick="javascript:partnerSiteClick('mall');"/><label for="select_site1" class="label_txt"><spring:message code="name.elandmall" /></label>
									</span>
									<span class="chk">
										<input type="checkbox" id="select_site1-1" name="partnerShip" class="checkBox" data-role="none" onclick="javascript:partnerSiteClick('core');"/><label for="select_site1-1" class="label_txt"><spring:message code="name.elandretail" /></label>										
									</span>
								</c:when>
							</c:choose>
						</div><!-- // checkArea -->	
					</fieldset>
				</div><!-- // fieldDiv :: 이랜드리테일 제휴 사이트 선택 -->				
	
				<!-- 마케팅 정보 수신동의 -->
				<div class="fieldDiv mt15">
					<fieldset id="field_agreement">
						<legend class="tit_bl">마케팅 정보 수신동의</legend>
						<div class="tit mt5"><strong>이메일 수신</strong></div>
						<div class="allCheckLine">
							<c:choose>
								<c:when test="${10 eq siteCode}">
									<span class="chk fl">
										<input type="checkbox" id="select_site2" name="check2" class="checkBox" data-role="none" onclick="allSiteAgreeBtn('email');" /><label for="select_site2" class="label_txt"><spring:message code="name.elandmall" /></label>
									</span>
								</c:when>
								<c:when test="${20 eq siteCode}">
									<span class="chk fl">
										<input type="checkbox" id="select_site2-1" name="check2" class="checkBox" data-role="none" onclick="allSiteAgreeBtn('email');" /><label for="select_site2-1" class="label_txt"><spring:message code="name.elandretail" /></label>
									</span>
								</c:when>
							</c:choose>
							<button type="button" class="btn white w60" id="check_email"><span>전체선택</span></button>
						</div>
						<div class="checkArea">
							<c:choose>
								<c:when test="${10 eq siteCode}">
									<span class="chk">
										<input type="checkbox" id="select_site2-1" name="check2" class="checkBox" data-role="none" onclick="allSiteAgreeBtn('email');" /><label for="select_site2-1" class="label_txt"><spring:message code="name.elandretail" /></label>
									</span>
								</c:when>
								<c:when test="${20 eq siteCode}">
									<span class="chk">
										<input type="checkbox" id="select_site2" name="check2" class="checkBox" data-role="none" onclick="allSiteAgreeBtn('email');" /><label for="select_site2" class="label_txt"><spring:message code="name.elandmall" /></label>
									</span>
								</c:when>
								<c:when test="${30 eq siteCode}">
									<span class="chk">
										<input type="checkbox" id="select_site2" name="check2" class="checkBox" data-role="none" onclick="allSiteAgreeBtn('email');" /><label for="select_site2" class="label_txt"><spring:message code="name.elandmall" /></label>
									</span>
									<span class="chk">
										<input type="checkbox" id="select_site2-1" name="check2" class="checkBox" data-role="none" onclick="allSiteAgreeBtn('email');" /><label for="select_site2-1" class="label_txt"><spring:message code="name.elandretail" /></label>
									</span>
								</c:when>								
							</c:choose>
						</div><!-- // checkArea -->					
						<!-- // 이메일 수신 -->
	
						<div class="tit mt5"><strong>문자 수신</strong></div>
						<div class="allCheckLine">
							<c:choose>
								<c:when test="${10 eq siteCode}">
									<span class="chk fl">
										<input type="checkbox" id="select_site3" name="check3" class="checkBox" data-role="none" onclick="allSiteAgreeBtn('sms');" /><label for="select_site3" class="label_txt"><spring:message code="name.elandmall" /></label>
									</span>
								</c:when>
								<c:when test="${20 eq siteCode}">
									<span class="chk fl">
										<input type="checkbox" id="select_site3-1" name="check3" class="checkBox" data-role="none" onclick="allSiteAgreeBtn('sms');" /><label for="select_site3-1" class="label_txt"><spring:message code="name.elandretail" /></label>
									</span>
								</c:when>
							</c:choose>
							<button type="button" class="btn white w60" id="check_sms"><span>전체선택</span></button>
						</div>
						<div class="checkArea">
							<c:choose>
								<c:when test="${10 eq siteCode}">
									<span class="chk">
										<input type="checkbox" id="select_site3-1" name="check3" class="checkBox" data-role="none" onclick="allSiteAgreeBtn('sms');" /><label for="select_site3-1" class="label_txt"><spring:message code="name.elandretail" /></label>
									</span>
								</c:when>
								<c:when test="${20 eq siteCode}">
									<span class="chk">
										<input type="checkbox" id="select_site3" name="check3" class="checkBox" data-role="none" onclick="allSiteAgreeBtn('sms');" /><label for="select_site3" class="label_txt"><spring:message code="name.elandmall" /></label>
									</span>
								</c:when>
								<c:when test="${30 eq siteCode}">
									<span class="chk">
										<input type="checkbox" id="select_site3" name="check3" class="checkBox" data-role="none" onclick="allSiteAgreeBtn('sms');" /><label for="select_site3" class="label_txt"><spring:message code="name.elandmall" /></label>
									</span>
									<span class="chk">
										<input type="checkbox" id="select_site3-1" name="check3" class="checkBox" data-role="none" onclick="allSiteAgreeBtn('sms');" /><label for="select_site3-1" class="label_txt"><spring:message code="name.elandretail" /></label>
									</span>
								</c:when>								
							</c:choose>
						</div><!-- // checkArea -->				
						<!-- // 문자 수신 -->
	
						<div id="dmDiv" class="tit mt5"><strong>DM 수신</strong></div>
						<div id="dmRadioDiv" class="radioArea">
							<div class="chkLine"><input type="radio" id="dm" name="radio1" class="radioBtn" data-role="none" /><label for="dm1" class="label_txt">우편수신</label></div>
							<div class="chkLine"><input type="radio" id="rj_dm" name="radio1" class="radioBtn" data-role="none" /><label for="rj_dm" class="label_txt">수신안함</label></div>
						</div><!-- // radioArea -->
						<!-- // DM 수신 -->
					</fieldset>
				</div><!-- // fieldDiv :: 마케팅 정보 수신동의 -->
	
	
				<!-- 부가정보 -->
				<div class="fieldDiv bLine mt15">
					<fieldset>
						<legend class="tit_bl">부가정보</legend>
						<div id="weddingYnRadioDiv" class="radioArea">
							<span class="chk"><input type="radio" id="wedding1" name="radio2" class="radioBtn" data-role="none" onclick="javascript:chgWeddingYn('married');" /><label for="wedding1" class="label_txt">기혼</label></span>
							<span class="chk"><input type="radio" id="wedding2" name="radio2" class="radioBtn" data-role="none" onclick="javascript:chgWeddingYn('single');" /><label for="wedding2" class="label_txt">미혼</label></span>
						</div><!-- // radioArea -->
						<div class="element m1 placeholderBox">
							<label for="weddingday" class="placeholder">결혼기념일</label>
							<input type="date" id="weddingday" name="weddingday" class="input_text" data-role="none" value="" placeholder="결혼기념일"/>
						</div><!-- // element -->
						
						<!-- 자녀정보 -->
						<div class="childWrap mt5">
							<div class="tit">
								<strong>자녀정보</strong>
								<button type="button" class="btn white w40 childAdd" title="추가" onclick="addChildDiv();"><span>추가</span></button>
							</div>
	
							<div class="childInfo">
								<c:forEach var="childs" items="${memberInfo.children}" varStatus="i">
									<div class="childDiv">
										<div class="tit">
											<strong>자녀정보</strong><button type="button" class="btn white w40 childRemove" onclick="removeChildDiv(this);"><span>삭제</span></button>
										</div>
										<div class="element">
											<div class="ui-grid-a">
												<div class="ui-block-a w30">
													<select class="selectBox" id="childGenderSelBox${i.index+1}" data-role="none">
														<option value="childGenderDef">선택</option>
														<option value="childGenderM">남</option>
														<option value="childGenderF">여</option>													
													</select>
													<input type="hidden" id="hidChildGender" name="hidChildGender" value="${childs.childGender}" />
												</div>
												<div class="ui-block-b w70">
													<input type="text" id="childName${i.index+1}" name="childName${i.index+1}" class="input_text" placeholder="이름" data-role="none" value="${childs.childName}" />
												</div>
											</div>
										</div><!-- // element -->
										<div class="element">
											<div class="ui-grid-a">
												<div class="ui-block-a w30">
													<select class="selectBox" id="childBirthUnarSelBox${i.index+1}" data-role="none">
														<option value="childBirthDef">선택</option>
														<option value="childBirthS">양력</option>
														<option value="childBirthL">음력</option>							
													</select>
													<input type="hidden" id="hidChildBirthUnar" name="hidChildBirthUnar" value="${childs.childUnar}" />
												</div>
												<div class="ui-block-b w70">
													<div class="placeholderBox">
														<label for="childBirth${i.index+1}" class="placeholder">${childs.childBirthYear}년 ${childs.childBirthMonth}월 ${childs.childBirthDay}일</label>
														<input type="date" id="childBirth${i.index+1}" name="childBirth${i.index+1}" class="input_text" placeholder="생년월일" data-role="none" value="${childs.childBirthYear}${childs.childBirthMonth}${childs.childBirthDay}" />
													</div>
												</div>
											</div>
										</div><!-- // element -->
									</div><!-- // childDiv -->
								</c:forEach>
							</div><!-- // childInfo -->
	
						</div><!-- // childWrap :: 자녀정보 -->
					</fieldset>
				</div><!-- // fieldDiv :: 부가정보 -->
			
				<input type="hidden" id="custId" name="custId" value="${memberInfo.custId}" />
				<input type="hidden" id="webId" name="webId" value="${memberInfo.webId}" />
				<input type="hidden" id="password" name="password" />
				<input type="hidden" id="inputOldPassword" name="inputOldPassword" />
				<input type="hidden" id="name" name="name" />
				<input type="hidden" id="birth" name="birth" />
				<input type="hidden" id="birthUnar" name="birthUnar" />
				<input type="hidden" id="tel" name="tel" />
				<input type="hidden" id="phone" name="phone" />
				<input type="hidden" id="gender" name="gender" />
				<input type="hidden" id="pbpId" name="pbpId" />
				<input type="hidden" id="joinDate" name="joinDate" />
				
				<input type="hidden" id="address1_1" name="address1_1" />
				<input type="hidden" id="address1_2" name="address1_2" />
				<input type="hidden" id="postNo1" name="postNo1" />
				<input type="hidden" id="addrType1" name="addrType1" />
				
				<input type="hidden" id="address2_1" name="address2_1" />
				<input type="hidden" id="address2_2" name="address2_2" />
				<input type="hidden" id="postNo2" name="postNo2" />
				<input type="hidden" id="addrType2" name="addrType2" />
				
				<input type="hidden" id="address3_1" name="address3_1" />
				<input type="hidden" id="address3_2" name="address3_2" />
				<input type="hidden" id="postNo3" name="postNo3" />
				<input type="hidden" id="addrType3" name="addrType3" />
		
				<input type="hidden" id="email" name="email" />
				
				<input type="hidden" id="retailMallPartnerShipYn" name="retailMallPartnerShipYn" />
				<input type="hidden" id="corePartnerShipYn" name="corePartnerShipYn" />		
				
				<input type="hidden" id="retailMallEmailYn" name="retailMallEmailYn" />
				<input type="hidden" id="coreEmailYn" name="coreEmailYn" />
				<input type="hidden" id="retailMallSmsYn" name="retailMallSmsYn" />
				<input type="hidden" id="coreSmsYn" name="coreSmsYn" />
				<input type="hidden" id="coreDmYn" name="coreDmYn" />
				
				<input type="hidden" id="weddingYn" name="weddingYn" />
				<input type="hidden" id="weddingDay" name="weddingDay" />
				
				<input type="hidden" id="childName" name="childName" />
				<input type="hidden" id="childGender" name="childGender" />
				<input type="hidden" id="childBirthday" name="childBirthday" />
				<input type="hidden" id="childUnar" name="childUnar" />
				
				<input type="hidden" id="currentSiteCode" name="currentSiteCode" />
				<input type="hidden" id="updateSiteCode" name="updateSiteCode" />
			</form>

			<div class="btnDiv taC mt20 ui-grid-a">
				<div class="ui-block-a"><a href="javascript:modifyCancel();" class="btn white large"><span>취소</span></a></div>
				<div class="ui-block-b"><button type="button" class="btn blue large" onclick="requiredCheck();"><span>수정완료</span></button></div>
			</div>

		</div><!-- // content -->

	</section>
</div><!-- // container -->

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

	