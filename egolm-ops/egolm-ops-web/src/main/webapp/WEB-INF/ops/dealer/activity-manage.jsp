<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="活动管理"  currentTopMenu="促销管理" currentSubMenu="活动管理" css="css/activity-manage.css" js="js/common.js" localCss="" localJs="dealer/activity-manage.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/dealer/activity-manage.jsp">
 
				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="#">促销管理</a> &gt; 
								<a class="active" href="${webHost}/tmpPromo/list">活动管理</a>
							</p>
						</div>
						
												
						<div class="activity table-box border-radius"> <!-- 消息管理 -->
							
							<form action="${webHost }/tmpPromo/list" id="limitPageForm"  method= "post">
								 	<input type="hidden" name="page.index" value="${page.index}" />  
 							
							<div class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="活动名称" id="sTmpPromoTitle" name="sTmpPromoTitle" type="text" />
								</label>
								<label class="filter-select dropdown-wrap">
								<input type="hidden" id = "zoneCode" name = "zoneCode">
									<a id="area-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>地区</span>
										<span class="dr"><img src="${webHost}/resources/egolm/assets/images/arrow-black.png"/></span>
									</a>
									<ul id="area-menu" class="dropdown-menu" aria-labelledby="area-id">
										 
									</ul>
								</label>
								<span class="pull-right">
										<a class="add-message" href="${webHost}/tmpPromo/addIndex"><i class="add-icon"></i>新增<span>活动</span></a>
								</span>
							</div>
							</form>
							
							<table class="footable table even" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th></th>
										<th data-toggle="true">活动名称</th>
										<th data-hide="phone">活动类型</th>
										<th data-hide="phone">活动档期</th>
										<th data-hide="phone">活动时间</th>
										<th data-hide="phone">活动区域</th> 
										<th data-hide="phone">状态</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
								  <c:forEach items="${activityList }" var="activity">
									<tr>
										<td>
											<label class="checked-wrap">
												<input type="checkbox" class="chk"  id="tmpPromoId" name="tmpPromoId" value = "${activity.nTmpPromoID}"/>
												<span class="chk-bg"></span>
											</label>
										</td>
										<td>${activity.sTmpPromoTitle }</td>
										<td>${activity.sTmpPromoActionType }</td>
										<td>${activity.sTmpPromoSchedule }</td>
										<td><span class="orange"><fmt:formatDate value="${activity.dTmpPromoBeginDate}" type="both"/>  </span> / <span><fmt:formatDate value="${activity.dTmpPromoEndDate}" type="both"/></span></td>
										<td>${activity.sZoneName }</td>
										<td><span class="state">
										<c:if test="${activity.nTag == 0}">
											<img src="${webHost}/resources/egolm/assets/images/close.png"/></span>未审核</td>
										</c:if>
										<c:if test="${activity.nTag == 2}">
											 <img src="${webHost}/resources/egolm/assets/images/circle.png"/>审核已通过
										</c:if>
										<c:if test="${activity.nTag == 4}">
											 <img src="${webHost}/resources/egolm/assets/images/close.png"/>审核未通过
										</c:if>
										
										<td>
											<span class="dropdown">
												<a class="edit" href="${webHost}/tmpPromo/loadMsgById?id=${activity.nTmpPromoID}"></a>
												<a class="delete" pid="${activity.nTmpPromoID}" href="javascript:void(0)"></a>
												<a class="detail" href="${webHost}/tmpPromo/loadDetailMsgById?id=${activity.nTmpPromoID}">详情</a>
											</span>
										</td>
									</tr>
								  </c:forEach>
								   
								</tbody>
								<tfoot>
									<tr>
										<td colspan="10" class="clearfix">
											<div class="batch">
												<label>
													<input type="checkbox" class="chk" />
													<span class="chk-bg"></span>
													<span class="txt" id="check-all">全选/取消</span>
												</label>
												<label ><input class="border border-radius bg-color f-50" type="button" value="批量通过"  pid="pass"/></label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量不通过"    pid="stop"/></label>
											</div>
											  <c:set var="pagerForm" value="limitPageForm" scope="request"/>
												<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
										</td>
									</tr>
								</tfoot>
							</table>
						
						</div>
						
						 
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->
</e:point>		

