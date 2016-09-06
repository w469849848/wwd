jQuery(function(){
	
	//商品分类
	$('.sort-wrap').hover(function(){
		$(this).find('.sort').show();
	},function(){
		$(this).find('.sort').hide();
	});
	
	
	$('.more-brand-nav>ul>li').on('click',function(){
		
		var $this = $(this),
			idx = $this.index(),
			$item = $this.parents('.more-brand:first').find('.more-brand-content>ul>li');
		
		$this.addClass('active').siblings().removeClass('active');
		
		$item.hide();
		$item.eq(idx).show();
		
	});
	
});