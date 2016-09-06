<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="售后服务" currentTopMenu="售后服务"
	currentSubMenu="意见建议"
	css="css/notice-manage.css,css/pagination.css,css/footable.core.css,css/add-notice.css,css/mediaContent-report.css"
	js="js/footable.js,js/checked.js"
	localCss="postsale/postsale.css" 
	localJs="postsale/postsale.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/postsale/advice-reply.jsp" >
	<div class="main-content">
		<div class="page-content">						
			<div class="wh_titer">
				<p class="wh_titer_f">您的位置：
					<a href="/${serverName}">首页</a> &gt; 
					<a href="javascript:void(0);">售后服务</a> &gt; 
					<a href="/${serverName}/postsale/advice/index">意见建议</a>&gt; 
					<a class="active" href="#">回复意见建议</a>
				</p>
			</div>
			<div class="advice-all">
				<c:forEach var="advice" items="${advices}">
					
				</c:forEach>
				<form id="notice-modify-form">
					<div class="reply-body">
						<textarea rows="10" cols=""></textarea>
					</div>
					<p class="clearfix">
						<label class="pull-left"><input id="submit-modify-notice"
							type="button" value="保存"></label> <label class="pull-right"><input
							type="button" data-dismiss="modal" value="取消"></label>
					</p>
				</form>
			</div>
		</div>
	</div>
</e:point>