$(function(){
	$('#bind-role').on('click',function(){
		var $users = $('.user-check').filter('[checked=checked]');
		if($users.length < 1) {Member.error('必须选择要用户!');return};
		if($users.length > 1) {Member.error('一次只能对单个用户分配角色!');return};
		initRoleSelect({'userId':$($users[0]).attr('data-id')});
		$('#bind-role-alert').modal('show');
	});
	
	$('#role-name-input').on('blur', function(){
		initRoleSelect({name : $(this).val()});
	});
	
	$('#submit-bind-role').on('click', function(){
		var $users = $('.user-check').filter('[checked=checked]');
		var tree = $.fn.zTree.getZTreeObj('allocate-role-tree');
		var checkNodes = tree.getCheckedNodes(true);
		if(checkNodes.length < 1) {
			Member.error('必须选择一个角色!');
			return;
		}
		var roleIds = [];
		for(var index in checkNodes) {
			roleIds.push(checkNodes[index].id)
		}
		Member.post(webHost+ '/member/user/bindRole', {userId : $($users[0]).attr('data-id'), roleIds : roleIds}, function(data) {
			Member.success("绑定角色成功!");
			window.location.href = '';
		},function(data){
			Member.error("绑定角色失败!");
		});
	});
	
	$('#search-user').on('click', function(){
		console.log('dddd');
		$('#user-search-form').submit();
	});
	
	var settings = {
			view : {
				selectedMulti : false,
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
					idKey : 'groupName',
					pIdKey : 'groupName',
					rootPId : '0'
				}
			},
			callback : {
				onClick : function(e, treeId, treeNode) {
					$('#permission-tree-id').val(treeNode.id);
				}
	}};
	
	function initRoleSelect(params) {
		Member.post(webHost+ '/member/role/queryRoles',params,function(data){
			$.fn.zTree.init($('#allocate-role-tree'), settings, data.roles);
			var tree = $.fn.zTree.getZTreeObj('allocate-role-tree');
			tree.expandAll(true);
			var ownPerms = data.ownRoles;
			for(var index in ownPerms) {
				var node = tree.getNodeByParam('id',ownPerms[index].id,null);
				node && tree.checkNode(node);
			}
		},function(data){
			Member.error('获取角色数据失败！');
		});
	}
	
	$('#add-user').on('click', function(){
		window.location.href = webHost + '/member/user/signup';
	});
	
	$('#user-type').on('change', function() {
		if($('#user-type').val() == 'AGENT') {
			$('#real-id').parent('label:first').show();
		}
		else {
			$('#real-id').parent('label:first').hide();
		}
	});
	
	$('#cancel-user-create').on('click', function(){
		window.location.href = webHost + '/member/user/index';
	});
	
	$('#submit-user-create').on('click', function(){
		Member.post(webHost + '/member/user/signup', $('#create-user-form').serialize(), function(){
			Ego.success('添加用户成功！', function(index){
				window.location.href = webHost + '/member/user/index';
			});
		}, function(data){
			Ego.error('添加用户失败！');
		});
	});
	
	$('#batch-set-password').on('click', function(){
		var $chks = $('.checked-wrap .chk').filter('[checked=checked]');
		if($chks.length < 1) {
			Ego.error('必须选择用户');
			return;
		}
		var userIds = [];
		$chks.each(function(){
			userIds.push($.trim($(this).attr('data-id')));
		});
		
		layer.prompt(function(value, index, elem){
			if(undefined != value && value.length > 0) {
				setPassword(userIds, $.trim(value));
				layer.close(index);
			}
			else {
				Ego.error('请输入新密码');
			}
		});
	});
	
	var setPassword = function(userIds, newPassword) {
		HTTP.postAjx(webHost + '/member/user/setPassword', {userIds:userIds, newPassword:newPassword}, function(data){
			Ego.success('批量修改密码成功');
		}, function(data){
			Ego.error(data.message);
		});
	};
	
	var importAgent = function(password) {
		HTTP.postAjx(webHost + '/member/user/batchImportAgent', {password:password}, function(data){
			Ego.success('批量修改密码成功');
		}, function(data){
			Ego.error(data.message);
		});
	};
	
	$('#import-agent').on('click', function() {
		layer.prompt({title : '请输入新密码'}, function(value, index, elem){
			if(undefined != value && value.length > 0) {
				importAgent($.trim(value));
				layer.close(index);
			}
			else {
				Ego.error('请输入默认密码');
			}
		});
	});
});