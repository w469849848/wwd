<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="配送优先级管理"  currentTopMenu="城市管理" currentSubMenu="配送优先级管理<" css="css/priorityManageList.css" js="js/common.js" localCss="" localJs="dealer/warehouse/priorityManageList.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/dealer/warehouse/priorityManageList.jsp">
				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="priorityManageList">城市管理</a> &gt; 
								<a class="active" href="priorityManageList">配送优先级管理</a>
							</p>
						</div>
						
					<div class="audit table-box border-radius"> 
						<form action="priorityManageList" id="limitPageForm"  method= "post">
							<input type="hidden" name="page.index" value="${page.index}"/>
							<input type="hidden" name="page.limit" value="10"/>
							<input type="hidden" name="type" value="${type }"/>
							<div class="filter-wrap">
								<label class="label-sRegionDesc">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="仓库名称" name="sRegionDesc" value="${sRegionDesc }" id="filter" type="text">
								</label>
								<lable>
									<span class="pull-right">
										 <a id="query" class="add-level add-man" href="#">查询</a>
									</span>
								</lable>
							</div>
						</form>
							<table class="footable table even" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<!-- <th></th> -->
										<th data-toggle="true">地区编号</th>
										<th data-toggle="true">地区名称</th>
										<th data-toggle="true">地区类型</th>
										<th data-hide="phone">所属城市</th>
										<th data-hide="phone">仓库数</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${districtList}" var="d">
										<tr>
											<%-- <td>
												<label class="checked-wrap">
													<input type="checkbox" class="chk" name="${d.shop}" />
													<span class="chk-bg"></span>
												</label>
											</td> --%>
											<td>${d.sRegionNO}</td>
											<td>${d.sRegionDesc}</td>
											<td>${d.sRegionType}</td>
											<td>${d.sUpRegionDesc}</td>
											<td>${d.whCount}</td>
											<td>
												<a class="edit" href="javascript:priorityManageSet('${d.sRegionNO}');"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/edit.png" alt="编辑" /></a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="10" class="clearfix">
											<!-- <div class="batch">
												<label>
													<input type="checkbox" class="chk" />
													<span class="chk-bg"></span>
													<span class="txt">全选/取消</span>
												</label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量导出" onClick="exportExcel();"/></label>
											</div> -->
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