$(document).ready(function() {
	$('#submit').on('click', function() { //保存编辑 
		//提交表单 
		if (check()) { //保存成功
			dealForm();
		}
	});
	//日期控件
	$('#dActiveDate').datetimepicker({
		format : 'Y/m/d H:i', //格式化日期
		timepicker : true, //开启时间选项
		yearStart : 2000, //设置最小年份
		yearEnd : 2050, //设置最大年份
		todayButton : false
	//关闭选择今天按钮
	});
	//日期控件
	$('#dExpireDate').datetimepicker({
		format : 'Y/m/d H:i', //格式化日期
		timepicker : true, //开启时间选项
		yearStart : 2000, //设置最小年份
		yearEnd : 2050, //设置最大年份
		todayButton : false
	//关闭选择今天按钮
	});
	//日期控件
	$('#dContractDate').datetimepicker({
		format : 'Y/m/d H:i', //格式化日期
		timepicker : true, //开启时间选项
		yearStart : 2000, //设置最小年份
		yearEnd : 2050, //设置最大年份
		todayButton : false
	//关闭选择今天按钮
	});
	$.datetimepicker.setLocale('ch'); //日期插件设置为中文
	//区域
	loadTOrgs("sZoneCode-area-menu", "4");
	$("#sZoneCode-area-menu li").click(function() {//新增时
		var litext = $(this).text();
		var livalue = $(this).attr("value");
		$("#sZoneCode-area-btn").find("span").eq(0).text(litext);
		$("#sOrgNO").val(livalue);
		//$("#sZoneName").val(litext);
	});
	//设置合同编号
	var nContractID = $('#nContractID').val();
	if (nContractID == '') {
		var sContractNO = Math.floor(Math.random() * 10000000);
		$("#sContractNO").val("C" + sContractNO);
	}

	//税别	 
	loadCommonMsg("sTaxType-menu", "TAXTYPE"); //加载下拉税别
	var sTaxType_u = $("#sTaxType").val();
	if (sTaxType_u != '') {
		$("#sTaxType-btn").find("span").eq(0).text(sTaxType_u);
	}
	$("#sTaxType-menu li").click(function() {
		var litext = $(this).text();
		var livalue = $(this).attr("value");
		$("#sTaxType-btn").find("span").eq(0).text(litext);
		$("#sTaxTypeID").val(livalue);
		$("#sTaxType").val(litext);

	});
	 //付款账期
	 loadCommonMsg("sPaytTermID-menu","PAYT");  //加载下拉列表
	 var sPaytTerm_u = $("#sPaytTerm").val();
	 if(sPaytTerm_u !=''){
		 $("#sPaytTermID-btn").find("span").eq(0).text(sPaytTerm_u);
	 }
	 $("#sPaytTermID-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sPaytTermID-btn").find("span").eq(0).text(litext);
		 $("#sPaytTermID").val(livalue);
		 $("#sPaytTerm").val(litext);
	 });
	 
	 //付款方式
	 loadCommonMsg("sPaytModeID-menu","PAYM");  //加载下拉列表
	 var sPaytMode_u = $("#sPaytMode").val();
	 if(sPaytMode_u !=''){
		 $("#sPaytModeID-btn").find("span").eq(0).text(sPaytMode_u);
	 }
	 $("#sPaytModeID-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sPaytModeID-btn").find("span").eq(0).text(litext);
		 $("#sPaytModeID").val(livalue);
		 $("#sPaytMode").val(litext);
	 });
	 //合同类型
	 loadCommonMsg("contract_type_menu","AgentContractType");  //加载下拉列表
	 var sAgentContractType_u = $("#sAgentContractType").val();
	 if(sAgentContractType_u !=''){
		 $("#contract_type").find("span").eq(0).text(sAgentContractType_u);
	 }
	 $("#contract_type_menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#contract_type").find("span").eq(0).text(litext);
		 $("#sAgentContractTypeID").val(livalue);
		 $("#sAgentContractType").val(litext);
	 });
	 
	 //经销商
	/* loadAgentMsg();
	 var nAgentID_u = $("#nAgentID").val();
 	 if(nAgentID_u != ''){
		 $("#agent_menu").find("li").each(function(){
 			  if($(this).attr("value")==nAgentID_u){
				 var nAgentID_text =  $(this).text();
				 $("#agent").find("span").eq(0).text(nAgentID_text); 
			  }
		 }); 
	 }*/
	 
	 $("#agent_menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#agent").find("span").eq(0).text(litext);
		 $("#nAgentID").val(livalue); 
	 });
	 
		$('#cancel').on('click', function(){
			window.location.href = webHost + '/dealer/agentContractList';
		});
		
		$('#agent').bind("click",function(){
			layer.open({
				type : 2,
				title : '选择经销商',
				shadeClose : true,
				shade : 0.6,
				area : [ '70%', '90%' ],
				content : 'toAgentList'
			});
		});
		
	 

});

//选择经销商后，更新所属机构值
function setAgentVal(nAgentID,sAgentNO,sAgentName){
	$('#nAgentID').val(nAgentID);
	$('#agentName').val(sAgentName);
	$('#agent span:first').text(sAgentName);
}
//表单检验
function check() {
	if($("#nAgentID").val()==""){
		$("#check-msg").text("请选择经销商")
		$('#successAlert').modal('show');  
		$("#nAgentID").focus();
		return false;
	}
	if($("#sAgentContractTypeID").val()==""){
		$("#check-msg").text("请选择合同类型")
		$('#successAlert').modal('show');  
		$("#sAgentContractTypeID").focus();
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
	if($("#dContractDate").val()==""){
		$("#check-msg").text("请选择合同时间")
		$('#successAlert').modal('show');  
		$("#dContractDate").focus();
		return false;
	}
	if($("#sOrgNO").val()==""){
		$("#check-msg").text("请选择区域")
		$('#successAlert').modal('show');  
		$("#sOrgNO").focus();
		return false;
	}
	if($("#sTaxTypeID").val()==""){
		$("#check-msg").text("请选择税别")
		$('#successAlert').modal('show');  
		$("#sTaxTypeID").focus();
		return false;
	}
	if($("#nTaxRate").val()==""){
		$("#check-msg").text("请选择税率")
		$('#successAlert').modal('show');  
		$("#nTaxRate").focus();
		return false;
	}
	if($("#nTaxPct").val()==""){
		$("#check-msg").text("请选择税比")
		$('#successAlert').modal('show');  
		$("#nTaxPct").focus();
		return false;
	}
	if($("#sBankAccountNO").val()==""){
		$("#check-msg").text("请选择银行账号")
		$('#successAlert').modal('show');  
		$("#sBankAccountNO").focus();
		return false;
	}
	
	if($("#sBankAccountNO").val().length>0){
		if(!checkBandCard($("#sBankAccountNO").val())){
			$("#check-msg").text("请填写正确的银行账号")
			$('#successAlert').modal('show'); 
			$("#sBankAccountNO").focus();
			return false;
		}
	}
	return true;
}

//检验银行卡格式
function checkBandCard(account){
	if (account.length < 16 || account.length > 19) {
		//$("#banknoInfo").html("银行卡号长度必须在16到19之间");
		return false;
	}
	var num = /^\d*$/;  //全数字
	if (!num.exec(account)) {
		//$("#banknoInfo").html("银行卡号必须全为数字");
		return false;
	}
	return true;
}
//处理表单
function dealForm() {
	if (check()) {
		$.ajax({
			cache : false,
			type : "POST",
			url : 'agentContractSubmit',
			data : $('#agentContractFrom').serialize(),
			async : false,
			error : function(request) {
				alert("Connection error");
			},
			success : function(data) {
				var dataResult = eval("(" + data + ")");
	        	console.log("dataResult="+dataResult);
	        	var isValid = dataResult.IsValid;
	        	var returnValue = dataResult.ReturnValue;
	        	var contractNo = dataResult.contractNo;
	        	if(isValid){
	        		Ego.success(returnValue+",合同编号为:"+contractNo, function(){
	        			window.location.href = webHost + '/dealer/agentContractList';
	        		});
	        	}else{
	        		Ego.error('创建经销商合同失败'); 
	        	}
			}
		});
	}
}

function GetJsonData() {
	var tableData = new Array();
	$("#goodsList tr").each(function(trindex, tritem) {
		tableData[trindex] = new Array();
		$(tritem).find("td").each(function(tdindex, tditem) {
			tableData[trindex][tdindex] = $(tditem).text();
		});
	});
	alert(tableData);
	var json = {
		"formData" : $('#agentContractFrom').serialize(),
		"goodsData" : ""
	};
	return json;
}

function loadAgentMsg(){
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/dealer/listToJson', 
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
					 $("#agent_menu").html(agentMsg); 
				 } 
         	}else{
         		var returnValue = data.ReturnValue 
         		$("#check-msg").text(returnValue)
         		$('#successAlert').modal('show');  
         	}
        }
    }); 
}
