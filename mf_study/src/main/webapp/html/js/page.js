// OS/browser check
var IS_ANDROID = false;
var IS_CHROME = false;
var IS_CHROME_SUCKS = false;
var IS_ANDROID_SUCKS = false;
var IS_IOS = false;
var IS_APP = false;
var app_ver = navigator.userAgent.toLowerCase();
if (/android/.test(app_ver)) { IS_ANDROID = true; }
if (/chrome/.test(app_ver)) { IS_CHROME = true; }
IS_ANDROID_SUCKS = IS_ANDROID && !IS_CHROME;

if (/iphone/.test(app_ver)) { IS_IOS = true; }
if (/ipad/.test(app_ver)) { IS_IOS = true; }
if (/ipod/.test(app_ver)) { IS_IOS = true; }


(function(){
    
    var special = $.event.special,
        uid1 = 'D' + (+new Date()),
        uid2 = 'D' + (+new Date() + 1);
        
    special.scrollstart = {
        setup: function() {
            
            var timer,
                handler =  function(evt) {
                    
                    var _self = this,
                        _args = arguments;
                    
                    if (timer) {
                        clearTimeout(timer);
                    } else {
                        evt.type = 'scrollstart';
                        $.event.handle.apply(_self, _args);
                    }
                    
                    timer = setTimeout( function(){
                        timer = null;
                    }, special.scrollstop.latency);
                    
                };
            
            $(this).bind('scroll', handler).data(uid1, handler);
            
        },
        teardown: function(){
            $(this).unbind( 'scroll', $(this).data(uid1) );
        }
    };
    
    special.scrollstop = {
        latency: 300,
        setup: function() {
            
            var timer,
                    handler = function(evt) {
                    
                    var _self = this,
                        _args = arguments;
                    
                    if (timer) {
                        clearTimeout(timer);
                    }
                    
                    timer = setTimeout( function(){
                        
                        timer = null;
                        evt.type = 'scrollstop';
                        $.event.handle.apply(_self, _args);
                        
                    }, special.scrollstop.latency);
                    
                };
            
            $(this).bind('scroll', handler).data(uid2, handler);
            
        },
        teardown: function() {
            $(this).unbind( 'scroll', $(this).data(uid2) );
        }
    };
    
})();

var this_top = 50;
var save_top = 0;
var d_top = 0;

// document scroll strat
$(window).scroll(function () {
	clearTimeout($.data(this, "scrollCheck"));
	$.data(this, "scrollCheck", setTimeout(function () {
			d_top = $('body').scrollTop(); // 현제 스크롤 위치
			scroll_check();
	}, 10));
	if (d_top < 50) {
			this_top = 50;
	} else {
			this_top = d_top; //현제 스크롤값 저장		
	}
});

/*$(window).bind('scrollstart', function(){	 });*/

// scroll Stop 
$(window).bind('scrollstop', function(e){			
		$.data(this, "scrollCheck", setTimeout(function () { 
				if ($('.btns_fix').hasClass('on') == false) {
						// 시간 지나면 버튼 다시 나타남.
						$('.btns_fix').addClass('on').animate({ 'bottom': '0' }, 120); // bottom button show	
				}
		}, 1200));	
});		


function scroll_check() {  

    if ($('.slide_area').css('display') == 'block') { var fix_check = 0; } else { var fix_check = 1; }

    if (this_top < d_top) { // scroll down 		
        if ($('header').hasClass('on') == false) {	//  header show	
            $('header').css({ 'top': '3px' }).animate({ 'top': '0' }, 20).addClass('on');
            $('div.basket_chk').css({ 'top': '35px' });//wish, basket top		
            return false;
        }
   			if (fix_check == 1) {												
						if ($('.btns_fix').hasClass('on')) {
								$('.btns_fix').removeClass('on').stop().animate({ 'bottom': '-60px' }, 120);	// bottom button hide	
								return false;
						}					
         }	
    	}

    if (this_top > d_top) { //scroll up	
        if ($('header').hasClass('on')) {
            $('header').css({ 'top': '-5px' }).animate({ 'top': '0' }, 20).removeClass('on');
            $('div.basket_chk').css({ 'top': '50px' });//wish, basket top	
						return false;	
        }			
				if (fix_check == 1) {
						if ($('.btns_fix').hasClass('on') == false) {
								$('.btns_fix').addClass('on').stop().animate({ 'bottom': '0' }, 120);  // bottom button show			
								return false;	
						}
				}
						
    }

    //Go Top button 
    if (d_top > 1500) { 
			if($('.btn_top').hasClass('on') == false){ $('.btn_top').addClass('on'); }
		}else { 
			if($('.btn_top').hasClass('on')){ $('.btn_top').removeClass('on');}	
		}

    if ($('.btn_top').hasClass('on')) {
			if($('.btn_top').css('display') == 'none'){						
					$('.btn_top').fadeIn(200);
					setTimeout(function () {
							$('.btn_top').fadeOut(200);
					}, 5000);
			}
    } else {
        $('.btn_top').fadeOut(200);
    }
   
}

$(function () {
	
		if($(window).width() > 359){
			$('#product_btn').removeClass('btns_fix');			
		}		
	
    $('.btns_fix').addClass('on');		

    resize_list(); //product List 

    // Button top

    $('.btn_top').click(function () {
        $('body').scrollTop(0);
        $('.btn_top').removeClass('on').hide();
        this_top = 50;
       // $('.btns_fix').addClass('on').css({ 'bottom': '-60px' }).animate({ 'bottom': '0' }, 150);
    });


    /*var name; // open layer name
    var layer_total =	$('.layer_box').length; //Porduct Option Array IScroll	

    for(k=0; k<layer_total; k++){
        var class_name = 'layer_scroll' + k;			
        $('.layer_box').eq(k).parent().addClass(class_name).css({'overflow':'hidden'});			
    }				
    Layer_PopScorller(layer_total);    */

    // Layer Open   
    $('.open_layer').click(function () {
        save_top = d_top;
        $('#dvwrap').css({ 'height': '100%', 'overflow': 'hidden' });

        name = $(this).attr('href');
        layer_open(name);

        if ($(name).hasClass('layer_note')) {
            layer_size(name);
            $('.dimlay').css('z-index', '9995');
            dim_on();
        }

    });

    // Layer Close   	
    $('.layer_area .btn_close').click(function () {
        var this_name = '#' + $(this).parent().attr('id');
        layer_close(this_name);
        $('#dvwrap').css({ 'height': 'auto', 'overflow': 'auto' });
        $('body').scrollTop(save_top);
    });
    // Layer Close   	
    /*$('.layer_area .btn_ok').click(function(){  			
            var this_name = '#' + $(this).parent().parent().parent().attr('id');		
        alert(name);
            layer_close(this_name);	
            $('#dvwrap').css({'height':'auto','overflow':'auto'});
            $('body').scrollTop(save_top);			
    });		*/

    // Layer Close   	
    $('.layer_note .btn_close').click(function () {				
        var this_name = '#' + $(this).parent().parent().attr('id');
        $('.dimlay').css({ 'display': 'none', 'z-index': '' });
        $('#dvwrap').css({ 'height': 'auto', 'overflow': 'auto' });
        $('body').scrollTop(save_top);
        layer_close(this_name);
    });
    // Layer Close   	
    $('.layer_note .btn_ok').click(function () {
        var this_name = '#' + $(this).parent().parent().parent().parent().attr('id');
        $('.dimlay').css({ 'display': 'none', 'z-index': '' });
        $('#dvwrap').css({ 'height': 'auto', 'overflow': 'auto' });
        $('body').scrollTop(save_top);
        layer_close(this_name);
    });

    // Layer Close info
    function layer_close(n) {
        if (n == '#product_comment_w' || n == '#product_qa_w' || n == '#comment_note') {
            $('.menu_link').removeClass('no');
            $('#dvwrap').css({ 'height': '100%', 'overflow': 'hidden' });
        } else {
            $('.menu_link').addClass('no');
            scroll_on();
        }

        $(n).fadeOut(100);

    }

    // Layer 이동 Tab 메뉴
    $('.menu_link .link_layer').click(function () {
        $('.layer_area').fadeOut(150);

        name = $(this).attr('href');
        layer_open(name);

    });


    // QA, 상품평 LIST onpen, close
    $('.pd_list >li>a').click(function () {
        /* if($(this).find('div').hasClass('con')){			 
         }else{			 
         }*/
        var txt_total = $(this).parent().find('.detail').text().length;
        var this_list = $(this).parent();

        if (txt_total > 0) {
            if (this_list.hasClass('on')) {
                this_list.removeClass('on').find('.detail').slideUp(100);
            } else {
                $('.pd_list >li').removeClass('on').find('.detail').slideUp(100);
                this_list.addClass('on').find('.detail').slideDown(100);
            }
        } else {
            if (this_list.hasClass('on')) {
                this_list.removeClass('on');
            } else {
                $('.pd_list >li').removeClass('on').find('.detail').slideUp(100);
                this_list.addClass('on');
            }
        }
        /*	for(k=0; k<layer_total; k++){
                    var n = '#' + $('.layer_box').eq(k).parent().parent().attr('id');
                    if(name == n ) { 								
                        var lay_n = k;					
                        setTimeout(function() {								
                            Layer_PopScorll[lay_n].refresh();
                        },200);	
                    }				    
            }	*/
    });


    // star score check
    $('.star_area dd button').click(function () {
        var star_name = '.' + $(this).parent().attr('class') + ' button';
        //var star_txt = '.'+$(this).parent().attr('class')+ ' span';
        var score = $(this).index();

        //	$(star_txt).text(score+1); // star score
        $(star_name).removeClass('on');

        for (i = 0; i <= score; i++) {
            $(star_name).eq(i).addClass('on').fadeIn(200);
        }

    });

    // bottom Layer full click
    $('.btn_full').click(function () {
        dim_out();
    });

    // Left Menu Open
    $('.hdMenu').click(function () {
        $('#leftMenu').animate({ left: 0 }, 250);
				$('.leftMenuDdim').css({'display':'block'});
        $('#leftMenu .leftLink').fadeIn(800);

        var left_h = $(window).height() - 50;
        MenuScroller(); //iscroll

        $('body').bind('touchmove', function (e) { e.preventDefault(); });
        $('body').css('overflow-y', 'hidden');
        MenuScroll01.refresh();
        MenuLink.refresh();
    });

    // Left Menu Close
    $('#leftMenu .close').click(function () {
        left_close();
    });

    function left_close() {
        $('#leftMenu').animate({ left: '-100%' }, 250);
        $('#leftMenu .leftLink').fadeOut(200);
        $('.leftMenuDdim').css({'display':'none'});      

        //$('#leftMenu .leftList > li ul').css({'display':'none'});
        //$('#leftMenu .leftList li').removeClass('on');
        //$('#leftMenu .leftList li a').removeClass('select');

        //$('.tabWrap > div').css('display','none');	
        //$('#leftMenu1').css('display','block');				

        //$('.leftLink li').removeClass('select');
        //$('.leftLink li:first-child').addClass('select');	
        //$('.leftLink li a').removeClass('on');			
        //$('.leftLink li.select a').addClass('on');		

        $('body').css('overflow-y', 'auto');
        $('body').unbind('touchmove');
        //document.removeEventListener('touchmove', function (e) { e.preventDefault(); }, false);		
    }

    // Left Menu List Slide
    $('#leftMenu .leftList li a.tit').click(function () {		
			if($(this).parent().hasClass('on') == false){
					$('#leftMenu .leftList ul').slideUp(120);		
					$('#leftMenu .leftList li').removeClass('on');
					$('#leftMenu .leftList li a').removeClass('select');		
				}
				leftMenuMove(this);			       
    });
	
		$('#leftMenu .leftList li li>a').click(function () {	
				if($(this).parent().hasClass('on') == false){
					$('#leftMenu .leftList li li>ul').slideUp(120);		
					$('#leftMenu .leftList li li').removeClass('on');
					$('#leftMenu .leftList li li a').removeClass('select');		
				}			
				leftMenuMove(this);			
		});																				 


    //left menu - category, search, customer	
    $('.leftLink li a.view').click(function () {
        var left_name = $(this).attr('href');
        $('.leftLink li').removeClass('select');
        $(this).parent().addClass('select');
        $('.leftLink li a').removeClass('on');
        $('.leftLink li.select a').addClass('on');

        $('.tabWrap > div').css('display', 'none');
        $(left_name).css('display', 'block');

        MenuScroll01.refresh();
        MenuScroll02.refresh();
        MenuScroll03.refresh();
        MenuLink.refresh();
    });

    //Search open
    $('.search').click(function () {
        $('.lay_search').css({ 'display': 'block' });
        SearchScroller(); //iscroll		
        scroll_out();
        SearchScroll01.refresh();
    });

    //Search Close		
    $('.search_close').click(function () {
        $('.lay_search').css({ 'display': 'none' });
        $('#search2').css({ 'display': 'none' });
        scroll_on();
    });

    $('.searchtab li').click(function () {
        $('.searchtab li').removeClass('select');
        $('.searchcont').css({ 'display': 'none' });
        $(this).addClass('select');

        var search_n = $(this).index();
        $('.searchcont').eq(search_n).css({ 'display': 'block' });

    });

    //living category open
    $('.living_category > strong').click(function () {
        var c_name = $(this).parent().find('.list_category a');
        var c_count = c_name.length - 1;
        c_name.eq(c_count).css('border', '0');
        if (c_count % 2 == 1) {
            c_name.eq(c_count - 1).css('border', '0');
        }

        $('.list_category a').removeClass('on');

        if ($(this).hasClass('on')) {
            $(this).removeClass('on');
            $(this).parent().find('.list_category').slideUp(200);
        } else {
            $(this).addClass('on');
            $(this).parent().find('.list_category').slideDown(200);
        }

    });

    //living category select and close	
    $('.main .list_category a').click(function () {
        $(this).addClass('on');
        $(this).parent().stop().slideUp(150);
        $(this).parent().parent().find('>strong').removeClass('on').text($(this).text());
    });

    //event category select and close	
    $('.event_tit .list_category a').click(function () {
        $(this).parent().parent().parent().stop().slideUp(150);
        $(this).parent().parent().parent().parent().find('>strong').removeClass('on');
    });


    //dim out
    $('.dimlay').click(function () {
        dim_out();
    });


    //search top
    $('.txt_show').click(function () {
        var txt_h = $('p.searchtxt span').css('height');
        if ($(this).hasClass('on')) {
            $(this).removeClass('on');
            $('p.searchtxt').animate({ 'height': '25px' }, 150);
        } else {
            $(this).addClass('on');
            $('p.searchtxt').animate({ 'height': txt_h }, 200);
        }
    });

    FixScrollSetting();

    //Porduct Option Array IScroll
    function FixScrollSetting() {
        var order_total = $('.orderbox').length;

        for (i = 0; i < order_total; i++) {
            var class_name = 'opt_scroll' + i;
            var this_h = $(window).height() / 2 + 50;

            if ($('.orderbox').eq(i).find('div').hasClass('multi')) {
                this_h = this_h - 79;
                $('.orderbox .multi').addClass(class_name).css({ 'overflow': 'hidden', 'max-height': this_h });
            } else {
                $('.orderbox').eq(i).addClass(class_name).css({ 'overflow': 'hidden', 'max-height': this_h });
            }

        }
        Button_FixScorller(order_total);
    }

    // category, bland, filter
    $('.btns_fix ul li').click(function () {
        if ($('div').hasClass('btn_slide')) {
            if ($(this).hasClass('on')) {
                $(this).removeClass('on');
                dim_out();
            } else {
                $('.btns_fix ul li').removeClass('on');
                $(this).addClass('on');

                dim_on();
                var this_name = $(this).find('a');
                var this_n = $(this).index();
                var this_con = $('.orderbox').eq(this_n);

                $('.btns_fix ul li a').addClass('btn2');
                $('.btns_fix ul li a span').removeClass('down');

                this_name.removeClass("btn2").addClass('btn1');
                this_name.find('span').addClass('down');

                $('.orderbox').fadeOut(100);
                this_con.css({ 'display': 'block', 'bottom': '-50px' }).animate({ 'bottom': '40px' }, 100);

                Button_FixScorll[this_n].refresh();
            }
        }
    });

    $('.slide_area .orderbox li').click(function () {
        if ($(this).parent().parent().hasClass('multi')) {
            if ($(this).hasClass('select')) {
                $(this).removeClass('select');
            } else {
                $(this).addClass('select');
            }
        } else {
            $(this).parent().parent().find('li').removeClass('select');
            $(this).addClass('select');
            dim_out();
            $('.btn_list3 li a').addClass("btn2");
            $('.btn_chk').find('span').removeClass('down');
        }
    });

    $('.sel_ok').click(function () {
        dim_out();
        $('.btn_list3 li a').addClass("btn2");
    });


    $('.btns_fix div >a').click(function () {
        if ($('div').hasClass('btn_slide')) {

            var id_name = $(this).attr('href');
            if (id_name == '#none') {
                var con_name = '.orderbox';
            } else {
                var con_name = id_name + ' .orderbox';
            }
            if ($(this).hasClass('on')) {
                $(this).removeClass('on');
                $(this).find('span').addClass('up');
                dim_out();
            } else {
                $('.btns_fix div > a').removeClass('on');
                $(this).addClass('on');

                dim_on();
                
                $(con_name).css({ 'display': 'block', 'bottom': '-30px' }).animate({ 'bottom': '44px' }, 200);
                $(this).find('span').addClass('down');

                Button_FixScorll[0].refresh();
            }
        }
    });


    $('#menuList').click(function () {
        dim_on();
        $('#menuList1').slideDown(100);        
        $('.slide_area').css('display', 'none');
				$('.btns_fix').addClass('on').animate({ 'bottom': '-60px' }, 120);		
    });

    $('#menuList1 .lay_close').click(function () {
        dim_out();
    });


    $(window).resize(function () {
        resize_list();  //리스트		
        resize_box();  //리스트	
        FixScrollSetting();
    });

    // Coaching 	
    $('div.coaching .btns').click(function () {
        $('.coachingbox').fadeOut(100);
        $('#dvwrap').css({ 'height': 'auto', 'overflow': 'auto' });
        $('body').css({ 'overflow-y': 'auto' });
        //$('body').unbind('touchmove');	
    });

    if ($('.coachingbox').css('display') == 'block') {
        $('#dvwrap').css({ 'height': '100%', 'overflow': 'hidden' });
        $('body').css({ 'overflow-y': 'hidden' })
        //$('body').bind('touchmove',function(e){ e.preventDefault(); });		
    }

});

//Layer Open info
function layer_open(name) {
    if (name == '#product_detail' || name == '#product_comment' || name == '#product_qa' || name == '#product_service') {
        $('.menu_link').removeClass('no');
        $('.menu_link').fadeIn(150);
        $('.menu_link .link_layer').removeClass('on');

        for (i = 0; i < $('.menu_link .link_layer').length; i++) {
            var link_name = $('.menu_link .link_layer').eq(i).attr('href');
            if (name == link_name) {
                $('.menu_link .link_layer').eq(i).addClass('on');
                name = link_name;
            }
        }
    } else {
        $('.menu_link').addClass('no');
    }

    if (name == '#product_detail') {
        try {
            setTimeout(function () {
                myScroll.refresh();
            }, 500);
        } catch (error) {
            console.log('exit');
        }
    }

    if (name == '#product_qa' || '#product_comment') {
        $('.pd_list li').removeClass('on').find('.detail').hide();
        $(name).show();
        scroll_out();
    } else {
        $(name).hide();
        scroll_out();
    }

    $('body').unbind('touchmove');

    /*for(k=0; k<layer_total; k++){
            var n = '#' + $('.layer_box').eq(k).parent().parent().attr('id');
            if(name == n ) { var lay_n = k;}				    
    }	

    if(lay_n > -1){
            setTimeout(function() {
                Layer_PopScorll[lay_n].refresh();
            },150);	
    }*/

    $(window).resize(function () {
        layer_size(name);
    });
}


function layer_size(name) {
    var note_name = name;
    var note_data = $(note_name).height();
    if ($(name).hasClass('layer_alert')) { note_data = note_data + 50; }

    var note_h = ($(window).height() - note_data) / 2;

    if (note_h > 0) {
        $(note_name).css({ 'top': note_h + 'px' });
    } else {
        $(note_name).css({ 'top': '0'/*, 'margin' : '15px'*/ });
    }
}

/* Loading */
function showLoadingBar() {
    $("body").append('<div class="load" style="display:block"><p><img src="/Images/common/loading.gif" alt=""></p></div>');
    //$('.dimlay').css("display", "block");
    $('body').bind('touchmove', function (e) { e.preventDefault(); });
}

function hideLoadingBar() {
    $('.load').remove();
   //$('.dimlay').css("display", "none");
    $('body').unbind('touchmove');
}


/* Alert Msg */
function commonAlert(msg) {
    $.alert({
        content: msg,
        confirmButton: '확인',
        confirmButtonClass: 'btn-primary',
        icon: 'fa fa-info',
        confirm: function () {

        }
    });
}

/* Alert Msg 2 */
function commonAlertUrl(msg, url) {
    $.alert({
        content: msg,
        confirmButton: '확인',
        confirmButtonClass: 'btn-primary',
        icon: 'fa fa-info',
        confirm: function () {
            location.href = url;
        },
        cancel: function () {
            location.href = url;
        }
    });
}

/* Alert Msg 3 */
function commonAlertCallBack(msg, callback1) {
    $.alert({
        content: msg,
        confirmButton: '확인',
        confirmButtonClass: 'btn-primary',
        icon: 'fa fa-info',
        confirm: function () {
            return callback1();
        }
    });
}

/* Alert Msg 4 */
function commonAlertParentUrl(msg, url) {
    $.alert({
        content: msg,
        confirmButton: '확인',
        confirmButtonClass: 'btn-primary',
        icon: 'fa fa-info',
        confirm: function () {
            parent.location.replace(url);
        },
        cancel: function () {
            parent.location.replace(url);
        }
    });
}

/* Alert Replace */
function commonAlertReplace(msg, url) {
    $.alert({
        content: msg,
        confirmButton: '확인',
        confirmButtonClass: 'btn-primary',
        icon: 'fa fa-info',
        confirm: function () {
            location.replace(url);
        },
        cancel: function () {
            location.replace(url);
        }
    });
}



/*Confirm Msg*/
function commonConfirm(msg, callback1, callback2) {
    $.confirm({
        content: msg,
        confirmButton: '확인',
        confirmButtonClass: 'btn-info',
        icon: 'fa fa-question-circle',
        //animation: 'fadeIn',
        confirm: function () {
            return callback1();
        },
        cancel: function () {
            return callback2();
        }
    });
}


/*Confirm Msg*/
function commonConfirm2(msg, callback1) {
    $.confirm({
        content: msg,
        confirmButton: '확인',
        confirmButtonClass: 'btn-info',
        icon: 'fa fa-question-circle',
        //animation: 'fadeIn',
        confirm: function () {
            return callback1();
        },
        cancel: function () {
            return;
        }
    });
}

/*Confirm Msg*/
function commonConfirm3(msg, callback1, param1) {
    $.confirm({
        content: msg,
        confirmButton: '확인',
        confirmButtonClass: 'btn-info',
        icon: 'fa fa-question-circle',
        //animation: 'fadeIn',
        confirm: function () {
            return callback1(param1);
        }
    });
}

/*Confirm Msg*/
function commonConfirm4(msg, url) {
    $.confirm({
        content: msg,
        confirmButton: '확인',
        confirmButtonClass: 'btn-info',
        icon: 'fa fa-question-circle',
        //animation: 'fadeIn',
        confirm: function () {
            location.href = url;
        },
        cancel: function () {
            return;
        }
    });
}

/*Confirm Msg*/
function commonConfirm5(msg, url, btnText1, btnText2) {
    $.confirm({
        content: msg,
        cancelButton: btnText1,
        confirmButton: btnText2,
        confirmButtonClass: 'btn-info',
        icon: 'fa fa-question-circle',
        //animation: 'fadeIn',
        confirm: function () {
            location.href = url;
        },
        cancel: function () {
            return;
        }
    });
}

/* Alert Focus */
function commonAlertFocus(msg, id) {
    $.alert({
        content: msg,
        confirmButton: '확인',
        confirmButtonClass: 'btn-primary',
        icon: 'fa fa-info',
        confirm: function () {
            $(id).focus();
        }
    });
}

/* This Focus */
function commonAlertThisFocus(msg, obj) {
    $.alert({
        content: msg,
        confirmButton: '확인',
        confirmButtonClass: 'btn-primary',
        icon: 'fa fa-info',
        confirm: function () {
            obj.focus();
        }
    });
}

// Product Layer resize
function resize_box() {
    var p_w = $(window).width();
    var p_h = $(window).height();
    var p_all = $('#product_order').height(); //all height		 
    var p_btn_h = $('#product_order .order_total').height();

    var is_h = (p_h / 2) + 27;
    $('#product_order .box_area').css({ 'max-height': is_h + 'px', 'margin-bottom': p_btn_h + 'px' });

}

// Scroll 
function scroll_out() {
    $('.dimlay').bind('touchmove', function (e) { e.preventDefault(); });
    $('body').bind('touchmove', function (e) { e.preventDefault(); });
    $('body').css('overflow-y', 'hidden');
}

function scroll_on() {
    $('.dimlay').unbind('touchmove');
    $('body').unbind('touchmove');
    $('body').css('overflow-y', 'auto');
}

// Dim 
function dim_out() {
    $('.orderbox').animate({ 'bottom': '-50px' }, 50).fadeOut(50);
    $('.slide_area').css('display', 'none');
    $('.dimlay').css({ 'display': 'none', 'z-index': '' });
    $('.btns_fix ul li a').addClass("btn2");
    $('.btns_fix ul li').removeClass('on');
    $('.btns_fix div >a').removeClass('on');
    $('.btns_fix a').find('span').removeClass('down');
    $('#menuList1').slideUp(100);
    $('#product_order').animate({ 'bottom': '-600px' }, 300);
    $('.layer_note').css('display', 'none');	  
    $('.btns_fix').animate({ 'bottom': '0' }, 120);
    $('#dvwrap').css({ 'height': 'auto', 'overflow': 'auto' });
    scroll_on();
}

function dim_on() {
    $('.slide_area').css('display', 'block');
    $('.orderbox').css({ 'display': 'none' });
    $('.dimlay').css('display', 'block');
		if($('.btn_top').hasClass('on')) { $('.btn_top').fadeOut(100); }		   
    scroll_out();
}

function Coaching(){
		$('#dvwrap').css({ 'height': '100%', 'overflow': 'hidden' });
		$('body').css({ 'overflow-y': 'hidden' })			
		//alert('a');
}

function leftMenuMove(this_menu){
	var this_cell = $(this_menu).parent();	
	if (this_cell.hasClass('on')) {
			if ($(this_menu).hasClass('tit')) {
					this_cell.find('ul').slideUp(100);
					this_cell.find('ul li').removeClass('on');
					this_cell.removeClass('on');
					this_cell.find('ul li a').removeClass('select');
					$(this_menu).removeClass('select');
			} else {
					this_cell.find(' > ul').slideUp(100);
					this_cell.removeClass('on');
					$(this_menu).removeClass('select');
			}
	} else {
			this_cell.addClass('on');
			$(this_menu).addClass('select')
			this_cell.find(' > ul').slideDown(100);
	}
	setTimeout(function () {
			MenuScroll01.refresh();
	}, 200);
}

// List resize
function resize_list() {
		var w = $(window).width();

		if (w > 415) {
				var list_w = $('.product_list li').width();

				var list_sum = $('.product_list  li').length;
				var list_count = Math.floor(w / list_w);
				var list_all_w = (list_w * list_count);

				if (list_sum < list_count) {
						list_all_w = (list_w * list_sum);
				}

				$('.product_list').css({ 'width': list_all_w + 'px', 'margin': '0 auto' });
		} else {
				$('.product_list').css({ 'width': 'auto' });
		}

}


//Iscroll	Name	
var MenuScroll01;
var MenuScroll02;
var MenuScroll03;
var SearchScroll01;
var SearchScroll02;
var MenuLink;
var OrderScorll;
var Button_FixScorll;
var scroll_count01 = 0;
var scroll_count02 = 0;
var scroll_count03 = 0;
var Button_FixScorll = [];
var Layer_PopScorll = [];

//var options = { scrollbars: true, mouseWheel: true, interactiveScrollbars: true, shrinkScrollbars: 'scale', fadeScrollbars: true, click: false };
var options = { mouseWheel: true, probeType: 1, scrollY: true, scrollX: false, scrollbars: true, fadeScrollbars: true};

if (IS_ANDROID_SUCKS) {
    options.click = false;
} else {
    options.click = true;
}

//Left Menu IScroll, All page
function MenuScroller() {
    if (scroll_count01 == 0) {
        MenuScroll01 = new IScroll('#leftMenu1', options);
        MenuScroll02 = new IScroll('#leftMenu2', options);
        MenuScroll03 = new IScroll('#leftMenu3', options);
        MenuLink = new IScroll('.leftLink', options);
        scroll_count01++;
    }
};

//Search IScroll, All page
function SearchScroller() {
    if (scroll_count02 == 0) {
        SearchScroll01 = new IScroll('#search1', options);
        SearchScroll02 = new IScroll('#search2', options);
        scroll_count02++;
    }
};

//Search IScroll, All page
function OrderScorller() {
    if (scroll_count03 == 0) {
        OrderScorll = new IScroll('#product_order .box_area', options);
        scroll_count03++;
    }
};

//Search IScroll, All page
function Button_FixScorller(n) {
    if (n > -1) {
        for (i = 0; i < n; i++) {
            Button_FixScorll[i] = new IScroll('.opt_scroll' + i, options);
        }
    } else {
        for (i = 0; i < n; i++) {
            Button_FixScorll[i].refresh();
        }
    }
};

//Search IScroll, All page
/*function Layer_PopScorller(n){	
    for(i=0;i<n;i++){
        Layer_PopScorll[i]= new IScroll('.layer_scroll'+i, {scrollbars: true,	mouseWheel: true,interactiveScrollbars: true, shrinkScrollbars: 'scale',fadeScrollbars: true,	click: true, scrollX: true,	scrollY: true});	
    }
};*/







