jQuery(function(){
	
	var insertHtml = function(elem){
		var text = $(elem).text(),
			html = '<div style="position:fixed;z-index:9999;" class="show-item-name">'+text+'</div>';
		$('body').append(html);
	}
	
	var removeHtml = function(){
		$('.show-item-name').remove();
	}
	
	var showItemName = function(e){
		var x = e.originalEvent.x || e.originalEvent.layerX || 0,
			y = e.originalEvent.y || e.originalEvent.layerY || 0;
		
		$('.show-item-name').css({'top': y + 5 +'px','left': x - 40 + 'px'});
		
	}
	
	$('.dropdown-btn').hover(function(){
		if( $(this).find('.item-name').length > 0 ){ insertHtml(this); }
	},function(){
		if( $(this).find('.item-name').length > 0 ){ removeHtml(); }
	});
	
	$('.dropdown-btn .item-name').mousemove(function(e){
		showItemName(e);
	});
	
	
});