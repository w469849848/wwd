<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="售后服务" currentTopMenu="售后服务"
	currentSubMenu="意见建议"
	css="css/notice-manage.css,css/add-notice.css,css/mediaContent-report.css,css/bootstrap-select.min.css"
	js="js/checked.js,js/bootstrap-select.min.js"
	localCss="postsale/postsale.css" 
	localJs="postsale/postsale.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/postsale/advice-list.jsp" >
	<div class="main-content">
		<div class="page-content">						
			<div class="wh_titer">
				<p class="wh_titer_f">您的位置：
					<a href="/${serverName}">首页</a> &gt; 
					<a href="javascript:void(0);">售后服务</a> &gt; 
					<a class="active" href="/${serverName}/postsale/advice/index">意见建议</a>
				</p>
			</div>
			<div class="notice table-box border-radius"> <!-- 审核表 -->
			<form id="advice-search-form" action="${webHost}/postsale/advice/index" method="post" >
				<p class="filter-wrap">
					<label class="">
						<i class="icon-search f-95"></i>
						<input class="filter border-radius bg-color" name="search" value="${query.search}" placeholder="建议内容/建议者" id="filter" type="text" />
					</label>
					<select name="isReply" class="selectpicker" data-width="130px" title="回复状态" >
						<option value="" ${query.isReply==null ? 'selected' : ''}>所有</option>
						<option value="true" ${(query.isReply!=null && query.isReply) ? 'selected' : ''}>已回复</option>
						<option value="false" ${(query.isReply!=null && !query.isReply) ? 'selected' : ''}>未回复</option>
					</select>
					<span><a id="search-advice" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>查询</span></a></span>
				</p>
			</form>	
				<table class="footable table even" data-page-size="10">
					<thead class="bg-color">
						<tr>
							<th>建议编号</th>
							<th>店铺号</th>
							<th>建议内容</th>
							<th>处理状态</th>
							<!-- <th>建议日期</th> -->
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${advices}" var="advice">
							<tr data-id="${advice.nAdviseID}" >
								<td>${advice.nAdviseID}</td>
								<td>${advice.sCreateUser}</td>
								<td style="min-width:550px;max-width: 800px;">
									<div class="advice-head">
										<span><fmt:formatDate value="${advice.dCreateDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
										<span>${advice.sCustName}</span>
										<span>${advice.sCity}</span> <span>${empty advice.sMobile ? advice.sTel : advice.sMobile}</span>
									</div>
									<div class="advice-body">
										<span style="font-weight:900;font-size:15px;">内容：</span><span style="color:#8e8e8e;">${advice.sContent}</span>
									</div>
									<c:choose>
										<c:when test="${advice.nTag == 0}">
										<div><a class="reply-advice" data-id="${advice.nAdviseID}" href="javascript:void(0);">回复</a></div>
										</c:when>
										<c:otherwise>
										<c:forEach var="reply" items="${advice.replies}">
											<div class="reply-head">
												<span><fmt:formatDate value="${reply.replyDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
											</div>
											<div class="reply-body">
												<span style="font-weight:900;font-size:15px;">回复：</span><span style="color:#070707;">${reply.replyContent}</span>
											</div>
										</c:forEach>
										</c:otherwise>
									</c:choose>
									<%-- <span>${advice.sContent}</span>
									<a>
										<i class="fa fa-question-circle-o" aria-hidden="true"></i>								
									</a>
									<div>${advice.sContent}</div> --%>
								</td>
								<c:choose>
								<c:when test="${advice.nTag == 0}">
									<td data-id="0"><span><img src="${resourceHost}/images/close.png"/></span>未处理
								</c:when>
								<c:otherwise>
									<td data-id="1"><span><img src="${resourceHost}/images/circle.png"/></span>已处理
								</c:otherwise>
								</c:choose>
								<%-- <td><fmt:formatDate value="${advice.dCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td> --%>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="10" class="clearfix">
								<!-- <div class="batch">
									<label>
										<input type="checkbox" class="chk check-all" />
										<span class="chk-bg"></span>
										<span class="txt">全选</span>
									</label>
									<label>
										<input id="batch-delete-notice" class="border border-radius bg-color f-50" type="button" value="批量移除" />
									</label>
									</div> -->
									<c:set var="pagerForm" value="advice-search-form" scope="request"/>
									<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
								</td>
							</tr>
					</tfoot>
				</table>
			</div>	
		</div>
	</div>
</e:point>