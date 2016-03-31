<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script type="text/javascript">
var addrList = [];
var isRoadAddr = ${isRoadAddr}; 
$(document).ready(function() {
	
	if (document.addEventListener) {
		window.addEventListener("keydown", keyDownTextField, false);
	} else {
		document.attachEvent("onkeydown", keyDownTextField);
	}

	function keyDownTextField(e) {
	var keyCode = e.keyCode;
	  if (keyCode==13) {
		  confirm();
	  } 
	}
	
	// 도로명 탭 처리
	if (isRoadAddr) {
		$("#roadTab").addClass("current");
		$("#jibunTab").attr("href", "/member/searchAddrPopup");
	} else {
		$("#jibunTab").addClass("current");
		$("#roadTab").attr("href", "/member/searchRoadAddrPopup");
	}
	
	convertAddr();
});

function convertAddr() {
	searchConvertAddr("${elandmallUrl}", "N", "${postNo}", "${addr}", "${addrDetail}");
}

function searchAddrCallBack(result) {
	// 주소 정제 데이터
	var obj = JSON.parse(result);
	var RCD1 = obj.convertAddr.RCD1;
	var RCD3 = obj.convertAddr.RCD3;
	
	var strHtml = "";
	
	// 1:1 매핑일때 자동 설정 (자식노드의 지번, 도로명 사용) 
	if (RCD3 == 'I' || RCD3 == 'H') {
		strHtml += '<li>';
		strHtml += '<div class="slct"><span class="customRadio"><input type="radio" id="radio-item-2" data-name="jibun" name="radio-item" class="radioBtn"></span><label for="radio-item-2" class="label_txt">표준지번 주소</label></div>';
		strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[1].ADDR1H+'" data-addr2="'+obj.convertAddr.DATA[1].STDADDR+'"><span class="post">'+obj.convertAddr.DATA[1].ZIPM6+'</span><p>'+obj.convertAddr.DATA[1].ADDR1H+""+obj.convertAddr.DATA[1].STDADDR+'</p></div>';
		strHtml += '</li>';
		strHtml += '<li>';
		strHtml += '<div class="slct"><span class="customRadio"><input type="radio" id="radio-item-3" data-name="road" name="radio-item" class="radioBtn"></span><label for="radio-item-3" class="label_txt">도로명 주소</label></div>';
		strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[1].NADR1+'" data-addr2="'+obj.convertAddr.DATA[1].NBKM+'-'+obj.convertAddr.DATA[1].NBKS+" "+obj.convertAddr.DATA[1].NADREM+" "+obj.convertAddr.DATA[1].NADR3S+'"><span class="post">'+obj.convertAddr.DATA[1].ZIPM6+'</span><p>'+obj.convertAddr.DATA[1].NADR1S +""+obj.convertAddr.DATA[1].NADREM +" "+obj.convertAddr.DATA[1].NADR3S +'</p></div>';
		strHtml += '</li>';
	// 멀티 선택 케이스 (지번은 부모노드, 도로명은 자식 노드 사용)
	} else if(RCD3 == 'C' || RCD3 == 'D' || RCD3 == 'E' || RCD3 == 'F' || RCD3 == 'G') {
		for (var i=0; i < obj.convertAddr.DATA.length; i++) {
			if (obj.convertAddr.DATA[i].NODE == "D") {
				strHtml += '<li>';
				strHtml += '<div class="slct"><span class="customRadio"><input type="radio" data-name="jibun" id="radio-item-'+(i+1)+'" name="radio-item" class="radioBtn"></span><label for="radio-item-'+(i+1)+'" class="label_txt">표준지번 주소</label></div>';
				strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[i].ADDR1H+'" data-addr2="'+obj.convertAddr.DATA[i].STDADDR+'"><span class="post">'+obj.convertAddr.DATA[i].ZIPM6+'</span><p>'+obj.convertAddr.DATA[i].ADDR1H+""+obj.convertAddr.DATA[i].STDADDR+'</p></div>';
				strHtml += '</li>';	
			}
			if (obj.convertAddr.DATA[i].NODE == "P") {
				strHtml += '<li>';
				strHtml += '<div class="slct"><span class="customRadio"><input type="radio" data-name="road" id="radio-item-'+(i+1)+'" name="radio-item" class="radioBtn"></span><label for="radio-item-'+(i+1)+'" class="label_txt">도로명 주소</label></div>';
				strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[i].NADR1+'" data-addr2="'+obj.convertAddr.DATA[i].NBKM+'-'+obj.convertAddr.DATA[i].NBKS+" "+obj.convertAddr.DATA[i].NADREM+" "+obj.convertAddr.DATA[i].NADR3S+'"><span class="post">'+obj.convertAddr.DATA[i].ZIPM6+'</span><p>'+obj.convertAddr.DATA[i].NADR1S +""+obj.convertAddr.DATA[i].NADREM +" "+obj.convertAddr.DATA[i].NADR3S +'</p></div>';
				strHtml += '</li>';
			}
		}
		
	// 지번주소만 정제 성공 케이스
	} else if(RCD3 == '6' || RCD3 == '8') {
		strHtml += '<li>';
		strHtml += '<div class="slct"><span class="customRadio"><input type="radio" data-name="jibun" id="radio-item-'+(i+1)+'" name="radio-item" class="radioBtn"></span><label for="radio-item-'+(i+1)+'" class="label_txt">표준지번 주소</label></div>';
		strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[0].ADDR1H+'" data-addr2="'+obj.convertAddr.DATA[0].STDADDR+'"><span class="post">'+obj.convertAddr.DATA[0].ZIPM6+'</span><p>'+obj.convertAddr.DATA[0].ADDR1H+""+obj.convertAddr.DATA[0].STDADDR+'</p></div>';
		strHtml += '</li>';
// 		strHtml += '<li>';
// 		strHtml += '<div class="slct"><span class="customRadio"><input type="radio" id="radio-item-'+(i+1)+'" name="radio-item" class="radioBtn"></span><label for="radio-item-'+(i+1)+'" class="label_txt">도로명주소</label></div>';
// 		strHtml += '<div class="addr" data-addr="'+obj.convertAddr.DATA[0].NADR1+'" data-addr2="'+obj.convertAddr.DATA[0].NBKM+'-'+obj.convertAddr.DATA[0].NBKS+" "+obj.convertAddr.DATA[0].NADREM+'"><span class="post">'+obj.convertAddr.DATA[0].ZIPM6+'</span><p>'+obj.convertAddr.DATA[0].NADR1S +""+obj.convertAddr.DATA[0].NADREM +'</p></div>';
// 		strHtml += '</li>';
	// 통신장애 케이스
	} else if(RCD3 == 'EXP') {
		
	}
		
	$("#ul_addrList").append(strHtml);
	customRadio();
	
	
	if (isRoadAddr) {
		// 디폴트 선택 처리
		if ($("#radio-item-3").data("name") == "road") {
			$("#radio-item-3").parent("span").addClass("selected");
			$("#radio-item-3").attr("checked", true);
		} else {
			$("#inputAddr").parent("span").addClass("selected");
			$("#inputAddr").attr("checked", true);
		}
	} else {
		// 디폴트 선택 처리
		if ($("#radio-item-2").data("name") == "jibun") {
			$("#radio-item-2").parent("span").addClass("selected");
			$("#radio-item-2").attr("checked", true);
		} else {
			$("#inputAddr").parent("span").addClass("selected");
			$("#inputAddr").attr("checked", true);
		}
	}
	
	
	
}

function confirm() {
	
	if ($(':radio[name="radio-item"]:checked').length == 0) {
		alert("저장할 주소를 선택해 주세요.");
	 	return false;
	}
	
	
	var selectAddr = $(':radio[name="radio-item"]:checked').closest("li").children("div.addr").data("addr");
	var selectAddr2 = $(':radio[name="radio-item"]:checked').closest("li").children("div.addr").data("addr2");
	var postNo = $(':radio[name="radio-item"]:checked').closest("li").children("div.addr").children(".post").text();
	var addrType = $(':radio[name="radio-item"]:checked').data("name");
	
	var object = {};
	
	if ("input" == addrType) {
		if ($("#roadTab").hasClass("current")) {
			addrType = addrType + "Road"; 
		} else {
			addrType = addrType + "Jibun";
		}
	}
	object.addrType = addrType; 
	object.postNo = postNo; 
	object.addr = selectAddr; 
	object.addr2 = selectAddr2;
	addrList[0] = object;
	
	// 입력주소 선택시
	if ("inputRoad" == addrType || "inputJibun" == addrType) {

		if ($(':radio[name="radio-item"]:unchecked').length > 0) {
			if ($(':radio[name="radio-item"]:unchecked').length == 1) {
				 var object = {};
				 var addr = $(':radio[name="radio-item"]:unchecked').eq(0).closest("li").children("div.addr").data("addr");
				 var addr2 = $(':radio[name="radio-item"]:unchecked').eq(0).closest("li").children("div.addr").data("addr2");
				 var postNo = $(':radio[name="radio-item"]:unchecked').closest("li").eq(0).children("div.addr").children("span").text();
				 var addrType = $(':radio[name="radio-item"]:unchecked').eq(0).data("name");
				 
				 object.addrType = addrType;
				 object.postNo = postNo;
				 object.addr = addr; 
				 object.addr2 = addr2; 
				 addrList[1] = object;
			} else {
				for (var i=0; i < 2; i++) {
					 var object = {};
					 var addrType = $(':radio[name="radio-item"]:unchecked').eq(i).attr("id"); // 
					 var addr = $(':radio[name="radio-item"]:unchecked').eq(i).closest("li").children("div.addr").data("addr");
					 var addr2 = $(':radio[name="radio-item"]:unchecked').eq(i).closest("li").children("div.addr").data("addr2");
					 var postNo = $(':radio[name="radio-item"]:unchecked').closest("li").eq(i).children("div.addr").children("span").text();
					 var addrType = $(':radio[name="radio-item"]:unchecked').eq(i).data("name");
					 
					 object.addrType = addrType;
					 object.postNo = postNo;
					 object.addr = addr; 
					 object.addr2 = addr2; 
					 addrList[i+1] = object;
				}
			}
			
		}
			
	} 
	// 지번 주소 선택시
	else if ("jibun" == addrType) {
		
		
		// 정제 도로명 주소 존재시 
		var index = $(':radio[name="radio-item"]:checked').closest("li").index();
		if ($(':radio[name="radio-item"]:unchecked').closest("li").eq(index).length > 0) {
			var roadAddr = $(':radio[name="radio-item"]:unchecked').closest("li").eq(index).children("div.addr").data("addr");
			var roadAddr2 = $(':radio[name="radio-item"]:unchecked').closest("li").eq(index).children("div.addr").data("addr2");
			var roadPostNo = $(':radio[name="radio-item"]:unchecked').closest("li").eq(index).children("div.addr").children("span").text();
			
			 var object = {};
			 object.addrType = "road"; 
			 object.postNo = roadPostNo; 
			 object.addr = roadAddr; 
			 object.addr2 = roadAddr2; 
			 addrList[1] = object;
		}
	} else if ("road" == addrType) {
		
		// 정제 지번 주소 존재시 		
		var index = $(':radio[name="radio-item"]:checked').closest("li").index();
		for (var i= index; 0 < i ; i--) {
			if ("jibun" == $(':radio[name="radio-item"]:unchecked').closest("li").eq(i).find("input").data("name")) {
				var jibunAddr = $(':radio[name="radio-item"]:unchecked').closest("li").eq(i).children("div.addr").data("addr");
				var jibunAddr2 = $(':radio[name="radio-item"]:unchecked').closest("li").eq(i).children("div.addr").data("addr2");
				var jibunPostNo = $(':radio[name="radio-item"]:unchecked').closest("li").eq(i).children("div.addr").children("span").text();
				
				 var object = {};
				 object.addrType = "jibun"; 
				 object.postNo = jibunPostNo; 
				 object.addr = jibunAddr; 
				 object.addr2 = jibunAddr2; 
				 addrList[1] = object;
			}	
		}
	}
	
	
 	this.opener.setAddr(addrList);	
 	window.close();
} 

function retrySearch() {
	if ($("#roadTab").hasClass("current")) {
		location.href = "/member/searchRoadAddrPopup";
	} else {
		location.href = "/member/searchAddrPopup";
	}
}




</script>

<div class="popupBox">
	<div class="popTitle taC"><h1>주소검색</h1></div>
	<div class="popContent">
		<p class="cntGuide taC">원하는 주소 검색방법을 선택해 주세요.</p>
		
		<div class="tabBox pop mt30">
			<ul class="srchTabMenu">
				<li><h2><a href="#" id="jibunTab">지번 주소로 찾기</a></h2></li>
				<li><h2><a href="#" id="roadTab">도로명 주소로 찾기</a></h2></li>
			</ul>
			<div class="viewDiv">
				<h3 class="guideTxt">입력된 주소</h3>
				<div class="boardList mt10">
					<table cellspacing="0" summary="우편번호, 주소">
						<caption>목록</caption>
						<colgroup>
							<col width="100px">
							<col width="174px">
							<col width="*">
						</colgroup>
						<thead>
							<tr>
								<th>우편번호</th>
								<th>주소</th>
								<th>상세주소</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><span>${postNo}</span></td>
								<td class="taL"><span>${addr}</span></td>
								<td class="taL"><span>${addrDetail}</span></td>
							</tr>
						</tbody>
					</table>
				</div><!-- // boardList -->

				<p class="guideTxt mt20 mb5">저장할 주소를 선택해 주세요.</p>
				<div class="addrList">
					<ul id="ul_addrList">
						<li>
							<div class="slct"><input type="radio" id="inputAddr" data-name="input" name="radio-item" class="radioBtn"><label for="radio-item-0" class="label_txt">입력 주소</label></div>
							<div class="addr" data-addr="${addr}" data-addr2="${addrDetail}"><span class="post">${postNo}</span><p>${addr} ${addrDetail}</p></div>
						</li>
					</ul>
				</div><!-- addrList -->
				
				<div class="btnDiv taC mt20">
					<button type="button" class="btn white pop" onclick="javascript:retrySearch();"><span>다시검색</span></button>
					<button type="button" class="btn blue pop" onclick="javascript:confirm();"><span>확인</span></button>
				</div>

			</div><!-- // viewDiv -->
		</div><!-- // tabBox -->

	</div><!-- // popContent -->
</div>
