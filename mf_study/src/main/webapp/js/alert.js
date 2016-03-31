// ----------------------------------------------
// alert
// ----------------------------------------------

/*function errorAlert(message)
{
	$("#errorMsg").html(message);
	$.mobile.changePage($("#errorAlert"),{transition:"pop",role:"dialog"});
	return;
}*/

function confirmDialog(text, callback) {
    var popupDialogId = 'popupDialog';
    $('<div data-role="popup" id="' + popupDialogId + '" data-confirmed="no" data-transition="pop" data-overlay-theme="b" data-theme="b" data-dismissible="false" class="alertPop"> \
                        <div class="tit">\
                            <strong>title</strong>\
                        </div>\
                        <div class="con">\
                            <p class="txt">' + text + '</p>\
							<div class="btnDiv ui-grid-a">\
								<div class="ui-block-a"><a href="#" class="btn blue pop" data-rel="back"><span>Yes</span></a></div>\
								<div class="ui-block-b"><a href="#" class="btn white pop" data-rel="back" data-transition="flow"><span>No</span></a></div>\
							</div>\
                        </div>\
                    </div>')
        .appendTo($.mobile.pageContainer);
    var popupDialogObj = $('#' + popupDialogId);
    popupDialogObj.trigger('create');
    popupDialogObj.popup({
        afterclose: function (event, ui) {
            popupDialogObj.find(".optionConfirm").first().off('click');
            var isConfirmed = popupDialogObj.attr('data-confirmed') === 'yes' ? true : false;
            $(event.target).remove();
            if (isConfirmed && callback) {
                callback();
            }
        }
    });
    popupDialogObj.popup('open');
    popupDialogObj.find(".optionConfirm").first().on('click', function () {
        popupDialogObj.attr('data-confirmed', 'yes');
    });
}