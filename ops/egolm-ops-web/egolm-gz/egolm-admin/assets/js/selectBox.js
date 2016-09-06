jQuery(function(){
	
	//三级菜单 --- 一级
	$('.lv-first>li').hover(function(){
		$('.lv-first').find('.select').removeClass('select');
		$(this).addClass('select').siblings().removeClass('select');
	},function(){});
	
	//三级菜单 --- 二级
	$('.lv-second>li').hover(function(){
		$('.lv-second').find('.select').removeClass('select');
		$(this).addClass('select').siblings().removeClass('select');
	},function(){});
	
	$('.lv-third>li').on('click',function(){
		
	});
	
	//第三级点击,显示选择信息
	$('.lv-third>li').on('click',function(e){
		var $this = $(this),
			lv3 = $this.find('.item-name').text(),
			lv2 = $this.parents('ul.lv-third:first').siblings('.item-name').text(),
			lv1 = $this.parents('ul.lv-second:first').siblings('.item-name').text();
		
		$this.parents('ul.lv-first:first').siblings('.dropdown-btn').find('.item-name').text(lv1 + ',' + lv2 + ',' + lv3);

	});
	
	//重置选中状态
	$(document).on('click',function(){
		$('.lv-first').find('.select').removeClass('select');
	});
	
});