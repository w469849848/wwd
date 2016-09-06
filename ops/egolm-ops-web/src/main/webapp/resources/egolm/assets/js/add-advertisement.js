jQuery(function($) {

	$('#submit').on('click', function() { //保存编辑
		
		//提交代码
		
		if(check()){ //保存成功
			//$('#successAlert').modal('show');
			adVertFrom();
		}
	});

	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});
	
	//广告区域
	 loadTOrgs("sAdZoneCode-area-menu","4");
	 var sAdZoneCode_u = $("#sAdZoneCode").val();
	 if(sAdZoneCode_u != ''){  //编辑时
		$("#sAdZoneCode-area-btn").find("span").eq(0).text(sAdZoneCode_u); 
		 //加载合同
		var sAdZoneCodeID = $("#sAdZoneCodeID").val();
		 loadContractMsg(sAdZoneCodeID);
		 var sContractNO= $("#sContractNO").val();
		 $("#sContractID-area-id").find("span").eq(0).text(sContractNO); 
		 
		  $("#sContractID-area-menu").find("li").each(function(){
			  if($(this).text()==sContractNO){
				 var cNAgentID =  $(this).attr("cNAgentID");
				 $("#nAgentID").val(cNAgentID);
			  }
		 }); 
	 }
	 $("#sAdZoneCode-area-menu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sAdZoneCode-area-btn").find("span").eq(0).text(litext);
		 $("#sAdZoneCodeID").val(livalue);
		 $("#sAdZoneCode").val(litext);
		 
		 //加载合同
		 loadContractMsg(livalue);
		 
		 var sApSaleTypeID = $("#sApSaleTypeID").val();
		 if(sApSaleTypeID != ''){
			 loadApByApSaleType(sApSaleTypeID,livalue);	 
		 }
	 });
	 
	 
	//广告位置 web  app wx 
	 //loadCommonMsg("sApSaleType-area-menu","sApSaleType");
	 
	 var sApSaleType_u = $("#sApSaleType").val();
	 if(sApSaleType_u != ''){  //编辑时会有
		$("#sApSaleType-area-btn").find("span").eq(0).text(sApSaleType_u);
		var sApSaleTypeID_u = $("#sApSaleTypeID").val();
		 var sAdZoneCodeID = $("#sAdZoneCodeID").val(); //区域编号
		loadApByApSaleType(sApSaleTypeID_u,sAdZoneCodeID);
		 $("#ap-place-id").find("span").eq(0).text($("#Aptitle").val());
	 }
	 $("#sApSaleType-area-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sApSaleType-area-btn").find("span").eq(0).text(litext);
		 $("#sApSaleType").val(litext);
		 $("#sApSaleTypeID").val(livalue);
		 
		 var sAdZoneCodeID = $("#sAdZoneCodeID").val(); //区域编号
		 if(sAdZoneCodeID != ''){
			 loadApByApSaleType(livalue,sAdZoneCodeID);	 
		 } 
	 });
	 
	 
	 //广告链接类型
	 var sAdJumpType_u = $("#sAdJumpType").val();
	 if(sAdJumpType_u != ''){ //编辑时
		 $("#ad-jump-type-id").find("span").eq(0).text(sAdJumpType_u);
		 
		 var sAdJumpTypeId = $("#sAdJumpTypeId").val();
		 selectJumpType(sAdJumpTypeId);
		 
		 var sAdJumpNo= $("#sAdJumpNo").val();
		 
		 $("#ad-jump-no-memu").find("li").each(function(){
			  
			 if(Trim($(this).attr("value")) == Trim(sAdJumpNo)){
				 
				 $("#ad-jump-no-id").find("span").eq(0).text($(this).text());
			 }
		 });
	 }
	 
	 $("#ad-jump-type-menu li").click(function(){  //新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#ad-jump-type-id").find("span").eq(0).text(litext);
		 $("#sAdJumpTypeId").val(livalue); 
		 $("#sAdJumpType").val(litext);
		 
		 selectJumpType(livalue);
		 
		 
		 
		 if(livalue=='other'){
			 $("#default-url-id").show();
		 }else{
			 $("#default-url-id").hide();
		 }
	 });
	 
	 
	
	 $("#cancel").click(function(){
			window.location.href="list";
	});
});

// 广告链接类型
function selectJumpType(type){
	if(type == 'goods'){   //选择的为商品
		 $("#default-url-id").hide();
		 var nAgentID  = $("#nAgentID").val();
		 var sAdZoneCodeID =  $("#sAdZoneCodeID").val();
		 
		 if(sAdZoneCodeID == ''){
			 $("#check-msg").text("请选择广告区域")
			 $('#successAlert').modal('show');
			 return;
		 }
		 if(nAgentID == ''){
			 $("#check-msg").text("请选择合同编码")
			 $('#successAlert').modal('show');
			 return;
		 }
		 loadAgentGoods(nAgentID,sAdZoneCodeID); //加载商品
	 }
}

function check(){
	if($("#sAdTitle").val()==''){
		$("#check-msg").text("请填写广告名称")
		$('#successAlert').modal('show');  
		$("#sAdTitle").focus();
		return false;
	}
	
	if($("#nContractID").val()==""){
		$("#check-msg").text("请选择合同编码")
		$('#successAlert').modal('show');  
		$("#nContractID").focus();
		return false;
	}
	if($("#sAdZoneCodeID").val()==""){
		$("#check-msg").text("请选择广告区域")
		$('#successAlert').modal('show');  
		$("#sAdZoneCodeID").focus();
		return false;
	} 
	if($("#sApSaleType").val()==""){
		$("#check-msg").text("请选择广告位置")
		$('#successAlert').modal('show');  
		$("#sApSaleType").focus();
		return false;
	} 
	if($("#nApID").val()==""){
		$("#check-msg").text("请选择广告位")
		$('#successAlert').modal('show');  
		$("#nApID").focus();
		return false;
	} 
	if($("#sAdZoneCode").val()==""){
		$("#check-msg").text("请选择区域");
		$('#successAlert').modal('show');  
		$("#sAdZoneCode").focus();
		return false;
	} 
	return true;
}

//加载广告位
function loadApByApSaleType(sApSaleType,sAdZoneCodeID){
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/advert/adPos/loadMsgByApSaleType?sApSaleTypeID='+sApSaleType+'&sAdZoneCodeID='+sAdZoneCodeID,
        data:'',
        async: false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")");
        	var isValid = dataResult.IsValid;
        	
        	if(isValid){
        		var dataList = dataResult.DataList; 
        		if(dataList.length>0){
        			 $("#ap-place-id").find("span").eq(0).text("请选择");
					 var apMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 apMsg+="<li value='"+data.nApID+"'  pApTypeId='"+data.sApTypeID+"' >"+data.sApTitle+"</li> "; 
					 }
					 $("#ap-place-menu").html(apMsg);
					 //广告位
					 $("#ap-place-menu li").click(function(){
						 var litext = $(this).text(); 
						 var livalue =  $(this).attr("value"); 
						 var pApTypeId= $(this).attr("pApTypeId"); 
 						 $("#ap-place-id").find("span").eq(0).text(litext);
						 $("#nApID").val(livalue);
						 
						 console.log("pApTypeId=="+pApTypeId);
						 if(pApTypeId == 'text'){
							 $("#sAdText-text-id").show(); 
						 }else{
							 $("#sAdText-text-id").hide();
							 $("#sAdText").val("");
						 }
 					 });
				 }else{
					 $("#ap-place-menu").html("");
					 $("#ap-place-id").find("span").eq(0).text("暂无广告位");
				 }
          	}else{
        		var returnValue = dataResult.ReturnValue 
        		$("#check-msg").text(returnValue)
        		$('#successAlert').modal('show');  
        	}
        }
    }); 
}



function adVertFrom(){ 
 	var formData = $('#adVertFrom').serializeObject1();   
 	var filePath = $('#sAdPathUrl')[0].files[0];   
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

//加载合同
function loadContractMsg(sZoneCodeId){ 
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/advert/adContract/listToJson', 
        data:'sOrgNO='+sZoneCodeId,
        dataType: "json",
        async: false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) { 
        	 $("#sContractID-area-id").find("span").eq(0).text("请选择");
        	 var isValid = data.IsValid;
        	 if(isValid){
         		var dataList = data.DataList ; 
         		console.log(dataList);
         		if(dataList.length>0){ 
					 var contractMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 contractMsg+="<li value='"+data.nContractID+"' cNAgentID='"+data.nAgentID+"'>"+data.sContractNO+"</li> "; 
					 }
					 $("#sContractID-area-menu").html(contractMsg); 
					 $("#sContractID-area-menu li").click(function(){
						 var litext = $(this).text();
						 var livalue =  $(this).attr("value"); 
						 var cNAgentID = $(this).attr("cNAgentID"); 
						 $("#sContractID-area-id").find("span").eq(0).text(litext);
						 $("#nContractID").val(livalue); 
						 $("#sContractNO").val(litext);
						 $("#nAgentID").val(cNAgentID);
					 });
				 }else{
					 $("#sContractID-area-id").find("span").eq(0).text("暂无合同");
				 }
         	}else{
         		var returnValue = data.ReturnValue 
         		$("#check-msg").text(returnValue)
         		$('#successAlert').modal('show');  
         	}
        }
    }); 
}

//加载经销商商品类据
function loadAgentGoods(nAgentID,sOrgNO){
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/agentContractGoods/listGoodsByIdAndOrgId', 
        data:'nAgentID='+nAgentID+'&sOrgNO='+sOrgNO,
        dataType: "json",
        async: false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) { 
        	$("#ad-jump-no-id").find("span").eq(0).text('请选择');
        	 var isValid = data.IsValid;
        	 if(isValid){
         		var dataList = data.DataList ; 
         		console.log(dataList);
         		if(dataList.length>0){
					 var goodsMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 goodsMsg+="<li value='"+data.nGoodsID+"'>"+data.sGoodsDesc+"</li> "; 
					 }
					 $("#ad-jump-no-memu").html(goodsMsg); 
					 $("#ad-jump-no-memu li").click(function(){
						 var litext = $(this).text();
						 var livalue =  $(this).attr("value"); 
 						 $("#ad-jump-no-id").find("span").eq(0).text(litext);
						 $("#sAdJumpNo").val(livalue);  
					 });
				 }else{
					 $("#ad-jump-no-id").find("span").eq(0).text('暂无商品');
				 }
         	}else{
         		var returnValue = data.ReturnValue 
         		$("#check-msg").text(returnValue)
         		$('#successAlert').modal('show');  
         	}
        }
    }); 
}
