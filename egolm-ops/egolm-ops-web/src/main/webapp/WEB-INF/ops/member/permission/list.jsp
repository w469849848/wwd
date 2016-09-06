<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="组织架构管理" currentTopMenu="组织架构管理"
	currentSubMenu="用户管理"
	css="css/notice-manage.css,css/pagination.css,css/footable.core.css,css/bootstrap-select.min.css"
	js="js/checked.js,js/bootstrap-select.min.js"
	localCss="member/member.css" 
	localJs="member/member.js,member/permission.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}"> 首页</a> &gt; <a
						href="javascript:void(0);"> 组织架构管理</a> &gt; <a
						href="/${serverName}/member/permission/index" class="active">权限</a> &gt;
				</p>
			</div>
			<div class="table-sutiable">
				<div class="tool-bar" >
					<form id="perm-search-form" action="${webHost}/member/permission/index" method="post">
					<p class="filter-wrap">
					<select name="platform" class="selectpicker" data-width="130px" title="平台" >
						<option value="">所有</option>
						<c:forEach var="platform" items="${platforms}">
							<option ${query.platform == platform ? 'selected' : ''} value="${platform.value}">${platform.description}</option>
						</c:forEach>
					</select>
					<select name="permType" class="selectpicker" data-width="130px" title="权限类型" >
						<option value="">所有</option>
						<c:forEach var="permType" items="${permTypes}">
							<option ${query.permType == permType ? 'selected' : ''} value="${permType.value}">${permType.description}</option>
						</c:forEach>
					</select>
					<select name="level" class="selectpicker" data-width="130px" title="级别" >
						<option value="">所有</option>
						<c:forEach var="index" begin="1" end="3">
							<option ${query.level == index ? 'selected' : ''} value="${index}">${index}</option>
						</c:forEach>
					</select>
					<select name="isValid" class="selectpicker" data-width="130px" title="状态" >
						<option value="">所有</option>
						<option ${query.isValid == true ? 'selected' : ''} value="true" >激活</option>
						<option ${query.isValid == false ? 'selected' : ''} value="false" >冻结</option>
					</select>
					<select name="version" class="selectpicker" data-width="130px" title="版本" >
						<option value="">所有</option>
						<c:forEach var="version" items="${versions}">
							<option value="${version}">${version}</option>
						</c:forEach>
					</select>
					<label class="">
						<input class="filter border-radius bg-color" name="name" value="${query.name}" placeholder="权限名称" type="text" />
					</label>
					<span><a id="perm-devops" class="perm-func notice-button" href="javascript:void(0);"><i></i>维护权限</a></span>
					<span><a id="perm-active" class="perm-func notice-button" href="javascript:void(0);"><i></i>激活权限</a></span>
					<span><a id="perm-freeze" class="perm-func notice-button" href="javascript:void(0);"><i></i>冻结权限</a></span>
					<span><a id="perm-search" class="perm-func notice-button" href="javascript:void(0);"><i></i><span>查询权限</span></a></span>
					</p>
					</form>
					<!-- <button type="button" class="btn btn-info" id="perm-info">查看详情</button>
					<button type="button" class="btn btn-info" id="perm-version">版本管理</button>
					<button type="button" class="btn btn-info" id="perm-excel">导出Excel</button> -->
				</div>
				<div class="table-content">
					<table data-page-size="10" class="footable table even default footable-loaded">
						<thead class="bg-color">
							<tr>
								<th class="footable-first-column"></th>
								<th>权限名称</th>
								<th>权限关键字</th>
								<th>权限级别</th>
								<th>权限URL</th>
								<th>父权限名称</th>
								<th>所属平台</th>
								<th>权限类型</th>
								<th>权限描述</th>
								<!-- <th>创建时间</th> -->
								<th>更新时间</th>
								<th>权限状态</th>
								<th>权限版本</th>
								<th>操作</th>
							</tr>
						</thead>
					<tbody>
						<c:forEach var="perm" items="${permissions}">
							<tr>
								<td class="footable-first-column">
								<label class="checked-wrap">
								<input type="checkbox" class="chk perm-check" data-valid="${perm.isValid}" data-id="${perm.id}">
								<span class="chk-bg"></span>
								</label>
								</td>
								<td>${perm.name}</td>
								<td>${perm.keys}</td>
								<td>${perm.level}</td>
								<td>${perm.url}</td>
								<td>${perm.parentName}</td>
								<td>${perm.platform.description}</td>
								<td>${perm.type.description}</td>
								<td>${perm.description}</td>
								<%-- <td><fmt:formatDate value="${perm.createTime}" pattern="yyyy-MM-dd"/></td> --%>
								<td><fmt:formatDate value="${perm.updateTime}" pattern="yyyy-MM-dd"/></td>
								<td>${perm.isValid ? "激活" : "冻结"}</td>
								<td>${perm.version}</td>
								<td>
									<a class="perm-edit" href="javascript:void(0)"><img src="${resourceHost}/images/edit.png" alt="编辑" /></a> 
									<%-- <a class="perm-delete" href="javascript:void(0)"><img src="${resourceHost}/images/delete.png" alt="删除" /></a> --%>
								</td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="12" class="clearfix">
								<div class="batch">
									<label>
										<input type="checkbox" class="chk" />
										<span class="chk-bg"></span>
										<span class="txt">全选</span>
									</label>
									<label>
										<!-- <input class="border border-radius bg-color f-50" type="button" value="批量移除" /> -->
									</label>
								</div>
								<c:set var="pagerForm" value="perm-search-form" scope="request"/>
								<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
							</td>
						</tr>
					</tfoot>
					</table>
				</div>
				
				<!-- 确定删除弹窗 -->
				<div class="modal fade delete-box" id="delete-alert" tabindex="-1" role="dialog" aria-labelledby="delete-alert-label">
					<div class="modal-dialog" role="document">
						<div class="modal-content border-radius">
							<div class="modal-header">
								<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
							</div>
							<div class="modal-body">
								<p class="pic">
									<span></span>
								</p>
								<p class="text">是否确认删除？</p>
								<p class="btn-box clearfix">
									<input class="bg-color border-radius border" type="button" id="submit-delete" value="确定" /> 
									<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="取消" />
								</p>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 确定冻结弹窗 -->
				<div class="modal fade delete-box" id="freeze-alert" tabindex="-1" role="dialog" aria-labelledby="freeze-alert-label">
					<div class="modal-dialog" role="document">
						<div class="modal-content border-radius">
							<div class="modal-header">
								<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
							</div>
							<div class="modal-body">
								<p class="pic">
									<span></span>
								</p>
								<p class="text">是否确认冻结？</p>
								<p class="btn-box clearfix">
									<input class="bg-color border-radius border" type="button" id="submit-perm-freeze" value="确定" /> 
									<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="取消" />
								</p>
							</div>
						</div>
					</div>
				</div>
				
				<!-- 确定冻结弹窗 -->
				<div class="modal fade delete-box" id="active-alert" tabindex="-1" role="dialog" aria-labelledby="active-alert-label">
					<div class="modal-dialog" role="document">
						<div class="modal-content border-radius">
							<div class="modal-header">
								<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
							</div>
							<div class="modal-body">
								<p class="pic">
									<span></span>
								</p>
								<p class="text">是否确认激活？</p>
								<p class="btn-box clearfix">
									<input class="bg-color border-radius border" type="button" id="submit-perm-active" value="确定" /> 
									<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="取消" />
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</e:point>