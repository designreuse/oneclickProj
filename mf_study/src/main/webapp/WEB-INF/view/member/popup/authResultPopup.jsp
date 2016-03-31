<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
$(document).ready(function(){
	var isMember = ${isMember};
	var isReJoin = ${isReJoin};
	var isUnderFourteen = ${isUnderFourteen};
	
	if (isUnderFourteen) {
		commonAlert("만 14세 미만은 회원가입이 제한됩니다.");
		location.href = "/member/joinMember";
	} else {
		if (isMember) {
			if (isReJoin) {
				commonAlert("이미 가입한 회원입니다.");
				location.href = "/member/joinMember";
			} else {
				commonAlert("탈퇴후 재가입은 30일 이후에 가능합니다.");
				location.href = "/member/joinMember";
			}
		} else {
			document.gForm.submit();
		}
	}
});

</script>

<form name="gForm" id="gForm" method="post" action="/member/joinMemberStep2">
	<input type="hidden" id="reqSiteCode" name="reqSiteCode" value="${siteCode}" />
</form>	

