jQuery(function($) {
	var footable = null, $row = null, isAll = false, // true为全选，false为未选中
	$table = $('.table-box table'), // 获取表格元素
	$bgRow = null;

	$('.pwd table').footable(
			{ // 响应式表格初始化
				debug : true,
				breakpoints : {
					phone : 600,
					tablet : 980
				},
				log : function(message, type) {
					$bgRow = $table.find('tbody tr')
							.not('.footable-row-detail');
					if (message == 'footable_initialized') {
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

	$('.chk').on('click', function() { // 选中/取消选中
		Checked.checked(this);
	});

	$('.batch .chk').on('click', function() { // 全选/取消全选
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});

	$('#batch_reset_btn').on(
			'click',
			function() {
				var ids = "";
				$(".checked-wrap input:checkbox[name='pwd_checkboxs']:checked")
						.each(function(index) {
							ids += $(this).val() + ",";
						});
				window.location.href="resetPsw?ids="+ids;
			});

});