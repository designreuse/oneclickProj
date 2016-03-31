<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script type="text/javascript">
$(document).ready(function() {
	
	var isMember = "${isMember}";
	var webId = "${webId}";
	var scIdReturnUrl = "${scIdReturnUrl}";
	
	location.href = "/member/findId?isMember=" + isMember + "&webId="+webId + "&scIdReturnUrl=" + scIdReturnUrl;
	
});

</script>

