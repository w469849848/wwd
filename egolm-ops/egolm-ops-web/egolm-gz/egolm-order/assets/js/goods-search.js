jQuery(function(){
	
	//多选组点击
	$('input.chk').on('click',function(){
		var $this = $(this);
			chk = $this.attr('checked');
			
		if(!!chk){
			$this.attr('checked',false);
		}else{
			$this.attr('checked',true);
		}
		
	});
	
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
	
	//加入购物车效果
	$('a.add-cart').on('click',function(){
		
		var $successBox = $(this).parents('li:first').find('.add-cart-success');
		$successBox.show();
		setTimeout(function(){
			$successBox.fadeOut(1000);
		},500);
		
	});
	
	
});
