jQuery(function($) {

	$('#submit').on('click', function() { //保存编辑
		
		//提交代码
		
		if(true){ //保存成功
			$('#successAlert').modal('show');
		}
	});

	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});

});