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
		var sTemplateName = $("#sTemplateName").val();
		var sCreator = $("#sCreator").val();
		var dCreateTime = $("#dCreateTime").val();
		var sRemark = $("#sRemark").val();
		var sAuditor = $("#sAuditor").val();
		var dAuditTime = $("#dAuditTime").val();
		
		var sTaskType = "";
		var sTaskName = "";
		$("input[type='checkbox']:checked").each(function(index,item){
			if(index == 0){
				sTaskType = $(item).val();
				sTaskName = $(item).next().text();
			}else{
				sTaskType +=","+$(item).val();
				sTaskName +=","+$(item).next().text();
			}
		});
		
		if(sTemplateName.trim()==""){
			$("#check-msg-warr").text("请填写模板名称！")
			$('#warrAlert').modal('show');  
			$("#sTaskName").focus();
			return false;
		}
		
		if(sCreator.trim()==""){
			$("#check-msg-warr").text("请填写创建人！")
			$('#warrAlert').modal('show');  
			$("#sTaskName").focus();
			return false;
		}
		
		if(dCreateTime.trim()==""){
			$("#check-msg-warr").text("请填写创建时间！")
			$('#warrAlert').modal('show');  
			$("#sTaskName").focus();
			return false;
		}
		
		if(sRemark.trim()==""){
			$("#check-msg-warr").text("请填写描述！")
			$('#warrAlert').modal('show');  
			$("#sTaskName").focus();
			return false;
		}
		
		if(sAuditor.trim()==""){
			$("#check-msg-warr").text("请填写审核人！")
			$('#warrAlert').modal('show');  
			$("#sTaskName").focus();
			return false;
		}
		
		if(dAuditTime.trim()==""){
			$("#check-msg-warr").text("请填写审核时间！")
			$('#warrAlert').modal('show');  
			$("#sTaskName").focus();
			return false;
		}
		
		if(sTaskType.trim()==""){
			$("#check-msg-warr").text("请选择任务！")
			$('#warrAlert').modal('show');  
			$("#sTaskName").focus();
			return false;
		}
		
		$.ajax({
			url:"addTemplate",
			type:"POST",
			dataType:"json",
			data:{
				sTemplateName:sTemplateName,
				sCreator:sCreator,
				dCreateTime:new Date(dCreateTime),
				sRemark:sRemark,
				sAuditor:sAuditor,
				dAuditTime:new Date(dAuditTime),
				sTaskType:sTaskType,
				sTaskName:sTaskName
			},
			success:function(data){
				if(data){
					window.location.href = "templateList";
				}
			}
		});
	});
	
	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});
})

function changeChkStatus(selehr){
	$('.batch label').removeClass('checked');
}
