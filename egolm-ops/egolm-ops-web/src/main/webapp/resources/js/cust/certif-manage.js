jQuery(function($) {
	var footable = null, $row = null, isAll = false,
	// true为全选，false为未选中
	deleteType = true,
	// true为删除一行,false为批量删除
	$table = $('.table-box table'),
	// 获取表格元素
	$bgRow = null;

	$('.certif table').footable(
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
		$("#sShopNO").val(this.title);
		$("#toEditPageForm").submit();
	});

	$(document).on('click', '#submit', function(e) { // 保存编辑
		$('#editShop').modal('hide');
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

	$('.chk').on('click', function() { // 选中/取消选中
		Checked.checked(this);
	});

	$('.batch .chk').on('click', function() { // 全选/取消全选
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
});

function updateTag(sShopNO, nTag) {
	$.ajax({
		cache : false,
		type : "POST",
		url : "updateTag",
		data : {
			sShopNO : sShopNO,
			nTag : nTag
		},
		async : false,
		error : function(request) {
			alert("错误提示：" + request);
		},
		success : function(data) {
			var res = JSON.parse(data);
			if (res.IsValid == true) {
				$.jalert({
					title : "提示",
					message : res.ReturnValue,
					confirmButton : "关闭",
					confirm : function() {
						window.location.href = "certifList";
					}
				});
			} else {
				$.jalert({
					title : "提示",
					message : res.ReturnValue,
					confirmButton : "关闭",
					confirm : function() {
					}
				});
			}
		}
	});
}