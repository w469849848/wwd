jQuery(function($) {
	
	//区域
	loadTOrgs("sOrgNO-menu","4");
	
	 var sOrgNO_u = $("#sOrgNO").val();
	 if(sOrgNO_u != ''){  //编辑时
		 var sOrgDesc_u = $("#sOrgDesc").val();
			$("#sOrgNO-id").find("span").eq(0).text(sOrgDesc_u); 
			 
	  }
	
	$("#sOrgNO-menu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sOrgNO-id").find("span").eq(0).text(litext);
		 $("#sOrgNO").val(livalue);
		 $("#sOrgDesc").val(litext);
		  
	 });
	
	/*//店铺类型
	loadCommonMsg("sScopeType-menu","ScopeType");
	
	 var sScopeTypeID_u = $("#sScopeTypeID").val();
	 if(sScopeTypeID_u != ''){  //编辑时
		 var sScopeType_u = $("#sScopeType").val();
			$("#sScopeType-id").find("span").eq(0).text(sScopeType_u); 
			 
	  }
	 
	$("#sScopeType-menu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sScopeType-id").find("span").eq(0).text(litext);
		 $("#sScopeTypeID").val(livalue);
		 $("#sScopeType").val(litext);
		  
	 });*/
	
	//使用范围
	
	 var sDisplayNO_u = $("#sDisplayNO").val();
	 if(sDisplayNO_u != ''){  //编辑时
		 var sDisplayDesc_u = $("#sDisplayDesc").val();
			$("#sDisplayNO-id").find("span").eq(0).text(sDisplayDesc_u); 
			 
	 }
	$("#sDisplayNO-menu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sDisplayNO-id").find("span").eq(0).text(litext);
		 $("#sDisplayNO").val(livalue);
		 $("#sDisplayDesc").val(litext); 
	 });
	
	 $("#cancel").click(function(){
		 window.location.href="list";
	 });
	 
	 $('#submit').on('click', function() { //保存编辑  
		if(check()){ //保存成功 
			promoPicSetFrom();
		}
	});
});


function check(){
	var sOrgNO = $("#sOrgNO").val();
	if(sOrgNO == ''){
		Ego.error("请选择区域",null);
		$("#sOrgNO").focus();
		return false;
	}
	var sDisplayNO = $("#sDisplayNO").val();
	if(sDisplayNO == ''){
		Ego.error("请选择使用范围",null);
		$("#sDisplayNO").focus();
		return false;
	}
	if($("#nId").val() ==''){
		var sBackgroundPicUrl = $("#sBackgroundPicUrl").val();
		if(sBackgroundPicUrl == ''){
			Ego.error("请选择背景图片",null);
			$("#sBackgroundPicUrl").focus();
			return false;
		}
	}
	
	var sBackgroundColour = $("#sBackgroundColour").val();
	if(sBackgroundColour == ''){
		Ego.error("请选择背景颜色",null);
		$("#sBackgroundColour").focus();
		return false;
	}
	return true;
}

function promoPicSetFrom(){ 
	var layerindex = layer.load(0, {shade: [0.2, '#393D49']});  
 	var formData = $('#promoPicSetFrom').serializeObject1();   
 	var filePath = $('#sBackgroundPicUrl')[0].files[0];   
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
        	var returnValue = dataResult.ReturnValue 
        	if(isValid){
        		layer.close(layerindex);
        		 Ego.success(returnValue,function(){
        			window.location.href = webHost + '/promoPicSet/list';
        		 });  
        	}else{
        		layer.close(layerindex);
        		Ego.error(returnValue,null);
        	}
        }
    }); 
}