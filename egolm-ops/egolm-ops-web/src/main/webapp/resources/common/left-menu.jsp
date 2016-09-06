<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="jstl.jsp"%>
<a class="menu-toggler" id="menu-toggler" href="#">
	<span></span>分类
</a>

<div class="sidebar" id="sidebar">

	<ul class="nav nav-list">
		<li class="">
			<a href="javascript:void(0)" class="dropdown-toggle">
				<i class="icon icon-goods"></i> <span class="menu-text"> 商品管理 </span> <b class="arrow"></b>
			</a>
			<ul class="submenu">
				<li>
					<a href="goods-import.html"> 商品导入 </a>
				</li>
				<li>
					<a href="goods-audit.html"> 商品审核 </a>
				</li>
				<li>
					<a href="goods-putaway.html"> 商品上下架 </a>
				</li>
				<li>
					<a href="add-goods.html"> 商品新增 </a>
				</li>
			</ul>
		</li>

		<li>
			<a href="javascript:void(0)" class="dropdown-toggle">
				<i class="icon icon-promotion"></i> <span class="menu-text"> 促销管理 </span> <b class="arrow icon icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li>
					<a href="activity-manage.html"> 活动管理 </a>
				</li>
				<li>
					<a href="promotion-setting.html"> 促销设置 </a>
				</li>
			</ul>
		</li>

		<li>
			<a href="javascript:void(0)" class="dropdown-toggle">
				<i class="icon icon-notice"></i> <span class="menu-text"> 公告管理 </span> <b class="arrow icon icon-angle-down"></b>
			</a>

			<ul class="submenu">
				<li>
					<a href="notice-manage.html"> 公告管理 </a>
				</li>

				<li>
					<a href="message-manage.html"> 消息管理 </a>
				</li>
			</ul>
		</li>

		<li>
			<a href="#" class="dropdown-toggle">
				<i class="icon icon-dealer"></i> <span class="menu-text"> 经销商管理 </span> <b class="arrow icon icon-angle-down"></b>
			</a>

			<ul class="submenu">
				<li>
					<a href="dealer-manage.html"> 经销商管理 </a>
				</li>

				<li>
					<a href="dealer-contract.html"> 合同管理 </a>
				</li>

				<li>
					<a href="#"> 信用管理 </a>
				</li>
			</ul>
		</li>

		<li>
			<a href="#" class="dropdown-toggle">
				<i class="icon icon-supplier"></i> <span class="menu-text"> 供应商管理 </span> <b class="arrow icon icon-angle-down"></b>
			</a>

			<ul class="submenu">
				<li>
					<a href="supplier-manage.html"> 供应商管理 </a>
				</li>

				<li>
					<a href="supplier-contract.html"> 合同管理 </a>
				</li>

				<li>
					<a href="#"> 信用管理 </a>
				</li>
			</ul>
		</li>

		<li>
			<a href="javascript:void(0)" class="dropdown-toggle">
				<i class="icon icon-salesman"></i> <span class="menu-text"> 业务员管理 </span> <b class="arrow icon icon-angle-down"></b>
			</a>

			<ul class="submenu">
				<li>
					<a href="salesman-manage.html"> 业务员管理 </a>
				</li>

				<li>
					<a href="award-setting.html"> 奖励设置 </a>
				</li>

				<li>
					<a href="award-query.html"> 奖励查询 </a>
				</li>
			</ul>
		</li>

		<li>
			<a href="javascript:void(0)" class="dropdown-toggle">
				<i class="icon icon-logistics"></i> <span class="menu-text"> 物流管理 </span> <b class="arrow icon icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li>
					<a href="driver-evaluate.html"> 司机评价 </a>
				</li>

				<li>
					<a href="driver-manage.html"> 司机管理 </a>
				</li>
			</ul>
		</li>

		<li>
			<a href="javascript:void(0)" class="dropdown-toggle">
				<i class="icon icon-user"></i> <span class="menu-text"> 用户管理 </span> <b class="arrow icon icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li>
					<a href="user-manage.html"> 用户管理 </a>
				</li>

				<li>
					<a href="psw-manage.html"> 密码管理 </a>
				</li>
				<li>
					<a href="fund-manage.html"> 资产管理 </a>
				</li>
			</ul>
		</li>

		<li>
			<a href="javascript:void(0)" class="dropdown-toggle">
				<i class="icon icon-data"></i> <span class="menu-text"> 数据管理 </span> <b class="arrow icon icon-angle-down"></b>
			</a>
			<ul class="submenu">
				<li>
					<a href="salesdata-chart.html"> 销售数据管理 </a>
				</li>

				<li>
					<a href="#"> 用户数据管理 </a>
				</li>
				<li>
					<a href="#"> 平台数据管理 </a>
				</li>
				<li>
					<a href="#"> 活动数据管理 </a>
				</li>
			</ul>
		</li>

		<li>
			<a href="#">
				<i class="icon icon-template"></i> <span class="menu-text"> 模板管理 </span>
			</a>
		</li>

		<li>
			<a href="javascript:void(0)" class="dropdown-toggle">
				<i class="icon icon-order"></i> <span class="menu-text">订单管理</span> <b class="arrow icon icon-angle-down"></b>
			</a>

			<ul class="submenu">
				<li>
					<a href="#"> 订单管理 </a>
				</li>

				<li>
					<a href="#"> 退单管理 </a>
				</li>
			</ul>
		</li>

		<li>
			<a href="javascript:void(0)" class="dropdown-toggle">
				<i class="icon icon-ad"></i> <span class="menu-text">广告管理</span> <b class="arrow icon icon-angle-down"></b>
			</a>

			<ul class="submenu">
				<li>
					<a href="ad-position-manage.html"> 广告位管理 </a>
				</li>

				<li>
					<a href="advertisement-manage.html"> 广告管理 </a>
				</li>

				<li>
					<a href="advertisement-audit.html"> 广告审核 </a>
				</li>
			</ul>
		</li>

	</ul>
	<!-- /.nav-list -->
	<div class="sidebar-collapse" id="sidebar-collapse">
		<i class="fa icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
	</div>

</div>