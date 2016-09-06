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


<script src="${resourceHost}/js/bootstrap.min.js"></script>
<!-- ace scripts -->
<script src="${resourceHost}/js/echarts.common.min.js"></script>
<script src="${resourceHost}/layer/layer.js"></script>
<script src="${resourceHost}/js/common.js"></script>
<script src="${egolmHost}${serverName}/resources/js/media/media-select.js"></script>
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
				 	<input type="hidden" name="sAdJumpTypeId" id="sAdJumpTypeId"  value= "${sAdJumpTypeId }" /> 
				 	<input type="hidden" name="nAgentID" id="nAgentID"  value= "${nAgentID }" /> 
				 	<input type="hidden" name="sOrgNO" id="sOrgNO"  value= "${sOrgNO }" /> 
						<label class="">
						<i class="icon-search f-95"></i>
						<c:if test="${sAdJumpTypeId == 'brand' }">
						   <input 	class="filter border-radius bg-color" placeholder="品牌编号/名称"	name="sAgentBrandSelect" id="sAgentBrandSelect"  id="filter" type="text" />
						</c:if>
						<c:if test="${sAdJumpTypeId == 'goods' }">
						   <input 	class="filter border-radius bg-color" placeholder="商品编号/名称/条码"	name="sAgentGoodsSelect" id="sAgentGoodsSelect"  id="filter" type="text" />
						</c:if>
					</label> 
				<span class="pull-right">   
			     	<span id="query"><a class="add-message" href="#">查询</a> </span>
				</span>
			</div>
			<table class="footable table even table-hover"  data-page-size="5" id="listTable">
				<thead class="bg-color">
						<c:if test="${sAdJumpTypeId =='brand' }">
							<tr>
								<th></th>
								<th data-toggle="true">品牌编号</th>
								<th data-hide="">品牌名称</th> 
							</tr>
						
						</c:if>
						
						<c:if test="${sAdJumpTypeId =='goods' }">
							<tr>
								<th></th>
								<th data-toggle="true">商品编号</th>
								<th data-hide="">商品名称</th>
								<th data-hide="">商品条码</th> 
							</tr>
						
						</c:if>
					
				</thead>
				<tbody id="select_msg_id" style="cursor:pointer;">
					
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
