<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 

<div id="resultBox"></div>
<div class="pageHeader">
	<form onsubmit="return ${showInOrganization?'dialogSearch(this)':'navTabSearch(this)'};" 
	      action="role/queryRoles${showInOrganization?'?showInOrganization=true':''}" method="post">
	<input type="hidden" name="page" value="${param.page}">
	<input type="hidden" name="pageSize" value="${param.pageSize}">
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td><label>所属组织：</label> <input type="text" name="organizationName" value="" /></td>
					<td><label>角色名称：</label> <input type="text" name="name" value="" /></td>
					<td>
						<div class="buttonActive">
							<div class="buttonContent">
								<button type="submit" id="submit-role-serach">检索</button>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>
</div>
<div class="pageContent">
	<div class="panelBar">
		<c:if test="${!showInOrganization}">
		<ul class="toolBar">
			<li><a href="role/create" target="dialog" rel="" mask="true" title="角色创建" class="add"><span>创建角色</span></a></li>
			<li><a href="role/delete" title="移除只是逻辑移除，确定要移除吗?" target="selectedTodo" rel="roleIds" class="delete"><span>移除角色</span></a></li>
			<li><a class="edit" id="role-modify-info"><span>编辑角色</span></a></li>
			<li><a class="edit" id="role-perm-author"><span>授权</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" targetType="navTab" title="实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
		</c:if>
	</div>
	<form id="add-role-ids-form">
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="22"><input type="checkbox" group="roleIds" class="checkboxCtrl"></th>
				<th width="100">角色ID</th>
				<th width="100">角色名称</th>
				<th width="100">所属组织</th>
				<th width="30">有效性</th>
				<th width="200">描述</th>
				<th width="100">创建时间</th>
				<th width="100">更新时间</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="role" items="${roles}">
				<tr target="sid_user">
				<td><input name="roleIds" value="${role.id}" type="checkbox"></td>
				<td class="role-id">${role.id}</td>
				<td>${role.name}</td>
				<td>${role.organizationName}</td>
				<td>${role.isValid ? "激活" : "冻结"}</td>
				<td>${role.description}</td>
				<td><fmt:formatDate value="${role.createTime}" pattern="yyyy-MM-dd"/></td>
				<td><fmt:formatDate value="${role.updateTime}" pattern="yyyy-MM-dd"/></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</form>
	<div class="panelBar">
		<div class="pages">
			<span>显示</span> <select class="combox" name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value})">
				<option value="20">20</option>
				<option value="50">50</option>
				<option value="100">100</option>
				<option value="200">200</option>
			</select> <span>条，共${totalCount}条</span>
		</div>

		<div class="pagination" targetType="navTab" totalCount="200"
			numPerPage="20" pageNumShown="10" currentPage="1"></div>

	</div>
</div>
<c:if test="${showInOrganization}">
<div style="width: 70%;margin-left: 15%;">
		<a class="button submit-add-role" id="org-submit-add-role" href="javascript:void(0)" style="float: left; margin: 5px auto 0px auto;">
			<span>确定</span>
		</a>
		<a class="button" href="#close" style="float: right; margin: 5px auto 0px auto;" onclick="$.pdialog.closeCurrent();">
			<span>取消</span>
		</a>
</div>
</c:if>
<c:if test="${!showInOrganization}">
<link type="text/css" rel="stylesheet" href="resources/z_tree/3.5/zTreeStyle.css" />
<script type="text/javascript" src="resources/z_tree/3.5/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="resources/z_tree/3.5/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="resources/js/member/member.js"></script>
</c:if>
<script type="text/javascript">
	$(function() {
		$('#org-submit-add-role').on('click',function(){
			var select = getSelectNode('organization-tree');
			var roleIds = $('#add-role-ids-form').serializeObject();
			if(Object.keys(roleIds).length < 1) {
				alertMsg.error('请选择需要添加的角色！');
				return;
			}
			Net.post('organization/allocateRoles', $.extend({orgId:select.id},roleIds), function(data) {
				$.pdialog.closeCurrent();
				loadRoleUnderOrganization();
			}, function(data) {
				alertMsg.error('添加角色失败！');
			});
		});
		
		$('#role-modify-info').on('click',function(){
			var roleId = validateOnlyOneRoleChoose();
			if(roleId.length < 1) return;
			dialog('role/modify','role-modify-dialog','角色编辑',{height : 500});
		});
		
		$('#role-perm-author').on('click',function(){
			var roleId = validateOnlyOneRoleChoose();
			if(roleId.length < 1) return;
			dialog('permission/tree?unit=role&unitId='+roleId,'role-author-dialog','角色授权',{height : 500});
		});
		
		function validateOnlyOneRoleChoose() {
			var formObject = $('#add-role-ids-form').serializeObject();
			if(Object.keys(formObject).length < 1) {
				alertMsg.error('请选择需要操作的角色!');
				return '';
			}
			if(formObject['roleIds'] instanceof Array) {
				alertMsg.error('不能同时操作两个角色!');
				return '';
			}
			return formObject.roleIds;
		}
	});
</script>