<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>  
<e:resource title="广告管理"  currentTopMenu="广告管理" currentSubMenu="" css="css/mediaContent-manage.css" js="js/common.js" localCss="" localJs="media/mediaContent-manage.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/media/mediaContent-manage.jsp">
 				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/media/mediaContext/list">广告管理</a> &gt; 
								<a class="active" href="${webHost}/media/mediaContext/list">广告管理</a>
							</p>
						</div>
						
						<div class="advertisement table-box"> <!-- 广告管理 -->
							<form action="list" id="limitPageForm" method= "post">
							  <input type="hidden" name="page.index" value="${page.index}" id="page_index"/>  
						
							<div class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="广告名称" id="sAdTitle" type="text"  name="sAdTitle" value="${sAdTitle }"/>
								</label>
								
								<label class="filter-select dropdown-wrap adv-margin">
 								<input type="hidden" name="sAdZoneCodeID" id="sAdZoneCodeID" value="${sAdZoneCodeID }"> 
									<a id="ad-zoneCode-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>区域</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="ad-zoneCode-menu" class="dropdown-menu" aria-labelledby="ad-zoneCode-id">
										 
									</ul>
								</label>
								
								 <label class="filter-select dropdown-wrap adv-margin">
 								<input type="hidden" name="sApSaleTypeID" id="sApSaleTypeID" value="${sApSaleTypeID}"> 
									<a id="ap-position-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>广告位类型</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="ap-position-menu" class="dropdown-menu" aria-labelledby="ap-position-id">
										<!-- <li value="wx">微信广告位</li>
										<li value="web">WEB广告位</li>
										<li value="app">APP广告位</li> -->
									</ul>
								</label>
							 
								<input   id="nApID"  name="nApID"  type="hidden" /> <!-- 不用回传 -->
								<label class="dropdown-wrap"> 
									   <div class="select-wrap">
									      <i class="icon-search f-95"></i>
										     <input class="filter border-radius bg-color" placeholder="广告位名称" id="sApTitle" type="text"  name="sApTitle" value="${sApTitle }"/>
										     <span class="dr" id="seletAdPosNO"><img src="${resourceHost}/images/icon-select.png"/></span>
										</div> 
								</label>
								
								<span class="pull-right">
										<a class="add-message" id="query"  href="#">查询</a>
										<a class="add-message" href="${webHost}/media/mediaContext/addIndex"><i class="add-icon"></i>新增<span>广告</span></a>
								</span> 
							</div>
							 </form>
							<table class="footable table" data-page-size="5">
								<thead class="bg-color">
									<tr>
										<!-- <th></th> -->
										<th data-toggle="true">编号</th>
										<th data-hide="phone">广告名称</th>
										<th data-hide="phone">广告位类型</th>
										<th data-hide="phone,tablet">广告位名称</th> 
										<th data-hide="phone">所属区域</th>
										<th data-hide="phone,tablet">开始时间 / 结束时间</th>
										<th data-hide="phone,tablet">还有几天到期</th>
										<th data-hide="phone,tablet">点击率</th>
										<th data-hide="phone,tablet">图片</th>
										<th data-hide="phone">状态</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
								
								   <c:forEach items="${adVertList }" var="adVert">
										<tr>
											<!-- <td>
												<label class="checked-wrap">
													<input type="checkbox" class="chk" />
													<span class="chk-bg"></span>
												</label>
											</td> -->
											<td >
												${adVert.nAdID} 
											</td>
											<td>${adVert.sAdTitle}</td>
											<td>${adVert.sApSaleType}</td>
											<td>${adVert.sApTitle }</td>
											<td>${adVert.sAdZoneCode} </td>
											<td><span><fmt:formatDate value="${adVert.dAdBeginTime}" type="date"/>  </span> / <span  class="orange"><fmt:formatDate value="${adVert.dAdEndTime}" type="date"/></span></td>
											<td><span  class="orange"> 
											   <c:if test="${adVert.endDay <0 }">
											        已过期 ${adVert.endDay*-1}天
											   </c:if>
											  <c:if test="${adVert.endDay >=0 }">
											        ${adVert.endDay}天
											   </c:if>
											   
											   </span> </td>
											<td>${adVert.nAdClickNum}</td>
											<td class="advertise-id">
												 <div class="clearfix">
												 <c:if test="${not empty adVert.sAdPathUrl }">
												   <img class="pull-left" src="${imgUrl}${adVert.sAdPathUrl}@70w_66h" width="70" height="66"  id="show-pic-id"/>
												   <div  id="adPicImg" class="pic-show-alert" style="display:none;">
												   <img src="${imgUrl}/${adVert.sAdPathUrl}@${adVert.nAdWidth }w_${adVert.nAdHeight}h"  width="${adVert.nAdWidth }" height="${adVert.nAdHeight}" id="logoShow2"/> 
												   </div>
												   
												 </c:if>
												  <c:if test="${empty adVert.sAdPathUrl }">
												      <img class="pull-left" src="${resourceHost}/goods/good.jpg" />
												 </c:if> 
												</div>
											</td>											<td><span class="state">
											  <c:if test="${adVert.nTag == 1 }">
											   <img src="${resourceHost}/images/close.png"/></span>未审核
											  </c:if>
											   <c:if test="${adVert.nTag == 4 }">
											   <img src="${resourceHost}/images/close.png"/></span>审核未通过
											  </c:if>
											   <c:if test="${adVert.nTag == 2 }">
											      <span class="state"><img src="${resourceHost}/images/circle.png"/></span>已审核
											  </c:if> 
											  </td>
											<td>
												<a class="edit" href="${webHost}/media/mediaContext/loadMsgById?id=${adVert.nAdID}"><img src="${resourceHost}/images/edit.png" alt="编辑" /></a>
												<a class="delete" pid="${adVert.nAdID}" href="javascript:void(0)"><img src="${resourceHost}/images/delete.png" alt="删除" /></a>
											</td>
										</tr> 
										 <c:if test="${adVert.nTag == 4 }"> 
										   <tr class="reject-elem" id="error_${adVert.nAdID}" ><td colspan="11">审核不通过原因：<span class="border border-radius">由于<input type="text"  value="${adVert.sMemo }" readonly="readonly"/>的原因，您的广告未能通过审核</span></td></tr>
										 </c:if>
									  </c:forEach> 
								</tbody>
								<tfoot>
									<tr>
										<td colspan="10" class="clearfix">
											<div class="batch">
												<!-- <label>
													<input type="checkbox" class="chk" />
													<span class="chk-bg"></span>
													<span class="txt">全选/取消</span>
												</label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量导出" /></label> -->
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
</e:point>			
	
