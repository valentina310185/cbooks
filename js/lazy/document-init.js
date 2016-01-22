$(document).ready(function () {
    init_document();
    HidePrintOptionsOnTabletAndMobile();
});

function HidePrintOptionsOnTabletAndMobile() {
    if(!device.desktop())
        $(".no-print").hide();
}

(function () {
  'use strict';
  if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
    var msViewportStyle = document.createElement('style')
    msViewportStyle.appendChild(
      document.createTextNode(
        '@-ms-viewport{width:auto!important}'
      )
    )
    document.querySelector('head').appendChild(msViewportStyle)
  }
})();

$(document).ready(function () {
    if(!device.desktop()) {
        $(document).on('focus', 'textarea,input,select', function(e) {
            $('.navbar.navbar-fixed-top').css('position', 'absolute');
        }).on('blur', 'textarea,input,select', function(e) {
            $('.navbar.navbar-fixed-top').css('position', '');
        })
    }
});

function init_document() {
    $('input[maxlength], textarea[maxlength]').maxlength({ alwaysShow: true });
    var $ta = $('textarea');
    $ta.autosize();
    document.body.offsetWidth;
    $ta.addClass('textarea-transition');
    $('[id=date-container] input').datepicker({
        todayBtn: "linked",
        autoclose: true
    });
    $('[id=daterange-container] .input-daterange').datepicker({
        todayBtn: "linked",
        autoclose: true
    });
}