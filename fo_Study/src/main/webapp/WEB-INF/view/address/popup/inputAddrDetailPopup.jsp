<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script type="text/javascript">

var isRoadAddr = ${isRoadAddr}; 
$(document).ready(function () {
	
	// 도로명 탭 처리
	if (isRoadAddr) {
		$("#roadTab").addClass("current");
	} else {
		$("#jibunTab").addClass("current");
	}
	
	
	$(document).ready(function () {

	    $("#addrDetail").keydown(function (key) {
	        if (key.keyCode == 13) {
	        	confirm();
	        }
	    });

	});
});



/**
 * 다시 주소 검색
 */
function retrySearch() {
	if (isRoadAddr) {
		location.href = "/member/searchRoadAddrPopup";
	} else {
		location.href = "/member/searchAddrPopup";
	}
}

function confirm() {
	
	if ($("#addrDetail").val() == "") {
		alert("상세 주소를 입력해주세요");
		return false;
	}
	
	
	location.href = "/member/selectAddrPopup?isRoadAddr="+$('#hdnIsRoadAddr').val()+"&postNo=" + $('#hdnPostNo').val() 
													+ "&addr=" + $('#hdnAddr').val() 
													+ "&addrDetail=" + $("#addrDetail").val();
	
}


</script>

<div class="popupBox">
	<div class="popTitle taC"><h1>주소검색</h1></div>
	<div class="popContent">
		<p class="cntGuide taC">원하는 주소 검색방법을 선택해 주세요.</p>
		
		<div class="tabBox pop mt30">
			<ul class="srchTabMenu">
				<li><h2><a href="#" id="jibunTab">지번 주소로 찾기</a></h2></li>
				<li><h2><a href="/member/searchRoadAddrPopup" id="roadTab">도로명 주소로 찾기</a></h2></li>
			</ul>
			<div class="viewDiv">
				<h3 class="guideTxt">검색된 주소</h3>
				<div class="boardList mt10">
					<table cellspacing="0" summary="우편번호, 주소">
						<caption>목록</caption>
						<colgroup>
							<col width="110px">
							<col width="*">
						</colgroup>
						<thead>
							<tr>
								<th>우편번호</th>
								<th>주소</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><span>${postNo}</span></td>
								<td class="taL"><span>${addr}</span></td>
							</tr>
						</tbody>
					</table>
				</div><!-- // boardList -->

				<label for="address" class="guideTxt mt20 mb5">나머지 주소를 입력해 주세요.</label>
				<input type="text" id="addrDetail" name="addrDetail" class="input_text w450" placeholder="상세주소" title="상세주소 입력">
				
				<div class="btnDiv taC mt20">
					<button type="button" class="btn white pop" onclick="javascript:retrySearch();"><span>다시검색</span></button>
					<button type="button" class="btn blue pop" onclick="javascript:confirm();"><span>확인</span></button>
				</div>

			</div><!-- // viewDiv -->
		</div><!-- // tabBox -->
	</div><!-- // popContent -->
</div>

<input type="hidden" id="hdnPostNo" name="hdnPostNo" value="${postNo}" />
<input type="hidden" id="hdnAddr" name="hdnAddr" value="${addr}" />
<input type="hidden" id="hdnIsRoadAddr" name="hdnIsRoadAddr" value="${isRoadAddr}" />
