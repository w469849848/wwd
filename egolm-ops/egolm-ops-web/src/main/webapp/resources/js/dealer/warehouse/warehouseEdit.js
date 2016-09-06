$(document).ready(function() {
	$('#submit').on('click', function() { //保存编辑
		//提交代码
		if(check()){ //保存成功
			dealForm();
		}
	});
	
	//省份选择处理
	var sProvince_u = $("#sProvince").val(); //编辑时展示
	if (sProvince_u != '') {
		$("#province").find("span").eq(0).text(sProvince_u);
		loadCity();
	}
	$("#province-menu li").click(function() { //选择
		var litext = $(this).text();
		var livalue = $(this).attr("value");
		$("#province").find("span").eq(0).text(litext);
		$("#sProvinceID").val(livalue);
		$("#sProvince").val(litext);
		
		$("#sCityID").val("");
		$("#sCity").val("");
		$("#citySpan").text("请选择");
		
		$("#sDistrictID").val("");
		$("#sDistrict").val("");
		$("#districtSpan").text("请选择");
		
		$("#deliverRegion").val("");
		$("#deliverRegionSel").val("请选择");
		
		//加载市
		loadCity();
	});
	 //市选择处理
	 var sCity_u = $("#sCity").val();   //编辑时展示
	 if(sCity_u !=''){
		$("#city").find("span").eq(0).text(sCity_u);
		 loadDistrict();
	 }
	 //地区选择处理
	 var sDistrict_u = $("#sDistrict").val();   //编辑时展示
	 if(sDistrict_u !=''){
		$("#district").find("span").eq(0).text(sDistrict_u);
	 }
	 $('#cancel').on('click', function(){
			window.location.href = webHost + '/agent/warehouse/warehouseList';
	 });
	 $("#seletDistrict").on('click',function(){  //选择
		var sCityID = $("#sCityID").val();
		var districtIDs = $("#deliverRegion").val();
		if(sCityID == ''){
			Ego.error("请选择省市",null);
			return;
		}
		seletDistrict("districtSelectPage?&cityID="+sCityID+"&districtIDs="+districtIDs);
	 });
	 
	 $("#seletAgent").on('click',function(){  //选择
			if(sCityID == ''){
				Ego.error("请选择省市",null);
				return;
			}
			seletAgent("agentSelectPage");
	  });
	 
		//仓库类型处理
		var sWarehouseType = $("#sWarehouseType").val(); //编辑时展示
		if (sWarehouseType != '') {
			$("#whType").find("span").eq(0).text(sWarehouseType);
		}
		$("#whType-menu li").click(function() { //选择
			var litext = $(this).text();
			var livalue = $(this).attr("value");
			$("#whType").find("span").eq(0).text(litext);
			$("#sWarehouseTypeID").val(livalue);
			$("#sWarehouseType").val(litext);
		});
});

//获取市区资料
function loadCity(){
	$.get("getCityByProvinceId?sProvinceID="+$("#sProvinceID").val(),function(data){
    	if(data.IsValid){
    		var result = "<li value=''>请选择</li>";
    		$.each(data.DataList,function(n,value){
                result +="<li value='"+value.sRegionNO+"'>"+value.sRegionDesc+"</li> "; 
            });
    		$("#city-menu").html('');
            $("#city-menu").append(result);
            $("#district-menu").html('');
    	}
	},"json");
	 $("#city-menu").on("click","li", function() {
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#city").find("span").eq(0).text(litext);
		 $("#sCityID").val(livalue);
		 $("#sCity").val(litext);
		 
		 $("#sDistrictID").val("");
		 $("#sDistrict").val("");
		 $("#districtSpan").text("请选择");
		
		 $("#deliverRegion").val("");
		 $("#deliverRegionSel").val("请选择");
			
		 //加载地区
		 loadDistrict();
	});
}
//获取地区资料
function loadDistrict(){
	 $.get("getAreaByCityId?sCityID="+$("#sCityID").val(),function(data){
         if(data.IsValid){
             var result = "";
             $.each(data.DataList,function(n,value){
                 result +="<li value='"+value.sRegionNO+"'>"+value.sRegionDesc+"</li> "; 
             });
             $("#district-menu").html('');
             $("#district-menu").append(result);
         }
	 },"json");
	 $("#district-menu").on("click","li", function() {
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#district").find("span").eq(0).text(litext);
		 $("#sDistrictID").val(livalue);
		 $("#sDistrict").val(litext);
	});
}
//表单检验
function check(){ 
	var type = $("#type").val();
	
	if(type == 'edit'){
		if($("#sWarehouseNO").val()==''){
			Ego.error("请填写仓库编号",null);
			$("#sWarehouseNO").focus();
			return false;
		}
		
		if($("#sWarehouseName").val()==''){
			Ego.error("请填写仓库名称",null);
			$("#sWarehouseName").focus();
			return false;
		}
		
	}else{
		if($("#sWarehouseNO").val()==''){
			Ego.error("请填写仓库编号",null);
			$("#sWarehouseNO").focus();
			return false;
		}
		
		if($("#sWarehouseName").val()==''){
			Ego.error("请填写仓库名称",null);
			$("#sWarehouseName").focus();
			return false;
		}
		
	}

	if($("#nMinDCAmount").val()==''){
		Ego.error("请填最小起订金额",null);
		$("#nMinDCAmount").focus();
		return false;
	}else{
		if(isNaN($("#nMinDCAmount").val())){
			Ego.error("请填写有效最小起订金额",null);
			$("#nMinDCAmount").focus();
			return false;
		}
	}
	
	if(type == 'edit'){
		
	}else{
		if($("#nAgentID").val()==''){
			Ego.error("请选择经销商",null);
			$("#nAgentIDSel").focus();
			return false;
		}
	}
	
	if($("#sProvince").val()==""){
		Ego.error("请填写省份",null);		
		$("#sProvince").focus();
		return false;
	}
	
	if($("#sCity").val()==""){
		Ego.error("请填写市",null);		
		$("#sCity").focus();
		return false;
	} 
	
	if($("#sDistrict").val()==""){
		Ego.error("请填写地区",null);	
		$("#sDistrict").focus();
		return false;
	}
	
	if($("#deliverRegion").val()==""){
		Ego.error("请选择配送区域",null);	
		$("#deliverRegionSel").focus();
		return false;
	}
	
	return true;
}

function ismail(mail){
	return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
}

//表单提交
function dealForm(){	
	var formData = $('#warehouseFrom').serialize();   
	$.ajax({
        cache: false,
        type: "POST",
        url:'warehouseSave',
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
	       		 Ego.success(returnValue,function(){
	       			window.location.href = webHost + '/agent/warehouse/warehouseList';
	       		 });  
	       	}else{
	       		Ego.error(returnValue,null);
	       	}
        }
    }); 
}

function getDistrict(selectNo,selectName){
	$("#deliverRegion").val(selectNo);
	$("#deliverRegionSel").val(selectName);
	$("#deliverRegionDesc").val(selectName);
}

function getAgentNO(selectNo,selectName){
	$("#nAgentID").val(selectNo);
	$("#nAgentIDSel").val(selectName);
}

/* 选择配送区域窗口 */
function seletDistrict(content_url) {
	layer.open({
		type : 2,
		title : '选择配送区域',
		shadeClose : true,
		shade : 0.6,
		area : [ '70%', '90%' ],
		content : content_url
	});
}

/* 选择经销商窗口 */
function seletAgent(content_url) {
	layer.open({
		type : 2,
		title : '选择经销商',
		shadeClose : true,
		shade : 0.6,
		area : [ '70%', '90%' ],
		content : content_url
	});
}