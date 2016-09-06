jQuery(function($){
	
	//我的易购
	$('li.egolm').hover(function(){
		var idx = $(this).index();
		$(this).parents('ul:first').children('li').eq(idx-1).find('a').css({'line-height':'30px'});
	},function(){
		var idx = $(this).index();
		$(this).parents('ul:first').children('li').eq(idx-1).find('a').css({'line-height':'1.3'});
	});
	
	//关注易购
	$('.follow').hover(function(){
		var idx = $(this).index();
		$(this).parents('ul:first').children('li').eq(idx-1).find('a').css({'line-height':'30px'});
	},function(){
		var idx = $(this).index();
		$(this).parents('ul:first').children('li').eq(idx-1).find('a').css({'line-height':'1.3'});
	});
	
	//三级菜单
	$('.header-nav .sort>ul>li').hover(function(){
		$(this).addClass('active').find('.sort-content').show();
	},function(){
		$(this).removeClass('active').find('.sort-content').hide();
	});
	
	//登录提示
	$('.cart-wrap .cart').on('click',function(e){
		e.stopPropagation();
		$(this).toggleClass('click');
	});
	$('.login-tips').on('click',function(e){
		e.stopPropagation();
	});
	$(document).on('click',function(){
		$('.cart-wrap .cart').removeClass('click')
	});
	
	
	//banner
	var pageWidth = 1210, //主页面宽度
		noticePosition = ($(window).width()-pageWidth)/2 > 0 ? ($(window).width()-pageWidth)/2 : 0,
		nextPosition = noticePosition + 248,
		prevPosition = noticePosition + 1010 - 28;
	
	$('.notice').css({'right':noticePosition+'px','display':'block'});
	$('.next').css({'right':nextPosition+'px'});
	$('.prev').css({'right':prevPosition+'px'});
	
	$(window).resize(function(){ //监听尺寸变化
		noticePosition = ($(window).width()-pageWidth)/2 > 0 ? ($(window).width()-pageWidth)/2 : 0;
		nextPosition = noticePosition + 248,
		prevPosition = noticePosition + 1010 - 28;
		$('.notice').css({'right':noticePosition+'px','display':'block'});
		$('.next').css({'right':nextPosition+'px'});
		$('.prev').css({'right':prevPosition+'px'});
	});
	
	
	$(document).scroll(function(){ //监听滚动条
		scrollHeight = $(this).scrollTop();
		if( scrollHeight > 0 ){
			$('.header').addClass('scroll');
			if($('.header .search-wrap .logo a img').attr('src').indexOf('logo.png') > -1){
				$('.header .search-wrap .logo a img').attr('src','assets/images/logo-s.png')
			}
		}else{
			$('.header').removeClass('scroll').find('.search-wrap .logo a img').attr('src','assets/images/logo.png');
		}
			
	});
	
});