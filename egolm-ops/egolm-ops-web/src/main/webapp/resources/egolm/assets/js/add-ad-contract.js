jQuery(function($) {

	$('#submit').on('click', function() { //保存编辑
		
		//提交代码
		
		if(check()){ //保存成功
			adContractFrom();
		}
	});
 
	//设置合同编号
	 var sContractNO = Math.floor(Math.random()*10000000);
	 $("#sContractNO").val("C"+sContractNO); 
	 
	 
	//税别	 
	 loadCommonMsg("sTaxType-menu","TAXTYPE");  //加载下拉税别
	 $("#sTaxType-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sTaxType-btn").find("span").eq(0).text(litext);
		 $("#sTaxTypeID").val(livalue);
		 $("#sTaxType").val(litext);
		 
	 });
	 
	 //经销商
	 loadAgentMsg();
	 $("#nAgent-memu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#nAgent-id").find("span").eq(0).text(litext);
		 $("#nAgentID").val(livalue); 
	 });
	 
	 //组织机构
	 loadTOrgs("sOrgNO-memu","4");
	 $("#sOrgNO-memu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sOrgNO-id").find("span").eq(0).text(litext);
		 $("#sOrgNO").val(livalue); 
	 });
	 
	 
	 //交易方式
	 loadCommonMsg("sTradeMode-menu","PayType");  //加载下拉列表
	 $("#sTradeMode-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sTradeMode-btn").find("span").eq(0).text(litext);
		 $("#sTradeModeID").val(livalue);
		 $("#sTradeMode").val(litext);
	 });
	 
	 //付款账期
	 loadCommonMsg("sPaytTermID-menu","PAYT");  //加载下拉列表
	 $("#sPaytTermID-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sPaytTermID-btn").find("span").eq(0).text(litext);
		 $("#sPaytTermID").val(livalue);
		 $("#sPaytTerm").val(litext);
	 });
	 
	 //付款方式
	 loadCommonMsg("sPaytModeID-menu","PAYTMODE");  //加载下拉列表
	 $("#sPaytModeID-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sPaytModeID-btn").find("span").eq(0).text(litext);
		 $("#sPaytModeID").val(livalue);
		 $("#sPaytMode").val(litext);
	 });
	 
	 //开户银行
	 loadCommonMsg("sBankID-menu","BANK");  //加载下拉列表
	 $("#sBankID-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sBankID-btn").find("span").eq(0).text(litext);
		 $("#sBank").val(livalue); 
	 });
	  
	 //合同状态
	 loadCommonMsg("nContractTag-menu","STATUS");  //加载下拉列表
	 $("#nContractTag-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#nContractTag-btn").find("span").eq(0).text(litext);
		 $("#nContractTag").val(livalue); 
	 });
});



function check(){
	if($("#sContractNO").val()==""){
		$("#check-msg").text("请填写合同编码")
		$('#successAlert').modal('show');  
		$("#sContractNO").focus();
		return false;
	}
	if($("#sTaxCode").val()==""){
		$("#check-msg").text("请填写税号")
		$('#successAlert').modal('show');  
		$("#sTaxCode").focus();
		return false;
	}
	if($("#nAgentID").val()==""){
		$("#check-msg").text("请选择经销商")
		$('#successAlert').modal('show');  
		$("#nAgentID").focus();
		return false;
	}
	if($("#sOrgNO").val()==""){
		$("#check-msg").text("请选择组织机构")
		$('#successAlert').modal('show');  
		$("#sOrgNO").focus();
		return false;
	}
	if($("#dActiveDate").val()==""){
		$("#check-msg").text("请选择生效日期")
		$('#successAlert').modal('show');  
		$("#dActiveDate").focus();
		return false;
	}
	if($("#dExpireDate").val()==""){
		$("#check-msg").text("请选择失效日期")
		$('#successAlert').modal('show');  
		$("#dExpireDate").focus();
		return false;
	}
	if($("#nTaxRate").val()==""){
		$("#check-msg").text("请填写税率")
		$('#successAlert').modal('show');  
		$("#nTaxRate").focus();
		return false;
	}
	if($("#sTaxTypeID").val()==""){
		$("#check-msg").text("请选择税别")
		$('#successAlert').modal('show');  
		$("#sTaxTypeID").focus();
		return false;
	}
	if($("#sTradeModeID").val()==""){
		$("#check-msg").text("请选择交易方式")
		$('#successAlert').modal('show');  
		$("#sTradeModeID").focus();
		return false;
	}
	if($("#sPaytTermID").val()==""){
		$("#check-msg").text("请选择付款账期")
		$('#successAlert').modal('show');  
		$("#sPaytTermID").focus();
		return false;
	}
	if($("#sPaytModeID").val()==""){
		$("#check-msg").text("请选择付款方式")
		$('#successAlert').modal('show');  
		$("#sPaytModeID").focus();
		return false;
	}
	if($("#sBank").val()==""){
		$("#check-msg").text("请选择开户银行")
		$('#successAlert').modal('show');  
		$("#sBank").focus();
		return false;
	}
	if($("#nContractTag").val()==""){
		$("#check-msg").text("请选择合同状态")
		$('#successAlert').modal('show');  
		$("#nContractTag").focus();
		return false;
	}
	if($("#sBankAccountNO").val()==""){
		$("#check-msg").text("请填写银行账号")
		$('#successAlert').modal('show');  
		$("#sBankAccountNO").focus();
		return false;
	}
	if($("#sBankAccount").val()==""){
		$("#check-msg").text("请填写银行账户")
		$('#successAlert').modal('show');  
		$("#sBankAccount").focus();
		return false;
	}
	if($("#nPaytDay").val()==""){
		$("#check-msg").text("请填写付款天数")
		$('#successAlert').modal('show');  
		$("#nPaytDay").focus();
		return false;
	}
	if($("#sPaytContact").val()==""){
		$("#check-msg").text("请填写付款联系人")
		$('#successAlert').modal('show');  
		$("#sPaytContact").focus();
		return false;
	}
	if($("#sPaytContactTel").val()==""){
		$("#check-msg").text("请填写联系电话")
		$('#successAlert').modal('show');  
		$("#sPaytContactTel").focus();
		return false;
	}
	if($("#sPaytCenterNO").val()==""){
		$("#check-msg").text("请填写付款中心")
		$('#successAlert').modal('show');  
		$("#sPaytCenterNO").focus();
		return false;
	}
	 
	return true;
}

//提交表单
function adContractFrom(){
	var jsonuserinfo = $('#adContractFrom').serializeObject();  
	var result = JSON.stringify(jsonuserinfo); 
	$.ajax({
        cache: false,
        contentType: "application/json; charset=utf-8", 
        type: "POST",
        url:'add',
        data:result,
        dataType: "json",
        async: false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
        	console.log("dataResult="+data);
        	var isValid = data.IsValid;
        	var returnValue = data.ReturnValue 
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


function loadAgentMsg(){
	$.ajax({
        cache: false,
        type: "POST",
        url:basectx+'/dealer/listToJson', 
        dataType: "json",
        async: false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) { 
         	console.log("dataResult="+data);
        	 var isValid = data.IsValid;
        	 if(isValid){
         		var dataList = data.DataList ; 
         		console.log(dataList);
         		if(dataList.length>0){ 
					 var agentMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 agentMsg+="<li value='"+data.nAgentID+"'>"+data.sAgentName+"</li> "; 
					 }
					 $("#nAgent-memu").html(agentMsg); 
				 } 
         	}else{
         		var returnValue = data.ReturnValue 
         		$("#check-msg").text(returnValue)
         		$('#successAlert').modal('show');  
         	}
        }
    }); 
}
