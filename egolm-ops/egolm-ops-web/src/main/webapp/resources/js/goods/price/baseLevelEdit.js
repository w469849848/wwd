$(document).ready(function(){
	$('#submitForm').on('click', function() { //保存编辑
		//提交代码
		if(check()){ //保存成功
			//$('#successAlert').modal('show');
			baseLevelFrom();
		}
	});
});

//经销商下拉框
function getAgentContent(el) {
	var data = eval(el);
	$("#sConstractSpan").text(data.id);
	$("#constractNO").val(data.name);
}

function check(){
	if($("#constractNO").val()==''){
		Ego.error("请选择合同编号",null);
		$("#sConstractSpan").focus();
		return false;
	}
	if($("#sLevelName").val()==""){
		Ego.error("请填写等级名称",null);
		$("#sLevelName").focus();
		return false;
	} 
	if($("#nDisRate").val()==""){
		Ego.error("请填写默认折扣",null);
		$("#nDisRate").focus();
		return false;
	}else{
		if(isNaN($("#nDisRate").val())){
			Ego.error("默认折扣填写错误",null);
			$("#nDisRate").focus();
			return false;
		}
	}
	return true;
}

function baseLevelFrom(){ 
		var nDisRate = $("#nDisRate").val();
		var oldNDisRate =  $("#oldNDisRate").val();
		if((parseFloat(nDisRate)-parseFloat(oldNDisRate)) != 0){
			Ego.alert("默认折扣修改将根据当前折扣重新计算此等级下的所有商品价格，是否确认",function(){  
				submitForm("y");
			}); 
		}else{
			submitForm("n");
		}
}

function submitForm(resetPrice){
	var formData = $('#baseLevelForm').serializeObject1();   
	formData.append("resetPrice",resetPrice);
 	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'baseLevelSave',
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
	       			window.location.href = webHost + '/goods/price/baseLevelList';
	       		 });  
	       	}else{
	       		Ego.error(returnValue,null);
	       	}
        }
    }); 
}
