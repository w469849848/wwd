<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div style="display: block; margin: 10px auto;overflow: auto; width: 500px; height: 400px; border: solid 1px #CCC; line-height: 21px; background: #FFF;">
	<div id='permission-tree-div' class="menuContent ztreeMC" style="display: block; position: relative; height: 400px;">
		<ul id="permission-tree" class="ztree permission-tree"></ul>
		<input type="hidden" id="permission-tree-id" name="id" value="" />
	</div>
</div>
<div style="display: block;">
	<a class="button submit-permission" href="javascript:void(0)" style="float: left; margin: 5px auto 0px 100px;" ><span>授权</span></a> 
	<a class="button" href="#close" style="float: right;margin: 5px 100px 0px auto;" onclick="$.pdialog.closeCurrent();"><span>取消</span></a>
</div>
<input type="hidden" id="unit" value="${unit}"/>
<input type="hidden" id="unitId" value="${unitId}"/>
<script type="text/javascript">
$(function(){
	var url = $('#unit').val() == 'role' ? 'role/authorization' : 'organization/authorization';
	var unitIdName = $('#unit').val() == 'role' ? 'roleIds' : 'organizationIds';
	var setting = {view:{selectedMulti:false,fontCss:{color:'#393939'}},check:{enable:true},data:{key:{checked: "isChecked"}, simpleData:{enable:true,idKey:'keys',pIdKey:'parentId',rootPId:'0'}},callback:{onClick:function(e,treeId,treeNode){$('#permission-tree-id').val(treeNode.id);}}};
	loadPermissionTree("permission-tree",setting);
	
	$('.submit-permission').on('click',function(){
		var tree = $.fn.zTree.getZTreeObj('permission-tree');
		var checkNodes = tree.getCheckedNodes(true);
		var unitIds = [];
		for(var index in checkNodes) {
			unitIds.push(checkNodes[index].id)
		}
		var param = {};
		param[unitIdName] = $('#unitId').val().split(',');
		param['permissionIds'] = unitIds;
		Net.post(url,param,function(data){
			data.statusCode == '200' && $.pdialog.closeCurrent();
			data.statusCode != '200' && alertMsg.error('您提交的数据有误，请检查后重新提交！');
			loadPermUnderOrganization();
		},function(data){
			alertMsg.error('授权失败！');
		});
	});
	
	function loadPermissionTree(rootName, settings){
		Net.post('permission/tree',{'unit':$('#unit').val(),'unitId':$('#unitId').val()},function(data){
			$.fn.zTree.init($("#"+rootName), settings, data.permissions);
			var tree = $.fn.zTree.getZTreeObj(rootName);
			tree.expandAll(true);
			var ownPerms = data.ownPermissions;
			for(var index in ownPerms) {
				var node = tree.getNodeByParam('keys',ownPerms[index].keys,null);
				node && tree.checkNode(node);
			}
		},function(data){
			alertMsg.error('获取权限树失败！');
		});
	}
});
</script>