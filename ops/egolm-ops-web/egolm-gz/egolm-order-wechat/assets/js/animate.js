/*
 * @内页加入购物车效果
 * @和首页加入购物车的效果不一样
 */
var Animate = (function(c) {
	
	c.addCart = function(thisElem){
		
		//显示购物车数量提示
		if($('#cart-tips').length <= 0){
			var html = '<div id="cart-tips" class="cart-tips"><span class="num f-a">1</span></div>';
			$('body').append(html);
		}else{
			$('#cart-tips').show();
		}
		
		//插入购物车动画元素
		var $pic = $(thisElem),
			imgSrc = $pic.find('img').attr('src'),
			$animateElem = '<div class="tips-animate position1-two"><img src="'+imgSrc+'" /></div>';
		$pic.find('.tips-animate').remove();
		$pic.append($animateElem);
		
		//动画
		var $animate = $pic.find('.tips-animate'),
			left = $('#cart-tips').offset().left - $animate.offset().left + 5,
			top = $('#cart-tips').offset().top - $animate.offset().top + 5;
		$animate.css({'width': '0.8572rem','height': '0.8572rem','opacity': '0.6','left': left+'px','top': top+'px'});
		setTimeout(function(){
			$animate.remove();
			var num = parseInt($('#cart-tips span.num').text());
			$('#cart-tips span.num').text(num+1);
		},800);
	};
	
	c.addCartIndex = function(thisElem,target){
		var $this = $(thisElem),
			$target = $(target),
			$animateElem = '<div class="animate-elem position1-two"><img src="assets/images/common/add-cart.png" /></div>';
		
		$this.find('.animate-elem').remove();
		$this.append($animateElem);
		
		var $animate = $this.find('.animate-elem'),
			top = $target.offset().top - $this.offset().top,
			left = $target.offset().left - $this.offset().left + $animate.width();
		
		$animate.css({'width': '0.8572rem','height': '0.8572rem','opacity': '0.3','left': left+'px','top': top+'px'});
		setTimeout(function(){
			
			$animate.remove();
			
			//显示购物车里面的数量
			if($target.find('span.num').length <= 0){
				$target.append('<span class="num f-a">1</span>');
			}else{
				var num = parseInt($target.find('span.num').text());
				$target.find('span.num').text(num+1);
			}
			
		},800);
	};
	
	return c;
})(window.Animate || {});
