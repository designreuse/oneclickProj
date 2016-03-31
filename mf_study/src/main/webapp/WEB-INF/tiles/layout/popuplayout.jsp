<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>E-land OneClick</title>
<link rel="stylesheet" href="../../css/oneclick_mobile.css" type="text/css" />
<link rel="stylesheet" href="../../css/jquery.mobile.structure-1.4.5.css" />
<link rel="stylesheet" href="../css/swiper.css" type="text/css" />
<!-- <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.3/themes/smoothness/jquery-ui.css"> -->
<script type="text/javascript" src="../js/jquery-1.12.0.min.js"></script>
<!-- <script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script> -->
<script type="text/javascript" src="../js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="../js/jquery.validate.js"></script>
<!--[if lt IE 9]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
<![endif]-->
<script src="../js/oneclick_mobile.js"></script>
<script src="../js/jquery.mobile-1.4.5.min.js"></script>
<script src="../js/common.js"></script><!-- 공통 스크립트 -->
<script src="../js/searchAddress.js"></script><!-- 주소찾기 스크립트 -->
<script src="../js/jquery.modalLayer.js"></script><!-- 모달팝업 -->
    
</head>
    <body class="popScroll">
    	<div id="popWrapper">
			<tiles:insertAttribute name="body" />
		</div>
    </body>
</html>