<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<e:resource title="首页" currentTopMenu="" currentSubMenu="" css="" js="" localCss="" localJs="" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/404.jsp">
	<div class="main-content" >
		
	</div>
	<div class="page-content">
		<div style="margin :-30% auto auto 30%;">
			<h1>404</h1>
		</div>
		<div style="margin :auto auto auto 30%;">
			<h1>对不起，您访问的页面不存在！</h1>
		</div>
		<div style="margin :auto auto auto 30%;">
			<h1>您可以：</h1><a href="${refer}">返回上一页</a>&nbsp;<a href="${webHost}${index}">返回首页</a>
		</div>
	</div>
</e:point>
