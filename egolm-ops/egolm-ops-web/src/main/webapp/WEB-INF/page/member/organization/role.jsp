<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<form id="remove-role-ids-form">
<div class="pageContent">
	<div id="jbsxBox3" class="unitBox"
		style="float: left; display: block; overflow: auto; width: 100%;">
		<h2 class="contentTitle">角色列表</h2>
		<div class="panelBar">
		<ul class="toolBar">
			<li>
				<a href="javascript:void(0)" class="add" id="org-add-role"> 
					<span>添加角色</span>
				</a>
			</li>
			<li>
				<a href="javascript:void(0)" class="delete" id="org-remove-role">
					<span>移除角色</span>
				</a>
			</li>
			<li class="line">line</li>
		</ul>
		</div>
	</div>
	<table class="table" width="100%">
		<thead>
			<tr>
				<th width="22"><input type="checkbox" group="roleIds" class="checkboxCtrl"><</th>
				<th width="100">角色ID</th>
				<th width="100">角色名称</th>
				<th width="100">所属组织</th>
				<th width="100">有效性</th>
				<th width="200">描述</th>
				<th width="100">创建时间</th>
				<th width="100">更新时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="role" items="${roles}">
					<tr target="sid_user">
						<td><input name="roleIds" value="${role.id}" type="checkbox"></td>
						<td>${role.id}</td>
						<td>${role.name}</td>
						<td>${role.organizationName}</td>
						<td>${role.isValid ? "激活" : "冻结"}</td>
						<td>${role.description}</td>
						<td><fmt:formatDate value="${role.createTime}" pattern="yyyy-MM-dd" /></td>
						<td><fmt:formatDate value="${role.updateTime}" pattern="yyyy-MM-dd" /></td>
					</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="panelBar">
		<div class="pages">
			<span>显示</span> <select class="combox" name="numPerPage"
				onchange="navTabPageBreak({numPerPage:this.value})">
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="100">100</option>
				<option value="200">200</option>
			</select> <span>条，共${totalCount}条</span>
		</div>

		<div class="pagination" targetType="navTab" totalCount="200"
			numPerPage="10" pageNumShown="10" currentPage="1"></div>

	</div>
</div>
</form>
<script type="text/javascript">
	$(function(){
		$('#org-add-role').on('click',function(){
			dialog('role/index?showInOrganization=true','organization-modify-dialog','组织机构编辑',{height : 500});
		});
		
		$('#org-remove-role').on('click', function() {
			var select = getSelectNode('organization-tree');
			var form = $('#remove-role-ids-form').serializeObject();
			if(undefined == form.roleIds || null == form.roleIds) {
				alertMsg.error('请选择需要移除的角色！');
				return;
			}
			Net.post('organization/removeRoles', $.extend({orgId:select.id},{roleIds:form.roleIds}), function(data) {
				$.pdialog.closeCurrent();
				loadRoleUnderOrganization();
			}, function(data) {
				alertMsg.error('移除角色失败！');
			});
		});
	});
</script>