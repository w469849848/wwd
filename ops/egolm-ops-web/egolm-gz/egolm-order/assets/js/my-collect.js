jQuery(function($){
	
	$('.sort-wrap').hover(function(){ //显示隐藏商品分类
		$(this).find('.sort').show();
	},function(){
		$(this).find('.sort').hide();
	});
	
	$('.g-wrap .ad-content').hover(function(){ //鼠标移入出现收藏按钮
		$(this).find('.collect').show();
	},function(){
		$(this).find('.collect').hide();
	});
	
	$('.collect a').on('click',function(){ // 收藏按钮
		
		//切换收藏样式
		$(this).toggleClass('active');
	});
	
	//更多品牌分类
	$('.g-brand .btn-more').on('click',function(){
		
		$(this).parents('.g-brand:first').find('.brand-sort').toggleClass('active');
		$(this).find('a').toggleClass('active');
	});
	
	//加入购物车效果
	$('a.add-cart').on('click',function(){
		
		var $successBox = $(this).parents('li:first').find('.add-cart-success');
		$successBox.show();
		setTimeout(function(){
			$successBox.fadeOut(1000);
		},500);
		
	});
	
});
