jQuery(function($) {

	var tableHeight = $('.table-outer').outerHeight(true),
		tableWidth = $('.true-table').width(),
		tfootHeight = $('tfoot td').outerHeight(true),
		surplusHeight = window.innerHeight - $('#navbar').outerHeight(true) - $('.filter-wrap').outerHeight(true) - $('.wh_titer').outerHeight(true); 
	
	tableHeight = parseFloat(tableHeight);
	surplusHeight = parseFloat(surplusHeight);
	
	if(tableHeight >= surplusHeight){
		$('body').css({'overflow':'hidden'});
		$('.table-inner').height(surplusHeight).css({'overflow-y':'scroll','overflow-x':'hidden','position':'relative'});
		$('.table-inner').css({'padding-bottom':tfootHeight});
		
		var scrollbarWidth = $('.table-outer')[0].offsetWidth - $('.table-outer')[0].scrollWidth;
		scrollbarWidth = scrollbarWidth > 0 ? scrollbarWidth : 0;
		
		$('tfoot').addClass('true').css({'width':tableWidth-scrollbarWidth});
	}
	
});
