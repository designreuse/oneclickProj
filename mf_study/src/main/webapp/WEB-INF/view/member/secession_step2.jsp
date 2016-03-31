<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">

$(document).ready(function () {
	
	// 제휴사이트 모두 선택
	$("#check_site").click(function(){
		if (!$(this).hasClass("on")) {
			$(this).addClass("on").children().text("전체해제");
			$("input[name=check1]").prop("checked", true).parent().addClass("selected");
		} else {
			$(this).removeClass("on").children().text("전체선택");
			$("input[name=check1]").prop("checked", false).parent().removeClass("selected");
		}
	});
	
	// 탈퇴 사이트 선택
	if ("2" == "${selectMenu}") {
		$("#siteChoiceField").hide();
	}

});

$(window).load(function() {
	var retailMallJoinYn = ${retailMallJoinYn};
	var coreJoinYn = ${coreJoinYn};
	
	if (!retailMallJoinYn) {
		$("#select_site1").hide();
		$("label[for=select_site1]").hide();
		$("label[for=select_site1]").remove();
		$("#select_site1").remove();
	} else if (!coreJoinYn) {
		$("#select_site1-1").hide();
		$("label[for=select_site1-1]").hide();
		$("label[for=select_site1-1]").remove();
		$("#select_site1-1").remove();
	}
	
	if ("1" == "${selectMenu}") {
		if (retailMallJoinYn) {
			$("#select_site1").attr("checked", true);
		}
		if (coreJoinYn) {
			$("#select_site1-1").attr("checked", true);
		}
		if (retailMallJoinYn && coreJoinYn) {
			$("#check_site").addClass("on").children().text("전체해제");
		}
	}
	
	if ("1" == "${selectMenu}") {
		var outSiteCnt = $("#siteChoiceField").find("input[type=checkbox]:checked").size();
		if (outSiteCnt == 1) {
			$("#check_site").hide();
			$(".checkArea").css("border-top", "1px dotted #fff");
			$(".checkArea").css("padding-bottom", "0px");
		} else if (outSiteCnt == 2 && "30" == "${siteCode}") {
			$(".checkArea").css("border-top", "1px dotted #fff");
			$(".checkArea").css("padding-bottom", "0px");
		}
	}
});

/**
 * 탈퇴 사이트 선택 갯수에 따라 버튼 text 제어 
 */
function allSiteBtn() {
	var outSiteCnt = $("#siteChoiceField").find("input[type=checkbox]:checked").size();
	if (outSiteCnt < 2) {
		$("#check_site").addClass("on").children().text("전체선택");
	} else {
		$("#check_site").addClass("on").children().text("전체해제");
	}
}

function memberOutCancel() {
	// 탈퇴 신청한 사이트의 메인 페이지로 이동
	location.replace("/");
}

function outConfirm() {
	var outSiteCnt = $("#siteChoiceField").find("input[type=checkbox]:checked").size();
	
	if ("1" == "${selectMenu}" && outSiteCnt == 0) {
		$.confirm({
			title: '',
			confirmButtonClass: 'btn white',
			cancelButtonClass: 'btn blue',
			content: "선택한 사이트가 없습니다. 탈퇴를 취소하시겠습니까?",
			cancelButton: '취소',
			confirmButton: '확인',
			backgroundDismiss: true, // 2016-03-14 추가
			confirm: function () {
				location.replace("/");
				return;
			},
			cancel : function () {
				return;
			}
		});
	}
	
	memberOutComplete();
}

function memberOutComplete() {

	// 탈퇴 사이트 & 회원 상태
	var outSites = "";
	var outSiteCnt = $("#siteChoiceField").find("input[type=checkbox]:checked").size();
	
	if ("1" == "${selectMenu}") {
		if ($("#select_site1").is(":checked")) {
			outSites += "10&";
		}
		if ($("#select_site1-1").is(":checked")) {
			outSites += "20&";
		}
		
		var outSitesArray = outSites.split("&");
		var outSiteLength = outSitesArray.length-1;
		if (outSiteLength == 2) {
			$("#custStat").val("50");
		} else if (outSiteLength == 1) {
			var joinSiteCnt = $("#siteChoiceField").find("input[type=checkbox]").size();
			if (joinSiteCnt == 1) {
				$("#custStat").val("50");	
			} else {
				$("#custStat").val("40");
			}		
		}
	} else if ("2" == "${selectMenu}") {
		if ("true" == "${retailMallJoinYn}") {
			outSites += "10&";
		}
		if ("true" == "${coreJoinYn}") {
			outSites += "20&";
		}
		$("#custStat").val("50");
	}
	$("#outSiteCodes").val(outSites);

	// 탈퇴 사유
	var outReasons = "";
	var liRsonCnt = $(".discontent > ul > li").find("input[type=checkbox]").size();
	for (var j=1; j<liRsonCnt+1; j++) {
		if ($("#dis_"+j).is(":checked")) {
			outReasons += j+"0&";
		}
	}
	$("#outReasons").val(outReasons);
	
	// 탈퇴 상세내용
	if ($("#custInputContents").val().length > 1000) {
		commonAlert("의견은 1000자 이하로 작성해주세요.");
		return;
	}
	$("#outDesc").val($("#custInputContents").val());

	$("#outDivCode").val("10");
	$("#webId").val("${webId}");
	$("#siteCode").val("${siteCode}");
	$("#selectMenu").val("${selectMenu}");
	
	document.membOutForm.submit();
}

</script>

<div class="container">
	<section class="cntDiv">

		<div class="lineMap">
			<div class="path">
				<span class="home"><a href="/" rel="external">HOME</a></span>
				<span><a href="/member/updateMember" rel="external">회원정보</a></span>
				<span class="current">회원탈퇴</span>
			</div>
		</div><!-- // lineMap -->
		
		<div class="pageTitle">
			<h2>회원탈퇴</h2>
		</div>

		<div class="content inner">

			<p class="taC pageGuide2 mt10">사이트를 이용하시면서 불편한 점이나 어려웠던 점이 있으시면<br />고객님의 의견을 들려주세요. <br />더 나은 이랜드리테일 원클릭이 되도록 노력하겠습니다.</p>

			<!-- 탈퇴 사이트 선택 -->
			<form action="/member/memberOutSuccess" name="membOutForm" id="membOutForm" method="POST">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<div class="fieldDiv mt15">
					<fieldset id="siteChoiceField">
						<legend class="tit_bl">탈퇴하시려는 사이트를 선택해 주세요.</legend>
						<div class="allCheckLine">
							<c:choose>
								<c:when test="${('1' eq selectMenu) && ('10' eq siteCode) && (true eq retailMallJoinYn)}">
									<span class="chk fl">
										<input type="checkbox" id="select_site1" name="check1" class="checkBox" data-role="none" onchange="allSiteBtn();" checked /><label for="select_site1" class="label_txt"><spring:message code="name.elandmall" /></label>
									</span>
								</c:when>
								<c:when test="${('1' eq selectMenu) && ('20' eq siteCode) && (true eq coreJoinYn)}">
									<span class="chk fl">
										<input type="checkbox" id="select_site1-1" name="check1" class="checkBox" data-role="none" onchange="allSiteBtn();" checked /><label for="select_site1-1" class="label_txt"><spring:message code="name.elandretail" /></label>
									</span>
								</c:when>
								<c:when test="${('1' eq selectMenu) && ('30' eq siteCode)}">
									<span class="chk">
										<input type="checkbox" id="select_site1" name="check1" class="checkBox" data-role="none" onchange="allSiteBtn();" /><label for="select_site1" class="label_txt"><spring:message code="name.elandmall" /></label>
									</span>
									<span class="chk">	
										<input type="checkbox" id="select_site1-1" name="check1" class="checkBox" data-role="none" onchange="allSiteBtn();" /><label for="select_site1-1" class="label_txt"><spring:message code="name.elandretail" /></label>
									</span>									
								</c:when>								
							</c:choose>
							<button type="button" class="btn white w60" id="check_site"><span>전체선택</span></button>
						</div><!-- // allCheckLine -->
						<div class="checkArea">
							<c:choose>
								<c:when test="${('1' eq selectMenu) && ('10' eq siteCode) && (true eq coreJoinYn)}">
									<span class="chk">
										<input type="checkbox" id="select_site1-1" name="check1" class="checkBox" data-role="none" onchange="allSiteBtn();" /><label for="select_site1-1" class="label_txt"><spring:message code="name.elandretail" /></label>
									</span>	
								</c:when>
								<c:when test="${('1' eq selectMenu) && ('20' eq siteCode) && (true eq retailMallJoinYn)}">
									<span class="chk">
										<input type="checkbox" id="select_site1" name="check1" class="checkBox" data-role="none" onchange="allSiteBtn();" /><label for="select_site1" class="label_txt"><spring:message code="name.elandmall" /></label>
									</span>	
								</c:when>
							</c:choose>
						</div><!-- // checkArea -->
					</fieldset>
				</div><!-- // fieldDiv :: 탈퇴 사이트 선택 -->

				<!-- 사이트를 이용하시면서 어떤 점이 불편하셨나요? -->
				<div class="fieldDiv mt15">
					<fieldset>
						<legend class="tit_bl"><span>사이트를 이용하시면서 어떤 점이 불편하셨나요?</span></legend>
						<div class="discontent">
							<ul>
								<li><input type="checkbox" id="dis_1" name="dis_1" class="checkBox" data-role="none" /><label for="dis_1" class="label_txt">자주 방문하지 않음</label></li>
								<li><input type="checkbox" id="dis_2" name="dis_2" class="checkBox" data-role="none" /><label for="dis_2" class="label_txt">상품 품질 및 가격 불만족</label></li>
								<li><input type="checkbox" id="dis_3" name="dis_3" class="checkBox" data-role="none" /><label for="dis_3" class="label_txt">개인정보 유출 우려</label></li>
								<li><input type="checkbox" id="dis_4" name="dis_4" class="checkBox" data-role="none" /><label for="dis_4" class="label_txt">배송/교환/환불/반품 불만족</label></li>
								<li><input type="checkbox" id="dis_5" name="dis_5" class="checkBox" data-role="none" /><label for="dis_5" class="label_txt">정보가 부족하여 기능을 사용하기 어려움</label></li>
								<li><input type="checkbox" id="dis_6" name="dis_6" class="checkBox" data-role="none" /><label for="dis_6" class="label_txt">이벤트 활성화 부족</label></li>
								<li><input type="checkbox" id="dis_7" name="dis_7" class="checkBox" data-role="none" /><label for="dis_7" class="label_txt">시스템에러, 속도등 불만</label></li>
							</ul>
						</div>
					</fieldset>
				</div><!-- // fieldDiv :: 사이트를 이용하시면서 어떤 점이 불편하셨나요? -->

				<!-- 기타 불편사항 -->
				<div class="fieldDiv mt30">
					<fieldset>
						<legend class="tit_bl"><span>위의 항목외에 기타 불편사항이나 건의 사항이 있으시면 의견을 들려주세요.</span></legend>
						<div class="textareaBox mt10">
							<textarea id="custInputContents" name="custInputContents" data-role="none"></textarea>
						</div>
					</fieldset>
				</div><!-- // fieldDiv :: 기타 불편사항 -->
				
				<input type="hidden" id="webId" name="webId" />
				<input type="hidden" id="siteCode" name="siteCode" />
				<input type="hidden" id="outSiteCodes" name="outSiteCodes" />
				<input type="hidden" id="outDivCode" name="outDivCode" />
				<input type="hidden" id="outDesc" name="outDesc" />
				<input type="hidden" id="outReasons" name="outReasons" />
				<input type="hidden" id="selectMenu" name="selectMenu" />
				<input type="hidden" id="custStat" name="custStat" />
			</form>

			<div class="warningBox mt15">
				<ul>
					<li><span class="bl">&middot;</span> 회원탈퇴를 하시면, 고객님의 포인트가 모두 소멸될 수도 있으니 주의하세요.</li>
					<li><span class="bl">&middot;</span> 30일 이내에 고객센터를 통해 탈퇴 철회하실 수 있습니다.</li>
					<li><span class="bl">&middot;</span> 일부 사이트 탈퇴시, 이랜드 원클릭 회원은 유지되며 계속 서비스를 받으실 수 있습니다.</li>
					<li><span class="bl">&middot;</span> 전체 사이트 탈퇴시 30일간 다시 가입하실 수 없습니다.</li>
				</ul>
			</div><!-- // warningBox -->
			
			<div class="btnDiv taC mt10 ui-grid-a mt20">
				<div class="ui-block-a"><button type="button" class="btn white large" onclick="memberOutCancel();"><span>취소</span></button></div>
				<div class="ui-block-b"><button type="button" class="btn blue large" onclick="outConfirm();"><span>회원탈퇴</span></button></div>
			</div>

		</div><!-- // content -->

	</section>
</div><!-- // container -->

