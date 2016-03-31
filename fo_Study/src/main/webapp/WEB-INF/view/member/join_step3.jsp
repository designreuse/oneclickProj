<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<script type="text/javascript">

var siteCode = "${siteCode}";
$(document).ready(function () {
	
	var invalidAccess = ${invalidAccess};
	if (invalidAccess) {
		alert("잘못된 접근입니다. 메인페이지로 이동합니다.");
		location.replace("/");
	}
	
	
	
	$('.open_modal').modalLayer();
	customRadio();
	
	// Path 및 LeftTitle 설정
	$("#li_member > a").addClass("current");
	$("#li_joinMember > a").addClass("current");
	var strHtml = "<a href='/member/updateMember'><span>회원정보</span></a><span class='current'>회원가입</span>";
	$("#header_path").append(strHtml);
	$("#leftTitle").text("회원가입");
	
	// 연월일 생성
	setSelectBox("","","");
	
	// 본인인증 휴대폰 번호 세팅
	var phoneNumber = "${phoneNumber}";
	if (phoneNumber != "") {
		var num1 = phoneNumber.substring(0,3);
		var num2 = phoneNumber.substring(3,7);
		var num3 = phoneNumber.substring(7,11);
		
		$("#label_mobile").text(num1);
		$("#mobile").val(num1);
		$("#phoneNumber2").val(num2);
		$("#phoneNumber3").val(num3);
	}
	
	
	$("#webId").blur(function() {
		$("#td_webId > em").remove();
	});
	// 비밀번호 입력시 웹아이디 validation 메세지 삭제 (유효한 아이디 입니다 일경우만)
	$("#password").focusin(function() {
		if ($("#td_webId > em").hasClass("valid")) {
			$("#td_webId > em").remove();
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
				$("#em_pwdValidMsg2").html("");
		 		$("#em_pwdValidMsg2").append(strHtml);
		 		$("#hidPwdCheck").val(false);
			} else {
				$("#em_pwdValidMsg2").html("");
				$("#hidPwdCheck").val(true);
			}		
		} 
	});
	
	// 패스워드 재입력 유효성 검사
	$("#phoneNumber2").blur(function() {
		if ($("#phoneNumber2").val() != "") {
			if ("010" == $("#mobile").val()) {
				if ($("#phoneNumber2").val().length < 4) {
					strHtml = "<em class='fail'>핸드폰 번호 자리수가 부족합니다.</em>";
					$("#td_phone > em").remove();
					$("#td_phone").append(strHtml);
					$("#phoneNumber2").focus();
					return;
				}
			} else {
				if ($("#phoneNumber2").val().length < 3) {
					strHtml = "<em class='fail'>핸드폰 번호 자리수가 부족합니다.</em>";
					$("#td_phone > em").remove();
					$("#td_phone").append(strHtml);
					$("#phoneNumber2").focus();
					return;
				}
			}
			$("#td_phone > em").remove();
		} 
	});
	
	// 패스워드 재입력 유효성 검사
	$("#phoneNumber3").blur(function() {
		if ($("#phoneNumber3").val() != "") {
			if ($("#phoneNumber3").val().length < 4) {
				strHtml = "<em class='fail'>핸드폰 번호 자리수가 부족합니다.</em>";
				$("#td_phone > em").remove();
				$("#td_phone").append(strHtml);
				$("#phoneNumber3").focus();
				return;
			}
		}
		$("#td_phone > em").remove();
	});
	
	
	$("#input_email1").blur(function() {
		if ($("#input_email1").val() == "") {
			strHtml = "<em class='fail'>이메일을 입력해 주세요.</em>";
			$("#td_email > em").remove();
			$("#td_email").append(strHtml);
			$("#input_email1").focus();
			return;
		}
		$("#td_email > em").remove();
	});
	
	
	
	$("#input_email2").blur(function() {
		var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		if(!reg_email.test($("#input_email1").val() +"@"+ $("#input_email2").val()))
		{
			strHtml = "<em class='fail'>잘못된 이메일 형식입니다.</em>";
			
			$("#td_email > em").remove();
			$("#td_email").append(strHtml);
			$("#input_email2").focus();
			return;
		}
		$("#td_email > em").remove();
	});
	
	
	
	// 제휴사이트 모두 선택
	$("#check_site").click(function() {
		if (!$(this).hasClass("on")) {
			$(this).addClass("on").children().text("전체해제");
			$("input[name=partnerShip]").prop("checked", true).parent().addClass("selected");
			$("#tr_receiveDm").show();
			 $("#tr_isWedding").show();
			 $("#children_number").show();
			
			 if ("10" == siteCode) {
				 $("#coreEmail").parent().removeClass("disabled");
				 $("#coreSms").parent().removeClass("disabled");
			 } else if ("20" == siteCode) {
				 $("#retailMallEmail").parent().removeClass("disabled");
				 $("#retailMallSms").parent().removeClass("disabled");
			 } else {
				 $("#retailMallEmail").parent().removeClass("disabled");
				 $("#retailMallSms").parent().removeClass("disabled");
				 $("#coreEmail").parent().removeClass("disabled");
				 $("#coreSms").parent().removeClass("disabled");
			 }
			 
			 
		} else {
			$(this).removeClass("on").children().text("전체선택");
			$("input[name=partnerShip]").prop("checked", false).parent().removeClass("selected");
// 			 $("#tr_isWedding").hide();
			 
			 if ("10" == siteCode) {
				 $("#coreEmail").parent().addClass("disabled");
				 $("#coreSms").parent().addClass("disabled");
				 $("#children_number").hide();
				 $("#tr_receiveDm").hide();
			 } else if ("20" == siteCode) {
				 $("#retailMallEmail").parent().addClass("disabled");
				 $("#retailMallSms").parent().addClass("disabled");
			 } else {
				 $("#retailMallEmail").parent().addClass("disabled");
				 $("#retailMallSms").parent().addClass("disabled");
				 $("#coreEmail").parent().addClass("disabled");
				 $("#coreSms").parent().addClass("disabled");
				 $("#tr_receiveDm").hide();
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
	
	
	// siteId별 제휴사이트, 마케팅 수신 정보 동의 순서 조정
	var strHtml = "";
	var strHtml2 = "";
	if ("10" == siteCode) {
		$("#children_number").hide();
		
	} else if ("20" == siteCode) {
		// 제휴 사이트
 		$("#partnerShipSpan").html("");
 		$("#partnerShipDiv").html("");
 		strHtml += '<span class="customCheck selected readonly">';
		strHtml += '<input type="checkbox" id="corePartnerShip" name="partnerShip" class="checkBox readonly" checked="true">';
		strHtml += '</span>';
		strHtml += '<label for="select_site1" class="label_txt"><spring:message code="name.elandretail" /></label>';
		strHtml2 += '<span class="customCheck">';
		strHtml2 += '<input type="checkbox" id="retailMallPartnerShip" name="partnerShip" class="checkBox" onclick="javascript:marketingShowAndHide(this)">';
		strHtml2 += '</span>';
		strHtml2 += '<label for="select_site1-1" class="label_txt"><spring:message code="name.elandmall" /></label>';
 		$("#partnerShipSpan").html(strHtml);
 		$("#partnerShipDiv").html(strHtml2);
		
 		strHtml = "";
 		strHtml2 = "";
 		// 이메일
 		$("#emailSpan").html("");
 		$("#emailDiv").html("");
 		strHtml += '<span class="customCheck selected">';
 		strHtml += '<input type="checkbox" id="coreEmail" name="receiveEmail" checked="true" class="checkBox" onclick="javascript:clickReceiveEmail();">';
 		strHtml += '</span>';
 		strHtml += '<label for="select_site2" class="label_txt"><spring:message code="name.elandretail" /></label>';
 		strHtml2 += '<span class="customCheck">';
		strHtml2 += '<input type="checkbox" id="retailMallEmail" name="receiveEmail" class="checkBox" onclick="javascript:clickReceiveEmail();">';
		strHtml2 += '</span>';
		strHtml2 += '<label for="select_site2-1" class="label_txt"><spring:message code="name.elandmall" /></label>';
 		$("#emailSpan").html(strHtml);
 		$("#emailDiv").html(strHtml2);
 		
 		strHtml = "";
 		strHtml2 = "";
 		// SMS
 		$("#smsSpan").html("");
 		$("#smsDiv").html("");
 		strHtml += '<span class="customCheck selected">';
 		strHtml += '<input type="checkbox" id="coreSms" name="receiveSms" checked="true" class="checkBox" onclick="javascript:clickReceiveSms();">';
 		strHtml += '</span>';
 		strHtml += '<label for="select_site3" class="label_txt"><spring:message code="name.elandretail" /></label>';
 		strHtml2 += '<span class="customCheck">';
		strHtml2 += '<input type="checkbox" id="retailMallSms" name="receiveSms" class="checkBox" onclick="return false;" onclick="javascript:clickReceiveSms();">';
		strHtml2 += '</span>';
		strHtml2 += '<label for="select_site3-1" class="label_txt"><spring:message code="name.elandmall" /></label>';
		$("#smsSpan").html(strHtml);
 		$("#smsDiv").html(strHtml2);
 		
 		$("#tr_receiveDm").show();
 		
	} else {
		//원클릭 회원가입
		$("#partnerShipSpan").html("");
 		$("#partnerShipDiv").html("");
		
		strHtml += '<span class="customCheck">';
		strHtml += '<input type="checkbox" id="retailMallPartnerShip" name="partnerShip" checked="true" class="checkBox" onclick="javascript:marketingShowAndHide(this);">';
		strHtml += '</span>';
		strHtml += '<label for="select_site1" class="label_txt"><spring:message code="name.elandmall" /></label>';
 		strHtml += '<span class="customCheck">';
		strHtml += '<input type="checkbox" id="corePartnerShip" name="partnerShip" class="checkBox" checked="true" onclick="javascript:marketingShowAndHide(this);">';
		strHtml += '</span>';
		strHtml += '<label for="select_site1-1" class="label_txt"><spring:message code="name.elandretail" /></label>';
 		$("#partnerShipDiv").html(strHtml);
 		
 		$("#emailSpan").html("");
 		$("#emailDiv").html("");
 		strHtml = "";
 		strHtml += '<span class="customCheck">';
		strHtml += '<input type="checkbox" id="retailMallEmail" name="receiveEmail" checked="" class="checkBox" onclick="javascript:clickReceiveEmail();">';
		strHtml += '</span>';
		strHtml += '<label for="select_site2" class="label_txt"><spring:message code="name.elandmall" /></label>';
 		strHtml += '<span class="customCheck">';
 		strHtml += '<input type="checkbox" id="coreEmail" name="receiveEmail" checked="true" class="checkBox" onclick="javascript:clickReceiveEmail();">';
 		strHtml += '</span>';
 		strHtml += '<label for="select_site2-1" class="label_txt"><spring:message code="name.elandretail" /></label>';
 		$("#emailDiv").html(strHtml);
 		
 		$("#smsSpan").html("");
 		$("#smsDiv").html("");
 		strHtml = "";
 		strHtml += '<span class="customCheck">';
		strHtml += '<input type="checkbox" id="retailMallSms" name="receiveSms" checked="true" class="checkBox" onclick="javascript:clickReceiveSms();">';
		strHtml += '</span>';
		strHtml += '<label for="select_site3" class="label_txt"><spring:message code="name.elandmall" /></label>';
 		strHtml += '<span class="customCheck selected">';
 		strHtml += '<input type="checkbox" id="coreSms" name="receiveSms" checked="true" class="checkBox" onclick="javascript:clickReceiveSms();">';
 		strHtml += '</span>';
 		strHtml += '<label for="select_site3-1" class="label_txt"><spring:message code="name.elandretail" /></label>';
 		$("#smsDiv").html(strHtml);
 		
 		$("#check_site").addClass("on");
 		$("#check_site > span").text("전체해제");
 		
 		$("#check_email").addClass("on");
 		$("#check_email > span").text("전체해제");
 		
 		$("#check_sms").addClass("on");
 		$("#check_sms > span").text("전체해제");
 		
 		$("#tr_receiveDm").show();
	}
	
	customCheckbox();
	
	// 오프라인 회원정보 사용 여부 팝업
	var isExistsMember = ${isExistsMember};
	if ( isExistsMember ) {
		// 레이어 팝업 호출
		modalLayer2();
	}
	
});


/**
 *  오프라인 가입 정보 사용
 */
function setExistMemberInfo() {
	
	// 주소
	var addr1 = "${existsMemberInfo.addr1}";
	var addr2 = "${existsMemberInfo.addr2}";
	var zipCode = "${existsMemberInfo.zipCode}";
	var addrType = "${existsMemberInfo.selectAddr}";
	$("#addr").val("(" + zipCode + ") " + addr1);
	$("#addrDetail").val(addr2);
	
	
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
	$("#label_year").text(birthYear);
	$("#year").val(birthYear);
	$("#label_month").text(birthMonth);
	$("#month").val(birthMonth);
	$("#label_day").text(birthDay);
	$("#day").val(birthDay);
	
	// 양 음력
	var birthUnar = "${existsMemberInfo.birthUnar}";
	$("input[name='solarLunar']").each(function() {  $(this).parent("span").removeClass("selected")  });
	if ("S" == birthUnar) {
		$("#solar").parent("span").addClass("selected");
	} else {
		$("#lunar").parent("span").addClass("selected");
	}
	
	// 이메일
	var email1 = "${existsMemberInfo.email1}";
	var email2 = "${existsMemberInfo.email2}";
	$("#input_email1").val(email1);
	$("#input_email2").val(email2);
	
	// 휴대전화
	var mobilNo1 = "${existsMemberInfo.mobileNo1}";
	var mobilNo2 = "${existsMemberInfo.mobileNo2}";
	var mobilNo3 = "${existsMemberInfo.mobileNo3}";
	
	$("#label_mobile").val(mobilNo1);
	$("#mobile").val(mobilNo1);
	$("#phoneNumber2").val(mobilNo2);
	$("#phoneNumber3").val(mobilNo3);
	
	// 결혼 여부
	var weddingYn = "${existsMemberInfo.weddingYn}";
	
	// 결혼 기념일
	var weddingYear = "${existsMemberInfo.weddingYear}";
	var weddingMonth = "${existsMemberInfo.weddingMonth}";
	var weddingDay = "${existsMemberInfo.weddingDay}";
	
	// 결혼 유무
	$("input[name='isWedding']").each(function() {  $(this).parent("span").removeClass("selected")  });
	if ("Y" == weddingYn) {
		$("#wedding").parent("span").addClass("selected");
		
		// 결혼 기념일
		if (weddingYear != null && weddingMonth != null && weddingDay != null) {
			$("#label_m_year").text(weddingYear);
			$("#m_year").val(weddingYear);
			$("#label_m_month").text(weddingMonth);
			$("#m_month").val(weddingMonth);
			$("#label_m_day").text(weddingDay);
			$("#m_day").val(weddingDay);
		}
	} else {
		$("#single").parent("span").addClass("selected");
		
		$("#wedding_anniversary").hide();
		$("#children_number").hide();
	}
	
	

	
	if ("10" != "${siteCode}") {
		// DM 수신 여부
		$("input[name='dmRadio']").each(function() {  
			$(this).parent("span").removeClass("selected")
			$(this).removeAttr("checked");
		});
		var dmYn = "${existsMemberInfo.coreDmYn}";
		if ("N" == dmYn || null == dmYn) {
			$("#notReceiveDm").parent("span").addClass("selected");
			$("#notReceiveDm").attr("checked", true);
		} else {
			$("#receiveDm").parent("span").addClass("selected");
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
						$("input[name='gender1']").each(function() {  $(this).parent("span").removeClass("selected")  });
						var childGender = "${child.childGender}";
						if ("M" == childGender) {
							$("#male1").parent("span").addClass("selected");
						} else {
							$("#female1").parent("span").addClass("selected");
						}
						
						// 양음력 초기화
						$("input[name='childBirth']").each(function() {  $(this).parent("span").removeClass("selected")  });
						var childUnar = "${child.childUnar}";
						if ("S" == childUnar) {
							$("#solar1").parent("span").addClass("selected");
						} else {
							$("#lunar1").parent("span").addClass("selected");
						}
						
						var childName = "${child.childName}";
						$("#childName1").val(childName);
						
						var childBirthDay = "${child.childBirthDay}";	
						var childBirthMonth	= "${child.childBirthMonth}";	
						var childBirthYear = "${child.childBirthYear}";	
						$("#label_child_year1").text(childBirthYear);
						$("#child_year1").val(childBirthYear);
						$("#label_child_month1").text(childBirthMonth);
						$("#child_month1").val(childBirthMonth);
						$("#label_child_day1").text(childBirthDay);
						$("#child_day1").val(childBirthDay);
					} else {
						
						addChildTr();
						
						$("input[name='gender"+("${i.index+1}")+"']").each(function() {  $(this).parent("span").removeClass("selected")  });
						var childGender = "${child.childGender}";
						if ("M" == childGender) {
							$("#male"+ ("${i.index+1}")).parent("span").addClass("selected");
						} else {
							$("#female"+ ("${i.index+1}")).parent("span").addClass("selected");
						}
						
						// 양음력 초기화
						$("input[name='childBirth"+ ("${i.index+1}")+"']").each(function() {  $(this).parent("span").removeClass("selected")  });
						var childUnar = "${child.childUnar}";
						if ("S" == childUnar) {
							$("#solar"+("${i.index+1}")).parent("span").addClass("selected");
						} else {
							$("#lunar"+("${i.index+1}")).parent("span").addClass("selected");
						}
						var childName = "${child.childName}";
						$("#childName"+("${i.index+1}")).val(childName);
						
						var childBirthDay = "${child.childBirthDay}";	
						var childBirthMonth	= "${child.childBirthMonth}";	
						var childBirthYear = "${child.childBirthYear}";	
						$("#label_child_year"+("${i.index+1}")).text(childBirthYear);
						$("#child_year"+("${i.index+1}")).val(childBirthYear);
						$("#label_child_month"+("${i.index+1}")).text(childBirthMonth);
						$("#child_month"+("${i.index+1}")).val(childBirthMonth);
						$("#label_child_day"+("${i.index+1}")).text(childBirthDay);
						$("#child_day"+("${i.index+1}")).val(childBirthDay);
						
						customRadio();
					}
				</c:forEach>
			}
		}
	} 
}



function addChildTr() {
	// 2016-02-22 자녀정보 추가 삭제
	
		var trCount = $("#tbody_children > tr").size() + 1;
		
		var strHtml = "";
		strHtml += '<tr>';
		strHtml += '	<td>';
		strHtml += '		<div class="taL">';
		strHtml += '			<input type="radio" id="male'+trCount+'" name="gender'+trCount+'" class="radioBtn" checked=""><label for="male'+trCount+'" class="label_txt m1">남</label>';
		strHtml += '			<input type="radio" id="female'+trCount+'" name="gender'+trCount+'" class="radioBtn"><label for="female'+trCount+'" class="label_txt">여</label>';
		strHtml += '		</div>';
		strHtml += '		<div class="mt10"><input type="text" id="childName'+trCount+'" name="childName'+trCount+'" class="input_text w50" title="이름 입력"></div>';
		strHtml += '	</td>';
		strHtml += '	<td>';
		strHtml += '		<div class="taL">';
		strHtml += '			<input type="radio" id="solar'+trCount+'" name="childBirth'+trCount+'" class="radioBtn" checked=""><label for="solar'+trCount+'" class="label_txt m1">양력</label>';
		strHtml += '			<input type="radio" id="lunar'+trCount+'" name="childBirth'+trCount+'" class="radioBtn"><label for="lunar'+trCount+'" class="label_txt">음력</label>';
		strHtml += '		</div>';	
		strHtml += '		<div class="mt10">';
		strHtml += '			<div class="selectBox w75">';
		strHtml += '				<label for="child_year" id="label_child_year'+trCount+'">선택</label>';
		strHtml += '				<select class="select" id="child_year'+trCount+'" onchange="chgChildBirthYear(this.value);">';
		strHtml += '					<option value="">2016</option>';
		strHtml += '				</select>';
		strHtml += '			</div><!-- // selectBox-->';
		strHtml += '			<span class="br">년</span>';
		strHtml += '			<div class="selectBox w75">';
		strHtml += '				<label for="child_month" id="label_child_month'+trCount+'">선택</label>';
		strHtml += '				<select class="select" id="child_month'+trCount+'" onchange="chgChildBirthMonth(this.value, true,'+trCount+')">';
		strHtml += '					<option value="">2016</option>';
		strHtml += '				</select>';			
		strHtml += '			</div><!-- // selectBox-->';			
		strHtml += '			<span class="br">월</span>';			
		strHtml += '				<div class="selectBox w75">';			
		strHtml += '					<label for="child_day" id="label_child_day'+trCount+'">선택</label>';			
		strHtml += '					<select class="select" id="child_day'+trCount+'">';			
		strHtml += '						<option value="">2016</option>';			
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
		
		// 셀렉트박스
		var select = $("select.select");
		select.change(function(){
			var select_name = $(this).children("option:selected").text();
			$(this).siblings("label").text(select_name);
		});
		
		customRadio();
}

function removeChildTr(args) {
	$(args).closest("tr").remove();
}


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
	for (var i=year; i>=1900; i--) {
		strYear += "<option value='" + i + "' >" + i + "</option>";
	}
	
	// 월, 일 설정
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
		$("#year").append(strYear);
		$("#month").append(strMonth);
		$("#day").append(strDay);
		$("#m_year").append(strYear);
		$("#m_month").append(strMonth);
		$("#m_day").append(strDay);
		
		$("#child_year1").append(strYear);
		$("#child_month1").append(strMonth);
		$("#child_day1").append(strDay);
		
		
		
		// 본인인증으로부터 받은 생년월일 세팅
		var birth = "${birth}";
		if (birth != "") {
			$("#year").val(birth.substring(0,4));
			$("#month").val(birth.substring(4,6));
			$("#day").val(birth.substring(6,8));
			$("#label_year").text(birth.substring(0,4));
			$("#label_month").text(birth.substring(4,6));
			$("#label_day").text(birth.substring(6,8));
		} else {
			$("#year").val("1980");
			$("#month").val("01");
			$("#day").val("01");
			$("#label_year").text("1980");
			$("#label_month").text("01");
			$("#label_day").text("01");
		}

	} else {
		$("#"+param1).html(strYear);
		$("#"+param2).html(strMonth);
		$("#"+param3).html(strDay);
	}
}




/**
 * 아이디 중복 체크
 */
 function isCheckId() {
	var inputWebId = $("#webId").val();
	var regType1 = /^[a-z]+[a-z-_0-9]{4,19}$/g;
	
	if (inputWebId == "") {
		var strHtml = "<em class='fail'>아이디를 입력해주세요.</em>";
		// valdation 이전 메세지 삭제
		 $("#td_webId > em").remove();
		// valdation 메세지 삽입
		 $("#td_webId").append(strHtml);
		 return;
	}
	
	if (!regType1.test(inputWebId)) { 
		 var strHtml = "<em class='fail'>아이디는 영문자로 시작하는 5~20자 영문자 또는 숫자이어야 합니다.</em>";
		// valdation 이전 메세지 삭제
		 $("#td_webId > em").remove();
		// valdation 메세지 삽입
		 $("#td_webId").append(strHtml);
		 return;
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
 
 function idCheckResult(param) {
	 
	 // 중복된 아이디
	 var strHtml = "";
	 if (param) {
		 strHtml = "<em class='fail'>이미 사용중인 아이디입니다.</em>";
		 $("#hidIdCheck").val(false);
	 } else {
		 strHtml = "<em class='valid'>사용 가능한 아이디입니다.</em>";
		 $("#hidIdCheck").val(true);
	 }
	 // valdation 이전 메세지 삭제
	 $("#td_webId > em").remove();
	// valdation 메세지 삽입
	 $("#td_webId").append(strHtml);
 }
 
 /**
  * 입력폼 validation
  */
 function validationCheck() {
	 var strHtml = "";
	if ($("#webId").val() == "") {
		strHtml = "<em class='fail'>아이디를 입력해 주세요.</em>";
		$("#td_webId").append(strHtml);
		$("#webId").focus();
		return;
	}
	if ($("#hidIdCheck").val() == "") {
		strHtml = "<em class='fail'>아이디 중복 체크를 해주세요.</em>";
		$("#td_webId").append(strHtml);
		$("#webId").focus();
		return;
	}
	
	if ($("#password").val() == "") {
		strHtml = "<em class='fail'>비밀번호를 입력해 주세요.</em>";
		$("#em_pwdValidMsg").html("");
		$("#em_pwdValidMsg").append(strHtml);
		$("#password").focus();
		return;
	}
	if (!$("#hidPwdCheck").val()) {
		strHtml = "<em class='fail'>비밀번호를 입력해 주세요.</em>";
		$("#em_pwdValidMsg2").html("");
		$("#em_pwdValidMsg2").append(strHtml);
		$("#confirmPassword").focus();
		return;
	}
	
	if ($("#password").val() != $("#confirmPassword").val()) {
		var strHtml = "<em class='fail'>비밀번호가 같지 않습니다.</em>";
		$("#em_pwdValidMsg2").html("");
 		$("#em_pwdValidMsg2").append(strHtml);
 		$("#hidPwdCheck").val(false);
 		$("#confirmPassword").focus();
 		return;
	} 	
	
	var password = $("#password").val();
	birth.push($("#year option:selected").val(), $("#month option:selected").val()+$("#day option:selected").val());
	phone.push($("#phoneNumber2").val(), $("#phoneNumber3").val());
	
	
	if ($("#year").val() == "") {
		$("#td_birth > em").remove();
		strHtml = "<em class='fail'>생년월일을 입력해 주세요.</em>";
		$("#td_birth").append(strHtml);
		$("#year").focus();
		return;
	}
	
	if ($("#month").val() == "") {
		$("#td_birth > em").remove();
		strHtml = "<em class='fail'>생년월일을 입력해 주세요.</em>";
		$("#td_birth").append(strHtml);
		$("#month").focus();
		return;
	}
	
	if ($("#day").val() == "") {
		$("#td_birth > em").remove();
		strHtml = "<em class='fail'>생년월일을 입력해 주세요.</em>";
		$("#td_birth").append(strHtml);
		$("#day").focus();
		return;
	}
	
	
	if ($("#phoneNumber2").val() == "") {
		strHtml = "<em class='fail'>핸드폰 번호를 입력해 주세요.</em>";
		
		$("#td_phone > em").remove();
		$("#td_phone").append(strHtml);
		$("#phoneNumber2").focus();
		return;
	}
	if ("010" == $("#mobile").val()) {
		if ($("#phoneNumber2").val().length < 4) {
			strHtml = "<em class='fail'>핸드폰 번호 자리수가 부족합니다.</em>";
			$("#td_phone > em").remove();
			$("#td_phone").append(strHtml);
			$("#phoneNumber2").focus();
			return;
		}
	}
	
	if ($("#phoneNumber3").val().length < 4) {
		strHtml = "<em class='fail'>핸드폰 번호 자리수가 부족합니다.</em>";
		$("#td_phone > em").remove();
		$("#td_phone").append(strHtml);
		$("#phoneNumber3").focus();
		return;
	}
	
	if ($("#phoneNumber3").val() == "") {
		strHtml = "<em class='fail'>핸드폰 번호를 입력해 주세요.</em>";
		$("#td_phone > em").remove();
		$("#td_phone").append(strHtml);
		$("#phoneNumber3").focus();
		return;
	}
	
	if ($("#addr").val() == "") {
		strHtml = "<em class='fail'>주소를 입력해 주세요.</em>";
		$("#td_addr > em").remove();
		$("#td_addr").append(strHtml);
		$("#addrDetail").focus();
		return;
	}
	
	if ($("#input_email1").val() == "" && $("#input_email2").val() == "") {
		strHtml = "<em class='fail'>이메일을 입력해 주세요.</em>";
		$("#td_email > em").remove();
		$("#td_email").append(strHtml);
		$("#input_email1").focus();
		return;
	} else {
		var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
		if(!reg_email.test($("#input_email1").val() +"@"+ $("#input_email2").val()))
		{
			strHtml = "<em class='fail'>잘못된 이메일 형식입니다.</em>";
			
			$("#td_email > em").remove();
			$("#td_email").append(strHtml);
			$("#input_email1").focus();
			return;
		}
	}
	
	if (!$("input[name=partnerShip]").is(":checked")) {
		strHtml = "<em class='fail'>제휴사이트를 선택해 주세요.</em>";
		$("#td_partnerShip > em").remove();
		$("#td_partnerShip").append(strHtml);
		$("#retailMallPartnerShip").focus();
		
		return;
	}
	
	if (!validatePassword($("#password").val(), $("#webId").val())) {
		return;
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
	 	// 양력, 음력 설정
	 	if ($("input[name=solarLunar]:checked").attr("id") == "solar") {
	 		$("#hidBirthUnar").val("S");
		} else  {
			$("#hidBirthUnar").val("L");
		}
 
		// 생년월일 히든값 처리
		$("#hidBirth").val($("#year option:selected").val()+$("#month option:selected").val()+$("#day option:selected").val());
		
		// 핸드폰 번호 히든값 처리
		$("#hidPhone").val($("#mobile option:selected").val() + $("#phoneNumber2").val() + $("#phoneNumber3").val());  
		
		// 이메일 히든값 처리
		$("#hidEmail").val($("#input_email1").val() +"@"+ $("#input_email2").val());
		
		// 제휴사이트 히든값 처리
		if ($("#retailMallPartnerShip").is(":checked")) {
			$("#hidRetailMallPartnerShipYn").val("Y");
		} else {
			$("#hidRetailMallPartnerShipYn").val("N");
		}
		
		if ($("#corePartnerShip").is(":checked")) {
			$("#hidCorePartnerShipYn").val("Y");
		} else {
			$("#hidCorePartnerShipYn").val("N");
		}
		// 이메일 수신 여부 히든값 처리
		if ($("#retailMallEmail").is(":checked")) {
			$("#hidRetailMallEmailYn").val("Y");
		} else {
			$("#hidRetailMallEmailYn").val("N");
		}
		
		if ($("#coreEmail").is(":checked")) {
			$("#hidCoreEmailYn").val("Y");
		} else {
			$("#hidCoreEmailYn").val("N");
		}
		
		// SMS 수신 여부 히든값 처리
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
		
		// DM 수신 여부 히든값 처리
		if ("receiveDm" == $("input[name=dmRadio]:checked").attr("id")) {
			$("#hidDmYn").val("Y");
		} else {
			$("#hidDmYn").val("N");
		}
		
		// 결혼 기념일
		$("#hidWeddingDay").val($("#m_year option:selected").val() + $("#m_month option:selected").val() + $("#m_day option:selected").val());
		
		// TODO : 자녀수
		var childCnt = $("#tbody_children > tr").size();
		var childgenders = "";
		var childUnars = "";
		var childNames = "";
		var childBirth = "";
		// 생성한 자녀수 tr 만큼 loof
		for (var i=0; i < childCnt; i++) {
			// 자녀의 이름, 생년월일이 입력된 tr만 처리
			if ($("#childName" + (i+1)).val() != "" && $("#child_year" + (i+1) + " option:selected").val() != "" 
					&& $("#child_month" + (i+1) + " option:selected").val() != "" 
					&& $("#child_day" + (i+1) + " option:selected").val() != "") {
				// 성별
				if ($("#male"+(i+1)).is(":checked")) {
					childgenders += "M,";
				} else {
					childgenders += "F,";
				}
				
				// 양력, 음력
				if ($("#solar"+(i+1)).is(":checked")) {
					childUnars += "S,";
				} else {
					childUnars += "L,";
				}
				
				// 자녀 이름
				childNames += $("#childName"+(i+1)).val() + ",";
				
				// 자녀 생년월일
				childBirth += $("#child_year" + (i+1) + " option:selected").val() + $("#child_month" + (i+1) + " option:selected").val() + $("#child_day" + (i+1) + " option:selected").val() + ",";; 
			}
		}
		
		$("#hidChildGender").val(childgenders);
		$("#hidChildName").val(childNames);
		$("#hidChildBirthday").val(childBirth);
		$("#hidChildUnar").val(childUnars);
 }		
 
 
 
 
 
 /**
  * 주소 찾기 팝업 띄우기
  */
 function searchAddr() {
	 openCommonPopup("/member/searchAddrPopup", "", "560", "700", "주소찾기");
	 
 }
 
 function setAddr(addrList) {
	 
	 for (var i=0; i< addrList.length; i++) {
		 if (i == 0) {
			 $("#addr").val("(" + addrList[i].postNo + ")" + addrList[i].addr);
			 $("#addrDetail").val(addrList[i].addr2);
			 
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
	 
	 $("#td_addr > em").remove();
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
  * 전화번호만 입력
  */
  function showKeyCode(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || keyID == 9 || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
		{
			return;
		}
		else
		{
			return;
		}
	}
 
/**
 * 제휴사이트 DM 수신 DIV 노출, 마케팅 수신 동의 (부가정보도 포함)
 */
 function marketingShowAndHide(args) {
	 if (args.id == "retailMallPartnerShip" ) {
		 if (args.checked) {
			 $("#retailMallEmail").parent().removeClass("disabled");
			 $("#retailMallSms").parent().removeClass("disabled");
			 
			 $("#tr_isWedding").show();
		 } else {
			 $("#retailMallEmail").parent().addClass("disabled");
			 $("#retailMallSms").parent().addClass("disabled");
		 }
	 } else {
		 if (args.checked) {
			$("#coreEmail").parent().removeClass("disabled");
			$("#coreSms").parent().removeClass("disabled");
			 
			$("#tr_receiveDm").show();
			$("#tr_isWedding").show();
			$("#children_number").show();
		 } else {
			 $("#coreEmail").parent().addClass("disabled");
			 $("#coreSms").parent().addClass("disabled");
			 
			 $("#tr_receiveDm").hide();
			 $("#children_number").hide();
			 
		 }
	 }
 }
 
 /**
  * 결혼 유무에 따라 결혼 기념일, 자녀수 노출
  */
 function isWeddingCheck(args) {
	 if ("single" == args) {
		$("#hidWeddingYn").val("N");
		$("#wedding_anniversary").hide();
		$("#children_number").hide();
	 } else {
		$("#hidWeddingYn").val("Y");
		$("#wedding_anniversary").show();
		$("#children_number").show();
	 }
	 
 }
 
 /**
  * 가입 취소
  */
  function cancelJoin() {
	 alert("회원가입을 취소하시겠습니까?");
	 location.href = "/";
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
 
 
 $(window).load(function () {
	if("10" == siteCode) {
		$("#coreEmail").parent().addClass("disabled");
		 $("#coreSms").parent().addClass("disabled");
	} else if ("20" == siteCode) {
		 $("#retailMallEmail").parent().addClass("disabled");
		 $("#retailMallSms").parent().addClass("disabled");
	}

	
});
 
 

 
function goToMainPage() {
	location.href = "/";
} 
</script>


<script>
    var checkUnload = true;
    $(window).on("beforeunload", function(){
        if(checkUnload && !invalidAccess) return "이 페이지를 벗어나면 작성된 내용은 저장되지 않습니다.";
    });
</script>




<div class="content">
	<c:choose>
		<c:when test="${10 eq siteCode}">
			<h3><span class="en"><spring:message code="name.elandmall" /></span> 회원가입</h3>
		</c:when>
		<c:when test="${20 eq siteCode}">
			<h3><span class="en"><spring:message code="name.elandretail" /></span> 회원가입</h3>
		</c:when>
		<c:otherwise>
			<h3><span class="en"><spring:message code="name.elandoneclick" /></span> 회원가입</h3>
		</c:otherwise>
	</c:choose>
	<div class="stepBox">
		<ol>
			<li><span>STEP 01</span>본인확인</li>
			<li><span>STEP 02</span>약관동의</li>
			<li class="on"><span>STEP 03</span>정보입력</li>
			<li><span>STEP 04</span>가입완료</li>
		</ol>
	</div><!-- // stepBox -->
	
	<!-- 기본정보 -->
	<form action="/member/joinMemberSuccess" name="joinForm" id="joinForm" method="POST">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class="fieldDiv mt30">
		<fieldset>
			<legend class="tit_bl">기본정보</legend>
			<p class="guide">(<span class="ns">*</span>)표시는 필수입력항목입니다.</p>
			<div class="fieldTable mt10">
				<table cellspacing="0" summary="이름, 회원아이디, 비밀번호, 비밀번호재입력, 생년월일, 핸드폰번호, 주소, 이메일">
					<!-- 2016-02-19 수정 -->
						<colgroup>
							<col class="col180" />
							<col class="col590" />
						</colgroup>
					<!-- // 2016-02-19 수정 -->

						<tbody>
							<tr>
								<th scope="row"><div class="tit">이름 <span class="ns" title="필수입력">*</span></div></th>
								<td><span class="txt"><c:out value="${userName}" /></span></td>
							</tr>
							<tr>
								<th scope="row"><div class="tit">회원아이디 <span class="ns" title="필수입력">*</span></div></th>
								<td id="td_webId">
									<input type="text" id="webId" name="webId" class="input_text w390" title="아이디 입력"><button type="button" class="btn grey" onclick="javascript:isCheckId()"><span>아이디 중복체크</span></button>
								</td>
							</tr>
							<tr>
								<th scope="row"><div class="tit">비밀번호 <span class="ns" title="필수입력">*</span></div></th>
								<td >
									<input type="password" id="password" name="password" class="input_text w390" title="비밀번호 입력">
									<div id="em_pwdValidMsg"></div>
									<em class="warn">연속적인 숫자나 생일, 전화번호등 추측하기 쉬운 개인정보 및 아이디와 비슷한 전화번호 사용을 피하시기 바랍니다.<br>비밀번호는 영대문자, 영소문자, 숫자, 특수문자 중 3종류 이상을 조합하여, 총 8~16자리로 구성하셔야 합니다.</em>
								</td>
							</tr>
							<tr>
								<th scope="row"><div class="tit">비밀번호재입력 <span class="ns" title="필수입력">*</span></div></th>
								<td id="td_confirmPassword">
									<input type="password" id="confirmPassword" name="confirmPassword" class="input_text w390" title="비밀번호 재입력">
									<div id="em_pwdValidMsg2"></div>
								</td>
								
							</tr>
							<tr>
								<th scope="row"><div class="tit">생년월일 <span class="ns" title="필수입력">*</span></div></th>
								<td id="td_birth">
									<div class="selectBox">
										<label for="year" id="label_year">선택</label>
										<select class="select" id="year" onchange="chgYear(this.value);">
											<option value="">선택</option>
										</select>
									</div><!-- // selectBox-->
									<span class="br">년</span>
									<div class="selectBox">
										<label for="month" id="label_month">선택</label>
										<select class="select" id="month" onchange="chgMonth(this.value, true);">
											<option value="">선택</option>
										</select>
									</div><!-- // selectBox-->
									<span class="br">월</span>
									<div class="selectBox">
										<label for="day" id="label_day">선택</label>
										<select class="select" id="day" onchange="chgDay(this.value, true);">
											<option value="">선택</option>
										</select>
									</div><!-- // selectBox-->
									<span class="br">일</span>
									<div class="birth_select">
										<input type="radio" id="solar" name="solarLunar" class="radioBtn" checked=""/><label for="birth3" class="label_txt m1">양력</label>
										<input type="radio" id="lunar" name="solarLunar" class="radioBtn" /><label for="birth4" class="label_txt">음력</label>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><div class="tit">핸드폰번호 <span class="ns" title="필수입력">*</span></div></th>
								<td id="td_phone">
									<div class="selectBox">
										<label for="mobile" id="label_mobile">010</label>
										<select class="select" id="mobile" title="핸드폰번호">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="017">017</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select>
									</div><!-- // selectBox-->
									<span class="br">-</span>
									<input type="text" id="phoneNumber2" name="phoneNumber2" class="input_text w110" maxlength="4" title="중간자리" onkeydown="return showKeyCode(event)">
									<span class="br">-</span>
									<input type="text" id="phoneNumber3" name="phoneNumber3" class="input_text w110" maxlength="4" title="뒷자리" onkeydown="return showKeyCode(event)">
								</td>
							</tr>
							<tr>
								<th scope="row"><div class="tit">주소 <span class="ns" title="필수입력">*</span></div></th>
								<td id="td_addr">
									<input type="text" id="addr" name="addr" class="input_text w390 disabled" disabled="" title="주소" value=""><a href="javascript:searchAddr();" class="btn grey"><span>주소찾기</span></a>
									<div class="mt10"><input type="text" id="addrDetail" name="addrDetail" class="input_text w390" title="상세주소" value=""></div>
								</td>
							</tr>
							<tr>
								<th scope="row"><div class="tit">이메일 <span class="ns" title="필수입력">*</span></div></th>
								<td id="td_email">
									<input type="text" id="input_email1" name="email_id" class="input_text w180" title="이메일주소">
									<span class="br m1">@</span>
									<input type="text" id="input_email2" name="email_addr" class="input_text w180">
									<div class="selectBox m2 w140">
										<label for="select-item">직접입력</label>
										<select class="select" id="select-item" onchange="javascript:selectEmail(this);">
											<option value="">직접입력</option>
				                            <option value="hanmail.net">hanmail.net</option>
				                            <option value="chol.com">chol.com</option>
				                            <option value="dreamwiz.com">dreamwiz.com</option>
				                            <option value="empal.com">empal.com</option>
				                            <option value="freechal.com">freechal.com</option>
				                            <option value="hanafos.com">hanafos.com</option>
				                            <option value="hotmail.com">hotmail.com</option>
				                            <option value="korea.com">korea.com</option>
				                            <option value="kornet.net">kornet.net</option>
				                            <option value="lycos.co.kr">lycos.co.kr</option>
				                            <option value="nate.com">nate.com</option>
				                            <option value="naver.com">naver.com</option>
				                            <option value="netian.com">netian.com</option>
				                            <option value="paran.com">paran.com</option>
				                            <option value="sayclub.com">sayclub.com</option>
				                            <option value="unitel.co.kr">unitel.co.kr</option>
				                            <option value="yahoo.com">yahoo.com</option>
				                            <option value="gmail.com">gmail.com</option>
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
		<fieldset>
			<legend class="tit_bl">이랜드 리테일 제휴 사이트 선택</legend>
			<div class="fieldTable mt10">
				<table cellspacing="0" summary="제휴 사이트 선택">
					<!-- 2016-02-19 수정 -->
					<colgroup>
						<col class="col180">
						<col class="col590">
					</colgroup>
					<!-- // 2016-02-19 수정 -->
					<tbody>
						<tr>
							<th scope="row"><div class="tit">제휴 사이트 선택</div></th><!-- // 2016-02-19 수정 -->
							<td id="td_partnerShip" class="inpd">
								<div class="allCheckLine">
									<span class="chk" id="partnerShipSpan">
										<span class="customCheck selected readonly">
											<input type="checkbox" id="retailMallPartnerShip" name="partnerShip" class="checkBox readonly" checked="true" >
										</span>
										<label for="select_site1" class="label_txt"><spring:message code="name.elandmall" /></label>
									</span><!-- 체크박스 선택/편집불가 상태일 경우 input에 addClass readonly -->
									<button type="button" class="btn white w95" id="check_site"><span>전체선택</span></button>
								</div>
								<div class="checkArea mt10" id="partnerShipDiv">
									<span class="customCheck">
										<input type="checkbox" id="corePartnerShip" name="partnerShip" class="checkBox" onclick="javascript:marketingShowAndHide(this);">
									</span>
									<label for="select_site1-1" class="label_txt"><spring:message code="name.elandretail" /></label>
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
				<table cellspacing="0" summary="이메일 수신, 문자수신, DM 수신">
					<!-- 2016-02-19 수정 -->
					<colgroup>
						<col class="col180">
						<col class="col590">
					</colgroup>
					<!-- // 2016-02-19 수정 -->
					<tbody>
						<tr>
							<th scope="row"><div class="tit">이메일 수신</div></th><!-- // 2016-02-19 수정 -->
							<td class="inpd">
								<div class="allCheckLine">
									<span class="chk" id="emailSpan">
										<span class="customCheck selected">
											<input type="checkbox" id="retailMallEmail" name="receiveEmail" class="checkBox" checked="" onclick="javascript:clickReceiveEmail();">
										</span>
										<label for="select_site2" class="label_txt"><spring:message code="name.elandmall" /></label></span>
									<button type="button" class="btn white w95" id="check_email"><span>전체선택</span></button>
								</div>
								<div class="checkArea mt10" id="emailDiv">
									<span class="customCheck readonly">
										<input type="checkbox" id="coreEmail" name="receiveEmail" class="checkBox" onclick="javascript:clickReceiveEmail();">
									</span>
									<label for="select_site2-1" class="label_txt"><spring:message code="name.elandretail" /></label>
								</div><!-- // checkArea -->
							</td>
						</tr>
						<tr>
							<th scope="row"><div class="tit">문자수신</div></th><!-- // 2016-02-19 수정 -->
							<td class="inpd">
								<div class="allCheckLine">
									<span class="chk" id="smsSpan">
										<span class="customCheck">
											<input type="checkbox" id="retailMallSms" name="receiveSms" class="checkBox" checked="" onclick="javascript:clickReceiveSms();">
										</span>
										<label for="select_site3" class="label_txt"><spring:message code="name.elandmall" /></label></span>
									<button type="button" class="btn white w95" id="check_sms"><span>전체선택</span></button>
								</div>
								<div class="checkArea mt10" id="smsDiv">
									<span class="customCheck readonly">
										<input type="checkbox" id="coreSms" name="receiveSms" class="checkBox" onclick="javascript:clickReceiveSms();">
									</span>
										<label for="select_site3-1" class="label_txt"><spring:message code="name.elandretail" /></label>
								</div><!-- // checkArea -->
							</td>
						</tr>
						<tr id=tr_receiveDm style="display:none;">
							<th scope="row">
								<div class="tit">
									DM 수신
								</div>
							</th><!-- // 2016-02-19 수정 -->
							<td>
								<div class="chk">
									
										<input type="radio" id="receiveDm" name="dmRadio" class="radioBtn">
										<label for="receiveDm" class="label_txt">우편수신</label>
										<input type="radio" id="notReceiveDm" name="dmRadio" class="radioBtn" checked="">
										<label for="notReceiveDm" class="label_txt">수신안함</label>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div><!-- // fieldTable -->
		</fieldset>
	</div>
	<!-- // fieldDiv :: 마케팅 정보 수신 동의 -->

	<!-- 부가정보 -->
	<div class="fieldDiv mt30">
	<fieldset>
		<legend class="tit_bl">부가정보</legend>
		<div class="fieldTable mt10">
			<table cellspacing="0" summary="전화번호, 결혼유무, 결혼기념일, 자녀수">
				<!-- 2016-02-19 수정 -->
				<colgroup>
					<col class="col180">
					<col class="col590">
				</colgroup>
				<!-- // 2016-02-19 수정 -->
					<tbody>
						<tr id="tr_isWedding">
							<th scope="row"><div class="tit">결혼유무</div></th><!-- // 2016-02-19 수정 -->
							<td>
								<div class="chk">
									
										<input type="radio" id="wedding" name="isWedding" class="radioBtn" checked="" onclick="isWeddingCheck('wedding');">
									
									<label for="wedding" class="label_txt">기혼</label>
									
										<input type="radio" id="single" name="isWedding" class="radioBtn" onclick="isWeddingCheck('single');">
									
									<label for="single" class="label_txt">미혼</label>
								</div>
							</td>
						</tr>
						<tr id="wedding_anniversary">
							<th scope="row"><div class="tit">결혼기념일</div></th><!-- // 2016-02-19 수정 -->
							<td>
								<div class="selectBox">
									<label for="m_year" id="label_m_year">선택</label>
									<select class="select" id="m_year" onchange="chgWedYear(this.value);">
										<option value="">선택</option>
									</select>
								</div><!-- // selectBox-->
								<span class="br">년</span>
								<div class="selectBox">
									<label for="m_month" id="label_m_month">선택</label>
									<select class="select" id="m_month" onchange="chgWedMonth(this.value, true);">
										<option value="">선택</option>
									</select>
								</div><!-- // selectBox-->
								<span class="br">월</span>
								<div class="selectBox">
									<label for="m_day" id="label_m_day">선택</label>
									<select class="select" id="m_day">
										<option value="">선택</option>
									</select>
								</div><!-- // selectBox-->
								<span class="br">일</span>
							</td>
						</tr>
						<tr id="children_number">
							<th scope="row"><div class="tit">자녀수</div></th><!-- // 2016-02-19 수정 -->
							<td class="inpd">
								<!-- // selectBox-->

								<!-- 2016-02-22 수정 -->
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
											<tr>
												<td>
													<div class="taL">
														<input type="radio" id="male1" name="gender1" class="radioBtn" checked="">
														<label for="male1" class="label_txt m1">남</label>
														<input type="radio" id="female1" name="gender1" class="radioBtn">
														<label for="female1" class="label_txt">여</label>
													</div>
													<div class="mt10">
														<input type="text" id="childName1" name="childName1" class="input_text w50" title="이름 입력">
													</div>
												</td>
												<td>
													<div class="taL">
														<input type="radio" id="solar1" name="childBirth" class="radioBtn" checked="">
														<label for="solar1" class="label_txt m1">양력</label>
														<input type="radio" id="lunar1" name="childBirth" class="radioBtn">
														<label for="runar1" class="label_txt">음력</label>
													</div>
													<div class="mt10">
														<div class="selectBox w75">
															<label for="child_year1" id="label_child_year1">선택</label>
															<select class="select" id="child_year1" onchange="chgChildBirthYear(this.value);">
																<option value="">선택</option>
															</select>
														</div><!-- // selectBox-->
														<span class="br">년</span>
														<div class="selectBox w75">
															<label for="child_month1" id="label_child_month1">선택</label>
															<select class="select" id="child_month1" onchange="chgChildBirthMonth(this.value, true, 1)">
																<option value="">선택</option>
															</select>
														</div><!-- // selectBox-->
														<span class="br">월</span>
														<div class="selectBox w75">
															<label for="child_day1" id="label_child_day1">선택</label>
															<select class="select" id="child_day1">
																<option value="">선택</option>
															</select>
														</div><!-- // selectBox-->
														<span class="br">일</span>
													</div>
												</td>
												<td>
													<button type="button" class="btn_pm plus" title="추가" onclick="javascript:addChildTr();"><span class="blind">추가</span></button>
													<button type="button" class="btn_pm minus" title="삭제"><span class="blind">삭제</span></button>
												</td>
											</tr>
										</tbody>
									</table>
								</div><!-- // innerTable-->
								
								<!-- // 2016-02-22 수정 -->
							</td>
						</tr>
					</tbody>
			</table>
		</div><!-- // fieldTable-->
	</fieldset>
</div>
<!-- // fieldDiv :: 부가정보 -->



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

<input type="hidden" id="hidEmail" name="email" />

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
<input type="hidden" id="hidChildBirthday" name="childBirthday" />
<input type="hidden" id="hidChildUnar" name="childUnar" />
<!-- Hidden Value //E -->

</form>
	<div class="btnDiv taC mt30">
		<a href="#cancel_join" class="btn white large open_modal"><span>가입취소</span></a>
		<a href="javascript:validationCheck();" class="btn blue large"><span>다음</span></a>
	</div>


	<div class="layerPop modal" id="cancel_join" aria-hidden="true" aria-labelledby="modalTitle2" role="alertdialog" aria-live="polit" style="top: 241px; left: 443px; display: none;">
		<div class="popupBox w420">
			<div class="popContent taC">
				회원가입을 취소하시겠습니까?
			</div><!-- // popContent -->
			<div class="btnDiv taC">
				<button type="button" class="btn white pop closeModalLayer"><span>취소</span></button>
				<button type="button" class="btn blue pop" onclick="javascript:goToMainPage();"><span>확인</span></button>
			</div>
			<button type="button" class="btn_popClose closeModalLayer"><span class="blind">팝업닫기</span></button>
		</div><!-- // popupBox -->
	</div>
	
	<div class="layerPop modal viewModal" id="exist_member" aria-hidden="true" aria-labelledby="modalTitle2" role="alertdialog" aria-live="polit" style="top: 241px; left: 443px; display: none;">
		<div class="popupBox w420">
			<div class="popContent taC">
				이랜드원클릭 오프라인 가입내역이 있습니다.<br>
				기존 회원정보를 사용하시겠습니까?
			</div><!-- // popContent -->
			<div class="btnDiv taC">
				<button type="button" class="btn white pop closeModalLayer"><span>취소</span></button>
				<button type="button" class="btn blue pop closeModalLayer" onclick="javascript:setExistMemberInfo();"><span>확인</span></button>
			</div>
			<button type="button" class="btn_popClose closeModalLayer"><span class="blind">팝업닫기</span></button>
		</div><!-- // popupBox -->
	</div>
</div>



