jQuery(function($){
	
	$('.sort-wrap').hover(function(){ //显示隐藏商品分类
		$(this).find('.sort').show();
	},function(){
		$(this).find('.sort').hide();
	});
	
	//下拉
	$('.btn-dropdown').on('click',function(e){
		e.stopPropagation();
		$(this).parents('th').toggleClass('focus');
	});
	
	//选择
	$('.dr-menu ul li').on('click',function(e){
		e.stopPropagation();
		var $this = $(this),
			selectText = $this.text();
		
		$(this).parents('th:first').removeClass('focus').find('span.item-name').text(selectText);
		
	});
	//失去焦点
	$(document).on('click',function(){
		$('th').removeClass('focus');
	});
	
});
