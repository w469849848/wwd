<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="notice table-box border-radius">
	<div style="margin: 10px 10px 10px 10px;">
		<form id="group-role-query">
			<p class="filter-wrap filter-role-group">
				<label class="role-group">
					<input class="filter border-radius bg-color" id="group-role-name" name="name" placeholder="角色名称" type="text" />
				</label>
				<span><a id="group-role-filter" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>过滤</span></a></span>
			</p>
		</form>
	</div>
	<table data-page-size="10" class="footable table even default footable-loaded">
		<thead class="bg-color">
			<tr>
				<th class="footable-first-column"></th>
				<th data-toggle="true">角色名称</th>
				<th data-hide="">绑定用户数</th>
				<th data-hide="">状态</th>
				<th data-hide="">创建时间</th>
				<th class="footable-last-column">管理</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="role" items="${roles}">
				<tr>
					<td class="footable-first-column">
						<label class="checked-wrap">
						<input type="checkbox" class="chk role-check" data-id="${role.id}" data-name="${role.name}" data-group="<c:forEach var="groupId" items="${role.groupIds}">${groupId},</c:forEach>" data-desc="${role.description}">
						<span class="chk-bg"></span>
						</label>
					</td>
					<td>${role.name}</td>
					<td>${role.bindUserCount}</td>
					<td>${role.isValid ? "激活" : "冻结"}</td>
					<td><fmt:formatDate value="${role.createTime}" pattern="yyyy-MM-dd" /></td>
					<td class="footable-last-column">
					<span class="dropdown">
					<!-- <a href="javascript:void(0)" class="edit"></a> --> 
					<a href="javascript:void(0)" class="delete"></a>
					</span>
					</td>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="10" class="clearfix">
					<div class="batch">
						<label><input type="checkbox" class="chk" /><span class="chk-bg"></span><span class="txt">全选</span></label> 
						<label> <input id="batch-delete-role" class="border border-radius bg-color f-50" type="button" value="批量移除" /></label>
					</div>
					<c:set scope="page" var="index"     value="${page.index == 0 ? 1 : page.index}" />
					<c:set scope="page" var="pageTotal" value="${page.pageTotal == 0 ? 1 : page.pageTotal}" />
					<c:set scope="page" var="limit"     value="${page.limit == 0 ? 1 : page.limit}" />
					<c:set scope="page" var="start"     value="${index < 7 ? 1 : ((pageTotal-6) < index? (pageTotal -6):(index- 3))}" />
					<c:set scope="page" var="end"       value="${start + 6 > pageTotal ? pageTotal : (start + 6)}" />		
					<div class="navigation_bar pull-right">
						<ul class="clearfix">
							<li><a href="javascript:Member.pager('group-role-query','1',${limit})" class="nav_first ${index == 1 ? 'page-disable' : ''}"></a></li>
							<li><a href="javascript:Member.pager('group-role-query',${index - 1 > 0 ? index - 1 : 1},${limit})" class="nav_float ${index == 1 ? 'page-disable' : ''}"></a></li>
							<c:if test="${pageTotal > 7 && (start+3) > (pageTotal/2)}">
							<li><a href="javascript:void(0)">…</a></li>
							</c:if>
							<c:forEach begin="${start}" end="${end}" var="idx">
							<c:choose>
							<c:when test="${idx == index}">
							<li class="active"><a href="javascript:void(0)">${idx}</a></li>
							</c:when>
							<c:otherwise>
							<li><a href="javascript:Member.pager('group-role-query',${idx},${limit})">${idx}</a></li>
							</c:otherwise>
							</c:choose>
							</c:forEach>
							<c:if test="${pageTotal > 7 && (start+3) <= (pageTotal/2)}">
							<li><a href="javascript:void(0)">…</a></li>
							</c:if>
							<li><a href="javascript:Member.pager('group-role-query',${index + 1 > pageTotal ? pageTotal : index + 1},${limit})" class="nav_right ${index == pageTotal ? 'page-disable' : ''}"></a></li>
							<li><a href="javascript:Member.pager('group-role-query',${pageTotal},${limit})" class="nav_last ${index == pageTotal ? 'page-disable' : ''}"></a></li>
						</ul>
					</div>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
