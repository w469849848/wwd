<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="组织架构管理" currentTopMenu="组织架构管理"
	currentSubMenu="用户管理"
	css="css/notice-manage.css,css/pagination.css,css/footable.core.css,z_tree/3.5/zTreeStyle.css,css/bootstrap-select.min.css"
	js="z_tree/3.5/jquery.ztree.core-3.5.min.js,z_tree/3.5/jquery.ztree.excheck-3.5.js,js/footable.js,js/checked.js,js/bootstrap-select.min.js"
	localCss="member/member.css" 
	localJs="member/member.js,member/role.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}"> 首页</a> &gt; <a
						href="javascript:void(0);"> 组织架构管理</a> &gt; <a
						href="/${serverName}/member/role/index" class="active">角色</a> &gt;
				</p>
			</div>
			<div  class="table-sutiable">
				<div class="tool-bar" >
					<form id="role-search-form" action="${webHost}/member/role/index" method="post">
					<p class="filter-wrap">
					<label class="">
						<!-- <i class="icon-search f-95"></i> -->
						<input class="filter border-radius bg-color" name="name" value="${query.name}" placeholder="角色名称" type="text" />
					</label>
					<label class="">
						<input class="filter border-radius bg-color" name="groupName" value="${query.groupName}" placeholder="所属组织" type="text" />
					</label>
					<select name="isValid" class="selectpicker" data-width="170px" title="角色状态" >
						<option value="">所有</option>
						<option ${query.isValid == true ? 'selected' : ''} value="true" >激活</option>
						<option ${query.isValid == false ? 'selected' : ''} value="false" >冻结</option>
					</select>
					<span><a id="role-auth" class="add-notice notice-button" href="javascript:void(0);"><i></i>角色授权</a></span>
					<span><a id="role-modify" class="add-notice notice-button" href="javascript:void(0);"><i></i>编辑角色</a></span>
					<span><a id="role-create" class="add-notice notice-button" href="javascript:void(0);"><i></i>创建角色</a></span>
					<span><a id="role-search" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>查询角色</span></a></span>
					</p>
					</form>
					<!-- 
					<button type="button" class="btn btn-info" id="role-info">角色详情</button>
					<button type="button" class="btn btn-info" id="role-excel">导出Excel</button> 
					-->
				</div>
				<div class="table-content">
					<table data-page-size="10" class="footable table even default footable-loaded">
						<thead class="bg-color">
							<tr>
								<th class="footable-first-column"></th>
								<th>角色ID</th>
								<th>角色名称</th>
								<th>所属组织</th>
								<th>状态</th>
								<th>描述</th>
								<th>创建时间</th>
								<th>更新时间</th>
								<th>操作</th>
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
								<td>${role.id}</td>
								<td>${role.name}</td>
								<td>
									<c:forEach var="groupName" items="${role.groupNames}">
									${groupName}<br>
									</c:forEach>
								</td>
								<td>${role.isValid ? "激活" : "冻结"}</td>
								<td>${role.description}</td>
								<td><fmt:formatDate value="${role.createTime}" pattern="yyyy-MM-dd"/></td>
								<td><fmt:formatDate value="${role.updateTime}" pattern="yyyy-MM-dd"/></td>
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
									<label>
										<input type="checkbox" class="chk" />
										<span class="chk-bg"></span>
										<span class="txt">全选</span>
									</label>
									<label><input id="batch-delete-role" class="border border-radius bg-color f-50" type="button" value="批量移除" /></label>
								</div>
								<c:set var="pagerForm" value="role-search-form" scope="request"/>
								<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
							</td>
						</tr>
					</tfoot>
					</table>
				</div>
				<!-- create role -->
				<div class="modal fade edit-box" id="create-role-alert" tabindex="-1" role="dialog" aria-labelledby="create-role-alert-label">
					<form action="#" method="post" id="create-role-form">
						<div class="modal-dialog" role="document">
							<div class="modal-content border-radius">
								<div class="modal-body">
						    		<div class="scroll-wrap">
						    			<p><label><span><font color="red">*</font>角色名称：</span><input id="create-role-name" name="name" type="text" value=""></label></p>
					        			<div><label><span>所属组织机构：</span></label>
						        			<div class="tree-body">
												<div class="menuContent ztreeMC tree-content">
													<input id="create-role-group-id" name="groupIds" type="hidden" />
													<ul id="create-role-tree" class="ztree"></ul>
												</div>
											</div>
						    			</div>
					        			<p><label><span>角色描述：</span></label><textarea maxlength="100" id="create-role-desc" name="description" multiline="true"></textarea></p>
					        		</div>
					        		<p class="clearfix">
					        			<label class="pull-left"><button type="button" class="btn btn-info" id="submit-role-create">添加</button></label>
					        			<label class="pull-right"><input type="button" class="btn btn-info" data-dismiss="modal" value="取消"></label>
					        		</p>
						      	</div>
					    	</div>
					  	</div>
					</form>
				</div>
			
				<!-- modify role -->
				<div class="modal fade edit-box" id="modify-role-alert" tabindex="-1" role="dialog" aria-labelledby="modify-role-alert-label">
					<form action="#" method="post" id="modify-role-form">
						<div class="modal-dialog" role="document">
							<div class="modal-content border-radius">
								<div class="modal-body">
						    		<div class="scroll-wrap">
						    			<p><label><span><font color="red">*</font>角色名称：</span><input id="modify-role-name" name="name" type="text" value=""></label></p>
					        			<div><label><span>所属组织机构：</span></label>
						        			<div class="tree-body">
												<div class="menuContent ztreeMC tree-content">
													<input type="hidden" name="id" id="modify-role-id" > 
													<input type="hidden" name="groupIds" id="modify-role-group-id" >
													<ul id="modify-role-tree" class="ztree"></ul>
												</div>
											</div>
						    			</div>
					        			<p><label><span>角色描述：</span></label><textarea maxlength="100" id="modify-role-desc" name="description" multiline="true"></textarea></p>
					        		</div>
					        		<p class="clearfix">
					        			<label class="pull-left"><input type="button" class="btn btn-info" id="submit-role-modify" value="保存"></label>
					        			<label class="pull-right"><input type="button" class="btn btn-info" data-dismiss="modal" value="取消"></label>
					        		</p>
						      	</div>
					    	</div>
					  	</div>
					</form>
				</div>
				
				<!-- permission tree -->
				<div class="modal fade edit-box" id="permission-tree-alert" tabindex="-1" role="dialog" aria-labelledby="permission-tree-alert-label">
					<div class="modal-dialog" role="document">
					   	<div class="modal-content border-radius modal-tree">
					      	<div class="modal-body">
					    		<div class="scroll-wrap">
						   			<div class="tree-body"> 
						   				<div class="menuContent ztreeMC tree-content"> 
					        				<ul id="permission-tree" class="ztree permission-tree"></ul>
					        			</div>
						   			</div>
					      		</div>
				        		<p class="clearfix">
			        			<label class="pull-left"><input type="button" class="btn btn-info" id="submit-permission-auth" value="授权"></input></label>
			        			<label class="pull-right"><input type="button" class="btn btn-info" data-dismiss="modal" value="取消"></label>
				        		</p>
					     	</div>
						</div>
					</div>
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
						
			</div>
		</div>
	</div>
</e:point>