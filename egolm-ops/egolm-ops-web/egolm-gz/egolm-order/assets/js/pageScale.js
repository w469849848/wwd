jQuery(function(){
	if(/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent) || /(Android)/i.test(navigator.userAgent)){
		var scale = document.documentElement.clientWidth/1210;
		$('head').append('<meta name="viewport" content="initial-scale='+scale+',user-scalable=no" />');
	}
});