jQuery(function($) {
	
	var footable = null,
		$row = null,
		isAll = false, //true为全选，false为未选中
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	var post = function(url, data, success, error, complete) {
		$.ajax({
			type : 'POST',
			url : url,
			data : data,
			dataType : "json",
			cache : false,
			traditional:true,
			success : function(data) {
				if(data.statusCode != 200) { error && error(data); }
				else { success && success(data); }
			},
			error : function(data){ error && error(data)},
			complete : function(data){ complete && complete(data)},
		});
	};
	
	var loadAgents = function(sOrgNo) {
		post(webHost + '/dealer/queryAgentByOrgNo', {sOrgNo:sOrgNo},function(data){
			var agents = data.agents;
			var list = '';
			if(agents.length>0){ 
				for(var i = 0;i<agents.length;i++){
					var agent = agents[i];
					list+="<li class='agent-item' value='"+agent.nAgentID+"'>"+agent.sAgentName+"</li> "; 
				}
				$('#agent-list').html(list); 
			} 
		},function(data){
			Ego.error('系统异常，请重新选择区域!');
		});
	};
	
	var loadWarehouse = function(nAgentId) {
		post(webHost + '/warehouse/queryByAgentNO', {nAgentId:nAgentId},function(data){
			var warehouses = data.warehouses;
			var list = '';
			if(warehouses.length>0){
				for(var i = 0;i<warehouses.length;i++){
					var warehouse = warehouses[i];
					list+='<li class="warehouse-item" value="'+warehouse.swarehouseNO+'">'+warehouse.swarehouseName+'</li>'; 
				 }
				$('#warehouse-list').html(list); 
			 } 
		},function(data){
			Ego.error('系统异常，请重新选择经销商!');
		});
	};
	
	var validator = function() {
		if($.trim($('input[name=sDrivemanNo]').val()).length < 1) {
			Ego.error('司机编号不能为空！');
		}
		else if($.trim($('input[name=sDrivemanNo]').val()).length > 20) {
			Ego.error('司机编号不能大于20位！');
		}
		else if($.trim($('input[name=sDrivemanName]').val()).length < 1) {
			Ego.error('司机姓名不能为空！');
		}
		else if($.trim($('input[name=sDrivemanName]').val()).length > 20) {
			Ego.error('司机姓名不能大于20位！');
		}
		else if($.trim($('input[name=sDrivemanPwd]').val()).length < 6) {
			Ego.error('用户密码不能小于6位');
		}
		else if($.trim($('input[name=sDrivemanPwd]').val()).length > 32) {
			Ego.error('用户密码不能大于32位');
		}
		else if(!/^[1][3,4,5,7,8][0-9]{9}$/.test($.trim($('input[name=sTel]').val()))) {
			Ego.error('联系方式不正确！');
		}
		else if($.trim($('input[name=sOrgNO]').val()).length < 1) {
			Ego.error('必须选择所属区域！');
		}
		else if($.trim($('input[name=nAgentID]').val()).length < 1) {
			Ego.error('必须选择所属经销商！');
		}
		else if($.trim($('input[name=sWareHouseNo]').val()).length < 1) {
			Ego.error('必须选择所属仓库！');
		}
		else {
			return true;
		}
		return false;
	}
	
	$('.driver-manage table').footable({ //响应式表格初始化
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
	
	$('#search-driver').on('click', function(){
		$('#driver-search-form').submit();
	});

	$(document).on('click', '#submit-modify-driver', function(e) { //保存编辑
		if(!validator()) return;
		post(webHost + '/logistics/driver/modifyDriver', $('#modify-driver-form').serialize(), function(data){
			// pager('driver-search-form', $('.navigation_bar .active').find('a').text(), 10);
			Ego.success('保存成功!', function(){
				window.location.href = webHost + '/logistics/driver/index';
			});
		}, function(data){
			Ego.error('保存失败!');
		}, function(data) {
		});
	});

	var currentDriverId = null;
	$('td a.delete').on('click', function(e) { //删除弹窗
		e.stopPropagation();
		footable = $(this).parents('table:first').data('footable');
		$row = $(this).parents('tr:first');
		currentDriverId = $row.find('.driver-check').attr('data-id');
		Ego.alert('确定要删除司机！', function(index) {
			post(webHost + '/logistics/driver/deleteDriver', {driverIds : [currentDriverId]}, function(data){
				Ego.success('删除成功!');
				footable.removeRow($row);
				footable = null;
				$row = null;
			}, function(data){
				Ego.error('删除失败!');
			}, function(data) {
			});
		});
	});

	$('#btn-confirm').on('click', function() { //确认删除
		
	});

	$('.driver-check').on('click', function() { //选中/取消选中
		Checked.checked(this);
		if($('.driver-check').filter('[checked=checked]').length == $('.driver-check').length) {
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
	
	$('#create-driver').on('click', function(){
		window.location.href = webHost + '/logistics/driver/addDriver';
	});
	
	// 添加司机页面
	if($('#org-list').length != 0) {
		loadTOrgs('org-list', 3);
	}
	if($('#agent-list').length != 0 && $('#sOrgNO').val().length > 0) {
		loadAgents($('#sOrgNO').val());
	}
	if($('#warehouse-list').length != 0 && $('#nAgentID').val().length > 0) {
		loadWarehouse($('#nAgentID').val());
	}
	
	$('#org-list').on('click', '.org-item', function(){
		$('#current-org').text($(this).text());
		$('#sOrgNO').val($(this).attr('value'));
		$('#current-agent').text('请选择');
		$('#nAgentID').val('');
		$('#agent-list').empty();
		$('#current-ware-house').text('请选择');
		$('#sWarehouseName').val('');
		$('#sWareHouseNo').val('');
		$('#warehouse-list').empty();
		loadAgents($(this).attr('value'));
	});
	
	$('#agent-list').on('click', '.agent-item', function(){
		$('#current-agent').text($(this).text());
		$('#nAgentID').val($(this).attr('value'));
		$('#current-ware-house').text('请选择');
		$('#sWarehouseName').val('');
		$('#sWareHouseNo').val('');
		$('#warehouse-list').empty();
		loadWarehouse($(this).attr('value'));
	});
	
	$('#warehouse-list').on('click', '.warehouse-item', function(){
		$('#current-ware-house').text($(this).text());
		$('#sWarehouseName').val($(this).text());
		$('#sWareHouseNo').val($(this).attr('value'));
	});
	
	$('#cancel-create-driver').on('click', function(){
		window.location.href = webHost + '/logistics/driver/index';
	});
	
	$('#submit-create-driver').on('click', function(){
		if(!validator()) return;
		post(webHost + '/logistics/driver/addDriver' ,$('#create-driver-form').serialize(), function(data){
			Ego.success('新建司机成功!', function(){
				window.location.href = webHost + '/logistics/driver/index';
			});
		},function(data){
			Ego.error('新建司机失败!');
		});
	});
	
	var driverState = '';
	$('#batch-audit').on('click', function(){
		var $driverIds = $('.driver-check').filter('[checked=checked]');
		var canBeAudit = true;
		if($driverIds.length < 1) {
			Ego.error('必须选择至少一个司机进行操作!');
			return;
		}
		var temp = null;
		$driverIds.each(function(){
			if(null == temp) temp = $(this).attr('data-tag');
			if($(this).attr('data-tag') != temp) {
				Ego.error('只能对相同状态的司机进行批量操作!');
				canBeAudit = false;
				return;
			}
		});
		if(temp == 0) {
			$('#a-audit-tag').text('确定要禁用吗！');
			$('#submit-audit').val('禁用');
			driverState = 'DISABLE';
		}
		if(temp == 1) {
			$('#a-audit-tag').text('确定要启用吗！');
			$('#submit-audit').val('启用');
			driverState = 'ENABLE';
		} 
		canBeAudit && $('#audit-alert').modal('show');
	});
	
	$('#submit-audit').on('click', function(){
		var $driverIds = $('.driver-check').filter('[checked=checked]');
		var driverIds = [];
		$driverIds.each(function(){
			driverIds.push($(this).attr('data-id'));
		});
		post(webHost + '/logistics/driver/changeState', {driverState : driverState, driverIds : driverIds}, function(data){
			pager('driver-search-form', $('.navigation_bar .active').find('a').text(), 10, true);
		},function(data){
			Ego.error('审核失败!');
		});
	});
	
	
	$('#batch-export').on('click', function(){
		var $driverIds = $('.driver-check').filter('[checked=checked]');
		var driverIds = '';
		$driverIds.each(function(){
			driverIds += $(this).attr('data-id') + ',';
		});
		window.open(webHost + '/logistics/driver/exeproExcel?' +
				'sDrivemanNo=' + $('#f-sDrivemanNo').val() + 
				'&driverState=' + $('#driverState').val() + 
				'&sDrivemanIds='+driverIds);
	});
	
	$('#driver-status-memu li').on('click', function(){
		$('#driverState').val($(this).attr('value'));
		$('#driver-status-text').text($(this).text());
	});
});