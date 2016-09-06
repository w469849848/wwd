jQuery(function(){
	
	//商品分类导航
	$('.sort-wrap').hover(function(){
		$(this).find('.sort').show();
	},function(){
		$(this).find('.sort').hide();
	});
	
	//单选组--支付方式
	$(".pay-info input.radio").on('click',function(){
		var $this = $(this);
		$("input[name=pay]").attr('checked',false);
		$(this).attr('checked',true);
		
	});
	
});