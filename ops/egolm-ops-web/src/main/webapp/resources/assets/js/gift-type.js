jQuery(function($) {

	var footable = null,
		$row = null,
		isAll = false, //true为全选，false为未选中
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	$('.integral table').footable({ //响应式表格初始化
		debug: true,
		breakpoints: {
			phone: 600,
			tablet: 1100
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

	$('td a.edit').on('click', function(e) { //显示编辑弹窗
		e.stopPropagation();
		$('#editIntegral').modal('show');
	});

	$(document).on('click', '#submit', function(e) { //保存编辑
		
		//异步代码
		
		if(true){ //成功返回
			$('#editIntegral').modal('hide');
			$('#successAlert').modal('show');
		}
		
	});

	$('td a.delete').on('click', function(e) { //显示删除弹窗
		e.stopPropagation();
		footable = $(this).parents('table:first').data('footable');
		$row = $(this).parents('tr:first');
		$('#deleteAlert').modal('show');
	});

	$('#btn-confirm').on('click', function() { //确认删除
		
		//异步代码
		
		if(true){ //返回成功
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