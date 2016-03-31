<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>

<head>
    <title>INSPINIA | Login</title>
</head>

<body>

<sec:authentication property="principal"/>님 안녕하세요

</body>

</html>
