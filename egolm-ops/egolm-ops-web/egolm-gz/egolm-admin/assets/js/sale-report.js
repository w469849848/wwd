jQuery(function(){
	
	//日期控件
	$('#report-start').datetimepicker({
      	format:'Y/m/d H:i',      //格式化日期
      	timepicker:true,    //开启时间选项
      	yearStart:2000,     //设置最小年份
     	yearEnd:2050,        //设置最大年份
      	todayButton:false    //关闭选择今天按钮
	});
	
	$('#report-end').datetimepicker({
      	format:'Y/m/d H:i',     //格式化日期
      	timepicker:true,    //开启时间选项
      	yearStart:2000,     //设置最小年份
     	yearEnd:2050,        //设置最大年份
      	todayButton:false    //关闭选择今天按钮
	});
	
	$.datetimepicker.setLocale('ch'); //日期插件设置为中文
	
	
	
	//表格单元格宽度均分
	var $td = $('.table-box table tbody tr td');
	$td.css({'width': 100/$td.length + '%'});
	
	
});