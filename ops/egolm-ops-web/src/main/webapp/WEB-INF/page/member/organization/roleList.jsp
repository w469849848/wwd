<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="pageContent">
	<div id="jbsxBox3" class="unitBox"
		style="float: left; display: block; overflow: auto; width: 100%;">
		<div class="pageHeader" style="border: 1px #B8D0D6 solid">
			<form id="pagerForm" onsubmit="return divSearch(this, 'jbsxBox3');"
				action="organization/queryRolesUnderOrg" method="post">
				<input type="hidden" name="pageNum" value="1" /> 
				<input type="hidden" name="numPerPage" value="10" /> 
				<input type="hidden" name="orderField" value="null" /> 
				<input type="hidden" name="orderDirection" value="null" />
				<input type="hidden" id="org-id-for-role-query" name="organizationId" value="" />
				<div class="searchBar">
					<table class="searchContent">
						<tr>
							<td>角色名称：
								<input type="text" name="roleName" />
							</td>
							<td>
								<div class="buttonActive">
									<div class="buttonContent">
										<button type="submit">检索</button>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
		<div class="panelBar">
		<ul class="toolBar">
			<li><a title="确实要添加这些角色吗?" target="selectedTodo" rel="ids" href="organization/allocateRoles?organizationId=${organizationId}"
				class="add"><span>添加角色</span></a></li>
			<li><a title="确实要移除这些角色吗?" target="selectedTodo" rel="ids" href="organization/removeRoles?organizationId=${organizationId}"
				class="delete"><span>移除角色</span></a></li>
			<li><a style="padding: auto auto 0px auto;" target="dialog" rel="ids" mask="true" title="组织架构授权" href="permission/tree?unitId=${organizationId}&unit=organization" class="edit" width="450" height="550"><span>授权</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" targetType="navTab" title="实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	</div>
	<table class="table" width="100%">
		<thead>
			<tr>
				<th width="22"><input type="checkbox" group="ids"
					class="checkboxCtrl"></th>
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
				<%-- <c:if test="${role.name == '' || role.name == roleName}"> --%>
					<tr target="sid_user">
						<td><input name="ids" value="${role.id}" type="checkbox"></td>
						<td>${role.id}</td>
						<td>${role.name}</td>
						<td>${role.organizationName}</td>
						<td>${role.isValid ? "激活" : "冻结"}</td>
						<td>${role.description}</td>
						<td><fmt:formatDate value="${role.createTime}" pattern="yyyy-MM-dd" /></td>
						<td><fmt:formatDate value="${role.updateTime}" pattern="yyyy-MM-dd" /></td>
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