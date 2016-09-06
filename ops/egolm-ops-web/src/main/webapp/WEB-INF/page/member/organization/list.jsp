<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<h2 class="contentTitle">组织架构树</h2>

<div id="resultBox"></div>

<div>
	<div style="position:absolute; display: inline; width: 380px;">
		<div style="margin: -10px auto 0px auto; overflow: auto; overflow: auto; border: solid 1px #CCC; line-height: 21px; background: #FFF;">
			<div id='preOrgContent' class="menuContent ztreeMC" style="display: block; position: relative;">
				<ul id="organization-tree" class="ztree organization-tree"></ul>
			</div>
		</div>
		<div style="margin: 0px auto 0px 10px;">
			<a class="button" id="organization-create"><span>添加</span></a> 
			<a class="button" id="organization-modify"><span>编辑</span></a> 
			<a class="button" id="organization-delete"><span>删除</span></a> 
			<a class="button" id="organization-info"><span>详情</span></a>
			<a class="button" id="organization-author"><span>授权</span></a>
		</div>
	</div>
</div>
<div style="position:absolute; display: inline;margin: 0px auto 0px 400px;height:100%;">
	<div style="width: 100%;height: 45%;">
	<div class="pageContent">
		<div id="role-box" class="unitBox" style="display:block; overflow:auto; width:100%;"></div>
	</div>
	</div>
	<div style="width: 100%;height: 45%;">
	<div class="pageContent">
		<div id="perm-box" class="unitBox" style="display:block; overflow:auto; width:100%;"></div>
	</div>
	</div>
</div>

<link type="text/css" rel="stylesheet" href="resources/z_tree/3.5/zTreeStyle.css" />
<script type="text/javascript" src="resources/z_tree/3.5/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="resources/z_tree/3.5/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="resources/js/member/member.js"></script>
<script type="text/javascript">
	$('#organization-author').on('click',function(){
		var select = getSelectNode('organization-tree');
		if(null == select) return;
		dialog('permission/tree?unit=organization&unitId='+member.base_organization.id,'organization-author-dialog','组织机构授权',{height : 500});
	});
	$('#organization-info').on('click',function(){
		var select = getSelectNode('organization-tree');
		if(null == select) return;
		dialog('organization/info','organization-info-dialog','组织机构详情',{});
	});
	$('#organization-delete').on('click',function(){
		var select = getSelectNode('organization-tree');
		if(null == select) return;
		if(select.children && select.children.length > 0) {
			alertMsg.error('该组织有下属机构，不能直接删除！');
			return;
		}
		dialog('organization/delete','organization-delete-dialog','组织机构删除',{height : 200,width : 300});
	});
	$('#organization-modify').on('click',function(){
		var select = getSelectNode('organization-tree');
		if(null == select) return;
		dialog('organization/modify','organization-modify-dialog','组织机构编辑',{height : 500});
	});
	$('#organization-create').on('click',function(){
		var select = getSelectNode('organization-tree');
		if(null == select) return;
		dialog('organization/create','organization-create-dialog','组织机构编辑',{height : 500});
	});
	$(function() {
		var selectItem = [];
		setTimeout(function() {
			loadBaseOrganizationTree();
			loadRoleUnderOrganization();
			loadPermUnderOrganization();
			$('.buttonActive button').click();
		}, 10);
	});
</script>
