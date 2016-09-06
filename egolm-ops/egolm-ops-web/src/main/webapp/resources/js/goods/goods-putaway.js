jQuery(function($) {

	var isAll = false, //是否全选
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	$('.putaway table').footable({ //响应式表格初始化
		debug: true,
		breakpoints: {
			phone: 480,
			tablet: 991
		},
		log: function(message, type) {
			$bgRow = $table.find('tbody tr').not('.footable-row-detail');
			if (message == 'footable_initialized') {
				$bgRow.each(function(index) {
					if (index % 2 == 1) {
						$(this).css({
							'background': '#fbfbfb'
						});
					}
				});
			}
			if (message == 'footable_row_expanded' || message == 'footable_row_collapsed') {
				$bgRow.each(function(index) {
					if (index % 2 == 1) {
						$(this).css({
							'background': '#fbfbfb'
						});
					}
				});
			}
		}
	});
	
	//批量上架
	$('.batch .border-radius').on('click',function(){
		var type = $(this).attr('id');  //点击的操作  
		var goodsJson = {};
		var goodsArray = [];
		var isChecked = false;
		
		var goodsStatusArray = []; //商品状态的的数组，用于检查所选状态是否都一致
		var isUpGoodId = ""; //已上架的商品
		var isDownGoodId = ""; //已下架的商品
		$('.putaway table tbody input[type=checkbox]').each(function(index) { 
			if ($(this).attr('checked') == 'checked') {
				var goodsid = $(this).attr("value"); 
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
		//console.log("goodsStatusArray=="+goodsStatusArray);
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
	 
	$('.batch .chk').on('click', function() { //全选/取消全选  
		$(' .chk').each(function(index) {
			Checked.selectAll(this, isAll);
		}); 
		isAll = !isAll;
	});
	
	$('td a.edit').on('click', function(e) { //编辑
		e.stopPropagation(); 
	});

	 
	//加载列表
	loadAcGoodsMsg(1);
	//加载分类
	loadCategoryTree("category-menu-name","sCategoryNO");
	
	//加载区域
	 loadTOrgs("zoneCode-menu","4");
	 var sOrgNO_u = $("#sOrgNO").val();
	 if(sOrgNO_u != ''){  //查询返回后  
		  $("#zoneCode-menu").find("li").each(function(){
			  if($(this).attr("value")==sOrgNO_u){
				  $("#zoneCode-id").find("span").eq(0).text($(this).text()); 
			  }
		 }); 
	 }
	 $("#zoneCode-menu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#zoneCode-id").find("span").eq(0).text(litext);
		 $("#sOrgNO").val(livalue); 
	 });
	 
	 
	//加载品牌
	loadBrandMsg(); 
	 $("#query").on('click',function(){  //回车查询
		 loadAcGoodsMsg(1);
	});
});

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
        url:webHost+'/dealer/goods/updateNTag',
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
          	    	loadAcGoodsMsg(1);
          	     }); 
	          }else{
	                Ego.error(returnValue,null);
	          }  
        }
    });
}


//加载商品
function loadAcGoodsMsg(index){
	 
	  var goodsNameOrMainBarCode  = $("#goodsNameOrMainBarCode").val();
	  var sCategoryNO = $("#sCategoryNO").val();
	  var sBrandID = $("#sBrandID").val();  
	  var sOrgNO= $("#sOrgNO").val();
	  $('.table-box .batch .chk').attr('checked',false);
	  $('.table-box .batch .chk').parents('label:first').removeClass('checked'); 
 
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/dealer/goods/list',
        data:'goodsNameOrMainBarCode='+goodsNameOrMainBarCode+'&sCategoryNO='+sCategoryNO+'&sBrandID='+sBrandID+"&page.index="+index+"&sOrgNO="+sOrgNO+"&page.limit=10&page.limitKey=nGoodsID",
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
					 var agGoodsMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 agGoodsMsg+="<tr>";
						 agGoodsMsg+="	<td>";
						 agGoodsMsg+="		<label class='checked-wrap'>";
						 agGoodsMsg+="			<input type='checkbox' class='chk putaway_chk' id='nGoodsID' name = 'nGoodsID' value = '"+data.nGoodsID+"'/>";
						 agGoodsMsg+="          <input type='hidden'   id='nTag_"+data.nGoodsID+"' value='"+data.nTag+"'  />  "; 
						 agGoodsMsg+="          <input type='hidden'   id='tagName_"+data.nGoodsID+"' value='"+data.tagName+"'  />  "; 
						 agGoodsMsg+="          <input type='hidden'   id='sAgentContractNO_"+data.nGoodsID+"' value='"+data.sAgentContractNO+"'  />  "; 
						 agGoodsMsg+="          <input type='hidden'   id='nAgentID_"+data.nGoodsID+"' value='"+data.nAgentID+"'  />  "; 
						 agGoodsMsg+="			<span class='chk-bg'></span>";
						 agGoodsMsg+="		</label>";
						 agGoodsMsg+="	</td>";
						 agGoodsMsg+="	<td>"+data.nGoodsID+"</td>";
						 agGoodsMsg+="	<td>"+data.sMainBarcode+"</td>";
						 agGoodsMsg+="	<td>"+data.sGoodsDesc+"</td>";
						 agGoodsMsg+="	<td>"+data.sOrgDesc+"</td>";
						 agGoodsMsg+="	<td>"+data.nSaleUnits+"</td>";
						 agGoodsMsg+="	<td>"+data.nMinSaleQty+"</td>";
						 agGoodsMsg+="	<td>¥"+data.nRealSalePrice+" </td>";
						 agGoodsMsg+="	<td>"+data.sUnit+"</td>";
						  
						 if(data.tagName == 'up'){
							 agGoodsMsg+="	<td>已上架</td>";	 
						 }
						 if(data.tagName == 'down'){
							 agGoodsMsg+="	<td>已下架</td>";	 
						 }
						 agGoodsMsg+="	<td>"+data.sMemo+"</td>";
						 agGoodsMsg+="</tr>";
					 }
					 $("#agGoodsID").html(agGoodsMsg); 
					
					 $("input[name='nGoodsID']").off().on('click', function() { //单个选
						 Checked.checked(this); 
						 if($('.putaway_chk').filter('[checked=checked]').length == $('.putaway_chk').length) {
 							 $('.table-box .batch .chk').attr('checked',true);
							 $('.table-box .batch .chk').parents('label:first').addClass('checked'); 
						}else {
							$('.table-box .batch .chk').attr('checked',false);
							$('.table-box .batch .chk').parents('label:first').removeClass('checked'); 
						}
					 });
				 }else{
					 $("#agGoodsID").html(''); 
					 $('#goods-putaway-pagination-id').html("");
				 }
             	
             	//设置分页 
              	var pageHtml = ajaxPager.render(dataResult.page, function(page) {
    				loadAcGoodsMsg(page.index);
    			});  
              	
              	$('div').remove('.navigation_bar');
    			$('tfoot .batch').append(pageHtml);
    			
        	}else{
        		var returnValue = dataResult.ReturnValue;   
        		Ego.error(returnValue,null);
        	}
          	
        }
    });
}



/**加载品牌数据***/
function loadBrandMsg(){
	   $.ajax({
			type:'POST',
			url:webHost+'/goods/brand/list',
			dataType:"json",
			cache: false,
			error: function(request) {
	        	Ego.error("系统连接异常,请刷新后重试.",null);
	        },
			success: function (data) {
				 var isValid = data.IsValid;
				 if(isValid){
					 var dataList = data.DataList ;  
		         		if(dataList.length>0){ 
							 var brandMsg="";
							 for(var i = 0;i<dataList.length;i++){
								 var data = dataList[i];
								 brandMsg+="<li value='"+data.sBrandID+"'>"+data.sBrandName+"</li> "; 
							 }
							 $("#brand-name").html(brandMsg); 
							 $("#brand-name li").click(function(){ 
								 var litext = $(this).text();
								 var livalue =  $(this).attr("value");  
								 $("#brand-id").find("span").eq(0).text(litext);
								 $("#sBrandID").val(livalue); 
							 });
						 } 
				 }else{
					 var returnValue =  data.ReturnValue;
					 Ego.error(returnValue,null);
				 }
			} 
		});
}


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