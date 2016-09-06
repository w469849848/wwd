jQuery(function($) {

	var footable = null,
		$row = null,
		isAll = false, //true为全选，false为未选中
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	$('.advertisement table').footable({ //响应式表格初始化
		debug: true,
		breakpoints: {
			phone: 600,
			tablet: 980
		},
		log: function(message, type) {
			$bgRow = $table.find('tbody tr').not('.footable-row-detail');
			if (message = 'footable_initialized') {
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

/*	$('td a.edit').on('click', function(e) { //编辑
		e.stopPropagation();
		$('#editAd').modal('show');
	});

	$(document).on('click', '#submit', function(e) { //保存编辑
		
		//异步代码
		
		if(true){ //保存成功
			$('#editAd').modal('hide');
			$('#successAlert').modal('show');
		}
		
	});*/
	
	
	$('td a.call').on('click', function(e) { //调用代码
		e.stopPropagation(); 
		var nApID = $(this).attr("pid");
		var zoneCode = $(this).attr("pZoneCode");
		$('#call-url-id').text("/advert/adVertView/advert_invoke?nApID="+nApID+"&sZoneCode="+zoneCode+"");
		$('#callUrlAlert').modal('show');
	});

	$('td a.delete').on('click', function(e) { //删除弹窗
		e.stopPropagation();
		footable = $(this).parents('table:first').data('footable');
		$row = $(this).parents('tr:first');
		$('#deleteAlert').modal('show'); 
		$("#delete-adPos-id").val($(this).attr("pid")); 
	});

	$('#btn-confirm').on('click', function() { //确认删除
		//异步代码
		var result = deleteAdPos(); 
		if (result) { //删除成功
			$('#deleteAlert').modal('hide');
			footable.removeRow($row);
			footable = null;
			$row = null;
		}
		$('#successAlert').modal('show');
	});

	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});

	$('.batch .chk').on('click', function() { //全选/取消全选
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	
	$("#pos-export").on('click',function(){  //批量导出
		$('input[name="nApId-chk"]:checked').each(function(){ 
			console.log($(this).val());
		});
	});
	
	$(document).keypress(function(e) {    //回车查询
	    // 回车键事件  
	       if(e.which == 13) {  
	    	  var sApTitle  = $("#sApTitle").val();
	    	  window.location.href="list?sApTitle="+sApTitle;
	       }  
	 }); 
	
	 
});

 
 


//删除广告位
function deleteAdPos(){
	var isValid = false; 
	var deleteId = $("#delete-adPos-id").val(); 
	if(deleteId == ''){
		return isValid;
	}
	$.ajax({
        cache: false,
        type: "POST",
        url:'delete',
        data:'id='+deleteId,
        async: false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")"); 
         	  isValid = dataResult.IsValid;  
         	  var returnValue = dataResult.ReturnValue;
         	  console.log(returnValue);
         	  $("#alert-adpos-msg").text(returnValue);
        }
    }); 
	return isValid;
}