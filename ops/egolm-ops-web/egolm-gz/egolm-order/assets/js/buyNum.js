jQuery(function(){
	
	/**
	 *  购买数量加减效果
	 */
	
	//减
	$('.ipt-num .sub').on('click',function(){
		
		var $input = $(this).parents('.ipt-num').find('input'),
			currentVal = parseInt($input.val());
		if(currentVal >= 1){
			$input.val(currentVal-1);
		}
	});
	
	//加
	$('.ipt-num .add').on('click',function(){
		
		var $input = $(this).parents('.ipt-num').find('input'),
			currentVal = parseInt($input.val());
		$input.val(currentVal + 1);
	});
	
	//输入不能为负数
	$('.ipt-num input').on('input',function(){
		
		var $this = $(this),
			currentVal = parseInt($this.val());
		if(currentVal < 0 || isNaN(currentVal)){
			$this.val(0);
		}else{
			$this.val(currentVal);
		}
		
	});
	
});