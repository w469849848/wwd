jQuery(function($){
	
	//商品分类
	$('.sort-wrap').hover(function(){
		$(this).find('.sort').show();
	},function(){
		$(this).find('.sort').hide();
	});
	
	//单选组--选择地址
	$(".consignee-info input.radio").on('click',function(){
		var $this = $(this);
		$("input[name=address]").attr('checked',false);
		$(this).attr('checked',true);
		
	});
	
	//单选组--支付方式
	$(".pay-info input.radio").on('click',function(){
		var $this = $(this);
		$("input[name=pay]").attr('checked',false);
		$(this).attr('checked',true);
		
	});
	
	//多选组点击
	$('.alert-box input.chk').on('click',function(){
		var $this = $(this);
			chk = $this.attr('checked');
			
		if(!!chk){
			$this.attr('checked',false);
		}else{
			$this.attr('checked',true);
		}
		
	});
	
	//新增地址
	$('.btn-add-addr a').on('click',function(){
		$('.add-address').fadeIn();
	});
	
	$('.add-address .btn-close').on('click',function(){
		$('.add-address').fadeOut();
	});
	
	//修改地址
	$('.btn-edit a').on('click',function(){
		$('.edit-address').fadeIn();
	});
	
	$('.edit-address .btn-close').on('click',function(){
		$('.edit-address').fadeOut();
	});
	
	
	//提交订单
	$('.check-out .btn-submit').on('click',function(){
		window.location.href = 'checkout-success.html';
	});
	
});