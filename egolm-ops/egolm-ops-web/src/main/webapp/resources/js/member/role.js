$(function(){
	$('#role-create').on('click',function(){
		Member.post(webHost+ '/member/group/queryAll', {}, function(data) {
			/*var $orgs = $('#create-role-orgs');
			var option = '<select class="combox" name="organizationId" style="width:200px;" size="1"><option value="">选择组织架构归属</option>';
			$orgs.empty();
			for(var index in data.orgs) {
				'<a value="" name="orgId" class="" href="javascript:">选择组织架构归属</a>';
				option += '<option value="'+data.orgs[index].id+'">'+data.orgs[index].name+'</option>';
			}
			option += '</select>';
			$orgs.append(option);*/
			Member.loadCurrentGroupTree('create-role-tree');
			$('#create-role-alert').modal('show');
		},function(data){
			Member.error('获取组织机构信息失败！');
		});
	});
	
	$('#submit-role-create').on('click',function(){
		if(!Member.currentGroup){Member.error('必须选择一个组织机构！');return ;}
		if($.trim($('#create-role-name').val()) == '') {Member.error('必须有组织名称！');return ;}
		$('#create-role-group-id').val(Member.currentGroup.id);
		Member.post(webHost + '/member/role/create', $('#create-role-form').serialize(), function(data) {
			$('#create-role-alert').modal('hide');
			//Member.success('角色创建成功！');
			window.location.href = '';
		},function(){
			Member.error('角色创建失败！');
		});
	});
	
	$('#role-modify').on('click',function(){
		var $role = Member.validateOnlyOneChoose();
		if($role.length < 1) return;
		Member.loadCurrentGroupTree('modify-role-tree', $role.attr('data-group').split(',')[0]);
		$('#modify-role-name').val($role.attr('data-name'));
		$('#modify-role-desc').val($role.attr('data-desc'));
		$('#modify-role-id').val($role.attr('data-id'));
		$('#modify-role-alert').modal('show');
	});
	
	$('#submit-role-modify').on('click',function(){
		var $role = Member.validateOnlyOneChoose();
		if($role.length < 1) return;
		var checkNode = Member.getSelectNode('modify-role-tree', true);
		if(null == checkNode) {
			return;
		}
		$('#modify-role-group-id').val(Member.currentGroup.id);
		if($role.attr('data-group').split(',')[0] != checkNode.id) {
			Ego.alert('改变角色的组织会清空角色已有权限！是否继续？', function() {
				modifyRole();
			});
		}else {
			modifyRole();
		}
	});
	
	var modifyRole = function() {
		Member.post(webHost + '/member/role/modify', $('#modify-role-form').serialize(), function(data) {
			Ego.success('角色编辑成功！', function() {
				$('#modify-role-alert').modal('hide');
				window.location.href = '';
			});
		},function(){
			Ego.error('角色编辑失败！');
		});
	}
	
	$('#role-auth').on('click', function(e){
		e.stopPropagation();
		var $role = Member.validateOnlyOneChoose();
		if($role.length < 1) return;
		Member.loadPermissionTree('permission-tree', {'unit':'role','unitId': $role.attr('data-id')});
		$('#permission-tree-alert').modal('show');
	});
	
	$('#submit-permission-auth').on('click',function(e){
		e.stopPropagation();
		var $role = Member.validateOnlyOneChoose();
		if($role.length < 1) return;
		var tree = $.fn.zTree.getZTreeObj('permission-tree');
		var checkNodes = tree.getCheckedNodes(true);
		var unitIds = [];
		for(var index in checkNodes) {
			unitIds.push(checkNodes[index].id)
		}
		var param = {};
		param['roleIds'] = [$role.attr('data-id')];
		param['permissionIds'] = unitIds;
		Member.post(webHost + '/member/role/authorization', param, function(data){
			$('#permission-tree-alert').modal('hide');
			Member.success('授权成功！');
		},function(data){
			Member.error('授权失败！');
		});
	});
	
	var currentRoleId = null;
	$('td a.delete').on('click', function(e) { //显示删除弹窗
		e.stopPropagation();
		var $row = $(this).parents('tr:first');
		currentRoleId = $row.find('input').filter('.role-check').attr('data-id');
		// $('#delete-alert').modal('show');
		Ego.alert('确定要删除角色！', function(index){
			Member.post(webHost + '/member/role/delete', {roleIds : [currentRoleId]}, function(data){
				window.location.href = '';
			},function(data){
				Member.error('删除失败！');
			},function(data){});
		});
	});
	
	$('#submit-delete').on('click', function(){
		
	});
	
	$('#batch-delete-role').on('click', function(e){
		e.stopPropagation();
		var $roles = $('.role-check').filter('[checked=checked]');
		if($roles.length < 1) {
			Ego.error('请选择需要删除的角色');
			return;
		}
		if($roles.length < 1) return;
		Ego.alert('确定要批量删除角色！', function(index){
			var roleIds = [];
			$roles.each(function(){
				roleIds.push($(this).attr('data-id'));
			});
			Member.post(webHost + '/member/role/delete', {roleIds : roleIds}, function(data){
				window.location.href = '';
			},function(data){
				Member.error('删除失败！');
			},function(data){});
		});
	});
	
	$('#role-search').on('click', function(){
		$('#role-search-form').submit();
	});
});