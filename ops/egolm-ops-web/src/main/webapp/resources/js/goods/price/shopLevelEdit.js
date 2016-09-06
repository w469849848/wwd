$(document).ready(function(){
	$('#submitForm').on('click', function() { //保存编辑
		//提交代码
		if(check()){ //保存成功
			//$('#successAlert').modal('show');
			shopLevelFrom();
		}
	});
	
	var constractNO = $("#constractNO").val();
	
	if(constractNO != ""){
		baseLevelContent(constractNO);
		shopContent(constractNO);
	}
	
	$("#constract-menu li").click(function(){
		var litext = $(this).find("a").text();
		var livalue =  $(this).find("a").attr("id");  
		$("#sConstractSpan").text(litext);
		$("#constractNO").val(livalue);
		if(livalue != ""){
			baseLevelContent(livalue);
			shopContent(livalue);
		}else{
			$("#shopLevelSpan").text("全部");
			$("#shopLevel").val("");
		}
	});
	
	//$(".js-example-basic-single").select2();
	
	$("#seletShopNO").on('click',function(){  //选择广告位
		var constractNO = $("#constractNO").val();
		if(constractNO == ''){
			Ego.error("请选择合同号",null);
			return;
		}
		seletShopNO("shopSelectPage?&constractNO="+constractNO+"");
	});
});

function check(){
	if($("#constractNO").val()==''){
		Ego.error("请选择合同编号",null);
		$("#sConstractSpan").focus();
		return false;
	}
	if($("#sShopNO").val()==""){
		Ego.error("请选择店铺",null);
		$("#shopSpan").focus();
		return false;
	}
	if($("#nLevel").val()==""){
		Ego.error("请选择店铺等级",null);
		$("#sLevelSpan").focus();
		return false;
	} 
	return true;
}

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

function shopContent(constractNO){
	var formData = new FormData();  
	formData.append("constractNO",constractNO);
 	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'shopJsonByAgent',
        data: formData,  
        async: false,
        error: function(request,errorThrown) {
            alert("Connection error"); 
        },
        success: function(data) {
        	var dataResult = JSON.parse(data); 
        	var isValid = dataResult.IsValid;
        	if(isValid){
        		var shopList = dataResult.DataList;
        		var shopHtml = "<li value=''><a id='' name='请选择' >请选择</a></li>";
        		var sShopNO = $("#sShopNO").val();
	       		for(var i = 0 ; i < shopList.length; i++){
	       			shopHtml += "<li><a id='"+shopList[i].sShopNO+"' name='"+shopList[i].sShopNO+"' >"+shopList[i].sShopName+"</a></li>";
	       			if(sShopNO == shopList[i].sShopNO){
	       				$("#shopSpan").text(shopList[i].sShopName);
	       			}
	       		}
	       		$("#shop-menu").html(shopHtml);
	       	}
        },
        complete : function(XMLHttpRequest, status){
        	$("#shop-menu li").click(function(){
        		var litext = $(this).find("a").text();
        		var livalue =  $(this).find("a").attr("id");  
        		$("#shopSpan").text(litext);
        		$("#sShopNO").val(livalue);
        	});
        }
    }); 
}

/**回调设置 店铺信息**/
function getShopNO(selectNo,selectName){
	$("#sShopNO").val(selectNo);
	$("#sShopNOName").val(selectName);
}

function shopLevelFrom(){ 
 	var formData = $('#shopLevelForm').serializeObject1();   
 	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'shopLevelSave',
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
	       			window.location.href = webHost + '/goods/price/shopLevelList';
	       		 });  
	       	}else{
	       		Ego.error(returnValue,null);
	       	}
        }
    }); 
}

/* 选择业务员窗口 */
function seletShopNO(content_url) {
	layer.open({
		type : 2,
		title : '选择店铺',
		shadeClose : true,
		shade : 0.6,
		area : [ '70%', '90%' ],
		content : content_url
	});
}