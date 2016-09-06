jQuery(function(){
	
	/*
	 * @显示大图
	 * @图片宽高没控制，需要的话可在插入时控制（insertHtml）
	 * @需要显示大图的img要加上class="show-big",用于区分。
	 */
	
	var insertHtml = function(elem){
		var src = $(elem).attr('src'); //要显示的大图的路径
			html = '<div class="big-img"><img src="'+ src +'@1000w_500h" /></div>';
		$('body').append(html);
	}
	
	var removeHtml = function(){
		$('.big-img').remove();
	}
	
	var showItemName = function(e){
		var x = e.originalEvent.x || e.originalEvent.layerX || 0,
			y = e.originalEvent.y || e.originalEvent.layerY || 0;
		
		$('.big-img').css({'position':'fixed','z-index':'9999','top': y +'px','left': x + 20 + 'px'});
		
	}
	
	$('img.show-big').hover(function(){
		insertHtml(this);
	},function(){
		removeHtml();
	});
	
	$('img.show-big').mousemove(function(e){
		showItemName(e);
	});
	
	
});