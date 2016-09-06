<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
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
<title>选择经销商</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">
<meta name="keywords" content="选择经销商" />
<meta name="description" content="选择经销商" />
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
<link rel="stylesheet" href="${resourceHost}/css/dealer-manage.css" />
<!-- personal style -->
<link rel="stylesheet" type="text/css" href="${resourceHost}/css/index.css" />
<link rel="stylesheet"	href="${resourceCustHost}/css/cust/cust-manage.css" />
<!-- ace settings handler -->
<script src="${resourceHost}/js/ace-extra.min.js"></script>
<script type="text/javascript">
	window.jQuery || document.write("<script src='${resourceHost}/js/jquery-2.0.3.min.js'>"+ "<"+"script>");
</script>
<!-- <![endif]-->
<script type="text/javascript">
	if ("ontouchend" in document)
		document.write("<script src='${resourceHost}/js/jquery.mobile.custom.min.js'>"+ "<"+"script>");
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
	<link rel="stylesheet" href="${resourceHost}/${c}?v=${e:resourceVersion()}" />
</c:forEach>
<c:forEach var="lc" items="${localCss}">
	<link rel="stylesheet" href="${egolmHost}${serverName}/resources/css/${lc}?v=${e:resourceVersion()}" />
</c:forEach>
<c:forEach var="j" items="${js}">
	<script type="text/javascript" src="${resourceHost}/${j}?v=${e:resourceVersion()}"></script>
</c:forEach>
<c:forEach var="lj" items="${localJs}">
	<script type="text/javascript" src="${egolmHost}${serverName}/resources/js/${lj}?v=${e:resourceVersion()}"></script>
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
	<div class="audit table-box border-radius"> <!-- 审核表 -->
		<form action="toAgentList" id="limitPageForm">
			<input type="hidden" name="page.index" value="${page.index}"/>
			<input type="hidden" name="page.limit" value="10"/>
			<input type="hidden" name="page.limitKey" value="sAgentNO DESC"/>
			<p class="filter-wrap">
				<label class=""> 
					<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="经销商名称/经销商编号" id="sAgentParam" name="sAgentParam" type="text" value="${sAgentParam}" />
				</label>
				<span class="pull-right">
						<a class="add-dealer add-man" href="#" onclick='$("#limitPageForm").submit()'>查询</a>
				</span>
			</p>
		</form>
			<table class="footable table even" data-page-size="10">
				<thead class="bg-color">
					<tr>
						<th></th>
						<th data-toggle="true">经销商编号</th>
						<th data-toggle="true">经销商名称</th>
						<th data-toggle="true">经销商抬头</th>
						<th data-hide="phone">联系人</th>
						<th data-hide="phone">手机</th>
						<th data-hide="phone,tablet">电话</th>
						<th data-hide="phone,tablet">传真</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${datas.DataList}" var="d">
						<tr onclick="choceAfent('${d.nAgentID}','${d.sAgentNO}','${d.sAgentName }')">
							<td>
								<label class="checked-wrap">
									<input type="checkbox" class="chk" name="${d.nAgentID}" />
									<span class="chk-bg"></span>
								</label>
							</td>
							<td>${d.sAgentNO}</td>
							<td>${d.sAgentName}</td>
							<td>${d.sAgentTitle}</td>
							<td>${d.sContact}</td>
							<td>${d.sMobile}</td>
							<td>${d.sTel}</td>
							<td>${d.sFax}</td>
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
	</div><!-- /.page-content -->
</body>
	<script type="text/javascript">
		function choceAfent(nAgentID,sAgentNO,sAgentName) {
					parent.setSalBizZoneVal(nAgentID,sAgentNO,sAgentName);
					var index = parent.layer.getFrameIndex(window.name); // 先得到当前iframe层的索引
					parent.layer.close(index); // 再执行关闭
		}
	</script>
</html>