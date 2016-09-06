$(function(){
	//日期控件
	$('#dCreateTime').datetimepicker({
		format : 'Y-m-d H:i', //格式化日期
		timepicker : true, //开启时间选项
		yearStart : 2000, //设置最小年份
		yearEnd : 2050, //设置最大年份
		todayButton : false
	//关闭选择今天按钮
	});
	//日期控件
	$('#dAuditTime').datetimepicker({
		format : 'Y-m-d H:i', //格式化日期
		timepicker : true, //开启时间选项
		yearStart : 2000, //设置最小年份
		yearEnd : 2050, //设置最大年份
		todayButton : false
	//关闭选择今天按钮
	});
	$.datetimepicker.setLocale('ch'); //日期插件设置为中文
	
	$("#submit").click(function(){
		var sLineId = $("#sLineId").val();
		var sTaskId = $("#sTaskId").val();
		var sTaskName = $("#sTaskName").val();
		var sCreatorId = $("#sCreatorId").val();
		var dCreateTime = $("#dCreateTime").val();
		var sAuditor = $("#sAuditor").val();
		var dAuditTime = $("#dAuditTime").val();
		var sRemark = $("#sRemark").val();
		
		$.ajax({
			url:"updateLine",
			type:"GET",
			dataType:"json",
			data:{
				sLineId:sLineId,
				sTaskId:sTaskId,
				sTaskName:sTaskName,
				sCreatorId:sCreatorId,
				dCreateTime:new Date(dCreateTime),
				sAuditor:sAuditor,
				dAuditTime:new Date(dAuditTime),
				sRemark:sRemark
			},
			success:function(data){
				if(data){
					$('#successAlert').modal('show');  
				}
			}
		});
	});
})