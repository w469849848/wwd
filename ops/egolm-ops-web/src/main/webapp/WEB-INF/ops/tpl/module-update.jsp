<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/resources/common/jstl.jsp"%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>万店易购运营管理平台</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta content="telephone=no" name="format-detection">
		<meta name="renderer" content="webkit">
		<meta name="keywords" content="万店易购运营管理平台" />
		<meta name="description" content="万店易购运营管理平台" />
		<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no" />
		<!-- basic styles -->
		<link href="${opsPath}/resources/assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="${opsPath}/resources/assets/css/font-awesome.min.css" />


		<!-- ace styles -->

		<link rel="stylesheet" href="${opsPath}/resources/assets/css/ace.min.css" />
		
		<!-- salesman style -->
		<link rel="stylesheet" href="${opsPath}/resources/assets/css/add-module.css" />

		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
		<![endif]-->

		<!-- ace settings handler -->

		<script src="${opsPath}/resources/assets/js/ace-extra.min.js"></script>

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lt IE 9]>
		<script src="assets/js/html5shiv.js"></script>
		<script src="assets/js/respond.min.js"></script>
		<![endif]-->
	</head>

	<body>
		<div class="navbar navbar-default" id="navbar">

			<div class="navbar-container" id="navbar-container">
				<div class="navbar-header pull-left">
					<a href="#" class="navbar-brand">
						<small>
							<i class="logo"></i>
							万店易购运营管理平台
						</small>
					</a><!-- /.brand -->
				</div><!-- /.navbar-header -->
				
				<div class="user-operate">
					<ul>
						<li>
							<a class="admin" href="javascript:void(0)"><span></span>Admin</a>
						</li>
						<li>
							<img src="${opsPath}/resources/assets/images/border.png" />
						</li>
						<li class="dropdown-wrap">
						    <a id="dropdown-btn" class="dropdown-btn dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
					          	<span>万店总部</span>
					          	<span class="dr"></span>
					        </a>
					        <ul id="dropdown-menu" class="dropdown-menu" aria-labelledby="dropdown-btn">
					          	<li>万店总部</li>
					          	<li>万店分部</li>
					        </ul>
						</li>
						<li>
							<a href="javascript:void(0)">
								消息
								<span class="badge badge-assertive">8</span>
							</a>
						</li>
						<li>
							<a href="javascript:void(0)">注销</a>
						</li>
					</ul>
				</div>
				
			</div><!-- /.container -->
		
		</div>
		

		<div class="main-container" id="main-container">

			<div class="main-container-inner">
				<a class="menu-toggler" id="menu-toggler" href="#"><span></span>分类</a>

				<div class="sidebar" id="sidebar">
					
					<ul class="nav nav-list">
						<li class="">
							<a href="javascript:void(0)" class="dropdown-toggle">
								<i class="icon icon-goods"></i>
								<span class="menu-text"> 商品管理 </span>
								<b class="arrow"></b>
							</a>
							<ul class="submenu">
								<li>
									<a href="goods-import.html">
										商品导入
									</a>
								</li>
								<li>
									<a href="goods-audit.html">
										商品审核
									</a>
								</li>
								<li>
									<a href="good-import-audit.html">
										单品引入审核
									</a>
								</li>
								<li>
									<a href="goods-putaway.html">
										商品上下架
									</a>
								</li>
								<li>
									<a href="add-goods.html">
										新品提报
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="javascript:void(0)" class="dropdown-toggle">
								<i class="icon icon-promotion"></i>
								<span class="menu-text"> 促销管理 </span>
								
								<b class="arrow icon icon-angle-down"></b>
							</a>
							<ul class="submenu">
								<li>
									<a href="activity-manage.html">
										活动管理
									</a>
								</li>
								<li>
									<a href="promotion-apply.html">
										促销申请
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="javascript:void(0)" class="dropdown-toggle">
								<i class="icon icon-notice"></i>
								<span class="menu-text"> 公告管理 </span>

								<b class="arrow icon icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="notice-manage.html">
										公告管理
									</a>
								</li>

								<li>
									<a href="message-manage.html">
										消息管理
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="#" class="dropdown-toggle">
								<i class="icon icon-dealer"></i>
								<span class="menu-text"> 经销商管理 </span>

								<b class="arrow icon icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="dealer-manage.html">
										经销商管理
									</a>
								</li>
								
								<li>
									<a href="dealer-contract.html">
										合同管理
									</a>
								</li>

								<li>
									<a href="#">
										信用管理
									</a>
								</li>
							</ul>
						</li>
						
						<li>
							<a href="#" class="dropdown-toggle">
								<i class="icon icon-supplier"></i>
								<span class="menu-text"> 供应商管理 </span>

								<b class="arrow icon icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="supplier-manage.html">
										供应商管理
									</a>
								</li>
								
								<li>
									<a href="supplier-contract.html">
										合同管理
									</a>
								</li>

								<li>
									<a href="#">
										信用管理
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="javascript:void(0)" class="dropdown-toggle">
								<i class="icon icon-salesman"></i>
								<span class="menu-text"> 业务员管理 </span>

								<b class="arrow icon icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="salesman-manage.html">
										业务员管理
									</a>
								</li>

								<li>
									<a href="award-setting.html">
										奖励设置
									</a>
								</li>

								<li>
									<a href="award-query.html">
										奖励查询
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="javascript:void(0)" class="dropdown-toggle">
								<i class="icon icon-logistics"></i>
								<span class="menu-text"> 物流管理 </span>
								<b class="arrow icon icon-angle-down"></b>
							</a>
							<ul class="submenu">
								<li>
									<a href="driver-evaluate.html">
										司机评价
									</a>
								</li>

								<li>
									<a href="driver-manage.html">
										司机管理
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="javascript:void(0)" class="dropdown-toggle">
								<i class="icon icon-user"></i>
								<span class="menu-text"> 用户管理 </span>
								<b class="arrow icon icon-angle-down"></b>
							</a>
							<ul class="submenu">
								<li>
									<a href="user-manage.html">
										用户管理
									</a>
								</li>

								<li>
									<a href="psw-manage.html">
										密码管理
									</a>
								</li>
								<li>
									<a href="fund-manage.html">
										资产管理
									</a>
								</li>
								<li>
									<a href="integral-exchange.html">
										积分管理
									</a>
								</li>
								<li>
									<a href="#">
										增值服务
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="javascript:void(0)" class="dropdown-toggle">
								<i class="icon icon-data"></i>
								<span class="menu-text"> 数据管理 </span>
								<b class="arrow icon icon-angle-down"></b>
							</a>
							<ul class="submenu">
								<li>
									<a href="salesdata-chart.html">
										销售数据管理
									</a>
								</li>

								<li>
									<a href="#">
										用户数据管理
									</a>
								</li>
								<li>
									<a href="#">
										平台数据管理
									</a>
								</li>
								<li>
									<a href="#">
										活动数据管理
									</a>
								</li>
							</ul>
						</li>

						<li class="open active">
							<a href="javascript:void(0)" class="dropdown-toggle">
								<i class="icon icon-order"></i>
								<span class="menu-text">模板管理</span>

								<b class="arrow icon icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="tpl-manage">
										模板管理
									</a>
								</li>

								<li class="active">
									<a href="module-manage">
										模块管理
									</a>
								</li>
							</ul>
						</li>

						<li>
							<a href="javascript:void(0)" class="dropdown-toggle">
								<i class="icon icon-order"></i>
								<span class="menu-text">订单管理</span>

								<b class="arrow icon icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="#">
										订单管理
									</a>
								</li>

								<li>
									<a href="#">
										退单管理
									</a>
								</li>
							</ul>
						</li>
						
						<li>
							<a href="javascript:void(0)" class="dropdown-toggle">
								<i class="icon icon-ad"></i>
								<span class="menu-text">广告管理</span>

								<b class="arrow icon icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="ad-position-manage.html">
										广告位管理
									</a>
								</li>

								<li>
									<a href="advertisement-manage.html">
										广告管理
									</a>
								</li>
								
								<li>
									<a href="advertisement-audit.html">
										广告审核
									</a>
								</li>
							</ul>
						</li>
						
					</ul><!-- /.nav-list -->

					<div class="sidebar-collapse" id="sidebar-collapse">
						<i class="fa icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
					</div>

				</div>

				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="index.html">首页</a> &gt; 
								<a href="javascript:void(0)">模块管理</a> &gt; 
								<a class="active" href="module-update">修改模块</a>
							</p>
						</div>
						
						<div class="module"> <!-- 模块管理 -->
							<form>
								
								<p class="row">
									<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
										<span class="col-xs-4 col-sm-2">模块名称：</span>
										<label class="col-xs-7 col-sm-9 dropdown-wrap">
											<input class="border border-radius bg-color" type="text" />
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
										<span class="col-xs-4 col-sm-2">是否属于楼层：</span>
										<label class="col-xs-7 col-sm-9 dropdown-wrap">
											<span class="dropdown-wrap">
												<label class="checked-wrap">
													<input type="checkbox" class="chk">
														<span class="chk-bg"></span>
												</label>
												楼层
											</span>
											<span class="dropdown-wrap">
												<label class="checked-wrap">
													<input type="checkbox" class="chk">
														<span class="chk-bg"></span>
												</label>
												非楼层
											</span>
											<span>（用于在页面展示时，是否加入到楼层导航索引中）</span>
										</label>
									</small>
								</p>
								<div class="row">
									<div class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">模块类别：</span>
											<div class="col-xs-7 dropdown-wrap">
												<a id="area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>首页轮播</span>
										          	<span class="dr"><img src="${opsPath}/resources/assets/images/arrow-black.png"/></span>
										        </a>
										        <ul id="area-menu" class="dropdown-menu" aria-labelledby="area-btn">
										          	<li>首页轮播</li>
										          	<li>首页轮播</li>
										          	<li>首页轮播</li>
										        </ul>										 
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="pic-wrap col-xs-10 col-sm-10 col-md-7 col-lg-6">
										<span class="tips-txt col-xs-4 col-sm-2">缩略图：</span>
										<label class="pic-box bg-color border border-radius">
											<img src="${opsPath}/resources/assets/images/upload-add.png">
											<input type="file">												
										</label>
									</div>
								</div>
								
								<div class="path-wrap">
									
									<p class="row path">
										<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
											<label class="col-xs-11 col-sm-11 tit"></label>
										</small>
									</p>
									
									<p class="row path">
										<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
											<label class="col-xs-11 col-sm-11">
												<input class="border border-radius bg-color" value="PC端界面模板路径" type="text" />
											</label>
										</small>
									</p>
									
									<p class="row path">
										<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
											<label class="col-xs-11 col-sm-11">
												<input class="border border-radius bg-color" value="微信端界面模板路径" type="text" />
											</label>
										</small>
									</p>
									
									<p class="row path">
										<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
											<label class="col-xs-11 col-sm-11">
												<input class="border border-radius bg-color" value="后台管理界面路径" type="text" />
											</label>
										</small>
									</p>
									
									<p class="row path">
										<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
											<label class="col-xs-11 col-sm-11">
												<textarea class="border border-radius bg-color" rows="6">备注</textarea>
											</label>
										</small>
									</p>
									
								</div>
								
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2"></span>
										<label class="col-xs-7 col-sm-9">
											<input id="submit" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="保存" />
											<input class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="取消" />
										</label>
									</small>
								</p>
							</form>
						</div>
						
						<!--保存成功-->
						<div class="modal fade success-box" id="successAlert" tabindex="-1" role="dialog" aria-labelledby="successAlertLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
							      	<div class="modal-header">
							      		<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
							      	</div>
							      	<div class="modal-body">
							      		<p class="pic"><span></span></p>
							      		<p class="text">保存成功</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="确定" />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->

		<!-- basic scripts -->
		
		<!--[if !IE]> -->

		<script type="text/javascript">
			window.jQuery || document.write("<script src='${opsPath}/resources/assets/js/jquery-2.0.3.min.js'>"+"<"+"script>");
		</script>

		<!-- <![endif]-->
		
		<!--[if IE]>
		<script type="text/javascript">
			window.jQuery || document.write("<script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"script>");
		</script>
		<![endif]-->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='${opsPath}/resources/assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
		</script>
		<script src="${opsPath}/resources/assets/js/bootstrap.min.js"></script>

		<!-- ace scripts -->

		<script src="${opsPath}/resources/assets/js/ace-elements.min.js"></script>
		<script src="${opsPath}/resources/assets/js/ace.min.js"></script>
		<script src="${opsPath}/resources/assets/js/checked.js"></script>
		
		<!--广告管理-->
		<script src="${opsPath}/resources/assets/js/add-module.js"></script>
</body>
</html>