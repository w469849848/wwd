$(function(){
	var selectItem = [];
	if($('#group-tree').length > 0) {
	setTimeout(function() {
		Member.loadBaseGroupTree();
		Member.loadRoleUnderGroup({index:1,limit:10});
		$('.buttonActive button').click();
	}, 10);
	}
	
	$('#group-auth').on('click', function(e) {
		e.stopPropagation();
		var select = Member.getSelectNode('group-tree');
		if (null == select)
			return;
		Member.loadPermissionTree('permission-tree', {'unit':'group','unitId':Member.baseGroup.id});
		Member.groupAuth = true;
		$('#permission-tree-alert').modal('show');
	});
	
	$('#submit-permission-auth').on('click',function(e){
		e.stopPropagation();
		var tree = $.fn.zTree.getZTreeObj('permission-tree');
		var checkNodes = tree.getCheckedNodes(true);
		var unitIds = [];
		for(var index in checkNodes) {
			unitIds.push(checkNodes[index].id)
		}
		var param = {};
		param['groupIds'] = [Member.baseGroup.id];
		param['permissionIds'] = unitIds;
		Member.post(webHost + '/member/group/authorization', param, function(data){
			data.statusCode == '200' && $('#permission-tree-alert').modal('hide');;
			data.statusCode != '200' && Member.error('您提交的数据有误，请检查后重新提交！');
			Ego.success('授权成功');
		},function(data){
			Member.error('授权失败！');
		},function(data){});
	});
	
	$('#group-info').on('click', function() {
		var select = Member.getSelectNode('group-tree');
		if (null == select)
			return;
		$('#info-name').text(Member.baseGroup.name);
		$('#info-prev').text((Member.baseGroup.getParentNode() && Member.baseGroup.getParentNode().name) || '');
		$('#info-level').text(Member.baseGroup.level + 1);
		$('#info-subs').text(Member.getSubNodeSize([Member.baseGroup]));
		$('#info-desc').text(Member.baseGroup.description);
		$('#info-group-alert').modal('show');
	});
	
	$('#group-delete').on('click', function() {
		var select = Member.getSelectNode('group-tree');
		if (null == select)
			return;
		if (select.children && select.children.length > 0) {
			Member.error('该组织有下属机构，不能直接删除！');
			return;
		}
		Member.deleteGroup = true;
		Ego.alert('确定要删除组织机构！', function(index) {
			if(Member.deleteGroup) {
				Member.post(webHost + '/member/group/delete',{'groupId' : Member.baseGroup.id},function(data){
					Member.loadBaseGroupTree();
				},function(data){
					Member.error('删除组织机构失败！');
				},function(data){Member.deleteGroup = false;});
			}
		});
	});
	
	$('#group-modify').on('click', function(e) {
		e.stopPropagation();
		$('#modify-group-i').show();
		$('#modify-group-n').show();
		var select = Member.getSelectNode('group-tree');
		if (null == select)
			return;
		Member.loadCurrentGroupTree('modify-group-tree');
		$('#modify-group-id').val(Member.baseGroup.id);
		$('#modify-group-name').val(Member.baseGroup.name);
		if(0 == Member.baseGroup.level || 1 == Member.baseGroup.level) {
			$('#modify-group-i').hide();
		}
		else if(2 == Member.baseGroup.level) {
			Ego.error('省份不支持编辑！');
			return;
		}
		else if(3 == Member.baseGroup.level) {
			Ego.error('城市不支持编辑！');
			return;
		}
		else {
			$('#modify-group-i').hide();
		}
		$('#modify-group-alert').modal('show');
	});
	
	$('#submit-group-modify').on('click', function(e){
		var node = Member.getSelectNode('modify-group-tree');
		if(null == node) return;
		if(Member.isSubNode(Member.baseGroup,node)) {
			Member.error('上级组织不能降为子级的子组织!');
			return;
		}
		if(Member.baseGroup.name == $.trim($('#modify-group-name').val()) &&
		   Member.baseGroup.description ==$.trim($('#modify-group-desc').val()) &&
		   Member.baseGroup.parentId == node.parentId){
			$('#modify-group-alert').modal('hide');
			return;
		}  
		Member.post(webHost + '/member/group/modify',{
			name:$.trim($('#modify-group-name').val()),
			description:$.trim($('#modify-group-desc').val()),
			parentId:node.parentId,
			id:Member.baseGroup.id,
		},function(){
			$('#modify-group-alert').modal('hide');
			Member.loadBaseGroupTree();
		},function(){Member.error('编辑组织机构信息失败!');});
	});
	
	var currentRoleId = null;
	$(document).on('click', 'td a.delete', function(e) { //显示删除弹窗
		e.stopPropagation();
		var $row = $(this).parents('tr:first');
		currentRoleId = $row.find('input').filter('.role-check').attr('data-id');
		Ego.alert('确定要删除绑定的角色！', function(index) {
			if(!Member.deleteGroup) {
				Member.post(webHost + '/member/role/delete', {roleIds : [currentRoleId]}, function(data){
					Member.loadRoleUnderGroup({index:1,limit:10});
				},function(data){
					Member.error('删除失败！');
				},function(data){});
			}
		});
	});
	
	$(document).on('click', '#batch-delete-role', function(e){
		e.stopPropagation();
		var $roles = $('.role-check').filter('[checked=checked]');
		if($roles.length < 1) return;
		var roleIds = [];
		$roles.each(function(){
			roleIds.push($(this).attr('data-id'));
		});
		Ego.alert('确定要批量删除绑定的角色！', function(index) {
			Member.post(webHost + '/member/role/delete', {roleIds : roleIds}, function(data){
				window.location.href = '';
			},function(data){
				Member.error('删除失败！');
			},function(data){});
		});
	});
	
	$('.role-left-side').on('click', '#group-role-filter', function(){
		Member.loadRoleUnderGroup({name : $('#group-role-name').val()});
	});
	
	// create group
	
	if($('#create-group-tree').length > 0) {
		Member.loadGroupTree("create-group-tree", Member.ztreeSetting.extend({callback : {
			onClick : function(e, treeId, treeNode) {
				addGroupTreeClick(e, treeId, treeNode);
			}
		}}),function(tree){
			tree.expandAll(true);
			var fgi = $('#forward-group-id').val();
			console.log(fgi);
			var nodes = tree.getNodesByParam('id',fgi);
			for(var index in nodes) {
				if(nodes[index].id == fgi) {
					tree.selectNode(nodes[index]);
					$("#"+nodes[index].tId+"_a").click();
					break;
				}
			}
		});
	}
	
	var level = 0;
	var addGroupTreeClick = function(e, treeId, treeNode) {
		level = treeNode.level;
		$('#group-name').val('');
		$('#group-city').empty();
		$('#group-parentId').val(treeNode.id);
		if(0 == treeNode.level) {
			$('#id-label').text('大区编号：');
			$('#group-id').prop('readonly', true);
			$('#name-label').text('大区名称：');
			$('#group-name').prop('readonly', false);
			$('#group-province').prop('disabled', true);
			$('#group-province').parents('label:first').hide();
			$('#group-city').prop('disabled', true);
			$('#group-city').parents('label:first').hide();
			$('#group-id').val(getNewNodeIndex(treeNode));
		}
		else if (1 == treeNode.level) {
			$('#id-label').text('省份编号：');
			$('#group-id').prop('readonly', true);
			$('#name-label').text('省份名称：');
			$('#group-name').prop('readonly', true);
			$('#group-province').prop('disabled', false);
			$('#group-province').parents('label:first').show();
			$('#group-city').prop('disabled', true);
			$('#group-city').parents('label:first').hide();
			$('#group-id').val(getNewNodeIndex(treeNode));
			loadProvince();
		}
		else if(2 == treeNode.level) {
			$('#id-label').text('城市编号：');
			$('#group-id').prop('readonly', false);
			$('#name-label').text('城市名称：');
			$('#group-name').prop('readonly', true);
			$('#group-province').prop('disabled', true);
			$('#group-province').parents('label:first').hide();
			$('#group-city').prop('disabled', false);
			$('#group-city').parents('label:first').show();
			$('#group-id').val('');
			loadCity(treeNode.regionNO);
		}
		else {
			$('#id-label').text('组织编号：');
			$('#group-id').prop('readonly', false);
			$('#name-label').text('组织名称：');
			$('#group-name').prop('readonly', false);
			$('#group-province').prop('disabled', true);
			$('#group-province').parents('label:first').hide();
			$('#group-city').prop('disabled', true);
			$('#group-city').parents('label:first').hide();
			$('#group-id').val('');
		}
		
	}
	
	var getNewNodeIndex = function(node) {
		var children = node.children;
		if(undefined == children) {
			if(0 == node.level) return node.id + '01';
			if(1 == node.level) return node.id + '01';
		}
		else {
			var cds = node.children;
			var index = 2;
			for(var i in cds) {
				if(cds[i].id > index) index = parseInt(cds[i].id) + 1;
			}
			var i = (index > 8 && (index + 1)) || ('0' + (index + 1));
			if(0 == node.level) return '00' + i;
			if(1 == node.level) return '000' + i;
		}
	}
	
	var loadProvince = function() {
		Member.post(webHost + '/base/region/allProvince', {}, function(data){
			var ps = data.provinces;
			var option = '';
			$('#group-province').empty();
			for(var index in ps) {
				option += '<option data-sRegionDesc='+ps[index].sRegionDesc+' data-sOrgTypeID='+ps[index].sOrgTypeID+' data-sOrgType='+ps[index].sOrgType+' data-sRegionNO='+ps[index].sRegionNO+'>'+ps[index].sRegionDesc+'</option>'
			}
			$('#group-province').append(option);
			$('.selectpicker').selectpicker('refresh');
		},function(data){
			Ego.error('获取行政区划数据失败！');
		},function(data){});
	}
	
	var loadCity = function(provinceNO) {
		Member.post(webHost + '/base/region/allCityInProvince', {provinceNO : provinceNO}, function(data){
			var cs = data.cities;
			var option = '';
			for(var index in cs) {
				option += '<option data-sRegionDesc='+cs[index].sRegionDesc+' data-sOrgTypeID='+cs[index].sOrgTypeID+' data-sOrgType='+cs[index].sOrgType+' data-sRegionNO='+cs[index].sRegionNO+'>'+cs[index].sRegionDesc+'</option>'
			}
			$('#group-city').append(option);
			$('.selectpicker').selectpicker('refresh');
		},function(data){
			Ego.error('获取行政区划数据失败！');
		},function(data){});
	}
	
	$('#group-province').on('change', function(){
		var $this = $(this).find('option:selected');
		$('#groupType').val($this.attr('data-sOrgType'));
		$('#groupTypeId').val($this.attr('ddata-sOrgTypeID'));
		$('#regionNO').val($this.attr('data-sRegionNO'));
		$('#group-name').val($this.attr('data-sRegionDesc'));
	});
	
	$('#group-city').on('change', function(){
		var $this = $(this).find('option:selected');
		$('#groupType').val($this.attr('data-sOrgType'));
		$('#groupTypeId').val($this.attr('ddata-sOrgTypeID'));
		$('#regionNO').val($this.attr('data-sRegionNO'));
		$('#group-name').val($this.attr('data-sRegionDesc'));
	});
	
	$('#cancel-group-create').on('click', function() {
		window.location.href = webHost + '/member/group/index';
	});
	
	$('#group-create').on('click', function(e) {
		window.location.href = webHost+'/member/group/create' + '?groupId='+Member.baseGroup.id;
	});
	
	$('#submit-group-create').on('click',function(e){
		if(!validator())return;
		Member.post(webHost + '/member/group/create', $('#create-group-form').serialize() ,function(data){
			Ego.success('新建组织机构成功!', function() {
				window.location.href = webHost + '/member/group/index';
			});
		},function(data){
			Member.error('新建组织机构失败！');
		});
	});
	
	var validator = function() {
		if($.trim($('#group-id').val()).length < 1) {
			if(2 == level) {
				Ego.error('城市编号不能为空！');
			}
			else if(2 <= level) {
				Ego.error('组织编号不能为空！');
				return false;
			}
			return false;
		}
		if($.trim($('#group-name').val()).length < 1) {
			if(0 == level) {
				Ego.error('大区名称不能为空！');
			}
			else if(1 == level)  {
				Ego.error('必须选择省份！');
			}
			else if(2 == level) {
				Ego.error('必须选择城市！');
			}
			else {
				Ego.error('组织名称不能为空！');
			}
			return false;
		}
		return true;
	}
});