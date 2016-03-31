<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE>
<html lang="ko">
<head>
	<tiles:insertAttribute name="head"/>
</head>
    <body>
	    <div id="dvwrap" data-role="page">
	        <tiles:insertAttribute name="header" />
	        	        
			<tiles:insertAttribute name="left" />
			<tiles:insertAttribute name="body" />
	        
	        <tiles:insertAttribute name="footer" />
		</div> <!-- dvwrap -->
    </body>
    <button type="button" class="btn_goTop" data-role="none"><span class="blind">맨위로</span></button>
</html>