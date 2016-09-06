<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<form id="pagerForm" method="post" action="#rel#">
	<input type="hidden" name="pageNum" value="1" /> <input type="hidden"
		name="numPerPage" value="${model.numPerPage}" /> <input type="hidden"
		name="orderField" value="${param.orderField}" /> <input type="hidden"
		name="orderDirection" value="${param.orderDirection}" />
</form>

<div class="pageHeader">
	<form rel="pagerForm" onsubmit="return navTabSearch(this);" action="permission/queryAll" method="post">
		<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					<select class="combox" name="region">
						<option value="">平台</option>
						<option value="ops">运营系统</option>
						<option value="biz">电商系统</option>
						<option value="fund">金融系统</option>
					</select>
				</td>
				<td>
					<label>组织机构名称：</label> <input type="text" name="orgName" value="" />
				</td>
				<td>
					<label>角色名称：</label> <input type="text" name="orgName" value="" />
				</td>
				<td>
					<label>权限级别：</label> <input type="text" name="userName" value="" />
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
<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a title="确实要冻结这些权限吗?" class="edit" href="permission/freeze" rel="permIds" target="selectedTodo"><span>冻结权限</span></a></li>
			<li><a title="确实要激活这些权限吗?" class="edit" href="permission/active" rel="permIds" target="selectedTodo"><span>激活权限</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" targetType="navTab" title="实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="100%" layoutH="138">
		<thead>
			<tr>
				<th width="2%"><input type="checkbox" group="permIds" class="checkboxCtrl"></th>
				<th width="8%" class="asc">权限名称</th>
				<th width="8%">权限关键字</th>
				<th width="8%">权限级别</th>
				<th width="10%">映射资源</th>
				<th width="8%">父权限名称</th>
				<th width="8%">所属平台</th>
				<th width="8%">权限类型</th>
				<th width="8%">权限描述</th>
				<th width="8%">创建时间</th>
				<th width="8%">更新时间</th>
				<th width="8%">权限状态</th>
				<th width="8%">权限版本</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="perm" items="${permissions}">
				<tr target="sid_user">
					<td><input name="permIds" value="${perm.id}" type="checkbox"></td>
					<td>${perm.name}</td>
					<td>${perm.keys}</td>
					<td>${perm.level}</td>
					<td>${perm.url}</td>
					<td>${perm.parentName}</td>
					<td>${perm.platform}</td>
					<td>${perm.type}</td>
					<td>${perm.description}</td>
					<td><fmt:formatDate value="${perm.createTime}" pattern="yyyy-MM-dd"/></td>
					<td><fmt:formatDate value="${perm.updateTime}" pattern="yyyy-MM-dd"/></td>
					<td>${perm.isValid ? "激活" : "冻结"}</td>
					<td>${perm.version}</td>
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

		<div class="pagination" targetType="navTab" totalCount="200" style="margin:auto auto 30px auto;"
			numPerPage="20" pageNumShown="10" currentPage="1"></div>

	</div>
</div>
