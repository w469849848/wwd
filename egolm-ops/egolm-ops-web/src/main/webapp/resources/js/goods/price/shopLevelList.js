$(document).ready(function(){
	var isAll = false;//true为全选，false为未选中
	
	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});

	$('.batch .chk').on('click', function() { //全选/取消全选
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	
	var constractNo = $("#constractNO").val();
	if(constractNo != ''){
		$("#sConstractSpan").text(constractNo);
		baseLevelContent(constractNo);
	}
	
//	var shopLevel = $("#shopLevel").val();
//	if(shopLevel != ''){
//		$("#shopLevelSpan").text();
//	}
	
	$('td a.delete').on('click', function(e) { //删除弹窗 
		var nLevel = $(this).attr("nLevelId");
		var contractNO = $(this).attr("sAgentContractNO");
		var shopNO = $(this).attr("sShopNO");
		Ego.alert("是否确认删除当前商铺等级？",function(){  
			shopLevelDel(nLevel,contractNO,shopNO);
		}); 
	}); 
	
	$("#query").on('click',function(){ //查询 
		$("#page_index").val("1");
		$("#limitPageForm").submit();
	});
	
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
	
	$("#shopLevel-menu li").click(function(){
		var litext = $(this).find("a").text();
		var livalue =  $(this).find("a").attr("id");  
		$("#shopLevelSpan").text(litext);
		$("#shopLevel").val(livalue);
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
        		var levelHtml = "<li value=''><a id='' name='全部' >全部</a></li>";
        		var shopLevel = $("#shopLevel").val();
	       		for(var i = 0 ; i < levelList.length; i++){
	       			levelHtml += "<li><a id='"+levelList[i].nLevel+"' name='"+levelList[i].nLevel+"' >"+levelList[i].sLevelName+"</a></li>";
	       			if(shopLevel == levelList[i].nLevel){
	       				$("#shopLevelSpan").text(levelList[i].sLevelName);
	       			}
	       		}
	       		$("#shopLevel-menu").html(levelHtml);
	       	}
        },
        complete : function(XMLHttpRequest, status){
        	$("#shopLevel-menu li").click(function(){
        		var litext = $(this).find("a").text();
        		var livalue =  $(this).find("a").attr("id");  
        		$("#shopLevelSpan").text(litext);
        		$("#shopLevel").val(livalue);
        	});
        }
    }); 
}

function shopLevelDel(nLevel,contractNO,shopNO){
	var formData = new FormData();  
	formData.append("nLevel",nLevel);
	formData.append("sShopNO",shopNO);
	formData.append("constractNO",contractNO);
	formData.append("type","del"); 
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