jQuery(function($) {

	var isAll = false, //是否全选
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	$('.putaway table').footable({ //响应式表格初始化
		debug: true,
		breakpoints: {
			phone: 480,
			tablet: 991
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
	
	$('td a.edit').on('click', function(e) { //编辑
		e.stopPropagation();
		$('#editGoods').modal('show');
	});

	$(document).on('click', '#submit', function(e) { //保存编辑
		
		//异步代码
		
		if(true){ //保存成功
			$('#editGoods').modal('hide');
			$('#successAlert').modal('show');
		}
		
	});
	
});