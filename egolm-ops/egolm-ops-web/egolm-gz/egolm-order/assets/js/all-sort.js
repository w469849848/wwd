jQuery(function(){
	
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
	
	
	//更多商品分类
	$('.g-sort .btn-more').on('click',function(){
		
		$(this).parents('.g-sort:first').find('.goods-sort').toggleClass('active');
		$(this).find('a').toggleClass('active');
	});
	
	//更多品牌分类
	$('.g-brand .btn-more').on('click',function(){
		
		$(this).parents('.g-brand:first').find('.brand-sort').toggleClass('active');
		$(this).find('a').toggleClass('active');
	});
	
	//更多经销商
	$('.dealer .btn-more').on('click',function(){
		
		$(this).parents('.dealer:first').find('.dealer-sort').toggleClass('active');
		$(this).find('a').toggleClass('active');
	});
	
	
	//选择效果
	var selectSort = function(thisELem,sortResult){
		var $this = $(thisELem),
			itemName = $this.find('a').text();
		
		$this.addClass('active').siblings().removeClass('active');
		if($('.selected-wrap .'+sortResult).length > 0){
			$('.selected-wrap .'+sortResult+' .item-name').text(itemName);
		}else{
			var html = '<li>'
							+'<div class="'+sortResult+' sort-item clearfix">'
								+'<span class="fl">分类：</span>'
								+'<span class="item-name fl">'+itemName+'</span>'
								+'<a class="btn-close" href="javascript:void(0)"></a>'
							+'</div>'
						+'</li>';
			$('.selected-wrap .goods-sort ul').append(html);
		}
	}
	
	//选择效果--分类
	$('.goods-nav .g-sort .goods-sort ul li').on('click',function(){
		selectSort(this,'sort-result')
	});
	
	//选择效果--品牌
	$('.goods-nav .g-brand .brand-sort ul li').on('click',function(){
		selectSort(this,'brand-result')
	});
	
	//选择效果--经销商
	$('.goods-nav .dealer .dealer-sort ul li').on('click',function(){
		selectSort(this,'dealer-result')
	});
	
	//删除选中
	$(document).on('click','.selected-wrap .btn-close',function(){
		var $this = $(this);
		switch(true){
			case $this.parents('.sort-result:first').length > 0:
				$('.goods-nav .g-sort ul li.active').removeClass('active');
				break;
				
			case $this.parents('.brand-result:first').length > 0:
				$('.goods-nav .g-brand ul li.active').removeClass('active');
				break;
				
			case $this.parents('.dealer-result:first').length > 0:
				$('.goods-nav .dealer ul li.active').removeClass('active');
				break;
				
			//default
		}
		$this.parents('li:first').remove();
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
