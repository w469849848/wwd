$(function(){
	
	//首页加载图片资源
	Insect.util.imgScrollRequest('.index .lazy');
	
	$(window).scroll(function(){
		
		//懒加载
		Insect.util.imgScrollRequest('.index .lazy');
		Insect.util.imgScrollRequest('.search .lazy');
		Insect.util.imgScrollRequest('.hot-brand .lazy');
		Insect.util.imgScrollRequest('.sort .lazy');
		Insect.util.imgScrollRequest('.supplier .lazy');
		Insect.util.imgScrollRequest('.bargain-goods .lazy');
		Insect.util.imgScrollRequest('.brand-list .lazy');
		Insect.util.imgScrollRequest('.quick-order .lazy');
		Insect.util.imgScrollRequest('.activity .lazy');
		Insect.util.imgScrollRequest('.back-order .lazy');
		Insect.util.imgScrollRequest('.cart-wrap .lazy');
		Insect.util.imgScrollRequest('.detail-wrap .lazy');
		Insect.util.imgScrollRequest('.sp-snack .lazy');
		Insect.util.imgScrollRequest('.sp-oils .lazy');
		Insect.util.imgScrollRequest('.sp-fullsend .lazy');
		Insect.util.imgScrollRequest('.sp-fullsubtract .lazy');
		Insect.util.imgScrollRequest('.sp-fulldiscount .lazy');
		Insect.util.imgScrollRequest('.sp-living .lazy');
		Insect.util.imgScrollRequest('.sp-fast .lazy');
		Insect.util.imgScrollRequest('.sp-wash .lazy');
		Insect.util.imgScrollRequest('.sp-xzl .lazy');
		Insect.util.imgScrollRequest('.sp-moldbaby .lazy');
		Insect.util.imgScrollRequest('.sp-group .lazy');
		Insect.util.imgScrollRequest('.sp-drink .lazy');
		Insect.util.imgScrollRequest('.my-collect .lazy');
		Insect.util.imgScrollRequest('.browsing-history .lazy');
		
		//城市定位字母导航滚动
		if($('.location').attr('class').indexOf('curPage') > -1){
			if($(window).scrollTop() <= 10){
				$('.location .nav-city').hide();
			}else{
				$('.location .nav-city').show();
				if (window.addEventListener&&($('.location .nav-city').data('one'))) {
			        $('.location .nav-city').data('one',false);
				    jackyScroll(document.querySelector(".location .nav-city"),{//消息内容滚动设置
						verticalScroll: true,          // 默认垂直滚动
						horizontalScroll: false,       // 水平滚动，默认false，不水平滚动
						hideScrollBar: true,          // 是否隐藏滚动条
						onScroll: function() {}        // 滚动时候的回调
					});
				}
			}
		}
		
		//热门品牌字母导航滚动
		if($('.hot-brand').attr('class').indexOf('curPage') > -1){
			if($(window).scrollTop() <= 10){
				$('.hot-brand .nav-brand').hide();
			}else{
				$('.hot-brand .nav-brand').show();
				if (window.addEventListener&&($('.hot-brand .nav-brand').data('one'))) {
			        $('.hot-brand .nav-brand').data('one',false);
				    jackyScroll(document.querySelector(".hot-brand .nav-brand"),{//消息内容滚动设置
						verticalScroll: true,          // 默认垂直滚动
						horizontalScroll: false,       // 水平滚动，默认false，不水平滚动
						hideScrollBar: true,          // 是否隐藏滚动条
						onScroll: function() {}        // 滚动时候的回调
					});
				}
			}
		}
		
		//供应商字母导航滚动
		if($('.supplier').attr('class').indexOf('curPage') > -1){
			if($(window).scrollTop() <= 10){
				$('.supplier .nav-supplier').hide();
			}else{
				$('.supplier .nav-supplier').show();
				if (window.addEventListener&&($('.supplier .nav-supplier').data('one'))) {
			        $('.supplier .nav-supplier').data('one',false);
				    jackyScroll(document.querySelector(".supplier .nav-supplier"),{//消息内容滚动设置
						verticalScroll: true,          // 默认垂直滚动
						horizontalScroll: false,       // 水平滚动，默认false，不水平滚动
						hideScrollBar: true,          // 是否隐藏滚动条
						onScroll: function() {}        // 滚动时候的回调
					});
				}
			}
		}
	});
	
	//banner轮播初始化
	Zepto(function($){
		
		var $indicator = $('#indicator li');
		window.bannerSlide = new mo.Slide({
			autoPlay: true,
			target: $('#slide li'),
			effect: 'slide',
			direction: 'x',
			circle: true,
			stay: 6000,
			event: {
				'beforechange':function(){
					$indicator.removeClass('active').eq(this.curPage).addClass('active');
				}
			}
		});
	});
	
	//品牌轮播初始化
	Zepto(function($){
		
		window.brandSlide = new mo.Slide({
			autoPlay: true,
			target: $('.brand > ul > li'),
			effect: 'slide',
			direction: 'x',
			circle: true,
			stay: 10000,
			event: {
				'beforechange':function(){}
			}
		});
	});
	
	//防止点击穿透
	var setPointer = function(el){
		$(el).css('pointer-events', 'none');

	    setTimeout(function(){
	        $(el).css('pointer-events', 'auto');
	    }, 400);
	}
	
	//首页签到关闭
	$('.index-wrap .sign-alert .mask,.index-wrap .sign-alert .btn-close').on('tap',function(){
		$('.index-wrap .sign-alert').fadeOut();
	});
	
	//模拟签到
	$('.index-wrap .sign-alert .btn-sign').on('tap',function(){
		$(this).addClass('active');
		$('.index-wrap .sign-alert').fadeOut();
		$('.index-wrap .join-alert').fadeIn();
	});
	
	//参加活动关闭
	$('.index-wrap .join-alert .mask,.index-wrap .join-alert .btn-close').on('tap',function(){
		$('.index-wrap .join-alert').fadeOut();
	});
	
	//参加活动
	$('.index-wrap .join-alert .btn-join').on('tap',function(){
		$('.index-wrap .join-alert').fadeOut();
		$('.activity-wrap').removeClass('hide').siblings().addClass('hide');
		$('.footer .btn-activity').addClass('active').siblings().removeClass('active');
		Insect.util.imgScrollRequest('.activity .lazy');
	});
	
	
	/**
	 * @ 购买数量加减效果
	 */
	
	//减
	$('.ipt-num .sub').on('tap',function(){
		
		var $input = $(this).parents('.ipt-num').find('input'),
			currentVal = parseInt($input.val());
		if(currentVal >= 1){
			$input.val(currentVal-1);
		}
	});
	
	//加
	$('.ipt-num .add').on('tap',function(){
		
		var $input = $(this).parents('.ipt-num').find('input'),
			currentVal = parseInt($input.val());
		$input.val(currentVal + 1);
	});
	
	//输入不能为负数
	$('.ipt-num input').on('change',function(){
		
		var $this = $(this),
			currentVal = parseInt($this.val());
		if(currentVal <= 0 || isNaN(currentVal)){
			$this.val(1);
		}else{
			$this.val(currentVal);
		}
		
	});
	
	//首页加入购物车效果
	$('.index .add-cart').on('tap',function(){
		Animate.addCartIndex(this,'#target');
	});
	
	
	var anchorScroll = function(parentElem,elem){ //锚点定位
		var $this = $(elem),
			$parent = $(parentElem),
			thisData = $this.data('anchor'),
			offsetTop = thisData && $parent.find('.tit-' + thisData).offset() ? $parent.find('.tit-' + thisData).offset().top : 0,
			headerHeight = $parent.find('.header').height();

		if(offsetTop > 0){
			$(window).scrollTop(offsetTop - headerHeight);
		}
	}
	
	var nextPage = function(tagPage,parentElem){ //页面切换函数
		var $curPage = $(parentElem + ' .curPage'),
			$tagPage = $(tagPage),
			$curHeader = $curPage.find('.header'),
			$tagHeader = $tagPage.find('.header');
			
		$('.wrap > .footer').addClass('hide');
		
		if($curHeader.length >= 0){ $curHeader.css({'position':'absolute'}); }
		if($tagHeader.length >= 0){ $tagHeader.css({'position':'absolute'}); }
		
		$curPage.animate({'left':'-100%'},300,function(){
			$curPage.addClass('hide');
		});
		
		$tagPage.css({'left':'100%'}).addClass('curPage').removeClass('hide').animate({'left':'0'},300,function(){
			if($tagHeader.length >= 0){ $tagHeader.css({'position':'fixed'}); }
		}).siblings().removeClass('curPage');
			
		$(window).scrollTop(0);
	}
	
	var backPage = function(tagPage,parentElem){ //返回上一页函数
		var $curPage = $(parentElem + ' .curPage'),
			$tagPage = $(tagPage),
			$curHeader = $curPage.find('.header'),
			$tagHeader = $tagPage.find('.header');
		
		$('.wrap > .footer').removeClass('hide');
		$('#cart-tips').hide();
			
		if($curHeader.length >= 0){ $curHeader.css({'position':'absolute'}); }
		if($tagHeader.length >= 0){ $tagHeader.css({'position':'absolute'}); }
		
		$curPage.animate({'left':'100%'},300,function(){
			$curPage.addClass('hide');
		});
		
		$tagPage.addClass('curPage').removeClass('hide').animate({'left':'0'},300,function(){
			if($tagHeader.length >= 0){ $tagHeader.css({'position':'fixed'}); }
		}).siblings().removeClass('curPage');
		
		$(window).scrollTop(0);
	}
	
		
	
	/*
	 * @底部菜单切换
	 */
	
	$('.wrap > .footer ul li').on('tap',function(){
		var $this = $(this),
			thisClass = $this.attr('class'),
			data = $this.data('tag') || '';
		
		if(data == 'scan'){ return false; }
		$this.addClass('active').siblings().removeClass('active');
		$(window).scrollTop(0);
		
		switch(true){
			case data == 'index' :
				$('.index-wrap').removeClass('hide').siblings().addClass('hide');
				Insect.util.imgScrollRequest('.index .lazy');
				break;
				
			case data == 'sort' :
				$('.sort-wrap').removeClass('hide').siblings().addClass('hide');
				Insect.util.imgScrollRequest('.sort .lazy');
				if (window.addEventListener&&($('.sort-nav').data('one'))) {
			        $('.sort-nav').data('one',false);
				    jackyScroll(document.querySelector(".sort-nav .nav-wrap"),{//消息内容滚动设置
						verticalScroll: true,          // 默认垂直滚动
						horizontalScroll: false,       // 水平滚动，默认false，不水平滚动
						hideScrollBar: true,          // 是否隐藏滚动条
						onScroll: function() {}        // 滚动时候的回调
					});
				}
				break;
				
			case data == 'cart' :
				$('.cart-wrap').removeClass('hide').siblings().addClass('hide');
				Insect.util.imgScrollRequest('.cart .lazy');
				break;
			
			case data == 'personal' :
				$('.personal-wrap').removeClass('hide').siblings().addClass('hide');
				Insect.util.imgScrollRequest('.personal-wrap .lazy');
				break;
			
				//default
		}
	});
	
	
	/*
	 * @城市定位
	 */
	
	$('.index .btn-location').on('tap',function(){ //城市定位
		nextPage('.index-wrap > .location','.index-wrap');
	});
	
	$('.location .search-header .btn-back').on('tap',function(){ //城市定位页返回
		backPage('.index-wrap > .index','.index-wrap');
	});
	
	$('.location .nav-city ul li').on('tap',function(){ //锚点定位
		anchorScroll('.location',this);
	});
	
	//模拟选择城市
	$('.hot-city ul li,.city-list ul li').on('tap',function(){
		backPage('.index-wrap > .index','.index-wrap');
	});
	
	/*
	 * @热门品牌页
	 */
	
	$('.entrance .btn-brand').on('tap',function(){ //热门品牌页
		nextPage('.index-wrap > .hot-brand','.index-wrap');
		Insect.util.imgScrollRequest('.hot-brand .lazy');
	});
	
	$('.hot-brand .search-header .btn-back').on('tap',function(){ //热门品牌页返回
		backPage('.index-wrap > .index','.index-wrap');
	});
	
	$('.brand-wrap .nav-brand ul li').on('tap',function(){ //锚点定位
		anchorScroll('.hot-brand',this);
	});
	
	/*
	 * @快速下单
	 */
	
	$('.entrance .btn-quick').on('tap',function(){ //快速下单页
		nextPage('.index-wrap > .quick-order','.index-wrap');
		Insect.util.imgScrollRequest('.quick-order .lazy');
	});
	
	$('.quick-order .quick-order-header .btn-back').on('tap',function(){ //快速下单页返回
		backPage('.index-wrap > .index','.index-wrap');
	});
	
	$('.quick-order .h-filter ul li').on('tap',function(){ //筛选
		var $this = $(this);
		$(this).toggleClass('active');
		$this.find('.price-filter i').removeClass('hide-im');
	});
	
	$('.quick-order .btn-order').on('tap',function(){ //一键加入购物车
		Insect.util.alertBox('<i class="icon-add"></i>成功加入购物车！');
	});
	
	
	/*
	 * @品牌商品页
	 */
	
	$('.brand .g-b li').on('click',function(){ //品牌商品页--推荐品牌点击
		nextPage('.index-wrap > .brand-list','.index-wrap');
		Insect.util.imgScrollRequest('.brand-list .lazy');
	});
	
	$('.tit a.more').on('tap',function(){ //品牌商品页--more点击
		nextPage('.index-wrap > .brand-list','.index-wrap');
		Insect.util.imgScrollRequest('.brand-list .lazy');
	});
	
	$('.brand-list .brand-list-header .btn-back').on('tap',function(){ //热门品牌页返回
		$('.brand-list .brand-list-header .h-filter .btn-filter').removeClass('active');
		$('.brand-list .filter-box').addClass('hide');
		$('.brand-list .search-result').removeClass('hide');
		$('.brand-list').css({'background':'#eee'});
		backPage('.index-wrap > .index','.index-wrap');
	});
	
	$('.brand-list .brand-list-header .h-filter ul li').on('tap',function(){ //顶部筛选点击效果
		var $this = $(this),
			classStr = $this.attr('class') || '';
		
		$this.toggleClass('active').siblings().removeClass('active');
		$this.find('.price-filter i').removeClass('hide-im')
		classStr = $this.attr('class') || ''
		
		if(classStr.indexOf('btn-filter') > -1 && classStr.indexOf('active') > -1){
			$('.brand-list .filter-box').removeClass('hide');
			$('.brand-list .search-result').addClass('hide');
			$('.brand-list').css({'background':'#fff'});
		}else{
			$('.brand-list .filter-box').addClass('hide');
			$('.brand-list .search-result').removeClass('hide');
			$('.brand-list').css({'background':'#eee'});
		}
	});
	
	$('.brand-list .filter-box .btn-submit input').on('tap',function(){ //确定筛选条件
		$('.brand-list .filter-box').addClass('hide');
		$('.brand-list .search-result').removeClass('hide');
		$('.brand-list').css({'background':'#eee'});
		$('.brand-list .brand-list-header .h-filter .btn-filter').removeClass('active');
	});
	
	//品牌商品页加入购物车效果
	$('.brand-list .add-cart').on('tap',function(){
		Animate.addCart(this);
	});
	
	/*
	 * @分类页
	 */
	
	$('.sort .nav-wrap ul li').on('tap',function(){ //切换分类
		var $this = $(this),
			thisIndex = $this.index() + 1;

		$this.addClass('active').siblings().removeClass('active');
		$('.s'+ thisIndex).removeClass('hide').siblings('.goods-list').addClass('hide');
		Insect.util.imgScrollRequest('.sort .lazy');
	});
	
	$('.sort .filter .all').on('tap',function(){ //全部分类下拉
		var $this = $(this);
		$this.toggleClass('active');
		$('.sort .filter .com').removeClass('active');
	});
	
	$('.sort .filter .com').on('tap',function(){ //综合排序下拉
		var $this = $(this);
		$this.toggleClass('active');
		$('.sort .filter .all').removeClass('active');
	});
	
	//停止冒泡
	$('.sort .filter .com .com-box,.sort .filter .all .all-box').on('tap',function(e){
		e.stopPropagation();
	});
	
	$('.sort .add-cart').on('tap',function(){ //分类页加入购物车
		var animateWrap = $(this).parents('.buy-wrap')[0];
		$(this).addClass('hide-im').siblings('label').removeClass('hide-im').find('input').val(1);
		Animate.addCartIndex(animateWrap,'#target');
	});
	
	$('.sort .goods-list .ipt-num .add').on('tap',function(){ //购物车数量增加
		var animateWrap = $(this).parents('.buy-wrap')[0];
		Animate.addCartIndex(animateWrap,'#target');
	});
	
	$('.sort .goods-list .ipt-num .sub').on('tap',function(){ //购物车数量减少
		var $input = $(this).siblings('input'),
			num = parseInt($('#target span.num').text());
			
		$('#target .num').text(num-1);
		if($input.val() <= 0){
			$($(this).parents('.ipt-num')[0]).addClass('hide-im').siblings('.add-cart').removeClass('hide-im');
		}
	});
	
	
	/*
	 * @搜索页
	 */
	
	$('.index .header .btn-search').on('tap',function(){ //搜索页
		nextPage('.index-wrap > .search','.index-wrap');
	});
	
	$('.search .search-header .btn-back').on('tap',function(){ //搜索页返回
		backPage('.index-wrap > .index','.index-wrap');
		$('.search .hot-wrap').removeClass('hide');
		$('.search .search-result').addClass('hide');
		$('.search').css({'padding-top': '3.15rem','background':'#fff'});
		$('.search .h-filter').addClass('hide');
		$('.search .search-header .h-filter .btn-filter').removeClass('active');
		$('.search .filter-box').addClass('hide');
	});
	
	//模拟搜索流程
	var isHas = true;//是否有商品
	$('.search .search-header .btn-wrap').on('tap',function(){
		$('.search').css({'padding-top': '6.357rem','background':'#eee'});
		$('.search .hot-wrap').addClass('hide');
		$('.search .search-result').removeClass('hide');
		$('.search .h-filter').removeClass('hide');
		if(isHas){
			Insect.util.imgScrollRequest('.search .lazy');
		}else{
			$('.search .search-result .no-goods-wrap').removeClass('hide');
			$('.search .search-result .goods-wrap').addClass('hide');
		}
	});
	
	$('.search .search-header .h-filter ul li').on('tap',function(){ //顶部筛选点击效果
		var $this = $(this),
			classStr = $this.attr('class') || '';
		
		$this.toggleClass('active').siblings().removeClass('active');
		$this.find('.price-filter i').removeClass('hide-im');
		classStr = $this.attr('class') || ''
		
		if(classStr.indexOf('btn-filter') > -1 && classStr.indexOf('active') > -1){
			$('.search .filter-box').removeClass('hide');
			$('.search .search-result').addClass('hide');
			$('.search').css({'background':'#fff'});
		}else{
			$('.search .filter-box').addClass('hide');
			$('.search .search-result').removeClass('hide');
			$('.search').css({'background':'#eee'});
		}
	});
	
	$('.search .filter-box .btn-submit input').on('tap',function(){ //确定筛选条件
		$('.search .filter-box').addClass('hide');
		$('.search .search-result').removeClass('hide');
		$('.search').css({'background':'#eee'});
		$('.search .search-header .h-filter .btn-filter').removeClass('active');
	});
	
	//搜索页加入购物车效果
	$('.search .add-cart').on('tap',function(){
		Animate.addCart(this);
	});
	
	
	/*
	 * @扫码补货模拟
	 */
	$('.index-wrap .header .scan').on('tap',function(){ //点击扫码按钮
		$('.back-order-wrap').removeClass('hide');
		$('.index-wrap').addClass('hide');
		$('.wrap > .footer').addClass('hide');
	});
	
	$('.back-order-wrap .back-order-header .btn-back').on('tap',function(){ //返回
		$('.back-order-wrap').addClass('hide');
		$('.index-wrap').removeClass('hide');
		$('.wrap > .footer').removeClass('hide');
	});
	
	$('.back-order-wrap .btn-order').on('tap',function(){ //一键加入购物车
		Insect.util.alertBox('<i class="icon-add"></i>成功加入购物车！');
	});
	
	/*
	 * @购物车
	 */
	
	var checkedAll = function(elem){ //部分全选函数
		var $this = $(elem),
			check = $this.prop('checked'),
			$parent = $($this.parents('.log-item')[0]);
		
		if(check){
			$parent.addClass('isChecked');
			$parent.find('.goods-list>ul>li').addClass('isChecked');
		}else{
			$parent.removeClass('isChecked');
			$parent.find('.goods-list>ul>li').removeClass('isChecked');
		}
		$parent.find('.goods-list .checkbox-wrap input').prop('checked',check);
	}
	
	$('.cart-wrap .log-wrap input').on('change',function(e){ //部分全选
		checkedAll(this);
	});
	
	$('.cart-wrap .goods-list input.chk').on('change',function(){ //个别选中
		var $this = $(this),
			$parent = $($this.parents('li')[0]),
			check = $this.prop('checked'),
			$logItem = $($this.parents('.log-item')[0]);
			
		if(check){
			var isAll = false;
			$parent.addClass('isChecked');
			$parent.siblings().find('input.chk').each(function(){
				isAll = $(this).prop('checked');
				if(!isAll){ return }
			});
			if(isAll){
				$logItem.addClass('isChecked').find('.log-wrap input.chk').prop('checked',check);
			}
		}else{ //如果有任何一个没选中，则为非全选状态
			$logItem.removeClass('isChecked').find('.log-wrap input.chk').prop('checked',check);
			$parent.removeClass('isChecked');
		}
	});
	
	$('.cart-wrap .buy-now input.chk').on('change',function(){ //全选
		var $this = $(this),
			check = $this.prop('checked');
		
		$($this.parents('.cart-wrap')[0]).find('input.chk').prop('checked',check);
		
	});
	
	$('.cart-wrap .header .btn-edit').on('tap',function(){ //编辑
		var $this = $(this);
		
		$this.toggleClass('active');
		$('.cart-wrap .cart').toggleClass('editing');
		if($('.cart-wrap .editing').length > 0){
			$('.cart-wrap input.chk').prop('checked',false);
			$('.cart-wrap .isChecked').removeClass('isChecked');
		}
	});
	
	$('.cart-wrap .btn-delete').on('tap',function(){ //删除
		$('body').on('touchmove',function(e){ e.preventDefault(); });
		if($('.cart-wrap .isChecked').length > 0){
			$('.cart-wrap .delete-alert').removeClass('hide');
		}else{
			Insect.util.alertBox('请选择要删除的订单');
		}
	});
	
	$('.cart-wrap .delete-alert .btn-confirm').on('tap',function(){ //确定删除
		$('body').off('touchmove');
		$('.cart-wrap .delete-alert').addClass('hide');
		$('.cart-wrap .isChecked').remove();
	});
	
	$('.cart-wrap .delete-alert .btn-cancel').on('tap',function(){ //取消删除
		$('body').off('touchmove');
		$('.cart-wrap .delete-alert').addClass('hide');
	});
	
	$('.cart-wrap .btn-yh').on('tap',function(){ //优惠按钮
		$(this).toggleClass('active');
	});
	
	$('.cart-wrap .btn-zp').on('tap',function(){ //选择赠品
		$('.cart-wrap .zp-alert').show();
		if (window.addEventListener&&($('.cart-wrap .zp-alert').data('one'))) {
	        $('.cart-wrap .zp-alert').data('one',false);
		    jackyScroll(document.querySelector(".cart-wrap .zp-alert .alert-content"),{//消息内容滚动设置
				verticalScroll: true,          // 默认垂直滚动
				horizontalScroll: false,       // 水平滚动，默认false，不水平滚动
				hideScrollBar: false,          // 是否隐藏滚动条
				onScroll: function() {}        // 滚动时候的回调
			});
		}
	});
	
	$('.cart-wrap .zp-alert .btn-close,.cart-wrap .zp-alert .btn-cancel').on('tap',function(){ //关闭选择赠品
		$('.cart-wrap .zp-alert').hide();
	});
	
	$('.cart-wrap .btn-zh').on('tap',function(){ //选择套餐
		$('.cart-wrap .tc-alert').show();
		if (window.addEventListener&&($('.cart-wrap .tc-alert').data('one'))) {
	        $('.cart-wrap .tc-alert').data('one',false);
		    jackyScroll(document.querySelector(".cart-wrap .tc-alert .alert-content"),{//消息内容滚动设置
				verticalScroll: true,          // 默认垂直滚动
				horizontalScroll: false,       // 水平滚动，默认false，不水平滚动
				hideScrollBar: false,          // 是否隐藏滚动条
				onScroll: function() {}        // 滚动时候的回调
			});
		}
	});
	
	$('.cart-wrap .tc-alert .btn-close,.cart-wrap .tc-alert .btn-cancel').on('tap',function(){ //关闭选择套餐
		$('.cart-wrap.tc-alert').hide();
	});
	
	$('.cart-wrap .btn-clear').on('tap',function(){ //结算
		nextPage('.cart-wrap > .check-order','.cart-wrap');
	});
	
	$('.check-order .btn-back').on('tap',function(){ //结算返回
		backPage('.cart-wrap > .cart','.cart-wrap');
	});
	
	$('.check-order .order-info .addr-info').on('tap',function(){ //修改地址
		nextPage('.cart-wrap > .addr-select','.cart-wrap');
	});
	
	$('.addr-select .btn-back').on('tap',function(){ //修改地址返回
		backPage('.cart-wrap > .check-order','.cart-wrap');
		$('.wrap > .footer').addClass('hide');
	});
	
	$('.check-order .btn-submit').on('tap',function(){ //提交订单
		nextPage('.cart-wrap > .order-success','.cart-wrap');
	});
	
	$('.cart-wrap > .order-success .btn-back').on('tap',function(){ //提交订单成功返回
		backPage('.cart-wrap > .check-order','.cart-wrap');
		$('.wrap > .footer').addClass('hide');
	});
	
	
	//成功后————>首页
	$('.cart-wrap > .order-success .btn-index').on('tap',function(){
		setPointer('.index-wrap'); //防止点击穿透
		$('.wrap > .footer').removeClass('hide').find('.btn-index').addClass('active').siblings().removeClass('active');
		$('.index-wrap').removeClass('hide').siblings().addClass('hide');
		$('.cart-wrap').children().addClass('hide').removeClass('curPage').css({'left':'0'});
		$('.cart-wrap .cart').removeClass('hide').addClass('curPage');
	});
	
	
	//成功后————>订单详情 
	$('.cart-wrap > .order-success .btn-order').on('tap',function(){
		$('.wrap > .footer').removeClass('hide').find('.btn-personal').addClass('active').siblings().removeClass('active');
		$('.personal-wrap').removeClass('hide').siblings().addClass('hide');
		$('.cart-wrap').children().addClass('hide').removeClass('curPage').css({'left':'0'});
		$('.cart-wrap .cart').removeClass('hide').addClass('curPage');
		$('.personal-wrap .my-order').addClass('curPage').removeClass('hide').css({'left':'0'});
		$('.personal-wrap .personal').removeClass('curPage').addClass('hide').css({'left':'-100%'});
	});
	
	
	
	/*
	 * @商品详情
	 */
	$('.goods-sort ul li .pic,.goods-wrap ul li .pic').on('tap',function(){ //显示商品详情
		$('.detail-wrap').removeClass('hide');
		$('.curPage').addClass('hide');
		Insect.util.imgScrollRequest('.detail-wrap .lazy');
		$(window).scrollTop(0);
	});
	
	$('.detail-wrap .btn-back').on('tap',function(){ //商品详情返回
		$('.detail-wrap').addClass('hide');
		$('.curPage').removeClass('hide');
		$('#cart-tips').hide();
	});
	
	$('.detail-wrap .btn-zp').on('tap',function(){ //选择赠品
		$('.detail-wrap .zp-alert').show();
		if (window.addEventListener&&($('.detail-wrap .zp-alert').data('one'))) {
	        $('.detail-wrap .zp-alert').data('one',false);
		    jackyScroll(document.querySelector(".detail-wrap .zp-alert .alert-content"),{//消息内容滚动设置
				verticalScroll: true,          // 默认垂直滚动
				horizontalScroll: false,       // 水平滚动，默认false，不水平滚动
				hideScrollBar: false,          // 是否隐藏滚动条
				onScroll: function() {}        // 滚动时候的回调
			});
		}
	});
	
	$('.detail-wrap .zp-alert .btn-close,.detail-wrap .zp-alert .btn-cancel').on('tap',function(){ //关闭选择赠品
		$('.detail-wrap .zp-alert').hide();
	});
	
	$('.detail-wrap .btn-zh').on('tap',function(){ //选择套餐
		$('.detail-wrap .tc-alert').show();
		if (window.addEventListener&&($('.detail-wrap .tc-alert').data('one'))) {
	        $('.detail-wrap .tc-alert').data('one',false);
		    jackyScroll(document.querySelector(".detail-wrap .tc-alert .alert-content"),{//消息内容滚动设置
				verticalScroll: true,          // 默认垂直滚动
				horizontalScroll: false,       // 水平滚动，默认false，不水平滚动
				hideScrollBar: false,          // 是否隐藏滚动条
				onScroll: function() {}        // 滚动时候的回调
			});
		}
	});
	
	$('.detail-wrap .tc-alert .btn-close,.detail-wrap .tc-alert .btn-cancel').on('tap',function(){ //关闭选择套餐
		$('.detail-wrap .tc-alert').hide();
	});
	
	//商品详情页加入购物车效果
	$('.detail-wrap .add-cart').on('tap',function(){
		Animate.addCart(this);
	});
	
	$('.detail-wrap .add-bar .btn-add').on('tap',function(){ //一键加入购物车
		Insect.util.alertBox('<i class="icon-add"></i>成功加入购物车！');
	});
	
	
	/*
	 * @活动页
	 */
	
	$('.index .btn-bulk').on('tap',function(){ //进入活动页
		$(window).scrollTop(0);
		$('.wrap > .footer').addClass('hide');
		$('.activity-wrap').removeClass('hide').siblings().addClass('hide');
		Insect.util.imgScrollRequest('.activity .lazy');
	});
	
	$('.activity-wrap .activity .btn-back').on('tap',function(){ //活动页返回主页
		$(window).scrollTop(0);
		$('.wrap > .footer').removeClass('hide');
		$('.activity-wrap').addClass('hide').siblings('.index-wrap').removeClass('hide');
	});
	
	//限量爆款
	$('.activity .btn-moldbaby').on('tap',function(){ //限量爆款
		nextPage('.activity-wrap > .sp-moldbaby','.activity-wrap');
	});
	
	$('.sp-moldbaby .btn-back').on('tap',function(){ //限量爆款返回
		backPage('.activity-wrap > .activity','.activity-wrap');
		$('.wrap > .footer').addClass('hide');
	});
	
	$('.sp-moldbaby .add-cart').on('tap',function(){ //限量爆款页加入购物车效果
		Animate.addCart(this);
	});
	
	$('.sp-moldbaby .header .btn-sort').on('tap',function(){ //筛选
		$('.sp-moldbaby .good-wrap').addClass('hide');
		$('.sp-moldbaby .sort-wrap').removeClass('hide');
	});
	
	$('.sp-moldbaby .sort-wrap .btn-ok').on('tap',function(){ //确定筛选条件
		$('.sp-moldbaby .good-wrap').removeClass('hide');
		$('.sp-moldbaby .sort-wrap').addClass('hide');
	});
	
	
	//满就送
	$('.activity .btn-mjs').on('tap',function(){ //满就送
		nextPage('.activity-wrap > .sp-fullsend','.activity-wrap');
	});
	
	$('.sp-fullsend .btn-back').on('tap',function(){ //满就送返回
		backPage('.activity-wrap > .activity','.activity-wrap');
		$('.wrap > .footer').addClass('hide');
	});
	
	$('.sp-fullsend .add-cart').on('tap',function(){ //满就送页加入购物车效果
		Animate.addCart(this);
	});
	
	$('.sp-fullsend .header .btn-sort').on('tap',function(){ //筛选
		$('.sp-fullsend .good-wrap').addClass('hide');
		$('.sp-fullsend .sort-wrap').removeClass('hide');
	});
	
	$('.sp-fullsend .sort-wrap .btn-ok').on('tap',function(){ //确定筛选条件
		$('.sp-fullsend .good-wrap').removeClass('hide');
		$('.sp-fullsend .sort-wrap').addClass('hide');
	});
	
	//组合优惠 
	$('.activity .btn-group').on('tap',function(){ //组合优惠 
		nextPage('.activity-wrap > .sp-group','.activity-wrap');
	});

	$('.sp-group .btn-back').on('tap',function(){ //组合优惠返回
		backPage('.activity-wrap > .activity','.activity-wrap');
		$('.wrap > .footer').addClass('hide');
	});
	
	$('.sp-group .item-wrap .add-cart').on('tap',function(){ //组合优惠点击加入购物车后出现数量输入框
		$(this).addClass('hide-im').siblings('label').removeClass('hide-im');
	});
	
	$('.sp-group .header .btn-sort').on('tap',function(){ //筛选
		$('.sp-group .good-wrap').addClass('hide');
		$('.sp-group .sort-wrap').removeClass('hide');
	});
	
	$('.sp-group .sort-wrap .btn-ok').on('tap',function(){ //确定筛选条件
		$('.sp-group .good-wrap').removeClass('hide');
		$('.sp-group .sort-wrap').addClass('hide');
	});
	
	//享乐购
	$('.activity .btn-tesco').on('tap',function(){ //享乐购
		nextPage('.activity-wrap > .sp-tesco','.activity-wrap');
	});
	
	$('.sp-tesco .btn-back').on('tap',function(){ //享乐购返回
		backPage('.activity-wrap > .activity','.activity-wrap');
		$('.wrap > .footer').addClass('hide');
	});
	
	$('.sp-tesco .add-cart').on('tap',function(){ //享乐购页加入购物车效果
		Animate.addCart(this);
	});
	
	$('.sp-tesco .header .btn-sort').on('tap',function(){ //筛选
		$('.sp-tesco .good-wrap').addClass('hide');
		$('.sp-tesco .sort-wrap').removeClass('hide');
	});
	
	$('.sp-tesco .sort-wrap .btn-ok').on('tap',function(){ //确定筛选条件
		$('.sp-tesco .good-wrap').removeClass('hide');
		$('.sp-tesco .sort-wrap').addClass('hide');
	});
	
	//多优惠
	$('.activity .btn-dyh').on('tap',function(){ //多优惠
		nextPage('.activity-wrap > .sp-coupon','.activity-wrap');
	});
	
	$('.sp-coupon .btn-back').on('tap',function(){ //多优惠返回
		backPage('.activity-wrap > .activity','.activity-wrap');
		$('.wrap > .footer').addClass('hide');
	});

	$('.sp-coupon .add-cart').on('tap',function(){ //多优惠页加入购物车效果
		Animate.addCart(this);
	});
	
	$('.sp-coupon .header .btn-sort').on('tap',function(){ //筛选
		$('.sp-coupon .good-wrap').addClass('hide');
		$('.sp-coupon .sort-wrap').removeClass('hide');
	});
	
	$('.sp-coupon .sort-wrap .btn-ok').on('tap',function(){ //确定筛选条件
		$('.sp-coupon .good-wrap').removeClass('hide');
		$('.sp-coupon .sort-wrap').addClass('hide');
	});
	
	//满减
	$('.activity .btn-mj').on('tap',function(){ //满减
		nextPage('.activity-wrap > .sp-fullsubtract','.activity-wrap');
	});
	
	$('.sp-fullsubtract .btn-back').on('tap',function(){ //满减返回
		backPage('.activity-wrap > .activity','.activity-wrap');
		$('.wrap > .footer').addClass('hide');
	});
	
	$('.sp-fullsubtract .add-cart').on('tap',function(){ //满减页加入购物车效果
		Animate.addCart(this);
	});
	
	$('.sp-fullsubtract .header .btn-sort').on('tap',function(){ //筛选
		$('.sp-fullsubtract .good-wrap').addClass('hide');
		$('.sp-fullsubtract .sort-wrap').removeClass('hide');
	});
	
	$('.sp-fullsubtract .sort-wrap .btn-ok').on('tap',function(){ //确定筛选条件
		$('.sp-fullsubtract .good-wrap').removeClass('hide');
		$('.sp-fullsubtract .sort-wrap').addClass('hide');
	});
	
	//满折
	$('.activity .btn-mz').on('tap',function(){ //满就送
		nextPage('.activity-wrap > .sp-fulldiscount','.activity-wrap');
	});
	
	$('.sp-fulldiscount .btn-back').on('tap',function(){ //满就送返回
		backPage('.activity-wrap > .activity','.activity-wrap');
		$('.wrap > .footer').addClass('hide');
	});
	
	$('.sp-fulldiscount .add-cart').on('tap',function(){ //满就送页加入购物车效果
		Animate.addCart(this);
	});
	
	$('.sp-fulldiscount .header .btn-sort').on('tap',function(){ //筛选
		$('.sp-fulldiscount .good-wrap').addClass('hide');
		$('.sp-fulldiscount .sort-wrap').removeClass('hide');
	});
	
	$('.sp-fulldiscount .sort-wrap .btn-ok').on('tap',function(){ //确定筛选条件
		$('.sp-fulldiscount .good-wrap').removeClass('hide');
		$('.sp-fulldiscount .sort-wrap').addClass('hide');
	});
	
	
	/*
	 * @个人中心
	 */
	
	var alertInfo = function(){
		var html = '<div id="alert-info" class="alert-info">'
						+'<div class="txt">'
							+'<p><i class="icon-coding"></i>功能开发中，敬请期待！</p>'
						+'</div>'
				   +'</div>';
		$('body').append(html);
		$('body').on('touchmove',function(e){
			e.preventDefault();
		});
		setTimeout(function(){
			$('#alert-info').fadeOut(1000,function(){
				$(this).remove();
				$('body').off('touchmove');
			});
		},1500);
	}
	
	//统计数据
	$('.personal-wrap .personal .btn-data').on('tap',function(){
		alertInfo();
	});
	
	//我的订单
	
	$('.personal-wrap .personal .btn-order').on('tap',function(){ //切换到我的订单
		nextPage('.personal-wrap > .my-order','.personal-wrap');
	});
	
	$('.personal-wrap .my-order .btn-back').on('tap',function(){ //返回
		backPage('.personal-wrap > .personal','.personal-wrap');
	});
	
	$('.my-order .header .btn-filter').on('tap',function(){ //模拟筛选
		$('.my-order .order-list').toggleClass('hide');
		$('.my-order .filter-box').toggleClass('hide');
	});
	
	var ydm = null;
	$('.my-order .filter-date input[type=text]').on('tap',function(){ //弹出日期控件
		var seq = $(this).data('seq');
		$('.my-order .date-alert').removeClass('hide').data('seq', seq);
		if(!ydm){
			ydm = new YMDselect('year','month','day',2016,6,28);
		}
	});
	
	$('.my-order .date-alert .btn-cancel').on('tap',function(){ //取消选择
		$('.my-order .date-alert').addClass('hide');
	});
	$('.my-order .date-alert .btn-ok').on('tap',function(){ //确定选择
		var $parent = $($(this).parents('.date-alert')[0]),
			year = $parent.find('select[name=year]').val(),
			month = $parent.find('select[name=month]').val(),
			day = $parent.find('select[name=day]').val();
			
		$parent.addClass('hide');
		if($parent.data('seq') == 'f'){
			$('.my-order .filter-box .first-date').val(year + '-' + month + '-' + day);	
		}else{
			$('.my-order .filter-box .second-date').val(year + '-' + month + '-' + day);
		}
	});
	
	$('.my-order .filter-date input[type=button]').on('tap',function(){ //确定筛选条件
		$('.wrap > .footer').removeClass('hide');
		$('.my-order .filter-box').addClass('hide');
		$('.my-order .order-list').removeClass('hide');
	});
	
	$('.date-alert select').on('change',function(){ //同步更新select上遮挡层数据
		var $this = $(this);
		$this.siblings('span').text($this.val());
	});
	
	
	$('.my-order .order-list .item-list').on('tap',function(){ //订单详情
		$('.my-order').addClass('hide');
		$('.order-detail').removeClass('hide');
	});
	
	$('.order-detail .btn-back').on('tap',function(){ //订单详情返回
		$('.personal-wrap .curPage').removeClass('hide');
		$('.order-detail').addClass('hide');
	});
	
	
	//我的收藏
	$('.personal-wrap .personal .btn-collect').on('tap',function(){ //切换到我的收藏
		nextPage('.personal-wrap > .my-collect','.personal-wrap');
	});
	
	$('.personal-wrap .my-collect .btn-back').on('tap',function(){ //返回
		backPage('.personal-wrap > .personal','.personal-wrap');
	});
	
	$('.my-collect .header .btn-edit').on('tap',function(){ //编辑
		var $this = $(this);
		
		$this.toggleClass('active');
		$('.my-collect').toggleClass('editing');
	});
	
	$('.my-collect .collect-list input.chk').on('change',function(){ //多选框状态变化
		var $this = $(this),
			$parent = $($this.parents('li')[0]);
		if($this.prop('checked')){
			$parent.addClass('checked');
		}else{
			$parent.removeClass('checked');
		}
	});
	
	$('.my-collect .btn-delete').on('tap',function(){ //删除
		if($('.my-collect .checked').length > 0){
			$('body').on('touchmove',function(e){ e.preventDefault(); });
			$('.my-collect .delete-alert').removeClass('hide');
		}else{
			Insect.util.alertBox('请选择要删除的商品');
		}
	});
	
	$('.my-collect .delete-alert .btn-confirm').on('tap',function(){ //确定删除
		$('body').off('touchmove');
		$('.my-collect .delete-alert').addClass('hide');
		$('.my-collect .checked').remove();
	});
	
	$('.my-collect .delete-alert .btn-cancel').on('tap',function(){ //取消删除
		$('body').off('touchmove');
		$('.my-collect .delete-alert').addClass('hide');
	});

	
	$('.my-collect .header .f-wrap a').on('tap',function(){ //宝贝分类
		var $this = $(this);
		$this.toggleClass('active');
	});
	
	//我的收藏页加入购物车效果
	$('.my-collect .add-cart').on('tap',function(){
		Animate.addCart(this);
	});
	
	
	//浏览历史
	
	$('.personal-wrap .personal .btn-browsing').on('tap',function(){ //切换到浏览历史
		nextPage('.personal-wrap > .browsing-history','.personal-wrap');
	});
	
	$('.personal-wrap .browsing-history .btn-back').on('tap',function(){ //返回
		backPage('.personal-wrap > .personal','.personal-wrap');
	});
	
	$('.browsing-history .header .f-wrap a').on('tap',function(){ //宝贝分类
		var $this = $(this);
		$this.toggleClass('active');
	});
	
	//浏览历史页加入购物车效果
	$('.browsing-history .add-cart').on('tap',function(){
		Animate.addCart(this);
	});
	
	//历史购买
	
	$('.personal-wrap .personal .btn-buy').on('tap',function(){ //切换到历史购买
		nextPage('.personal-wrap > .buy-history','.personal-wrap');
	});
	
	$('.personal-wrap .buy-history .btn-back').on('tap',function(){ //返回
		backPage('.personal-wrap > .personal','.personal-wrap');
	});
	
	$('.buy-history .header .btn-filter').on('tap',function(){ //模拟筛选
		$('.buy-history .order-list').toggleClass('hide');
		$('.buy-history .filter-box').toggleClass('hide');
	});
	
	$('.buy-history .order-list .item-list').on('tap',function(){ //订单详情
		$('.buy-history').addClass('hide');
		$('.order-detail').removeClass('hide');
	});
	
	var ydm2 = null;
	$('.buy-history .filter-date input[type=text]').on('tap',function(){ //弹出日期控件
		var seq = $(this).data('seq');
		$('.buy-history .date-alert').removeClass('hide').data('seq', seq);
		if(!ydm2){
			ydm2 = new YMDselect('year2','month2','day2',2016,6,28);
		}
	});
	
	$('.buy-history .date-alert .btn-cancel').on('tap',function(){ //取消选择
		$('.buy-history .date-alert').addClass('hide');
	});
	$('.buy-history .date-alert .btn-ok').on('tap',function(){ //确定选择
		var $parent = $($(this).parents('.date-alert')[0]),
			year = $parent.find('select[name=year2]').val(),
			month = $parent.find('select[name=month2]').val(),
			day = $parent.find('select[name=day2]').val();
			
		$parent.addClass('hide');
		if($parent.data('seq') == 'f'){
			$('.buy-history .filter-box .first-date').val(year + '-' + month + '-' + day);	
		}else{
			$('.buy-history .filter-box .second-date').val(year + '-' + month + '-' + day);
		}
	});
	
	$('.buy-history .filter-date input[type=button]').on('tap',function(){ //确定筛选条件
		$('.wrap > .footer').removeClass('hide');
		$('.buy-history .filter-box').addClass('hide');
		$('.buy-history .order-list').removeClass('hide');
	});
	
	$('.date-alert select').on('change',function(){ //同步更新select上遮挡层数据
		var $this = $(this);
		$this.siblings('span').text($this.val());
	});
	
	
	//设置
	$('.personal-wrap .personal .btn-setting').on('tap',function(){ //切换到浏览历史
		nextPage('.personal-wrap > .setting-box','.personal-wrap');
	});
	
	$('.personal-wrap .setting-box .btn-back').on('tap',function(){ //返回
		backPage('.personal-wrap > .personal','.personal-wrap');
	});
	
	//账户信息
	$('.personal-wrap .personal .btn-account-manage').on('tap',function(){ //切换到账户信息
		nextPage('.personal-wrap > .account-manage','.personal-wrap');
	});
	
	$('.personal-wrap .account-manage .btn-back').on('tap',function(){ //返回
		backPage('.personal-wrap > .personal','.personal-wrap');
	});
	
	$('.personal-wrap .account-manage .add-address').on('tap',function(){ //新增地址
		$('.personal-wrap .new-address').removeClass('hide');
		$('.personal-wrap .account-manage').addClass('hide');
		//省市区三级联动初始化
		addressInit('addProvince', 'addCity', 'addArea', '广东', '广州市', '越秀区');
	});
	
	$('.new-address .header .btn-back').on('tap',function(){ //新增地址返回
		$('.personal-wrap .new-address').addClass('hide');
		$('.personal-wrap .account-manage').removeClass('hide');
		
	});
	
	$('.personal-wrap .account-manage .btn-edit').on('tap',function(){ //编辑地址
		$('.personal-wrap .edit-address').removeClass('hide');
		$('.personal-wrap .account-manage').addClass('hide');
		//省市区三级联动初始化
		addressInit('edProvince', 'edCity', 'edArea', '广东', '广州市', '越秀区');
	
	});
	
	$('.edit-address .header .btn-back').on('tap',function(){ //编辑地址返回
		$('.personal-wrap .edit-address').addClass('hide');
		$('.personal-wrap .account-manage').removeClass('hide');
	});
	
	//我的资产
	$('.personal-wrap .personal .btn-assets').on('tap',function(){ //切换到我的资产
		nextPage('.personal-wrap > .my-assets','.personal-wrap');
	});
	
	$('.personal-wrap .my-assets .btn-back').on('tap',function(){ //返回
		backPage('.personal-wrap > .personal','.personal-wrap');
	});
	
	$('.my-assets .sign-in input').on('tap',function(){ //签到
		$(this).addClass('active');
	});
	
	//修改地址
	$('.edit-address .addr-city select').on('change',function(){ //同步更新select上遮挡层数据
		var $this = $(this);
		$this.siblings('.txt').find('span').text($this.val());
	});
	
	//新增地址
	$('.new-address .addr-city select').on('change',function(){ //同步更新select上遮挡层数据
		var $this = $(this);
		$this.siblings('.txt').find('span').text($this.val());
	});
	
	
	/*
	 * @供应商
	 */
	
	$('.entrance .btn-supplier').on('tap',function(){ //切换到供应商页面
		nextPage('.index-wrap > .supplier','.index-wrap');
		Insect.util.imgScrollRequest('.supplier .lazy');
	});
	
	$('.index-wrap .supplier .btn-back').on('tap',function(){ //返回上一页
		backPage('.index-wrap > .index','.index-wrap');
	});
	
	$('.supplier .choice-supplier').on('tap',function(){ //选择供应商
		$(window).scrollTop(0);
		$('.index-wrap .supplier .btn-back').data('page',1)
		$(this).addClass('active').siblings().removeClass('active');
		$('.supplier .goods-list').addClass('hide');
		$('.supplier .supplier-list').removeClass('hide');
		$('.supplier .goods-sort').addClass('hide');
		$('#cart-tips').hide();
	});
	
	$('.supplier .supplier-list input[name="supplier"]').on('change',function(){ //完成选择供应商
		var choiceItem = $(this).siblings('.rdo-bg').text();
		$('.supplier .choice-supplier').removeClass('active').addClass('selected').find('.item-name').text(choiceItem);
		$('.supplier .h-filter li').removeClass('hide').css('width','50%');
		$('.supplier .goods-list').removeClass('hide');
		$('.supplier .supplier-list').addClass('hide');
	});
	
	$('.supplier .choice-sort').on('tap',function(){ //选择商品分类
		$(window).scrollTop(0);
		$('.index-wrap .supplier .btn-back').data('page',2)
		$(this).addClass('active').siblings().removeClass('active');
		$('.supplier .goods-list').addClass('hide');
		$('.supplier .supplier-list').addClass('hide');
		$('.supplier .goods-sort').removeClass('hide');
		$('#cart-tips').hide();
	});
	
	$('.supplier .goods-sort .btn-ok').on('tap',function(){ //完成选择商品分类
		var $checked = $('.supplier .goods-sort input[name="sort"]:checked');
		if($checked.size() >= 1){
			var choiceItem = $checked.siblings('.rdo-bg').text();
			$('.supplier .choice-sort').addClass('selected').find('.item-name').text(choiceItem);
		}
		$('.supplier .choice-sort').removeClass('active');
		$('.supplier .goods-list').removeClass('hide');
		$('.supplier .goods-sort').addClass('hide');
	});
	
	$('.supplier .add-cart').on('tap',function(){ //供应商页面加入购物车效果
		Animate.addCart(this);
	});
	
	$('.supplier .nav-supplier ul li').on('tap',function(){ //选择供应商字母锚点定位
		anchorScroll('.supplier',this);
	});
	
	
	/*
	 * @特价商品页
	 * @入口展示放在批发抢购（首页第三个入口）
	 */
	
	$('.entrance .btn-gold').on('tap',function(){ //切换到特价商品页面(批发抢购)
		nextPage('.index-wrap > .bargain-goods','.index-wrap');
		Insect.util.imgScrollRequest('.bargain-goods .lazy');
	});
	
	$('.index-wrap .bargain-goods .btn-back').on('tap',function(){ //返回上一页
		backPage('.index-wrap > .index','.index-wrap');
	});
	
	$('.bargain-goods .choice-brand').on('tap',function(){ //选择品牌
		$(window).scrollTop(0);
		$(this).addClass('active').siblings().removeClass('active');
		$('.bargain-goods .goods-list').addClass('hide');
		$('.bargain-goods .brand-sort').removeClass('hide');
		$('.bargain-goods .goods-sort').addClass('hide');
		$('#cart-tips').hide();
	});
	
	$('.bargain-goods .brand-sort .btn-ok').on('tap',function(){ //完成选择品牌分类
		var $checked = $('.bargain-goods .brand-sort input[name="brand"]:checked');
		if($checked.size() >= 1){
			var choiceItem = $checked.siblings('.rdo-bg').text();
			$('.bargain-goods .choice-brand').addClass('selected').find('.item-name').text(choiceItem);
		}
		$('.bargain-goods .choice-brand').removeClass('active');
		$('.bargain-goods .goods-list').removeClass('hide');
		$('.bargain-goods .brand-sort').addClass('hide');
	});
	
	$('.bargain-goods .choice-sort').on('tap',function(){ //选择商品分类
		$(window).scrollTop(0);
		$(this).addClass('active').siblings().removeClass('active');
		$('.bargain-goods .goods-list').addClass('hide');
		$('.bargain-goods .brand-sort').addClass('hide');
		$('.bargain-goods .goods-sort').removeClass('hide');
		$('#cart-tips').hide();
	});
	
	$('.bargain-goods .goods-sort .btn-ok').on('tap',function(){ //完成选择商品分类
		var $checked = $('.bargain-goods .goods-sort input[name="good"]:checked');
		if($checked.size() >= 1){
			var choiceItem = $checked.siblings('.rdo-bg').text();
			$('.bargain-goods .choice-sort').addClass('selected').find('.item-name').text(choiceItem);
		}
		$('.bargain-goods .choice-sort').removeClass('active')
		$('.bargain-goods .goods-list').removeClass('hide');
		$('.bargain-goods .goods-sort').addClass('hide');
	});
	
	$('.bargain-goods .add-cart').on('tap',function(){ //特价商品页面加入购物车效果
		Animate.addCart(this);
	});
	
	
	
	//地图获取位置
	function showPosition(a,b){
		//调用百度地图api
//		alert('经度：'+ a +'  '+'纬度：'+b);
	}
//	Insect.geo.getLocation(showPosition);
	
	
	
	
	/*
	 * @android文字偏上hack(android下line-height导致)
	 */
	var isAndroid = Insect.device.isAndriod || false;
	if(isAndroid){
		$('.h-search .btn-search').css({'padding-top':'0.65rem'});
		$('.city-header input,.brand-header input,.location .header input,.hot-brand .header input,.brand-list .header input').css({'padding-top':'0.25rem'});
		$('.search-header .btn-wrap,.brand-list .btn-wrap').css({'padding-top':'0.15rem'});
		$('.index-wrap .index .floor .tit i.icon-more').css({'top':'-0.05rem'});
		$('.activity-wrap .floor .btn-more').css({'padding-top':'0.15rem'});
		$('.activity-wrap .floor .tit p').css({'margin-top':'0.25rem'});
	}
	
});
