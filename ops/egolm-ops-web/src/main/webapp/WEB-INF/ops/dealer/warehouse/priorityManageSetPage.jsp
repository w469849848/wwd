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
<meta name="keywords" content="选择会员" />
<meta name="description" content="选择会员" />
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
<link rel="stylesheet"
	href="${resourceHost}/css/priorityManageSetPage.css" />

<!-- personal style -->
<link rel="stylesheet" type="text/css"
	href="${resourceHost}/css/index.css" />
<link rel="stylesheet"
	href="${resourceCustHost}/css/cust/cust-manage.css" />

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
<script src="${resourceHost}/js/checked.js"></script>


<script src="${resourceHost}/js/bootstrap.min.js"></script>
<!-- ace scripts -->
<script src="${resourceHost}/js/echarts.common.min.js"></script>
<script src="${resourceHost}/layer/layer.js"></script>
<script src="${resourceHost}/js/common.js"></script>
<script src="${resourceCustHost}/js/tpl/Sortable.min.js"></script>

<script
	src="${egolmHost}${serverName}/resources/js/dealer/warehouse/priorityManageSetPage.js"></script>
<script type="text/javascript"
	src="${egolmHost}${serverName}/resources/js/ajaxPage.js?v=${e:resourceVersion()}"></script>
<jsp:include page="/WEB-INF/common/module.jsp"></jsp:include>
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

	jQuery(function($) {
		sort();
	});

	function sort() {
		window.x = new Sortable(sortItems, {
			group : "words",
			store : {
				get : function(sortable) {
					var order = localStorage.getItem(sortable.options.group);
					return [];
				},
				set : function(sortable) {
					var order = sortable.toArray();
					localStorage.setItem(sortable.options.group, order
							.join('|'));
				}
			}
		});
	}
</script>

</head>
<body>
	<div class="page-content">
		<input type="hidden" name="districtIDs" id="districtIDs"
			value="${districtIDs }" /> <input type="hidden" name="moduleItems"
			id="moduleItems" value="" />
		<div class="module-wrap">
			<div class="row tit">
				<span class="orange" id="moduleTips">备注：拖动模块可以调整模块显示顺序</span>
			</div>

			<p class="row path">
				<small class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> <label
					class="col-xs-11 col-sm-11 line"></label>
				</small>
			</p>
			<div class="row">
				<ul class="sortItems">
					<li val="hzwh1" draggable="false">
						<p class="row module">
							<small class="col-xs-10 col-sm-10 col-md-12 col-lg-12"> <label
								class="col-xs-4 col-sm-4"><input
									class="border border-radius bg-color" disabled="disabled"
									value="仓库编号"> </label>
									 <label
								class="col-xs-4 col-sm-4"><input
									class="border border-radius bg-color" disabled="disabled"
									value="仓库名称"> </label>
									 <label
								class="col-xs-4 col-sm-4"><input
									class="border border-radius bg-color" disabled="disabled"
									value="仓库类型"> </label>
							</small>
						</p>
					</li>
				</ul>
				<ul class="sortItems" id="sortItems">

				</ul>
			</div>
			<div class="foot-submit">
				<label><input class="border border-radius bg-color f-50"
					type="button" value="确定" onClick="save();" /></label>
			</div>
		</div>
	</div>
	<!-- /.page-content -->

</body>
</html>
