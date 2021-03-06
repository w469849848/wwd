jQuery(function($) {

	var footable = null,
		$row = null,
		isAll = false, //true为全选，false为未选中
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	$('.tpl table').footable({ //响应式表格初始化
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

	$('td a.edit').on('click', function(e) { //编辑
		e.stopPropagation();
		$('#editContract').modal('show');
	});

	$(document).on('click', '#submit', function(e) { //保存编辑
		
		//异步代码
		
		if(true){ //保存成功
			$('#editContract').modal('hide');
			$('#successAlert').modal('show');
		}
		
	});

	$('td a.delete').on('click', function(e) { //删除弹窗
		e.stopPropagation();
		footable = $(this).parents('table:first').data('footable');
		$row = $(this).parents('tr:first');
		$('#deleteAlert').modal('show');
	});

	$('#btn-confirm').on('click', function() { //确认删除
		
		//异步代码
		
		if (true) { //删除成功
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
});

function deleteTpl(sTplNo){
	layer.confirm("是否确认删除？", {icon: 3, title:'提示'}, function(index){
		$.ajax({
	        cache: false,
	        type: "POST",
	        url:"delete",
	        data:{sTplNo:sTplNo},
	        async: false,
	        error: function(request) {
	            alert("错误提示："+request);
	        },
	        success: function(data) {
	        	var res = JSON.parse(data);
	        	if(res.IsValid==true){
	        		layer.alert(res.ReturnValue, {icon: 1}, function(index){
	        			layer.close(index);
	        			window.location.href="list"; 
	        		});
	        	}else{
	        		/*$.jalert({
						title:"提示", 
						message:res.ReturnValue, 
						confirmButton:"关闭", 
						confirm:function() {
						}
					});*/
	        		layer.alert(res.ReturnValue, {icon: 2}, function(index){
	        			layer.close(index);
	        		});
	        	}
	        }
	    }); 
	});
}

function updateStatus(sTplNo,nTag){
	var statusText = "";
	if(nTag == "1"){
		statusText = "已发布";
	}else{
		statusText = "待发布";
	}
	layer.confirm("是否确认修改模块状态为【"+statusText+"】？", {icon: 3, title:'提示'}, function(index){
		$.ajax({
	        cache: false,
	        type: "POST",
	        url:"status",
	        data:{
	        	sTplNo:sTplNo,
	        	nTag:nTag
	        },
	        async: false,
	        error: function(request) {
	            alert("错误提示："+request);
	        },
	        success: function(data) {
	        	var res = JSON.parse(data);
	        	console.log(res);
	        	if(res.IsValid==true){
	        		layer.alert(res.ReturnValue, {icon: 1}, function(index){
	        			layer.close(index);
	        			window.location.href="list"; 
	        		});
	        	}else{
	        		layer.alert(res.ReturnValue, {icon: 2}, function(index){
	        			layer.close(index);
	        		});
	        	}
	        }
	    });   
	});
}