<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="公告管理" currentTopMenu="公告管理"
	currentSubMenu="公告管理"
	css="css/notice-manage.css,css/pagination.css,css/footable.core.css,css/add-notice.css,css/mediaContent-report.css"
	js="js/footable.js,js/checked.js"
	localCss="notice/notice.css" 
	localJs="notice/notice.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp">
	<div class="main-content">
		<div class="page-content">						
			<div class="wh_titer">
				<p class="wh_titer_f">您的位置：
					<a href="/${serverName}">首页</a> &gt; 
					<a href="javascript:void(0);">公告管理</a> &gt; 
					<a class="active" href="/${serverName}/api/notice/query">公告管理</a>
				</p>
			</div>
			<div class="notice table-box border-radius"> <!-- 审核表 -->
			<form id="notice-search-form" action="${webHost}/api/notice/query" method="post" >
				<p class="filter-wrap">
					<label class="">
						<i class="icon-search f-95"></i>
						<input class="filter border-radius bg-color" name="sNoticeTitle" value="${sNoticeTitle}" placeholder="公告标题" id="filter" type="text" />
					</label>
					<span><a id="search-notice" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>查询</span></a></span>
					<span><a id="modify-notice" class="add-notice notice-button" href="javascript:void(0);"><i></i>更新公告</a></span>
					<span><a id="create-notice" class="add-notice notice-button" href="${webHost}/api/notice/toAdd"><i class="add-icon"></i>新增<span>公告</span></a></span>
				</p>
			</form>	
				<table class="footable table even" data-page-size="10">
					<thead class="bg-color">
						<tr>
							<th></th>
							<th>公告标题</th>
							<th>公告内容</th>
							<th>发布地点</th>
							<th>状态</th>
							<th>创建者</th>
							<th>发布时间</th>
							<th>下线时间</th>
							<th>创建时间</th>
							<th>最后修改时间</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${noticeList}" var="maps">
							<tr>
								<td>
									<label class="checked-wrap">
									<input type="checkbox" class="chk notice-check" data-id="${maps.sNoticeId}"/>
									<span class="chk-bg"></span>
									</label>
								</td>
								<td>${maps.sNoticeTitle}</td>
								<%-- <td class="content-tip" style="width:550px;">
									<span>${maps.sNoticeContent}</span>
									<input type="hidden" value="${maps.sNoticeContent}">
								</td> --%>
								<td  class="cpa" style="width:550px;" data-hide="phone" >
									<span>${maps.sNoticeContent}</span>
									<a>
										<i class="fa fa-question-circle-o" aria-hidden="true"></i>								
									</a>
									<div>${maps.sNoticeContent}</div>
								</td>
								<td>${maps.sOrgDesc}</td>
								<c:choose>
								<c:when test="${maps.nTag == 0}">
									<td data-id="0">新建</td>
								</c:when>
								<c:when test="${maps.nTag == 1}">
									<td data-id="1">删除</td>
								</c:when>
								<c:when test="${maps.nTag == 2}">
									<td data-id="2">发布</td>
								</c:when>
								<c:when test="${maps.nTag == 3}">
									<td data-id="3">下架</td>
								</c:when>
								<c:otherwise>
									<td>删除</td>
								</c:otherwise>
								</c:choose>
								<td>${maps.sUserName}</td>
								<td><fmt:formatDate value="${maps.dPubDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td><fmt:formatDate value="${maps.dOutDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td><fmt:formatDate value="${maps.dCreatedDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td><fmt:formatDate value="${maps.dLastModifyDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="10" class="clearfix">
								<div class="batch">
									<label>
										<input type="checkbox" class="chk check-all" />
										<span class="chk-bg"></span>
										<span class="txt">全选</span>
									</label>
									<label>
										<input id="batch-delete-notice" class="border border-radius bg-color f-50" type="button" value="批量移除" />
									</label>
									</div>
									<c:set var="pagerForm" value="notice-search-form" scope="request"/>
									<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
								</td>
							</tr>
					</tfoot>
				</table>
			</div>	
			<!-- 编辑 -->
			<div class="modal fade edit-box" id="notice-modify-alert" tabindex="-1" role="dialog" aria-labelledby="editNoticeLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content border-radius">
						<div class="modal-body">
							<form id="notice-modify-form">
								<div class="scroll-wrap">
									<input type="hidden" name="sNoticeId" id="m-notice-id"/>
							    	<p><label><span>公告名称：</span><input id="m-notice-name" name="sNoticeTitle" type="text" value=""></label></p>
							        <p>
							        	<label>
							       	 		<span>发布时间：</span>
							       	 		<input  style="width: 35%;" class="border border-radius bg-color" id="pub-date-picker" name="dPubDate" type="text" />
							       	 	</label>
							       	 </p>
							       	  <p>
							        	<label>
							       	 		<span>下架时间：</span>
							       	 		<input  style="width: 35%;" class="border border-radius bg-color" id="out-date-picker" name="dOutDate" type="text" />
							       	 	</label>
							       	 </p>
							       	<!-- <p><label><span>发布地区：</span><input type="text" value=""></label></p> -->
							       	<p>
							       		<label>
							        	<span>状态：</span>
							        	<select name="nTag" style="width: 25%;" id="m-notice-tag">
							        		<option value="0">新建</option>
							        		<option value="2">发布</option>
							        		<option value="3">下架</option>
							        	</select>
							        	</label>
							        </p>
							        <p><label><span>发布内容：</span><textarea style="width: 75%;" id="m-notice-c" name="sNoticeContent" rows="5" cols=""></textarea></label></p>
							   	</div>
							    <p class="clearfix">
							    	<label class="pull-left"><input id="submit-modify-notice" type="button" value="保存"></label>
							    	<label class="pull-right"><input type="button" data-dismiss="modal" value="取消"></label>
							    </p>
							</form>
						</div>
					</div>
				</div>
			</div>			
			<!-- 确定删除弹窗 -->
			<div class="modal fade delete-box" id="delete-alert" tabindex="-1" role="dialog" aria-labelledby="delete-alert-label">
				<div class="modal-dialog" role="document">
					<div class="modal-content border-radius">
						<div class="modal-header">
							<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
						</div>
						<div class="modal-body">
							<p class="pic"><span></span></p>
							<p class="text">是否确认删除？</p>
							<p class="btn-box clearfix">
								<input id="submit-batch-delete" class="bg-color border-radius border" type="button" id="btn-confirm" value="确定" />
								<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="取消" />
							</p>
						</div>
					</div>
				</div>
			</div>
						
			<!--保存成功-->
			<div class="modal fade success-box" id="successAlert" tabindex="-1" role="dialog" aria-labelledby="successAlertLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content border-radius">
						<div class="modal-header">
							<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
						</div>
						<div class="modal-body">
						<p class="pic"><span></span></p>
						<p class="text">保存成功</p>
						<p class="btn-box clearfix">
							<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="确定" />
						</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</e:point>