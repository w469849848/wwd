jQuery(function($){
	
	//商品分类
	$('.sort-wrap').hover(function(){
		$(this).find('.sort').show();
	},function(){
		$(this).find('.sort').hide();
	});
	
	//多选
	$('.select .chk').on('click',function(){
		var $this = $(this),
			chk = $this.attr('checked');
			
		$this.attr('checked',!chk);
	});
	
	//全选
	$('.btn-all .chk').on('click',function(){
		var $this = $(this),
			chk = $this.attr('checked');
			
		$this.attr('checked',!chk);
		
		$('.select .chk').attr('checked',!chk);
		
	});
	
	
	//下单条/筛选悬浮
	var isVisible = function(obj) { //元素是否可见
		if ($(obj).offset().top < ($(window).height() + $("body").scrollTop()) && (($(window).height() + $("body").scrollTop()) - $(obj).offset().top) < $(window).height()) {
			return true;
		} else {
			return false;
		}
	}

	var fixedBar = function(parentObj,childObj,className){
		if( isVisible($(parentObj)) ){
			$(childObj).removeClass(className);
		}else{
			$(childObj).addClass(className);
		}
	}
	
	//下单bar
	fixedBar('.bar-posi','.btn-bar-wrap','fixed bottom');
	//筛选bar
	fixedBar('.order-nav-wrap','.order-nav-box','.fixed top');
	
	$(document).scroll(function(){ //监听滚动条 --下单条悬浮
		fixedBar('.bar-posi','.btn-bar-wrap','fixed bottom');
		fixedBar('.order-nav-wrap','.order-nav-box','fixed top');
	});
	
	
});