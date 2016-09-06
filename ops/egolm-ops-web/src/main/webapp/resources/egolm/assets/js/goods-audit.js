jQuery(function($) {

	var isAll = false; //是否全选

	$('.goods table').footable({ //响应式表格初始化
		breakpoints: {
			phone: 480,
			tablet: 1200
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