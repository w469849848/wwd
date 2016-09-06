var Member = {};

Member.success = function(msg) {
	Ego.success(msg);
};
Member.error = function(msg) {
	Ego.error(msg);
};

Member.currentGroup = null;
Member.baseGroup = null;
Member.isAll = false, //true为全选，false为未选中

Member.ztreeSetting = {
	view : {
		selectedMulti : false,
		showIcon: false,
		fontCss : {
			color : '#393939'
		}
	},
	data : {
		simpleData : {
			enable : true,
			idKey : 'id',
			pIdKey : 'parentId',
			rootPId : '0'
		}
	},
	callback : {
		onClick : function(e, treeId, treeNode) {
			Member.currentGroup = treeNode;
		}
	},
	extend : function(ex) {
		return $.extend({},Member.ztreeSetting, ex);
	}
};

Member.permissionSetting = {
	view : {
		selectedMulti : false,
		showIcon: false,
		fontCss : {
			color : '#393939'
		}
	},
	check : {
		enable : true
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
			$('#permission-tree-id').val(treeNode.id);
		}
	}};

Member.selectNode = function(rootName, nodeId) {
	var tree = $.fn.zTree.getZTreeObj(rootName);
	tree.selectNode(tree.getNodeByTId(nodeId));
}

Member.loadGroupTree = function(rootName, settings, callback) {
	Member.post(webHost + '/member/group/queryAll', {}, function(data) {
		$.fn.zTree.init($("#" + rootName), settings, data.groups);
		var tree = $.fn.zTree.getZTreeObj(rootName);
		var nodes = tree.getNodes();
		if (nodes.length > 0) {
			callback && callback(tree);
		}
	});
}

Member.loadCurrentGroupTree = function(treeName, nodeId) {
	Member.loadGroupTree(treeName, Member.ztreeSetting.extend({callback : {
		onClick : function(e, treeId, treeNode) {
			Member.currentGroup = treeNode;
		}
	}}),function(tree){
		// tree.expandAll(true);
		Member.currentGroup = Member.baseGroup;
		Member.baseGroup && tree.selectNode(tree.getNodeByTId(Member.baseGroup.tId));
		if(nodeId) {
			var nodes = tree.getNodesByParam('id',nodeId);
			for(var index in nodes) {
				if(nodes[index].id == nodeId) {
					tree.selectNode(nodes[index]);
					Member.currentGroup = nodes[index];
					break;
				}
			}
		}
	});
}

Member.loadBaseGroupTree = function() {
	Member.loadGroupTree("group-tree", Member.ztreeSetting.extend({callback : {
		onClick : function(e, treeId, treeNode) {
			Member.baseGroup = treeNode;
			Member.loadRoleUnderGroup();
		}
	}}),function(tree){
		tree.expandAll(true);
		tree.selectNode((Member.baseGroup && tree.getNodeByTId(Member.baseGroup.tId)) || (tree.getNodes() && tree.getNodes()[0]));
		Member.baseGroup = tree.getSelectedNodes()[0];
	});
}

Member.loadRoleUnderGroup = function(params) {
	$.ajax({
		type : 'POST',
		url : webHost + '/member/role/queryRolesUnderGroup',
		data : $.extend(params, {groupId:(Member.baseGroup && Member.baseGroup.id) || '0'}),
		dataType : "text",
		cache : false,
		traditional:true,
		success : function(data) {
			$('#group-role').empty();
			$('#group-role').append($(data));
		},
		error : function(data){ },
		complete : function(data){ },
	});
}

Member.getSelectNode = function(treeName, required) {
	var tree = $.fn.zTree.getZTreeObj(treeName);
	if(required && !tree){Member.error('系统异常，请刷新页面！');return null};
	if(!tree && !required) return null;
	var node = tree.getSelectedNodes();
	if(required && $.isEmptyObject(node)) {Member.error('您必须选定一个组织机构！');return null;}
	if(required && node.length > 1) {Member.error('您只能对一个组织机构进行操作!');return null;}
	return node[0];
}

Member.isSubNode = function(parentNode,subNode) {
	var subNodes = parentNode.children;
	for(var index in subNodes) {
		if(subNodes[index].id == subNode.id) return true;
		if(subNodes[index].children && Member.isSubNode(subNodes[index], subNode)) return true;
	}
	return false;
}

Member.getSubNodeSize = function(nodes) {
	var size = 0;
	for(var index in nodes) {
		size += ((nodes[index] && nodes[index].children) || 0) && (nodes[index].children.length + Member.getSubNodeSize(nodes[index].children));
	}
	return size;
}

Member.loadPermissionTree = function(rootName, params){
	Member.post(webHost + '/member/permission/tree',params,function(data){
		for(var index in data.permissions) {
			delete data.permissions[index].icon;
		}
		$.fn.zTree.init($("#"+rootName), Member.permissionSetting, data.permissions);
		var tree = $.fn.zTree.getZTreeObj(rootName);
		tree.expandAll(true);
		var ownPerms = data.ownPermissions;
		for(var index in ownPerms) {
			var node = tree.getNodeByParam('keys',ownPerms[index].keys,null);
			node && tree.checkNode(node);
		}
	},function(data){
		Member.error('获取权限树失败！');
	});
};

Member.validateOnlyOneChoose = function() {
	var $checkRoles = $('.role-check').filter('[checked=checked]');
	if($checkRoles.length < 1) {
		Member.error('请选择需要操作的角色!');
		return '';
	}
	if($checkRoles.length > 1) {
		Member.error('不能同时操作两个角色!');
		return '';
	}
	return $checkRoles;
};

Member.post = function(url, data, success, error, complete) {
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

Member.pager = function(formId, page, pageSize) {
	if('group-role-query' == formId) {
		Member.loadRoleUnderGroup({index : page, limit : pageSize, name : $('#group-role-name').val()});
		return;
	}
	var $form = $('#' + formId);
	$form.append('<input type="hidden" name="index" value="' + page + '">');
	$form.append('<input type="hidden" name="limit" value="' + pageSize + '">');
	$form.submit();
}


$(function(){
	isAll = false;
	$(document).on('click', '.checked-wrap .chk', function() { //选中/取消选中
		Checked.checked(this);
		if($('.checked-wrap .chk').filter('[checked=checked]').length == $('.checked-wrap .chk').length) {
			$('.batch .chk').attr('checked',true);
			$('.batch .chk').parents('label:first').addClass('checked');
			isAll = true;
		}else {
			$('.batch .chk').attr('checked',false);
			$('.batch .chk').parents('label:first').removeClass('checked');
			isAll = false;
		}
	});

	$(document).on('click', '.batch .chk', function() { //全选/取消全选
		Checked.selectAll(this, isAll);
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	
	function removeRole() {
		var select = Member.getSelectNode('group-tree');
		var form = $('#remove-role-ids-form').serializeObject();
		if(undefined == form.roleIds || null == form.roleIds) {
			alertMsg.error('请选择需要移除的角色！');
			return;
		}
		Member.post(webHost + '/member/group/removeRoles', $.extend({orgId:select.id},{roleIds:form.roleIds}), function(data) {
			$.pdialog.closeCurrent();
			loadRoleUnderOrganization();
		}, function(data) {
			alertMsg.error('移除角色失败！');
		});
	};
});
