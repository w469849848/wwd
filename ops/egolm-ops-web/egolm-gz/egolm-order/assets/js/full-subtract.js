jQuery(function(){
	
	$('.sort-wrap').hover(function(){ //显示隐藏商品分类
		$(this).find('.sort').show();
	},function(){
		$(this).find('.sort').hide();
	});
	
	//顶部背景位置修正
	var docWidth = $(document).width(),
		picWidth = 1920,
		picHeight = 456,
		paddingTop = picHeight*(docWidth/picWidth);
	$('.content-wrap').css({'padding-top':paddingTop+'px'});
	
	$(window).resize(function(){ //监听尺寸变化
		docWidth = $(document).width();
		paddingTop = picHeight*(docWidth/picWidth);
		$('.content-wrap').css({'padding-top':paddingTop+'px'});
	});
	
	$('.sort-wrap').hover(function(){ //显示隐藏商品分类
		$(this).find('.sort').show();
	},function(){
		$(this).find('.sort').hide();
	});
	
	$('.goods-wrap .ad-content').hover(function(){ //鼠标移入出现收藏按钮
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
	
	//商品分类点击筛选
	$('.g-sort ul li').on('click',function(){
		
		$(this).addClass('active').siblings().removeClass('active');
	});
	
	//更多品牌分类
	$('.g-brand .btn-more').on('click',function(){
		
		$(this).parents('.g-brand:first').find('.brand-sort').toggleClass('active');
		$(this).find('a').toggleClass('active');
	});
	
	//品牌分类点击筛选
	$('.g-brand ul li').on('click',function(){
		
		$(this).addClass('active').siblings().removeClass('active');
	});
	
	//加入购物车效果
	$('a.add-cart').on('click',function(){
		
		var $successBox = $(this).parents('li:first').find('.add-cart-success');
		$successBox.show();
		setTimeout(function(){
			$successBox.fadeOut(1000);
		},500);
		
	});
	
	//轮播
	var setSlide = function(sliderBox,visibleNum){
		var $obj = $(sliderBox),
			$sliderBox = $obj.find('ul'),
			itemLen = $sliderBox.find('li').length,
			itemWidth = $sliderBox.find('li').outerWidth(true),
			num = Math.round(itemLen/visibleNum),
			sliderWidth = itemLen * itemWidth,
			i = 0;
		
		
		$obj.find('ul').width(sliderWidth);
		if(itemLen <= visibleNum){
			$obj.find('a.btn-next').hide();
			$obj.find('a.btn-prev').hide();
			return;
		}
		
		$obj.find('a.btn-next').on('click',function(){
			$sliderBox.stop(true,true);
			var sliderLeft = parseInt($sliderBox.css('left'));
			if( i <= 0 ){
				i = num;
				$sliderBox.animate({'left':'-'+(num-1)*itemWidth*visibleNum + 'px'},600);
			}else{
				
				$sliderBox.animate({'left':sliderLeft + itemWidth*visibleNum + 'px'},600);
			}
			i--;
		});
		
		$obj.find('a.btn-prev').on('click',function(){
			$sliderBox.stop(true,true);
			i++;
			if(i < num){
				$sliderBox.animate({'left':'-'+ (itemWidth*visibleNum) + 'px'},600);
			}else{
				i = 0;
				$sliderBox.animate({'left':'0px'},600);
			}
		});
		
	}
	
	//轮播初始化
	$('.mz-content').each(function(){
		var $goodList = $(this).find('.goods-list');
		setSlide($goodList,4);
	});
});