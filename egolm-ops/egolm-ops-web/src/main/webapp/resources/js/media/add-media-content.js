jQuery(function($) {

	$('#submit').on('click', function() { //保存编辑  
		if(check()){ //保存成功 
			adVertFrom();
		}
	});

	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});
	
	$('#seletAdVertNO').on('click', function() { // 显示选择用户窗口
		var sAdJumpTypeId = $("#sAdJumpTypeId").val();//链接类型为商品时
		var nAgentID = $("#nAgentID").val();
		var sOrgNO = $("#sAdZoneCodeID").val(); 
		if(sOrgNO == ''){
			Ego.error("请选择广告区域",null);
			return;
		}
		if(nAgentID == ''){
			Ego.error("请选择合同编号",null);
			return;
		}
		if(sAdJumpTypeId == ''){
			Ego.error("请选择广告链接类型",null);
			return;
		}
		
	    seletAdVertNO(sAdJumpTypeId,"adVertSelect?sAdJumpTypeId="+sAdJumpTypeId+"&nAgentID="+nAgentID+"&sOrgNO="+sOrgNO); 
	});
	
	$("#seletAdPosNO").on('click',function(){  //选择广告位
		var sAdZoneCodeID  = $("#sAdZoneCodeID").val();
		var sApSaleTypeID = $("#sApSaleTypeID").val();
		if(sAdZoneCodeID == ''){
			Ego.error("请选择广告区域",null);
			return;
		}
		if(sApSaleTypeID == ''){
			Ego.error("请选择广告位置",null);
			return;
		}
		
		seletAdPosNO("adPosSelect?type=add&sAdZoneCodeID="+sAdZoneCodeID+"&sApSaleTypeID="+sApSaleTypeID+"");
	});
	
	
	
	//广告区域
 	loadTOrgsAndAll("sAdZoneCode-area-menu","4","loadAll");
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
	  loadCommonMsg("sApSaleType-area-menu","sApSaleType");
	 
	 var sApSaleType_u = $("#sApSaleType").val();
	 if(sApSaleType_u != ''){  //编辑时会有
		$("#sApSaleType-area-btn").find("span").eq(0).text(sApSaleType_u);
		var sApSaleTypeID_u = $("#sApSaleTypeID").val();
		 var sAdZoneCodeID = $("#sAdZoneCodeID").val(); //区域编号
		 loadApByApSaleType(sApSaleTypeID_u,sAdZoneCodeID);
		 $("#ap-place-id").find("span").eq(0).text($("#Aptitle").val());
		 
		 // 编辑时设置隐藏的 广告位 宽和高
		 var nApID= $("#nApID").val();
		 
		 $("#ap-place-menu").find("li").each(function(){
			  
			 if(Trim($(this).attr("value")) == Trim(nApID)){ 
				  $("#nApWidth").val($(this).attr("nApWidth"));
				  $("#nApHeight").val($(this).attr("nApHeight"));
			 }
		 });
		 
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
		 var sAdJumpTypeId = $("#sAdJumpTypeId").val();  //原来的
		 selectJumpType(sAdJumpTypeId,sAdJumpType_u);  
	 }
	 
	 $("#ad-jump-type-menu li").click(function(){  //新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#ad-jump-type-id").find("span").eq(0).text(litext);
		 $("#sAdJumpTypeId").val(livalue); 
		 $("#sAdJumpType").val(litext);
 		 selectJumpType(livalue,litext);  
		 
		 if(livalue == 'goods' || livalue == 'brand' ){
			 var sAdJumpTypeId_now = $("#sAdJumpTypeId_now").val(); 
	 		 if(livalue != sAdJumpTypeId_now){ //不相同 置为空
 				 $("#sAdJumpNo").val("");
				 $("#sAdJumpName").val("");
			 }
			 if(livalue == sAdJumpTypeId_now){ //相同 重新设值 
	 			 $("#sAdJumpNo").val($("#sAdJumpNo_now").val());
				 $("#sAdJumpName").val($("#sAdJumpName_now").val());
			 }
		 }
		
	 });
	 
	 //是否显示商品信息
	 var nAdShowGoodsMsgID_u = $("#nAdShowGoodsMsgID").val();
	 if(nAdShowGoodsMsgID_u != ''){
		 $("#sAdShowGoodsMsg-id").find("span").eq(0).text($("#sAdShowGoodsMsg").val());
	 }
	 $("#sAdShowGoodsMsg-menu li").click(function(){  // 
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sAdShowGoodsMsg-id").find("span").eq(0).text(litext);
		 $("#nAdShowGoodsMsgID").val(livalue); 
		 $("#sAdShowGoodsMsg").val(litext);
		 
	 });
	
	 $("#cancel").click(function(){
		 window.location.href="list";
	 });
	 
		
		//日期控件
		$('#dAdBeginTime').datetimepicker({
	      	format:'Y-m-d',      //格式化日期
	      	timepicker:false,    //开启时间选项
	      	yearStart:2000,     //设置最小年份
	     	yearEnd:2050,        //设置最大年份
	      	todayButton:false    //关闭选择今天按钮
		});
		
		$('#dAdEndTime').datetimepicker({
	      	format:'Y-m-d',     //格式化日期
	      	timepicker:false,    //开启时间选项
	      	yearStart:2000,     //设置最小年份
	     	yearEnd:2050,        //设置最大年份
	      	todayButton:false    //关闭选择今天按钮
		});
		
		$.datetimepicker.setLocale('ch'); //日期插件设置为中文
		
		
});

// 广告链接类型
function selectJumpType(typeId,typeName){
	 //console.log("typeId=="+typeId+"=typeName="+typeName);
	 $("#sAdJumpTypeId").val(typeId);
	 $("#sAdJumpType").val(typeName);
	 
	if(typeId == 'goods'){   //选择的为商品
		 $("#ad_jump_id").show();
		 $("#seletAdVertNO").show();
		 $("#typeName-id").text("链接商品:");
		 $("#default-url-id").hide(); 
	 }
	if(typeId == 'brand'){ //品牌
		$("#ad_jump_id").show();
		$("#seletAdVertNO").show();
		 $("#default-url-id").hide();
		 $("#typeName-id").text("链接品牌:"); 
	}
	if(typeId == 'activity'){ //活动 
		 $("#ad_jump_id").show();
		 $("#default-url-id").hide();
		 $("#seletAdVertNO").hide();
		 $("#typeName-id").text("链接活动:");
		 $("#sAdJumpName").val("默认活动页");
		  
	}
	if(typeId=='other' ){   //外部链接
		 $("#ad_jump_id").hide();
		 $("#seletAdVertNO").hide();
		 $("#default-url-id").show();
		 $("#sAdJumpUrl").attr("placeholder","以http://开头,如跳转至百度,天猫,官网等.");
	}
	if(typeId == 'internalLink'){  //内部链接
		$("#ad_jump_id").hide();
		 $("#seletAdVertNO").hide();
		 $("#default-url-id").show();
		 $("#sAdJumpUrl").attr("placeholder","系统内部之间的跳转");
	}
	
}

function check(){
	if(Trim($("#sAdTitle").val())==''){ 
		Ego.error("请填写广告名称",null);
		$("#sAdTitle").focus();
		return false;
	}
	if(Trim($("#sAdZoneCodeID").val())==""){ 
		Ego.error("请选择广告区域",null);
		$("#sAdZoneCode").focus();
		return false;
	} 
	if(Trim($("#nContractID").val())==""){ 
		Ego.error("请选择合同编号",null);
		$("#nContractID").focus();
		return false;
	}
	
	if(Trim($("#sApSaleType").val())==""){ 
		Ego.error("请选择广告位置",null);
		$("#sApSaleType").focus();
		return false;
	} 
	if(Trim($("#nApID").val())==""){  
		Ego.error("请选择广告位",null);
		$("#nApID").focus();
		return false;
	} 
	if(Trim($("#dAdBeginTime").val())==""){   
		Ego.error("请选择开始时间",null);
		$("#dAdBeginTime").focus();
		return false;
	} 
	if(Trim($("#dAdEndTime").val())==""){ 
		Ego.error("请选择结束时间",null);
		$("#dAdEndTime").focus();
		return false;
	}
	

	if(Trim($("#dAdBeginTime").val()) > Trim($("#dAdEndTime").val())){ 
		Ego.error("开始时间不能大于结束时间",null);
		return false;
	}
	
	
	if(Trim($("#nAdWidth").val())==""){  
		Ego.error("请填写广告宽度",null);
		$("#nAdWidth").focus();
		return false;
	}
	if(isNaN(Trim($("#nAdWidth").val()))){  
		Ego.error("广告宽度填写错误",null);
		$("#nAdWidth").focus();
		return false;
	}
	if(Trim($("#nAdHeight").val())==""){ 
		Ego.error("请填写广告高度",null);
		$("#nAdHeight").focus();
		return false;
	}
	if(isNaN(Trim($("#nAdHeight").val()))){  
		Ego.error("广告高度填写错误",null);
		$("#nAdHeight").focus();
		return false;
	}
	
 	if(Trim($("#nAdWidth").val()) > Trim($("#nApWidth").val())){ 
		Ego.error("广告宽度("+$("#nAdWidth").val()+")不能大于广告位宽度("+$("#nApWidth").val()+")",null);
		$("#nAdWidth").focus();
		return false;
	}
	if(Trim($("#nAdHeight").val()) > Trim($("#nApHeight").val())){ 
		Ego.error("广告高度("+$("#nAdHeight").val()+")不能大于广告位高度("+$("#nApHeight").val()+")",null);
		$("#nAdHeight").focus();
		return false;
	} 
	
	if(Trim($("#nBID").val()) !=""){
		if(isNaN(Trim($("#nBID").val()))){  
			Ego.error("广告批次填写错误",null);
			$("#nBID").focus();
			return false;
		}
	}else{
		$("#nBID").val("0");
	}
	if(Trim($("#nAdSlideSequence").val()) !=""){
		if(isNaN(Trim($("#nAdSlideSequence").val()))){   
			Ego.error("幻灯片序号填写错误",null);
			$("#nAdSlideSequence").focus();
			return false;
		}
	}else{
		$("#nAdSlideSequence").val("1");
	}
	
	if(Trim($("#nAdShowGoodsMsgID").val())==""){ 
		Ego.error("请选择是否需要展示商品信息",null);
		$("#nAdShowGoodsMsgID").focus();
		return false;
	}
	
 	if(Trim($("#nAdShowGoodsMsgID").val()) == 1){  //显示商品信息 
		if(Trim($("#nAdHeight").val()) == Trim($("#nApHeight").val())){ 
			Ego.error("广告高度与广告位高度相同,将无法显示商品信息,正确设置:广告高度应小于广告位高度",null);
			$("#nAdHeight").focus();
			return false;
		}
	} 
	
 	
  	if($("#sAdJumpTypeId").val() !='' && $("#sAdJumpTypeId").val() != 'other' && $("#sAdJumpTypeId").val() != 'internalLink' && $("#sAdJumpTypeId").val() != 'activity'){
  		if(Trim($("#sAdJumpNo").val()) == ""){
 			Ego.error("请选择对应的链接信息",null);
 			$("#sAdJumpNo").focus();
 			return false;
 		}
 	}
	
	return true;
}

//加载广告位
function loadApByApSaleType(sApSaleType,sAdZoneCodeID){
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/media/mediaPos/loadMsgByApSaleType?sApSaleTypeID='+sApSaleType+'&sAdZoneCodeID='+sAdZoneCodeID,
        data:'',
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
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
						 apMsg+="<li value='"+data.nApID+"'  pApTypeId='"+data.sApTypeID+"' nApWidth='"+data.nApWidth+"' nApHeight='"+data.nApHeight+"' >"+data.sApTitle+"</li> "; 
						
					 }
					 $("#ap-place-menu").html(apMsg);
					 //广告位
					 $("#ap-place-menu li").click(function(){
						 var litext = $(this).text(); 
						 var livalue =  $(this).attr("value"); 
						 var pApTypeId= $(this).attr("pApTypeId"); 
						 
						 var resultText = "";
						 if(litext.length >12){
							 resultText = litext.substring(0,12)+"...";
						 }else{
							 resultText= litext;
						 }
						 	
						 
						 
 						 $("#ap-place-id").find("span").eq(0).text(resultText);
						 $("#nApID").val(livalue);
						 
						 //将广告位的宽高设为到广告上
						 $("#nAdWidth").val($(this).attr("nApWidth"));
						 $("#nAdHeight").val($(this).attr("nApHeight"));
						  
						 //隐藏广告位的宽高，用于提交比较
						 $("#nApWidth").val($(this).attr("nApWidth"));
						 $("#nApHeight").val($(this).attr("nApHeight"));
						 
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
        		var returnValue = dataResult.ReturnValue ; 
        		Ego.error(returnValue,null);
        	}
        }
    }); 
}



function adVertFrom(){ 
	var layerindex = layer.load(0, {shade: [0.2, '#393D49']});  
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
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")"); 
        	var isValid = dataResult.IsValid;
        	var returnValue = dataResult.ReturnValue 
        	if(isValid){
        		layer.close(layerindex);
        		 Ego.success(returnValue,function(){
        			window.location.href = webHost + '/media/mediaContext/list';
        		 });  
        	}else{
        		layer.close(layerindex);
        		Ego.error(returnValue,null);
        	}
        }
    }); 
}

//加载合同
function loadContractMsg(sZoneCodeId){ 
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/media/mediaContract/listToJson', 
        data:'sOrgNO='+sZoneCodeId,
        dataType: "json",
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) { 
        	 $("#sContractID-area-id").find("span").eq(0).text("请选择");
        	 var isValid = data.IsValid;
        	 if(isValid){
         		var dataList = data.DataList ; 
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
					 $("#sContractID-area-menu").html("");
				 }
         	}else{
         		var returnValue = data.ReturnValue ;
         		Ego.error(returnValue,null);
         	}
        }
    }); 
}
  


/* 选择 商品 、品牌 窗口 */
function seletAdVertNO(sAdJumpTypeId,content_url) {
	var showTitle = "";
	if(sAdJumpTypeId == 'goods'){
		showTitle='选择商品';		
	}
	if(sAdJumpTypeId == 'brand'){
		showTitle='选择品牌';
	}
	layer.open({
		type : 2,
		title : showTitle,
		shadeClose : true,
		shade : 0.6,
		area : [ '60%', '80%' ],
		content : content_url
	});
}
/**回调设置 商品、品牌数据**/
function getJumpNO(selectNo,selectName){
	$("#sAdJumpNo").val(selectNo);
	$("#sAdJumpName").val(selectName);
}



/* 选择 窗口 */
function seletAdPosNO(content_url) {
	 
	layer.open({
		type : 2,
		title : '广告位选择',
		shadeClose : true,
		shade : 0.6,
		area : [ '60%', '80%' ],
		content : content_url
	});
}


function getAdPosNO(selectNo,selectName,selectWidth,selectHeight){
	$("#nApID").val(selectNo);
	$("#sApTitle").val(selectName);
	$("#nAdWidth").val(selectWidth);
	$("#nAdHeight").val(selectHeight);
	$("#nApWidth").val(selectWidth);
	$("#nApHeight").val(selectHeight);
}
