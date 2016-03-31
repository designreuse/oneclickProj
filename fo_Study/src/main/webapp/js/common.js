$(document).ready(function () {

	// 제휴사 슬라이드 배너
	// fn_rollToEx('slider', 'banner', 'control', 2, true);
	
	// gnb
	$(".gnbList li a").click(function(){
		if (!$(this).hasClass("current")) {
			$(this).addClass("current").parent("li").siblings("li").find("a.current").removeClass("current");
		} else {
			$(this).removeClass("current");
		}
	});

	// 사이드메뉴
//	$(".menuList li a").click(function(){
//		if (!$(this).hasClass("current")) {
//			$(this).addClass("current").parent("li").siblings("li").find("a.current").removeClass("current");
//		} else {
//			$(this).removeClass("current");
//		}
//	});

	// 팝업 탭 메뉴
//	$(".srchTabMenu li a").click(function(){
//		if (!$(this).hasClass("current")) {
//			$(this).addClass("current").parent().parent("li").siblings("li").find("a.current").removeClass("current");
//		} else {
//			$(this).removeClass("current");
//		}
//	});
	

	// -------------------------------
	// form
	//--------------------------------

	// 라디오, 체크박스
//	 customCheckbox();
//	 customRadio();


	// 셀렉트박스
	var select = $("select.select");
	select.change(function(){
		var select_name = $(this).children("option:selected").text();
		$(this).siblings("label").text(select_name);
	});
	// 2016-03-16 추가
	select.focus(function(){
		$(this).parent().addClass("focusLine");
	});
	select.focusout(function(){
		$(this).parent().removeClass("focusLine");
	});


	// 인풋 포커스
	var target = $("input.input_text");
	
	target.focus(function(){
		$(this).addClass("focusLine");
	});

	target.focusout(function(){
		$(this).removeClass("focusLine");
	});


	// 인풋 포커스 placeholder
	function add() {
		if($(this).val() === ''){
			$(this).val($(this).attr('placeholder')).addClass('placeholder');
		}
	}
	function remove() {
		if($(this).val() === $(this).attr('placeholder')){
			$(this).val('').removeClass('placeholder');
		}
	}
	if (!('placeholder' in $('<input>')[0])) {
		$('input[placeholder], textarea[placeholder]').blur(add).focus(remove).each(add);
		$('form').submit(function(){
			$(this).find('input[placeholder], textarea[placeholder]').each(remove);
		});
	}

}); // document



// -------------------------------
// 라디오, 체크박스
//--------------------------------
function customCheckbox(){
	$("input.checkBox").each(function(){
		$(this).wrap( "<span class='customCheck'></span>" );
		if($(this).is(":checked")){
			$(this).parent().addClass("selected");
		}
		if($(this).is(":disabled")){
			$(this).parent().addClass("disabled");
		}
		if($(this).hasClass("readonly")){
			$(this).parent().addClass("readonly");
		}
	});
	 $("input.checkBox").click(function(){
		if($(this).hasClass("readonly")){
			$(this).parent().addClass("readonly");
		}
		$(this).parent().toggleClass("selected");
	});
}

function customRadio(){
	$("input.radioBtn").each(function(){
		$(this).wrap( "<span class='customRadio'></span>" );
		if($(this).is(":disabled")){
			$(this).parent().addClass("disabled");
		}
		if($(this).is(":checked")){
			$(this).parent().addClass("selected");
		}
	});

	 $("input.radioBtn").click(function(){
		if($(this).is(":checked")){
			$(this).parent().addClass("selected");
			$(".radioBtn:not(:checked)").parent().removeClass("selected");
		}
	});
	 
	 $( ".innerTable" ).on("click", "input.radioBtn", function() {
		  if($(this).is(":checked")){
		   $(this).parent().addClass("selected");
		   $(".radioBtn:not(:checked)").parent().removeClass("selected");
		  }
		 });
}



// -------------------------------
// 제휴사 슬라이드 배너
//--------------------------------
function fn_rollToEx(containerID,slideID,controlID,stepNum,autoStart){

	// 롤링할 객체를 변수에 담아둔다.
	var el = $('#'+containerID).find('#'+slideID);
	var lastChild;
	var speed = 4000;
	var timer = 0;
	var autoplay = false;

	el.data('prev', $('#'+containerID).find('.prev'));	//이전버튼을 data()메서드를 사용하여 저장한다.
	el.data('next', $('#'+containerID).find('.next'));	//다음버튼을 data()메서드를 사용하여 저장한다.
	el.data('size', el.children().outerWidth());		//롤링객체의 자식요소의 넓이를 저장한다.
	el.data('len', el.children().length);				//롤링객체의 전체요소 개수
	el.data('animating',false);
	el.data('step', stepNum);								//매개변수로 받은 step을 저장한다.
	el.data('autoStart', false);								//매개변수로 받은 step을 저장한다.
	el.data('play', null);
	el.data('stop', null);

	el.css('width',el.data('size')*el.data('len'));		//롤링객체의 전체넓이 지정한다.

	if(arguments[4]==true){
		el.data('autoStart', autoStart);
	}

	if(arguments[2]!= undefined){
		el.data('play', $('#'+controlID).find('.bStart'));
		el.data('stop', $('#'+controlID).find('.bStop'));
	}

	if(el.data('autoStart')){
		if(timer==0){
			timer = setInterval(moveNextSlide, speed);
			autoplay = true;
		}
	}

	el.bind({
		mouseenter:function(){
			if(!autoplay) return false;

			if(timer!=0 && el.data('autoStart')){
				clearInterval(timer);
				timer=0;
			}
		},
		mouseleave:function(){
			if(!autoplay) return false;

			if(timer==0 && el.data('autoStart')){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});


	//el에 첨부된 prev 데이타를 클릭이벤트에 바인드한다.
	el.data('prev').bind({
		click:function(e){
			e.preventDefault();
			movePrevSlide();
		},
		mouseenter:function(){
			if(!autoplay) return false;

			if(timer!=0 && el.data('autoStart')){
				clearInterval(timer);
				timer=0;
			}
		},
		mouseleave:function(){
			if(!autoplay) return false;

			if(timer==0 && el.data('autoStart')){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});

	//el에 첨부된 next 데이타를 클릭이벤트에 바인드한다.
	el.data('next').bind({
		click:function(e){
			e.preventDefault();
			moveNextSlide();
		},
		mouseenter:function(){
			if(!autoplay) return false;

			if(timer!=0 && el.data('autoStart')){
				clearInterval(timer);
				timer=0;
			}
		},
		mouseleave:function(){
			if(!autoplay) return false;

			if(timer==0 && el.data('autoStart')){
				timer = setInterval(moveNextSlide, speed);
			}
		}
	});

	if(arguments[4]!= undefined){
		el.data('play').bind({
			click:function(){
				if(timer==0 && el.data('autoStart')){
					timer = setInterval(moveNextSlide, speed);
					autoplay = true;
				}
			}
		});

		el.data('stop').bind({
			click:function(){
				if(timer!=0 && el.data('autoStart')){
					clearInterval(timer);
					timer=0;
					autoplay = false;
				}
			}
		});
	}

	function movePrevSlide(){
		if(!el.data('animating')){
			//전달된 step개수 만큼 롤링객체의 끝에서 요소를 선택하여 복사한후 변수에 저장한다.
			var lastItem = el.children().eq(-(el.data('step')+1)).nextAll().clone(true);
			lastItem.prependTo(el);		//복사된 요소를 롤링객체의 앞에 붙여놓는다.
			el.children().eq(-(el.data('step')+1)).nextAll().remove();	//step개수만큼 선택된 요소를 끝에서 제거한다
			el.css('left','-'+(el.data('size')*el.data('step'))+'px');	//롤링객체의 left위치값을 재설정한다.
		
			el.data('animating',true);	//애니메이션 중복을 막기 위해 첨부된 animating 데이타를 true로 설정한다.

			el.animate({'left': '0px'},'2000',function(){		//롤링객체를 left:0만큼 애니메이션 시킨다.
				el.data('animating',false);
			});
		}
		return false;
	}

	function moveNextSlide(){
		if(!el.data('animating')){
			el.data('animating',true);

			el.animate({'left':'-'+(el.data('size')*el.data('step'))+'px'},'2000',function(){	//롤링객체를 첨부된 size와 step을 곱한 만큼 애니메이션 시킨다.
				//전달된 step개수 만큼 롤링객체의 앞에서 요소를 선택하여 복사한후 변수에 저장한다.
				var firstChild = el.children().filter(':lt('+el.data('step')+')').clone(true);
				firstChild.appendTo(el);	//복사된 요소를 롤링객체의 끝에 붙여놓는다.
				el.children().filter(':lt('+el.data('step')+')').remove();	//step개수만큼 선택된 요소를 앞에서 제거한다
				el.css('left','0px');	////롤링객체의 left위치값을 재설정한다.

				el.data('animating',false);
			});
		}
		return false;
	}
}

//-------------------------------
// 윈도우 팝업
//--------------------------------

function openCommonPopup(actionUrl, params, pWidth, pHeight, winNm) {
	//console.log(actionUrl);
	if ( actionUrl != undefined ) {
		var winName = "E.LAND OneClick";
		if ( winNm != undefined ) {
			winName = winNm;
		}
		if ( pWidth == "" ) {
			pWidth = 600;
		}
		if ( pHeight == "" ) {
			pHeight = 660;
		}
		openPopupGet(actionUrl, params, winName, pHeight, pWidth);
	}
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
var birth = new Array();
var phone = new Array();
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

/**
 * 생년월일 - 2월(28/29일) & 30/31일 처리
 * selectedVal: 선택한 년도
 */
function chgYear(selectedVal) {
	
	selectBirthCheck();
	
	 if (parseInt(selectedVal) % 4 == 0) {
		 if ("02" == $("#month option:selected").val()) {
			 if ("28" == $("#day option:last").val()) {
				 $("#day option:last").after('<option value="29">29</option>');
			 } else {
				$("#day").val("29").attr("selected", true);
	 			$("#day option:selected").nextAll().remove();
			 }
		 }
	 } else {
		if ("02" == $("#month option:selected").val()) {
			if ("02" == $("#month option:selected").val()) {
				$("#day").val("28").attr("selected", true);
				$("#label_day").text("28");
	 			$("#day option:selected").nextAll().remove();
			}
		}
	 }
}

/**
 * 생년월일 - 2월(28/29일) & 30/31일 처리
 * selectedVal: 선택한 월
 * chgYn: 월 선택 시, 일을 '01'일로 바꿀것인지 여부
 */
function chgMonth(selectedVal, chgYn) {
	
	selectBirthCheck();
	
	var months = ["04", "06", "09", "11"];
	if ($.inArray(selectedVal, months) >= 0) {
		if ("31" == $("#day option:last").val()) {
			$("#day option:last").remove();
		} else if ("29" == $("#day option:last").val()) {
			$("#day option:last").after('<option value="30">30</option>');
		} else if ("28" == $("#day option:last").val()) {
			$("#day option:last").after('<option value="29">29</option>');
			$("#day option:last").after('<option value="30">30</option>');
		}
	} else {
		if ("30" == $("#day option:last").val()) {
			$("#day option:last").after('<option value="31">31</option>');
		} else if ("29" == $("#day option:last").val()) {
			$("#day option:last").after('<option value="30">30</option>');
			$("#day option:last").after('<option value="31">31</option>');
		} else if ("28" == $("#day option:last").val()) {
			$("#day option:last").after('<option value="29">29</option>');
			$("#day option:last").after('<option value="30">30</option>');
			$("#day option:last").after('<option value="31">31</option>');
		}		
	}
	if ("02" == selectedVal) {
		var birthYear = parseInt($("#year option:selected").val());
		if (birthYear % 4 == 0) {
			$("#day").val("29").attr("selected", true);
			$("#day option:selected").nextAll().remove();
		} else {
			$("#day").val("28").attr("selected", true);
			$("#day option:selected").nextAll().remove();
		}
	}
	if (chgYn) {
		  $("#day").val("01").attr("selected", true);
		  $("label[for=day]").text("01");
		 }

}

function chgDay(selectedVal, chgYn) {
	selectBirthCheck();
}

function selectBirthCheck() {
	
	if ($("#year").val() != "" && $("#month").val() != "" && $("#day").val() != "") {
		$("#td_birth > em").remove();
	}
}

/**
 * 결혼기념일 - 2월(28/29일) & 30/31일 처리
 * selectedVal: 선택한 년도
 */
function chgWedYear(selectedVal) {
	if (parseInt(selectedVal) % 4 == 0) {
		if ("02" == $("#m_month option:selected").val()) {
			if ("28" == $("#m_day option:last").val()) {
				$("#m_day option:last").after('<option value="29">29</option>');
			} else {
				$("#m_day").val("29").attr("selected", true);
			 	$("#m_day option:selected").nextAll().remove();
			}
		}
	} else {
		if ("02" == $("#m_month option:selected").val()) {
			if ("02" == $("#m_month option:selected").val()) {
				$("#m_day").val("28").attr("selected", true);
				$("#m_day option:selected").nextAll().remove();
			}
		}
	}
}

/**
 * 결혼기념일 - 2월(28/29일) & 30/31일 처리
 * selectedVal: 선택한 월
 * chgYn: 월 선택 시, 일을 '01'일로 바꿀것인지 여부
 */
function chgWedMonth(selectedVal, chgYn) {
	var months = ["04", "06", "09", "11"];
	if ($.inArray(selectedVal, months) >= 0) {
		if ("31" == $("#m_day option:last").val()) {
			$("#m_day option:last").remove();
		} else if ("29" == $("#m_day option:last").val()) {
			$("#m_day option:last").after('<option value="30">30</option>');
		} else if ("28" == $("#day option:last").val()) {
			$("#m_day option:last").after('<option value="29">29</option>');
			$("#m_day option:last").after('<option value="30">30</option>');
		}
	} else {
		if ("30" == $("#m_day option:last").val()) {
			$("#m_day option:last").after('<option value="31">31</option>');
		} else if ("29" == $("#m_day option:last").val()) {
			$("#m_day option:last").after('<option value="30">30</option>');
			$("#m_day option:last").after('<option value="31">31</option>');
		} else if ("28" == $("#m_day option:last").val()) {
			$("#m_day option:last").after('<option value="29">29</option>');
			$("#m_day option:last").after('<option value="30">30</option>');
			$("#m_day option:last").after('<option value="31">31</option>');
		}		
	}
	if ("02" == selectedVal) {
		var wedYear = parseInt($("#m_year option:selected").val());
		if (wedYear % 4 == 0) {
			$("#m_day").val("29").attr("selected", true);
			$("#m_day option:selected").nextAll().remove();
		} else {
			$("#m_day").val("28").attr("selected", true);
			$("#m_day option:selected").nextAll().remove();
		}
	}
	if (chgYn) {
	  $("#m_day").val("01").attr("selected", true);
	  $("label[for=m_day]").text("01");
	 }
}

/**
 * 자녀 생년월일 - 2월(28/29일) & 30/31일 처리
 * selectedVal: 선택한 년도
 */
function chgChildBirthYear(selectedVal) {
	var childNum = $("#tbody_children > tr").size();
	
	for (var i=0; i<childNum; i++) {
		if (parseInt(selectedVal) % 4 == 0) {
			if ("02" == $("#child_month"+(i+1)+" option:selected").val()) {
				if ("28" == $("#child_day"+(i+1)+" option:last").val()) {
					$("#child_day"+(i+1)+" option:last").after('<option value="29">29</option>');
				} else {
					$("#child_day"+(i+1)).val("29").attr("selected", true);
		 			$("#child_day"+(i+1)+" option:selected").nextAll().remove();
				}
			}
		} else {
			if ("02" == $("#child_month"+(i+1)+" option:selected").val()) {
				if ("02" == $("#child_month"+(i+1)+" option:selected").val()) {
					$("#child_day"+(i+1)).val("28").attr("selected", true);
		 			$("#child_day"+(i+1)+" option:selected").nextAll().remove();
				}
			}
		 }
	}
	
}

/**
 * 자녀 생년월일 - 2월(28/29일) & 30/31일 처리
 * selectedVal: 선택한 월
 * chgYn: 월 선택 시, 일을 '01'일로 바꿀것인지 여부
 * addCount: 자녀 추가한 경우
 *           0 -> 자녀 추가 아니고, 저장된 자녀 정보 불러왔을 때
 *           0 이상 -> 추가한 자녀(몇 번째로 추가했는지) 
 */
function chgChildBirthMonth(selectedVal, chgYn, addCount) {
	if (selectedVal != "" && selectedVal != "선택") {		
		if (addCount == 0) {
			var childNum = $("#tbody_children > tr").size();
			for (var i=0; i<childNum; i++) {
				var months = ["04", "06", "09", "11"];
				if ($.inArray(selectedVal, months) >= 0) {
					if ("31" == $("#child_day"+(i+1)+" option:last").val()) {
						$("#child_day"+(i+1)+" option:last").remove();
					} else if ("29" == $("#child_day"+(i+1)+" option:last").val()) {
						$("#child_day"+(i+1)+" option:last").after('<option value="30">30</option>');
					} else if ("28" == $("#day option:last").val()) {
						$("#child_day"+(i+1)+" option:last").after('<option value="29">29</option>');
						$("#child_day"+(i+1)+" option:last").after('<option value="30">30</option>');
					}	
				} else {
					if ("30" == $("#child_day"+(i+1)+" option:last").val()) {
						$("#child_day"+(i+1)+" option:last").after('<option value="31">31</option>');
					} else if ("29" == $("#child_day"+(i+1)+" option:last").val()) {
						$("#child_day"+(i+1)+" option:last").after('<option value="30">30</option>');
						$("#child_day"+(i+1)+" option:last").after('<option value="31">31</option>');
					} else if ("28" == $("#child_day"+(i+1)+" option:last").val()) {
						$("#child_day"+(i+1)+" option:last").after('<option value="29">29</option>');
						$("#child_day"+(i+1)+" option:last").after('<option value="30">30</option>');
						$("#child_day"+(i+1)+" option:last").after('<option value="31">31</option>');
					}		
				}
				if ("02" == selectedVal) {
					var birthYear = parseInt($("#child_year"+(i+1)+" option:selected").val());
					if (birthYear % 4 == 0) {
						$("#child_day"+(i+1)).val("29").attr("selected", true);
						$("#child_day"+(i+1)+" option:selected").nextAll().remove();
					} else {
						$("#child_day"+(i+1)).val("28").attr("selected", true);
						$("#child_day"+(i+1)+" option:selected").nextAll().remove();
					}
				}
				if (chgYn) {
					$("#child_day"+(i+1)).val("01").attr("selected", true);
					$("label[for=child_day"+(i+1)+"]").text("01");
				}
			}
		} else if (addCount > 0) {
			var months = ["04", "06", "09", "11"];
			if ($.inArray(selectedVal, months) >= 0) {
				if ("31" == $("#child_day"+addCount+" option:last").val()) {
					$("#child_day"+addCount+" option:last").remove();
				} else if ("29" == $("#child_day"+addCount+" option:last").val()) {
					$("#child_day"+addCount+" option:last").after('<option value="30">30</option>');
				} else if ("28" == $("#day option:last").val()) {
					$("#child_day"+addCount+" option:last").after('<option value="29">29</option>');
					$("#child_day"+addCount+" option:last").after('<option value="30">30</option>');
				}	
			} else {
				if ("30" == $("#child_day"+addCount+" option:last").val()) {
					$("#child_day"+addCount+" option:last").after('<option value="31">31</option>');
				} else if ("29" == $("#child_day"+addCount+" option:last").val()) {
					$("#child_day"+addCount+" option:last").after('<option value="30">30</option>');
					$("#child_day"+addCount+" option:last").after('<option value="31">31</option>');
				} else if ("28" == $("#child_day"+addCount+" option:last").val()) {
					$("#child_day"+addCount+" option:last").after('<option value="29">29</option>');
					$("#child_day"+addCount+" option:last").after('<option value="30">30</option>');
					$("#child_day"+addCount+" option:last").after('<option value="31">31</option>');
				}		
			}
			if ("02" == selectedVal) {
				var birthYear = parseInt($("#child_year"+addCount+" option:selected").val());
				if (birthYear % 4 == 0) {
					$("#child_day"+addCount).val("29").attr("selected", true);
					$("#child_day"+addCount+" option:selected").nextAll().remove();
				} else {
					$("#child_day"+addCount).val("28").attr("selected", true);
					$("#child_day"+addCount+" option:selected").nextAll().remove();
				}
			}
			if (chgYn) {
				$("#child_day"+addCount).val("01").attr("selected", true);
				$("label[for=child_day"+addCount+"]").text("01");
			}
		}
		
		

	}
	
}

