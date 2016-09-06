$(document).ready(function() {
	$('#submit').on('click', function() { //保存编辑
		//提交代码
		if(check()){ //保存成功
			dealForm();
		}
	});
	//加载经销商类别
	loadCommonMsg("agenttype-menu", "AgentType"); //加载类别
	var sAgentType_u = $("#sAgentType").val();
	if (sAgentType_u != '') {
		$("#agenttype").find("span").eq(0).text(sAgentType_u);
	}
	$("#agenttype-menu li").click(function() {
		var litext = $(this).text();
		var livalue = $(this).attr("value");
		$("#agenttype").find("span").eq(0).text(litext);
		$("#sAgentTypeID").val(livalue);
		$("#sAgentType").val(litext);
	});

	//省份选择处理
	var sProvince_u = $("#sProvince").val(); //编辑时展示
	if (sProvince_u != '') {
		$("#province").find("span").eq(0).text(sProvince_u);
	}
	$("#province-menu li").click(function() { //选择
		var litext = $(this).text();
		var livalue = $(this).attr("value");
		$("#province").find("span").eq(0).text(litext);
		$("#sProvinceID").val(livalue);
		$("#sProvince").val(litext);
		//加载市
		loadCity();
	});
	 //市选择处理
	 var sCity_u = $("#sCity").val();   //编辑时展示
	 if(sCity_u !=''){
		$("#city").find("span").eq(0).text(sCity_u);
	 }
	 //地区选择处理
	 var sDistrict_u = $("#sDistrict").val();   //编辑时展示
	 if(sDistrict_u !=''){
		$("#district").find("span").eq(0).text(sDistrict_u);
	 }
	 $('#cancel').on('click', function(){
			window.location.href = webHost + '/dealer/agentList';
		});
});
//获取国家资料
function loadNation(el) {
	var data = eval(el);
	$("#sNationID").val(data.id);
	$("#sNation").val(data.name);
	$("#nationSpan").text(data.name);
}
//获取市区资料
function loadCity(){
	$.get("getCityByProvinceId?sProvinceID="+$("#sProvinceID").val(),function(data){
    	if(data.IsValid){
    		var result = "";
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
	if($("#sAgentName").val()==""){ 
		$("#check-msg").text("请填写经销商名称")
		$('#successAlert').modal('show');  
		$("#sAgentName").focus();
		return false;
	}
	if($("#sAgentType").val()==""){ 
		$("#check-msg").text("请填写经销商类别")
		$('#successAlert').modal('show');  
		$("#sAgentType").focus();
		return false;
	}
	if($("#sMobile").val()==""){ 
		$("#check-msg").text("请填写手机号码")
		$('#successAlert').modal('show');  
		$("#sMobile").focus();
		return false;
	}
	var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
	if($("#sMobile").val().length>0){
	if($("#sMobile").val().length != 11 && !myreg.test($("#sMobile").val())){
		$("#check-msg").text("请填写正确的手机号码")
		$('#successAlert').modal('show'); 
		$("#sMobile").focus();
		return false;
	}
	}
	var checkPhone = /^([0-9]{3,4}-)?[0-9]{7,8}$/;
	if($("#sTel").val().length>0){
		if(!checkPhone.test($("#sTel").val())){
			$("#check-msg").text("请填写正确的电话")
			$('#successAlert').modal('show'); 
			$("#sTel").focus();
			return false;
		}
	}
	var checkFax = /^(\d{3,4}-)?\d{7,8}$/; 
	if($("#sFax").val().length>0){
		if(!checkFax.test($("#sFax").val())){
			$("#check-msg").text("请填写正确的传真")
			$('#successAlert').modal('show'); 
			$("#sFax").focus();
			return false;
		}
	}
	
	var checkPostalcode= /^[0-9]\d{5}$/;
	if($("#sPostalcode").val().length>0){
		if(!checkPostalcode.test($("#sPostalcode").val())){
			$("#check-msg").text("请填写正确的邮编")
			$('#successAlert').modal('show'); 
			$("#sPostalcode").focus();
			return false;
		}
	}
	if($("#sNation").val()==""){ 
		$("#check-msg").text("请填写国家")
		$('#successAlert').modal('show');  
		$("#sNation").focus();
		return false;
	}
	if($("#sProvince").val()==""){
		$("#check-msg").text("请填写省份")
		$('#successAlert').modal('show'); 
		$("#sProvince").focus();
		return false;
	}
	if($("#sCity").val()==""){
		$("#check-msg").text("请填写市")
		$('#successAlert').modal('show');  
		$("#sCity").focus();
		return false;
	} 
	
	if($("#sDistrict").val()==""){
		$("#check-msg").text("请填写地区")
		$('#successAlert').modal('show'); 
		$("#sDistrict").focus();
		return false;
	}
	if($("#sEmail").val()==""){
		$("#check-msg").text("请填写邮箱")
		$('#successAlert').modal('show'); 
		$("#sEmail").focus();
		return false;
	}
	if($("#sEmail").val().length>0){
		if(!ismail($("#sEmail").val())){
			$("#check-msg").text("请填写正确的邮箱")
			$('#successAlert').modal('show'); 
			$("#sEmail").focus();
			return false;
		}
	}
	return true;
}

function ismail(mail){
	return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
}

//表单提交
function dealForm(){	
	var formData = $('#agentFrom').serialize();   
	$.ajax({
        cache: false,
        type: "POST",
        url:'agentUpdate',
        data: $('#agentFrom').serialize(),  
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
        		window.location.href = webHost + '/dealer/agentList';
        	}else{
        		$("#check-msg").text(returnValue)
        		$('#successAlert').modal('show');  
        	}
        }
    }); 
}
