jQuery(function($) {
	var footable = null, $row = null, isAll = false,
	// true为全选，false为未选中
	deleteType = true,
	// true为删除一行,false为批量删除
	$table = $('.table-box table'),
	// 获取表格元素
	$bgRow = null;

	$('.cust table').footable(
			{ // 响应式表格初始化
				debug : true,
				breakpoints : {
					phone : 600,
					tablet : 980
				},
				log : function(message, type) {
					$bgRow = $table.find('tbody tr')
							.not('.footable-row-detail');
					if (message = 'footable_initialized') {
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

	$('td a.edit').on('click', function(e) { // 编辑
		// 这只是给来做效果的，没什么鸟用
		// e.stopPropagation();
		// TableEdit.util.createForm(this, 'editUser');
		// $('#editUser').modal('show');

		$("#editCustId").val(this.title);
		$("#toEditPageForm").submit();
	});

	$(document).on('click', '#submit', function(e) { // 保存编辑
		$('#editUser').modal('hide');
		$('#successAlert').modal('show');
	});

	$('td a.delete').on('click', function(e) { // 删除弹窗
		e.stopPropagation();
		deleteType = true;
		footable = $(this).parents('table:first').data('footable');
		$row = $(this).parents('tr:first');
		$('#deleteAlert').modal('show');
	});

	$('#btn-confirm').on('click', function() { // 确认删除
		if (deleteType) {
			$.ajax({
				cache : false,
				type : "POST",
				url : "delete",
				data : {
					sCustNO : $row.attr("title")
				},
				async : false,
				error : function(request) {
					alert("错误提示：" + request);
				},
				success : function(data) {
					var res = JSON.parse(data);
					if (res.IsValid == true) {
						$('#deleteAlert').modal('hide');
						footable.removeRow($row);
						footable = null;
						$row = null;
					} else {
						
					}
					$.jalert({
						title : "提示",
						message : res.ReturnValue,
						confirmButton : "关闭",
						confirm : function() {
						}
					});
				}
			});

		} else { // 批量删除
		}
	});

	$('.cust-check').on('click', function() { //选中/取消选中
		Checked.checked(this);
		if($('.cust-check').filter('[checked=checked]').length == $('.cust-check').length) {
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
	
	$('#batch-update-cust').on('click', function(){
		var currentTag = validateCustomerTagSame();
		if(null == currentTag) return;
		var $checkCusts = $('.cust-check').filter('[checked=checked]');
		var custNOs = [];
		$checkCusts.each(function(){
			custNOs.push($(this).attr('data-id'));
		});
		var notice = '确定要批量禁用这些会员';
		var tag = 1;
		if(1 == currentTag) {
			notice = '确定要批量启用这些会员';
			tag = 0;
		}
		Ego.alert(notice, function(){
			updateTag(custNOs, tag);
		});
	});
	function validateCustomerTagSame() {
		var $checkCusts = $('.cust-check').filter('[checked=checked]');
		if($checkCusts.length < 1) {
			Ego.error('请选择需要操作的会员!');
			return null;
		}
		var currentTag = null;
		var pass = true;
		$checkCusts.each(function(){
			if(null == currentTag) {
				currentTag = $(this).attr('data-tag');
			}
			if(currentTag != $(this).attr('data-tag')) {
				pass = false;
			}
		});
		
		if(!pass) {
			Ego.error('不能同时操作不同状态的会员');
			return null;
		}
		return currentTag;
	};
	
	$('#batch-reset-password').on('click', function(){
		var $checkCusts = $('.cust-check').filter('[checked=checked]');
		var custNOs = [];
		$checkCusts.each(function(){
			custNOs.push($(this).attr('data-id'));
		});
		Ego.alert('确定要批量重置会员密码', function(){
			resetPassword(custNOs, null);
		});
	});
});

function resetPassword(sCustNOs, password) {
	$.ajax({
		cache : false,
		traditional:true,
		type : "POST",
		url : "resetPassword",
		data : {
			sCustNOs : sCustNOs,
			newPassword : password
		},
		async : false,
		error : function(request) {
			Ego.error("错误提示：" + request);
		},
		success : function(data) {
			var res = JSON.parse(data);
			if (res.IsValid == true) {
				Ego.success(res.ReturnValue, function() {
					window.location.href = "customerList";
				});
			} else {
				Ego.error(res.ReturnValue);
			}
		}
	});
}

function updateTag(sCustNO, nTag) {
	$.ajax({
		cache : false,
		traditional:true,
		type : "POST",
		url : "updateTag",
		data : {
			sCustNOs : sCustNO,
			nTag : nTag
		},
		async : false,
		error : function(request) {
			Ego.error("错误提示：" + request);
		},
		success : function(data) {
			var res = JSON.parse(data);
			if (res.IsValid == true) {
				Ego.success(res.ReturnValue, function(){
					window.location.href = "customerList";
				});
			} else {
				Ego.error(res.ReturnValue);
			}
		}
	});
}