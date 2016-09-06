<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="jstl.jsp" %>
<div class="accordion" fillSpace="sidebar">
	<div class="accordionHeader">
		<h2><span>Folder</span>业务员管理</h2>
	</div>
	<div class="accordionContent">
		<ul class="tree treeFolder">
			<li>
				<li><a href="<%=request.getContextPath() %>/salesman/querySalesList" rel="" target="navTab">业务员资料管理</a></li> 
			</li>
		</ul>
	</div>
	
	<div class="accordionHeader">
		<h2><span>Folder</span>系统管理</h2>
	</div>
	<div class="accordionContent">
		<ul class="tree treeFolder">
			<li>
				<a href="javascript:void(0);">权限管理</a>
				<ul>
					<li><a href="user/index" rel="" target="navTab">用户管理</a></li>
					<li><a href="role/index" rel="" target="navTab">角色管理</a></li>
					<li><a href="organization/index" rel="" target="navTab">组织架构管理</a></li>
					<li><a href="permission/index" rel="" target="navTab">权限管理</a></li>
				</ul>
			</li>
		</ul>
	</div>
	
	<div class="accordionHeader">
		<h2><span>Folder</span>公告管理</h2>
	</div>
	<div class="accordionContent">
		<ul class="tree treeFolder">
			<li>
				<a href="javascript:void(0);">公告管理</a>
				<ul>
					<li><a href="<%=request.getContextPath() %>/api/notice/index" rel="" target="navTab">查询公告</a></li>									
				</ul>
			</li>
		</ul>
	</div>
	<div class="accordionHeader">
		<h2><span>Folder</span>广告管理</h2>
	</div>
	<div class="accordionContent">
		<ul class="tree treeFolder">
		<li>
				<a href="javascript:void(0);">广告合同管理</a>
				<ul>
					<li><a href="<%=request.getContextPath() %>/api/advContract/index" rel="" target="navTab">广告合同新增</a></li>
					<li><a href="<%=request.getContextPath() %>/api/advContract/list" rel="" target="navTab">广告合同管理</a></li>	 
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">广告位管理</a>
				<ul>
					<li><a href="<%=request.getContextPath() %>/api/adPos/index" rel="" target="navTab">广告位新增</a></li>
					<li><a href="<%=request.getContextPath() %>/api/adPos/list" rel="" target="navTab">广告位管理</a></li>	 
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">广告管理</a>
				<ul>
					<li><a href="<%=request.getContextPath() %>/api/adVert/index" rel="" target="navTab">广告新增</a></li>
					<li><a href="<%=request.getContextPath() %>/api/adVert/list?selectType=all" rel=""adPosListPage target="navTab">广告管理</a></li>
					<li><a href="<%=request.getContextPath() %>/api/adVert/list?selectType=audit" rel="" target="navTab">广告审核</a></li>										
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">广告批次</a>
				<ul>
					<li><a href="<%=request.getContextPath() %>/api/adBatch/index" rel="" target="navTab">批次新增</a></li>
					<li><a href="<%=request.getContextPath() %>/api/adBatch/list" rel=""adPosListPage target="navTab">批次管理</a></li> 						
				</ul>
			</li>
		</ul>
	</div>
	<div class="accordionHeader">
		<h2><span>Folder</span>商品基础资料管理</h2>
	</div>
	<div class="accordionContent">
		<ul class="tree treeFolder">
			<li>
				<a href="javascript:void(0);">商品基础资料管理</a>
				<ul>
					<li><a href="<%=request.getContextPath() %>/goods/product/index" rel="" target="navTab">商品资料新增</a></li>
					<li><a href="<%=request.getContextPath() %>/goods/product/list" rel="" target="navTab">商品资料管理</a></li>	 
				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">分类管理</a>
				<ul>
					<li><a href="<%=request.getContextPath() %>/goods/category/index" rel="" target="navTab">分类新增</a></li>
					<li><a href="<%=request.getContextPath() %>/goods/category/list" rel="" target="navTab">分类管理</a></li>
 				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">品牌管理</a>
				<ul>
					<li><a href="<%=request.getContextPath() %>/goods/brand/index" rel="" target="navTab">品牌新增</a></li>
					<li><a href="<%=request.getContextPath() %>/goods/brand/list" rel="" target="navTab">品牌管理</a></li>
 				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">商品色码组</a>
				<ul>
					<li><a href="<%=request.getContextPath() %>/goods/goodsColorGroup/index" rel="" target="navTab">色码组新增</a></li>
					<li><a href="<%=request.getContextPath() %>/goods/goodsColorGroup/list" rel="" target="navTab">色码组管理</a></li>
 				</ul>
			</li>
			<li>
				<a href="javascript:void(0);">商品尺码组</a>
				<ul>
					<li><a href="<%=request.getContextPath() %>/goods/goodsColorSize/index" rel="" target="navTab">尺码组新增</a></li>
					<li><a href="<%=request.getContextPath() %>/goods/goodsColorSize/list" rel="" target="navTab">尺码组管理</a></li>
 				</ul>
			</li>
		</ul>
	</div>
	
	
	<div class="accordionHeader">
		<h2><span>Folder</span>商品管理</h2>
	</div>
	<div class="accordionContent">
		<ul class="tree treeFolder">
			<li>
				<li><a href="<%=request.getContextPath() %>/goods/tGoodsDealer/importSecond" rel="" target="navTab">商品导入</a></li>
				<li><a href="#" rel="" target="navTab">商品审核</a></li>
				<li><a href="#" rel="" target="navTab">商品上下架</a></li>
				<li><a href="#" rel="" target="navTab">商品新增</a></li>	 
			</li> 
		</ul>
	</div>
	<div class="accordionHeader">
		<h2><span>Folder</span>商品资料录入管理</h2>
	</div>
	<div class="accordionContent">
		<ul class="tree treeFolder">
			<li>
				<li><a href="<%=request.getContextPath() %>/goods/tmpGoods/index" rel="" target="navTab">商品资料列表</a></li>
				<li><a href="<%=request.getContextPath() %>/goods/tmpGoods/addIndex" rel="" target="navTab">商品资料录入</a></li>
				<li><a href="#" rel="" target="navTab">条码表录入</a></li>
				<li><a href="#" rel="" target="navTab">图片录入</a></li>
				<li><a href="#" rel="" target="navTab">分类录入</a></li>	 
			</li> 
		</ul>
	</div>
</div>
