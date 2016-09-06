$(document).ready(function(){
	var isAll = false;//true为全选，false为未选中
	
	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});

	$('.batch .chk').on('click', function() { //全选/取消全选
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	
	var constractNo = $("#constractNO").val();
	if(constractNo != ''){
		$("#sConstractSpan").text(constractNo);
	}
	
	$("#query").on('click',function(){ //查询 
		$("#page_index").val("1");
		$("#limitPageForm").submit();
	});
	
	$('td a.delete').on('click', function(e) { //删除弹窗 
		var warehouseNO = $(this).attr("warehouseNO");
		Ego.alert("是否确认删除当前仓库？",function(){  
			warehouseDel(warehouseNO);
		}); 
	}); 

});

function priorityManageSet(districtIDs){
	priorityManageWindow("priorityManageSetPage?&districtIDs="+districtIDs);
}

/* 选择经销商窗口 */
function priorityManageWindow(content_url) {
	layer.open({
		type : 2,
		title : '优先级设置',
		shadeClose : true,
		shade : 0.6,
		area : [ '70%', '90%' ],
		content : content_url
	});
}