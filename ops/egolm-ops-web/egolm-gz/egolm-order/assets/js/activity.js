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
	
});