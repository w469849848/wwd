<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="组织架构管理" currentTopMenu="组织架构管理"
	currentSubMenu="组织架构管理"
	css="css/notice-manage.css,z_tree/3.5/zTreeStyle.css,css/bootstrap-select.min.css"
	js="z_tree/3.5/jquery.ztree.core-3.5.min.js,z_tree/3.5/jquery.ztree.excheck-3.5.js,js/bootstrap-select.min.js"
	localCss="member/member.css,member/group.css" localJs="member/member.js,member/permission.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}"> 首页</a> &gt; <a
						href="javascript:void(0);"> 组织架构管理</a> &gt; <a
						href="/${serverName}/member/permission/index"> 权限</a> &gt; <a
						href="/${serverName}/member/permission/create" class="active">
						增加权限</a> &gt;
				</p>
			</div>
			<div style="position: absolute; display: inline;">
				<div class="tool-bar">
					<p class="filter-wrap group-float">
					<span><a id="perm-create" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>新建</span></a></span>
					<span><a id="perm-edit" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>编辑</span></a></span>
					<span><a id="perm-delete" class="add-notice notice-button" href="javascript:void(0);"><i></i>删除</a></span>
					</p>
				</div>
				<br/>
				<div class="tool-bar">
					<div class="base-tree-body">
						<div class="menuContent ztreeMC tree-content"> 
					        <ul id="permission-tree" class="ztree permission-tree"></ul>
					    </div>
					</div>
					<div class="role-left-side">
						<form id="create-perm-form">
						<div class="scroll-wrap" >
							<p>
								<label><font color="red">*</font><span id="id-label">平台：</span>
									<input id="platform" readonly="readonly" name="platform" type="text" value="">
									<input id="id" name="id" type="hidden" value="">
								</label>
								<label><font color="red">*</font><span id="id-label">父权限名称：</span>
									<input id="parentName" readonly="readonly" name="parentName" type="text" value="">
									<input type="hidden" id="parentId" name="parentId" type="text" value="">
								</label>
							</p>
							<p>
								<label><font color="red">*</font><span id="id-label">父权限KEY：</span>
									<input id="parentKeys" readonly="readonly" name="parentKeys" type="text" value="">
								</label>
								<label><font color="red">*</font><span id="name-label">权限等级：</span>
									<input id="level" readonly="readonly" name="level" type="text" value="">
								</label>
							</p>
							<p>
								<label><font color="red">*</font><span id="name-label">权限类型：</span>
									<input id="type" name="type" readonly="readonly" type="text" value="">
								</label>
								<label><font color="red">*</font><span id="name-label">权限版本：</span>
									<input id="version" name="version" readonly="readonly" type="text" value="">
								</label>
							</p>
							<p>
								<label><font color="red">*</font><span id="name-label">权限名称：</span>
									<input id="name" name="name" type="text" value="">
								</label>
								<label><font color="red">*</font><span id="name-label">权限KEY：</span>
									<input id="keys" name="keys" type="text" value="">
								</label>
							</p>
							<p>
								<label><font color="red">*</font><span id="name-label">权限URL：</span>
									<input id="url" name="url" type="text" value="">
								</label>
								<label><font color="black">*</font><span id="name-label">权限命名空间：</span>
									<input id="namespace" name="namespace" type="text" value="">
								</label>
							</p>
							<p>
								<label><font color="black">*</font><span id="name-label">权限ICON：</span>
									<input id="icon" name="icon" type="text" value="">
								</label>
								<label><font color="black">*</font><span id="name-label">人为排序：</span>
									<input id="idx" name="idx" type="text" value="">
								</label>
							</p>
						</div>
						</form>
						<!-- <p class="clearfix">
							<label class="pull-left"><input type="button" class="btn btn-info" id="submit-group-create" value="保存" /></label>
							<label class="pull-right"><input type="button" class="btn btn-info" id="cancel-group-create" value="取消"></label>
						</p> -->
						<p class="filter-wrap group-create">
							<span><a id="submit-perm-change" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>保存</span></a></span>
							<span><a id="cancel-perm-create" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>取消</span></a></span>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</e:point>
<style>
.scroll-wrap label {
   margin: 20px auto auto 35px;
}
.scroll-wrap {
	min-height: 270px;max-height: 100%; width: 900px;
}
.group-create {
    float: left;
    margin: 20px auto auto 35%;
}

.group-float {
    clear: both;
    float: none;
    margin-left: -20px;
}

.filter-wrap .add-notice {
    float: left;
}
</style>

