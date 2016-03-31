<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">


	var isMember = ${isMember};
	var thirtyCheck = ${isReJoin};
	var isUnderFourteen = ${isUnderFourteen};
	var custStat = "${custStat}";
	
	if (isUnderFourteen) {
		alert("만 14세 미만은 회원가입이 제한됩니다.");
		window.close();
	} else {
		if (isMember) {
			if ("50" == custStat) {
				if (!thirtyCheck) {
					alert("탈퇴후 재가입은 30일 이후에 가능합니다.");
					window.close();
				} else {
					window.opener.goToJoinStep2();
					window.close();
				}
			} else {
				alert("이미 가입한 회원입니다.");
				window.close();
			}
		} else {
			window.opener.goToJoinStep2();
			window.close();
		}
	}
	

</script>

