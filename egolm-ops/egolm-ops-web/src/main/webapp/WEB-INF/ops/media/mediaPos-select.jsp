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
<title>选择广告位</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">
<meta name="keywords" content="选择广告位" />
<meta name="description" content="选择广告位" />
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
	href="${resourceHost}/css/mediaPos-select.css" />
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
<script src="${egolmHost}${serverName}/resources/js/media/mediaPos-select.js"></script>
<script src="${egolmHost}${serverName}/resources/js/media/media-base.js"></script>

<script type="text/javascript" src="${egolmHost}${serverName}/resources/js/ajaxPage.js?v=${e:resourceVersion()}"></script>
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
</script>

</head>
<body> 
	<div class="page-content">

		<div class=" table-box">
			<div class="filter-wrap clearfix">  
					 <label class="">
						   <i class="icon-search f-95"></i>						 
					       <input 	class="filter border-radius bg-color" placeholder="广告位名称"	name="sApTitle" id="sApTitle"  id="filter" type="text" />
					</label> 
					 <input type="hidden" name="type" id="type" value="${type }"/> 
					<label class="filter-select dropdown-wrap adv-margin">
					       
					               <input type="hidden" name="sZoneCodeID" id="sZoneCodeID" value="${sAdZoneCodeID}"/> 
					
 									<a id="ap-zoneCode-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>区域</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="ap-zoneCode-memu" class="dropdown-menu" aria-labelledby="ap-zoneCode-id">
										 
									</ul>
					</label>
					
					  
					<label class="filter-select dropdown-wrap adv-margin">
					       
					               <input type="hidden" name="sApSaleTypeID" id="sApSaleTypeID" value="${sApSaleTypeID}"/> 
					
 									<a id="ap-sale-type-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>广告位类型</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="ap-sale-type-menu" class="dropdown-menu" aria-labelledby="ap-sale-type-id">
										 
									</ul>
					</label>
					
					<label class="filter-select dropdown-wrap adv-margin">
									<input type="hidden" name="sScopeTypeID" id="sScopeTypeID" value="${sScopeTypeID}"/> 
 									<a id="ScopeType-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>店铺类型</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="ScopeType-menu" class="dropdown-menu" aria-labelledby="ScopeType-id">
										  
									</ul>
					</label>
				<span class="pull-right">   
			     	<span id="query"><a class="add-message" href="#">查询</a> </span>
				</span>
			</div>
			<table class="footable table even table-hover" data-page-size="5" id="listTable">
				<thead class="bg-color">
						<tr>
 								<th data-toggle="true">广告位编号</th>
								<th data-hide="">广告位名称</th>
								<th data-hide="">广告位类型</th>
								<th data-hide="">区域</th>
								<th data-hide="">店铺类型</th> 
							</tr>
					
				</thead>
				<tbody id="select-msg-id" style="cursor:pointer;">
					
				</tbody>
				<tfoot>
					<tr>
						<td colspan="10" class="clearfix" id="select-page">
						
						</td>
					</tr>
				</tfoot>
			</table>
		</div>

	</div>
	<!-- /.page-content -->
	 
</body>
</html>
