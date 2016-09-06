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
	
	$("#submit").click(function(){
		var sTaskName = $("#sTaskName").val();
		var sCreatorId = $("#sCreatorId").val();
		var dCreateTime = $("#dCreateTime").val();
		
		var sAuditor = $("#sAuditor").val();
		var dAuditTime = $("#dAuditTime").val();
		var sRemark = $("#sRemark").val();
		
		if(sTaskName.trim()==""){
			$("#check-msg-warr").text("请填写任务名称！")
			$('#warrAlert').modal('show');  
			$("#sTaskName").focus();
			return false;
		}
		
		if(sCreatorId.trim()==""){
			$("#check-msg-warr").text("请填写创建人！")
			$('#warrAlert').modal('show');  
			$("#sCreatorId").focus();
			return false;
		}
		
		if(dCreateTime.trim()==""){
			$("#check-msg-warr").text("请填写创建时间！")
			$('#warrAlert').modal('show');  
			$("#dCreateTime").focus();
			return false;
		}
		
		if(sAuditor.trim()==""){
			$("#check-msg-warr").text("请填写审核人！")
			$('#warrAlert').modal('show');  
			$("#sAuditor").focus();
			return false;
		}
		
		if(dAuditTime.trim()==""){
			$("#check-msg-warr").text("请填写审核时间！")
			$('#warrAlert').modal('show');  
			$("#dAuditTime").focus();
			return false;
		}
		
		if(sRemark.trim()==""){
			$("#check-msg-warr").text("请填写任务描述！")
			$('#warrAlert').modal('show');  
			$("#sRemark").focus();
			return false;
		}
		
		$.ajax({
			url:"addTask",
			type:"POST",
			dataType:"json",
			data:{
				sTaskName:sTaskName,
				sCreatorId:sCreatorId,
				dCreateTime:new Date(dCreateTime),
				sAuditor:sAuditor,
				dAuditTime:new Date(dAuditTime),
				sRemark:sRemark
			},
			success:function(data){
				console.log("success");
				if(data){
					window.location.href = "taskList";
				}
			},
			error:function(){
				console.log("error");
			}
		});
	});
})