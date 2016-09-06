$(document).ready(function(){
	$('#submitForm').on('click', function() { //查询
		//提交代码
		if(checkQuery()){ //保存成功
			$("#goodsPriceLevelBatchForm").submit();
		}
	});
	
	$('#applyForm').on('click', function() { //查询
		//提交代码
		if(checkApplyQuery()){ //保存成功
			applyBatchFrom();
		}
	});
	
	var showDetail = $("input[name='showDetail']").val();
	if(showDetail=="true"){
		$(".queryInfo").show();
	}
	
	
	var constractNO = $("#constractNO").val();
	
	if(constractNO != ""){
		baseLevelContent(constractNO);
	}
	
	$("#constract-menu li").click(function(){
		var litext = $(this).find("a").text();
		var livalue =  $(this).find("a").attr("id");  
		$("#sConstractSpan").text(litext);
		$("#constractNO").val(livalue);
		if(livalue != ""){
			baseLevelContent(livalue);
		}else{
			$("#shopLevelSpan").text("全部");
			$("#shopLevel").val("");
		}
	});
	
	$("#scope-menu li").click(function(){
		var litext = $(this).find("a").text();
		var livalue =  $(this).find("a").attr("id");  
		$("#scopeSpan").text(litext);
		$("#scope").val(livalue);
	});
});

function baseLevelContent(constractNO){
	var formData = new FormData();  
	formData.append("constractNO",constractNO);
 	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'baseLevelJsonByConstract',
        data: formData,  
        async: false,
        error: function(request,errorThrown) {
            alert("Connection error"); 
        },
        success: function(data) {
        	var dataResult = JSON.parse(data); 
        	var isValid = dataResult.IsValid;
        	if(isValid){
        		var levelList = dataResult.DataList;
        		var levelHtml = "<li value=''><a id='' name='请选择' >请选择</a></li>";
        		var shopLevel = $("#nLevel").val();
	       		for(var i = 0 ; i < levelList.length; i++){
	       			levelHtml += "<li><a id='"+levelList[i].nLevel+"' name='"+levelList[i].nLevel+"' >"+levelList[i].sLevelName+"</a></li>";
	       			if(shopLevel == levelList[i].nLevel){
	       				$("#sLevelSpan").text(levelList[i].sLevelName);
	       			}
	       		}
	       		$("#level-menu").html(levelHtml);
	       	}
        },
        complete : function(XMLHttpRequest, status){
        	$("#level-menu li").click(function(){
        		var litext = $(this).find("a").text();
        		var livalue =  $(this).find("a").attr("id");  
        		$("#sLevelSpan").text(litext);
        		$("#nLevel").val(livalue);
        	});
        }
    }); 
}

function applyBatchFrom(){ 
 	var formData = $('#applyBatchFrom').serializeObject1();   
 	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'goodsPriceLevelBatchSave',
        data: formData,  
        async: false,
        error: function(request,errorThrown) {
            alert("Connection error"); 
        },
        success: function(data) {
        	console.log(data);
        	var dataResult = JSON.parse(data); 
        	var isValid = dataResult.IsValid;
        	var returnValue = dataResult.ReturnValue;
        	if(isValid){
	       		 Ego.success(returnValue,function(){
	       			$(".queryInfo").show();
	       		 });  
	       	}else{
	       		Ego.error(returnValue,null);
	       	}
        }
    }); 
}

function checkQuery(){
	if($("#constractNO").val()==""){
		Ego.error("请选择合同编号",null);
		$("#constractNO").focus();
		return false;
	} 
	if($("#nLevel").val()==""){
		Ego.error("请选择等级",null);
		$("#nLevel").focus();
		return false;
	} 
	return true;
}


function checkApplyQuery(){
	if($("input[name='disRate']").val()==""){
		Ego.error("请填写折扣率",null);
		$("input[name='disRate']").focus();
		return false;
	}else{
		if(isNaN($("input[name='disRate']").val())){
			Ego.error("请填写有效的折扣率",null);
			$("input[name='disRate']").focus();
			return false;
		}
	}
	if($("#scope").val()==""){
		Ego.error("请选择范围",null);
		$("#scope").focus();
		return false;
	} 
	return true;
}
