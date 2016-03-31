/*$(document).ready(function () {*/
var birth = new Array();
var phone = new Array();
$(document).on("pageinit", "#dvwrap", function(event) {

	// -------------------------------
	// header
	//--------------------------------
	$(document).scroll(function(){
		if($(document).scrollTop() > 50) {
			$("header").addClass("on");
		}	else {
			$("header").removeClass("on");
		}
	});

	// -------------------------------
	// 사이드메뉴
	//--------------------------------
	$(".leftList .dep2").hide(); 
	$("#dvwrap").append("<div class='overlay'></div>")

	$(".dep2 li a").click(function () {
		if ($(this).hasClass("select")) {
			return;
		}
		$(".dep2 li a.select").removeClass("select");
		$(this).addClass("select");
	});
	
	$('.leftList>li>a').click(function(){
		var $obj = $(this).next(".dep2");
		$(this).toggleClass("select").next(".dep2").slideToggle("fast");
		$(".dep2").not($obj).each(function(){
			$(this).slideUp("fast").siblings("a").removeClass("select");
			$(this).children().find("a.select").removeClass();
		});
	});

	var scrollValue;
	$(".hdMenu").click(function () {
		scrollValue = $(document).scrollTop();
		$("#dvwrap").css({"position":"fixed" ,"top":-scrollValue});
	});

	$("#leftpanel").bind({
		panelbeforeopen: function() { 
			$(".overlay").fadeIn("100");
		},
		panelbeforeclose: function() { 
			$(".overlay").fadeOut("100");
		},
		panelopen: function() { 
			$("body").css({"overflow":"hidden"});
		},
		panelclose: function() { 
			$("#dvwrap").css({"position":"" ,"top":""});
			$("body").css({"overflow":""});
			$(document).scrollTop(scrollValue);
		}
	});
	
	$(".overlay").bind({
		click: function() { 
			$("#leftpanel").panel("close");
		},
		swipe: function() { 
			$("#leftpanel").panel("close");
		}
	});


	// -------------------------------
	// 팝업 (layer)
	//--------------------------------
	$(".popupBox").each(function () {
		$(this).parent(".ui-popup-container").addClass("layer");
	});


	// -------------------------------
	// 팝업 (full screen)
	//--------------------------------
	$(".popWrap").each(function () {
		$(this).parent().parent(".ui-popup-container").addClass("full");
		$(this).parent().addClass("fullPopup"); // #pagePopup1 대신 쓰기
	});

	var popScrollValue;
	$(".fullPopup").bind({
		popupbeforeposition: function() {
			$(this).css({
				width: document.innerWidth,
				height: document.innerHeight
			});
		},
		x: 0,
		y: 0
	});
	$(".fullPopup").bind({
		popupafteropen: function() { 
			popScrollValue = $(document).scrollTop();
			$("#dvwrap").css({"position":"fixed" ,"top":-popScrollValue});
			$("body,.container.ui-content").css({"overflow":"hidden"});
		},
		popupafterclose: function() { 
			$("#dvwrap").css({"position":"" , "top":""});
			$(document).scrollTop(popScrollValue);
			$("body,.container.ui-content").css({"overflow":""});
		}
	});
	// 컨텐츠영역 세로 정렬
	$(".popWrap.fix .popContent>div").not(".btnDiv").wrapAll('<div class="fixDiv" />');


	// -------------------------------
	// 하단 toolbar
	//--------------------------------
	$(".toolbar").append('<div class="dim"></div>');
	$(".list").hide();

	var listScrollValue;
	var dim = $(".dim");

	$(".toolbar .link_tab").on("click",function (event) {

		if ($(this).hasClass("current")) {
			// 리스트 사라짐
			$(this).removeClass("current").next().slideUp("fast");
			$("#dvwrap").css({"position":"" ,"top":""});
			$(document).scrollTop(listScrollValue);
		} else {
			// 클릭한 리스트 보여지고 다른것은 사라짐
			$(this).addClass("current").next().slideDown("fast");
			$(this).parent().siblings().children(".current").removeClass("current").next().slideUp("fast");
			listScrollValue = $(document).scrollTop();
			$("#dvwrap").css({
				"position" : "fixed",
				"top":-listScrollValue
			});
			dim.show();
		}
	});

	dim.bind({
		click:function(){
			$(this).fadeOut();
			$(".list").slideUp("fast");
			$(".toolbar .link_tab").removeClass("current");
			$("#dvwrap").css({"position":"" ,"top":""});
			$(document).scrollTop(listScrollValue);
		}
	});

	// 하단 약관상세 스크롤리스트 
	$(".list ul li").find("a").click(function () {
		$("#dvwrap").css({"position":"" ,"top":""});
		$(document).scrollTop(listScrollValue);
		$(this).parent().parent().parent().slideUp().siblings("a").removeClass("current");
		//$(this).parent().parent().parent().siblings("a").removeClass("current");
		$(".dim").hide();

	});
	// 본문으로 링크 이동 :: #termList1 = .list
	$("#termList1 li").children("a").click(function(event){
		event.preventDefault();
		$('html,body').stop().animate({scrollTop:$(this.hash).offset().top - 50}, 500);
		
	});


	// -------------------------------
	// gotop
	//--------------------------------
	$(".btn_goTop").fadeOut(0);
	$(document).scroll(function(){
		if($(document).scrollTop() > 700) {
			$(".btn_goTop").fadeIn(500);
		} else {
			$(".btn_goTop").fadeOut(500);
		}
	});
	$(".btn_goTop").click(function(){
		$("html, body").animate({scrollTop:0}, 500);
	})

}); // document


// ----------------------------------------------
// popup (normal)
// ----------------------------------------------
function normalPopup (id){

	var $popupid = $("#" + id);
	//var $popupid = $(".popupBox.normal");
	var $leftP = ( $(window).scrollLeft() + ($(window).width() - $popupid.width()) / 2 );
	var $topP = ( $(window).scrollTop() + ($(window).height() - $popupid.height()) / 2 );
	var $maxWidth = $(window).width()-32;
	var $closBtn = $popupid.find('.layerClose');

	$("#dvwrap").append('<div class="dim"></div>');
	$popupid.css({ 'top':$topP ,'left':$leftP, 'max-width':$maxWidth });
		
	if( $(window).width() < 600) {
		$popupid.css({ 'left':'15px' });
	} else {
		$popupid.css({ 'left':$leftP });
	}

	$("div.dim").fadeIn(300);
	setTimeout(function() {	$('div.dim').css("height",$(document).height()); }, 10);
	$(window).on("resize", function () { $('div.dim').css("height",$(document).height()); }).resize();
	//$popupid.wrap("<div class='normalWrap'></div>" );
	$popupid.show();
	$closBtn.click(function () {
		$hide();
	});
	$('div.dim').click(function () {
		$hide();
	});
	
	$hide = function (){
		$('div.dim').fadeOut(100);
		$popupid.fadeOut();
	};

}


/**
 * 팝업호출
 * 
 * @param url
 * @param params
 * @param windowName
 * @param iHeight
 * @param iWidth
 */
function openPopupGet(url, params, windowName, iHeight, iWidth){
    var popupX  = (screen.availWidth - iWidth)/2 ;
    var popupY  = (screen.availHeight - iHeight)/2 ;
    var popupSet  = "top=" + popupY + ",left=" + popupX + ",width=" + iWidth + ",height=" + iHeight + ",history=no,toolbar=no,menubar=no,resizable=no,status=no,scrollbars=yes" ;
    var param = "?";
    	for(var paramObject in params){
    		var key = paramObject;
    		var val = params[key];
    		param += key + "=" + encodeURIComponent(val) + "&";
    	}
    param = param.substring(0, param.length - 1);
    window.open(url + param, windowName, popupSet);
}

/**
 * 팝업호출
 * @param url, params, windowName, iHeight, iWidth
 * @returns
 */
function openPopup(url, params, windowName, iHeight, iWidth) {
	
	var winl   = (screen.width - iWidth) / 2;
	var wint   = (screen.height - iHeight) / 2 - 50;
	var option = 'location=0,status=0,toolbar=0,statusbar=0,scrollbars=yes,resizable=no,left='+winl+',top='+wint+',width='+iWidth+',height='+iHeight;
	var form   = createForm(params);
	var newWin = window.open('', windowName, option);

	submitPopup(form, url, windowName);
	discardForm(form);

	newWin.opener = this;
	return newWin;
}

var PCC_window; 

function openPCCWindow(){ 
    var PCC_window = window.open('', 'PCCV3Window', 'width=430, height=560, resizable=1, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );

    if(PCC_window == null){ 
		 alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
    }

    document.reqPCCForm.action = 'https://pcc.siren24.com/pcc_V3/jsp/pcc_V3_j10.jsp';
    document.reqPCCForm.target = 'PCCV3Window';
    document.reqPCCForm.submit();
}

//아이핀 팝업창 오픈
var CBA_window;
function openCBAWindow() { 

    CBA_window = window.open('', 'cbafsh', 'width=450, height=500, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );

    if(CBA_window == null){
		alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
		;return false;
    }
		
	document.ipinForm.action = 'https://ipin.siren24.com/i-PIN/jsp/ipin_j10.jsp';
    document.ipinForm.target = 'cbafsh';
    document.ipinForm.method = "post";
    document.ipinForm.submit();

    return;
}

/**
 * 비밀번호 유효성 검사
 * 1. 8자 이상, 15자 이하
 * 2. 영문 대/소문자, 숫자, 특수기호 중 2가지 이상 조합
 * 3. 동일문자 3회이상 반복 불가
 * 4. 키보드 상 연속문자열 4자 이상 사용 불가
 * 5. 사용자아이디와 연속 3문자 이상 중복 불가
 * 6. 연속된 숫자/문자 3자 이상 사용불가
 */
function validatePassword(password, webId) {
	//숫자/문자의 순서대로 4자 이상 사용금지
	var strights = ['012345678901', '987654321098', 'abcdefghijklmnopqrstuvwxyzab', 'zyxwvutsrqponmlkjihgfedcbazy'];
	//연속된 키보드 조합
	var keypads = [
		       		'`1234567890-=', 	'=-0987654321`', 	'~!@#$%^&*()_+', 	'+_)(*&^%$#@!~',
		       		'qwertyuiop[]\\', 	'\\][poiuytrewq', 	'QWERTYUIOP{}|',	'|}{POIUYTREWQ',
		       		'asdfghjkl;\'', 	'\';lkjhgfdsa', 	'ASDFGHJKL:"', 		'":LKJHGFDSA',
		       		'zxcvbnm,./', 		'/.,mnbvcxz', 		'ZXCVBNM<>?', 		'?><MNBVCXZ'
		       		];
	
	var getPattern = function(str, casesensitive) {
		//정규식 생성전에 예약어를 escape 시킨다.
		var reserves = ['\\', '^', '$', '.', '[', ']', '{', '}', '*', '+', '?', '(', ')', '|'];

		$.each(reserves, function(index, reserve){
			var pattern = new RegExp('\\' + reserve, 'g');
			if (pattern.test(str)) {
				str = str.replace(pattern, '\\' + reserve);
			}
		});
		var pattern = null;
		if (casesensitive == false) {
			pattern = new RegExp(str, 'i');
		} else {
			pattern = new RegExp(str);
		}
		return pattern;
	};

	// 1. 6자 이상, 15자 이하
	if (password.match(/^.{8,16}$/g) == null) {
		var strHtml = "<em class='fail'>비밀번호는 8자리 이상 16자리 미만으로 입력하세요.</em>";
		$("#em_pwdValidMsg").html("");
		$("#em_pwdValidMsg").append(strHtml);
		return false;
	}

	// 2. 영문 대/소문자, 숫자, 특수기호 중 3가지 이상 조합
	var valid_count = 0;
	if (password.match(/[a-z]/) != null) {
		valid_count++;
	}
	if (password.match(/[A-Z]/) != null) {
		valid_count++;
	}
	if (password.match(/[0-9]/) != null) {
		valid_count++;
	}
	if (password.match(/\W/) != null) {
		valid_count++;
	}
	if(valid_count < 3) {
		var strHtml = "<em class='fail'>비밀번호는 영문대문자/영문소문자/숫자/특수기호중 3가지 이상을 혼합하여 입력하세요.</em>";
		$("#em_pwdValidMsg").html("");
		$("#em_pwdValidMsg").append(strHtml);
		return false;
	}

	for (var i = 0 ; i < password.length ; i++) {
		if (password.charAt(i+1) != '' && password.charAt(i+2) != '') {
			//3. 동일문자 3회이상 반복 불가
			if (password.charCodeAt(i) == password.charCodeAt(i+1) && password.charCodeAt(i+1) == password.charCodeAt(i+2)) {
				var strHtml = "<em class='fail'>동일문자를 연속3회이상 반복 하실 수 없습니다.</em>";
				$("#em_pwdValidMsg").html("");
		 		$("#em_pwdValidMsg").append(strHtml);
				return false;
			}
			var str = password.charAt(i)+''+password.charAt(i+1)+''+password.charAt(i+2);

			var pattern = getPattern(str, false);

			//6. 연속된 숫자/문자 3자 이상 사용불가
			for (var j = 0 ; j < strights.length ; j++) {
				if (pattern.exec(strights[j]) != null) {
					var strHtml = "<em class='fail'>연속된 알파벳/숫자 조합을 사용할 수 없습니다.</em>";
					$("#em_pwdValidMsg").html("");
	 		 		$("#em_pwdValidMsg").append(strHtml);
					return false;
				}
			}

			//5. 사용자아이디와 연속 3문자 이상 중복 불가
			if (pattern.exec(webId) != null) {
				var strHtml = "<em class='fail'>아이디와 3자 이상 중복될 수 없습니다.</em>";
				$("#em_pwdValidMsg").html("");
	 		 	$("#em_pwdValidMsg").append(strHtml);
				return false;
			}
		}
	}

	//4. 키보드 상 연속문자열 4자 이상 사용 불가
	for (var i = 0 ; i < password.length ; i++) {
		if (password.charAt(i+1) != '' && password.charAt(i+2) != '' && password.charAt(i+3) != '') {
			var str = password.charAt(i)+''+password.charAt(i+1)+''+password.charAt(i+2) +''+ password.charAt(i+3);

			var pattern = getPattern(str);

			for (var j = 0 ; j < keypads.length ; j++) {
				if (pattern.exec(keypads[j]) != null) {
					var strHtml = "<em class='fail'>연속된 키보드 조합을 사용할 수 없습니다.</em>";
					$("#em_pwdValidMsg").html("");
		 		 	$("#em_pwdValidMsg").append(strHtml);
					return false;
				}
			}
		}
	}
	
	//5. 생년월일, 전화번호
	for (var i = 0 ; i < password.length ; i++) {
		if (password.charAt(i+1) != '' && password.charAt(i+2) != '' && password.charAt(i+3) != '') {
			var str = password.charAt(i)+''+password.charAt(i+1)+''+password.charAt(i+2) +''+ password.charAt(i+3);

			var pattern = getPattern(str);

			for (var j = 0 ; j < birth.length ; j++) {
				if (pattern.exec(birth[j]) != null) {
					var strHtml = "<em class='fail'>비밀번호에 생년월일을 포함하면 안됩니다.</em>";
					$("#em_pwdValidMsg").html("");
		 		 	$("#em_pwdValidMsg").append(strHtml);
					$("#password").focus();
					return false;
				}
			}
			
			for (var j = 0 ; j < phone.length ; j++) {
				if (pattern.exec(phone[j]) != null) {
					var strHtml = "<em class='fail'>비밀번호에 전화번호를 포함하면 안됩니다.</em>";
					$("#em_pwdValidMsg").html("");
		 		 	$("#em_pwdValidMsg").append(strHtml);
					$("#password").focus();
					return false;
				}
			}
		}
	}
	
	return true;
}


function commonConfirm(text, callback) {
	$.confirm({
		title: '',
		confirmButtonClass: 'btn white',
		cancelButtonClass: 'btn blue',
		content: text,
		cancelButton: '확인',
		confirmButton: '취소',
		backgroundDismiss: true, // 2016-03-14 추가
		confirm: function () {
			
		},
		cancel : function () {
			callback();
		}
	});
}
	
	function commonAlert(text) {
		$.alert({
			title: '',
	        content: text,
	        confirmButton: '확인',
	        confirmButtonClass: 'btn-primary',
	        confirm: function () {

	        }
	    });
	}

	

