;$(document).ready(function () {
    "use strict";

    $('#header').scrollToFixed();
    $('.titlepage').scrollToFixed({ marginTop: 50 });

    $('.dropdown').hover(function () {
        $(this).toggleClass('open');
    });


    $('.result').click(function() {
        $(this).select();
    });

    $('.callanimated').click(function() {
        var anim = $('.selectanimated').val();
        testAnim(anim);
    });

    $('.selectanimated').change(function() {
        var anim = $(this).val();
        testAnim(anim);
    });

    // ToggleMenu
    $("#menu-toggle").click(function (e) {
        e.preventDefault();
        if ($("#wrapper").hasClass('toggled')) {
            ShowMenuToolbar();
            Set_Cookie('menuOpenState', 'open');
        }
        else {
            HideMenuToolbar();
            Set_Cookie('menuOpenState', 'closed');
        }
    });

    //Accordion Arrow//////////////////////////////////////////////////////////////
    $(".panel-group .panel-title a").click(function () {
        $(this).children(".fa-chevron-circle-down").toggleClass('fa-rotate-180');
        $(this).children('#name').toggleClass('show');
    });

    $("#setposet li a").click(function (e) {
        e.preventDefault();
        $(this).parents('ul').find('li').removeClass();
        $(this).parent().toggleClass("active");
        var setposet = $(this).attr('data-poset');
        if (setposet !== "") {
            $(".adminpanel").removeClass().addClass('adminpanel ' + setposet);
            $(".cmsadminpanel").removeClass().addClass('cmsadminpanel ' + setposet);
        }
    });
});

/*==========================================================================================================================================================================================
=WINDOWS LOAD===============================================================================================================================================================================
===========================================================================================================================================================================================*/
$(window).load(function () {
    "use strict";
});

/*==========================================================================================================================================================================================
=WINDOWS RESIZE===============================================================================================================================================================================
===========================================================================================================================================================================================*/
$(window).resize(function () {
    "use strict";
});
/*==========================================================================================================================================================================================
=FUNCTIONS==================================================================================================================================================================================
===========================================================================================================================================================================================*/
$(function () {
    $('html').scrollUp({
        scrollName: 'scrollUp-text', // Element ID
        topDistance: '300', // Distance from top before showing element (px)
        topSpeed: 300, // Speed back to top (ms)
        animation: 'fade', // Fade, slide, none
        animationInSpeed: 200, // Animation in speed (ms)
        animationOutSpeed: 200, // Animation out speed (ms)
        scrollText: '<i class="fa fa-angle-double-up"></i>', // Text for element
        activeOverlay: false // Set CSS color to display scrollUp active point, e.g '#00FFFF'
    });
    //Tab Responsive
    fakewaffle.responsiveTabs(['xs', 'sm']);
});

function testAnim(x) {
    $('.result').val(x);
    $('#timing, #timing2').removeClass().addClass(x + ' animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
        $(this).removeClass();
    });
};

function HideMenuToolbar() { $("#wrapper").addClass("toggled"); $('#menu-toggle i').addClass('active'); }
function ShowMenuToolbar() { $("#wrapper").removeClass("toggled"); $('#menu-toggle i').removeClass('active'); }
var menuOpenState = Get_Cookie('menuOpenState');
if (menuOpenState != null) { if (menuOpenState == 'closed') { HideMenuToolbar(); } if (menuOpenState == 'open') { ShowMenuToolbar(); } }