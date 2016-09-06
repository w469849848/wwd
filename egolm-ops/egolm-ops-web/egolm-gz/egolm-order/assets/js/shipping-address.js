jQuery(function($){
	
	$('.sort-wrap').hover(function(){ //显示隐藏商品分类
		$(this).find('.sort').show();
	},function(){
		$(this).find('.sort').hide();
	});
	
	//单选组--选择地址
	$(".ship-wrap input.radio").on('click',function(){
		var $this = $(this);
		$("input[name=address]").attr('checked',false);
		$(this).attr('checked',true);
		
	});
	
	//设为默认效果
	$('.btn-wrap .btn-default').on('click',function(){
		
		var $this = $(this),
			html = '<div class="icon-default fl">默认地址</div>';
		
		$('.icon-default').remove();
		$this.hide().parents('.btn-wrap:first').before(html)
			.parents('.addr-item:first').siblings().find('.btn-default').show();
		
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
	
	//修改地址
	$('.btn-wrap .btn-edit').on('click',function(){
		$('.edit-address').fadeIn();
	});
	
	//关闭修改地址弹窗
	$('.edit-address .btn-close').on('click',function(){
		$('.edit-address').fadeOut();
	});
	
	
	//新增地址
	$('.btn-add input').on('click',function(){
		$('.edit-address').fadeIn();
	});
	
	//关闭新增地址弹窗
	$('.add-address .btn-close').on('click',function(){
		$('.add-address').fadeOut();
	});
	
	
	//删除地址弹窗
	$('.btn-wrap .btn-delete').on('click',function(){
		$('.delete-address').fadeIn();
		$(this).parents('.addr-item:first').addClass('delete');
	});
	
	//关闭删除地址弹窗
	$('.delete-address .btn-close,.delete-address .btn-cancel').on('click',function(){
		$('.delete-address').fadeOut();
		$('.addr-item').removeClass('delete');
	});
	
	//确定删除
	$('.delete-address .btn-ok').on('click',function(){
		$('.delete-address').fadeOut();
		$('.addr-item.delete').remove();
	});
	
});
