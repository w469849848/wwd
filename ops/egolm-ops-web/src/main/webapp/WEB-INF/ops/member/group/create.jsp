<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="组织架构管理" currentTopMenu="组织架构管理"
	currentSubMenu="组织架构管理"
	css="css/notice-manage.css,css/pagination.css,css/footable.core.css,z_tree/3.5/zTreeStyle.css,css/bootstrap-select.min.css"
	js="z_tree/3.5/jquery.ztree.core-3.5.min.js,z_tree/3.5/jquery.ztree.excheck-3.5.js,js/bootstrap-select.min.js"
	localCss="member/member.css,member/group.css" localJs="member/member.js,member/group.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}"> 首页</a> &gt; <a
						href="javascript:void(0);"> 组织架构管理</a> &gt; <a
						href="/${serverName}/member/group/index"> 组织机构</a> &gt; <a
						href="/${serverName}/member/group/create" class="active">
						新建组织机构</a> &gt;
				</p>
			</div>
			<input type="hidden" id="forward-group-id" name="forwardGroupId" value="${groupId}" >
			<div style="position: absolute; display: inline;">
				<div class="tool-bar">
					<div class="base-tree-body">
						<div id='pre-group-content'
							class="menuContent ztreeMC tree-content">
							<ul id="create-group-tree" class="ztree group-tree"></ul>
						</div>
					</div>
					<div class="role-left-side">
						<form id="create-group-form">
						<div class="scroll-wrap" style="min-height: 100%;">
							<p>
								<label><font color="red">*</font><span id="id-label">组织编号：</span>
									<input id="group-id" name="id" type="text" value="">
									<input type="hidden" id="group-parentId" name="parentId" type="text" value="">
								</label>
							</p>
							<p>
								<label><font color="red">*</font><span id="name-label">组织名称：</span>
									<input id="group-name" name="name" type="text" value="">
								</label>
							</p>
						</div>
						<div class="select">
							<p>
							<input type="hidden" name="groupTyp" id="groupTyp" />
							<input type="hidden" name="groupTypId" id="groupTypId" />
							<input type="hidden" name="regionNO" id="regionNO" />
							<label for="province">
								<font color="red">*</font>
								<span id="province-label">省：</span>
								<select id="group-province" name="province" class="selectpicker" data-width="220px" title="省" >
									<option></option>
								</select>
							</label>
							</p>
							<p>
								<label for="city">
									<font color="red">*</font>
									<span id="city-label">市：</span>
									<select id="group-city" name="city" class="selectpicker" data-width="220px" title="市">
										<option></option>
									</select>
								</label>
							</p>
						</div>
						</form>
						<!-- <p class="clearfix">
							<label class="pull-left"><input type="button" class="btn btn-info" id="submit-group-create" value="保存" /></label>
							<label class="pull-right"><input type="button" class="btn btn-info" id="cancel-group-create" value="取消"></label>
						</p> -->
						<p class="filter-wrap group-create">
							<span><a id="cancel-group-create" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>取消</span></a></span>
							<span><a id="submit-group-create" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>保存</span></a></span>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</e:point>


