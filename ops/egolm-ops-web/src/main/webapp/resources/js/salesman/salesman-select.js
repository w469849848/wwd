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
	
	$('.chk').on('click', function() { //选中/取消选中
		$('.chk').each(function(){
			$(this).parents('label:first').removeClass('checked');
			$(this).attr('checked',false);
		});
		Checked.checked(this);
	});
});

 

function savePage(){  
	var datas = {};
	var salesManNO2 = "";
	datas["salesManNO"] = $("input[name='saleNO']").val();
	$(".salesMan-check").each(function(){
		if($(this).attr("checked")){
			salesManNO2=$(this).attr("data-id");
		}
	});
	
	datas["salesManNO2"] = salesManNO2;
	console.log(datas);
	$.ajax({
        cache: false,
        type: "POST",
        dataType: "json",
        url:'batchUpdateShopSalesMan',
        data: datas,  
        async: false,
        error: function(request,errorThrown) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {
        	var isValid = data.IsValid;
        	var returnValue = data.ReturnValue;       	 	 
        	if(isValid){
   			   Ego.success(returnValue,function(){
      			   parent.window.location.href = webHost + '/salesman/toSalesManList';
      		  }); 
	     	}else{
	     		 Ego.error(returnValue,null);
	     	}
        }
	});
} 
