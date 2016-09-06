<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="业务员管理"  currentTopMenu="业务员管理" currentSubMenu="任务管理" css="css/add-salesman.css" js="" localJs="salesman/task_add.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/sales/task_add.jsp">
				<div class="main-content">
					<div class="page-content">
						<div class="wh_titer">
							<p class="wh_titer_f">您的位置：
								<a href="/${serverName}">首页</a> &gt; 
								<a href="taskList">任务管理</a>&gt; 
								<a class="active" href="#">新增任务</a>
							</p>
						</div>
						<div class="add-box"> <!-- 新增任务 -->
							<form method="post" id="salesFrom" name="salesFrom">
								<%-- <p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">任务编号：</span>
										<label class="col-xs-7 col-sm-9">
											<input  readonly="readonly" class="border border-radius bg-color" type="text"  id="sTaskId" name="sTaskId" value="${sSalNum }"/>
										</label>
									</small>
								</p> --%>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">任务名称：</span>
										<label class="col-xs-7 col-sm-9">
											<input class="border border-radius bg-color" type="text"  id="sTaskName" name="sTaskName"/>
										</label>
									</small>
								</p>
								<!-- <p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">任务类型：</span>
										<label class="col-xs-7 col-sm-9">
											<input class="border border-radius bg-color" type="text"  id="sTaskType" name="sTaskType"/>
										</label>
									</small>
								</p> -->
								
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">创建人：</span>
											<label class="col-xs-7 dropdown-wrap">
												<input class="border border-radius bg-color" type="text" id="sCreatorId" name="sCreatorId"/>
											</label>
										</div>
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">创建日期：</span>
											<label class="col-xs-7 dropdown-wrap">
												<input id="dCreateTime" class="border border-radius bg-color" type="text" name="dCreateTime" value="${tAgentContract.DExpireDate}"/>
												<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
											</label>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">审核人：</span>
											<label class="col-xs-7 dropdown-wrap">
												<input class="border border-radius bg-color" type="text" id="sAuditor" name="sAuditor"/>
											</label>
										</div>
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">审核日期：</span>
											<label class="col-xs-7 dropdown-wrap">
												<input id="dAuditTime" class="border border-radius bg-color" type="text" name="dAuditTime" value="${tAgentContract.DExpireDate}"/>
												<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
											</label>
										</div>
									</div>
								</div>
								
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">任务描述：</span>
										<label class="col-xs-7 col-sm-9">
											<input class="border border-radius bg-color" type="text"  id="sRemark" name="sRemark"/>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">备注：</span>
										<label class="col-xs-7 col-sm-9">
											<textarea class="border border-radius bg-color" rows="4"  id="sRemark" name="sRemark"></textarea>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2"></span>
										<label class="col-xs-7 col-sm-9">
											<input onclick="submit();" id="submit" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="提交" />
											<input class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="取消" onclick="window.location.href='taskList'"/>
										</label>
									</small>
								</p>
							</form>
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
							      		<p class="text" id="check-msg">保存成功</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" onclick="window.location.href='toSalesManList'"value="确定" />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
						<div class="modal fade success-box" id="warrAlert" tabindex="-1" role="dialog" aria-labelledby="successAlertLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
							      	<div class="modal-header">
							      		<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
							      	</div>
							      	<div class="modal-body">
							      		<p class="pic"><span></span></p>
							      		<p class="text" id="check-msg-warr">温馨提示</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="确定" />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
					</div><!-- /.page-content -->
			</div><!-- /.main-container-inner -->
</e:point>