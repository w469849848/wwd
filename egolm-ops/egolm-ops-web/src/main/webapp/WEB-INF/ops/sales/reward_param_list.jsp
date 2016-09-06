<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="业务员管理"  currentTopMenu="业务员管理" currentSubMenu="" css="" js="" localCss="" localJs="" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/sales/reward_param_list.jsp">

				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								<a href="/${serverName}">首页</a> &gt; 
								<a href="agentList">奖励参数管理</a> &gt; 
								<a class="active" href="agentList">奖励参数管理</a>
							</p>
						</div>
						
					<div class="audit table-box border-radius"> <!-- 审核表 -->
							<form action="toSalesRewardParamList" id="limitPageForm">
							<input type="hidden" name="page.index" value="${page.index}"/>
							<input type="hidden" name="page.limit" value="10"/>
							<input type="hidden" name="page.limitKey" value="nSalRoyID DESC"/>
							<p class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="提成方式" id="sRoyaltyType" name="sRoyaltyType" type="text" value="${sRoyaltyType}" onchange="filterList();"/>
								</label>
								<span class="pull-right">
										<a class="add-man" href="toAddSalesRewardParam"><i class="add-icon"></i>新增奖励参数</a>
								</span>
							</p>
							</form>
							<table class="footable table even" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th></th>
										<th data-toggle="true">业务区域</th>
										<th data-hide="">提成方式</th>
										<th data-hide="phone">提成比例</th>
										<th data-hide="phone,tablet">创建时间</th>
										<th data-hide="phone">修改时间</th>
										<th data-hide="phone">备注</th>
										<th data-hide="phone">状态</th>
										<th>详情</th>
										<th>管理</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${datas.DataList}" var="d">
										<tr>
											<td>
												<label class="checked-wrap">
													<input type="checkbox" class="chk" name="${d.nSalRoyID}" />
													<span class="chk-bg"></span>
												</label>
											</td>
											<td>${d.sBizZone}</td>
											<td>${d.sRoyaltyType}</td>
											<td>${d.nRoyaltyRate}</td>
											<td>${d.dCreateTime}</td>
											<td>${d.dModifyTime}</td>
											<td>${d.sMemo}</td>
											<td><span class="state"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/close.png"/></span>未审核</td>
											<td>
												<a class="detail" href="toEditSalesRewardParam?nSalRoyID=${d.nSalRoyID}&type=detail">详情</a>
											</td>
											<td>
												<a class="edit" href="toEditSalesRewardParam?nSalRoyID=${d.nSalRoyID}&type=edit"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/edit.png" alt="编辑" /></a>
												<a class="delete" href="javascript:void(0)" onClick="del(${d.nSalRoyID})"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/delete.png" alt="删除" /></a>
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
													<span class="txt">全选/取消</span>
												</label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量审核" /></label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量导出" onClick="exportExcel();"/></label>
											</div>
											<div class="pagination pagination-centered">
												<label>当前第${page.index}页，共${page.pageTotal}页</label>
												<a href="javascript:$.limitTo(1);">首页</a>
												<a href="javascript:$.limitTo(${page.index - 1});">上一页</a>
												<c:forEach items="${page.pageIndexs}" var="idx">
													<a href="javascript:$.limitTo(${idx});">${idx}</a>
												</c:forEach>
												<a href="javascript:$.limitTo(${page.index + 1});">下一页</a>
												<a href="javascript:$.limitTo(${page.pageTotal});">末尾</a>
											</div>
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
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="取消" />
							        		<input class="bg-color border-radius border" type="button" id="btn-confirm" value="确定" onClick="delAgent();" />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			
		
		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='${pageContext.request.contextPath}/resources/egolm/assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
		</script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/jquery.ui.touch-punch.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/ace-elements.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/ace.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/footable.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/footable.paginate.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/footable.filter.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/edit-table.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/checked.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/common.js"></script>

		<script type="text/javascript">
			$(document).ready(function() {
				$("#JAlert1").jalert({
					title:"友情提示", 
					message:"测试提示消息"
				});
				$("#JAlert2").click(function() {
					$.jalert({
						title:"友情提示", 
						message:"测试提示消息", 
						confirmButton:"关闭", 
						confirm:function() {
							alert("执行一些操作");
						}
					});
				});
				
				$("#JConfirm1").jconfirm({
					title:"友情提示", 
					message:"确定要删除客户信息吗？",
					confirm:function() {
						alert("执行确认操作");
					}
				});
				$("#JConfirm2").click(function() {
					$.jconfirm({
						title:"友情提示", 
						message:"确定要删除客户信息吗？",
						confirmButton:"确认按钮",
						cancelButton:"取消按钮",
						confirm:function() {
							alert("执行确认操作");
						},
						cancel:function() {
							alert("执行确认取消");
						}
					});
				});

				$("#JWindow1").jwindow({
					html:"<input type='text'/>", 
					confirm:function() {
						alert("执行提交表单操作");
						$.closeJWindow();
					},
					cancel:function() {
						alert("执行关闭弹窗操作");
					}
				});
				$("#JWindow2").click(function() {
					$.jwindow({
						url:"ajax.html",
						showButton:false,
						confirm:function() {
							alert("执行提交表单操作");
						},
						cancel:function() {
							alert("执行关闭弹窗操作");
						}
					});
				});
			});

			jQuery(function($) {
				var footable = null,
					$row = null,
					isAll = false,
					deleteType = true;
				
				$('.supplier table').footable({ //响应式表格初始化
					breakpoints:{
						phone: 480,
				        tablet: 1200
					}
				});
			    
			    $('.chk').on('click',function(){ //选中/取消选中
			    	Checked.checked(this);
			    });
			    
			    $('.batch .chk').on('click',function(){ //全选/取消全选
			    	$('.checked-wrap input').each(function(index){
			    		Checked.selectAll(this,isAll);
			    	});
			    	isAll = !isAll;
			    });
			});
			
			
			function del(id){
		    	$.jconfirm({
						title:"温馨提示", 
						message:"确定要删除奖励参数信息吗？",
						confirmButton:"确认",
						cancelButton:"取消",
						confirm:function() {
							$.ajax({
				                cache: false,
				                type: "POST",
				                url:'cleanSalesRewardParam?nSalRoyID='+id,
				                async: false,
				                error: function(request) {
				                    alert("Connection error");
				                },
				                success: function(data) {
				                	$.jalert({
				    					title:"提示", 
				    					message:"删除成功"
				    				});
				                	window.location.href="toSalesRewardParamList"; 
				                }
				            })
						},
						cancel:function() {
						}
					});
			}
			
			function filterList(){
				var sRoyaltyType = $("#sRoyaltyType").val();
				window.location.href="toSalesRewardParamList?sRoyaltyType="+sRoyaltyType;
			}
			function exportExcel(){
				var sRoyaltyType = $("#sRoyaltyType").val();
				window.location.href="exprotExcel?sRoyaltyType="+sRoyaltyType;
			}
			
			
		</script>
</e:point>