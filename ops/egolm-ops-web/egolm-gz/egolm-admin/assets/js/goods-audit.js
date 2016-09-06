jQuery(function($) {

	var isAll = false, //是否全选
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;
		
	$('.goods table').footable({ //响应式表格初始化
		debug: true,
		breakpoints: {
			phone: 480,
			tablet: 1200
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