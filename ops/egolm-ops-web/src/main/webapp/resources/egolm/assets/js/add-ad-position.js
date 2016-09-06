jQuery(function($) {

	$('#submit').on('click', function() { //保存编辑
		
		//提交代码
		
		if(check()){ //保存成功
			adPosForm();
			//$('#successAlert').modal('show');
		}
	});

	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
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
	 
	//广告位类型别
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
	 loadTOrgs("sZoneCode-area-menu","4");
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
	 loadCommonMsg("sApShowType-area-menu","AdShowType");
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
	 
	//系统类型
	 loadCommonMsg("sApSysType-salesman-menu","AdSysType");
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
	 loadCommonMsg("sApStatus-royalty-menu","ApStatus");
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
	 });
	 
	 
	 $("#cancel").click(function(){
			window.location.href="list";
	});
	  
});
 

function check(){ 
	if($("#sApTitle").val()==""){ 
		$("#check-msg").text("请填写广告位名称")
		$('#successAlert').modal('show');  
		$("#sApTitle").focus();
		return false;
	}
	if($("#sApContent").val()==""){ 
		$("#check-msg").text("请填写广告位简介")
		$('#successAlert').modal('show');  
		$("#sApContent").focus();
		return false;
	}
	if($("#nApPrice").val()==""){
		$("#check-msg").text("请填写广告位价格")
		$('#successAlert').modal('show'); 
		$("#nApPrice").focus();
		return false;
	}
	if($("#nApWidth").val()==""){
		$("#check-msg").text("请填写广告位宽度")
		$('#successAlert').modal('show');  
		$("#nApWidth").focus();
		return false;
	}
	if($("#nApHeight").val()==""){
		$("#check-msg").text("请填写广告位高度")
		$('#successAlert').modal('show'); 
		$("#nApHeight").focus();
		return false;
	}
	if($("#sApSaleType").val()==''){
		$("#check-msg").text("请选择广告位类型")
		$('#successAlert').modal('show'); 
		$("#sApSaleType").focus();
		return false;
	}
	
	if($("#sApType").val()==''){
		$("#check-msg").text("请选择广告位类别")
		$('#successAlert').modal('show'); 
		$("#sApType").focus();
		return false;
	} 
	
	if($("#sZoneCode").val()==''){
		$("#check-msg").text("请选择区域")
		$('#successAlert').modal('show'); 
		$("#sZoneCode").focus();
		return false;
	}
	if($("#nApShowType").val()==''){
		$("#check-msg").text("请选择展示方式")
		$('#successAlert').modal('show'); 
		$("#nApShowType").focus();
		return false;
	}
	if($("#sApSysType").val()==''){
		$("#check-msg").text("请选择是否为系统广告")
		$('#successAlert').modal('show'); 
		$("#sApSysType").focus();
		return false;
	}
	if($("#nApStatus").val()==''){
		$("#check-msg").text("请选择是否启用")
		$('#successAlert').modal('show'); 
		$("#nApStatus").focus();
		return false;
	}
	
	
	if($("#sApType").val()=='text'){
		if($("#sApText").val()==''){
			$("#check-msg").text("请填写广告位默认内容")
			$('#successAlert').modal('show'); 
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
