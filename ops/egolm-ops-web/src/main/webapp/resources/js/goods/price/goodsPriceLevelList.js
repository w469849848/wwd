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
		categoryContent(constractNo);
		brandContent(constractNo);
		baseLevelContent(constractNo);
		footBaseLevelContent(constractNo);
	}
	
	$('td a.delete').on('click', function(e) { //删除弹窗 
		var nLevel = $(this).attr("nLevelId");
		var contractNO = $(this).attr("sAgentContractNO");
		var goodsID = $(this).attr("goodsID");
		Ego.alert("是否确认重置当前商品等级价格设置？",function(){  
			goodsPriceLevelReset(contractNO,nLevel,goodsID);
		}); 
	}); 
	
	$("#query").on('click',function(){ //查询 
		if(checkQuery()){
			$("#page_index").val("1");
			$("#limitPageForm").submit();
		}
	});
	
	$("#constract-menu li").click(function(){
		var litext = $(this).find("a").text();
		var livalue =  $(this).find("a").attr("id");  
		$("#sConstractSpan").text(litext);
		$("#constractNO").val(livalue);
		if(livalue != ""){
			categoryContent(livalue);
			brandContent(livalue);
			baseLevelContent(livalue);
			footBaseLevelContent(livalue);
		}else{
			$("#categorySpan").text("全部");
			$("#brandSpan").text("全部");
			$("#categoryID").val("");
			$("#brandID").val("");
		}
	});
	

	$("#category-menu li").click(function(){
		var litext = $(this).find("a").text();
		var livalue =  $(this).find("a").attr("id");  
		$("#categorySpan").text(litext);
		$("#categoryID").val(livalue);
	});
	
	$("#brand-menu li").click(function(){
		var litext = $(this).find("a").text();
		var livalue =  $(this).find("a").attr("id");  
		$("#brandSpan").text(litext);
		$("#brandID").val(livalue);
	});

});

function levelChange(obj){
	var disRate = $(obj).find("option:selected").attr("disRate");
	var realPrice = $(obj).parents('tr:first').find('#nSalePrice').attr("oldValue"); 
//	alert(FloatDiv(parseFloat(disRate), 100));
//	var salePrice = FloatMul(parseFloat(realPrice),FloatDiv(parseFloat(disRate), 100));
	if(disRate){
		$(obj).parents('tr:first').find('#nSalePrice').val(parseFloat(realPrice)*parseFloat(disRate)/100); 
	}else{
		$(obj).parents('tr:first').find('#nSalePrice').val(""); 
	}
}
function savePage(){
	if(checkPage()){
		var datas = {};
		datas["goodsPriceList"] = handlePageData();
		$.ajax({
	        cache: false,
	        contentType: "application/json; charset=utf-8",  
	        type: "POST",
	        dataType: "json",
	        url:'goodsPriceLevelSave',
	        data: JSON.stringify(datas),  
	        async: false,
	        error: function(request,errorThrown) {
	        	Ego.error("系统连接异常,请刷新后重试.",null);
	        },
	        success: function(data) {
	        	var isValid = data.IsValid;
	        	var returnValue = data.ReturnValue;       	 	 
	        	
	        	if(isValid){
	   			   Ego.success(returnValue,function(){
	      			   window.location.href = webHost + '/goods/price/goodsPriceLevelList';
	      		  }); 
		     	}else{
		     		 Ego.error(returnValue,null);
		     	}
	        }
	    });   
	}
}

function categoryContent(constractNO){
	var formData = new FormData();  
	formData.append("constractNO",constractNO);
 	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'categoryByConstract',
        data: formData,  
        async: false,
        error: function(request,errorThrown) {
            alert("Connection error"); 
        },
        success: function(data) {
        	var dataResult = JSON.parse(data); 
        	var isValid = dataResult.IsValid;
        	if(isValid){
        		var categoryList = dataResult.DataList;
        		var categoryHtml = "<li value=''><a id='' name='全部' >全部</a></li>";
        		var categoryID = $("#categoryID").val();
	       		for(var i = 0 ; i < categoryList.length; i++){
	       			categoryHtml += "<li><a id='"+categoryList[i].categoryID+"' name='"+categoryList[i].categoryID+"' >"+categoryList[i].categoryName+"</a></li>";
	       			if(categoryID == categoryList[i].categoryID){
	       				$("#categorySpan").text(categoryList[i].categoryName);
	       			}
	       		}
	       		$("#category-menu").html(categoryHtml);
	       	}
        },
        complete : function(XMLHttpRequest, status){
        	$("#category-menu li").click(function(){
        		var litext = $(this).find("a").text();
        		var livalue =  $(this).find("a").attr("id");  
        		$("#categorySpan").text(litext);
        		$("#categoryID").val(livalue);
        	});
        }
    }); 
}

function brandContent(constractNO){
	var formData = new FormData();  
	formData.append("constractNO",constractNO);
 	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'brandByConstract',
        data: formData,  
        async: false,
        error: function(request,errorThrown) {
            alert("Connection error"); 
        },
        success: function(data) {
        	var dataResult = JSON.parse(data); 
        	var isValid = dataResult.IsValid;
        	if(isValid){
        		var brandList = dataResult.DataList;
        		var brandHtml = "<li value=''><a id='' name='全部' >全部</a></li>";
        		var brandID = $("#brandID").val();
	       		for(var i = 0 ; i < brandList.length; i++){
	       			brandHtml += "<li><a id='"+brandList[i].brandID+"' name='"+brandList[i].brandID+"' >"+brandList[i].brandName+"</a></li>";
	       			if(brandID == brandList[i].brandID){
	       				$("#brandSpan").text(brandList[i].brandName);
	       			}
	       		}
	       		$("#brand-menu").html(brandHtml);
	       	}
        },
        complete : function(XMLHttpRequest, status){
        	$("#brand-menu li").click(function(){
        		var litext = $(this).find("a").text();
        		var livalue =  $(this).find("a").attr("id");  
        		$("#brandSpan").text(litext);
        		$("#brandID").val(livalue);
        	});
        }
    }); 
}

function footBaseLevelContent(constractNO){
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
	       			levelHtml += "<li><a id='"+levelList[i].nLevel+"' name='"+levelList[i].nLevel+"' nDisRate='"+levelList[i].nDisRate+"'>"+levelList[i].sLevelName+"</a></li>";
	       		}
	       		$("#foot-shop-menu").html(levelHtml);
	       	}
        },
        complete : function(XMLHttpRequest, status){
        	$("#foot-shop-menu li").click(function(){
        		var litext = $(this).find("a").text();
        		var livalue =  $(this).find("a").attr("id");  
        		var lidisrate =  $(this).find("a").attr("nDisRate");  
        		$("#foot-shopSpan").text(litext);
        		$("#foot-nlevel").val(livalue);
        		$("#foot-disRate").val(lidisrate);
        	});
        }
    }); 
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


function goodsPriceLevelReset(contractNO,nLevel,goodsID){
	var formData = new FormData();  
	formData.append("lv",nLevel);
	formData.append("gid",goodsID);
	formData.append("acNO",contractNO);
 	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'goodsPriceLevelReset',
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
	       			window.location.href = webHost + '/goods/price/goodsPriceLevelList';
	       		 });  
	       	}else{
	       		Ego.error(returnValue,null);
	       	}
        }
    }); 
}

function handlePageData(){
	var pageList = [];
	$(".footable").find("tbody").find("tr").each(function(){
		var dataDtl={};
		var acNO = $(this).find("input[name='acNO']").val();
		var gid = $(this).find("input[name='gid']").val();
		var salePrice = $(this).find("input[name='nSalePrice']").val();
		var oldLevel = $(this).find("input[name='oldLevel']").val();
		var level = $(this).find("#s-level").val();
		var oldSalePrice = $(this).find("input[name='nSalePrice']").attr("oldValue");
		
		if(!level){
			level = oldLevel;
		}
		
		dataDtl["acNO"] =  acNO;
		dataDtl["gid"] =  gid;
		dataDtl["level"] =  level;
		dataDtl["oldLevel"] =  oldLevel;
		dataDtl["salePrice"] =  salePrice;
		dataDtl["realSalePrice"] =  oldSalePrice;
		
		pageList.push(dataDtl);
	});
	
	return pageList;
}

function checkPage(){
	var chkResult = true;
	if($(".footable").find("tbody").find("tr").size() > 0){
		$(".footable").find("tbody").find("tr").each(function(){
			var level = $(this).find("#s-level");
			var salePrice = $(this).find("#nSalePrice");
			if(level){
				level = $(this).find("#oldLevel");
			}
			if(level.val() != "" && salePrice.val() != ""){
				if(salePrice.val() == ""){
					Ego.error("价格未设置",null);
					salePrice.focus();
					chkResult = false;
					return false;
				}
				if(level.val() == ""){
					Ego.error("等级未设置",null);
					level.focus();
					chkResult = false;
					return false;
				}
			}
		});
	}else{
		Ego.error("没有要保存的数据！",null);
		return false;
	}
	
	return chkResult;
}

function checkQuery(){
	if($("#constractNO").val() == ""){
		Ego.error("请选择合同编号",null);
		$("#constractNO").focus();
		return false;
	}
	
	if($("#shopLevel").val() == "" ){
		Ego.error("请选择等级",null);
		$("#shopLevel").focus();
		return false;
	}
	return true;
}

