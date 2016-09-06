<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="数据管理"  
            currentTopMenu="IDC统计报表"
	        currentSubMenu="报表打印" 
	        js="js/jquery.dataTables.min.js"
	        localJs="report/print.js"
	        css="css/jquery.dataTables.min.css" 
	        localCss="report/print.css"
	        showHeader="false"
	        showTopMenu="false" 
	        showFooter="false" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" >
	<form id="print-form" action="javascript:void(0)">
		<c:forEach var="map" items="${params}">
			<input type="hidden" name="${map.key}" value="${map.value}"/>
		</c:forEach>
	</form>
	<div id="report">
	
	</div>
</e:point>
<script type="text/javascript" >
$(function() {
	$('#report').eq(0).renderTable($('#print-form'));
	window.print();
});
</script>