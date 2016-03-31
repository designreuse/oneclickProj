<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function () {
	
	var invalidAccess = ${invalidAccess};
	if (invalidAccess) {
		commonAlert("잘못된 접근입니다. 메인페이지로 이동합니다.");
		location.replace("/");
	}
	
	// 체크박스 모두 선택
	$("#all_check").change(function () {
		var checked = $(this).prop("checked");
		if ($(this).prop("checked")) {
			$("input[name='check_item']").prop("checked", checked);
		} else{
			$("input[name='check_item']").prop("checked", false);
		}
	});

	// 자세히보기 토글
	$(".toggleBox").hide();
	$(".agreeDiv .clr").children(".more").click(function () {
		$(this).toggleClass("on").parent().next(".toggleBox").slideToggle();
		$(this).parent().parent(".last").toggleClass("nonLine"); // 2016-03-21 추가

	});


});


function goNext() {
	if (!$("#check_item1").is(":checked")) {
		commonAlert("이랜드리테일 멤버십 이용약관 동의를 선택해 주세요.");
		$("#check_item1").focus();
		return false;
	}
	
	if (!$("#check_item2").is(":checked")) {
		commonAlert("온라인 서비스 이용약관 동의를 선택해 주세요.");
		$("#check_item2").focus();
		return false;
	}
	
	if (!$("#check_item3").is(":checked")) {
		commonAlert("개인정보 수집항목, 목적 및 이용기간 동의를 선택해 주세요.");
		$("#check_item3").focus();
		return false;
	}
	
	if ($("#check_item4").is(":checked")) {
		$("#offerMemberInfo").val("Y");
	} else {
		$("#offerMemberInfo").val("N");
	}
	
 	document.termsForm.submit(); 
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
	
		<div class="content inner">
	
			<div class="stepBox">
				<ol>
					<li><span class="num">STEP 01</span><span class="txt">본인확인</span></li>
					<li class="on"><span class="num">STEP 02</span><span class="txt">약관동의</span></li>
					<li><span class="num">STEP 03</span><span class="txt">정보입력</span></li>
					<li><span class="num">STEP 04</span><span class="txt">가입완료</span></li>
				</ol>
			</div><!-- // stepBox -->
			<form action="/member/joinMemberStep3" name="termsForm" method="POST">
			
			<div class="allCheck">
				<input type="checkbox" id="all_check" name="check_item" class="checkBox" data-role="none"><label for="all_check" class="label_txt">모든 약관을 확인하고 전체동의 합니다.</label>
			</div><!-- // allCheck -->
			
			<div class="termsAgree mt15">
				
				
				<div class="agreeDiv">
					<div class="clr">
						<input type="hidden" id="memberShipTerms" name="memberShipTerms" value="Y">
						<input type="checkbox" id="check_item1" name="check_item" class="checkBox" data-role="none"><label for="check_item1" class="label_txt">이랜드리테일 멤버십 이용약관 동의 [필수]</label>
						<a href="/terms/memberShipClubTerms" class="btn_icon arrow ui-link" target="_blank" rel="external"><span class="blind">자세히 보기</span></a>
					</div>
					<div class="detail">
						<p class="guide">위 서비스 이용약관은 당사가 운영하는 아래의 홈페이지에도 동일하게 적용되며 원하시는 사이트를 가입할 때는 개별적인 동의 절차를 밟으시면 됩니다.</p>
						<div class="linkBox mt10">
							<div class="link"><em><spring:message code="name.elandmall" /></em><a href="http://www.elandmall.co.kr" target="_blank" rel="external" class="ui-link">http://www.elandmall.co.kr</a></div>
							<div class="link"><em><spring:message code="name.elandretail" /></em><a href="http://www.ecore.co.kr" target="_blank" rel="external" class="ui-link">http://www.ecore.co.kr</a></div>
						</div>
					</div><!-- // detail -->
				</div><!-- // agreeDiv :: 이랜드리테일 멤버십 이용약관 동의 -->
	
				<div class="agreeDiv">
					<div class="clr">
						<input type="hidden" id="onlineTerms" name="onlineTerms" value="Y">
						<input type="checkbox" id="check_item2" name="check_item" class="checkBox" data-role="none"><label for="check_item2" class="label_txt">온라인 서비스 이용약관 동의 [필수]</label>
						<a href="/terms/onlineServiceTerms" class="btn_icon arrow ui-link" target="_blank" rel="external"><span class="blind">자세히 보기</span></a>
					</div>
				</div><!-- // agreeDiv :: 온라인 서비스 이용약관 동의 -->
	
				<div class="agreeDiv">
					<div class="clr">
						<input type="hidden" id="memberInfoTerms" name="memberInfoTerms" value="Y">
						<input type="checkbox" id="check_item3" name="check_item" class="checkBox" data-role="none"><label for="check_item3" class="label_txt">개인정보 수집항목, 목적 및 이용기간 동의 [필수]</label>
						<a href="#" class="btn_icon more ui-link" target="_blank" rel="external"><span class="blind">자세히 보기</span></a>
					</div>
					<div class="detail toggleBox mb5" style="display: none;">
						<dl class="termsDetail">
							<dt>개인정보 수집 항목</dt>
							<dd>[필수]성명, 이메일 및 주소, 휴대전화번호, 생년월일, 성별</dd>
							<dt>수집목적</dt>
							<dd>1. 서비스 제공에 관한 계약이행 및 서비스 제공에 따른 요금정산 컨텐츠 제공, 물품 및 경품 배송 또는 청구서 등 발송, 금융거래 본인인증 및 금융서비스, 이랜드리테일 멤버십 포인트적립, 구매 및 요금결재, 요금추심 등 <br>2. 회원관리 회원제 서비스 이용에 따른 본인 확인, 개인식별, 불량회원의부정이용 방지와 비인가 사용 가입 및 가입횟수 제한, 법정대리인 동의여부 확인, 추후 법정대리인 본인 확인, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리, 고지사항 전달 등<br>3. 마케팅 및 광고에 활용 신규 서비스(제품) 개발 및 특화, 인구통계학적 특성에 따른서비스제공 및 광고 게재, 접속 빈도 파악, 회원의서비스 이용에 대한 통계 등 업무와 관련된 각종 통계자료의 작성 및 서비스 개발, 이벤트 등 광고성 정보 전달, 사은행사, 판촉행사, 광고물 발송 등<br>4. 기타 당사가 제공하는 서비스 및 이벤트 등 정보제공, 당사가 진행하는 행사 및 제휴행사의 안내, 서비스 홍보, 텔레마케팅, DM, EM 등의정보제공 및 활용, 문화센터, 소극장 등의 안내 정보 제공</dd>
							<dt>보유 및 이용기간</dt>
							<dd>이랜드리테일 멤버십 회원 탈퇴시까지</dd>
						</dl>
					</div><!-- // detail -->
				</div><!-- // agreeDiv :: 개인정보 수집항목, 목적 및 이용기간 동의 -->
	
				<div class="agreeDiv last">
					<div class="clr">
						<input type="hidden" id="offerMemberInfo" name="offerMemberInfoTerms" value="">
						<input type="checkbox" id="check_item4" name="check_item" class="checkBox" data-role="none"><label for="check_item4" class="label_txt">개인정보 제3자(계열사) 제공 동의 [선택]</label>
						<a href="#" class="btn_icon more ui-link" target="_blank" rel="external"><span class="blind">자세히 보기</span></a>
					</div>
					<div class="detail toggleBox" style="display: none;">
						<p class="guide">개인정보에 대한 수집/이용 동의는 거부할 권리가 있으며, 제3자 제공의 동의 여부와 관계 없이 "이랜드클럽 멤버십"서비스 회원에 가입할 수 있습니다. 단, 개인정보 제3자 제공 동의 거부시, 상기 이용목적에 명시된 서비스를 받으실 수 없습니다.</p>
						<dl class="termsDetail">
							<dt>개인 정보 제공 제휴사</dt>
							<dd>[필수]성명, 이메일 및 주소, 휴대전화번호, 생년월일</dd>
							<dt>이용목적</dt>
							<dd>＊업체별 서비스 및 이벤트 정보 제공(SMS/E-mail/DM/TM 등), <br>＊제휴행사 및 서비스 홍보를 위한 마케팅 활동</dd>
							<dt>제공하는 개인정보</dt>
							<dd>성명, 생년월일, 성별, 이메일 및 자택 [직장]주소, 자택[직장]전화번호 및휴대전화번호, 포인트카드번호 및거래정보, 본인/배우자/자녀의 생일결혼유무, 결혼기념일, 자녀성명, 수</dd>
							<dt>이용기간</dt>
							<dd>이랜드리테일 멤버십 회원 탈퇴시까지</dd>
						</dl>
					</div><!-- // detail -->
				</div><!-- // agreeDiv :: 개인정보 제3자(계열사) 제공 동의 -->
	
				<div class="btnDiv mt20 ui-grid-a">
					<div class="ui-block-a"><a href="/" class="btn white pop ui-link" rel="external"><span>가입취소</span></a></div>
					<div class="ui-block-b"><a href="javascript:goNext();" class="btn blue pop ui-link" rel="external"><span>다음</span></a></div>
				</div>
			</div><!-- // termsAgree -->
			</form>
		</div><!-- // content -->
	
	</section>
</div>



