jQuery(function($) {

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

	$('td a.edit').on('click', function(e) { //编辑
		e.stopPropagation();
		$('#editSalesman').modal('show');
	});

	$(document).on('click', '#submit', function(e) { //保存编辑
		
		//异步
		
		if(true){ //保存成功
			$('#editSalesman').modal('hide');
			$('#successAlert').modal('show');
		}
		
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
	
	$('#batch-confirm').on('click', function() { //确认删除
		
		//异步
		var result = batchExamine(); 
		if (result) { //删除成功
			$('#successAlert').modal('hide');
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
	
	$('#submit-audit').on('click', function(){
		$.ajax({
	        cache: false,
	        type: "POST",
	        url:'batchExamine?driverState='+driverState+'&roleIds='+roleIds,
	        async: false,
	        error: function(request) {
	            alert("Connection error");
	        },
	        success: function(data) {
	        	window.location.href="toSalesManList?";
	        }
	    });
	});
	var nTag = $("#nTag").val();
	if(nTag != ""){
		if(nTag= '0'){
			$("#tagSpan").text("已启用");
		}else{
			$("#tagSpan").text("已停用");
		}
	}
	$("#tag-menu li").click(function(){
		var litext = $(this).find("a").text();
		var livalue =  $(this).find("a").attr("id");  
		$("#tagSpan").text(litext);
		$("#nTag").val(livalue);
	});
	
	$('#batch-reset').on('click', function(){
		var $chks = $('.checked-wrap .chk').filter('[checked=checked]');
		if($chks.length < 1) {
			Ego.error('必须选择用户');
			return;
		}
		var userIds = [];
		$chks.each(function(){
			userIds.push($.trim($(this).attr('data-id')));
		});
		
		layer.prompt({title : '请输入新密码'}, function(value, index, elem){
			if(undefined != value && value.length > 0) {
				setPassword(userIds, $.trim(value));
				layer.close(index);
			}
			else {
				Ego.error('请输入新密码');
			}
		});
	});
	
	var setPassword = function(userIds, newPassword) {
		HTTP.postAjx(webHost + '/salesman/batchResetPassword', {saleIds:userIds, newPassword:newPassword}, function(data){
			Ego.success('批量修改密码成功');
		}, function(data){
			Ego.error(data.message);
		});
	};
});

function changeChkStatus(selehr){
	$('.batch label').removeClass('checked');
}

var driverState = '';
var roleIds='';
function batchExamine(){
	driverState = '';
	roleIds='';
	var temp = null;
	var canBeAudit = true;
	$(".footable #SaleId_chk").each(function(index) {
		var roleId = $(this).val();
		var checked = $(this).attr('checked');
		if('checked'==checked){
			if(roleIds==''){roleIds =roleId;}else{roleIds = roleIds +','+roleId;}
			
			if(null == temp) temp = $(this).attr('attr');
			if($(this).attr('attr') != temp) {
				Ego.error('只能对相同状态的业务员进行批量操作!');
				canBeAudit = false;
				return;
			}
		}
	});

	if(temp == 0) {
		$('#a-audit-tag').text('确定要禁用吗！');
		$('#submit-audit').val('禁用');
		driverState = '1';
	}
	if(temp ==1) {
		$('#a-audit-tag').text('确定要启用吗！');
		$('#submit-audit').val('启用');
		driverState = '0';
	} 
	
	if(""==roleIds||typeof(roleIds) == 'undefined'){
		$("#check-msg").text("至少选择勾选一个业务员");
		$('#successAlert').modal('show');  
		canBeAudit = false;
    }else{
    	if(canBeAudit) $('#audit-alert').modal('show');
    }
}

function del(){
	var isValid = false; 
	var deleteId = $("#delete-salesmane-id").val(); 
	if(deleteId == ''){
		return isValid;
	}
	$.ajax({
        cache: false,
        type: "POST",
        url:'cleanSalesMan?sSaleId='+deleteId,
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
function filterList(){
	var sSalChineseName = $("#sSalChineseName").val();
	window.location.href="toSalesManList?sSalChineseName="+sSalChineseName;
}

function exportExcel(){
	var saleManIds = [];
	$(".footable #SaleId_chk").each(function(index) {
		var checked = $(this).attr('checked');
		if('checked'==checked){
			saleManIds.push("'"+$(this).val()+"'");
		}
	});
	
	var sSalParam = $("#sSalParam").val();
	window.location.href="exprotExcel?saleManIds="+saleManIds.join(",")+"&sSalParam="+sSalParam;
}

/* 选择业务员窗口 */
function seletSalesmanNO(content_url) {
	layer.open({
		type : 2,
		title : '选择业务员',
		shadeClose : true,
		shade : 0.6,
		area : [ '70%', '80%' ],
		content : content_url
	});
}