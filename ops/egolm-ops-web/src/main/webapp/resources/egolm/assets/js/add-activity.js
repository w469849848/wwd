jQuery(function($) {

	$('#submit').on('click', function() { //保存编辑
		
		//提交表单
		
		if(check()){ //保存成功 
			activityForm();
		} 
	});
	
	
	//加载活动类型
	loadCommonMsg("tmp-promo-type-memu","PromoAType");
	 var sTmpPromoActionType_u = $("#sTmpPromoActionType").val();   //编辑时
	 if(sTmpPromoActionType_u !=''){
		 $("#tmp-promo-type-id").find("span").eq(0).text(sTmpPromoActionType_u);
	 }
	 
	$("#tmp-promo-type-memu li").click(function(){  //新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#tmp-promo-type-id").find("span").eq(0).text(litext);
		 $("#sTmpPromoActionType").val(litext);
		 $("#sTmpPromoActionTypeID").val(livalue);
	 });
	
	//加载活动区域
	 loadTOrgs("tmp-zone-memu","4");
	 var sZoneName_u = $("#sZoneName").val(); 
	 if(sZoneName_u !=''){
		 $("#tmp-zone-id").find("span").eq(0).text(sZoneName_u);
	 }
	 $("#tmp-zone-memu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#tmp-zone-id").find("span").eq(0).text(litext);
		 $("#sZoneName").val(litext);
		 $("#sZoneCode").val(livalue);
	 });
});


function check(){
	if($("#dTmpPromoBeginDate").val()==""){ 
		$("#check-msg").text("请填写活动开始时间")
		$('#successAlert').modal('show');  
		$("#dTmpPromoBeginDate").focus();
		return false;
	}
	if($("#dTmpPromoEndDate").val()==""){ 
		$("#check-msg").text("请填写活动结束时间")
		$('#successAlert').modal('show');  
		$("#dTmpPromoEndDate").focus();
		return false;
	}
	
	if($("#dTmpPromoSmsBeginTime").val()==""){ 
		$("#check-msg").text("请填写短信开始时间")
		$('#successAlert').modal('show');  
		$("#dTmpPromoSmsBeginTime").focus();
		return false;
	}
	if($("#dTmpPromoSmsEndTime").val()==""){ 
		$("#check-msg").text("请填写短信结束时间")
		$('#successAlert').modal('show');  
		$("#dTmpPromoSmsEndTime").focus();
		return false;
	}
	
	
	if($("#dTmpPromoNoticeBeginTime").val()==""){ 
		$("#check-msg").text("请填写公告开始时间")
		$('#successAlert').modal('show');  
		$("#dTmpPromoNoticeBeginTime").focus();
		return false;
	}
	
	if($("#dTmpPromoNoticeEndTime").val()==""){ 
		$("#check-msg").text("请填写公告结束时间")
		$('#successAlert').modal('show');  
		$("#dTmpPromoNoticeEndTime").focus();
		return false;
	}
	
	
	if($("#sTmpPromoSchedule").val()==""){ 
		$("#check-msg").text("请填写活动档期")
		$('#successAlert').modal('show');  
		$("#sTmpPromoSchedule").focus();
		return false;
	}
	
	if($("#sTmpPromoTitle").val()==""){ 
		$("#check-msg").text("请填写活动标题")
		$('#successAlert').modal('show');  
		$("#sTmpPromoTitle").focus();
		return false;
	}
	
	if($("#sTmpPromoSmsMemo").val()==""){ 
		$("#check-msg").text("请填写短信内容描述")
		$('#successAlert').modal('show');  
		$("#sTmpPromoSmsMemo").focus();
		return false;
	}
	
	if($("#sTmpPromoMemo").val()==""){ 
		$("#check-msg").text("请填写活动公告描述")
		$('#successAlert').modal('show');  
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
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")");
        	console.log("dataResult="+dataResult);
        	var isValid = dataResult.IsValid;
        	var returnValue = dataResult.ReturnValue 
        	if(isValid){
        		$("#check-msg").text(returnValue)
        		$('#successAlert').modal('show');  
        	}else{
        		$("#check-msg").text(returnValue)
        		$('#successAlert').modal('show');  
        	}
        }
    }); 
}