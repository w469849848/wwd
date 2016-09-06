<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<form id="pagerForm" method="post" action="${pageContext.request.contextPath}/api/notice/index">
	<input type="hidden" name="page.index" value="1" />
	<input type="hidden" name="page.limit" value="${page.limit}" />
	<input type="hidden" name="page.limitKey" value="notice_id" />
	<input type="hidden" name="notice_title" value="${notice_title}" />

</form>

<div class="pageHeader" style="margin-buttom: 1px;">
	<form rel="pagerForm" id="report_detail_in" onsubmit="return navTabSearch(this);" action="${pageContext.request.contextPath}/api/notice/index" method="post">
		<input type="hidden" name="page.limit" value="${page.limit}" />
		<input type="hidden" name="page.index" value="${page.index}" />
		<input type="hidden" name="page.limitKey" value="notice_id" />
		<div class="searchBar">
			<table class="searchContent">
				<tr>
					<td><label style="width: 80px;">公告标题：</label> <input type="text" style="width: 100px;" name="notice_title" value="${notice_title}" /></td>
				</tr>
		</table>
			<div class="subBar">
				<ul>
					<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li>
				</ul>
		</div>
		</div>
	</form>
</div>

<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
			<li><a class="add" href="<%=request.getContextPath()%>/api/notice/toAdd" target="navTab"><span>添加</span></a></li>
			<!-- <li><a class="delete" href="#?notice_id={noticeId}" target="ajaxTodo" title="确定要删除吗?"><span>删除</span></a></li> -->
			<li><a class="edit" href="<%=request.getContextPath()%>/api/notice/toUpdate?notice_id={noticeid}" target="navTab"><span>修改</span></a></li>
			<li class="line">line</li>
		</ul>
</div>
	<table class="table" width="100%" layoutH="136">
		<thead>
			<tr>

				<th width="100">公告标题</th>
				<th width="100">公告内容</th>
				<th width="100">创建时间</th>
				<th width="100">创建者ID</th>
				<th width="100">发布时间</th>
				<th width="100">下线时间</th>
				<th width="100">作用地域</th>
				<th width="100">最后修改时间</th>
			</tr>
		</thead>
		<tbody class="notice_list">
			<c:forEach items="${noticeList}" var="maps">
				<tr target="noticeid" rel="${maps.notice_id}">
					<td>${maps.notice_title}</td>
					<td>${maps.notice_content}</td>
					<td>${maps.created_date}</td>
					<td>${maps.account_id}</td>
					<td>${maps.pub_date}</td>
					<td>${maps.out_date}</td>
					<td>${maps.area}</td>
					<td>${maps.lastModify_date}</td>
				</tr>
			</c:forEach>
		</tbody>
</table> <%@ include file="/resources/common/limit-navtab.jsp"%>