jQuery(function($){
	
	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});
	var wait = 60;
	
	function setTime(o) {
		if (wait == 0) {
			o.removeAttribute("disabled");
			o.value = "获取验证码";
			wait = 60;
		} else {
			o.setAttribute("disabled", true);
			o.value = "重新发送(" + wait + ")";
			wait--;
			setTimeout(function() {
					setTime(o)
				},
				1000)
		}
	};
	
	$('.getCode').on('click',function(){ //获取验证码
		setTime(this)
	});
	
});
