<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="广告审核管理"  currentTopMenu="广告管理" currentSubMenu="广告审核管理" css="css/mediaContent-audit.css" js="" localCss="" localJs="media/mediaContent-audit.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/media/mediaContent-audit.jsp">


				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="#">广告管理</a> &gt; 
								<a class="active" href="${webHost}/media/mediaContext/waitAuditlist">广告审核</a>
							</p>
						</div>
						
						<div class="advertisement table-box"> <!-- 广告管理 -->
						 <form action="waitAuditlist" id="limitPageForm"  method= "post">
							  <input type="hidden" name="page.index" value="${page.index}" id="page_index"/>  
						
								<div class="filter-wrap">
									<label class="">
										<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="广告名称" id="sAdTitle" type="text"  name="sAdTitle" value="${sAdTitle }"/>
									</label>
									<label class="filter-select dropdown-wrap adv-margin">
 										<input type="hidden" name="sAdZoneCodeID" id="sAdZoneCodeID" value="${sAdZoneCodeID }" /> 
										<a id="ad-zoneCode-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
											<span>区域</span>
											<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										</a>
										<ul id="ad-zoneCode-menu" class="dropdown-menu" aria-labelledby="ad-zoneCode-id">
											 
										</ul>
								    </label>
										<label class="filter-select dropdown-wrap adv-margin">		
	 										<input type="hidden" name="sApSaleTypeID" id="sApSaleTypeID" value="${sApSaleTypeID }"/>  
										<a id="ap-position-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
											<span>广告位置</span>
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
									
									<%-- <label class="filter-select dropdown-wrap">
										<input type="hidden" name="nApID" id="nApID"> 
										<a id="adv-name-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
											<span>广告名称</span>
											<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										</a>
										<ul id="adv-name-menu" class="dropdown-menu" aria-labelledby="adv-name-id">
											
										</ul>
									</label> --%>
									<span class="pull-right">
										<a class="add-message" id="query"  href="#">查询</a> 
								    </span> 
								</div>
							</form>
							<table class="footable table" data-page-size="5">
								<thead class="bg-color">
									<tr>
										<th></th>
										<th data-toggle="true">编号</th>
										<th data-hide="phone">广告名称</th>
										<th data-hide="phone">广告位类型</th>
										<th data-hide="phone,tablet">广告位名称</th> 
										<th data-hide="phone">所属区域</th>
										<th data-hide="phone,tablet">开始时间 / 结束时间</th>
										<th data-hide="phone,tablet">图片</th>
										<th data-hide="phone,tablet">幻灯片序号</th>
										<th data-hide="phone">状态</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									 <c:forEach items="${adVertList }" var="adVert">
										<tr>
											<td>
												<label class="checked-wrap">
													<input type="checkbox" class="chk media_audit_chk" name="nadid-chk" id = "nadid-chk" value="${adVert.nAdID}"/>
													<span class="chk-bg"></span>
												</label>
											</td>
											<td >
												${adVert.nAdID}
											</td>
											<td>${adVert.sAdTitle}</td>
											<td>${adVert.sApSaleType}</td>
											<td>${adVert.sApTitle }</td>
											<td>${adVert.sAdZoneCode}</td>
											<td><span class="orange"><fmt:formatDate value="${adVert.dAdBeginTime}" type="date"/>  </span> / <span><fmt:formatDate value="${adVert.dAdEndTime}" type="date"/></span></td>
											<td class="advertise-id">
												 <div class="clearfix">
												 <c:if test="${not empty adVert.sAdPathUrl }">
												   <img class="pull-left" src="${imgUrl}/${adVert.sAdPathUrl}@70w_66h" width="70" height="66"  id="show-pic-id"/>
												    	<div  id="adPicImg" class="pic-show-alert" style="display:none;"><img src="${imgUrl}/${adVert.sAdPathUrl }@${adVert.nAdWidth }w_${adVert.nAdHeight}h"  width="${adVert.nAdWidth }" height="${adVert.nAdHeight}" id="logoShow2"/> </div>
												   
												 </c:if>
												  <c:if test="${empty adVert.sAdPathUrl }">
												      <img class="pull-left" src="${resourceHost}/goods/good.jpg" />
												 </c:if> 
												</div>
											</td>
											<td>${adVert.nAdSlideSequence}</td>
											<td><span class="state">
											  <c:if test="${adVert.nTag == 1 }">
											   <img src="${resourceHost}/images/close.png"/></span>未审核
											  </c:if>
											   
											  </td>
											<td>
											   <a class="edit" pid="${adVert.nAdID}" pName="${adVert.sAdTitle}" href="javascript:void(0)"><img src="${resourceHost}/images/edit.png" alt="编辑" /></a>
										    </td>
										</tr> 
									  </c:forEach> 
									             
								</tbody>
								<tfoot>
									<tr>
										<td colspan="10" class="clearfix">
											<div class="batch">
												<label>
													<input type="checkbox" class="chk all_media_audit_chk" />
													<span class="chk-bg"></span>
													<span class="txt">全选/取消</span>
												</label>
												  <label><input class="border border-radius bg-color f-50" type="button" value="批量审核" /></label>  
											</div>
											 <c:set var="pagerForm" value="limitPageForm" scope="request"/>
											<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
						
						<!-- 编辑 -->
						<div class="modal fade edit-box" id="editAd" tabindex="-1" role="dialog" aria-labelledby="editAdLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content">
						    	    <input type="hidden"  id="audit-adId" name="audit-adId"/>
							      	<div class="modal-body">
							        	<form>
							        		<div class="scroll-wrap">
							        			<p id="ad-num-id"><label><span>编号：</span><input type="text" name="alert-adId" id="alert-adId" readonly="readonly" ></label></p>
							        			<p id="ad-title-id"><label><span>广告名称：</span><input type="text" name="alert-adTitle" id="alert-adTitle" readonly="readonly"></label></p>  
 							        			  <p>
							        				<label>
							        					<span>审核通过：</span>
								        				<label>
								        					<span class="checked-wrap">
																<input type="radio" name="alertNtag" class="chk-radio"  id="alertNtag"  checked = "checked" value="2">
																<span class="chk-bg"></span>
															</span>
															<i>审核通过</i>
								        				</label>
														<label>
															<span class="checked-wrap">
																<input type="radio" name="alertNtag" class="chk-radio"  id="alertNtag"  value="4">
																<span class="chk-bg"></span>
															</span>
															<i>审核不通过</i>
														</label>
							        				</label>
							        			</p>  
							        			<p style="display: none;" id="errorMsgId"><label><span>审核失败原因：</span><input type="text" name="alert-sMemo"  id="alert-sMemo" value=""></label></p> 
							        		</div>
							        		<p class="clearfix">
							        			<label class="pull-left"><input id="submit" type="button" value="保存"></label>
							        			<label class="pull-right"><input type="button" data-dismiss="modal" value="取消"></label>
							        		</p>
							        	</form>
							      	</div>
						    	</div>
						  	</div>
						</div> 
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			
</e:point>