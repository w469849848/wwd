<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/common/jstl.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>万店易购运营管理平台</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">
<meta name="keywords" content="万店易购运营管理平台" />
<meta name="description" content="万店易购运营管理平台" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/font-awesome.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/ace.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/ace-rtl.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/ace-skins.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/supplier-manage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/pagination.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/footable.core.css" />
<!--[if lte IE 8]>
		  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/ace-ie.min.css" />
<![endif]-->
<script src="${pageContext.request.contextPath}/resources/assets/js/ace-extra.min.js"></script>
<!--[if lt IE 9]>
		<script src="${pageContext.request.contextPath}/resources/assets/js/html5shiv.js"></script>
		<script src="${pageContext.request.contextPath}/resources/assets/js/respond.min.js"></script>
<![endif]-->
</head>
<body>
	<%@ include file="/resources/common/header.jsp"%>
	<div class="main-container" id="main-container">

		<div class="main-container-inner">
			<%@ include file="/resources/common/left-menu.jsp"%>

			<div class="main-content">

				<div class="page-content">

					<div class="wh_titer">
						<p class="wh_titer_f">
							<a href="index.html">首页</a>
							&gt;
							<a href="supplier-manage.html">供应商管理</a>
							&gt;
							<a class="active" href="supplier-manage.html">供应商管理</a>
						</p>
					</div>

					<div class="supplier table-box">
						<!-- 经销商表 -->
						<form action="pageLimitExample" id="limitPageForm">
							<input type="hidden" name="page.index" value="${page.index}" /> <input type="hidden" name="page.limit" value="10" /> <input type="hidden" name="page.limitKey" value="nGoodsID" />
							<p class="filter-wrap row">
								<label class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
									<i class="icon-search f-95"></i>搜索<input class="filter border-radius bg-color" placeholder="经销商名字" id="filter" type="text" />
								</label>
								<label class="col-lg-4 col-md-4 col-sm-4 col-xs-4">
									<select class="filter-status border bg-color border-radius">
										<option value="经销商/合作商">经销商/合作商</option>
										<option value="11">11</option>
										<option value="22">22</option>
									</select>
									<span class="dr"><img src="${pageContext.request.contextPath}/resources/assets/images/arrow-black.png" /></span>
								</label>
								<span class="col-lg-2 col-md-2 col-sm-2 col-xs-2 pull-right"> <a class="add-supplier" href="add-supplier.html">
										<i class="fa fa-plus" aria-hidden="true"></i>新增经销商
									</a>
								</span>
							</p>
						</form>
						<table class="footable table" data-page-size="10">
							<thead>
								<tr>
									<th></th>
									<th data-toggle="true">经销商名称</th>
									<th data-hide="phone">联系人</th>
									<th data-hide="phone">联系方式</th>
									<th data-hide="phone,tablet">地区</th>
									<th>管理</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${datas}" var="d">
									<tr>
										<td><label class="checked-wrap">
												<input type="checkbox" class="chk" /> <span class="chk-bg"></span>
											</label></td>
										<td>${d.sProductNO}</td>
										<td>${d.sProductName}</td>
										<td>${d.nPrice}</td>
										<td>${d._id}</td>
										<td><a class="edit" href="javascript:void(0)">
												<img src="${pageContext.request.contextPath}/resources/assets/images/edit.png" alt="编辑" />
											</a> <a class="delete" href="javascript:void(0)">
												<img src="${pageContext.request.contextPath}/resources/assets/images/delete.png" alt="删除" />
											</a></td>
									</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="10" class="clearfix">
										<div class="batch">
											<label>
												<input type="checkbox" class="chk" /> <span class="chk-bg"></span> <span class="txt">全选/取消</span>
											</label>
											<label>
												<input class="border border-radius bg-color f-50" type="button" value="批量删除" />
											</label>
											<label>
												<input class="border border-radius bg-color f-50" type="button" value="批量导出" />
											</label>

											<label>
												<input id="JAlert1" class="border border-radius bg-color f-50" type="button" value="弹出提示1" />
											</label>
											<label>
												<input id="JAlert2" class="border border-radius bg-color f-50" type="button" value="弹出提示2" />
											</label>
											<label>
												<input id="JConfirm1" class="border border-radius bg-color f-50" type="button" value="确认提示1" />
											</label>
											<label>
												<input id="JConfirm2" class="border border-radius bg-color f-50" type="button" value="确认提示2" />
											</label>
											<label>
												<input id="JWindow1" class="border border-radius bg-color f-50" type="button" value="弹出窗口1" />
											</label>
											<label>
												<input id="JWindow2" class="border border-radius bg-color f-50" type="button" value="弹出窗口2" />
											</label>
										</div>
										<div class="navigation_bar pull-right">
											<ul class="clearfix">
												<li>
													<a href="javascript:$.limitTo(1);" class="nav_first"></a>
												</li>
												<li>
													<a href="javascript:$.limitTo(${page.index - 1});" class="nav_float"></a>
												</li>
												<c:forEach items="${page.pageIndexs}" var="idx">
													<li class="active">
														<a href="javascript:$.limitTo(${idx});">${idx}</a>
													</li>
												</c:forEach>
												<li>
													<a href="javascript:$.limitTo(${page.index + 1});" class="nav_right"></a>
												</li>
												<li>
													<a href="javascript:$.limitTo(${page.pageTotal});" class="nav_last"></a>
												</li>
											</ul>
										</div>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
				<!-- /.page-content -->
			</div>
			<!-- /.main-content -->
		</div>
		<!-- /.main-container-inner -->
	</div>
	<!-- /.main-container -->


	<!--[if !IE]> -->
	<script type="text/javascript">
		window.jQuery || document.write("<script src='${pageContext.request.contextPath}/resources/assets/js/jquery-2.0.3.min.js'>" + "<"+"script>");
	</script>
	<!-- <![endif]-->

	<!--[if IE]>
		
		<script type="text/javascript">
			window.jQuery || document.write("<script src='${pageContext.request.contextPath}/resources/assets/js/jquery-1.10.2.min.js'>"+"<"+"script>");
		</script>
		
		<![endif]-->

	<script type="text/javascript">
		if ("ontouchend" in document)
			document.write("<script src='${pageContext.request.contextPath}/resources/assets/js/jquery.mobile.custom.min.js'>" + "<"+"script>");
	</script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/jquery.ui.touch-punch.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/ace-elements.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/ace.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/footable.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/footable.paginate.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/footable.filter.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/edit-table.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/checked.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			$("#JAlert1").jalert({
				title : "友情提示",
				message : "测试提示消息"
			});
			
			$("#JAlert2").click(function() {
				$.jalert({
					title : "友情提示",
					message : "测试提示消息",
					confirmButton : "关闭",
					confirm : function() {
						alert("执行一些操作");
					}
				});
			});

			$("#JConfirm1").jconfirm({
				title : "友情提示",
				message : "确定要删除客户信息吗？",
				confirm : function() {
					alert("执行确认操作");
				}
			});
			$("#JConfirm2").click(function() {
				$.jconfirm({
					title : "友情提示",
					message : "确定要删除客户信息吗？",
					confirmButton : "确认按钮",
					cancelButton : "取消按钮",
					confirm : function() {
						alert("执行确认操作");
					},
					cancel : function() {
						alert("执行确认取消");
					}
				});
			});

			$("#JWindow1").jwindow({
				html : "<input type='text'/>",
				confirm : function() {
					alert("执行提交表单操作");
					$.closeJWindow();
				},
				cancel : function() {
					alert("执行关闭弹窗操作");
				}
			});
			
			$("#JWindow2").click(function() {
				$.jwindow({
					url : "ajax.html",
					showButton : false,
					confirm : function() {
						alert("执行提交表单操作");
					},
					cancel : function() {
						alert("执行关闭弹窗操作");
					}
				});
			});
		});

		jQuery(function($) {
			var footable = null, $row = null, isAll = false, deleteType = true;

			$('.chk').on('click', function() { //选中/取消选中
				Checked.checked(this);
			});

			$('.batch .chk').on('click', function() { //全选/取消全选
				$('.checked-wrap input').each(function(index) {
					Checked.selectAll(this, isAll);
				});
				isAll = !isAll;
			});
		});
	</script>
</body>
</html>