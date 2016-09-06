jQuery(function($){
	
	
	$('.collect a').on('click',function(){ //收藏
		
		//切换收藏样式
		$(this).toggleClass('active');
		
	});
	
	//切换优惠组合
	$('.good-group .group-nav ul li').on('click',function(){
		var $this = $(this),
			idx = $this.index(),
			$item = $this.parents('.good-group:first').find('.group-list-wrap .group-list');
			
		$this.addClass('active').siblings().removeClass('active');
		
		$item.hide();
		$item.eq(idx).show();
		
	});
	
	//分类导航
	$('.sort-wrap').hover(function(){
		$(this).find('.sort').show();
	},function(){
		$(this).find('.sort').hide();
	});
	
	//加入购物车效果
	$('.ad-intro a.add-cart').on('click',function(){
		
		var $successBox = $(this).parents('li:first').find('.add-cart-success');
		$successBox.show();
		setTimeout(function(){
			$successBox.fadeOut(1000);
		},500);
		
	});
	
	//详情页加入购物车组合 、 主商品加入购物车
	$('.good-info .add-cart').on('click',function(){
		
		var $successBox = $(this).parents('.good-info:first').find('.add-cart-success');
		$successBox.show();
		setTimeout(function(){
			$successBox.fadeOut(1000);
		},500);
	});
	
	$('.good-group .add-cart').on('click',function(){
		
		var $successBox = $(this).parents('.good-group:first').find('.add-cart-success');
		$successBox.show();
		setTimeout(function(){
			$successBox.fadeOut(1000);
		},500);
	});
	
	//切换查看图片
	$('.pic-nav li').on('click',function(){
		
		var $this = $(this),
			imgSrc = $this.data('src');
		$this.addClass('active').siblings().removeClass('active');
		$this.parents('.good-pic:first').find('.pic img').attr('src',imgSrc);
	});
	
	
	//左右切换图册
	var $item = $('.pic-nav li'),
		itemWidth = $item.outerWidth(true);
		len = $item.length;
		
	$('.btn-prev').on('click',function(){
		var $activeLi = $('.pic-nav li.active'),
			idx = $activeLi.index();
		if(idx > 0){
			imgSrc = $activeLi.prev().data('src');
			$activeLi.removeClass('active').prev().addClass('active');
			$('.good-info .pic img').attr('src',imgSrc);
			
			if(idx >= 4){
				$('.good-info .slide-wrap > ul').stop(true,true).animate({'left':$('.good-info .slide-wrap > ul').position().left + itemWidth + 'px'},300);
			}
		}
	});
	
	$('.btn-next').on('click',function(){
		var $activeLi = $('.pic-nav li.active'),
			idx = $activeLi.index();
		if(idx < (len - 1)){
			imgSrc = $activeLi.next().data('src');
			$activeLi.removeClass('active').next().addClass('active');
			$('.good-info .pic img').attr('src',imgSrc);
			if(idx >= 3){
				$('.good-info .slide-wrap > ul').stop(true,true).animate({'left':$('.good-info .slide-wrap > ul').position().left - itemWidth + 'px'},300);
			}
		}
	});
	
});
