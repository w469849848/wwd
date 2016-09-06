<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="业务员管理"  currentTopMenu="业务员管理" currentSubMenu="任务管理" css="css/salesman-manage.css"   js="js/common.js"  localCss="" localJs="salesman/task_list.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/sales/task_list.jsp">
				<div class="main-content">
					<div class="page-content">
						<div class="wh_titer">
							<p class="wh_titer_f">您的位置：
								<a href="/${serverName}">首页</a> &gt; 
								<a href="javascript:void(0);">业务员管理</a> &gt; 
								<a class="active" href=""taskList"">任务管理</a>
							</p>
						</div>
					<div class="audit table-box border-radius"> <!-- 审核表 -->
						<form action="taskList" id="limitPageForm">
							<input type="hidden" name="page.index" value="${page.index}"/>
							<input type="hidden" name="page.limit" value="10"/>
							<input type="hidden" name="page.limitKey" value="dCreateTime DESC"/>		
							<div class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i>
									<input class="filter border-radius bg-color"  width="60px" placeholder="任务名称/任务编号" id="sTaskParam" name="sTaskParam" type="text" value="${sSalParamTrim}" />
								</label>
								<%-- <label class="">
									<a id="tag-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span id="tagSpan">全部</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<input type="hidden" id="nTag" name="nTag" value="${nTag }">
									<ul id="tag-menu" class="dropdown-menu" aria-labelledby="tag-id">
										 <li value=""><a id="" name="全部">全部</a></li>
										 <li value=""><a id="0" name="已启用">已启用</a></li>
										 <li value=""><a id="1" name="已禁用">已禁用</a></li>
									</ul>
								</label> --%>
								<lable>
									<span class="pull-right">
											<a class="add-man"  href="addTask"><i class="add-icon"></i>新增任务</a>
											<a class="add-man" href="#" onclick='$("#limitPageForm").submit()'>查询<span></span></a>
									</span>
								</lable>
							</div>
							</form>
							<table class="footable table even" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th></th>
										<th data-toggle="true">任务编号</th>
										<th data-hide="phone">任务名称</th>
										<th data-hide="phone">任务类型</th>
										<th data-hide="phone">任务创建人</th>
										<th data-hide="phone,tablet">创建时间</th>
										<th data-hide="phone">任务描述</th>
										<th data-hide="phone">任务状态</th>
										<th>管理</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${datas.DataList}" var="d">
										<tr>
											<td>
												<label class="checked-wrap">
													<input type="checkbox" class="chk"  onclick="changeChkStatus(this)" id="SaleId_chk" value="${d.sSaleId}"  attr="${d.nTag}" />
													<span class="chk-bg"></span>
												</label>
											</td>
											<td>${d.sTaskId}</td>
											<td>${d.sTaskName}</td>
											<td>${d.sTaskType}</td>
											<td>${d.sCreatorId}</td>
											<td>${d.dCreateTime}</td>
											<td>${d.sRemark}</td>
											<td>${d.nTag}</td>
											<td>
												<a class="edit"  href="toEditTask?sTaskId=${d.sTaskId}&type=edit"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/edit.png" alt="编辑" /></a>
												<a class="delete" pid="${d.sTaskId}" href="javascript:void(0)" ><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/delete.png" alt="删除" /></a>
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
												<label><input class="border border-radius bg-color f-50" id="batch-confirm" type="button" value="启用／禁用" /></label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量导出"  onClick="exportExcel();"/></label>
											</div> -->
											<c:set var="pagerForm" value="limitPageForm" scope="request"/>
											<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
						<!-- 确定删除弹窗 -->
						<div class="modal fade delete-box" id="deleteAlert" tabindex="-1" role="dialog" aria-labelledby="deleteAlertLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
							      	<div class="modal-header">
							      		<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
							      	</div>
							      	<div class="modal-body">
							      		<input type="hidden"  id = "delete-salesmane-id"  />
							      		<p class="pic"><span></span></p>
							      		<p class="text">是否确认删除任务？</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" id="btn-confirm" value="确定" />
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="取消" />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
						<div class="modal fade edit-box" id="audit-alert" tabindex="-1" role="dialog" aria-labelledby="editNoticeLabel">
								<div class="modal-dialog" role="document">
									<div class="modal-content border-radius">
										<div class="modal-body">
											<form id="notice-modify-form">
												<div class="scroll-wrap" style="text-align : center;" >
											       	<p>
											       		<label>
											        	<span id="a-audit-tag" >确定要启用吗</span>
											        	</label>
											        </p>
											   	</div>
											    <p class="clearfix">
											    	<label class="pull-left"><input id="submit-audit" type="button" value="确定"></label>
											    	<label class="pull-right"><input type="button" data-dismiss="modal" value="取消"></label>
											    </p>
											</form>
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
							      		<p class="text" id="check-msg">保存成功2</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="确定" />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>