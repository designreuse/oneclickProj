<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE>
<html lang="ko">
<head>
	<tiles:insertAttribute name="head"/>
</head>
    <body>
	    <div id="wrapper">
	        <tiles:insertAttribute name="header" />
	        	        
	        <div id="container">
				<div class="lineMap">
					<div class="path" id="header_path">
						<a href="/"><span class="home">HOME</span></a>
					</div>
				</div><!-- // lineMap -->
	
				<div class="contentWrap">
					<tiles:insertAttribute name="left" />
					<tiles:insertAttribute name="body" />
					
				</div><!-- // contentWrap -->
	
			</div><!-- // container -->
	        
	        <tiles:insertAttribute name="footer" />
	        </div>
    </body>
</html>