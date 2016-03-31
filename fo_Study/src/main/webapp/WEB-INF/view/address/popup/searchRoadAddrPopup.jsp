<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">

$(document).ready(function () {

    $(".input_text").keydown(function (key) {
        if (key.keyCode == 13) {
        	searchAddr();
        }
    });

});

function getSiGunGu(option) {
	
	var cityNm = option.value;
	if (cityNm == "") {
		$("#label_sigungu").text("시\/군\/\구 선택");
		 $("#select-item12").html("");
		return false;
	}
	
	// 주소찾기
	searchGuNm("${elandmallUrl}", cityNm);
}


function getSiGunGuCallBack(result) {
	var obj = JSON.parse(result);
	var strHtml = "";
	 
	if (obj.arrGuList.length > 0) {
		 for (var i=0; i<obj.arrGuList.length; i++) {
			strHtml += "<option value='"+obj.arrGuList[i]+"'>"+obj.arrGuList[i]+"</option>";
		 }
		 
		 $("#label_sigungu").text(obj.arrGuList[0]);
		 $("#select-item12").html("");
		 $("#select-item12").append(strHtml);
	 }
}




function searchAddr() {
	var cityNm = $("#select-item1 option:selected").val();
	var guNm = $("#select-item12 option:selected").val();
	var roadNm = $("#roadNm").val();
	
	if (cityNm == "") {
		alert("시/도를 선택해주세요.");
		return false;
	}
	if (guNm == "") {
		alert("시/군/구를 선택해주세요.");
		return false;
	}
	if (roadNm == "") {
		alert("도로명을 입력해주세요.");
		return false;
	}
	
	var schNm = roadNm;  

	// 주소찾기
	searchPostNo("${elandmallUrl}", "N", cityNm, guNm, schNm);
}

 function searchAddrCallBack(result) {
	 var gubunCode = $("#select-item1 option:selected").data("code");
	 var obj = JSON.parse(result);
	 var strHtml = "";
	 
	 if (obj.results.length > 0) {
		 for (var i=0; i<obj.results.length; i++) {
			strHtml += "<tr>";
			strHtml += "<td><span>"+obj.results[i].POST_NO +"</span></td>";
			strHtml += "<td class='taL'><a href='/member/inputAddrDetailPopup?isRoadAddr="+true+"&postNo="+obj.results[i].POST_NO+"&addr="+obj.results[i].ADDR+"'>"+obj.results[i].ADDR+"</a></td>";
			strHtml += "</tr>";
			 
		 }
	 } else {
		 strHtml += "<tr>";
		 strHtml += "<td colspan='2' class='result_none'>";
		 strHtml += "<p class='taC'>주소 검색 결과가 없습니다.<br />도로명을 입력해 주세요. </p>";
		 strHtml += "</tr>";
	 }
	 
	 $("#tbody_addr").html("");
	 $("#tbody_addr").append(strHtml);
	 $("#div_addrList").css("display", "block");
 }



</script>

<div class="popupBox">
	<div class="popTitle taC"><h1>주소검색</h1></div>
	<div class="popContent">
		<p class="cntGuide taC">원하는 주소 검색방법을 선택해 주세요.</p>
		
		<div class="tabBox pop mt30">
			<ul class="srchTabMenu">
				<li><h2><a href="/member/searchAddrPopup">지번 주소로 찾기</a></h2></li>
				<li><h2><a href="#" class="current">도로명 주소로 찾기</a></h2></li>
			</ul>
			<div class="viewDiv">
				<p class="guideTxt">찾고자 하는 지역의 동이름 / 길이름 / 건물명을 입력해 주세요.<br><span class="f_point">예) 삼성동 / 올림픽로 / IT 프리미어타워</span></p>
				<div class="addrSearch m1">
					<fieldset>
						<legend class="blind">주소 찾기</legend>
						<div class="selectBox w138">
							<label for="select-item1">시/도 선택</label>
							<select class="select" id="select-item1" onchange="javascript:getSiGunGu(this);">
								<option value="">시/도 선택</option>
								<option value="서울" data-code="16">서울</option>
								<option value="경기" data-code="18">경기</option>
								<option value="인천" data-code="15">인천</option>
								<option value="대전" data-code="23">대전</option>
								<option value="대구" data-code="27">대구</option>
								<option value="부산" data-code="12">부산</option>
								<option value="광주" data-code="24">광주</option>
								<option value="울산" data-code="21">울산</option>
								<option value="충북" data-code="11">충북</option>
								<option value="충남" data-code="26">충남</option>
								<option value="경북" data-code="19">경북</option>
								<option value="경남" data-code="17">경남</option>
								<option value="전북" data-code="13">전북</option>
								<option value="전남" data-code="14">전남</option>
								<option value="강원" data-code="22">강원</option>
								<option value="세종" data-code="25">세종</option>
								<option value="제주" data-code="20">제주</option>
							</select>
						</div><!-- // selectBox -->
						<div class="selectBox w138">
							<label for="select-item2" id="label_sigungu">시/군/구 선택</label>
							<select class="select" id="select-item12">
							
							</select>
						</div><!-- // selectBox -->
						<input type="text" id="roadNm" name="roadNm" class="input_text w138" placeholder="도로명">
							
					</fieldset>
				</div><!-- // addrSearch -->

				<div class="btnDiv taC mt20">
					<button type="button" class="btn blue pop" onclick="javascript:searchAddr();"><span>조회</span></button>
				</div>
				
				<div id="div_addrList" style="display:none">
				<p class="guideTxt mt20">범위에 해당하는 주소를 선택하세요.</p>
				<div class="boardList headFix mt10 h245">
					<div class="listHead"></div>
					<div class="scrollBody">
						<table cellspacing="0" summary="우편번호, 주소">
							<caption>목록</caption>
							<colgroup>
								<col width="110px">
								<col width="*">
							</colgroup>
							<thead>
								<tr>
									<th class="postNum"><div class="th_inner">우편번호</div></th>
									<th class="addr"><div class="th_inner">주소</div></th>
								</tr>
							</thead>
							<tbody id="tbody_addr">

							</tbody>
						</table>
					</div>
				</div>
			</div>

			</div><!-- // viewDiv -->
		</div><!-- // tabBox -->

	</div><!-- // popContent -->

	
</div>
