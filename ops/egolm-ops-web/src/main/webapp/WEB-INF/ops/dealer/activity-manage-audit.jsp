<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ include file="/resources/common/jstl.jsp"%> 
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
		<link href="${opsPath}/resources/egolm/assets/css/bootstrap.min.css" rel="stylesheet" />
		<link rel="stylesheet" href="${opsPath}/resources/egolm/assets/css/font-awesome.min.css" />


		<!-- ace styles -->

		<link rel="stylesheet" href="${opsPath}/resources/egolm/assets/css/ace.min.css" />
		
		<!-- personal style -->
		<link rel="stylesheet" href="${opsPath}/resources/egolm/assets/css/activity-manage.css" />
		
		<link rel="stylesheet" href="${opsPath}/resources/egolm/assets/css/pagination.css" />
		
		<link rel="stylesheet" type="text/css" href="${opsPath}/resources/egolm/assets/css/footable.core.css"/>

		<!--[if lte IE 8]>
		  <link rel="stylesheet" href="${opsPath}/resources/egolm/assets/css/ace-ie.min.css" />
		<![endif]-->

		<!-- ace settings handler -->

		<script src="${opsPath}/resources/egolm/assets/js/ace-extra.min.js"></script>

		<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

		<!--[if lt IE 9]>
		<script src="${opsPath}/resources/egolm/assets/js/html5shiv.js"></script>
		<script src="${opsPath}/resources/egolm/assets/js/respond.min.js"></script>
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
							<img src="${opsPath}/resources/egolm/assets/images/border.png" />
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
				<a class="menu-toggler" id="menu-toggler" href="#">
					<span></span>
					分类
				</a>

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

						<li class="open active">
							<a href="javascript:void(0)" class="dropdown-toggle">
								<i class="icon icon-promotion"></i>
								<span class="menu-text"> 促销管理 </span>
								
								<b class="arrow icon icon-angle-down"></b>
							</a>
							<ul class="submenu">
								<li class="active">
									<a href="${opsPath}/tmpPromo/list">
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

						<li>
							<a href="javascript:void(0)" class="dropdown-toggle">
								<i class="icon icon-order"></i>
								<span class="menu-text">模板管理</span>

								<b class="arrow icon icon-angle-down"></b>
							</a>

							<ul class="submenu">
								<li>
									<a href="tpl-manage.html">
										模板管理
									</a>
								</li>

								<li>
									<a href="module-manage.html">
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
								<a href="javascript:void(0)">促销管理</a> &gt; 
								<a class="active" href="${opsPath}/tmpPromo/list">活动审核</a>
							</p>
						</div>
						
												
						<div class="activity table-box border-radius"> <!-- 消息管理 -->
							
							<div class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="活动名称" id="sTmpPromoTitle" name="sTmpPromoTitle" type="text" />
								</label>
								<label class="filter-select dropdown-wrap">
								<input type="hidden" id = "zoneCode" name = "zoneCode">
									<a id="area-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>地区</span>
										<span class="dr"><img src="${opsPath}/resources/egolm/assets/images/arrow-black.png"/></span>
									</a>
									<ul id="area-menu" class="dropdown-menu" aria-labelledby="area-id">
										 
									</ul>
								</label>
								 
							</div>
							
							<table class="footable table even" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th></th>
										<th data-toggle="true">活动名称</th>
										<th data-hide="phone">活动类型</th>
										<th data-hide="phone">活动档期</th>
										<th data-hide="phone">活动时间</th>
										<th data-hide="phone">活动区域</th> 
										<th data-hide="phone">状态</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
								  <c:forEach items="${activityList }" var="activity">
									<tr>
										<td>
											<label class="checked-wrap">
												<input type="checkbox" class="chk"  id="tmpPromoId" name="tmpPromoId" value = "${activity.nTmpPromoID}"/>
												<span class="chk-bg"></span>
											</label>
										</td>
										<td>${activity.sTmpPromoTitle }</td>
										<td>${activity.sTmpPromoActionType }</td>
										<td>${activity.sTmpPromoSchedule }</td>
										<td><span class="orange"><fmt:formatDate value="${activity.dTmpPromoBeginDate}" type="date"/>  </span> / <span><fmt:formatDate value="${activity.dTmpPromoEndDate}" type="date"/></span></td>
										<td>${activity.sZoneName }</td>
										<td><span class="state">
										<c:if test="${activity.nTag == 0}">
											<img src="${opsPath}/resources/egolm/assets/images/close.png"/></span>未审核</td>
										</c:if>
										<c:if test="${activity.nTag == 2}">
											 <img src="${opsPath}/resources/egolm/assets/images/circle.png"/>已审核
										</c:if>
										<c:if test="${activity.nTag == 4}">
											 <img src="${opsPath}/resources/egolm/assets/images/close.png"/>审核未通过
										</c:if>
										
										<td>
											<span class="dropdown">
												<a class="edit" href="${opsPath}/tmpPromo/loadMsgById?id=${activity.nTmpPromoID}"></a>
												<a class="delete" pid="${activity.nTmpPromoID}" href="javascript:void(0)"></a>
												<a class="detail" href="${opsPath}/tmpPromo/loadDetailMsgById?id=${activity.nTmpPromoID}">详情</a>
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
													<span class="txt" id="check-all">全选/取消</span>
												</label>
												<label  id="auditMoreid"><input class="border border-radius bg-color f-50" type="button" value="批量审核" /></label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量下线" /></label>
											</div>
											
											<div class="navigation_bar pull-right">
												<ul class="clearfix">
													<li>
														<a href="javascript:void(0)" class="nav_first"></a>
													</li>
													<li>
														<a href="javascript:void(0)" class="nav_float"></a>
													</li>
													<li class="active"><a href="javascript:void(0)">1</a></li>
													<li><a href="javascript:void(0)">2</a></li>
													<li><a href="javascript:void(0)">3</a></li>
													<li><a href="javascript:void(0)">…</a></li>
													<li><a href="javascript:void(0)">7</a></li>
													<li><a href="javascript:void(0)">8</a></li>
													<li><a href="javascript:void(0)">9</a></li>
													<li><a href="javascript:void(0)" class="nav_right"></a></li>
													<li><a href="javascript:void(0)" class="nav_last"></a></li>
												</ul>
											</div>
											
										</td>
									</tr>
								</tfoot>
							</table>
						
						</div>
						
						<!-- 编辑 -->
						<div class="modal fade edit-box" id="editActivity" tabindex="-1" role="dialog" aria-labelledby="editActivityLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
							      	<div class="modal-body">
							        	<form>
							        		<div class="scroll-wrap">
							        			<p><label><span>活动名称：</span><input type="text" value="五一满300减10块"></label></p>
								        		<p><label><span>活动类型：</span><input type="text" value="满减"></label></p>
								        		<p><label><span>活动档期：</span><input type="text" value="五一节活动"></label></p>
								        		<p><label><span>活动时间：</span><input type="text" value="2016.04.25-2016.0503"></label></p>
								        		<p><label><span>状态：</span><input type="text" value="未审核"></label></p>
							        		</div>
							        		<p class="clearfix">
							        			<label class="pull-left"><input id="submit" type="button" value="保存"></label>
							        			<label class="pull-right"><input type="button" data-dismiss="modal" value="取消"></label>
							        				
							        		</p>
							        	</form>
							      	</div>
						    	</div>
						  	</div>
						</div>
						
						<!-- 确定删除弹窗 -->
						<div class="modal fade delete-box" id="deleteAlert" tabindex="-1" role="dialog" aria-labelledby="deleteAlertLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
							      	<div class="modal-header">
							      		<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
							      	</div>
							      	<input type="hidden"  id = "delete-activity-id">
							      	<div class="modal-body">
							      		<p class="pic"><span></span></p>
							      		<p class="text">是否确认删除？</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" id="btn-confirm" value="确定" />
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="取消" />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
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
			window.jQuery || document.write("<script src='${opsPath}/resources/egolm/assets/js/jquery-2.0.3.min.js'>"+"<"+"script>");
		</script>

		<!-- <![endif]-->
		
		<!--[if IE]>
		<script type="text/javascript">
			window.jQuery || document.write("<script src='${opsPath}/resources/egolm/assets/js/jquery-1.10.2.min.js'>"+"<"+"script>");
		</script>
		<![endif]-->

		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='${opsPath}/resources/egolm/assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
		</script>
		<script src="${opsPath}/resources/egolm/assets/js/bootstrap.min.js"></script>

		<!-- ace scripts -->

		<script src="${opsPath}/resources/egolm/assets/js/ace-elements.min.js"></script>
		<script src="${opsPath}/resources/egolm/assets/js/ace.min.js"></script>
		<script src="${opsPath}/resources/egolm/assets/js/footable.js"></script>
		<script src="${opsPath}/resources/egolm/assets/js/checked.js"></script>
		
		<!--消息管理js-->
		<script src="${opsPath}/resources/egolm/assets/js/activity-manage.js"></script>
	    <script src="${opsPath}/resources/egolm/assets/js/ad-base.js"></script>
</body>
</html>

