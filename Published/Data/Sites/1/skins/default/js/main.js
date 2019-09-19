(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
'use strict';
$(document).ready(function () {
    $(document).on("click", ".like-news", function (e) {
        e.preventDefault();
        var newsID = $(this).attr("data-newsID");
        var data = { 'method': 'UpdateLike', 'newsID': newsID };
        $(this).addClass('liked');
        $.ajax({
            type: "POST",
            url: "/News/Services/NewsService.aspx",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {},
            failure: function (errMsg) {}
        });
    });

    $(document).on("click", ".share-social", function () {
        var newsID = $(this).attr("data-newsID");
        var data = { 'method': 'UpdateShare', 'newsID': newsID };
        $.ajax({
            type: "POST",
            url: "/News/Services/NewsService.aspx",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {},
            failure: function (errMsg) {}
        });
    });

    $(".btn-showsub").detach().appendTo('.menulink li:nth-child(3)');
    $(".mega").detach().appendTo('.menulink li:nth-child(3)');
});

$(document).ready(function () {
	var width = $(window).width();
	if (width > 991) var width = $(window).width();
	if (width > 991) $('.user-sidebar').scrollToFixed({
		marginTop: $('header .mainmenu').outerHeight() + 0,
		limit: function limit() {
			return $('footer').offset().top - $('.user-sidebar').outerHeight() - 40;
		},
		zIndex: 99
	});

	$(window).resize(function () {
		var width = $(window).width();
		if (width > 991) $('.user-sidebar').scrollToFixed({
			marginTop: $('header .mainmenu').outerHeight() + 0,
			limit: function limit() {
				return $('footer').offset().top - $('.user-sidebar').outerHeight() - 40;
			},
			zIndex: 99
		});
	});

	$('.sub > li').mouseover(function () {
		$('.sub > li.first').removeClass('active');
	});

	$('.child > ul > li').mouseover(function () {
		$('.child > ul > li:first').removeClass('active');
	});

	$('.mega').mouseleave(function () {
		$('.sub > li.first').addClass('active');
		$('.child > ul > li:first').addClass('active');
	});

	$('.overlay').click(function () {
		$('.mainmenu').removeClass('open');
		$('.overlay').fadeOut(300);
		$('.search').removeClass('open');
	});

	$('.btn-showmega').click(function () {
		$(this).siblings('.mega').slideToggle(300);
		$(this).toggleClass('active');
	});

	$('.btn-showmenu').click(function () {
		$('.mainmenu').toggleClass('open');
		$('.overlay').fadeIn(500);
		$('.search').removeClass('open');
		// $('html').css('overflow', 'hidden');
	});
	$('.overlay').click(function () {
		$(this).fadeOut(500);
		$('.menu').removeClass('open');
		// $('html').css('overflow', 'auto');
	});
	$('.btn-showsub').click(function () {
		$(this).siblings('.mega').children('.sub').addClass('open');
	});
	$('.btn-showchild').click(function () {
		$(this).siblings('.child').slideToggle(300);
		$(this).toggleClass('active ');
	});
	$('.titlewrap').click(function () {
		$(this).parent('.sub').removeClass('open');
	});

	$('.userinfo').click(function () {
		$('.user-sidelink').slideToggle(300);
	});

	new WOW().init();

	// $('.topbar').scrollToFixed({
	//     marginTop: 129,
	//     zIndex: 50
	// });


	$('[data-toggle="tooltip"]').tooltip();

	$('.btn-comment').click(function (e) {
		e.preventDefault();
		$('html,body').animate({
			scrollTop: $(this.hash).offset().top - 150
		}, 700);
		// $('.nav-tabs li').removeClass('active');
		// $(this).parent('li').addClass('active');
		return false;
	});
	$(window).bind('scroll', function () {
		if ($(window).scrollTop() > 50) {
			$('header').addClass('minimal');
		} else {
			$('header').removeClass('minimal');
		}

		if ($(window).scrollTop() > 400) {
			$('.like-share').addClass('open');
		} else {
			$('.like-share').removeClass('open');
		}
	});

	$(".counter").countimator({
		duration: 3000
	});

	$(".pagename").append($('.breadcrumb li a').eq(1).find('span').html());

	$('.searchtoggle').click(function () {
		$('.searchwrap').toggleClass('open');
	});

	$('#map').click(function () {
		$(this).find('iframe').addClass('active');
	}).mouseleave(function () {
		$(this).find('iframe').removeClass('active');
	});

	// FAQ SCRIPT
	$('.faqlist .faq').click(function () {
		$('.faqlist .faq .faqtitle').removeClass('active');
		$('.faqlist .faq .faqcontent').slideUp(300);
		$(this).children('.faqtitle').addClass('active');
		$(this).children('.faqcontent').slideDown(300);
	});

	// SLIDE 
	$('.result-list').slick({
		slidesToShow: 3,
		slidesToScroll: 1,
		arrows: true,
		dots: true,
		speed: 1000,
		responsive: [{
			breakpoint: 767,
			settings: {
				slidesToShow: 3
			}
		}, {
			breakpoint: 575,
			settings: {
				slidesToShow: 2
			}
		}]
	});

	$('.news-img-slide').slick({
		infinite: true

	});

	$('.author-img-slide').slick({
		infinite: true
	});

	$('.test-slide').slick();

	$('.about-slide').slick({
		asNavFor: '.about-nav',
		arrows: false
	});
	$('.about-nav').slick({
		asNavFor: '.about-slide',
		slidesToShow: 4,
		slidesToScroll: 1,
		focusOnSelect: true
	});

	$('.partner-slide').slick({
		slidesToShow: 4,
		slidesToScroll: 1,
		responsive: [{
			breakpoint: 997,
			settings: {
				slidesToShow: 3
			}
		}, {
			breakpoint: 767,
			settings: {
				slidesToShow: 2
			}
		}, {
			breakpoint: 543,
			settings: {
				slidesToShow: 1
			}
		}]
	});

	$('.parallax-window').parallax();
});

// REVOLUTION SLIDER
var tpj = jQuery;

var banner001;
tpj(document).ready(function () {
	if (tpj("#banner001").revolution == undefined) {
		revslider_showDoubleJqueryError("#banner001");
	} else {
		banner001 = tpj("#banner001").show().revolution({
			sliderType: "standard",
			sliderLayout: 'auto',
			dottedOverlay: "none",
			delay: 5000,
			navigation: {
				keyboardNavigation: "off",
				keyboard_direction: "horizontal",
				mouseScrollNavigation: "off",
				onHoverStop: "off",
				touch: {
					touchenabled: "on",
					swipe_threshold: 75,
					swipe_min_touches: 50,
					swipe_direction: "horizontal",
					drag_block_vertical: false
				},
				arrows: {
					enable: true,
					style: 'uranus',
					tmp: '',
					rtl: false,
					hide_onleave: true,
					hide_onmobile: true,
					hide_under: 0,
					hide_over: 9999,
					hide_delay: 300,
					hide_delay_mobile: 1200,
					left: {
						container: 'slider',
						h_align: 'left',
						v_align: 'center',
						h_offset: 20,
						v_offset: 0
					},

					right: {
						container: 'slider',
						h_align: 'right',
						v_align: 'center',
						h_offset: 20,
						v_offset: 0
					}
				},
				bullets: {
					enable: true,
					style: 'hermes',
					tmp: '',
					direction: 'horizontal',
					rtl: false,

					container: 'slider',
					h_align: 'center',
					v_align: 'bottom',
					h_offset: 0,
					v_offset: 20,
					space: 10,

					hide_onleave: false,
					hide_onmobile: false,
					hide_under: 0,
					hide_over: 9999,
					hide_delay: 200,
					hide_delay_mobile: 1200

				}
			},
			responsiveLevels: [1024, 991, 767, 543],
			visibilityLevels: [1024, 991, 767, 543],
			gridwidth: [1440, 1199, 991, 543],
			gridheight: [600, 500, 450, 400],
			lazyType: "none",
			// parallax: {
			//     type: "scroll",
			//     origo: "slidercenter",
			//     speed: 50,
			//     levels: [5000]
			// },
			shadow: 0,
			spinner: "off",
			stopLoop: "off",
			shuffle: "off",
			autoHeight: "off",
			fullScreenAutoWidth: "off",
			fullScreenAlignForce: "off",
			fullScreenOffsetContainer: "",
			fullScreenOffset: "",
			disableProgressBar: "on",
			hideThumbsOnMobile: "off",
			hideSliderAtLimit: 0,
			hideCaptionAtLimit: 0,
			hideAllCaptionAtLilmit: 0,
			debugMode: false,
			fallbacks: {
				simplifyAll: "off",
				nextSlideOnWindowFocus: "off",
				disableFocusListener: false
			}
		});
	}
});

},{}]},{},[1])

//# sourceMappingURL=main.js.map
