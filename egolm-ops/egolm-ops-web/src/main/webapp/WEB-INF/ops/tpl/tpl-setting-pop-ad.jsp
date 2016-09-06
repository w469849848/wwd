<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<c:set scope="application" var="egolmHost"     value="${e:egolmHost('')}" />
<c:set scope="application" var="mediaHost"     value="${e:mediaHost('')}" />
<c:set scope="application" var="resourceHost"  value="${e:resourceHost('')}${serverName}/resources/assets" />
<c:set scope="application" var="localHost"     value="${e:localHost()}" />
<c:set scope="application" var="serverName"    value="${e:serverName()}" />
<c:set scope="application" var="webHost"       value="${egolmHost}${serverName}" />
<e:resource title="模板设置" currentTopMenu="" currentSubMenu="" css=""  js="js/common.js"  localCss="tpl/tpl-setting.css,tpl/index.css,tpl/tpl-manage.css" showFooter="false" showHeader="false" showSubMenu="false" showMenu="false" showTopMenu="false" localJs="tpl/tpl-setting.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-setting-pop-ad.jsp">
	<div class="modal fade edit-box ad-pic in" id="editAdPic" tabindex="-1" role="dialog" aria-labelledby="editAdPicLabel" style="display: block; padding-right: 0px;">
		  	<div class="modal-dialog" role="document">
		    	<div class="modal-content border-radius" style="height: 600px;margin-top: 20px;">
		    		<div class="modal-header">
		    		</div>
			      	<div class="modal-body">
			        	<form id="limitPageForm" method="post">
							<input type="hidden" name="page.index" value="${page.index}" />
							<input type="hidden" name="page.limit" value="10" />
			        		<div class="table-box">
			        			<p class="filter-wrap">
									<label class="">
										<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="广告位名称" id="filter" type="text"  name="aAptile" value="${aAptile }"/>
										<input type="hidden" value="${orgNO }" name="orgNO" id="orgNO">
										<input type="hidden" value="${sScopeTypeID }" name="sScopeTypeID" id="sScopeTypeID">
									</label>
									<span class="pull-right">
											<a class="add-message" href="#" onclick='$("#limitPageForm").submit()'>查询<span></span></a>
									</span>
								</p>
								<div class="table-scroll">
									<div class="table-head">
										<table class="footable table even border border-radius" data-page-size="10">
											<thead class="bg-color">
												<tr>
													<th data-toggle="true">广告位名称</th>
													<th data-hide="phone">类别</th>
													<th data-hide="phone">所属区域</th>
													<th data-hide="">尺寸</th>
													<th></th>
												</tr>
											</thead>
										</table>
									</div>
									<div class="scroll-wrap">
										<table class="footable table even border border-radius" data-page-size="10">
											<thead class="bg-color hide">
												<tr>
													<th data-toggle="true">广告位名称</th>
													<th data-hide="phone">类别</th>
													<th data-hide="phone">所属区域</th>
													<th data-hide="phone">尺寸</th>
													<th data-hide="phone">操作</th> 
												</tr>
											</thead>
											<tbody>
												<c:forEach items="${datas}" var="d">
													<tr>
														<td>${d.sApTitle}</td>
														<td>${d.sApSaleType}</td>
														<td>${d.sZoneCode}</td>
														<td>宽${d.nApWidth}*高${d.nApHeight}</td>
														<td>
															<%-- <a class="detail"  id="see_detail" attr="${d.nApID }" name="${d.sZoneCode }" href="javascript:void(0)">查看</a> --%>
															<c:if test="${d.sApStatusID ==1}">
																	<a class="detail active" href="javascript:void(0)">启用中</a>
															</c:if>
															<c:if test="${d.sApStatusID !=1}">
																	<a class="detail" onclick="savePopAdd(${d.nApID},'http://img.egolm.com${d.sApPathUrl}@${d.nApHeight}h_${d.nApWidth }w','${sign }')" href="javascript:void(0)">启用</a>
															</c:if>
														</td>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
			        		</div>
							<div class="navigation_bar pull-right" style="margin-top: 20px;">
								<ul class="clearfix">
									<c:set var="pagerForm" value="limitPageForm" scope="request"/>
									<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
								</ul>
							</div>
			        	</form>
			      	</div>
		    	</div>
		  	</div>
		</div>
</e:point>