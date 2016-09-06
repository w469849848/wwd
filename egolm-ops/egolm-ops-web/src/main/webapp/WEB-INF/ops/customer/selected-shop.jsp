<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="com.egolm.security.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>

<c:set scope="application" var="egolmHost" value="${e:egolmHost('')}" />
<c:set scope="application" var="mediaHost" value="${e:mediaHost('')}" />
<c:set scope="application" var="resourceHost"
	value="${e:resourceHost('')}${serverName}/resources/assets" />
<c:set scope="application" var="localHost" value="${e:localHost()}" />
<c:set scope="application" var="serverName" value="${e:serverName()}" />
<c:set scope="application" var="webHost"
	value="${egolmHost}${serverName}" />
<c:set scope="application" var="resourceHost"
	value="${e:resourceHost('')}${serverName}/resources/assets" />
<c:set scope="application" var="resourceCustHost"
	value="${e:resourceHost('')}${serverName}/resources" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>选择会员</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">
<meta name="keywords" content="选择店铺" />
<meta name="description" content="选择店铺" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- basic styles -->
<link href="${resourceHost}/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="${resourceHost}/css/font-awesome.min.css" />
<link rel="stylesheet" href="${resourceHost}/css/pagination.css" />
<!-- ace styles -->
<link rel="stylesheet" href="${resourceHost}/css/ace.min.css" />
<link rel="stylesheet" href="${resourceHost}/css/ace-rtl.min.css" />
<link rel="stylesheet" href="${resourceHost}/css/ace-skins.min.css" />
<link rel="stylesheet" href="${resourceHost}/css/footable.core.css" />


<!-- personal style -->
<link rel="stylesheet" type="text/css"
	href="${resourceHost}/css/index.css" />
<link rel="stylesheet"
	href="${resourceCustHost}/css/cust/shop-manage.css" />
<!-- ace settings handler -->
<script src="${resourceHost}/js/ace-extra.min.js"></script>
<script type="text/javascript">
	window.jQuery
			|| document
					.write("<script src='${resourceHost}/js/jquery-2.0.3.min.js'>"
							+ "<"+"script>");
</script>
<!-- <![endif]-->
<script type="text/javascript">
	if ("ontouchend" in document)
		document
				.write("<script src='${resourceHost}/js/jquery.mobile.custom.min.js'>"
						+ "<"+"script>");
</script>

<script src="${resourceHost}/js/ace-elements.min.js"></script>
<script src="${resourceHost}/js/ace.min.js"></script>
<script src="${resourceHost}/js/footable.js"></script>


<script src="${resourceHost}/js/bootstrap.min.js"></script>
<!-- ace scripts -->
<script src="${resourceHost}/js/echarts.common.min.js"></script>
<script src="${resourceHost}/layer/layer.js"></script>
<script src="${resourceHost}/js/common.js"></script>

</head>

<c:forEach var="c" items="${css}">
	<link rel="stylesheet"
		href="${resourceHost}/${c}?v=${e:resourceVersion()}" />
</c:forEach>
<c:forEach var="lc" items="${localCss}">
	<link rel="stylesheet"
		href="${egolmHost}${serverName}/resources/css/${lc}?v=${e:resourceVersion()}" />
</c:forEach>
<c:forEach var="j" items="${js}">
	<script type="text/javascript"
		src="${resourceHost}/${j}?v=${e:resourceVersion()}"></script>
</c:forEach>
<c:forEach var="lj" items="${localJs}">
	<script type="text/javascript"
		src="${egolmHost}${serverName}/resources/js/${lj}?v=${e:resourceVersion()}"></script>
</c:forEach>
<script type="text/javascript">
	var egolmHost = "${egolmHost}";
	var webHost = "${egolmHost}" + "${serverName}";
	var mediaHost = "${mediaHost}";
	var resourceHost = "${resourceHost}";
	var sessionId = "${session.id}";
	var SID = "${SID}";
	var username = "${user.name}";
	var userKey = "${user.id}";
</script>
</head>
<body>


	<div class="page-content">

		<div class="shop table-box">
						<div class="filter-wrap clearfix">
							<form id="limitPageForm" method="post">
							<input type="hidden" name="page.index" value="${page.index}" />
							<input type="hidden" name="page.limit" value="10" />
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="店铺名称" name="sShopName" value="${sShopName }" id="filter" type="text" />
								</label>
							</form>
								<span class="pull-right">
									<a class="add-message" href="javascript:$('#limitPageForm').submit();"><i class="search-icon"></i>查询</a>
								</span>
							</div>
						<table class="footable table even" data-page-size="5" id="listTable">
							<thead class="bg-color">
								<tr>
									<th></th>
									<th data-toggle="true">代码</th>
									<th data-toggle="true">名称</th>
									<th data-hide="phone,tablet">店铺类型</th>
									<th data-hide="phone,tablet">经销类型</th>
									<th data-hide="phone,tablet">所属会员</th>
									<th data-toggle="phone,tablet">联系人</th>
									<th data-hide="phone,tablet">电话</th>
									<th data-hide="phone,tablet">所在城市</th>
									<th data-hide="phone">状态</th>
									<th data-hide="phone,tablet">开店日期</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${datas}" var="d">
									<tr title="${d.nShopID}" shopNO="${d.sShopNO }" shopName="${d.sShopName }">
										<td></td>
										<td>${d.sShopNO }</td>
										<td>${d.sShopName }</td>
										<td>${d.sShopType }</td>
										<td>${d.sScopeType }</td>
										<td>${d.sCustName }</td>
										<td>${d.sContacts }</td>
										<td>${d.sTel }</td>
										<td>${d.sCity }</td>
										<td>
											<c:if test="${d.nTag == 0}">
												<span class="state"><img
													src="${pageContext.request.contextPath}/resources/egolm/assets/images/circle.png" />
												</span>未禁用
											</c:if> 
											<c:if test="${d.nTag == 1}">
												<span class="state"><img
													src="${pageContext.request.contextPath}/resources/egolm/assets/images/close.png" />
												</span>已禁用
											</c:if>
										</td>
										<td><fmt:formatDate value='${d.dFirstSaleDate }' pattern='yyyy-MM-dd'/></td>
									</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="10" class="clearfix">
										<c:set var="pagerForm" value="limitPageForm" scope="request"/>
										<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>

	</div>
	<!-- /.page-content -->
	<script type="text/javascript">
		jQuery(function($) {
			var footable = null, $row = null, isAll = false,
			// true为全选，false为未选中
			deleteType = true,
			// true为删除一行,false为批量删除
			$table = $('.table-box table'),
			// 获取表格元素
			$bgRow = null;
			clicked('listTable'); 
			$('.shop table').footable(
					{ // 响应式表格初始化
						debug : true,
						breakpoints : {
							phone : 600,
							tablet : 980
						},
						log : function(message, type) {
							$bgRow = $table.find('tbody tr').not(
									'.footable-row-detail');
							if (message = 'footable_initialized') {
								$bgRow.each(function(index) {
									if (index % 2 == 1) {
										$(this).css({
											'background' : '#fbfbfb'
										});
									}
								});
							}
							if (message == 'footable_row_expanded'
									|| message == 'footable_row_collapsed') {
								$bgRow.each(function(index) {
									if (index % 2 == 1) {
										$(this).css({
											'background' : '#fbfbfb'
										});
									}
								});
							}
						}
					});
			
		});

		function clicked(id) {
			var o, i;
			o = document.getElementById(id).rows;//表格所有行
			for (i = 0; i < o.length; i++) {
				o[i].ondblclick = function() { //设置事件
					var oo = this.cells[1]; //取得第二列对象
					var sShopNO=$(this).attr("shopNO");
					var sShopName=$(this).attr("shopName");
					parent.getShopNO(sShopNO,sShopName);
					var index = parent.layer.getFrameIndex(window.name); // 先得到当前iframe层的索引
					parent.layer.close(index); // 再执行关闭
				}
			}
		}
		
	</script>
</body>
</html>
