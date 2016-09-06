var isAll = false;
$(document).ready(function(){
	var footable = null, $row = null,
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
		loadWarehouseList();
});

//加载经销商商品类据
function loadWarehouseList(){
	var districtIDs = $("#districtIDs").val();
	$.ajax({
      cache: false,
      type: "POST",
      url:webHost+'/city/manage/priorityManageSet', 
      data:'districtIDs='+districtIDs, 
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
					 var moduleItems= "";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i]; 
						 shopMsg += "<li val='"+data.sWarehouseNO+"'> "
							 + "							<p class='row module'> "
							 + "								<small class='col-xs-10 col-sm-10 col-md-12 col-lg-12'> <label "
							 + "									class='col-xs-4 col-sm-4'><input class='border border-radius' disabled='disabled' value='"+data.sWarehouseNO+"'></input> "
							 + "								</label> "
							 + "								<label "
							 + "									class='col-xs-4 col-sm-4'><input class='border border-radius' disabled='disabled' value='"+data.sWarehouseName+"'></input> "
							 + "								</label> "
							 + "								<label "
							 + "									class='col-xs-4 col-sm-4'><input class='border border-radius' disabled='disabled' value='"+data.sWarehouseType+"'></input> "
							 + "								</label> "
							 + "								</small> "
							 + "							</p> "
							 + "						</li> ";
						 if(moduleItems == ""){
							 moduleItems = data.sWarehouseNO;
						 }else{
							 moduleItems = moduleItems + "," +data.sWarehouseNO;
						 }
						 //console.log(shopMsg);
						 $("#moduleItems").val(moduleItems);
					 }

					 $("#sortItems").html(shopMsg);
				 }else{
					 $("#sortItems").html("<li>暂无仓库信息</li>");
				 }
       	}else{
       		var returnValue = dataResult.ReturnValue ;
       		Ego.error(returnValue,null);
       	}
      }
  }); 
} 

function save(){
	if(checkWarehouse()){
		var formData = new FormData();  
		formData.append("moduleItems",$("#moduleItems").val().trim());
		formData.append("districtIDs",$("#districtIDs").val().trim());
	 	$.ajax({
	        cache: false,
	        contentType:false,
	        processData : false,
	        type: "POST",
	        url:'priorityManageSetSave',
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
	        			var index = parent.layer.getFrameIndex(window.name); // 先得到当前iframe层的索引
	        			parent.layer.close(index); // 再执行关闭
	        			//parent.location.href = webHost + '/city/manage/priorityManageList';
		      		}); 
			     }else{
			    	 Ego.error(returnValue,null);
			     }
	        }
	 	});
	}
}

function checkWarehouse(){
	if($("#sortItems").find("li").size() > 0){
		var moduleArray = [];
		$("#sortItems").find("li").each(function(i){
			moduleArray.push($(this).attr("val"));
		});
		$("#moduleItems").val(moduleArray.join(","));
		console.log($("#moduleItems").val());
		moduleArray = null;
		return true;
	}else{
		Ego.error("无可选仓库信息",null);
		return false;
	}
	
}