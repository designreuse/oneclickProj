
var HST_BCK_TARGET_SCROLL_TOP = 0;

/**
* 로드 이벤트 리스너
*/
function HIS_BCK_loadListener(e) {
    var data = HST_BCK_restoreData();
    
    if (data == null) {
        // 새로 불러오기
        HST_BCK_startOver();

    } else {
        // 이전 데이터 복원
        HST_BCK_restroePreviousState(data);
    }

    $(document).bind("scroll", HIS_BCK_scrollListener);
}

/**
* 페이지 스크롤 이벤트 리스너
*/
function HIS_BCK_scrollListener(e) {
    $("#HIS_BCK_SCROLL_TOP").val($(window, document).scrollTop());
}

/**
* 이전 위치로 스크롤
*/
function HIS_BCK_scrollToPrevious() {
    var scr = $("#HIS_BCK_SCROLL_TOP").val();

    if (scr != 0) {
        HST_BCK_TARGET_SCROLL_TOP = scr;
        $(window, document).scrollTop(scr);
    }
}

/**
* 이전 상태 복원하기
* @param data 이전 저장된 데이터
*/
function HST_BCK_restroePreviousState(data) {
    // please override
    HIS_BCK_scrollToPrevious();
}

/**
* 처음부터 시작하기
*/
function HST_BCK_startOver() {
    // please override
    HIS_BCK_scrollToPrevious();
}

/**
* 세션스토리지 ID 구하기
*/
function HST_BCK_getSSID(name) {
    if ($("#HIS_BCK_SSID").length == 0) { return; }

    var ssid = $("#HIS_BCK_SSID").val();
    if (ssid == undefined || ssid == "") {
        var now = new Date();
        ssid = "SSID_" + now.getTime() + "_" + Math.floor(Math.random() * 100000000);
    }
    
    $("#HIS_BCK_SSID").val(ssid);
    //HST_BCK_SSN_STR_ID = ssid;
    if (name != undefined) {
        ssid = ssid + "_" + name;
    }

    return ssid;
}

/**
* 세션스토리지에 저장하기
*/
function HST_BCK_saveData(obj, name) {
    //if(name == undefined){ return false; }
    if (obj == undefined) { return false; }

    try {
        var ssid = HST_BCK_getSSID(name);
        if (ssid == undefined) { return false; }
        sessionStorage.setItem(ssid, JSON.stringify(obj));
    } catch (e) {
        return false;
    }

    return true;
}

/**
* 세션스토리지에서 복원하기
*/
function HST_BCK_restoreData(name) {
    try {
        var ssid = HST_BCK_getSSID(name);
        if (ssid == undefined) { return null; }
        return JSON.parse(sessionStorage.getItem(ssid));
    } catch (e) {
        return null;
    }
}


$(function () {
    
    HIS_BCK_loadListener();
    
    //$(window).bind("load", HIS_BCK_loadListener);
});
