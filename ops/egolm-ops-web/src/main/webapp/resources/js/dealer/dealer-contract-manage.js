$(document).ready(function() {
});
jQuery(function($) {
	var footable = null, $row = null, isAll = false, //true为全选，false为未选中
	$table = $('.table-box table'), //获取表格元素
	$bgRow = null;

	$('.contract table').footable(
			{ //响应式表格初始化
				breakpoints : {
					phone : 600,
					tablet : 980
				},
				log : function(message, type) {
					$bgRow = $table.find('tbody tr')
							.not('.footable-row-detail');
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

	/*$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});

	$('.batch .chk').on('click', function() { //全选/取消全选
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});*/
	
	
	$('.agentcontract-check').on('click', function() { //选中/取消选中
		Checked.checked(this);
		if($('.agentcontract-check').filter('[checked=checked]').length == $('.agentcontract-check').length) {
			$('.check-all').attr('checked',true);
			$('.check-all').parents('label:first').addClass('checked');
			isAll = true;
		}else {
			$('.check-all').attr('checked',false);
			$('.check-all').parents('label:first').removeClass('checked');
			isAll = false;
		}
	});
	
	$('.check-all').on('click', function() { //全选/取消全选
		Checked.selectAll(this, isAll);
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	var post = function(url, data, success, error, complete) {
		$.ajax({
			type : 'POST',
			url : url,
			data : data,
			dataType : "json",
			cache : false,
			traditional:true,
			success : function(data) {
				if(!data.IsValid) { error && error(data); }
				else { success && success(data); }
			},
			error : function(data){ error && error(data)},
			complete : function(data){ complete && complete(data)},
		});
	};
	
	var currentDriverId = null;
	$('td a.delete').on('click', function(e) { //删除弹窗
		//e.stopPropagation();
		footable = $(this).parents('table:first').data('footable');
		$row = $(this).parents('tr:first');
		currentDriverId = $row.find('.agentcontract-check').attr('data-id');
		Ego.alert('确定要删除经销商合同信息?', function(index) {
			post(webHost + '/dealer/agentContractClean', {sAgentContractNO : [currentDriverId]}, function(data){
				Ego.success('删除成功!');
				footable.removeRow($row);
				footable = null;
				$row = null;
			}, function(data){
				Ego.error('删除失败!');
			}, function(data) {
			});
		});
	});
});


//选择经销商后，更新所属机构值
function setAgentVal(nAgentID,sAgentNO,sAgentName){
	$('#sSalBizZoneID').val(nAgentID);
	$('#sSalBizZone').val(sAgentName);
	$('#zone-btn span:first').text(sAgentName);
	$('#sAgentNO').text(sAgentNO);
}

//获取合同类型
function getConType(el) {
	var data = eval(el);
	$("#sComID").val(data.id);
	$("#sComDesc").val(data.name);
	$("#sComSpan").text(data.name);
}

function del(sAgentContractNO) {
	$.jconfirm({
		title : "友情提示",
		message : "确定要删除经销商合同信息吗？",
		confirmButton : "确认",
		cancelButton : "取消",
		confirm : function() {
			$
					.ajax({
						cache : false,
						type : "POST",
						url : 'agentContractClean?sAgentContractNO='
								+ sAgentContractNO,
						async : false,
						error : function(request) {
							alert("Connection error");
						},
						success : function(data) {
							$.jalert({
								title : "提示",
								message : "删除成功"
							});
							//window.location.href = "agentContractList";
							//$('#deleteAlert').modal('hide');
						}
					})
		},
		cancel : function() {
		}
	});
}

function filterList() {
	var sAgentContractNO = $("#sAgentContractNO").val();
	var sComID = $("#sComID").val();
	window.location.href = "agentContractList?sAgentContractNO=" + sAgentContractNO
			+ "&sComID=" + sComID;
}

function exportExcel() {
	var sAgentContractNO = $("#sAgentContractNO").val();
	var sComID = $("#sComID").val();
	window.location.href = "/contract/exprotExcel?sAgentContractNO="
			+ sAgentContractNO + "&sComID=" + sComID;
}

function batchDel() {
	alert(1);
	var contractNoArray = new Array();
	/*  $(".chk").each(function(){
	      if ($(this).attr('checked') ==true) {
	            alert($(this).val());
	        }
	 }); */
	$('.checked-wrap input').each(function(index) {
		if ($(this).attr('checked') == 'checked') {
			contractNoArray.push($(this).val());
		}
	});
	$.ajax({
		cache : false,
		type : "POST",
		url : 'agentContractBatchClean?batchNo=' + contractNoArray.toString(),
		async : false,
		error : function(request) {
			alert("Connection error");
		},
		success : function(data) {
			$.jalert({
				title : "提示",
				message : "删除成功"
			});
			window.location.href = "agentContractList";
		}
	})

}