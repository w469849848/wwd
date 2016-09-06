<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="经销商管理"  currentTopMenu="经销商管理" currentSubMenu="" css="css/dealer-manage.css,css/pagination.css,css/footable.core.css" js="js/common.js,js/footable.js,js/checked.js" localCss="" localJs="dealer/dealer-manage.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/dealer/dealer_list.jsp">
				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="agentList">经销商管理</a> &gt; 
								<a class="active" href="agentList">经销商管理</a>
							</p>
						</div>
						
					<div class="audit table-box border-radius"> <!-- 审核表 -->
						<form action="agentList" id="agentPageForm">
							<input type="hidden" name="page.index" value="${page.index}"/>
							<input type="hidden" name="page.limit" value="10"/>
							<input type="hidden" name="page.limitKey" value="dCreateDate DESC"/>
							<p class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="经销商名字" id="sAgentName" name="sAgentName" type="text" value="${sAgentName }" />
								</label>
								<span class="pull-right">
									<a class="add-dealer add-man" href="agentAdd"><i class="fa fa-plus" aria-hidden="true"></i>新增<span>经销商</span></a><a class="add-dealer add-man" href="javascript:filterList();" >查询</a>
								</span>
							</p>
						</form>
							<table class="footable table" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th></th>
										<th data-toggle="true">经销商编号</th>
										<th data-toggle="true">经销商名称</th>
										<th data-toggle="true">经销商抬头</th>
										<th data-hide="phone">联系人</th>
										<th data-hide="phone">手机</th>
										<th data-hide="phone,tablet">电话</th>
										<th data-hide="phone,tablet">传真</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${datas.DataList}" var="d">
										<tr>
										
											<td>
												<label class="checked-wrap">
													<input type="checkbox" class="chk agent-check" name="${d.nAgentID}"  data-id="${d.nAgentID}"/>
													<span class="chk-bg"></span>
												</label>
											</td>
											<td>${d.sAgentNO}</td>
											<td>${d.sAgentName}</td>
											<td>${d.sAgentTitle}</td>
											<td>${d.sContact}</td>
											<td>${d.sMobile}</td>
											<td>${d.sTel}</td>
											<td>${d.sFax}</td>
											<td>
												<a class="edit" href="agentEdit?nAgentID=${d.nAgentID}&type=edit"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/edit.png" alt="编辑" /></a>
												<a class="delete" href="javascript:void(0)"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/delete.png" alt="删除" /></a>
												<a class="detail" href="agentEdit?nAgentID=${d.nAgentID}&type=detail">详情</a>
											</td>
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
													<span class="txt">全选/取消</span>
												</label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量导出" onClick="exportExcel();"/></label>
											</div>
											<%-- <div class="navigation_bar pull-right">
												<ul class="clearfix">
													<li>
														<a href="javascript:$.limitTo(1);" class="nav_first"></a>
													</li>
													<li>
														<a href="javascript:$.limitTo(${page.index - 1});" class="nav_float"></a>
													</li>
													<c:forEach items="${page.pageIndexs}" var="idx">
														 <li <c:if test="${idx eq 1}">class='active'</c:if>><a href="javascript:$.limitTo(${idx});">${idx}</a></li>
														<li class="active"><a href="javascript:$.limitTo(${idx});">${idx}</a></li>
													</c:forEach>
													<li><a href="javascript:$.limitTo(${page.index + 1});" class="nav_right"></a></li>
													<li><a href="javascript:$.limitTo(${page.pageTotal});" class="nav_last"></a></li>
												</ul>
											</div> --%>
												<c:set var="pagerForm" value="agentPageForm" scope="request"/>
												<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
						<!-- 编辑 -->
						<div class="modal fade edit-box" id="editSalesman" tabindex="-1" role="dialog" aria-labelledby="editSalesmanLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
							      	<div class="modal-body">
							        	<form></form>
							      	</div>
						    	</div>
						  	</div>
						</div>
						
						<!-- 确定删除弹窗 -->
						<div class="modal fade delete-box" id="deleteAlert" tabindex="-1" role="dialog" aria-labelledby="deleteAlertLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
							      	<div class="modal-header">
							        	<h4 class="modal-title" id="deleteAlertLabel">弹出框提示</h4>
							      	</div>
							      	<div class="modal-body">
							      		<p>是否确认删除？</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" id="btn-confirm" value="确定" onClick="delAgent();" />
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="取消" />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
 </e:point>