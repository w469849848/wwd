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

//经销商下拉框
function getAgentContent(el) {
	var data = eval(el);
	$("#sConstractSpan").text(data.id);
	$("#constractNO").val(data.name);
}

function warehouseDel(warehouseNO){
	var formData = new FormData();  
	formData.append("sWarehouseNO",warehouseNO);
	formData.append("type","del"); 
 	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'warehouseSave',
        data: formData,  
        async: false,
        error: function(request,errorThrown) {
            alert("Connection error"); 
        },
        success: function(data) {
        	console.log(data);
        	var dataResult = JSON.parse(data); 
        	var isValid = dataResult.IsValid;
        	var returnValue = dataResult.ReturnValue;
        	if(isValid){
	       		 Ego.success(returnValue,function(){
	       			window.location.href = webHost + '/agent/warehouse/warehouseList';
	       		 });  
	       	}else{
	       		Ego.error(returnValue,null);
	       	}
        }
    }); 
}