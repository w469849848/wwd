jQuery(function($) {
	
	
	//版本类型
	 loadCommonMsg("sAppType-menu","AppType");
	 
	 var sAppTypeID_u = $("#sAppTypeID").val();
	 if(sAppTypeID_u != ''){
		 var sAppType_u = $("#sAppType").val();
		 $("#sAppType-id").find("span").eq(0).text(sAppType_u); 
	 }
	 
	 $("#sAppType-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sAppType-id").find("span").eq(0).text(litext);
		 $("#sAppType").val(litext);
		 $("#sAppTypeID").val(livalue); 
	 });
	 
	 $("#submit").on('click',function(){
		  
		 if(check()){ 
			 appVersionFromSubmmit();
		 }
	 });
	 
	 $("#cancel").on('click',function(){
		 window.location.href="list";
	 });
	 
	 $("#sAppUrl").change(function(){ 
		 $('#fileId').html($("#sAppUrl").val());
	 });
	 
});

function appVersionFromSubmmit(){
	$index = layer.load(0, {shade: [0.2, '#393D49']}); 
	 
	
 	var formData = $('#appVersionFrom').serializeObject1();   
 	var filePath = $('#sAppUrl')[0].files[0];   
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
        	layer.close($index);   
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")"); 
        	var isValid = dataResult.IsValid;
        	var returnValue = dataResult.ReturnValue 
        	if(isValid){
        		 Ego.success(returnValue,function(){
        			 layer.close($index);   
        			window.location.href = webHost + '/system/appVersion/list';
        		 });  
        	}else{
        		layer.close($index);   
        		Ego.error(returnValue,null);
        	}
        }
    }); 
}


function check(){
	var sAppName = $("#sAppName").val(); 
	if(Trim(sAppName) == ''){
		Ego.error("请填写应用名称",null);
		$("#sAppName").focus();
 		return false;
	}
	
	var sAppVersion = $("#sAppVersion").val(); 
	if(Trim(sAppVersion) == ''){
		Ego.error("请填写版本号",null);
		$("#sAppVersion").focus();
 		return false;
	}
	
	
	var sAppTypeID = $("#sAppTypeID").val(); 
	if(sAppTypeID == ''){
		Ego.error("请选择版本类型",null);
		$("#sAppTypeID").focus(); 
		return false;
	}
	var nID = $("#nID").val();
	
	if(nID == ''){
		var sAppUrl = $("#sAppUrl").val();
	 	if(sAppUrl == ''){
			Ego.error("请选择要上传的版本附件",null);
			$("#sAppUrl").focus();
			return false;
		}
		
		var ldot = sAppUrl.lastIndexOf(".");
		var type = sAppUrl.substring(ldot + 1);
		 
		if(type !="apk"){
			Ego.error("上传文件类型不合法,只能是apk类型！",null);
			$("#sAppUrl").focus();
			return false;
		}
	}
	
	return true;
}