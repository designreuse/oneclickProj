<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

$(document).ready(function(){ 

});

</script>

<div class="container">
	
	<div class="lineMap">
		<div class="path">
			<span class="home"><a href="/" rel="external">HOME</a></span>
			<span><a href="/terms/memberShipClubTerms" rel="external">약관</a></span>
			<span class="current">입점상담 동의사항</span>
		</div>
	</div><!-- // lineMap -->
	
	<section class="terms">
		<div class="pageTitle">
			<h2>입점상담 동의사항</h2>
		</div>

		<div class="content termsView">
			${entryCounselAgree.termsCont}		
		</div><!-- // content -->
	</section><!-- // terms -->

</div><!-- // container -->