<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<form id="pagerForm" method="post" action="#rel#">
	<input type="hidden" name="pageNum" value="1" /> <input type="hidden"
		name="numPerPage" value="${model.numPerPage}" /> <input type="hidden"
		name="orderField" value="${param.orderField}" /> <input type="hidden"
		name="orderDirection" value="${param.orderDirection}" />
</form>

<div class="pageHeader">
	<form rel="pagerForm" onsubmit="return navTabSearch(this);" action="user/index" method="post">
		<div class="searchBar">
		<table class="searchContent">
			<tr>
				<td>
					<select class="combox" name="region">
						<option value="">所属大区</option>
						<option value="北京">华东</option>
						<option value="上海">华南</option>
						<option value="天津">华北</option>
						<option value="重庆">东北</option>
						<option value="广东">西南</option>
					</select>
				</td>
				<td>
					<label>组织机构名称：</label> <input type="text" name="orgName" value="" />
				</td>
				<td>
					<label>角色名称：</label> <input type="text" name="orgName" value="" />
				</td>
				<td>
					<label>用户名称：</label> <input type="text" name="userName" value="" />
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
			<li><a class="edit" href="demo_page4.html" target="navTab"><span>修改信息</span></a></li>
			<li><a title="确实要删除这些记录吗?" target="selectedTodo" rel="ids"
				href="demo/common/ajaxDone.html" class="edit"><span>重置密码</span></a></li>
			<li><a title="确实要删除这些记录吗?" target="selectedTodo" rel="ids"
				postType="string" href="demo/common/ajaxDone.html" class="delete"><span>发送邮件</span></a></li>
			<li><a class="edit" href="demo_page4.html?uid={sid_user}"
				target="navTab" warn="请选择一个用户"><span>查看历史记录</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="demo/common/dwz-team.xls"
				target="dwzExport" targetType="navTab" title="实要导出这些记录吗?"><span>导出EXCEL</span></a></li>
		</ul>
	</div>
	<table class="table" width="1200" layoutH="138">
		<thead>
			<tr>
				<th width="22"><input type="checkbox" group="ids"
					class="checkboxCtrl"></th>
				<th width="120" orderField="userId" class="asc">用户编号</th>
				<th width="120" orderField="userName">用户名称</th>
				<th width="80" orderField="userType">用户类型</th>
				<th width="130" orderField="mobile">手机号码</th>
				<th width="60" align="center" orderField="accountLevel">信用等级</th>
				<th width="70">所属地区</th>
				<th width="70">所属角色</th>
				<th width="70">操作</th>
			</tr>
		</thead>
		<tbody>
			<tr target="sid_user" rel="1">
				<td><input name="ids" value="xxx" type="checkbox"></td>
				<td>A120113196309052434</td>
				<td>coyzeng</td>
				<td>厂商</td>
				<td>17717089660</td>
				<td>5级</td>
				<td>华东</td>
				<td>苹果厂商</td>
				<td><a title="删除" target="ajaxTodo"
					href="demo/common/ajaxDone.html?id=xxx" class="btnDel">删除</a> <a
					title="编辑" target="navTab" href="demo_page4.html?id=xxx"
					class="btnEdit">编辑</a></td>
			</tr>			
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
			numPerPage="20" pageNumShown="10" currentPage="1"></div>

	</div>
</div>
