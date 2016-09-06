jQuery(function($) {
	
	var footable = null,
		$row = null,
		isAll = false, //true为全选，false为未选中
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	$('.activity table').footable({ //响应式表格初始化
		debug: true,
		breakpoints: {
			phone: 600,
			tablet: 800
		},
		log: function(message, type) {
			$bgRow = $table.find('tbody tr').not('.footable-row-detail');
			if (message == 'footable_initialized') {
				$bgRow.each(function(index) {
					if (index % 2 == 1) {
						$(this).css({
							'background': '#f8f8f8'
						});
					}
				});
			}
			if (message == 'footable_row_expanded' || message == 'footable_row_collapsed') {
				$bgRow.each(function(index) {
					if (index % 2 == 1) {
						$(this).css({
							'background': '#f8f8f8'
						});
					}
				});
			}
		}
	});
	
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