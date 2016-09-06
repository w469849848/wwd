jQuery(function($) {
	var footable = null, $row = null, isAll = false,
	// true为全选，false为未选中
	deleteType = true,
	// true为删除一行,false为批量删除
	$table = $('.table-box table'),
	// 获取表格元素
	$bgRow = null; 
	$('.cust table').footable(
			{ // 响应式表格初始化
				debug : true,
				breakpoints : {
					phone : 600,
					tablet : 980
				},
				log : function(message, type) {
					$bgRow = $table.find('tbody tr').not(
							'.footable-row-detail');
					if (message = 'footable_initialized') {
						$bgRow.each(function(index) {
							if (index % 2 == 1) {
								$(this).css({
									'background' : '#fbfbfb'
								});
							}
						});
					}
					if (message == 'footable_row_expanded'
							|| message == 'footable_row_collapsed') {
						$bgRow.each(function(index) {
							if (index % 2 == 1) {
								$(this).css({
									'background' : '#fbfbfb'
								});
							}
						});
					}
				}
			});
	
	var sAdJumpTypeId = $("#sAdJumpTypeId").val();
	if(sAdJumpTypeId == 'goods'){
		loadAgentGoods(1);
	}
	if(sAdJumpTypeId == 'brand'){
		loadBrandMsg(1);	
	}
	 
	$("#query").on('click',function(){
		var sAdJumpTypeId = $("#sAdJumpTypeId").val();
		if(sAdJumpTypeId == 'goods'){
			loadAgentGoods(1);
		}
		if(sAdJumpTypeId == 'brand'){
			loadBrandMsg(1);	
		}
	});
});

 

function bindClicked(selectValue,selectName){  
	parent.getJumpNO(selectValue,selectName);
	var index = parent.layer.getFrameIndex(window.name); // 先得到当前iframe层的索引
	parent.layer.close(index); // 再执行关闭
}


/**加载品牌数据***/
function loadBrandMsg(index){
	   	var  sAgentBrandSelect = $("#sAgentBrandSelect").val();
		 var nAgentID  = $("#nAgentID").val();
		 var sOrgNO =  $("#sOrgNO").val();  
		 
	   $.ajax({
			type:'POST',
			url:webHost+'/dealer/goods/listBrandByIdAndOrgId', 
			  data:'page.index='+index+'&nAgentID='+nAgentID+'&sOrgNO='+sOrgNO+'&sAgentBrandSelect='+sAgentBrandSelect, 
			cache: false,
			error: function(request) {
	        	Ego.error("系统连接异常,请刷新后重试.",null);
	        },
			success: function (data) { 
				var dataResult = eval("(" + data + ")");
				 var isValid = dataResult.IsValid;
				 if(isValid){
					 var dataList = dataResult.DataList ;  
		         		if(dataList.length>0){ 
							 var brandMsg="";
							 for(var i = 0;i<dataList.length;i++){
								 var data = dataList[i];  
								 brandMsg+="<tr onclick= bindClicked('"+data.sBrandID+"','"+data.sBrand+"') title='"+data.sBrandID+"' selectValue='"+data.sBrandID+"' selectName='"+data.sBrand+"'>"; 
								 brandMsg+="	<td></td>"; 
								 brandMsg+="	<td>"+data.sBrandID+"</td>"; 
								 brandMsg+="	<td>"+data.sBrand+"</td> ";  
								 brandMsg+="</tr>"; 
							 }
							 $("#select_msg_id").html(brandMsg);
							
						 }else{
							 $("#select_msg_id").html("<tr> <td colspan='3' style='text-align: center;'>暂无对应品牌</td> </tr>");
						 }
				 }else{
					 var returnValue = dataResult.ReturnValue ;
					 Ego.error(returnValue,null);
				 }
			   
		        //设置分页  
		        	var pageHtml = ajaxPager.render(dataResult.page, function(page) {
		        		loadBrandMsg(page.index);
		 		   });
		        	$('div').remove('.navigation_bar');
		 		   $('#select-page').append(pageHtml);
			} 
	
		});
}




//加载经销商商品类据
function loadAgentGoods(index){
	var sAdJumpTypeId = $("#sAdJumpTypeId").val();//链接类型为商品时
	if(sAdJumpTypeId != 'goods'){
		return;
	}
	
	 var nAgentID  = $("#nAgentID").val();
	 var sOrgNO =  $("#sOrgNO").val();
	 var sAgentGoodsSelect = $("#sAgentGoodsSelect").val();
	 							 
	 if(sOrgNO == ''){ 
		 Ego.error("请选择广告区域",null);
		 return;
	 }
	 if(nAgentID == ''){ 
		 Ego.error("请选择合同编码",null);
		 return;
	 }
	 
 	 
	$.ajax({
      cache: false,
      type: "POST",
      url:webHost+'/dealer/goods/listGoodsByIdAndOrgId', 
      data:'page.index='+index+'&nAgentID='+nAgentID+'&sOrgNO='+sOrgNO+'&sAgentGoodsSelect='+sAgentGoodsSelect, 
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
					 var goodsMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i]; 
						 var desc = data.sGoodsDesc;
						 var trimGoodsDesc = desc.replace(/\s+/g,""); 
						 goodsMsg+="<tr onclick= bindClicked('"+data.nGoodsID+"','"+trimGoodsDesc+"') title='"+data.nGoodsID+"' selectValue='"+data.nGoodsID+"' selectName='"+desc+"'>"; 
						 goodsMsg+="	<td></td>"; 
						 goodsMsg+="	<td>"+data.nGoodsID+"</td>"; 
						 goodsMsg+="	<td>"+desc+"</td> "; 
						 goodsMsg+="	<td>"+data.sMainBarcode+"</td> "; 
						 goodsMsg+="</tr>"; 
					 }
					 $("#select_msg_id").html(goodsMsg);
				 }else{
					 $("#select_msg_id").html("<tr> <td colspan='4' style='text-align: center;'>暂无对应商品</td> </tr>");
				 }
       	}else{
       		var returnValue = dataResult.ReturnValue ;
       		Ego.error(returnValue,null);
       	}
      	 //设置分页  
     	var pageHtml = ajaxPager.render(dataResult.page, function(page) {
     			loadAgentGoods(page.index);
		   });
     	$('div').remove('.navigation_bar');
	    $('#select-page').append(pageHtml);
      }
  }); 
} 