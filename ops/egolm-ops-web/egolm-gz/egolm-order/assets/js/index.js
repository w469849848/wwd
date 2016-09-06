jQuery(function($){
	
	
	//商品分类
	$(document).on('mouseover','.sort-wrap-top',function(){
		$(this).find('.sort').show();
	});
	$(document).on('mouseleave','.sort-wrap-top',function(){
		$(this).find('.sort').hide();
	});
	var scrollHeight = $(this).scrollTop();
	if( scrollHeight > 0 ){
		$('.sort-wrap').addClass('sort-wrap-top').find('.sort').hide();
	}else{
		$('.sort-wrap').removeClass('sort-wrap-top').find('.sort').show();
	}
	$(document).scroll(function(){
		scrollHeight = $(this).scrollTop();
		if( scrollHeight > 0 ){
			$('.sort-wrap').addClass('sort-wrap-top').find('.sort').hide();
		}else{
			$('.sort-wrap').removeClass('sort-wrap-top').find('.sort').show();
		}
	});
	
	
	//轮播组件初始化
	$('.slideBox').slide({
		mainCell:'.bd ul',
		autoPlay:true,
		interTime:3500,
		delayTime:1500
	});
	
	//推荐商品点击切换效果
	$('.activity-nav li').on('click',function(){
		var $this = $(this),
			idx = $this.index(),
			$item = $this.parents('.activity:first').find('.activity-item ul');
		
		$this.addClass('active').siblings().removeClass('active');
		
		$item.hide();
		$item.eq(idx).show();

	});
	
	//楼层分类切换
	$('.f-nav .nav-bar-wrap li').on('click',function(){
		var $this = $(this),
			idx = $this.index(),
			$sort = $this.parents('.floor:first').find('.fes-sort-wrap .fes-sort');
		
		$this.siblings().find('a').removeClass('active');
		$this.find('a').addClass('active');
		
		$sort.hide();
		$sort.eq(idx).show();
		
		$this.parents('ul:first').find('li i.spacer').css({'display':'block'});
		$this.parents('ul:first').find('li').eq(idx-1).find('i.spacer').css({'display':'none'})
	});
	
	
	//悬浮导航条
	var pageWidth = 1210, //主页面宽度
		left = pageWidth + ($(document).width() - pageWidth)/2 + 14, //浮动导航离左边的距离
		scrollHeight = $(this).scrollTop(); //滚动条滚过的高度
	
	if( scrollHeight > 600){
		$('.elevator').show();
	}
	
	$('.elevator').css({'left':left+'px'});
	
	if( (($(document).width() - pageWidth)/2) <= 134 ){
			$('span.qr-hover').css({'left':'-80px'});
		}
	
	$(window).resize(function(){ //监听尺寸变化
		left = pageWidth + ($(document).width() - pageWidth)/2 + 14;
		$('.elevator').css({'left':left+'px'});
		if( (($(document).width() - pageWidth)/2) <= 134 ){
			$('span.qr-hover').css({'left':'-80px'});
		}
	});
	
	$(document).scroll(function(){
		scrollHeight = $(this).scrollTop();
		if( scrollHeight > 600 ){
			$('.elevator').show();
		}else{
			$('.elevator').hide();
		}
	});
	
	
	//右侧悬浮导航
	$('.elevator li a').hover(function(){
		$(this).find('span').css({'display':'block'});
	},function(){
		$(this).find('span').css({'display':'none'});
	});
	
	//锚点平滑过渡
	var $floor = $('.floor');	
	$('.elevator li a').on('click',function(){
		var data = $(this).data('floor');
		if(data){
			$floor.each(function(index){
				var $this = $(this);
					fData = $this.data('floor');
				if(fData === data){
					$("html, body").animate({
			            scrollTop: $this.offset().top - 187 + "px"
			        }, {
			            duration: 1000,
			            easing: "swing"  
			        });
					return false;
				}
			});
		}
	});
	

});



function generatorSlide(id){
		var nodes = $("#"+id).find("li");
		if(nodes.size()==1){
			$("#"+id).html(nodes[0].outerHTML);
		}else if(nodes.size()>1){
			var content="";
			var button="";
			for(var i=0;i<nodes.size();i++){
				content=content+nodes[i].outerHTML;
				button=button+'<li><a href="javascript:void(0)"></a></li>';
			}

			var slideHtml = '<div class="slideItem" style="position: relative; width:100%;height:100%;overflow:hidden;">'
						+'<div class="bd">'
							+'<ul>'+content+'</ul>'
						+'</div>'
						+'<div class="hd">'
							+'<ul>'+button+'</ul>'
						+'</div>'
						+'<a class="prev" href="javascript:void(0)"><img src="assets/images/banner-dr-l.png"/></a>'
						+'<a class="next" href="javascript:void(0)"><img src="assets/images/banner-dr-r.png"/></a>'
					+'</div>';
			$("#"+id).html(slideHtml);
		}
}

