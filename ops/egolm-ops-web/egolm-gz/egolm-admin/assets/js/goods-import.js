jQuery(function($) {

	var footable = null,
		$row = null,
		isAll2 = false, //true为全选，false为未选中--第二步
		isAll3 = false, //true为全选，false为未选中--第三步
		isAll4 = false, //true为全选，false为未选中--资料库弹窗商品列
		isAll5 = false, //true为全选，false为未选中--资料库弹窗已选商品
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


	$(document).on('click','.chk',function(){
		Checked.checked(this);
	});
	
	//单选组
	$(document).on('click','.chk-radio',function(){
		$('.table-step1 .chk-radio').attr('checked',false);
		$(this).attr('checked',true);
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
	
	$('.table-step1 .next-step').on('click',function(){ //第一步--下一步
		
		if(step == 2){ $(this).hide(); }
		
		$('.table-step' + step).addClass('hide'); //隐藏上一步表格
		step++;
		$('.table-step' + step).removeClass('hide'); //显示下一步表格
		$('a.btn-step' + step).addClass('active');
		$('p.dashed-step' + step).addClass('active');
	});
	
	$('.table-step2 .next-step').on('click',function(){ //第二步--下一步
		
		if(step == 2){ $(this).hide(); }
		
		$('.table-step' + step).addClass('hide'); //隐藏上一步表格
		step++;
		$('.table-step' + step).removeClass('hide'); //显示下一步表格
		$('a.btn-step' + step).addClass('active');
		$('p.dashed-step' + step).addClass('active');
	});
	
	//显示资料库
	$('.btn-database').on('click',function(){
		$('#database').modal('show');
	});
	
	$('.select-box .batch .chk').on('click', function() { //全选/取消全选 ------ 资料库商品列表
		$('.select-box .checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll4);
		});
		isAll4 = !isAll4;
	});
	
	$('.result-box .batch .chk').on('click', function() { //全选/取消全选 ------ 已选商品列表
		$('.result-box .checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll5);
		});
		isAll5 = !isAll5;
	});
	
	//选中商品移动到结果框
	$('.btn-box .btn-select').on('click',function(){
		
		$('.select-box table tbody input').each(function(index){

			var $this = $(this);
				checked = $this.attr('checked');
			if(!!checked){
				var $row = $this.parents('tr:first').clone();
				$('.result-box table tbody').append($row);
				$this.parents('tr:first').remove();
			}
		});
		
	});
	
	//还原选中的商品
	$('.btn-box .btn-remove').on('click',function(){
		
		$('.result-box table tbody input').each(function(index){

			var $this = $(this);
				checked = $this.attr('checked');
			if(!!checked){
				var $row = $this.parents('tr:first').clone();
				$('.select-box table tbody').append($row);
				$this.parents('tr:first').remove();
			}
		});
		
	});

});