<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt"%>
<% 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<c:set var="webRoot" value="<%=basePath%>" />
<c:set var="shopPath" value="<%=path%>"/>
<c:set var="sZoneCode" value="SUZU"/>

<html>
<head>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<script type="text/javascript">
	var ctx = "<%=path%>";
	var basectx = "<%=basePath%>"; 
</script>
</head>

</html>
