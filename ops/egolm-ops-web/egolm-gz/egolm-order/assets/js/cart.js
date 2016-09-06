/**
 ** 购物车 
 */

jQuery(function($){
	
	$('.sort-wrap').hover(function(){ //显示隐藏商品分类
		$(this).find('.sort').show();
	},function(){
		$(this).find('.sort').hide();
	});
	
	
	//下单条悬浮
	var isVisible = function(obj) { //元素是否可见
		if ($(obj).offset().top < ($(window).height() + $("body").scrollTop()) && (($(window).height() + $("body").scrollTop()) - $(obj).offset().top) < $(window).height()) {
			return true;
		} else {
			return false;
		}
	}
	
	//初始化
	if( !isVisible($('.bar-posi')) && $('.bar-posi').offset().top > ($(window).height() + $("body").scrollTop()) ){
		$('.btn-bar-wrap').addClass('fixed');
	}
	
	$(document).scroll(function(){ //监听滚动条
		
		if( isVisible($('.bar-posi')) ){
			$('.btn-bar-wrap').removeClass('fixed');
		}else if( $('.bar-posi').offset().top > ($(window).height() + $("body").scrollTop()) ){
			$('.btn-bar-wrap').addClass('fixed');
		}
	});
	
	
	/**
	 * 优惠弹窗
	 */
	$('.btn-coupon').on('click',function(e){ //显示优惠弹窗
		e.stopPropagation();
		$('.coupon-wrap').addClass('click');
		$('.coupon-content').show();
	});
	
	$('.coupon-content').on('click',function(e){ //停止冒泡
		e.stopPropagation();
	});
	
	$(document).on('click',function(){ //点击其他区域关闭优惠弹窗
		$('.coupon-wrap').removeClass('click');
		$('.coupon-content').hide();
	});
	
	$('.btn-cancel').on('click',function(){ //关闭优惠弹窗
		
		$('.coupon-wrap').removeClass('click');
		$('.coupon-content').hide();
		
	});
	
	
	
	
	//单选组radio -- 促销优惠
	$(".coupon-content input.chk-cp").on('click',function(){
		var $this = $(this);
		$("input[name=coupon]").attr('checked',false);
		$(this).attr('checked',true);
		
		$(this).parents('div:first').addClass('checked').siblings().removeClass('checked');
	});
	
	//单选组radio -- 组合优惠
	$(".group-wrap input.chk-cp").on('click',function(){
		var $this = $(this);
		$("input[name=group]").attr('checked',false);
		$(this).attr('checked',true);
		
		$(this).parents('div:first').addClass('checked').siblings().removeClass('checked');
	});
	
	//单选组radio -- 满赠
	$(".reduce input.chk-cp").on('click',function(){
		var $this = $(this);
		$("input[name=reduce]").attr('checked',false);
		$(this).attr('checked',true);
	});
	
	
	//显示满减弹窗
	$('.mz').on('click',function(){
		$('.mz-alert').fadeIn();
	});
	
	//显示组合优惠弹窗
	$('.btn-zh').on('click',function(){
		$('.zh-alert').fadeIn();
	});
	
	//关闭弹窗
	$('.alert-header .btn-close,.alert-footer .btn-cancel').on('click',function(){
		
		$(this).parents('div.alert-box:first').fadeOut();
		
	});
	
	
	//选择优惠
	$('.btn-cp').on('click',function(){
		
		$(this).toggleClass('yh');
		
	});
	
	//加入购物车效果
	$('a.add-cart').on('click',function(){
		
		var $successBox = $(this).parents('li:first').find('.add-cart-success');
		$successBox.show();
		setTimeout(function(){
			$successBox.fadeOut(1000);
		},500);
		
	});
	
	
	/**
	 * 购买数量 
	 */
	
	var $allSum = $('.btn-bar .all-sum');
	
	//减
	$('.ipt-num .sub').on('click',function(){
		
		var $input = $(this).parents('.ipt-num').find('input'),
			$cost = $input.parents('tr:first').find('.b-cost'),
			$sum = $input.parents('tr:first').find('.b-sum'),
			cost = parseInt($cost.text()), //单价
			sum = parseInt($sum.text()), //总价
			allSum = parseInt($allSum.text()),
			currentNum = parseInt($input.val()) - 1;
		
		if(currentNum >= 0){
			$input.val(currentNum);
			$sum.text((cost * currentNum)+'.00');
			
			if(allSum - cost >= 0){
				$allSum.text(allSum - cost + '.00');
			}
		}
	});
	
	//加
	$('.ipt-num .add').on('click',function(){
		
		var $input = $(this).parents('.ipt-num').find('input'),
			$cost = $input.parents('tr:first').find('.b-cost'),
			$sum = $input.parents('tr:first').find('.b-sum'),
			cost = parseInt($cost.text()), //单价
			sum = parseInt($sum.text()), //总价
			allSum = parseInt($allSum.text()), //全部总价
			currentNum = parseInt($input.val()) + 1;
			
		$input.val(currentNum);
		$sum.text((cost * currentNum)+'.00');
		$allSum.text(allSum + cost + '.00');
	});
	
	//输入不能为负数
	$('.ipt-num input').on('input',function(){
		
		var $this = $(this),
			$cost = $this.parents('tr:first').find('.b-cost'),
			$sum = $this.parents('tr:first').find('.b-sum'),
			cost = parseInt($cost.text()), //单价
			sum = parseInt($sum.text()), //总价
			allSum = parseInt($allSum.text()), //全部总价
			currentNum = parseInt($this.val());
		if(currentNum < 0 || isNaN(currentNum)){
			$this.val(0);
		}else{
			$this.val(currentNum);
			$sum.text((cost * currentNum)+'.00');
			$allSum.text((allSum + (cost * currentNum - sum)) + '.00');
		}
		
	});
	
	
});