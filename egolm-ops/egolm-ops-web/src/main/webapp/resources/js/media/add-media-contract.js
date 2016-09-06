jQuery(function($) {

	$('#submit').on('click', function() { //保存编辑 
		//提交代码 
		if(check()){ //保存成功
			adContractFrom();
		}
	});
	
	$('#cancel').on('click', function() { //取消
		window.location.href = webHost + '/media/mediaContract/list';
	});
 
	//设置合同编号
	var nContractID = $('#nContractID').val();
	if(nContractID == ''){
		 var sContractNO = getNowFormatDate();
		 var conNo = "AD-"+sContractNO;
		 $("#sContractNO_show").val(conNo); 
		 $("#sContractNO").val(conNo); 
		 $("#sContractNO_hidden").val(conNo);
	}
	
	 
	 
	//税别	 
	 loadCommonMsg("sTaxType-menu","TAXTYPE");  //加载下拉税别
	 var sTaxType_u = $("#sTaxType").val();
	 if(sTaxType_u !=''){
		 $("#sTaxType-btn").find("span").eq(0).text(sTaxType_u);
	 }
	 
	 $("#sTaxType-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sTaxType-btn").find("span").eq(0).text(litext);
		 $("#sTaxTypeID").val(livalue);
		 $("#sTaxType").val(litext);
		 
	 });
	 
	 //经销商
	 loadAgentMsg();
	 var nAgentID_u = $("#nAgentID").val();
 	 if(nAgentID_u != ''){
		 $("#nAgent-memu").find("li").each(function(){
 			  if($(this).attr("value")==nAgentID_u){
				 var nAgentID_text =  $(this).text();
				 $("#nAgent-id").find("span").eq(0).text(nAgentID_text);  
				
				 $("#nAgent-memu").html("<li></li>");
			  }
		 }); 
	 }
 	 
 	$("#nAgent-memu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 var sCityID = $(this).attr("sCityID");
		 $("#nAgent-id").find("span").eq(0).text(litext);
		 $("#nAgentID").val(livalue); 
		  
		 //根据经销商ID业设置广告合同编号
		var sContractNO_hidden=  $("#sContractNO_hidden").val();  
		
		$("#sContractNO_show").val(sContractNO_hidden+"-"+livalue);
		$("#sContractNO").val(sContractNO_hidden+"-"+livalue);
		 
		 
		 loadTOrgsByCityID("sOrgNO-memu",sCityID);  //加载组织机构
	 });
	 
	
	 
	 //组织机构
	 //loadTOrgs("sOrgNO-memu","4");
	 var sOrgNO_u = $("#sOrgNO").val();
	 var sOrgNODesc_u = $("#sOrgNODesc").val();
	 if(sOrgNO_u != ''){
		 $("#sOrgNO-id").find("span").eq(0).text(sOrgNODesc_u); 
	 }
	 
	 
	 
	 //交易方式
	 loadCommonMsg("sTradeMode-menu","PayType");  //加载下拉列表
	 var sTradeMode_u = $("#sTradeMode").val();
	 if(sTradeMode_u !=''){
		 $("#sTradeMode-btn").find("span").eq(0).text(sTradeMode_u);
	 }
	 
	 $("#sTradeMode-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sTradeMode-btn").find("span").eq(0).text(litext);
		 $("#sTradeModeID").val(livalue);
		 $("#sTradeMode").val(litext);
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
	 loadCommonMsg("sPaytModeID-menu","PAYTMODE");  //加载下拉列表
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
	 
	 //开户银行
	 loadCommonMsg("sBankID-menu","BANK");  //加载下拉列表
	 var sBank_u = $("#sBank").val();
	 if(sBank_u !=''){
		 $("#sBankID-menu").find("li").each(function(){
			  if($(this).attr("value")==sBank_u){
				 var sBankO_text =  $(this).text();
				 $("#sBankID-btn").find("span").eq(0).text(sBankO_text); 
			  }
		 }); 
	 }
	 $("#sBankID-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sBankID-btn").find("span").eq(0).text(litext);
		 $("#sBank").val(livalue); 
	 });
	  
	 //合同状态
	 loadCommonMsg("nContractTag-menu","STATUS");  //加载下拉列表
	 var nContractTag_u = $("#nContractTag").val();
	 if(nContractTag_u !=''){
		 $("#nContractTag-menu").find("li").each(function(){
			  if($(this).attr("value")==nContractTag_u){
				 var nContractTag_text =  $(this).text();
				 $("#nContractTag-btn").find("span").eq(0).text(nContractTag_text); 
			  }
		 }); 
	 }
	 $("#nContractTag-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#nContractTag-btn").find("span").eq(0).text(litext);
		 $("#nContractTag").val(livalue); 
	 });
	 
	 
	 $("#sBankAccountNO").on("keyup", formatBC);
	 
	//日期控件
		$('#dActiveDate').datetimepicker({
	      	format:'Y-m-d',      //格式化日期
	      	timepicker:false,    //开启时间选项
	      	yearStart:2000,     //设置最小年份
	     	yearEnd:2050,        //设置最大年份
	      	todayButton:false    //关闭选择今天按钮
		});
		
		$('#dExpireDate').datetimepicker({
	      	format:'Y-m-d',     //格式化日期
	      	timepicker:false,    //开启时间选项
	      	yearStart:2000,     //设置最小年份
	     	yearEnd:2050,        //设置最大年份
	      	todayButton:false    //关闭选择今天按钮
		});
		
		$.datetimepicker.setLocale('ch'); //日期插件设置为中文
});



function check(){
	if(Trim($("#sContractNO").val())==""){ 
		Ego.error("请填写合同编码",null);
		$("#sContractNO").focus();
		return false;
	}
	
	if(Trim($("#nRatio").val())==""){ 
		Ego.error("请填写固定扣点率",null);
		$("#nRatio").focus();
		return false;
	}
	if(isNaN(Trim($("#nRatio").val()))){ 
		Ego.error("固定扣点率填写错误",null);
		$("#nRatio").focus();
		return false;
	}
	
	if(Trim($("#sTaxCode").val())==""){ 
		Ego.error("请填写税号",null);
		$("#sTaxCode").focus();
		return false;
	}
	if(Trim($("#nAgentID").val())==""){ 
		Ego.error("请选择经销商",null);
		$("#nAgentID").focus();
		return false;
	}
	if(Trim($("#sOrgNO").val())==""){ 
		Ego.error("请选择组织机构",null);
		$("#sOrgNO").focus();
		return false;
	}
	if(Trim($("#dActiveDate").val())==""){ 
		Ego.error("请选择生效日期",null);
		$("#dActiveDate").focus();
		return false;
	}
	if(Trim($("#dExpireDate").val())==""){ 
		Ego.error("请选择失效日期",null);
		$("#dExpireDate").focus();
		return false;
	}
	if(Trim($("#dActiveDate").val()) > Trim($("#dExpireDate").val())){ 
		Ego.error("生效日期不能大于失效日期",null);
		return false;
	}
	
	if(Trim($("#nTaxRate").val())==""){ 
		Ego.error("请填写税率",null);
		$("#nTaxRate").focus();
		return false;
	}
	if(isNaN(Trim($("#nTaxRate").val()))){ 
		Ego.error("税率填写错误",null);
		$("nTaxRate").focus();
		return false;
	}
	
	if(Trim($("#nTaxPct").val())==""){  
		Ego.error("请填写税比",null);
		$("#nTaxPct").focus();
		return false;
	}
	if(isNaN(Trim($("#nTaxPct").val()))){   
		Ego.error("税比填写错误",null);
		$("nTaxPct").focus();
		return false;
	}
	if(Trim($("#nTaxPct").val()) >= 100){  
		Ego.error("税比应小于100",null);
		$("#nTaxPct").focus();
		return false;
	}
	
	if(Trim($("#sTaxTypeID").val())==""){   
		Ego.error("请选择税别",null);
		$("#sTaxTypeID").focus();
		return false;
	}
	if(Trim($("#sTradeModeID").val())==""){  
		Ego.error("请选择交易方式",null);
		$("#sTradeModeID").focus();
		return false;
	}
	if(Trim($("#sPaytTermID").val())==""){   
		Ego.error("请选择付款账期",null);
		$("#sPaytTermID").focus();
		return false;
	}
	if(Trim($("#sPaytModeID").val())==""){ 
		Ego.error("请选择付款方式",null);
		$("#sPaytModeID").focus();
		return false;
	}
	if(Trim($("#sBank").val())==""){ 
		Ego.error("请选择开户银行",null);
		$("#sBank").focus();
		return false;
	}
	if(Trim($("#nContractTag").val())==""){   
		Ego.error("请选择合同状态",null);
		$("#nContractTag").focus();
		return false;
	}
	if(Trim($("#sBankAccountNO").val())==""){ 
		Ego.error("请填写银行账号",null);
		$("#sBankAccountNO").focus();
		return false;
	}
	if(Trim($("#sBankAccount").val())==""){ 
		Ego.error("请填写银行账户",null);
		$("#sBankAccount").focus();
		return false;
	}
	if(Trim($("#nPaytDay").val())==""){  
		Ego.error("请填写付款天数",null);
		$("#nPaytDay").focus();
		return false;
	}
	if(isNaN(Trim($("#nPaytDay").val()))){  
		Ego.error("付款天数填写错误",null);
		$("#nPaytDay").focus();
		return false;
	}
	
	if(Trim($("#sPaytContact").val())==""){ 
		Ego.error("请填写付款联系人",null);
		$("#sPaytContact").focus();
		return false;
	}
	if(Trim($("#sPaytContactTel").val())==""){   
		Ego.error("请填写联系电话",null);
		$("#sPaytContactTel").focus();
		return false;
	}
	if(Trim($("#sPaytCenterNO").val())==""){ 
		Ego.error("请填写付款中心",null);
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
            Ego.error("系统异常,请刷新后重试",null);
        },
        success: function(data) {
        	var isValid = data.IsValid;
        	var returnValue = data.ReturnValue 
        	if(isValid){ 
        		Ego.success(returnValue,function(){
        			window.location.href = webHost + '/media/mediaContract/list';
        		}); 
        	}else{
        		Ego.error(returnValue,null); 
        	}
        }
    }); 
}


function loadAgentMsg(){
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/dealer/listToJson', 
        dataType: "json",
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) { 
         	 var isValid = data.IsValid;
        	 if(isValid){
         		var dataList = data.DataList ; 
          		if(dataList.length>0){ 
					 var agentMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 agentMsg+="<li value='"+data.nAgentID+"' sCityID='"+data.sCityID+"'>"+data.sAgentName+"</li> "; 
					 }
					 $("#nAgent-memu").html(agentMsg); 
				 } 
         	}else{
         		var returnValue = data.ReturnValue 
         		Ego.error(returnValue,null); 
         	}
        }
    }); 
}


function formatBC(e){
	  
    $(this).attr("data-oral", $(this).val().replace(/\ +/g,""));
    //$("#bankCard").attr("data-oral")获取未格式化的卡号

    var self = $.trim(e.target.value);
    var temp = this.value.replace(/\D/g, '').replace(/(....)(?=.)/g, '$1 ');
    if(self.length > 23){
      this.value = self.substr(0, 23);
      return this.value;
    }
    if(temp != this.value){
      this.value = temp;
    }
  }


/**
 * 根据市编号查询组织机构
 * @param memuId
 * @param nOrgLevel
 */
function loadTOrgsByCityID(memuId,sCityID){
 	$("#sOrgNO-id").find("span").eq(0).text("请选择");
	 $("#sOrgNO").val(""); 
	 $("#sOrgNODesc").val("");
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/org/queryTOrgsByScityID',
        data:'sCityID='+sCityID,
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {  
        	var dataResult = eval("(" + data + ")");
         	var isValid = dataResult.IsValid;
         	if(isValid){
        		var dataList = dataResult.DataList ; 
            	if(dataList.length>0){ 
					 var memuMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 memuMsg+="<li class='org-item' value='"+data.sOrgNO+"'>"+data.sOrgDesc+"</li> "; 
					 }
					 $("#"+memuId).html(memuMsg); 
					 $("#"+memuId+" li").click(function(){
						 var litext = $(this).text();
						 var livalue =  $(this).attr("value"); 
						 $("#sOrgNO-id").find("span").eq(0).text(litext);
						 $("#sOrgNO").val(livalue); 
						 $("#sOrgNODesc").val(litext);
					 });
				 }else{
					 $("#"+memuId).html(""); 
				 }
        	}else{
        		var returnValue = data.ReturnValue; 
        		$("#check-msg").text(returnValue)
        		$('#successAlert').modal('show');  
        	}
        }
    }); 
}


/**
 * 获取时间
 * @param defaultvalue
 * @returns {String}
 */
function getNowFormatDate() {
 	var dd = new Date(); 
	dd.setDate(dd.getDate());//获取AddDayCount天后的日期 
	var y = dd.getFullYear(); 
	var m = dd.getMonth()+1;//获取当前月份的日期 
	var d = dd.getDate(); 
	var h = dd.getHours();   //时
	var mm = dd.getMinutes(); //分
	var se = dd.getSeconds(); //秒
	var currentdate =  y+Appendzero(m)+Appendzero(d)+Appendzero(h)+Appendzero(mm)+Appendzero(se); 
	return currentdate;
}

function Appendzero(obj)  
{  
    if(obj<10) return "0" +""+ obj;  
    else return obj;  
} 
