<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function () {
	
	var invalidAccess = ${invalidAccess};
	if (invalidAccess) {
		alert("잘못된 접근입니다. 메인페이지로 이동합니다.");
		location.replace("/");
	}
	
	$('.open_modal').modalLayer();
	customCheckbox();
	customRadio();
	
	$("#li_member > a").addClass("current");
	$("#li_joinMember > a").addClass("current");
	var strHtml = "<a href='/member/updateMember'><span>회원정보</span></a><span class='current'>회원가입</span>";
	$("#header_path").append(strHtml);
	$("#leftTitle").text("회원가입");
	
	// 체크박스 모두 선택
	$("#all_check").click(function(){
		if($("#all_check").prop("checked")){
			$("input[name=check_item]").prop("checked",true).parent().addClass("selected");
		}else{
			$("input[name=check_item]").prop("checked",false).parent().removeClass("selected");
		}
	});
});

function goNext() {
	if (!$("#check_item1").is(":checked")) {
		alert("이랜드리테일 멤버십 이용약관 동의를 선택해 주세요.");
		$("#check_item1").focus();
		return;
	}
	
	if (!$("#check_item2").is(":checked")) {
		alert("온라인 서비스 이용약관 동의를 선택해 주세요.");
		$("#check_item2").focus();
		return;
	}
	
	if (!$("#check_item3").is(":checked")) {
		alert("개인정보 수집항목, 목적 및 이용기간 동의를 선택해 주세요.");
		$("#check_item3").focus();
		return;
	}
	
	if ($("#check_item4").is(":checked")) {
		$("#offerMemberInfo").val("Y");
	} else {
		$("#offerMemberInfo").val("N");
	}
	
 	document.termsForm.submit(); 
}

function goToMainPage() {
	location.href = "/";
}
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
			<li class="on"><span>STEP 02</span>약관동의</li>
			<li><span>STEP 03</span>정보입력</li>
			<li><span>STEP 04</span>가입완료</li>
		</ol>
	</div><!-- // stepBox -->
	
	<form action="/member/joinMemberStep3" name="termsForm" method="POST">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	
	<div class="allCheck mt40">
			<input type="checkbox" id="all_check" name="check_item" class="checkBox">
		<label for="all_check" class="label_txt">모든 약관을 확인하고 전체동의 합니다.</label>
	</div><!-- // allCheck -->
	<div class="termsAgree mt20">
	
		<div class="agreeDiv">
			<div class="clr">
				<div class="fl">
					
						<input type="hidden" id="memberShipTerms" name="memberShipTerms" value="Y">
						<input type="checkbox" id="check_item1" name="check_item" class="checkBox">
					
					<label for="check_item1" class="label_txt">이랜드리테일 멤버십 이용약관 동의 [필수]</label>
				</div>
				<div class="fr">
					<a href="/terms/memberShipClubTerms" class="btn white w95" target="_blank">
						<span>자세히 보기</span>
					</a>
				</div>
			</div>
			<div class="detail">
				<p class="guide">위 서비스 이용약관은 당사가 운영하는 아래의 홈페이지에도 동일하게 적용되며 원하시는 사이트를 가입할 때는 개별적인 동의 절차를 밟으시면 됩니다.</p>
				<div class="linkBox mt5">
					<div class="link"><em><spring:message code="name.elandmall" /></em><a href="http://www.elandmall.co.kr" target="_blank">http://www.elandmall.co.kr</a></div>
					<div class="link"><em><spring:message code="name.elandretail" /></em><a href="http://www.ecore.co.kr" target="_blank">http://www.ecore.co.kr</a></div>
				</div>
			</div><!-- // detail -->
		</div><!-- // agreeDiv :: 이랜드 멤버십 클럽 이용약관 동의 -->

		<div class="agreeDiv">
			<div class="clr">
				<div class="fl">
					
						<input type="hidden" id="onlineTerms" name="onlineTerms" value="Y">
						<input type="checkbox" id="check_item2" name="check_item" class="checkBox">
					
					<label for="check_item2" class="label_txt">온라인 서비스 이용약관 동의 [필수]</label>
				</div>
				<div class="fr">
					<a href="/terms/onlineServiceTerms" class="btn white w95" target="_blank">
						<span>자세히 보기</span>
					</a>
				</div>
			</div>
		</div><!-- // agreeDiv :: 온라인 서비스 이용약관 동의 -->

		<div class="agreeDiv">
			<div class="clr">
				<div class="fl">
					
						<input type="hidden" id="memberInfoTerms" name="memberInfoTerms" value="Y">
						<input type="checkbox" id="check_item3" name="check_item" class="checkBox" >
					
					<label for="check_item3" class="label_txt">개인정보 수집항목, 목적 및 이용기간 동의 [필수]</label>
				</div>
			</div>
			<div class="detail">
				<div class="termsTable join ">
					<table cellspacing="0" summary="개인정보 수집 항목, 수집목적, 보유 및 이용기간">
						<colgroup>
							<col width="150px">
							<col width="440px">
							<col width="*">
						</colgroup>
						<thead>
							<tr>
								<th>개인정보 수집 항목</th>
								<th>수집목적</th>
								<th>보유 및 이용기간</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>[필수]<br>성명, 이메일 및 주소,<br>휴대전화번호,<br>생년월일, 성별</td>
								<td>1. 서비스 제공에 관한 계약이행 및 서비스 제공에 따른 요금정산 컨텐츠 제공, 물품 및 경품 배송 또는 청구서 등 발송, 금융거래 본인인증 및 금융서비스, 이랜드리테일 멤버십 포인트적립, 구매 및 요금결재, 요금추심 등 <br>2. 회원관리 회원제 서비스 이용에 따른 본인 확인, 개인식별, 불량회원의부정이용 방지와 비인가 사용 가입 및 가입횟수 제한, 법정대리인 동의여부 확인, 추후 법정대리인 본인 확인, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리, 고지사항 전달 등<br>3. 마케팅 및 광고에 활용 신규 서비스(제품) 개발 및 특화, 인구통계학적 특성에 따른서비스제공 및 광고 게재, 접속 빈도 파악, 회원의서비스 이용에 대한 통계 등 업무와 관련된 각종 통계자료의 작성 및 서비스 개발, 이벤트 등 광고성 정보 전달, 사은행사, 판촉행사, 광고물 발송 등<br>4. 기타 당사가 제공하는 서비스 및 이벤트 등 정보제공, 당사가 진행하는 행사 및 제휴행사의 안내, 서비스 홍보, 텔레마케팅, DM, EM 등의정보제공 및 활용, 문화센터, 소극장 등의 안내 정보 제공 </td>
								<td>이랜드<br>Club Membership<br>회원 탈퇴시 까지</td>
							</tr>
						</tbody>
					</table>
				</div><!-- // termsTable -->
			</div><!-- // detail -->
		</div><!-- // agreeDiv :: 개인정보 수집항목, 목적 및 이용기간 동의 -->

		<div class="agreeDiv last">
			<div class="clr">
				<div class="fl">
					
						<input type="hidden" id="offerMemberInfo" name="offerMemberInfoTerms" value="">
						<input type="checkbox" id="check_item4" name="check_item" class="checkBox">
					
					<label for="check_item4" class="label_txt">개인정보 제3자(계열사) 제공 동의 [선택]</label>
				</div>
			</div>
			<div class="detail">
				<p class="guide">개인정보에 대한 수집/이용 동의는 거부할 권리가 있으며, 제3자 제공의 동의 여부와 관계 없이 "이랜드클럽 멤버십"서비스 회원에 가입할 수 있습니다. 단, 개인정보 제3자 제공 동의 거부시, 상기 이용목적에 명시된 서비스를 받으실 수 없습니다.</p>
				<div class="termsTable join mt5">
					<table cellspacing="0" summary="개인정보 제공 제휴사, 이용목적, 제공하는 개인정보, 이용기간">
						<colgroup>
							<col width="150px">
							<col width="220px">
							<col width="220px">
							<col width="*">
						</colgroup>
						<thead>
							<tr>
								<th>개인 정보 제공 제휴사</th>
								<th>이용목적</th>
								<th>제공하는 개인정보</th>
								<th>이용기간</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>[필수]<br>성명, 이메일 및 주소,<br>휴대전화번호, <br>생년월일</td>
								<td>＊ 업체별 서비스 및 이벤트 정보<br>제공(SMS/E-mail/DM/TM 등), <br>＊제휴행사 및 서비스 홍보를 위한 마케팅 활동</td>
								<td>성명, 생년월일, 성별, 이메일 및 자택 [직장]주소, 자택[직장]전화번호 및휴대전화번호, 포인트카드번호 및거래정보, 본인/배우자/자녀의 생일결혼유무, 결혼기념일, 자녀성명, 수</td>
								<td>이랜드리테일 멤버십 회원 탈퇴시까지</td><!-- 2016-03-07 수정 -->
							</tr>
						</tbody>
					</table>
				</div><!-- // termsTable -->
			</div><!-- // detail -->
		</div><!-- // agreeDiv :: 개인정보 제3자(계열사) 제공 동의 -->

		
	</div><!-- // termsAgree -->
	</form>
	<div class="btnDiv taC mt30">
		<a href="#cancel_join" class="btn white large open_modal"><span>가입 취소</span></a>
		<a href="javascript:goNext();" class="btn blue large"><span>다음</span></a>
	</div>
	
	

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


