jQuery(function($) {
	
	$('#submit').on('click', function() { //保存编辑
		
		//提交表单
		
		if(true){ //保存成功
			$('#successAlert').modal('show');
		}
		
	});
	
	$('td a.delete').on('click', function(e) { //删除弹窗
		e.stopPropagation();
		footable = $(this).parents('table:first').data('footable');
		$row = $(this).parents('tr:first');
		$('#deleteAlert').modal('show');
	});

	$('#btn-confirm').on('click', function() { //确认删除
		
		//异步代码
		
		if (true) { //删除成功
			$('#deleteAlert').modal('hide');
			footable.removeRow($row);
			footable = null;
			$row = null;
		}
	});
	
	
	
	//日期控件
	$('#active-date1').datetimepicker({
      	format:'Y/m/d H:i',      //格式化日期
      	timepicker:true,    //开启时间选项
      	yearStart:2000,     //设置最小年份
     	yearEnd:2050,        //设置最大年份
      	todayButton:false    //关闭选择今天按钮
	});
	
	$('#active-date2').datetimepicker({
      	format:'Y/m/d H:i',     //格式化日期
      	timepicker:true,    //开启时间选项
      	yearStart:2000,     //设置最小年份
     	yearEnd:2050,        //设置最大年份
      	todayButton:false    //关闭选择今天按钮
	});
	
	$.datetimepicker.setLocale('ch'); //日期插件设置为中文

});