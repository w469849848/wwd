jQuery(function(){
	
	$('.sort-wrap').hover(function(){ //显示隐藏商品分类
		$(this).find('.sort').show();
	},function(){
		$(this).find('.sort').hide();
	});
	
	//顶部背景位置修正
	var docWidth = $(document).width(),
		picWidth = 1920,
		picHeight = 496,
		paddingTop = picHeight*(docWidth/picWidth);
	$('.content-wrap').css({'padding-top':paddingTop+'px'});
	
	$(window).resize(function(){ //监听尺寸变化
		docWidth = $(document).width();
		paddingTop = picHeight*(docWidth/picWidth);
		$('.content-wrap').css({'padding-top':paddingTop+'px'});
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
		if(itemLen <= 5){
			$obj.find('a.btn-next').hide();
			$obj.find('a.btn-prev').hide();
			return;
		}
		
		$obj.find('a.btn-next').on('click',function(){
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
			i++;
			if(i < num){
				$sliderBox.animate({'left':'-'+ (itemWidth*visibleNum) + 'px'},600);
			}else{
				i = 0;
				$sliderBox.animate({'left':'0px'},600);
			}
		});
		
	}
	setSlide('.mz-wrap .goods-list',5);
	setSlide('.discount-wrap .goods-list',5);
	setSlide('.promotion-wrap .goods-list',5);
});