<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="业务员管理"  currentTopMenu="业务员管理" currentSubMenu="任务管理" css="css/add-salesman.css" js="" localJs="salesman/template_edit.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/sales/template_edit.jsp">
				<div class="main-content">
					<div class="page-content">
						<div>
							<input type="hidden" id="sTemplateId" value="${tSalesmanTemplate.sTemplateId }">
						</div>
						<div class="wh_titer">
							<p class="wh_titer_f">您的位置：
								<a href="/${serverName}">首页</a> &gt; 
								<a href="templateList">模板管理</a>&gt; 
								<a class="active" href="#">编辑模板</a>
							</p>
						</div>
						<div class="add-box"> <!-- 编辑模板 -->
							<form method="post" id="salesFrom" name="salesFrom">
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">模板名称：</span>
										<label class="col-xs-7 col-sm-9">
											<input class="border border-radius bg-color" type="text"  id="sTemplateName" name="sTemplateName" value="${tSalesmanTemplate.sTemplateName }"/>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">任务类型：</span>
										<label class="col-xs-7 col-sm-9">
										<c:forEach var="data" items="${datas.DataList}">
											<c:if test="${fn:contains(tSalesmanTemplate.sTaskType,data.sTaskId)==true}">
												<input checked="checked" type="checkbox" value="${data.sTaskId }"><span>${data.sTaskName }</span>
											</c:if>
											<c:if test="${fn:contains(tSalesmanTemplate.sTaskType,data.sTaskId)==false}">
												<input type="checkbox" value="${data.sTaskId }"><span>${data.sTaskName }</span>
											</c:if>
										</c:forEach>
										</label>
									</small>
								</p>
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">创建人：</span>
											<label class="col-xs-7 dropdown-wrap">
												<input class="border border-radius bg-color" type="text" id="sCreator" name="sCreator" value="${tSalesmanTemplate.sCreator }"/>
											</label>
										</div>
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">创建日期：</span>
											<label class="col-xs-7 dropdown-wrap">
												<input id="dCreateTime" class="border border-radius bg-color" type="text" name="dCreateTime" value="${tSalesmanTemplate.dCreateTime }"/>
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
												<input class="border border-radius bg-color" type="text" id="sAuditor" name="sAuditor" value="${tSalesmanTemplate.sAuditor }"/>
											</label>
										</div>
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">审核日期：</span>
											<label class="col-xs-7 dropdown-wrap">
												<input id="dAuditTime" class="border border-radius bg-color" type="text" name="dAuditTime" value="${tSalesmanTemplate.dAuditTime }"/>
												<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
											</label>
										</div>
									</div>
								</div>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">模板描述：</span>
										<label class="col-xs-7 col-sm-9">
											<input class="border border-radius bg-color" type="text"  id="sRemark" name="sRemark" value="${tSalesmanTemplate.sRemark }"/>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">备注：</span>
										<label class="col-xs-7 col-sm-9">
											<textarea class="border border-radius bg-color" rows="4"  id="sRemark" name="sRemark" value="${tSalesmanTemplate.sRemark }"></textarea>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2"></span>
										<label class="col-xs-7 col-sm-9">
											<input id="submit" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="提交" />
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
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" onclick="window.location.href='templateList'"value="确定" />
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
			<script type="text/javascript">
			$(document).ready(function() {
				initDate();
			});
			function initDate(){
				var dCreateTime = new Date("${tSalesmanTemplate.dCreateTime}"); 
				var dAuditTime = new Date("${tSalesmanTemplate.dAuditTime}"); 
				$("#dCreateTime").val(dCreateTime.pattern("yyyy-MM-dd hh:mm"));
				$("#dAuditTime").val(dAuditTime.pattern("yyyy-MM-dd hh:mm"));
			}
			Date.prototype.pattern=function(fmt) {         
			    var o = {         
			    "M+" : this.getMonth()+1, //月份         
			    "d+" : this.getDate(), //日         
			    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时         
			    "H+" : this.getHours(), //小时         
			    "m+" : this.getMinutes(), //分         
			    "s+" : this.getSeconds(), //秒         
			    "q+" : Math.floor((this.getMonth()+3)/3), //季度         
			    "S" : this.getMilliseconds() //毫秒         
			    };         
			    var week = {         
			    "0" : "/u65e5",         
			    "1" : "/u4e00",         
			    "2" : "/u4e8c",         
			    "3" : "/u4e09",         
			    "4" : "/u56db",         
			    "5" : "/u4e94",         
			    "6" : "/u516d"        
			    };         
			    if(/(y+)/.test(fmt)){         
			        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));         
			    }         
			    if(/(E+)/.test(fmt)){         
			        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "/u661f/u671f" : "/u5468") : "")+week[this.getDay()+""]);         
			    }         
			    for(var k in o){         
			        if(new RegExp("("+ k +")").test(fmt)){         
			            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));         
			        }         
			    }         
			    return fmt;         
			} 
		</script>
</e:point>