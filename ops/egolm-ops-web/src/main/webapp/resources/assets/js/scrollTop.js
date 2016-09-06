jQuery(function(){
	
	//置顶
	$('.btn-top').on('click',function(){
		$('html,body').animate({'scrollTop':'0px'},300);
	});
	
	if( $('.to-top').length > 0){
		//悬浮导航条
		var pageWidth = 1210, //主页面宽度
			left = pageWidth + ($(document).width() - pageWidth)/2 + 14, //浮动导航离左边的距离
			scrollHeight = $(this).scrollTop(); //滚动条滚过的高度
		
		if( scrollHeight > 800){
			$('.to-top').show();
		}
		$('.to-top').css({'left':left+'px'});
		
		$(window).resize(function(){ //监听尺寸变化
			left = pageWidth + ($(document).width() - pageWidth)/2 + 14;
			$('.to-top').css({'left':left+'px'});
		});
		
		$(document).scroll(function(){
			scrollHeight = $(this).scrollTop();
			if( scrollHeight > 600 ){
				$('.to-top').show();
			}else{
				$('.to-top').hide();
			}
		});
	}
	
});