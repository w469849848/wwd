$(document).ready(function(){
	var isAll = false;//true为全选，false为未选中
	
	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
		if($('.goods-check').filter('[checked=checked]').length == $('.goods-check').length) {
			$('.check-all').attr('checked',true);
			$('.check-all').parents('label:first').addClass('checked');
			isAll = true;
		}else {
			$('.check-all').attr('checked',false);
			$('.check-all').parents('label:first').removeClass('checked');
			isAll = false;
		}
	});

	$('.batch .chk').on('click', function() { //全选/取消全选
		Checked.selectAll(this, isAll);
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	
	var nAgentID = $("#nAgentID").val();
	var sAgentName = $("#sAgentName").val();
	if(sAgentName != ""){
		$("#agentSpan").text(sAgentName);
		warehouseContent(nAgentID);
	}
	
	$("#agent-menu li").click(function(){
		var litext = $(this).find("a").text();
		var livalue =  $(this).find("a").attr("id");  
		$("#agentSpan").text(litext);
		$("#sAgentName").val(litext);
		$("#nAgentID").val(livalue);
		if(livalue != ""){
			warehouseContent(livalue);
		}else{
			$("#warehouseSpan").text("全部");
			$("#categorySpan").text("全部");
			$("#brandSpan").text("全部");
		}
	});
	
	$("#warehouse-menu li").click(function(){
		var litext = $(this).find("a").text();
		var livalue =  $(this).find("a").attr("id");  
		$("#warehouseSpan").text(litext);
		$("#sWarehouseNO").val(livalue);
		if(livalue != ""){
			categoryContent(livalue);
		}else{
			$("#categorySpan").text("全部");
			$("#brandSpan").text("全部");
		}
	});
	
	$("#category-menu li").click(function(){
		var litext = $(this).find("a").text();
		var livalue =  $(this).find("a").attr("id");  
		$("#categorySpan").text(litext);
		$("#categoryID").val(livalue);
		if(livalue != ""){
			brandContent(livalue);
		}else{
			$("#categorySpan").text("全部");
			$("#brandSpan").text("全部");
		}
	});
	
	$("#brand-menu li").click(function(){
		var litext = $(this).find("a").text();
		var livalue =  $(this).find("a").attr("id");  
		$("#brandSpan").text(litext);
		$("#brandID").val(livalue);
	});
	
	$('td a.delete').on('click', function(e) { //删除弹窗 
		var nLevel = $(this).attr("nLevelId");
		var contractNO = $(this).attr("sAgentContractNO");
		var goodsID = $(this).attr("goodsID");
		Ego.alert("是否确认重置当前商品等级价格设置？",function(){  
			goodsPriceLevelReset(contractNO,nLevel,goodsID);
		}); 
	}); 
	
	
	//批量上架
	$('.batch .up_down').on('click',function(){
		var type = $(this).attr('id');  //点击的操作  
		var goodsJson = {};
		var goodsArray = [];
		var isChecked = false;
		
		var goodsStatusArray = []; //商品状态的的数组，用于检查所选状态是否都一致
		var isUpGoodId = ""; //已上架的商品
		var isDownGoodId = ""; //已下架的商品
		$('.whgoods table tbody input[type=checkbox]').each(function(index) { 
			if ($(this).attr('checked') == 'checked') {
				var goodsid = $(this).attr("data-id"); 
				var tagName = $("#tagName_"+goodsid).val(); 
				
 				goodsStatusArray.push(tagName);
				if(type == 'up' && tagName == 'up'){ //点击的上架事件，并且当前商品也为上架 ，则不进行操作
					isUpGoodId +=goodsid+",";
				}else if(type == 'down' && tagName == 'down'){
					isDownGoodId +=goodsid+",";
				}else{
					isChecked = true;
					goodsArray.push(createJSON(goodsid));
				}
			}
		}); 
		console.log("goodsStatusArray=="+goodsStatusArray);
		var result = isRepeat(goodsStatusArray);   //去除重复数据
 
		if(result.length>1){ 
			Ego.error("所选商品状态不一致,无法进行批量操作",null);
		}else{
			if(isUpGoodId != ''){ 
				Ego.error("商品"+isUpGoodId+"已上架",null);
			}else if(isDownGoodId !=''){ 
				Ego.error("商品"+isDownGoodId+"已下架",null);
			}else{
				if(isChecked){
					goodsJson["type"]=type; 
					goodsJson["acGoodList"]=goodsArray; 
					updateNTag(JSON.stringify(goodsJson));
				}else{
					Ego.error("请选择需要操作的数据",null);
				}
			} 
		} 
		
	});
	
	$("#query").on('click',function(){ //查询 
		if(checkQuery()){
			$("#page_index").val("1");
			$("#limitPageForm").submit();
		}
	});
	
});

//去除重复数据
function isRepeat(arr) {
	    var result = [], hash = {};
	    for (var i = 0, elem; (elem = arr[i]) != null; i++) {
	        if (!hash[elem]) {
	            result.push(elem);
	            hash[elem] = true;
	        }
	    }
	    return result;
}

//拼装上下架的JSON
function createJSON(goodsId){
	var goodId = {};
	goodId["nGoodId"]=goodsId;
	goodId["nTag"]=$("#nTag_"+goodsId).val();
	goodId["sAgentContractNO"]=$("#sAgentContractNO_"+goodsId).val();
	goodId["nAgentID"]=$("#nAgentID_"+goodsId).val();
	return goodId;
}

//操作上下架
function updateNTag(jsonStr){ 
	$.ajax({
		cache: false,
		contentType: "application/json; charset=utf-8",  
        type: "POST",
        dataType: "json",
        url:webHost+'/agent/warehouse/updateNTag',
        data: jsonStr,  
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {
       	    var isValid = data.IsValid;
          	var returnValue = data.ReturnValue;  
          	  if(isValid){
          	     Ego.success(returnValue,function(){
          	    	window.location.href=webHost + '/agent/warehouse/warehouseGoodsList';
          	     }); 
	          }else{
	                Ego.error(returnValue,null);
	          }  
        }
    });
}

function savePage(){
	if(checkPage()){
		var datas = {};
		datas["goodsList"] = handlePageData();
		$.ajax({
	        cache: false,
	        contentType: "application/json; charset=utf-8",  
	        type: "POST",
	        dataType: "json",
	        url:'warehouseGoodsListSave',
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
	      			   window.location.href = webHost + '/agent/warehouse/warehouseGoodsList';
	      		  }); 
		     	}else{
		     		 Ego.error(returnValue,null);
		     	}
	        }
	    });   
	}
}

function categoryContent(sWarehouseNO){
	var formData = new FormData();  
	formData.append("sWarehouseNO",sWarehouseNO);
 	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'categoryByWarehouse',
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
	       				brandContent(categoryList[i].categoryID);
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
        		if(livalue != ""){
        			brandContent(livalue);
        		}else{
        			$("#categorySpan").text("全部");
        			$("#brandSpan").text("全部");
        		}
        	});
        }
    }); 
}

function brandContent(sCategoryNO){
	var formData = new FormData();  
	formData.append("sCategoryNO",sCategoryNO);
	formData.append("sWarehouseNO",$("#sWarehouseNO").val());
 	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'brandByCategory',
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

function warehouseContent(nAgentID){
	var formData = new FormData();  
	formData.append("nAgentID",nAgentID);
 	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'warehouseByAgent',
        data: formData,  
        async: false,
        error: function(request,errorThrown) {
            alert("Connection error"); 
        },
        success: function(data) {
        	var dataResult = JSON.parse(data); 
        	var isValid = dataResult.IsValid;
        	if(isValid){
        		var whList = dataResult.DataList;
        		var whHtml = "<li value=''><a id='' name='全部' >全部</a></li>";
        		var sWarehouseNO = $("#sWarehouseNO").val();
	       		for(var i = 0 ; i < whList.length; i++){
	       			whHtml += "<li><a id='"+whList[i].sWarehouseNO+"' name='"+whList[i].sWarehouseNO+"' >"+whList[i].sWarehouseName+"</a></li>";
	       			if(sWarehouseNO == whList[i].sWarehouseNO){
	       				categoryContent(whList[i].sWarehouseNO);
	       				$("#warehouseSpan").text(whList[i].sWarehouseName);
	       			}
	       		}
	       		$("#warehouse-menu").html(whHtml);
	       	}
        },
        complete : function(XMLHttpRequest, status){
        	$("#warehouse-menu li").click(function(){
        		var litext = $(this).find("a").text();
        		var livalue =  $(this).find("a").attr("id");  
        		$("#warehouseSpan").text(litext);
        		$("#sWarehouseNO").val(livalue);
        		if(livalue != ""){
        			categoryContent(livalue);
        		}else{
        			$("#categorySpan").text("全部");
        			$("#brandSpan").text("全部");
        		}
        	});
        	
        }
    }); 
}

function handlePageData(){
	var pageList = [];
	$(".footable").find("tbody").find("tr").each(function(){
		var dataDtl={};
		var gid = $(this).find("input[name='gid']").val();
		var acNO = $(this).find("#sAgentContractNO_"+gid).val();
		var whNO = $(this).find("input[name='whNO']").val();
		var nStockQty = $(this).find("input[name='nStockQty']").val();
		var nPrice = $(this).find("input[name='nPrice']").val();
		var sUnit = $(this).find("input[name='sUnit']").val();
		
		dataDtl["acNO"] =  acNO;
		dataDtl["gid"] =  gid;
		dataDtl["whNO"] =  whNO;
		dataDtl["nStockQty"] =  nStockQty;
		dataDtl["nPrice"] =  nPrice;
		dataDtl["sUnit"] =  sUnit;
		
		pageList.push(dataDtl);
	});
	
	return pageList;
}

function checkPage(){
	var chkResult = true;
	if($(".footable").find("tbody").find("tr").size() > 0){
		$(".footable").find("tbody").find("tr").each(function(){
			var nStockQty = $(this).find("input[name='nStockQty']");
			var nPrice = $(this).find("input[name='nPrice']");
			var sUnit = $(this).find("input[name='sUnit']");
			if(nStockQty.val() == ""){
				Ego.error("库存未填写",null);
				nStockQty.focus();
				chkResult = false;
				return false;
			}else{
				var r = /^[0-9]*[1-9][0-9]*$/;
				if(!r.test(nStockQty.val())){
					Ego.error("请填写正确的库存数量",null);
					nStockQty.focus();
					chkResult = false;
					return false;
				}
			}
			
			if(nPrice.val() == ""){
				Ego.error("零售价格未填写",null);
				nStockQty.focus();
				chkResult = false;
				return false;
			}else{
				if(isNaN(nPrice.val())){
					Ego.error("请填写正确的零售价格",null);
					nPrice.focus();
					chkResult = false;
					return false;
				}
			}
			
			if(sUnit.val() == ""){
				Ego.error("零售单位未填写",null);
				sUnit.focus();
				chkResult = false;
				return false;
			}
		});
	}else{
		Ego.error("没有要保存的数据！",null);
		return false;
	}
	
	return chkResult;
}

function checkQuery(){
	if($("#nAgentID").val() == ""){
		Ego.error("请选择经销商",null);
		$("#agentSpan").focus();
		return false;
	}
	
	if($("#sWarehouseNO").val() == "" ){
		Ego.error("请选择仓库",null);
		$("#warehouseSpan").focus();
		return false;
	}
	return true;
}

