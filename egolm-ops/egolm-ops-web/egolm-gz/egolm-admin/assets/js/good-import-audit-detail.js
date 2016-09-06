jQuery(function($) {

	var isAll = false, //是否全选
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null,
		footable = null;

	$('.putaway table').footable({ //响应式表格初始化
		debug: true,
		breakpoints: {
			phone: 480,
			tablet: 991
		},
		log: function(message, type) {
			$bgRow = $table.find('tbody tr').not('.footable-row-detail,.reject-elem');
			if (message == 'footable_initialized') {
				
				//隐藏驳回信息
				$('.reject-elem').remove();
				
				$bgRow.each(function(index) {
					console.log(index);
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
		var $this = $(this);
			$tr = $this.parents('tr:first')
			state = $tr.find('.state').attr('class'),
			footable = $(this).parents('table:first').data('footable');
			
		Checked.checked(this);

		//驳回信息显示
		if(state.indexOf('reject') > -1 && !!$this.attr('checked')){
			
			//异步代码
			var $elem = '<tr class="reject-elem"><td colspan="10">驳回原因：<span class="border border-radius">由于XXXXXXXXX的原因，您的商品未能通过审核</span></td></tr>'; //异步填充数据
			
			//动态插入驳回信息
			if( $tr.attr('class') && $tr.attr('class').indexOf('footable-detail-show') > -1 ){ footable.toggleDetail($tr); }
			$tr.after($elem);
			
		}else{
			//移除驳回信息
			$tr.next('.reject-elem').remove();
		}
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