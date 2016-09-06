<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="组织架构管理" currentTopMenu="组织架构管理"
	currentSubMenu="用户管理"
	css="z_tree/3.5/zTreeStyle.css,css/notice-manage.css,css/pagination.css,css/footable.core.css,css/add-notice.css,css/bootstrap-select.min.css"
	js="z_tree/3.5/jquery.ztree.core-3.5.min.js,z_tree/3.5/jquery.ztree.excheck-3.5.js,js/footable.js,js/checked.js,js/bootstrap-select.min.js"
	localCss="member/member.css" 
	localJs="member/member.js,member/user.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/member/user/list.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}"> 首页</a> &gt; <a
						href="javascript:void(0);"> 组织架构管理</a> &gt; <a
						href="/${serverName}/member/user/index" class="active"> 用户</a> &gt;
				</p>
			</div>
			<div class="table-sutiable" >
				<div class="tool-bar" >
					<form id="user-search-form" action="${webHost}/member/user/index" method="post">
					<p class="filter-wrap">
					<label class="">
						<!-- <i class="icon-search f-95"></i> -->
						<input class="filter border-radius bg-color" name="name" value="${query.name}" placeholder="用户名称" type="text" />
					</label>
					<label class="">
						<input class="filter border-radius bg-color" name="mobile" value="${query.mobile}" placeholder="手机号" type="text" />
					</label>
					<select id="search-user-type" name="userType" class="selectpicker" data-width="170px" title="用户类型" >
						<option value="">所有</option>
						<c:forEach var="userType" items="${userTypes}">
							<option ${query.userType == userType ? 'selected' : ''} value="${userType.value}">${userType.description}</option>
						</c:forEach>
					</select>
					<span><a id="bind-role" class="add-notice notice-button" href="javascript:void(0);"><i></i>分配角色</a></span>
					<span><a id="add-user" class="add-notice notice-button" href="javascript:void(0);"><i></i>添加用户</a></span>
					<span><a id="search-user" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>查询</span></a></span>
					<span><a id="import-agent" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>批量导入经销商</span></a></span>
					</p>
					</form>
					<!-- <button type="button" class="btn btn-info" id="user-modify">修改信息</button>
					<button type="button" class="btn btn-info" id="user-reset">重置密码</button>
					<button type="button" class="btn btn-info" id="user-message">发送消息</button>
					<button type="button" class="btn btn-info" id="user-info">详情</button>
					<button type="button" class="btn btn-info" id="user-log">查看登录历史记录</button>
					<button type="button" class="btn btn-info" id="user-excel">导出Excel</button> -->
				</div>
				<div class="table-content">
					<table data-page-size="10" class="footable table even default footable-loaded">
						<thead class="bg-color">
							<tr>
								<th class="footable-first-column"></th>
								<th>用户名称</th>
								<th>用户真名</th>
								<th>用户类型</th>
								<th>所属角色</th>
								<!-- <th>用户性别</th>
								<th>联系邮箱</th>
								<th>用户简介</th> -->
								<th>手机号码</th>
								<th>创建时间</th>
								<th>更新时间</th>
								<th>有效性</th>
							</tr>
						</thead>
					<tbody>
						<c:forEach var="user" items="${users}">
							<tr>
								<td class="footable-first-column">
								<label class="checked-wrap">
								<input type="checkbox" class="chk user-check" data-id="${user.id}">
								<span class="chk-bg"></span>
								</label>
								</td>
								<td>${user.name}</td>
								<td>${user.realName}</td>
								<td>${user.type.description}</td>
								<td>
									<c:forEach var="roleName" items="${user.roleNames}">
									${roleName}<br>
									</c:forEach>
								</td>
								<%-- <td>${user.gender.description}</td>
								<td>${user.mail}</td>
								<td>${user.description}</td> --%>
								<td>${user.mobile}</td>
								<td><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd"/></td>
								<td><fmt:formatDate value="${user.updateTime}" pattern="yyyy-MM-dd"/></td>
								<td>${user.isValid ? "激活" : "冻结"}</td>
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
										<input class="border border-radius bg-color f-50" id="batch-set-password" type="button" value="批量修改密码" />
									</label>
									</div>
									<c:set var="pagerForm" value="user-search-form" scope="request"/>
									<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
								</td>
							</tr>
						</tfoot>
					</table>
				</div>
				
				<!-- add group -->
				<!-- <div class="modal fade edit-box" id="bind-role-alert" tabindex="-1" role="dialog" aria-labelledby="bind-role-alert-label">
					<form action="#" method="post" id="create-group-form">
						<div class="modal-dialog" role="document">
							<div class="modal-content border-radius">
								<div class="modal-body">
						    		<div class="scroll-wrap">
					        			<p><label><span>角色名称过滤：</span><input name="name" type="text" value=""></label></p>
						        			<div><label><span>上级组织：</span></label>
						        			<div class="tree-body">
											<div class="menuContent ztreeMC tree-content">
												<input id="create-group-parent-id" name="parentId" type="hidden" />
												<ul id="create-group-tree" class="ztree"></ul>
											</div>
											</div>
						        			</div>
					        		</div>
					        		<p class="clearfix">
					        			<label class="pull-left"><input type="button" class="btn btn-info" id="submit-group-create" value="确定" ></label>
					        			<label class="pull-right"><input type="button" class="btn btn-info" data-dismiss="modal" value="取消"></label>
					        		</p>
						      	</div>
					    	</div>
					  	</div>
					</form>
				</div> -->
							
				<div class="modal fade edit-box" id="bind-role-alert" tabindex="-1" role="dialog" aria-labelledby="bind-role-alert-label">
					<div class="modal-dialog" role="document">
						<div class="modal-content border-radius">
							<div class="modal-body">
								<!-- <form action="javascript:void(0);"> -->
							   		<div><label><span>请选择角色：</span></label>
						        		<div class="tree-body">
											<div class="menuContent ztreeMC tree-content">
												<input id="create-role-group-id" name="groupId" type="hidden" />
												<ul id="allocate-role-tree" class="ztree"></ul>
											</div>
										</div>
						    		</div>
							       	<p class="clearfix">
							       		<label class="pull-left"><input id="submit-bind-role" type="button" value="保存"></label>
							       		<label class="pull-right"><input class="btn btn-info" type="button" data-dismiss="modal" value="取消"></label>
							       	</p>
								<!-- </form> -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</e:point>