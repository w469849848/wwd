$(function() {
	$('#perm-freeze').on('click', function() {
		var $perms = $('.perm-check').filter('[checked=checked]');
		if($perms.length < 1) {Member.error('必须选择要冻结的权限!');return};
		var isValid = null;
		for(var index in $perms) {
			if($perms[index].type != 'checkbox') continue;
			var $perm = $($perms[index]);
			if(null == isValid) isValid = $perm.attr('data-valid');
			if(isValid != $perm.attr('data-valid')) {
				Ego.error('所选权限状态不一致！');
				return;
			}
		}
		if('false' == isValid) {
			Ego.error('只能对激活状态的权限进行冻结！');
			return;
		}
		Ego.alert('是否确定冻结权限！', function(index) {
			var $perms = $('.perm-check').filter('[checked=checked]');
			if($perms.length < 1) return;
			var permIds = [];
			$perms.each(function(){
				permIds.push($(this).attr('data-id'));
			});
			Member.post(webHost + '/member/permission/freeze', {permIds : permIds}, function(data){
				window.location.href = '';
			},function(data){
				Member.error('冻结权限失败！');
			},function(data){});
		});
	});
	
	$('#perm-active').on('click', function() {
		var $perms = $('.perm-check').filter('[checked=checked]');
		if($perms.length < 1) {Member.error('必须选择要激活的权限!');return};
		var isValid = null;
		for(var index in $perms) {
			if($perms[index].type != 'checkbox') continue;
			var $perm = $($perms[index]);
			if(null == isValid) isValid = $perm.attr('data-valid');
			if(isValid != $perm.attr('data-valid')) {
				Ego.error('所选权限状态不一致！');
				return;
			}
		}
		if('true' == isValid) {
			Ego.error('只能对冻结状态的权限进行激活！');
			return;
		}
		Ego.alert('是否确定激活权限！', function(index) {
			var $perms = $('.perm-check').filter('[checked=checked]');
			if($perms.length < 1) return;
			var permIds = [];
			$perms.each(function(){
				permIds.push($(this).attr('data-id'));
			});
			Member.post(webHost + '/member/permission/active', {permIds : permIds}, function(data){
				window.location.href = '';
			},function(data){
				Member.error('激活权限失败！');
			},function(data){});
		});
	});
	
	$('#perm-search').on('click', function(){
		$('#perm-search-form').submit();
	});
	
	$('#perm-devops').on('click', function() {
		window.location.href = webHost + '/member/permission/create';
	});
	
	if($('#permission-tree').length > 0) {
		Member.post(webHost + '/member/permission/queryAll',{},function(data){
			for(var index in data.permissions) {
				data.permissions[index].icons = data.permissions[index].icon;
				delete data.permissions[index].icon;
			}
			$.fn.zTree.init($('#permission-tree'), {
				view : {
					selectedMulti : false,
					showIcon: false,
					fontCss : {
						color : '#393939'
					}
				},
				data : {
					key : {
						checked : "isChecked",
						url: 'jvascript:void(0);'
					},
					simpleData : {
						enable : true,
						idKey : 'keys',
						pIdKey : 'parentKeys',
						rootPId : '0'
					}
				},
				callback : {
					onClick : function(e, treeId, treeNode) {
						actionType == 'create' && clickPermNode(treeNode, true);
						actionType != 'create' && clickPermNode(treeNode, false);
					}
				}}, data.permissions);
			var tree = $.fn.zTree.getZTreeObj('permission-tree');
			tree.expandAll(true);
			tree.selectNode(tree.getNodes()[0]);
			// clickPermNode(tree.getNodes()[0], false);
		},function(data){
			Member.error('获取权限树失败！');
		});
	}
	
	var clickPermNode = function(node, isCreate) {
		console.log(actionType);
		if(actionType == 'create') {
			$('#parentName').val(node.name);
			$('#parentId').val(node.id);
			$('#parentKeys').val(node.keys);
			$('#level').val(isCreate ? node.level + 1 : node.level);
			$('#id').val('');
		}
		else if(actionType == 'edit') {
			$('#parentName').val(node.parentName);
			$('#parentId').val(node.parentId);
			$('#parentKeys').val(node.parentKeys);
			$('#level').val(isCreate ? node.level + 1 : node.level);
			$('#id').val(node.id);
		}
		else {
			Ego.error('请选择新建或者编辑');
			return;
		}
		$('#platform').val(node.platform);
		$('#type').val(node.type);
		$('#version').val(node.version);
		$('#name').val(node.name);
		$('#url').val(node.url);
		$('#keys').val(node.keys);
		$('#namespace').val(node.namespace);
		$('#icon').val(node.icons);
		$('#idx').val(node.idx);
	};
	
	$('#perm-delete').on('click', function() {
		var select = Member.getSelectNode('permission-tree');
		if (null == select)
			return;
		if (select.children && select.children.length > 0) {
			Member.error('该权限有子权限，不能直接删除！');
			return;
		}
		Ego.alert('确定要删除组织机构！', function(index) {
			Member.post(webHost + '/member/permission/delete',{'permIds' : select.id},function(data){
				window.location.href = '';
			},function(data){
				Member.error('删除权限失败！');
			},function(data){});
		});
	});
	
	$('#cancel-perm-create').on('click', function(){
		window.location.href = webHost + '/member/permission/index';
	});
	
	$('#perm-edit').on('click', function() {
		$('.role-left-side').show();
		var select = Member.getSelectNode('permission-tree');
		if (null == select)
			return;
		actionType = 'edit';
		clickPermNode(select, false);
		$('#id').val(select.id);
		$('#submit-perm-change span').text('编辑保存');
	});

	$('#perm-create').on('click', function() {
		$('.role-left-side').show();
		var select = Member.getSelectNode('permission-tree');
		if (null == select)
			return;
		actionType = 'create';
		clickPermNode(select, true);
		$('#name').val('');
		$('#url').val('');
		$('#keys').val('');
		$('#namespace').val('');
		$('#icon').val('');
		$('#idx').val('');
		$('#id').val('');
		$('#submit-perm-change span').text('新建保存');
	});

	var actionType = '';
	$('#submit-perm-change').on('click', function(){
		if(actionType == '') {
			Ego.error('请选择或者还是编辑');
			return;
		}
		if($('#keys').val().length > 0) {
			var status = $.ajax({
				type : 'POST',
				url : webHost + '/member/permission/validate',
				data : $('#create-perm-form').serialize(),
				dataType : "json",
				cache : false,
				async: false,
				traditional:true,
				success : function(data) {
					if(data.statusCode != 200) { Ego.error('权限KEY校验未通过，同一平台存在相同的KEY'); }
					else { return; }
				},
				error : function(data){ Ego.error('系统异常');},
				complete : function(data){},
			});
			if(JSON.parse(status.responseText).statusCode != 200) {
				return;
			}
		}
		if(actionType == 'create') {
			if(!validatePerm()) {
				return;
			}
			Member.post(webHost + '/member/permission/create',$('#create-perm-form').serialize(),function(data){
				Ego.success('新建权限成功', function() {
					window.location.href = '';
				});
			},function(data){
				Member.error('保存失败！');
			},function(data){});
		}
		else if(actionType == 'edit') {
			Member.post(webHost + '/member/permission/modify',$('#create-perm-form').serialize(),function(data){
				Ego.success('编辑权限成功', function() {
					window.location.href = '';
				});
			},function(data){
				Member.error('保存失败！');
			},function(data){});
		}
	});
	
	var validatePerm = function() {
		if ($('#name').val().length < 1) {
			Ego.error('权限名称不能为空');
		} else if ($('#keys').val().length < 1) {
			Ego.error('权限KEY不能为空');
		} else if ($('#url').val().length < 1) {
			Ego.error('权限URL不能为空');
		} else if ($('#url').val().length < 1) {
			Ego.error('权限URL不能为空');
		} else {
			return true;
		}
		return false;
	};
	
	if($('.role-left-side').length > 0) {
		$('.role-left-side').hide();
	}
});