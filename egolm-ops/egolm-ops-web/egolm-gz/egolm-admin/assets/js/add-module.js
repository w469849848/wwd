jQuery(function($) {

	$('#submit').on('click', function() { //保存编辑
		
		//提交代码
		
		if(true){ //保存成功
			$('#successAlert').modal('show');
		}
	});
	
	//单选组radio -- 是否楼层
	$(".floor-wrap input.chk-radio").on('click',function(){
		var $this = $(this);
		$("input[name=floor]").attr('checked',false);
		$(this).attr('checked',true);
	});

});