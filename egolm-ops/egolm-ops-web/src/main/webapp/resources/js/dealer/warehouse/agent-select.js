$(document).ready(function(){
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
	
		loadShopList(1);
	 
	$("#query").on('click',function(){
		loadShopList(1);
	});
});

 

function bindClicked(selectValue,selectName){  
	parent.getAgentNO(selectValue,selectName);
	var index = parent.layer.getFrameIndex(window.name); // 先得到当前iframe层的索引
	parent.layer.close(index); // 再执行关闭
} 

//加载经销商商品类据
function loadShopList(index){
	 var sAgentName = $("#sAgentName").val();
 	 
	$.ajax({
      cache: false,
      type: "POST",
      url:webHost+'/agent/warehouse/agentSelectList', 
      data:'page.index='+index+'&AgentName='+sAgentName, 
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
					 var shopMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i]; 
						 shopMsg += "<tr style='cursor:pointer;' onclick= bindClicked('"+data.nAgentID+"','"+data.sAgentName+"') title='"+data.sAgentNO+"' agentNO='"+data.sAgentNO+"' agentName='"+data.sAgentName+"'> "
							 + "							<td></td> "
							 + "							<td>"+data.sAgentNO+"</td> "
							 + "							<td>"+data.sAgentName+"</td> "
							 + "							<td>"+data.sAgentTitle+"</td> "
							 + "							<td> ";
							 if(data.nTag == 0){
								 shopMsg += "									<span class='state'><img "
									 + "										src='"+webHost+"/resources/egolm/assets/images/circle.png' /> "
									 + "									</span>未禁用 ";
							 }else if(data.nTag == 1){
								 shopMsg+= "									<span class='state'><img "
									 + "										src='"+webHost+"/resources/egolm/assets/images/close.png' /> "
									 + "									</span>已禁用 ";
							 }
							 shopMsg+= "							</td> "
							 + "						</tr>";
						 $("#select_msg_id").html(shopMsg);
					 }
				 }else{
					 $("#select_msg_id").html("<tr> <td colspan='4' style='text-align: center;'>暂无经销商</td> </tr>");
				 }
       	}else{
       		var returnValue = dataResult.ReturnValue ;
       		Ego.error(returnValue,null);
       	}
      	 //设置分页  
     	var pageHtml = ajaxPager.render(dataResult.page, function(page) {
     			loadShopList(page.index);
		   });
     	$('div').remove('.navigation_bar');
	    $('#select-page').append(pageHtml);
      }
  }); 
} 