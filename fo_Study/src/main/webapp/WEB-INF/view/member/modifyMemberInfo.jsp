<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(document).ready(function () {
	$("#li_member > a").addClass("current");
	$("#li_updateMember > a").addClass("current");
	var strHtml = "<a href='/member/updateMember'><span>회원정보</span></a><span class='current'>회원정보 수정</span>";
	$("#header_path").append(strHtml);
	
	$('.open_modal').modalLayer();
	
	// 라디오, 체크박스
	customCheckbox();
	customRadio();
	
	// 연,월,일 selectBox 생성
	setSelectBox("", "", "");
	
	// 비밀번호 변경
	$(".change_pw").hide();
	$(".btn_change").click(function () {
		//$(".change_pw").toggle();
		 $(this).parent().parent().siblings(".change_pw").toggle().toggleClass("on");
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
			    	alert(e.responseText);	
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
		if($(checkPW_re).val() != "") {
			if ($(checkPW).val() != $(checkPW_re).val()) {
				$("#em_pwdValidMsg").fadeIn().text("비밀번호가 맞지 않습니다.");
				checkPW.focus();
			} else {
				$("#em_pwdValidMsg").fadeOut();
			}
		}
	});

	checkPW_re.focusout(function(){
		if ($(checkPW).val() == $(checkOldPW).val()) {
			$("#em_pwdValidMsg").fadeIn().text("기존 비밀번호와 신규 비밀번호가 같습니다");
			checkPW.focus();
		} else {
			if ($(checkPW).val() != $(checkPW_re).val()) {
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
				    	alert(e.responseText);	
				    }
				});
			}
		}
		birth.push($("#year option:selected").val(), $("#month option:selected").val()+$("#day option:selected").val());
		phone.push($("#phoneNumber2").val(), $("#phoneNumber3").val());
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
			$("#dmTr").hide();
			$("#childrensTr").hide();
		}
	} else {
		if ("false" == "${retailMallJoinYn}") {
			$("#select_site2").parent().addClass("readonly");
			$("#select_site2").attr("disabled", true);
			$("#select_site3").parent().addClass("readonly");
			$("#select_site3").attr("disabled", true);
		}
		if ("false" == "${coreJoinYn}") {
			$("#select_site2-1").parent().addClass("readonly");
			$("#select_site2-1").attr("disabled", true);
			$("#select_site3-1").parent().addClass("readonly");
			$("#select_site3-1").attr("disabled", true);
			
			$("#dmTr").hide();
			$("#weddingDayTr").show();
		}
	}
	
});

$(window).load(function() {
	
	// 생년월일
	$("#year").val("${memberInfo.birthYear}").attr("selected", true);
	$("#month").val("${memberInfo.birthMonth}").attr("selected", true);
	$("#day").val("${memberInfo.birthDay}").attr("selected", true);
	chgMonth("${memberInfo.birthMonth}", false);
	
	if ("S" == "${memberInfo.birthUnar}") {
		$("#birth3").parent().addClass("selected");
		$("#birth3").attr("checked", true);
	} else if ("L" == "${memberInfo.birthUnar}") {
		$("#birth4").parent().addClass("selected");
		$("#birth4").attr("checked", true);
	}
	
	// 핸드폰번호
	$("#select_mobile").val("${memberInfo.mobileNo1}").attr("selected", true);
	
	// 이메일
	var domainIndex = $("#select-item > option").text().indexOf("${memberInfo.email2}");
	if (domainIndex > 0) {
		$("#select-item").val("${memberInfo.email2}").attr("selected", true);
		$("label[for=select-item]").text("${memberInfo.email2}");
		$("#input_email2").addClass("disabled");
		$("#input_email2").attr("disabled", true);
	}
	
	// 제휴사이트
	var retailMallJoinYn = "${retailMallJoinYn}";
	var coreJoinYn = "${coreJoinYn}";
	if ("true" == retailMallJoinYn) {
		if ("10" == "${siteCode}") {
			$("#select_site1").parent().addClass("selected").addClass("readonly");
			$("#select_site1").attr("disabled", true);
		} else {
			$("#select_site1").parent().addClass("selected");
		}	
		$("#select_site1").attr("checked", true);	
	}
	if ("true" == coreJoinYn) {
		if ("20" == "${siteCode}") {
			$("#select_site1-1").parent().addClass("selected").addClass("readonly");
			$("#select_site1-1").attr("disabled", true);
		} else {
			$("#select_site1-1").parent().addClass("selected");
		}		
		$("#select_site1-1").attr("checked", true);
	}
	if ("30" == "${siteCode}") {
		$("#field_partnership .checkArea").hide();
	}
	
	// 이메일 수신
	var retailMallEmailYn = "${memberInfo.retailMallEmailYn}";
	var coreEmailYn = "${memberInfo.coreEmailYn}";
	if ("Y" == retailMallEmailYn) {
		$("#select_site2").parent().addClass("selected");
		$("#select_site2").attr("checked", true);
	} else {
		$("#select_site2").parent().removeClass("selected");
		$("#select_site2").attr("checked", false);
	}	
	if ("Y" == coreEmailYn) {
		$("#select_site2-1").parent().addClass("selected");
		$("#select_site2-1").attr("checked", true);
	} else {
		$("#select_site2-1").parent().removeClass("selected");
		$("#select_site2-1").attr("checked", false);
	}
	if ("Y" == retailMallEmailYn && "Y" == coreEmailYn) {
		$("#check_email").addClass("on").children().text("전체해제");
	}

	if ($("#emailTr > td").find(".checkBox").size() == 1) {
		$("#emailTr > td").children().find("button").hide();
		$("#emailTr > td > div:eq(1)").removeClass("checkArea");
		$("#emailTr > td > div:eq(1)").removeClass("mt10");
	}

	// 문자 수신
	var retailMallSmsYn = "${memberInfo.retailMallSmsYn}";
	var coreSmsYn = "${memberInfo.coreSmsYn}";
	if ("Y" == retailMallSmsYn) {
		$("#select_site3").parent().addClass("selected");
		$("#select_site3").attr("checked", true);
	} else {
		$("#select_site3").parent().removeClass("selected");
		$("#select_site3-1").attr("checked", false);
	}	
	if ("Y" == coreSmsYn) {
		$("#select_site3-1").parent().addClass("selected");
		$("#select_site3-1").attr("checked", true);
	} else {
		$("#select_site3-1").parent().removeClass("selected");
		$("#select_site3-1").attr("checked", false);
	}
	if ("Y" == retailMallSmsYn && "Y" == coreSmsYn) {
		$("#check_sms").addClass("on").children().text("전체해제");
	}
	
	if ($("#smsTr > td").find(".checkBox").size() == 1) {
		$("#smsTr > td").children().find("button").hide();
		$("#smsTr > td > div:eq(1)").removeClass("checkArea");
		$("#smsTr > td > div:eq(1)").removeClass("mt10");
	}
	
	// DM 수신
	if ("Y" == "${memberInfo.coreDmYn}") {
		$("#rj_dm").parent().removeClass("selected");
		$("#rj_dm").attr("checked", false);
		$("#dm").parent().addClass("selected");
		$("#dm").attr("checked", true);
	} else {
		$("#dm").parent().removeClass("selected");
		$("#dm").attr("checked", false);
		$("#rj_dm").parent().addClass("selected");
		$("#rj_dm").attr("checked", true);
	}
		
	// 결혼 유무
	if("N" == "${memberInfo.weddingYn}") {
		$("#wedding2").parent().addClass("selected");
		$("#wedding2").attr("checked", true);
		$("#weddingDayTr").hide();
		$("#childrensTr").hide();
		if ("10" != "${siteCode}") {
			$("#weddingDayTr").hide();
		}
	} else {
		$("#wedding1").parent().addClass("selected");
		$("#wedding1").attr("checked", true);
	}
	
	// 결혼 기념일
	if ("${memberInfo.weddingYear}" != null && "${memberInfo.weddingYear}" != "") {		
		$("#m_year").val("${memberInfo.weddingYear}").attr("selected", true);
		$("#m_month").val("${memberInfo.weddingMonth}").attr("selected", true);
		$("#m_day").val("${memberInfo.weddingDay}").attr("selected", true);
		
		$("label[for=m_year]").text("${memberInfo.weddingYear}");
		$("label[for=m_month]").text("${memberInfo.weddingMonth}");
		$("label[for=m_day]").text("${memberInfo.weddingDay}");
	}	
	chgWedMonth("${memberInfo.weddingMonth}", false);
	
	// 자녀 생일
	var childSelCnt = $("#tbody_children > tr").size();
	for (var i=0; i<childSelCnt; i++) {
		setSelectBox("child_year"+(i+1), "child_month"+(i+1), "child_day"+(i+1));
		
		$("#child_year"+(i+1)).val($("input[name=child_year"+(i+1)+"]").val()).attr("selected", true);
		$("#child_month"+(i+1)).val($("input[name=child_month"+(i+1)+"]").val()).attr("selected", true);
		$("#child_day"+(i+1)).val($("input[name=child_day"+(i+1)+"]").val()).attr("selected", true);
		
		$("label[for=child_year"+(i+1)+"]").text($("#child_year"+(i+1)+" option:selected").val());
		$("label[for=child_month"+(i+1)+"]").text($("#child_month"+(i+1)+" option:selected").val());
		$("label[for=child_day"+(i+1)+"]").text($("#child_day"+(i+1)+" option:selected").val());
		
		chgChildBirthMonth($("#child_month"+(i+1)+" option:selected").val(), false, 0);
	}
	if ($("#tbody_children > tr").size() == 0) {
		addChildTr();
	}
	
});

/**
 *  연월일 생성 및 생년원일 디폴트 처리
 */
 function setSelectBox(param1, param2, param3) {
	// 생년월일 slectBox 설정
	var toDay = new Date();
	var year  = toDay.getFullYear();
	
	var strYear = "";
	var strMonth = "";
	var strDay = "";
	
	// 년도 설정
 	strYear += "<option value='선택'>선택</option>"
	for (var i=year; i>=1900; i--) {		
		strYear += "<option value='" + i + "' >" + i + "</option>";
	}
	
	// 월, 일 설정
	strMonth += "<option value='선택'>선택</option>"
	strDay += "<option value='선택'>선택</option>"
	for (var i=1; i<=31; i++) {
		var val = "";
		if (i < 10) {
			val = "0" + new String(i);
		} else {
			val = new String(i);
		} 
		
		strDay += "<option value='" + val + "'>" + val + "</option>";
		
		if (i < 13) {
			strMonth += "<option value='" + val + "'>" + val + "</option>";	
		}
	}
	
	if (param1 == "" && param2 == "" && param3 == "") {
		$("#year").html(strYear);
		$("#m_year").html(strYear);
		$("#month").html(strMonth);
		$("#day").html(strDay);
		$("#m_month").html(strMonth);
		$("#m_day").html(strDay);
		
		$("#child_year1").html(strYear);
		$("#child_month1").html(strMonth);
		$("#child_day1").html(strDay);
	} else {
		$("#"+param1).html(strYear);
		$("#"+param2).html(strMonth);
		$("#"+param3).html(strDay);
	}
	
	
}

/**
 * 이메일 주소 셀렉트 박스
 */
function selectEmail(option) {	
	if (option.value != "") {
		$("#input_email2").val(option.value);
		$("#input_email2").addClass("disabled");
		$("#input_email2").attr("disabled", true);
	} else {
		$("#input_email2").val("");
		$("#input_email2").removeClass("disabled");
		$("#input_email2").attr("disabled", false);
	}
}



/**
 * 제휴사이트 선택 시, 수신 동의 여부도 제어
 */
function partnerSiteClick(siteNm) {
	if ("mall" == siteNm) {
		if ($("#select_site1").parent().hasClass("selected")) {
			$("#select_site2").parent().removeClass("selected").addClass("readonly");
			$("#select_site2").attr("checked", false);
			$("#select_site2").attr("disabled", true);
			$("#select_site3").parent().removeClass("selected").addClass("readonly");
			$("#select_site3").attr("checked", false);
			$("#select_site3").attr("disabled", true);
		} else {
			$("#select_site2").parent().removeClass("readonly").addClass("selected");
			$("#select_site2").attr("checked", true);
			$("#select_site2").attr("disabled", false);			
			$("#select_site3").parent().removeClass("readonly").addClass("selected");
			$("#select_site3").attr("checked", true);
			$("#select_site3").attr("disabled", false);
			
		}
		allSiteBtn('mail');
		allSiteBtn('sms');
	} else if ("core" == siteNm) {
		if ($("#select_site1-1").parent().hasClass("selected")) {
			$("#select_site2-1").parent().removeClass("selected").addClass("readonly");
			$("#select_site2-1").attr("checked", false);
			$("#select_site2-1").attr("disabled", true);
			$("#select_site3-1").parent().removeClass("selected").addClass("readonly");
			$("#select_site3-1").attr("checked", false);
			$("#select_site3-1").attr("disabled", true);
			
			$("#dmTr").hide();
			if ($("#wedding1").is(":checked")) {
				$("#childrensTr").hide();
			}
		} else {
			$("#select_site2-1").parent().removeClass("readonly").addClass("selected");
			$("#select_site2-1").attr("checked", true);
			$("#select_site2-1").attr("disabled", false);
			
			$("#select_site3-1").parent().removeClass("readonly").addClass("selected");
			$("#select_site3-1").attr("checked", true);
			$("#select_site3-1").attr("disabled", false);
		
			$("#dmTr").show();
			if ($("#wedding1").is(":checked")) {
				$("#childrensTr").show();
			}			
		}
		allSiteBtn('mail');
		allSiteBtn('sms');
	}
}

/**
 * 마케팅 수신 동의 영역 버튼 제어
 */
function allSiteBtn(agreeField) {
	if ("mail" == agreeField) {
		var agreeCnt = $("#emailTr input[type=checkbox]:checked").size();
		if (agreeCnt == 2) {
			$("#check_email").addClass("on").children().text("전체해제");
		} else {
			$("#check_email").addClass("on").children().text("전체선택");
		}
	} else if ("sms" == agreeField) {
		var agreeCnt = $("#smsTr input[type=checkbox]:checked").size();
		if (agreeCnt == 2) {
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
		
	// 생년월일
	$("#birth").val($("label[for=year]").text() + $("label[for=month]").text() + $("label[for=day]").text());	
	
	// 생년월일 양/음력
	if ($("#birth3").parent().hasClass("selected")) {
		$("#birthUnar").val("S");
	} else if ($("#birth4").parent().hasClass("selected")) {
		$("#birthUnar").val("L");
	}
	
	// 이름
	$("#name").val("${memberInfo.membName}");
	
	// 전화번호
	$("#tel").val("${memberInfo.telNo}");
	
	// 핸드폰
	if ($("label[for=select_mobile]").text() == "선택") {
		alert("핸드폰 번호를 확인해주세요.");
		$("#select_mobile").focus();
		return;
	}
	var mobileNo1 = $("#mobile_1").val();
	if (mobileNo1 != null && mobileNo1 != "" && (mobileNo1.length == 3 || mobileNo1.length == 4)) {
		var mobileNo2 = $("#mobile_2").val();
		if (mobileNo2 != null && mobileNo2 != "" && mobileNo2.length == 4) {
			$("#phone").val($("label[for=select_mobile]").text() + $("#mobile_1").val() + $("#mobile_2").val());
		} else {
			alert("핸드폰 번호를 확인해주세요.");
			$("#mobile_2").focus();
			return;
		}
	} else {
		alert("핸드폰 번호를 확인해주세요.");
		$("#mobile_1").focus();
		return;
	}	
	
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
		$("#address1_2").val($("#addrDetail").val());
	}
	
	// 이메일
	if ($("#input_email1").val() == null || $("#input_email1").val() == "") {
		alert("이메일 주소를 입력해주세요.");
		$("#input_email1").focus();
		return;
	}
	$("#email").val($("#input_email1").val() +"@"+ $("#input_email2").val());
	
	// 회원 성별
	$("#gender").val("${memberInfo.gender}");
	
	// 제휴사이트
	if (!$("#select_site1").parent().hasClass("selected") && !$("#select_site1-1").parent().hasClass("selected")) {
		alert("제휴사이트는 한 곳 이상 선택해주세요");
		return;
	} else {
		if ("false" == "${retailMallJoinYn}" && $("#select_site1").parent().hasClass("selected")) {
			$("#retailMallPartnerShipYn").val("Y");
		} else if ("true" == "${retailMallJoinYn}" && !$("#select_site1").parent().hasClass("selected")) {
			$("#retailMallPartnerShipYn").val("N");
		}
		if ("false" == "${coreJoinYn}" && $("#select_site1-1").parent().hasClass("selected")) {
			$("#corePartnerShipYn").val("Y");
		} else if ("true" == "${coreJoinYn}" && !$("#select_site1-1").parent().hasClass("selected")) {
			$("#corePartnerShipYn").val("N");
		}
	}
		
	// 이메일 수신 여부
	if (!$("#select_site2").parent().hasClass("readonly")) {
		if ($("#select_site2").parent().hasClass("selected")) {
			if (!$("#select_site1").parent().hasClass("selected")) {
				alert("제휴 사이트가 선택되어야 수신 여부를 수정할 수 있습니다.");
				$("#select_site1").focus();
				return;
			} else {
				$("#retailMallEmailYn").val("Y");
			}		
		}		
	} else {
		$("#retailMallEmailYn").val("N");
	}
	if (!$("#select_site2-1").parent().hasClass("readonly")) {	
		if ($("#select_site2-1").parent().hasClass("selected")) {
			if (!$("#select_site1-1").parent().hasClass("selected")) {
				alert("제휴 사이트가 선택되어야 수신 여부를 수정할 수 있습니다.");
				$("#select_site1").focus();
				return;
			} else {
				$("#coreEmailYn").val("Y");
			}		
		} else {
			$("#coreEmailYn").val("N");
		}
	} else {
		$("#coreEmailYn").val("N");
	}
		
	// SMS 수신 여부
	if (!$("#select_site3").parent().hasClass("readonly")) {
		if ($("#select_site3").parent().hasClass("selected")) {
			if (!$("#select_site1").parent().hasClass("selected")) {
				alert("제휴 사이트가 선택되어야 수신 여부를 수정할 수 있습니다.");
				$("#select_site1-1").focus();
				return;
			} else {
				$("#retailMallSmsYn").val("Y");
			}
		} else {
			$("#retailMallSmsYn").val("N");
		}	
	} else {
		$("#retailMallSmsYn").val("N");
	}
	if (!$("#select_site3-1").parent().hasClass("readonly")) {
		if ($("#select_site3-1").parent().hasClass("selected")) {
			if (!$("#select_site1-1").parent().hasClass("selected")) {
				alert("제휴 사이트가 선택되어야 수신 여부를 수정할 수 있습니다.");
				$("#select_site1-1").focus();
				return;
			} else {
				$("#coreSmsYn").val("Y");
			}
		} else {
			$("#coreSmsYn").val("N");
		}
	} else {
		$("#coreSmsYn").val("N");
	}
		
	// DM 수신 여부
	if ($("#dmTr").is(":visible")) {
		if ($("#dm").parent().hasClass("selected")) {
			if (!$("#select_site1-1").parent().hasClass("selected")) {
				alert("제휴 사이트가 선택되어야 수신 여부를 수정할 수 있습니다.");
				$("#select_site1-1").focus();
				return;
			} else {
				$("#coreDmYn").val("Y");
			}		
		} else {
			$("#coreDmYn").val("N");
		}
	}
	
	// 결혼유무
	if ($("#wedding1").parent().hasClass("selected")) {
		$("#weddingYn").val("Y");
	} else if ($("#wedding2").parent().hasClass("selected")) {
		$("#weddingYn").val("N");
	}
	
	// 결혼기념일
	if ("Y" == $("#weddingYn").val()) {
		var weddingdayCnt = 0;
		
		var selWedYear = $("label[for=m_year]").text();
		var selWedMonth = $("label[for=m_month]").text();
		var selWedDay = $("label[for=m_day]").text();
		if (selWedYear != null && selWedYear != "" && selWedYear != "선택") {
			weddingdayCnt++;
			if (selWedMonth != null && selWedMonth != "" && selWedMonth != "선택") {
				weddingdayCnt++;
				if (selWedDay != null && selWedDay != "" && selWedDay != "선택") {
					weddingdayCnt++;
				}
			}		
		}
		if (weddingdayCnt < 3) {
			alert("결혼기념일을 확인해주세요");
			if (selWedYear == "선택") {
				$("#m_year").focus();
			} else if (selWedMonth == "선택") {
				$("#m_month").focus();
			} else {
				$("#m_day").focus();
			}
			return;
		} else {
			$("#weddingDay").val(selWedYear + selWedMonth + selWedDay);
		}
	}	
	
	// 자녀 정보
	if ("Y" == $("#weddingYn").val()) {
		var cNames = "";
		var cGenders = "";
		var cBirthdays = "";
		var cUnars = "";
		
		var nullCnt = 0;
		var childCnt = $("#tbody_children > tr").size();
		
		for (var i=0; i<childCnt; i++) {
			var childInfos = $("#tbody_children > tr:eq("+i+")");
			if (childInfos.find("#childName"+(i+1)).val() != null && childInfos.find("#childName"+(i+1)).val() != "") {
				cNames += childInfos.find("#childName"+(i+1)).val()+",";
			} else {
				nullCnt++;
			}
			
			if (childInfos.find("#male"+(i+1)).is(":checked")) {
				cGenders += "M,";
			} else if (childInfos.find("#female"+(i+1)).is(":checked")) {
				cGenders += "F,";
			}
			
			if (childInfos.find("#solar"+(i+1)).is(":checked")) {
				cUnars += "S,";
			} else if (childInfos.find("#lunar"+(i+1)).is(":checked")) {
				cUnars += "L,";
			}

			var childYear = $("label[for=child_year"+(i+1)+"]").text();
			var childMonth = $("label[for=child_month"+(i+1)+"]").text();			
			var childDay = $("label[for=child_day"+(i+1)+"]").text();
			if ((childYear == null || childYear == "" || childYear == "선택") 
					|| (childMonth == null || childMonth == "" || childMonth == "선택") 
					|| (childDay == null || childDay == "" || childDay == "선택")) {
				nullCnt++;
			} else {
				cBirthdays += childYear + childMonth + childDay+",";
			}		
		}
		
		// validation 추가 고려
		if (nullCnt == 0) {
			$("#childName").val(cNames);
			$("#childGender").val(cGenders);
			$("#childBirthday").val(cBirthdays);
			$("#childUnar").val(cUnars);
		}
		
	}
	
	if ($("#old_valid").is(":hidden") && $("#em_pwdValidMsg").is(":hidden")) {
		$("#currentSiteCode").val("${siteCode}");
	 	$("#pbpId").val("${memberInfo.pbpId}");
	 	$("#joinDate").val("${memberInfo.joinDate}");
		
		// 수정 정보 submit
		document.modifyForm.submit();
	} else {
		alert("회원정보를 수정할 수 없습니다. 다시 확인해주세요");
		$("#pwCheck").focus();
		return;
	}
 	
}

/**
 * 입력 항목 validation
 */
function requiredCheck() {
	// 생년월일
	if ($("#year option:selected").val() == "" || $("label[for=year]").text() == "선택") {
		alert("생년월일을 확인해주세요");
		$("#year").focus();
		return;
	} else if ($("#month option:selected").val() == "" || $("label[for=month]").text() == "선택") {
		alert("생년월일을 확인해주세요");
		$("#month").focus();
		return;
	} else if ($("#day option:selected").val() == "" || $("label[for=day]").text() == "선택") {
		alert("생년월일을 확인해주세요");
		$("#day").focus();
		return;
	}
	
	// 핸드폰번호
	if ($("#select_mobile option:selected").val() == "") {
		alert("핸드폰 번호를 입력하여 주세요");
		$("#select_mobile").focus();
		return;
	} else if ($.trim($("#mobile_1").val()) == "") {
		alert("핸드폰 번호를 입력하여 주세요");
		$("#mobile_1").focus();
		return;
	} else if ($.trim($("#mobile_2").val()) == "") {
		alert("핸드폰 번호를 입력하여 주세요");
		$("#mobile_2").focus();
		return;
	} else {
 		var mobileNo = $("#select_mobile option:selected").val() + $("#mobile_1").val() + $("#mobile_2").val();
 		if (!$.isNumeric(mobileNo)) {
 			alert("핸드폰 번호를 확인하여 주세요");
 			$("#mobile_1").focus();
 	 		return;
 		} else {
 			var mobileNo1 = $("#select_mobile option:selected").val();
 			if ("010" == mobileNo1) {
 				if ($("#mobile_1").val().length != 4) {
 					alert("핸드폰 번호를 확인하여 주세요");
 					$("#mobile_1").focus();
 		 	 		return;
 				} else {
 					if ($("#mobile_2").val().length != 4) {
 	 					alert("핸드폰 번호를 확인하여 주세요");
 	 					$("#mobile_2").focus();
 	 		 	 		return;
 					}
 				}
 			} else {
 				if (mobileNo.length < 10 || mobileNo.length > 11) {
 					alert("핸드폰 번호를 확인하여 주세요");
 					$("#mobile_1").focus();
	 		 	 		return;
 				}
 			}
 		}
	}
	
	// 주소
	if ($("#addrDetail").val() == "") {
		alert("주소를 입력하여 주세요");
		$("#addrDetail").focus();
		return;
	}
	
	// 이메일
	if ($.trim($("#input_email1").val()) == "") {
		alert("이메일를 입력하여 주세요");
		$("#input_email1").focus();
		return;
	} else if ($.trim($("#input_email2").val()) == "") {
		alert("이메일를 입력하여 주세요");
		$("#input_email2").focus();
		return;
	}
	
	if ($("#changePwdBtn").text() == "비밀번호 변경취소") {
		if ($("#pwCheck_re").val() != null && $("#pwCheck_re").val() != "") {
			birth.push($("#year option:selected").val(), $("#month option:selected").val()+$("#day option:selected").val());
			phone.push($("#phoneNumber2").val(), $("#phoneNumber3").val());
			
			if (!validatePassword($("#pwCheck_re").val(), "${memberInfo.webId}")) {
				alert("비밀번호를 다시 확인해주세요.");
				$("#pwCheck").focus();
				return;
			} else {
				$("#em_pwdValidMsg").text("");
			}
		}
	}
	
	setHiddenValue();
}

/**
 * 주소 찾기 팝업 띄우기
 */
function searchAddr() {
	 openCommonPopup("/member/searchAddrPopup", "", "560", "700", "주소찾기");
}

/**
 * 주소 찾기 팝업에서 넘어오는 값 세팅
 */
function setAddr(addrList) { 
	for (var i=0; i< addrList.length; i++) {
		if (i == 0) {
			$("#addr1").val("(" + addrList[i].postNo + ")" + addrList[i].addr);
			$("#addrDetail").val(addrList[i].addr2);
			 
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
 * 생년월일 양/음력 변경
 */
function chgBirthUnar(radio) {
	if (radio.id == "birth3") {
		$("#birth4").attr("checked", false);
		$("#birth3").attr("checked", true);		
	} else {
		$("#birth3").attr("checked", false);
		$("#birth4").attr("checked", true);
	}
	
}

/**
 * 결혼 유무 변경
 */
function chgWeddingYn(wedType) {
	if (wedType == "married") {
		$("#wedding2").attr("checked", false);
		$("#wedding1").attr("checked", true);
		if ("10" == "${siteCode}") {
			if (!$("#select_site1-1").is(":checked")) {
				$("#childrensTr").hide();
			} else {
				$("#weddingDayTr").show();
				$("#childrensTr").show();
			}
		} else {
			if (!$("#select_site1-1").is(":checked")) {
				$("#childrensTr").hide();
			} else {
				$("#childrensTr").show();
			}
			$("#weddingDayTr").show();		
		}
	} else {
		$("#wedding1").attr("checked", false);
		$("#wedding2").attr("checked", true);
		$("#weddingDayTr").hide();
 		$("#childrensTr").hide();
	}
}

/**
 * 자녀 정보 추가
 */
function addChildTr() {	
	var trCount = $("#tbody_children > tr").size() + 1;
	
	var strHtml = "";
	strHtml += '<tr>';
	strHtml += '	<td>';
	strHtml += '		<div class="taL">';
	strHtml += '			<span class="customRadio selected"><input type="radio" id="male'+trCount+'" name="gender'+trCount+'" class="radioBtn" checked=""></span><label for="male'+trCount+'" class="label_txt m1">남</label>';
	strHtml += '			<span class="customRadio"><input type="radio" id="female'+trCount+'" name="gender'+trCount+'" class="radioBtn"></span><label for="female'+trCount+'" class="label_txt">여</label>';
	strHtml += '		</div>';
	strHtml += '		<div class="mt10"><input type="text" id="childName'+trCount+'" name="childName'+trCount+'" class="input_text w50" title="이름 입력"></div>';
	strHtml += '	</td>';
	strHtml += '	<td>';
	strHtml += '		<div class="taL">';
	strHtml += '			<span class="customRadio selected"><input type="radio" id="solar'+trCount+'" name="childBirth'+trCount+'" class="radioBtn" checked=""></span><label for="solar'+trCount+'" class="label_txt m1">양력</label>';
	strHtml += '			<span class="customRadio"><input type="radio" id="runar'+trCount+'" name="childBirth'+trCount+'" class="radioBtn"></span><label for="runar'+trCount+'" class="label_txt">음력</label>';
	strHtml += '		</div>';	
	strHtml += '		<div class="mt10">';
	strHtml += '			<div class="selectBox w75">';
	strHtml += '				<label for="child_year'+trCount+'">선택</label>';
	strHtml += '				<select class="select" id="child_year'+trCount+'" onchange="chgChildBirthYear(this.value);">';
	strHtml += '					<option value=""></option>';
	strHtml += '				</select>';
	strHtml += '			</div><!-- // selectBox-->';
	strHtml += '			<span class="br">년</span>';
	strHtml += '			<div class="selectBox w75">';
	strHtml += '				<label for="child_month'+trCount+'">선택</label>';
	strHtml += '				<select class="select" id="child_month'+trCount+'" onchange="chgChildBirthMonth(this.value, true,'+trCount+');">';
	strHtml += '					<option value=""></option>';
	strHtml += '				</select>';			
	strHtml += '			</div><!-- // selectBox-->';			
	strHtml += '			<span class="br">월</span>';			
	strHtml += '				<div class="selectBox w75">';			
	strHtml += '					<label for="child_day'+trCount+'">선택</label>';			
	strHtml += '					<select class="select" id="child_day'+trCount+'">';			
	strHtml += '						<option value=""></option>';			
	strHtml += '					</select>';			
	strHtml += '				</div><!-- // selectBox-->';			
	strHtml += '			<span class="br">일</span>';			
	strHtml += '		</div>';			
	strHtml += '	</td>';			
	strHtml += '	<td>';
	strHtml += '		<button type="button" class="btn_pm plus" title="추가" onclick="javascript:addChildTr();"><span class="blind">추가</span></button>';
	strHtml += '		<button type="button" class="btn_pm minus" title="삭제" onclick="javascript:removeChildTr(this);"><span class="blind">삭제</span></button>';
	strHtml += '	</td>';
	strHtml += '</tr>';
	
	$("#tbody_children").append(strHtml);
	setSelectBox("child_year"+trCount, "child_month"+trCount, "child_day"+trCount);
	
	$("input.radioBtn").click(function(){
		if($(this).is(":checked")){
			$(this).parent().addClass("selected");
			$(".radioBtn:not(:checked)").parent().removeClass("selected");
		}
	});
	
	var select = $("select.select");
	select.change(function(){
		var select_name = $(this).children("option:selected").text();
		$(this).siblings("label").text(select_name);
	});
		
}

/**
 * 자녀 정보 삭제
 */
function removeChildTr(args) {
	$(args).closest("tr").remove();
}

function goToMainPage() {
	location.href = "/";
}

</script>

<!-- 컨텐츠 상세 영역 시작 -->
<div class="content">
	<h3>회원정보 수정</h3>

	<!-- 기본정보 -->
	<form action="/member/updateMemberSuccess" name="modifyForm" id="modifyForm" method="POST">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<div class="fieldDiv">
			<fieldset>
				<legend class="tit_bl">기본정보</legend>
				<p class="guide">(<span class="ns">*</span>)표시는 필수입력항목입니다.</p>
				<div class="fieldTable mt10">
					<table cellspacing="0"  summary="이름, 회원아이디, 비밀번호, 비밀번호재입력, 생년월일, 핸드폰번호, 주소, 이메일">
							<colgroup>
								<col class="col180" />
								<col class="col590" />
							</colgroup>
	
							<tbody>
								<tr>
									<th scope="row"><div class="tit">이름</div></th>
									<td><span class="txt">${memberInfo.membName}</span></td>
								</tr>
								<tr>
									<th scope="row"><div class="tit">회원아이디</div></th>
									<td><span class="txt">${memberInfo.webId}</span></td>
								</tr>
								<tr class="pwLine">
									<th scope="row"><div class="tit">비밀번호</div></th>
									<td><button id="changePwdBtn" type="button" class="btn grey btn_change"><span>비밀번호 변경</span></button></td>
								</tr>
								<!-- 비밀번호 변경 영역 -->
								<tr class="change_pw">
									<th scope="row"><div class="tit">기존 비밀번호 <span class="ns" title="필수입력">*</span></div></th>
									<td><input type="password" id="old_pwd" name="old_pwd" class="input_text w390" title="기존 비밀번호 입력" /><em id='old_valid' class='fail'></em></td>
								</tr>
								<tr class="change_pw">
									<th scope="row"><div class="tit">신규 비밀번호 <span class="ns" title="필수입력">*</span></div></th>
									<td>
										<input type="password" id="pwCheck" name="pwCheck" class="input_text w390" title="신규 비밀번호 입력" />
										<em class="warn">연속적인 숫자나 생일, 전화번호등 추측하기 쉬운 개인정보 및 아이디와 비슷한 전화번호 사용을 피하시기 바랍니다.<br />비밀번호는 영대문자, 영소문자, 숫자, 특수문자 중 3종류 이상을 조합하여, 총 8~16자리로 구성하셔야 합니다.</em>
									</td>
								</tr>
								<tr class="change_pw">
									<th scope="row"><div class="tit">신규 비밀번호 재입력<span class="ns" title="필수입력">*</span></div></th>
									<td><input type="password" id="pwCheck_re" name="pwCheck_re" class="input_text w390" title="신규 비밀번호 재입력" /><em id='em_pwdValidMsg' class='fail'></em></td>
								</tr>
								<!-- // 비밀번호 변경 영역 -->
								<tr>
									<th scope="row"><div class="tit">생년월일 <span class="ns" title="필수입력">*</span></div></th>
									<td>
										<div class="selectBox">
											<label for="year">${memberInfo.birthYear}</label>
											<select class="select" id="year" onchange="chgYear(this.value);">
												<option value="${memberInfo.birthYear}">${memberInfo.birthYear}</option>
											</select>
										</div><!-- // selectBox-->
										<span class="br">년</span>
										<div class="selectBox">
											<label for="month">${memberInfo.birthMonth}</label>
											<select class="select" id="month" onchange="chgMonth(this.value, true);">
												<option value="${memberInfo.birthMonth}">${memberInfo.birthMonth}</option>
											</select>
										</div><!-- // selectBox-->
										<span class="br">월</span>
										<div class="selectBox">
											<label for="day">${memberInfo.birthDay}</label>
											<select class="select" id="day">
												<option value="${memberInfo.birthDay}">${memberInfo.birthDay}</option>
											</select>
										</div><!-- // selectBox-->
										<span class="br">일</span>
										<div class="birth_select">
											<input type="radio" id="birth3" name="birthRadio" class="radioBtn" onchange="chgBirthUnar(this);"/><label for="birth3" class="label_txt m1">양력</label>
											<input type="radio" id="birth4" name="birthRadio" class="radioBtn" onchange="chgBirthUnar(this);"/><label for="birth4" class="label_txt">음력</label>
										</div>										
									</td>
								</tr>
								<tr>
									<th scope="row"><div class="tit">핸드폰번호 <span class="ns" title="필수입력">*</span></div></th><!-- // 2016-02-19 수정 -->
									<td>
										<div class="selectBox">
											<label for="select_mobile">${memberInfo.mobileNo1}</label>
											<select class="select" id="select_mobile" title="핸드폰번호">
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
											</select>
										</div><!-- // selectBox-->
										<span class="br">-</span>
										<input type="text" id="mobile_1" name="mobile_1" class="input_text w110" title="중간자리" value="${memberInfo.mobileNo2}" />
										<span class="br">-</span>
										<input type="text" id="mobile_2" name="mobile_2" class="input_text w110" title="뒷자리" value="${memberInfo.mobileNo3}" />
									</td>
								</tr>
								<tr>
									<th scope="row"><div class="tit">주소 <span class="ns" title="필수입력">*</span></div></th>
									<td>
										<div class="clr"><input type="text" id="addr1" name="addr1" class="input_text w390 disabled" disabled title="주소" value="(${memberInfo.zipCode})${memberInfo.addr1}"/><a href="javascript:searchAddr();" class="btn grey"><span>주소찾기</span></a></div>
										<div class="mt10"><input type="text" id="addrDetail" name="addrDetail" class="input_text w390" title="상세주소" value="${memberInfo.addr2}"/></div>
										<input type="hidden" id="hidAddrType" name="hidAddrType" value="${memberInfo.selectAddr}" />
									</td>
								</tr>
								<tr>
									<th scope="row"><div class="tit">이메일 <span class="ns" title="필수입력">*</span></div></th>
									<td>									
										<input type="text" id="input_email1" name="email_id" class="input_text w180" title="이메일주소" value="${memberInfo.email1}"/>
										<span class="br m1">@</span>
										<input type="text" id="input_email2" name="email_addr" class="input_text w180" value="${memberInfo.email2}"/>									
										<div class="selectBox m2 w140">
											<label for="select-item">직접입력</label>
											<select class="select" id="select-item" onchange="javascript:selectEmail(this);">
												<option value="">직접입력</option>
												<option value="naver.com">naver.com</option>
				                                <option value="gmail.com">gmail.com</option>
				                                <option value="icloud.com">icloud.com</option>
				                                <option value="nate.com">nate.com</option>
				                                <option value="hanmail.com">hanmail.com</option>
				                                <option value="hotmail.com">hotmail.com</option>
				                                <option value="yahoo.com">yahoo.com</option>
											</select>
										</div><!-- // selectBox-->
									</td>
								</tr>
							</tbody>
					</table>
				</div><!-- // fieldTable-->
			</fieldset>
		</div><!-- // fieldDiv :: 기본정보 -->
		
		<!-- 이랜드 리테일 제휴 사이트 선택 -->
		<div class="fieldDiv mt30">
			<fieldset id="field_partnership">
				<legend class="tit_bl">이랜드 리테일 제휴 사이트 선택</legend>
				<div class="fieldTable mt10">
					<table cellspacing="0" summary="제휴 사이트 선택">
						<colgroup>
							<col class="col180">
							<col class="col590">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><div class="tit">제휴 사이트 선택</div></th>
								<td id="td_partnerShip" class="inpd">
									<div class="allCheckLine">
										<c:choose>
											<c:when test="${10 eq siteCode}">
												<span class="chk" id="partnerShipSpan">
													<span class="customCheck selected">
														<input type="checkbox" id="select_site1" name="partnerShip" class="checkBox" checked="" onclick="javascript:partnerSiteClick('mall');">
													</span>
													<label for="select_site1" class="label_txt"><spring:message code="name.elandmall" /></label>
												</span>
											</c:when>
											<c:when test="${20 eq siteCode}">
												<span class="chk" id="partnerShipSpan">
													<span class="customCheck selected">
														<input type="checkbox" id="select_site1-1" name="partnerShip" class="checkBox" checked="" onclick="javascript:partnerSiteClick('core');">
													</span>
													<label for="select_site1-1" class="label_txt"><spring:message code="name.elandretail" /></label>
												</span>
											</c:when>
											<c:when test="${30 eq siteCode}">
												<span class="customCheck">
													<input type="checkbox" id="select_site1" name="partnerShip" class="checkBox" onclick="javascript:partnerSiteClick('mall');">
												</span>
												<label for="select_site1" class="label_txt"><spring:message code="name.elandmall" /></label>
												<span class="customCheck">
													<input type="checkbox" id="select_site1-1" name="partnerShip" class="checkBox" onclick="javascript:partnerSiteClick('core');">
												</span>
												<label for="select_site1-1" class="label_txt"><spring:message code="name.elandretail" /></label>
											</c:when>
										</c:choose>
										<!-- <button type="button" class="btn white w95" id="check_site"><span>전체선택</span></button> -->
									</div>
									<div class="checkArea mt10" id="partnerShipDiv">
										<c:choose>
											<c:when test="${10 eq siteCode}">
												<span class="customCheck">
													<input type="checkbox" id="select_site1-1" name="partnerShip" class="checkBox" onclick="javascript:partnerSiteClick('core');">
												</span>
												<label for="select_site1-1" class="label_txt"><spring:message code="name.elandretail" /></label>
											</c:when>
											<c:when test="${20 eq siteCode}">
												<span class="customCheck">
													<input type="checkbox" id="select_site1" name="partnerShip" class="checkBox" onclick="javascript:partnerSiteClick('mall');">
												</span>
												<label for="select_site1" class="label_txt"><spring:message code="name.elandmall" /></label>
											</c:when>
										</c:choose>

									</div><!-- // checkArea -->
								</td>
							</tr>
						</tbody>
					</table>
				</div><!-- // fieldTable -->
			</fieldset>
		</div>
		<!-- // fieldDiv :: 이랜드 리테일 제휴 사이트 선택 -->
	
		<!-- 마케팅 정보 수신 동의 -->
		<div class="fieldDiv mt30">
			<fieldset>
				<legend class="tit_bl">마케팅 정보 수신 동의</legend>
				<div class="fieldTable mt10">
					<table cellspacing="0"  summary="이메일 수신, 문자수신, DM 수신">
						<colgroup>
							<col class="col180" />
							<col class="col590" />
						</colgroup>
	
						<tbody>			
							<tr id="emailTr">
								<th scope="row"><div class="tit">이메일 수신</div></th>
								<td class="inpd">
									<div class="allCheckLine">
										<c:choose>
											<c:when test="${10 eq siteCode}">
												<span class="chk"><input type="checkbox" id="select_site2" name="check2" class="checkBox" onchange="allSiteBtn('mail');"/><label for="select_site2" class="label_txt"><spring:message code="name.elandmall" /></label></span>
											</c:when>
											<c:when test="${20 eq siteCode}">
												<span class="chk"><input type="checkbox" id="select_site2-1" name="check2" class="checkBox" onchange="allSiteBtn('mail');"/><label for="select_site2-1" class="label_txt"><spring:message code="name.elandretail" /></label></span>
											</c:when>											
										</c:choose>
										<button type="button" class="btn white w95" id="check_email"><span>전체선택</span></button>
									</div>
									<div class="checkArea mt10">
										<c:choose>
											<c:when test="${10 eq siteCode}">
												<input type="checkbox" id="select_site2-1" name="check2" class="checkBox" onchange="allSiteBtn('mail');"/><label for="select_site2-1" class="label_txt"><spring:message code="name.elandretail" /></label>
											</c:when>
											<c:when test="${20 eq siteCode}">
												<input type="checkbox" id="select_site2" name="check2" class="checkBox" onchange="allSiteBtn('mail');"/><label for="select_site2" class="label_txt"><spring:message code="name.elandmall" /></label>
											</c:when>
											<c:when test="${30 eq siteCode}">
												<input type="checkbox" id="select_site2" name="check2" class="checkBox" onchange="allSiteBtn('mail');"/><label for="select_site2" class="label_txt"><spring:message code="name.elandmall" /></label>
												<input type="checkbox" id="select_site2-1" name="check2" class="checkBox" onchange="allSiteBtn('mail');"/><label for="select_site2-1" class="label_txt"><spring:message code="name.elandretail" /></label>										
											</c:when>											
										</c:choose>
									</div><!-- // checkArea -->
								</td>
							</tr>
							<tr id="smsTr">
								<th scope="row"><div class="tit">문자수신</div></th>
								<td class="inpd">
									<div class="allCheckLine">
										<c:choose>
											<c:when test="${10 eq siteCode}">
												<span class="chk"><input type="checkbox" id="select_site3" name="check3" class="checkBox" onchange="allSiteBtn('sms');"/><label for="select_site3" class="label_txt"><spring:message code="name.elandmall" /></label></span>
											</c:when>
											<c:when test="${20 eq siteCode}">
												<span class="chk"><input type="checkbox" id="select_site3-1" name="check3" class="checkBox" onchange="allSiteBtn('sms');"/><label for="select_site3-1" class="label_txt"><spring:message code="name.elandretail" /></label></span>
											</c:when>
										</c:choose>									
										<button type="button" class="btn white w95" id="check_sms"><span>전체선택</span></button>
									</div>
									<div class="checkArea mt10">
										<c:choose>
											<c:when test="${10 eq siteCode}">
												<input type="checkbox" id="select_site3-1" name="check3" class="checkBox" onchange="allSiteBtn('sms');"/><label for="select_site3-1" class="label_txt"><spring:message code="name.elandretail" /></label>
											</c:when>
											<c:when test="${20 eq siteCode}">
												<input type="checkbox" id="select_site3" name="check3" class="checkBox" onchange="allSiteBtn('sms');"/><label for="select_site3" class="label_txt"><spring:message code="name.elandmall" /></label>
											</c:when>
											<c:when test="${30 eq siteCode}">
												<input type="checkbox" id="select_site3" name="check3" class="checkBox" onchange="allSiteBtn('sms');"><label for="select_site3" class="label_txt"><spring:message code="name.elandmall" /></label>
												<input type="checkbox" id="select_site3-1" name="check3" class="checkBox" onchange="allSiteBtn('sms');"><label for="select_site3-1" class="label_txt"><spring:message code="name.elandretail" /></label>
											</c:when>
										</c:choose>
									</div><!-- // checkArea -->
								</td>
							</tr>
							<tr id="dmTr">
								<th scope="row">
									<div class="tit">
										DM 수신
									</div>
								</th>
								<td>
									<div class="chk">
										<input type="radio" id="dm" name="radio1" class="radioBtn" checked /><label for="dm" class="label_txt">우편수신</label>
										<input type="radio" id="rj_dm" name="radio1" class="radioBtn" /><label for="rj_dm" class="label_txt">수신안함</label>
									</div>
								</td>
							</tr>						
						</tbody>
					</table>
				</div><!-- // fieldTable -->
			</fieldset>
		</div><!-- // fieldDiv :: 마케팅 정보 수신 동의 -->
	
		<!-- 부가정보 -->
		<div class="fieldDiv mt30">
			<fieldset>
				<legend class="tit_bl">부가정보</legend>
				<div class="fieldTable mt10">
					<table cellspacing="0"  summary="전화번호, 결혼유무, 결혼기념일, 자녀수">
						<colgroup>
							<col class="col180" />
							<col class="col590" />
						</colgroup>
	
							<tbody>
								<tr id="weddingYnTr">
									<th scope="row"><div class="tit">결혼유무</div></th>
									<td>
										<div class="chk">
											<input type="radio" id="wedding1" name="wedRadio" class="radioBtn" onclick="javascript:chgWeddingYn('married');"/><label for="wedding1" class="label_txt">기혼</label>
											<input type="radio" id="wedding2" name="wedRadio" class="radioBtn" onclick="javascript:chgWeddingYn('single');"/><label for="wedding2" class="label_txt">미혼</label>
										</div>
									</td>
								</tr>
								<tr id="weddingDayTr">
									<th scope="row"><div class="tit">결혼기념일</div></th>
									<td>
										<div class="selectBox">
											<label for="m_year">선택</label>
											<select class="select" id="m_year" onchange="chgWedYear(this.value);">
												<option value="${memberInfo.weddingYear}">${memberInfo.weddingYear}</option>
											</select>
										</div><!-- // selectBox-->
										<span class="br">년</span>
										<div class="selectBox">
											<label for="m_month">선택</label>
											<select class="select" id="m_month" onchange="chgWedMonth(this.value, true);">
												<option value="${memberInfo.weddingMonth}">${memberInfo.weddingMonth}</option>
											</select>
										</div><!-- // selectBox-->
										<span class="br">월</span>
										<div class="selectBox">
											<label for="m_day">선택</label>
											<select class="select" id="m_day">
												<option value="${memberInfo.weddingDay}">${memberInfo.weddingDay}</option>
											</select>
										</div><!-- // selectBox-->
										<span class="br">일</span>
									</td>
								</tr>
								<tr id="childrensTr">
									<th scope="row"><div class="tit">자녀수</div></th>
									<td class="inpd">
										<div class="innerTable"><!-- 2016-03-02 class mt10 삭제 -->
											<table cellspacing="0" summary="성별/이름, 생년월일, 추가/삭제">
												<colgroup>
													<col width="137px">
													<col width="*">
													<col width="80px">
												</colgroup>
												<thead>
													<tr>
														<th>성별/이름</th>
														<th>생년월일</th>
														<th>추가/삭제</th>
													</tr>
												</thead>
												<tbody id="tbody_children">
													<c:forEach var="childs" items="${memberInfo.children}" varStatus="i">
														<tr>
															<td>
																<div class="taL">
																	<c:choose>
																		<c:when test="${'M' eq childs.childGender}">
																			<span class="customRadio selected"><span class="customRadio"><input type="radio" id="male${i.index+1}" name="gender${i.index+1}" class="radioBtn" checked="checked"></span></span><label for="male${i.index+1}" class="label_txt m1">남</label>
																			<span class="customRadio selected"><span class="customRadio"><input type="radio" id="female${i.index+1}" name="gender${i.index+1}" class="radioBtn"></span></span><label for="female${i.index+1}" class="label_txt">여</label>
																		</c:when>
																		<c:when test="${'F' eq childs.childGender}">
																			<span class="customRadio selected"><span class="customRadio"><input type="radio" id="male${i.index+1}" name="gender${i.index+1}" class="radioBtn" ></span></span><label for="male${i.index+1}" class="label_txt m1">남</label>
																			<span class="customRadio selected"><span class="customRadio"><input type="radio" id="female${i.index+1}" name="gender${i.index+1}" class="radioBtn" checked="checked"></span></span><label for="female${i.index+1}" class="label_txt">여</label>
																		</c:when>																	
																	</c:choose>	
																</div>
																<div class="mt10"><input type="text" id="childName${i.index+1}" name="childName${i.index+1}" class="input_text w50" title="이름 입력" value="${childs.childName}"></div>
															</td>
															<td>
																<div class="taL">
																	<c:choose>
																		<c:when test="${'S' eq childs.childUnar}">
																			<span class="customRadio selected"><span class="customRadio"><input type="radio" id="solar${i.index+1}" name="childBirth${i.index+1}" class="radioBtn" checked="checked"></span></span><label for="solar${i.index+1}" class="label_txt m1">양력</label>
																			<span class="customRadio selected"><span class="customRadio"><input type="radio" id="runar${i.index+1}" name="childBirth${i.index+1}" class="radioBtn"></span></span><label for="runar${i.index+1}" class="label_txt">음력</label>
																		</c:when>
																		<c:when test="${'L' eq childs.childUnar}">
																			<span class="customRadio selected"><span class="customRadio"><input type="radio" id="solar${i.index+1}" name="childBirth${i.index+1}" class="radioBtn"></span></span><label for="solar${i.index+1}" class="label_txt m1">양력</label>
																			<span class="customRadio selected"><span class="customRadio"><input type="radio" id="runar${i.index+1}" name="childBirth${i.index+1}" class="radioBtn" checked="checked"></span></span><label for="runar${i.index+1}" class="label_txt">음력</label>
																		</c:when>
																	</c:choose>
																</div>
																<div class="mt10">
																	<div class="selectBox w75">
																		<label for="child_year${i.index+1}">선택</label>
																		<input type="hidden" name="child_year${i.index+1}" value="${childs.childBirthYear}" />
																		<select class="select" id="child_year${i.index+1}" onchange="chgChildBirthYear(this.value);">
																			<option value="${childs.childBirthYear}">${childs.childBirthYear}</option>
																		</select>
																	</div><!-- // selectBox-->
																	<span class="br">년</span>
																	<div class="selectBox w75">
																		<label for="child_month${i.index+1}">선택</label>
																		<input type="hidden" name="child_month${i.index+1}" value="${childs.childBirthMonth}" />
																		<select class="select" id="child_month${i.index+1}" onchange="chgChildBirthMonth(this.value, true, ${i.index+1});">
																			<option value="${childs.childBirthMonth}">${childs.childBirthMonth}</option>
																		</select>
																	</div><!-- // selectBox-->
																	<span class="br">월</span>
																	<div class="selectBox w75">
																		<label for="child_day${i.index+1}">선택</label>
																		<input type="hidden" name="child_day${i.index+1}" value="${childs.childBirthDay}" />
																		<select class="select" id="child_day${i.index+1}">
																			<option value="${childs.childBirthDay}">${childs.childBirthDay}</option>
																		</select>
																	</div><!-- // selectBox-->
																	<span class="br">일</span>
																</div>
															</td>
															<td>
																<button type="button" class="btn_pm plus" title="추가" onclick="addChildTr();"><span class="blind">추가</span></button>
																<button type="button" class="btn_pm minus" title="삭제" onclick="removeChildTr(this);"><span class="blind">삭제</span></button>
															</td>
														</tr>														 
													</c:forEach>													
												</tbody>
											</table>
										</div><!-- // innerTable-->
									</td>
								</tr>
							</tbody>
					</table>
				</div><!-- // fieldTable-->
			</fieldset>
		</div><!-- // fieldDiv :: 부가정보 -->
		
		<!-- Hidden Value //S -->
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
		<!-- Hidden Value //E -->
	</form>

	<div class="btnDiv taC mt30">
		<a href="#cancel_modify" class="btn white large open_modal"><span>취소</span></a>
		<a href="javascript:requiredCheck();" class="btn blue large"><span>수정 완료</span></a>
	</div>
	
	<div class="layerPop modal" id="cancel_modify" aria-hidden="true" aria-labelledby="modalTitle2" role="alertdialog" aria-live="polit" style="top: 241px; left: 443px; display: none;">
		<div class="popupBox w420">
			<div class="popContent taC">
				회원정보 수정을 취소하시겠습니까?
			</div><!-- // popContent -->
			<div class="btnDiv taC">
				<button type="button" class="btn white pop closeModalLayer"><span>취소</span></button>
				<button type="button" class="btn blue pop" onclick="javascript:goToMainPage();"><span>확인</span></button>
			</div>
			<button type="button" class="btn_popClose closeModalLayer"><span class="blind">팝업닫기</span></button>
		</div><!-- // popupBox -->
	</div>

</div>
<!-- // content :: 컨텐츠 상세 영역 끝 -->