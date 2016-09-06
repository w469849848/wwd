jQuery(function($) {

	var footable = null,
		$row = null,
		isAll1 = false, //true为全选，false为未选中
		isAll2 = false, //true为全选，false为未选中
		isAll3 = false, //true为全选，false为未选中
		step = 1, //第一步
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	$('.goods-import table').footable({ //响应式表格初始化
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


	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});

	$('.table-step1 .batch .chk').on('click', function() { //全选/取消全选-------第一步
		$('.table-step1 .checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll1);
		});
		isAll1 = !isAll1;
	});
	
	$('.table-step2 .batch .chk').on('click', function() { //全选/取消全选 ------ 第二步
		$('.table-step2 .checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll2);
		});
		isAll2 = !isAll2;
	});
	
	$('.table-step3 .batch .chk').on('click', function() { //全选/取消全选 ------ 第二步
		$('.table-step3 .checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll3);
		});
		isAll3 = !isAll3;
	});
	
	$('.next-step').on('click',function(){ //下一步
		
		if(step == 3){ return false; }
		
		$('.table-step' + step).addClass('hide'); //隐藏上一步表格
		step++;
		$('.table-step' + step).removeClass('hide'); //显示下一步表格
		$('a.btn-step' + step).addClass('active');
		$('p.dashed-step' + step).addClass('active');
	});

});