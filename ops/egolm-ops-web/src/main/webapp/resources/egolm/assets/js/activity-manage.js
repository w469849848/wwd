jQuery(function($) {

	var footable = null,
		$row = null,
		isAll = false, //true为全选，false为未选中
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	$('.activity table').footable({ //响应式表格初始化
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

	/*$('td a.edit').on('click', function(e) { //显示编辑弹窗
		e.stopPropagation();
		$('#editActivity').modal('show');
	});*/

	/*$(document).on('click', '#submit', function(e) { //保存编辑 
		//异步代码 
		if(true){ //成功返回
			$('#editActivity').modal('hide');
			$('#successAlert').modal('show');
		}
		
	});*/

	$('td a.delete').on('click', function(e) { //显示删除弹窗
		e.stopPropagation();
		footable = $(this).parents('table:first').data('footable');
		$row = $(this).parents('tr:first');
		$('#deleteAlert').modal('show');
		$("#delete-activity-id").val($(this).attr("pid"));
	});

	$('#btn-confirm').on('click', function() { //确认删除 
		//异步代码 
		if(deleteActivity()){ //返回成功
			$('#deleteAlert').modal('hide');
			footable.removeRow($row);
			footable = null;
			$row = null;
		}
		
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
	
	$('#auditMoreid').on('click',function(e){  //批量审核
		$('input[name="tmpPromoId"]:checked').each(function(){ 
			console.log($(this).val());
		 }); 
		e.stopPropagation();
		$('#editActivity').modal('show');
	});
	
	
	
	//加载区域
	loadTOrgs("area-menu","4");
	 $("#area-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#area-id").find("span").eq(0).text(litext);
		 $("#zoneCode").val(livalue); 
		 
	 });
	 
	 
	 //查询
	 $(document).keypress(function(e) {  
		    // 回车键事件  
	       if(e.which == 13) {  
	    	  var sTmpPromoTitle  = $("#sTmpPromoTitle").val(); 
	    	  var zoneCode = $("#zoneCode").val(); 
	    	  window.location.href="list?sTmpPromoTitle="+sTmpPromoTitle+"&zoneCode="+zoneCode;
	       }  
	  }); 
});



//删除广告位
function deleteActivity(){
	var isValid = false; 
	var deleteId = $("#delete-activity-id").val(); 
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