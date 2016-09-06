jQuery(function($) {

	$('#submit').on('click', function() { //保存编辑
		
		//提交代码
		
		if(check()){ //保存成功
			adPosForm(); 
		}
	});

	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});
	
	
	//店铺类型 
	loadCommonMsg("sScopeType-area-menu","ScopeType");  //加载下接
	var sScopeType_u = $("#sScopeType").val();   //编辑时展示
	if(sScopeType_u !=''){
		$("#sScopeType-area-btn").find("span").eq(0).text(sScopeType_u);
	}
	 $("#sScopeType-area-menu li").click(function(){  //选择
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sScopeType-area-btn").find("span").eq(0).text(litext);
		 $("#sScopeTypeID").val(livalue);
		 $("#sScopeType").val(litext);
	 });

	//广告位类型 
	loadCommonMsg("sApSaleType-area-menu","sApSaleType");  //加载下接
	var sApSaleType_u = $("#sApSaleType").val();   //编辑时展示
	if(sApSaleType_u !=''){
		$("#sApSaleType-area-btn").find("span").eq(0).text(sApSaleType_u);
	}
	 $("#sApSaleType-area-menu li").click(function(){  //选择
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sApSaleType-area-btn").find("span").eq(0).text(litext);
		 $("#sApSaleTypeID").val(livalue);
		 $("#sApSaleType").val(litext);
	 });
	 
	//广告位类型
	 loadCommonMsg("sApType-area-menu","sApType");
	 var sApType_u = $("#sApType").val();
	 if(sApType_u != ''){
		 $("#sApType-area-btn").find("span").eq(0).text(sApType_u);
	 }
	 
	 $("#sApType-area-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sApType-area-btn").find("span").eq(0).text(litext);
		 $("#sApType").val(litext);
		 $("#sApTypeID").val(livalue);
		 if(livalue == 'text'){
			 $("#sApText-text-id").show();  
		 }else{
			 $("#sApText-text-id").hide();
			 $("#sApText").val("");
			 $("#sApTypeID").val();
		 }
	 });
	 
	//区域
 	 loadTOrgsAndAll("sZoneCode-area-menu","4","loadAll");
	 var sZoneCode_u = $("#sZoneCode").val(); 
	 if(sZoneCode_u !=''){
		 $("#sZoneCode-area-btn").find("span").eq(0).text(sZoneCode_u);
	 }
	 $("#sZoneCode-area-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sZoneCode-area-btn").find("span").eq(0).text(litext);
		 $("#sZoneCode").val(litext);
		 $("#sZoneCodeID").val(livalue);
	 });
	 
	//展示方式
	 //loadCommonMsg("sApShowType-area-menu","AdShowType");
	 var sApShowType_u = $("#sApShowType").val();
	 if(sApShowType_u !=''){
		 $("#sApShowType-area-btn").find("span").eq(0).text(sApShowType_u);
	 }
	 $("#sApShowType-area-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sApShowType-area-btn").find("span").eq(0).text(litext);
		 $("#sApShowTypeID").val(livalue);
		 $("#sApShowType").val(litext);
	 });
	 
	/*//系统类型    不需要界面添加
	 var sApSysType_u = $("#sApSysType").val();
	 if(sApSysType_u !=''){
		 $("#sApSysType-salesman-type").find("span").eq(0).text(sApSysType_u);
	 }
	 $("#sApSysType-salesman-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sApSysType-salesman-type").find("span").eq(0).text(litext);
		 $("#sApSysTypeID").val(livalue);
		 $("#sApSysType").val(litext);
	 });
	 
	//是否启用
	// loadCommonMsg("sApStatus-royalty-menu","ApStatus");
	 var sApStatus_u = $("#sApStatus").val();
	 if(sApStatus_u !=''){
		 $("#sApStatus-royalty-way").find("span").eq(0).text(sApStatus_u);
	 }
	 $("#sApStatus-royalty-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sApStatus-royalty-way").find("span").eq(0).text(litext);
		 $("#sApStatusID").val(livalue);
		 $("#sApStatus").val(litext);
	 });*/
	 
	 
	 $("#cancel").click(function(){
			window.location.href="list";
	});
	  
});
 

function check(){ 
	if($("#sApTitle").val()==""){    
		Ego.error("请填写广告位名称",null);
		$("#sApTitle").focus();
		return false;
	}
	if($("#sApTitle").val().length > 30){
		Ego.error("广告位名称长度不能超过30个字",null);
		$("#sApTitle").focus();
		return false;
	} 
	if($("#sApContent").val()==""){  
		Ego.error("请填写广告位简介",null);
		$("#sApContent").focus();
		return false;
	}
	if($("#nApPrice").val()==""){ 
		Ego.error("请填写广告位价格",null);
		$("#nApPrice").focus();
		return false;
	}
	if($("#sScopeTypeID").val()==""){ 
		Ego.error("请选择店铺类型",null);
		$("#sScopeTypeID").focus();
		return false;
	}
	if(isNaN($("#nApPrice").val())){  
		Ego.error("广告位价格填写错误",null);
		$("#nApPrice").focus();
		return false;
	}
	if($("#nApWidth").val()==""){  
		Ego.error("请填写广告位宽度",null);
		$("#nApWidth").focus();
		return false;
	} 
	if(isNaN($("#nApWidth").val())){  
		Ego.error("广告位宽度填写错误",null);
		$("#nApWidth").focus();
		return false;
	}
	
	if($("#nApHeight").val()==""){ 
		Ego.error("请填写广告位高度",null);
		$("#nApHeight").focus();
		return false;
	}
	if(isNaN($("#nApHeight").val())){ 
		Ego.error("广告位高度填写错误",null);
		$("#nApHeight").focus();
		return false;
	}
	if($("#sApSaleType").val()==''){ 
		Ego.error("请选择广告位类型",null);
		$("#sApSaleType").focus();
		return false;
	}
	
	if($("#sApType").val()==''){ 
		Ego.error("请选择广告位类别",null);
		$("#sApType").focus();
		return false;
	} 
	
	if($("#sZoneCode").val()==''){ 
		Ego.error("请选择区域",null);
		$("#sZoneCode").focus();
		return false;
	}
	if($("#nApShowType").val()==''){ 
		Ego.error("请选择展示方式",null);
		$("#nApShowType").focus();
		return false;
	} 
	
	if($("#sApType").val()=='text'){
		if($("#sApText").val()==''){ 
			Ego.error("请填写广告位默认内容",null);
			$("#sApType").focus();
			return false;
		} 
	}
	return true;
}


function adPosForm(){	
	var formData = $('#adPosFrom').serializeObject1();   
 	var filePath = $('#sApPathUrl')[0].files[0];  
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
        	Ego.error("系统异常,请刷新后重试.",null);
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")");
        	var isValid = dataResult.IsValid;
        	var returnValue = dataResult.ReturnValue 
        	if(isValid){
        		Ego.success(returnValue,function(){
        			window.location.href = webHost + '/media/mediaPos/list';
        		}); 
        	}else{  
        		Ego.error(returnValue,null);
        	}
        }
    }); 
}
