jQuery(function($) {
	var footable = null, $row = null, isAll = false, deleteType = true;
	$table = $('.table-box table'), //获取表格元素
	$bgRow = null;
	$('.supplier table').footable({ //响应式表格初始化
		breakpoints : {
			phone : 480,
			tablet : 1200
		}
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
	
	$('.agent-check').on('click', function() { //选中/取消选中
		Checked.checked(this);
		if($('.agent-check').filter('[checked=checked]').length == $('.agent-check').length) {
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
	
	
	
	$('.audit table').footable({ //响应式表格初始化
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
	
	var currentDriverId = null;
	$('td a.delete').on('click', function(e) { //删除弹窗
		e.stopPropagation();
		footable = $(this).parents('table:first').data('footable');
		$row = $(this).parents('tr:first');
		currentDriverId = $row.find('.agent-check').attr('data-id');
		Ego.alert('确定要删除经销商信息?', function(index) {
			post(webHost + '/dealer/agentClean', {nAgentID : [currentDriverId]}, function(data){
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

/*function del(id) {
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
	footable = $(this).parents('table:first').data('footable');
	$row = $(this).parents('tr:first');
	currentDriverId = $row.find('.driver-check').attr('data-id');
	Ego.alert('确定要删除经销商信息?', function(index) {
		post(webHost + '/dealer/agentClean', {nAgentID : [id]}, function(data){
			Ego.success('删除成功!');
			footable.removeRow($row);
			footable = null;
			$row = null;
		}, function(data){
			Ego.error('删除失败!');
		}, function(data) {
		});
	});*/
	
	
	
	
	/*$.jconfirm({
		title : "友情提示",
		message : "确定要删除经销商信息吗？",
		confirmButton : "确认",
		cancelButton : "取消",
		confirm : function() {
			$.ajax({
				cache : false,
				type : "POST",
				url : 'agentClean?nAgentID=' + id,
				async : false,
				error : function(request) {
					alert("Connection error");
				},
				success : function(data) {
					$.jalert({
						title : "提示",
						message : "删除成功"
					});
					window.location.href = webHost + '/dealer/agentList';
				}
			})
		},
		cancel : function() {
		}
	});
}*/


function filterList() {
	var sAgentName = $("#sAgentName").val();
	window.location.href = "agentList?sAgentName=" + sAgentName;
}
function exportExcel() {
	var $agentIds = $('.agent-check').filter('[checked=checked]');
	var agentIds = '';
	$agentIds.each(function(){
		agentIds += $(this).attr('data-id') + ',';
	});
	var sAgentName = $("#sAgentName").val();
	/*window.open(webHost + '/dealer/exeproExcel?' +
			'sAgentName=' +sAgentName + 
			'&agentIds='+agentIds);*/
	
	window.location.href = "exprotExcel?sAgentName=" + sAgentName+'&agentIds='+agentIds;
	
}