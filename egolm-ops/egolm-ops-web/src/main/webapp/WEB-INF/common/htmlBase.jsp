<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="com.egolm.security.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"        prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"         prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security"  prefix="e"%>

<c:set scope="application" var="egolmHost"     value="${e:egolmHost('')}" />
<c:set scope="application" var="mediaHost"     value="${e:mediaHost('')}" />
<c:set scope="application" var="resourceHost"  value="${e:resourceHost('')}${serverName}/resources/assets" />
<c:set scope="application" var="localHost"     value="${e:localHost()}" />
<c:set scope="application" var="serverName"    value="${e:serverName()}" />
<c:set scope="application" var="webHost"       value="${egolmHost}${serverName}" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>万店易购运营管理平台</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer"              content="webkit">
<meta name="keywords"              content="万店易购运营管理平台" />
<meta name="description"           content="万店易购运营管理平台" />
<meta name="viewport"              content="width=device-width, initial-scale=1.0" />
<!-- basic styles -->
<link href="${resourceHost}/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="${resourceHost}/css/font-awesome.min.css" />
<link rel="stylesheet" href="${resourceHost}/css/pagination.css" /> 
<!-- ace styles -->
 <link rel="stylesheet" href="${resourceHost}/css/ace.min.css" />
<link rel="stylesheet" href="${resourceHost}/css/ace-rtl.min.css" />
<link rel="stylesheet" href="${resourceHost}/css/ace-skins.min.css" />
<link rel="stylesheet" href="${resourceHost}/css/footable.core.css" />

	<!--日期控件css-->
<link rel="stylesheet" href="${resourceHost}/css/jquery.datetimepicker.css" />

<!-- personal style -->
<link rel="stylesheet" type="text/css" href="${resourceHost}/css/index.css" />
<link rel="stylesheet" href="${resourceHost}/css/tpl/reset.css" />
<link rel="stylesheet" href="${resourceHost}/css/tpl/common.css" />
<!--[if lte IE 8]>
<link rel="stylesheet" href="${resourceHost}/css/ace-ie.min.css" />
<![endif]-->
<!-- ace settings handler -->
<script src="${resourceHost}/js/ace-extra.min.js"></script>
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="${resourceHost}/js/html5shiv.js"></script>
<script src="${resourceHost}/js/respond.min.js"></script>
<![endif]-->
<!--[if !IE]> -->
<script type="text/javascript">
			window.jQuery || document.write("<script src='${resourceHost}/js/jquery-2.0.3.min.js'>"+"<"+"script>");
		</script>
<!-- <![endif]-->
<script type="text/javascript">
	if ("ontouchend" in document)
		document.write("<script src='${resourceHost}/js/jquery.mobile.custom.min.js'>" + "<"+"script>");
</script>

<script src="${resourceHost}/js/ace-elements.min.js"></script>
<script src="${resourceHost}/js/ace.min.js"></script>
<script src="${resourceHost}/js/footable.js"></script>
<%-- 影 响分页 <script src="${resourceHost}/js/footable.paginate.js"></script> --%>
 
 <script src="${resourceHost}/js/checked.js"></script>
		<!--日期控件js-->
<script src="${resourceHost}/js/jquery.datetimepicker.full.min.js"></script>

<!--表单验证提醒控件js-->
<script src="${resourceHost}/js/jquery.tips.js"></script>

<script src="${resourceHost}/js/bootstrap.min.js"></script> 
<!-- ace scripts -->
 
<script src="${resourceHost}/layer/layer.js"></script>

<%-- <script type="text/javascript" src="${egolmHost}${serverName}/resources/js/jQuery.print.js"></script> --%>
<!-- 百度api的key -->
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=8lOeGVzjGlbnMZi6DoACc9YjF80aBTPX"></script>



</head>

<script type="text/javascript" src="${egolmHost}${serverName}/resources/js/ajaxPage.js?v=${e:resourceVersion()}"></script>

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
	var egolmHost    =    "${egolmHost}";
	var webHost      =    "${egolmHost}" + "${serverName}";
	var mediaHost    =    "${mediaHost}";
	var resourceHost =    "${resourceHost}";
	var sessionId    =    "${session.id}";
	var SID          =    "${SID}";
	var username     =    "${user.name}";
	var userKey      =    "${user.id}";
</script>
<script type="text/javascript" src="${egolmHost}${serverName}/resources/js/jquery.form.js"></script>
</head>
<body>
	<c:if test="${showHeader}">
	<jsp:include page="/WEB-INF/common/header.jsp"></jsp:include>
	</c:if>
	<div class="main-container" id="main-container">
		<div class="main-container-inner">
			<a class="menu-toggler" id="menu-toggler" href="#"><span></span>分类</a>
			<c:if test="${showTopMenu}">
			<jsp:include page="/WEB-INF/common/menu.jsp"></jsp:include>
			</c:if>
			<e:include id="content"></e:include>
		</div>
	</div>
	<c:if test="${showFooter}">
	<jsp:include page="/WEB-INF/common/footer.jsp"></jsp:include>
	</c:if>
	<jsp:include page="/WEB-INF/common/module.jsp"></jsp:include>
</body>
</html>

