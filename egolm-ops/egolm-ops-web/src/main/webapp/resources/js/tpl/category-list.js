jQuery(function($) {

	var footable = null,
		$row = null,
		isAll = false, //true为全选，false为未选中
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	$('.sort-wrap table').footable({ //响应式表格初始化
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
							'background': '#f8f8f8'
						});
					}
				});
			}
			if (message == 'footable_row_expanded' || message == 'footable_row_collapsed') {
				$bgRow.each(function(index) {
					if (index % 2 == 1) {
						$(this).css({
							'background': '#f8f8f8'
						});
					}
				});
			}
		}
	});
	
	//区域选择弹窗
	$('.area .filter-select input').on('focus',function(){
		$('#areaAlert').modal('show');
		addressInit('addProvince', 'addCity', 'addArea', '广东', '广州市', '越秀区');
	});
	
	//确定选择区域
	$('#areaAlert .btn-submit').on('click',function(){
		var prov = $('#addProvince option:selected').text(),
			city = $('#addCity option:selected').text(),
			area = $('#addArea option:selected').text(),
			areaValue = $('#addArea option:selected').val();
		
		$('.filter-wrap .area input[name="sOrgNO"]').val(areaValue);
		$('.filter-wrap .area input[name="sOrgName"]').val(prov + ','+ city + ',' + area);
		$('#areaAlert').modal('hide');
		
	});

	/*$('td a.delete').on('click', function(e) { //删除弹窗
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
*/
	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});

	$('.batch .chk').on('click', function() { //全选/取消全选
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	
	//没有全选时，全选状态取消
	$('.sort-wrap table tbody td input.chk').on('change',function(){
		var check = !!$(this).attr('checked');
		if(!check){
			isAll = false;
			$('.sort-wrap tfoot td input.chk').attr('checked',false).parents('label:first').removeClass('checked');
		}else{
			var len = 0;
			$('.sort-wrap table tbody td input.chk').each(function(index){
				if(!$(this).attr('checked')){
					return false;
				}
				len = index + 1;
			});
			if(len == $('.sort-wrap table tbody td input.chk').length){
				$('.sort-wrap tfoot td input.chk').attr('checked',true).parents('label:first').addClass('checked');
				isAll = true;
			}
		}
	});
	
	//店铺类型选择
	$('#scope-ul').on('click','li',function(){
		$('input[name="sScopeTypeID"]').val($(this).attr('val'));
		$('input[name="sScopeType"]').val($(this).text());
		$('#scope-name').text($(this).text());
	});
});

function layerLoad(){
	var index = layer.load(0, {time:10*1000,shade: [0.2, '#393D49']}); 
	//关闭
	layer.close(index);    
}

function deleteCategory(sOrgNo, sScopeTypeID){
	layer.confirm("是否确认删除？", {icon: 3, title:'提示'}, function(index){
		var _index = layer.load(0, {shade: [0.2, '#393D49']}); 
		$.ajax({
	        cache: false,
	        type: "POST",
	        url:"delete",
	        data:{
	        	cateItems : sOrgNo + "-" + sScopeTypeID
	        },
	        async: false,
	        error: function(request) {
	            alert("错误提示："+request);
	        },
	        success: function(data) {
	        	layer.close(_index);
	        	var res = JSON.parse(data);
	        	if(res.IsValid==true){
	        		layer.alert(res.ReturnValue, {icon: 1}, function(index){
	        			layer.close(index);
	        			window.location.href="list"; 
	        			//$('#limitPageForm').submit();
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

/**
 * 批量删除
 */
function batchDelete(){
	var delArray = [];
	$('input[name="catebox"]:checked').each(function(){
		delArray.push($(this).val());
	});
	
	if(delArray.length > 0){
		layer.confirm("是否确认批量删除？", {icon: 3, title:'提示'}, function(index){
			var _index = layer.load(0, {shade: [0.2, '#393D49']}); 
			$.ajax({
		        cache: false,
		        type: "POST",
		        url:"delete",
		        data:{
		        	cateItems : delArray.join(",")
		        },
		        async: false,
		        error: function(request) {
		            alert("错误提示："+request);
		        },
		        success: function(data) {
		        	layer.close(_index);
		        	var res = JSON.parse(data);
		        	if(res.IsValid==true){
		        		layer.alert(res.ReturnValue, {icon: 1}, function(index){
		        			layer.close(index);
		        			window.location.href="list"; 
		        			//$('#limitPageForm').submit();
		        		});
		        	}else{
		        		layer.alert(res.ReturnValue, {icon: 2}, function(index){
		        			layer.close(index);
		        		});
		        	}
		        }
		    }); 
		});
	}else{
		layer.alert("请选择需要删除的数据", {icon: 3}, function(index){
			layer.close(index);
		});
	}
}

/**
 * 批量导出
 */
function bacthExport(){
	var exportArr = [];
	$('input[name="catebox"]:checked').each(function(){
		exportArr.push($(this).val());
	});
	
	if(exportArr.length > 0){
		/*layer.confirm("是否确认批量导出？", {icon: 3, title:'提示'}, function(index){
			
			layer.close(index);
		});*/
		console.log(exportArr.join(","));
		$('input[name="param"]').val(exportArr.join(","));
		$('#exportForm').submit();
	}else{
		layer.alert("请选择需要导出的数据", {icon: 3}, function(index){
			layer.close(index);
		});
	}
}
	