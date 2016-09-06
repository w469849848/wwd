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

				$bgRow.each(function(index) {

					if (index % 2 == 1) {
						$(this).css({
							'background': '#f8f8f8'
						});
					}
				});
			}
			if (message == 'footable_row_expanded' || message == 'footable_row_collapsed') {
				
				var isEdit = $('.btn-fail').attr('class').toLocaleLowerCase().indexOf('isedit') > -1 ? true : false; //是否正在编辑
				
				if( isEdit ){
					$('.footable-row-detail').hide();
				}
				
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

	$('table tbody .chk').on('click', function() { //选中/取消选中
		
		var $this = $(this),
			$tr = $this.parents('tr:first'),
			isEdit = $('.btn-fail').attr('class').toLocaleLowerCase().indexOf('isedit') > -1 ? true : false; //是否正在编辑
		
		Checked.checked(this);
		
		if($this.attr('checked') != 'checked'){
			$tr.next('.reject-elem').remove();
			
			//去掉正在编辑的状态
			if( $('.reject-elem').length <= 0){ $('.btn-fail').removeClass('isedit'); }
		}else if( $this.attr('checked') == 'checked' && isEdit ){
			
			var $elem = '<tr class="reject-elem"><td colspan="10">驳回原因：<span class="border border-radius">由于<input type="text" />的原因，您的商品未能通过审核</span></td></tr>';
			$tr.after($elem);
			
		}

	});
	
	
	//批量通过
	$('.btn-pass').on('click',function(){
		
		$('.putaway table tbody input[type=checkbox]').each(function(index) {

			var $this = $(this),
				$tr = $this.parents('tr:first');
		
			if ($this.attr('checked') == 'checked') {
				
				$tr.remove(); //删除选中的行
				
			}
		});
		
	});
	

	//批量驳回
	$('.btn-fail').on('click',function(){
		
		var isEdit = $(this).attr('class').toLocaleLowerCase().indexOf('isedit') > -1 ? true : false, //是否正在编辑
			footable =  $table.data('footable');
			
		$('.footable-row-detail').hide(); //隐藏表格下拉信息
		
		
		if(!isEdit){
			$('.putaway table tbody input[type=checkbox]').each(function(index){
				
				var $this = $(this),
					$tr = $this.parents('tr:first'),
					footable = $(this).parents('table:first').data('footable');
				
				$tr.removeClass('footable-detail-show');
				
				if($this.attr('checked') == 'checked'){
					var $elem = '<tr class="reject-elem"><td colspan="10">驳回原因：<span class="border border-radius">由于<input type="text" />的原因，您的商品未能通过审核</span></td></tr>';
					$tr.after($elem);
					$('.btn-fail').addClass('isedit');
				}
			});
			
		}else{
			var isEmpty = false; //输入信息是否有空
			
			$('.putaway table tbody input[type=text]').each(function(index){
				
				var $this = $(this);
					
				if($this.val() == ''){
					alert('驳回原因不可为空!');
					isEmpty = true;
					return false;
				}
			});
			
			if(!isEmpty){ //不为空，提交审核，删除选中的行
				
				//后台代码--提交驳回
				
				$('.reject-elem').prev().remove();
				$('.reject-elem').remove();
				$(this).removeClass('isedit');
				
				
			}
		}
	});

	$('.batch .chk').on('click', function() { //全选/取消全选
		
		var _this = $(this),
			isEdit = $('.btn-fail').attr('class').toLocaleLowerCase().indexOf('isedit') > -1 ? true : false; //是否正在编辑
		
		Checked.checked(this);
		
		$('.checked-wrap input').each(function(index) {
			
			var $this = $(this),
				$tr = $this.parents('tr:first');
			
			Checked.selectAll(this, isAll);
			
			if(isEdit){ //编辑状态下
			
				if( _this.attr('checked') != 'checked' ){
					$('.reject-elem').remove();
					$('.btn-fail').removeClass('isedit');
				}else{
					var $elem = '<tr class="reject-elem"><td colspan="10">驳回原因：<span class="border border-radius">由于<input type="text" />的原因，您的商品未能通过审核</span></td></tr>';
					$('.reject-elem').next('.reject-elem').remove();
					$tr.after($elem);
				}
			}
			
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