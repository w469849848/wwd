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
							'background': '#fbfbfb'
						});
					}
				});
			}
			if (message == 'footable_row_expanded' || message == 'footable_row_collapsed') {
				$bgRow.each(function(index) {
					if (index % 2 == 1) {
						$(this).css({
							'background': '#fbfbfb'
						});
					}
				});
			}
		}
	});
	
	$('#submit').on('click', function() { //保存编辑 
		//提交表单 
		if(check()){ //保存成功 
			 activityForm();
		} 
	});
	$("#cancel").on('click',function(){ //取消
		window.location.href = webHost + '/tmpPromo/list';
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
	$('#dTmpPromoBeginDate').datetimepicker({
      	format:'Y-m-d H:i:s',      //格式化日期
      	timepicker:true,    //开启时间选项
      	yearStart:2000,     //设置最小年份
     	yearEnd:2050,        //设置最大年份
      	todayButton:false    //关闭选择今天按钮
	});
	
	$('#dTmpPromoEndDate').datetimepicker({
	   	format:'Y-m-d H:i:s',      //格式化日期
      	timepicker:true,    //开启时间选项
      	yearStart:2000,     //设置最小年份
     	yearEnd:2050,        //设置最大年份
      	todayButton:false    //关闭选择今天按钮
	});
	
	$('#dTmpPromoSmsBeginTime').datetimepicker({
	   	format:'Y-m-d H:i:s',      //格式化日期
      	timepicker:true,    //开启时间选项
      	yearStart:2000,     //设置最小年份
     	yearEnd:2050,        //设置最大年份
      	todayButton:false    //关闭选择今天按钮
	});
	
	$('#dTmpPromoSmsEndTime').datetimepicker({
	   	format:'Y-m-d H:i:s',      //格式化日期
      	timepicker:true,    //开启时间选项
      	yearStart:2000,     //设置最小年份
     	yearEnd:2050,        //设置最大年份
      	todayButton:false    //关闭选择今天按钮
	});
	
	$('#dTmpPromoNoticeBeginTime').datetimepicker({
	   	format:'Y-m-d H:i:s',      //格式化日期
      	timepicker:true,    //开启时间选项
      	yearStart:2000,     //设置最小年份
     	yearEnd:2050,        //设置最大年份
      	todayButton:false    //关闭选择今天按钮
	});
	
	$('#dTmpPromoNoticeEndTime').datetimepicker({
	   	format:'Y-m-d H:i:s',      //格式化日期
      	timepicker:true,    //开启时间选项
      	yearStart:2000,     //设置最小年份
     	yearEnd:2050,        //设置最大年份
      	todayButton:false    //关闭选择今天按钮
	}); 
	$.datetimepicker.setLocale('ch'); //日期插件设置为中文
	
	//活动
	 loadCommonMsg("tmp-promo-type-memu","PromoAType");
	 $("#tmp-promo-type-memu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#tmp-promo-type-id").find("span").eq(0).text(litext);
		 $("#sTmpPromoActionTypeID").val(livalue);
		 $("#sTmpPromoActionType").val(litext); 
	 });

	 //区域
	 loadTOrgs("tmp-zone-memu","4");
	 $("#tmp-zone-memu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#tmp-zone-id").find("span").eq(0).text(litext);
		 $("#sZoneCode").val(livalue);
		 $("#sZoneName").val(litext); 
	 });

});

function check(){
	if($("#dTmpPromoBeginDate").val()==''){ 
		Ego.error("请选择活动开始时间",null);
		$("#dTmpPromoBeginDate").focus();
		return false;
	}
	if($("#dTmpPromoEndDate").val()==''){ 
		Ego.error("请选择活动结束时间",null);
		$("#dTmpPromoEndDate").focus();
		return false;
	}
	if($("#dTmpPromoBeginDate").val() > $("#dTmpPromoEndDate").val()){ 
		Ego.error("活动开始时间不能大于活动结束时间",null);
 		return false;
	}
	
	
	if($("#dTmpPromoSmsBeginTime").val()==''){  
		Ego.error("请选择短信开始时间",null);
		$("#dTmpPromoSmsBeginTime").focus();
		return false;
	}
	if($("#dTmpPromoSmsEndTime").val()==''){ 
		Ego.error("请选择短信结束时间",null);
		$("#dTmpPromoSmsEndTime").focus();
		return false;
	}
	
	if($("#dTmpPromoSmsBeginTime").val() > $("#dTmpPromoSmsEndTime").val()){ 
		Ego.error("短信开始时间不能大于短信结束时间",null);
 		return false;
	}
	
	if($("#dTmpPromoNoticeBeginTime").val()==''){ 
		Ego.error("请选择公告开始时间",null);
		$("#dTmpPromoNoticeBeginTime").focus();
		return false;
	}
	if($("#dTmpPromoNoticeEndTime").val()==''){ 
		Ego.error("请选择公告结束时间",null);
		$("#dTmpPromoNoticeEndTime").focus();
		return false;
	}
	
	if($("#dTmpPromoNoticeBeginTime").val() > $("#dTmpPromoNoticeEndTime").val()){ 
		Ego.error("公告开始时间不能大于公告结束时间",null);
 		return false;
	}
	
	if($("#sTmpPromoActionTypeID").val()==''){  
		Ego.error("请选择活动类型",null);
		$("#sTmpPromoActionTypeID").focus();
		return false;
	}
	if($("#sZoneCode").val()==''){ 
		Ego.error("请选择活动区域",null);
		$("#sZoneCode").focus();
		return false;
	}
	if($("#sTmpPromoSchedule").val()==''){ 
		Ego.error("请填写活动档期",null);
		$("#sTmpPromoSchedule").focus();
		return false;
	}
	if($("#sTmpPromoTitle").val()==''){ 
		Ego.error("请选择活动标题",null);
		$("#sTmpPromoTitle").focus();
		return false;
	}
	if($("#sTmpPromoSmsMemo").val()==''){ 
		Ego.error("请选择短信内容描述",null);
		$("#sTmpPromoSmsMemo").focus();
		return false;
	}
	if($("#sTmpPromoMemo").val()==''){ 
		Ego.error("请选择活动公告描述",null);
		$("#sTmpPromoMemo").focus();
		return false;
	}
	return true;
}
 

function activityForm(){
	var formData = $('#activityForm').serializeObject1();   
 	var filePath = $('#sTmpPromoAttr')[0].files[0];   
 	 formData.append("filePath",filePath); 
 	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'add',
        data: formData,  
        async: false,
        error: function(request,errorThrown) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")"); 
        	var isValid = dataResult.IsValid;
        	var returnValue = dataResult.ReturnValue;
        	if(isValid){
        		  Ego.success(returnValue,function(){
        			window.location.href = webHost + '/tmpPromo/list';
        		  }); 
        	}else{
        	      Ego.error(returnValue,null);
        	} 
        	
        	 
        }
    }); 
}