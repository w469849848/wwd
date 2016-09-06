<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="广告位管理"  currentTopMenu="广告管理" currentSubMenu="广告位管理" css="css/mediaPosition-manage.css" js="js/common.js" localCss="" localJs="media/mediaPosition-manage.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/media/mediaPosition-manage.jsp">

				<div class="main-content">
					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/media/mediaPos/list">广告管理</a> &gt; 
								<a class="active" href="${webHost}/media/mediaPos/list">广告位管理</a>
							</p>
						</div>
						
						<div class="advertisement table-box"> <!-- 广告管理 -->
						  <form action="list" id="limitPageForm"  method= "post">
							<input type="hidden" name="page.index" id="page_index" value="${page.index}" />
							   <input type="hidden" name="page.limit" value="10" />  
						
							<div class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="广告位名称" id="sApTitle" name="sApTitle" type="text" value="${sApTitle }"/>
								</label>
								<label class="filter-select dropdown-wrap adv-margin">
 								<input type="hidden" name="sZoneCodeID" id="sZoneCodeID" value="${sZoneCodeID }"> 
									<a id="ap-zoneCode-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>区域</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="ap-zoneCode-menu" class="dropdown-menu" aria-labelledby="ap-zoneCode-id">
										 
									</ul>
								</label>
								<label class="filter-select dropdown-wrap adv-margin">
 								<input type="hidden" name="sApSaleTypeID" id="sApSaleTypeID" value="${sApSaleTypeID }"> 
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
								
								<span class="pull-right"> 
										<a class="add-message" href="${webHost}/media/mediaPos/addIndex"><i class="add-icon"></i>新增<span>广告位</span></a>
								</span>
								 
								<span class="pull-right" id="query"><a class="add-message" href="#">查询</a> </span>
							</div>
							</form>
							<table class="footable table" data-page-size="5">
								<thead class="bg-color">
									<tr>
										 
										<th data-hide="phone">编号</th>
										<th data-toggle="true">广告位名称</th>
										<th data-hide="phone,tablet">广告位区域</th>
										<th data-hide="phone">广告位类型</th>
										<th data-hide="phone">店铺类型</th>
										<th data-hide="phone">类别</th>
										<th data-hide="phone,tablet">尺寸</th>
										<th data-hide="phone,tablet">价格（元/月）</th>
										<th data-hide="phone,tablet">展示类型</th>
										<th data-hide="phone">状态</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
								
								 <c:forEach items = "${adPosList }" var= "adPos">
									<tr>
									<%-- 	<td>
											  <label class="checked-wrap">
												<input type="checkbox" class="chk" id="nApId-chk" name="nApId-chk" value="${adPos.nApID }"/>
												<span class="chk-bg"></span>
											</label>  
										</td> --%>
										 <td >
											${adPos.nApID}
										</td>
											 
										<td>${adPos.sApTitle }</td>
										<td>${adPos.sZoneCode }</td> 
										<td>${adPos.sApSaleType }</td>
										<td>${adPos.sScopeType }</td>
										<td>${adPos.sApType }</td>
										<td>宽${adPos.nApWidth }x高${adPos.nApHeight }(px)</td>
										<td>${adPos.nApPrice/100 }</td>
										<td>${adPos.sApShowType }</td>
										<td><span class="state">
										<c:if test="${adPos.sApStatusID ==0}">
										    <img src="${resourceHost}/images/close.png"/></span>未启用 
										</c:if>
										<c:if test="${adPos.sApStatusID ==1}">
										   <img src="${resourceHost}/images/circle.png"/></span>已启用
										</c:if>
										
										
										</td>
										<td>
											<a class="edit"  href="${webHost}/media/mediaPos/loadMsgByID?id=${adPos.nApID }"><img src="${resourceHost}/images/edit.png" alt="编辑" /></a>
											<a class="delete" pid="${adPos.nApID }" pStatus ="${adPos.sApStatusID}"  href="javascript:void(0)"><img src="${resourceHost}/images/delete.png" alt="删除" /></a>
											<%-- <a class="call"  pid="${adPos.nApID }" pZoneCode="${adPos.sZoneCodeID }" href="javascript:void(0)">调用代码</a> --%>
										</td>
									</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="11" class="clearfix">
											 <!--  <div class="batch">
												<label>
													<input type="checkbox" class="chk" />
													<span class="chk-bg"></span>
													<span class="txt">全选/取消</span>
												</label>
												  <label><input class="border border-radius bg-color f-50" type="button" value="批量导出" /></label>  
											</div>   -->
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

