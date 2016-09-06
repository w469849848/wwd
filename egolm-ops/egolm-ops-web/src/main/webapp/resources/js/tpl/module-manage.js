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


	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});

	$('.batch .chk').on('click', function() { //全选/取消全选
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	
	
	
	$(".module-option").on('click',function(){
		var text=$(this).text();
		if(text=='全部 '){
			$("#nModuleType").val("");
		}else{
			$("#nModuleType").val($(this).text());
		}
		$("#nModuleTypeText").text($(this).text());
	});
});


function deleteModule(sModuleNo){
	layer.confirm("是否确认删除？", {icon: 3, title:'提示'}, function(index){
			$.ajax({
		        cache: false,
		        type: "POST",
		        url:"delete",
		        data:{sModuleNo:sModuleNo},
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
		        		layer.alert(res.ReturnValue, {icon: 2}, function(index){
		        			layer.close(index);
		        		});
		        	}
		        }
		    }); 
		});
}

function updateStatus(sModuleNo,nStatus){
	/*if(confirm("是否确认修改模块状态为【"+nStatus+"】？")){*/
	layer.confirm("是否确认修改模块状态为【"+nStatus+"】？", {icon: 3, title:'提示'}, function(index){
			$.ajax({
		        cache: false,
		        type: "POST",
		        url:"status",
		        data:{sModuleNo:sModuleNo,nStatus:nStatus},
		        async: false,
		        error: function(request) {
		            alert("错误提示："+request);
		        },
		        success: function(data) {
		        	var res = JSON.parse(data);
		        	if(res.IsValid==true){
		        		/*$.jalert({
							title:"提示", 
							message:res.ReturnValue, 
							confirmButton:"关闭", 
							confirm:function() {
								window.location.href="list"; 
							}
						});*/
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