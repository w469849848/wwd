$(function(){
	var footable = null,
	$row = null,
	isAll = false, //true为全选，false为未选中
	$table = $('.table-box table'), //获取表格元素
	$bgRow = null;
	
	$('.audit table').footable({ //响应式表格初始化
		debug: true,
		breakpoints: {
			phone: 600,
			tablet: 980
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
	
	$("#search").click(function(){
		var sSalParam = $("#sSalParam").val();
		
		$.ajax({
			url:"lineList",
			type:"GET",
			dataType:"json",
			data:{
				sSalParam:sSalParam
			},
			success:function(data){
				if(data){
					
				}
			}
		});
	});
	
	$('td a.delete').on('click', function(e) { //删除弹窗
		e.stopPropagation();
		footable = $(this).parents('table:first').data('footable');
		$row = $(this).parents('tr:first');
		$('#deleteAlert').modal('show');
		$("#delete-salesmane-id").val($(this).attr("pid")); 
	});
	
	$('#btn-confirm').on('click', function() { //确认删除
		
		//异步
		var result = del(); 
		if (result) { //删除成功
			$('#deleteAlert').modal('hide');
			footable.removeRow($row);
			footable = null;
			$row = null;
		}
		
	});
	
	$('td a.edit').on('click', function(e) { //编辑
		e.stopPropagation();
		$('#editSalesman').modal('show');
	});
});

function del(){
	var isValid = false; 
	var deleteId = $("#delete-salesmane-id").val(); 
	if(deleteId == ''){
		return isValid;
	}
	$.ajax({
        cache: false,
        type: "POST",
        url:'cleanLinesMan?sLineId='+deleteId,
        async: false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")"); 
	       	  isValid = dataResult.IsValid;  
	       	  var returnValue = dataResult.ReturnValue;
	       	  $("#alert-adpos-msg").text(returnValue);
        }
    });
	return isValid;
}