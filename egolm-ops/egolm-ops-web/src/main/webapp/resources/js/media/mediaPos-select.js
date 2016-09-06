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
	
	//广告位区域
	loadCommonMsg("ap-sale-type-menu","sApSaleType");
	$("#ap-sale-type-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#ap-sale-type-id").find("span").eq(0).text(litext); 
		 $("#sApSaleTypeID").val(livalue);
		 
	 });
	//店铺类型 
	loadCommonMsg("ScopeType-menu","ScopeType");
	$("#ScopeType-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#ScopeType-id").find("span").eq(0).text(litext); 
		 $("#sScopeTypeID").val(livalue); 
	 });
	
	//区域
	loadTOrgsAndAll("ap-zoneCode-memu","4","loadAll");
	$("#ap-zoneCode-memu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#ap-zoneCode-id").find("span").eq(0).text(litext);
		 $("#sZoneCodeID").val(livalue);  
	 });
	
	
	$("#query").on('click',function(){
		loadApByApSaleType(1);
	});
	
	var type = $("#type").val(); 
	if(type == 'add'){
		var sZoneCodeID = $("#sZoneCodeID").val(); // 区域 
		var sApSaleTypeID = $("#sApSaleTypeID").val(); //广告位类型
		
		$("#ap-zoneCode-memu").find("li").each(function(){
			  if($(this).attr("value")==sZoneCodeID){
				  $("#ap-zoneCode-id").find("span").eq(0).text($(this).text());
				  $("#ap-zoneCode-memu").html("");
 			  }
		 }); 
		
		$("#ap-sale-type-menu").find("li").each(function(){
			  if($(this).attr("value")==sApSaleTypeID){
				  $("#ap-sale-type-id").find("span").eq(0).text($(this).text());
				  $("#ap-sale-type-menu").html("");
			  }
		 }); 
	}
});

 

function bindClicked(selectValue,selectName,selectWidth,selectHeight){  
	parent.getAdPosNO(selectValue,selectName,selectWidth,selectHeight);
	var index = parent.layer.getFrameIndex(window.name); // 先得到当前iframe层的索引
	parent.layer.close(index); // 再执行关闭
}


//根据广告位置获取广告位
function loadApByApSaleType(index){
	var sApSaleTypeID= $("#sApSaleTypeID").val();
	var sZoneCodeID = $("#sZoneCodeID").val();
	var sScopeTypeID = $("#sScopeTypeID").val();
	var sApTitle = $("#sApTitle").val();
	$.ajax({
      cache: false,
      type: "POST",
      url:webHost+'/media/mediaPos/listPos',
      data:'sApSaleTypeID='+sApSaleTypeID+'&sApTitle='+sApTitle+'&sZoneCodeID='+sZoneCodeID+'&sScopeTypeID='+sScopeTypeID+'&page.index='+index+'',
      async: false,
      error: function(request) {
      	Ego.error("系统异常,请刷新后重试.",null);
      },
      success: function(data) {
      	var dataResult = eval("(" + data + ")");
       	var isValid = dataResult.IsValid; 
      	if(isValid){
      		var dataList = dataResult.DataList; 
      		if(dataList.length>0){ 
					 var apMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i]; 
						 var desc = data.sApTitle;
						 var trimApTitleDesc = desc.replace(/\s+/g,""); 						 
						 
						 apMsg+="<tr onclick= bindClicked('"+data.nApID+"','"+trimApTitleDesc+"','"+data.nApWidth+"','"+data.nApHeight+"') title='"+data.nApID+"' selectValue='"+data.nApID+"' selectName='"+desc+"'>"; 
 						 apMsg+="	<td>"+data.nApID+"</td>"; 
						 apMsg+="	<td>"+desc+"</td> "; 
						 apMsg+="	<td>"+data.sApSaleType+"</td> "; 
						 apMsg+="	<td>"+data.sZoneCode+"</td> ";  
						 apMsg+="	<td>"+data.sScopeType+"</td> ";  
						 apMsg+="</tr>"; 
					 }
					 $("#select-msg-id").html(apMsg);
					 
				 }else{
					 $("#select-msg-id").html("<tr> <td colspan='4' style='text-align: center;'>暂无对应广告位</td> </tr>");
 				 }
        	}else{
      		var returnValue = dataResult.ReturnValue;  
      		Ego.error(returnValue,null);
      	 }
      	 //设置分页  
     	var pageHtml = ajaxPager.render(dataResult.page, function(page) {
     		loadApByApSaleType(page.index);
		   });
     	$('div').remove('.navigation_bar');
	    $('#select-page').append(pageHtml);
      }
  }); 
}
 