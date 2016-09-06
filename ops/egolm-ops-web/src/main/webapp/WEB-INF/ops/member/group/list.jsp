<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="组织架构管理" currentTopMenu="组织架构管理"
	currentSubMenu="组织架构管理"
	css="css/notice-manage.css,css/pagination.css,css/footable.core.css,z_tree/3.5/zTreeStyle.css"
	js="z_tree/3.5/jquery.ztree.core-3.5.min.js,z_tree/3.5/jquery.ztree.excheck-3.5.js,js/footable.js"
	localCss="member/member.css" localJs="member/member.js,member/group.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/member/group/list.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">您的位置： 
				<a href="/${serverName}"> 首页</a> &gt;
				<a href="javascript:void(0);"> 组织架构管理</a> &gt; 
				<a href="/${serverName}/member/group/index" class="active"> 组织机构</a> &gt;
				</p>
			</div>
			<div style="position: absolute; display: inline;">
				<div class="tool-bar">
					<p class="filter-wrap group-float">
					<span><a id="group-auth" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>授权</span></a></span>
					<span><a id="group-info" class="add-notice notice-button" href="javascript:void(0);"><i></i>详情</a></span>
					<span><a id="group-delete" class="add-notice notice-button" href="javascript:void(0);"><i></i>删除</a></span>
					<span><a id="group-modify" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>编辑</span></a></span>
					<span><a id="group-create" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>新建</span></a></span>
					</p>
				</div>
				<div class="tool-bar">
					<div class="base-tree-body">
						<div id='pre-group-content'
							class="menuContent ztreeMC tree-content">
							<ul id="group-tree" class="ztree group-tree"></ul>
						</div>
					</div>
					<div class="role-left-side" id="group-role">
						
					</div>
					<!-- 确定删除弹窗 -->
					<div class="modal fade delete-box" id="delete-alert" tabindex="-1" role="dialog" aria-labelledby="delete-alert-label">
						<div class="modal-dialog" role="document">
							<div class="modal-content border-radius">
								<div class="modal-header">
									<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
								</div>
								<div class="modal-body">
									<p class="pic"><span></span></p>
									<p class="text">是否确认删除？</p>
									<p class="btn-box clearfix">
										<input class="bg-color border-radius border" type="button" id="submit-delete" value="确定" /> 
										<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="取消" />
									</p>
								</div>
							</div>
						</div>
					</div>

					<!-- modify group -->
					<div class="modal fade edit-box" id="modify-group-alert" tabindex="-1" role="dialog" aria-labelledby="modify-group-alert-label">
						<form action="#" method="post" id="modify-group-form">
							<div class="modal-dialog" role="document">
								<div class="modal-content border-radius">
									<div class="modal-body">
										<div class="scroll-wrap">
											<p id="modify-group-i">
												<label><span><font color="red">*</font>组织编号：</span>
												<input id="modify-group-id" name="id" type="text" value=""  >
												</label>
											</p>
											<p id="modify-group-n">
												<label><span><font color="red">*</font>组织名称：</span>
												<input id="modify-group-name" name="name" type="text" value="">
												</label>
											</p>
											<div class="hidden">
												<label><span>上级组织：</span></label>
												<div class="tree-body">
													<div class="menuContent ztreeMC tree-content">
														<input id="modify-group-parent-id" name="parentId" type="hidden" />
														<ul id="modify-group-tree" class="ztree"></ul>
													</div>
												</div>
											</div>
										</div>
										<p class="clearfix">
											<label class="pull-left"><input type="button" class="btn btn-info" id="submit-group-modify" value="保存" ></label> 
											<label class="pull-right"><input type="button" class="btn btn-info" data-dismiss="modal" value="取消"></label>
										</p>
									</div>
								</div>
							</div>
						</form>
					</div>

					<!-- info group -->
					<div class="modal fade delete-box" id="info-group-alert" tabindex="-1" role="dialog" aria-labelledby="info-group-alert-label">
						<div class="modal-dialog" role="document">
							<div class="modal-content border-radius">
								<div class="modal-body">
									<div class="scroll-wrap">
										<p>
											<label><span>组织名称：</span><span class="info-val" id="info-name"></span></label>
										</p>
										<p>
											<label><span>上级组织：</span><span class="info-val" id="info-prev"></span></label>
										</p>
										<p>
											<label><span>所在层级：</span><span class="info-val" id="info-level"></span></label>
										</p>
										<p>
											<label><span>下属组织数：</span><span class="info-val" id="info-subs"></span></label>
										</p>
										<p>
											<!-- <label><span>组织描述：</span><span class="info-val" id="info-desc"></span></label> -->
										</p>
									</div>
									<p class="clearfix btn-center">
										<label class="btn-center"><input type="button" class="btn btn-info" data-dismiss="modal" value="关闭"></label>
									</p>
								</div>
							</div>
						</div>
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
										<label class="pull-left"><input type="button" class="btn btn-info" id="submit-permission-auth" value="授权" /></label>
										<label class="pull-right"><input type="button" class="btn btn-info" data-dismiss="modal" value="取消"></label>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</e:point>


