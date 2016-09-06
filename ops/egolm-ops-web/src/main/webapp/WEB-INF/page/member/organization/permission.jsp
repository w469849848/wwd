<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="pageContent">
	<div id="jbsxBox3" class="unitBox"
		style="float: left; display: block; overflow: auto; width: 100%;">
		<h2 class="contentTitle">权限列表</h2>
		<div class="panelBar">
		<ul class="toolBar">
			<li>
				<a href="javascript:void(0)" class="add" id="org-modify-perm">
					<span>编辑权限</span>
				</a>
			</li>
			<li class="line">line</li>
		</ul>
	</div>
	</div>
	<table class="table" width="100%">
		<thead>
			<tr>
				<th width="100">权限名称</th>
				<th width="100">权限key</th>
				<th width="100">权限url</th>
				<th width="100">有效性</th>
				<th width="100">所属平台</th>
				<th width="200">描述</th>
				<th width="100">版本号</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="perm" items="${perms}">
				<%-- <c:if test="${role.name == '' || role.name == roleName}"> --%>
					<tr target="sid_user">
						<td>${perm.name}</td>
						<td>${perm.keys}</td>
						<td>${perm.url}</td>
						<td>${perm.isValid ? "激活" : "冻结"}</td>
						<td>${perm.platform}</td>
						<td>${perm.description}</td>
						<td>${perm.version}</td>
					</tr>
				<%-- </c:if> --%>
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
<script type="text/javascript">
	$(function(){
		$('#org-modify-perm').on('click',function(){
			var select = getSelectNode('organization-tree');
			if(null == select) return;
			dialog('permission/tree?unit=organization&unitId='+member.base_organization.id,'organization-author-dialog','组织机构授权',{height : 500});
		});
	});
</script>