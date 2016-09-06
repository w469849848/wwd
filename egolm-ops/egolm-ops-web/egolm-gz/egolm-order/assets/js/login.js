jQuery(function($){
	
	
	//登录方式切换
	$('.erweima').on("click", function() {
	 	if ($('.login_hid').hasClass('btn-2qrcode')) {
	 		$('.erweima').css("background", "url(assets/images/erweima_th.png) no-repeat");
	 		$('.login_hid').removeClass('btn-2qrcode').addClass('btn-2login');
	 		$('.login_hid').css("display", "block");
	 		$('.sm_login').css("display", "none");
	 	} else {
	 		$('.erweima').css("background", "url(assets/images/erweima.png) no-repeat");
	 		$('.login_hid').removeClass('btn-2login').addClass('btn-2qrcode');
	 		$('.sm_login').css("display", "block");
	 		$('.login_hid').css("display", "none");
	 	}
	});
	
	//模拟登录过程
	$('.btn-login').on('click',function(){
		
		//隐藏当前登录框
		$(this).parents('.login_content:first').hide();
		
		//显示店铺列表
		$('.select-shop').removeClass('hide');
		
	});
	
	// 进入
	$('.btn-enter').on('click',function(){
		//隐藏当前登录框
		$(this).parents('.login_content:first').hide();
		
		//显示店铺列表
		$('.enter-tips').removeClass('hide');
	});
	
	//多选组点击
	$('.login-input input.chk').on('click',function(){
		var $this = $(this);
			chk = $this.attr('checked');
			
		if(!!chk){
			$this.attr('checked',false);
		}else{
			$this.attr('checked',true);
		}
		
	});
	
	
});