<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="经销商合同管理"  currentTopMenu="经销商管理" currentSubMenu="合同管理" css="css/activity-manage.css,css/pagination.css,css/footable.core.css" js="js/common.js,js/footable.js,js/checked.js" localCss="" localJs="dealer/dealer-contract-manage.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/dealer/dealer_contract_list.jsp">

			<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="agentContractList">经销商管理</a> &gt; 
								<a class="active" href="agentContractList">合同管理</a>
							</p>
						</div>
						
						<div class="contract table-box"> <!-- 合同 -->
						<form action="agentContractList" id="agentContractPageForm">
							<input type="hidden" name="page.index" value="${page.index}"/>
							<input type="hidden" name="page.limit" value="10"/>
							<input type="hidden" name="page.limitKey" value="dCreateDate DESC"/>
							<div class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="合同编号" id="sAgentContractNO" name="sAgentContractNO"  type="text" />
								</label>
								<label class="filter-select dropdown-wrap">
									<a id="contract-type" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span id="sComSpan">合同分类</span>
										<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
									</a>
									<input type="hidden" id="sComID" name="sAgentContractTypeID" />
									<input type="hidden" id="sComDesc" name="sAgentContractType"/>
									<ul id="contract-menu" class="dropdown-menu" aria-labelledby="contract-type">
										<c:forEach items="${contractTypeDatas}" var="conType">
											<li><a id="${conType.sComID}" name="${conType.sComDesc}" onClick="getConType(this)">${conType.sComDesc}</a></li>
										</c:forEach>
									</ul>
								</label>
								<!-- <span class="pull-right">
										<a class="add-message" href="agentContractAdd"><i class="add-icon"></i>新增<span>合同</span></a>
								</span> -->
								<span><a id="search-notice" class="add-message notice-button" href="javascript:void(0);" onClick="filterList()"><i></i><span>查询</span></a></span>
								<span><a id="create-notice" class="add-message notice-button" href="agentContractAdd"><i class="add-icon"></i>新增<span>合同</span></a></span>
							</div>
						</form>
							<table class="footable table" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th></th>
										<th data-toggle="true">合同编号</th>
										<th data-toggle="true">组织机构编码</th>
										<th data-toggle="true">联系人</th>
										<th data-hide="phone">联系人电话</th>
										<th data-hide="phone">合同类型</th>
										<th data-hide="phone,tablet">生效时间/失效时间</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${datas.DataList}" var="d">
									<tr>
											<td>
												<label class="checked-wrap">
													<input type="checkbox" class="chk agentcontract-check" name="${d.sAgentContractNO}" value="${d.sAgentContractNO}" data-id="${d.sAgentContractNO}"   />
													<span class="chk-bg"></span>
												</label>
											</td>
											<td>${d.sAgentContractNO}</td>
											<td>${d.sOrgNO}</td>
											<td>${d.sPaytContact}</td>
											<td>${d.sPaytContactTel}</td>
											<td>${d.sAgentContractType}</td>
											<td><span class="orange"><fmt:formatDate value="${d.dActiveDate}" pattern="yyyy-MM-dd HH:mm:ss" />/<fmt:formatDate value="${d.dExpireDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td>
												<a class="edit" href="agentContractEdit?sAgentContractNO=${d.sAgentContractNO}&type=edit"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/edit.png" alt="编辑" /></a>
												<a class="delete" href="javascript:void(0)"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/delete.png" alt="删除" /></a>
												<a class="detail" href="agentContractEdit?sAgentContractNO=${d.sAgentContractNO}&type=detail">详情</a>
												
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
												<!-- <label><input class="border border-radius bg-color f-50" type="button" value="批量删除" onClick="batchDel();"/></label> -->
												<label><input class="border border-radius bg-color f-50" type="button" value="批量导出" onClick="exportExcel();" /></label>
											</div>
											<c:set var="pagerForm" value="agentContractPageForm" scope="request"/>
												<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
									<%-- 	<div class="navigation_bar pull-right">
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
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
						
						<!-- 编辑 -->
						<div class="modal fade edit-box" id="editContract" tabindex="-1" role="dialog" aria-labelledby="editContractLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content">
							      	<div class="modal-body">
							        	<form>
							        		<div class="scroll-wrap">
							        			<p><label><span>经销商ID：</span><input type="text" value="3110000000"></label></p>
							        			<p><label><span>组织机构编码：</span><input type="text" value="318888888"></label></p>
							        			<p><label><span>联系人：</span><input type="text" value="张先生"></label></p>
							        			<p><label><span>联系人电话：</span><input type="text" value="18000000000"></label></p>
							        			<p><label><span>税率：</span><input type="text" value="6.8%"></label></p>
							        			<p><label><span>合同类型：</span><input type="text" value="合同"></label></p>
							        			<p><label><span>状态：</span><input type="text" value="已审核"></label></p>
							        			<p><label><span>生效时间：</span><input type="text" value="2016.04.28"></label></p>
							        			<p><label><span>失效时间：</span><input type="text" value="2017.05.28"></label></p>
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
						
						<!-- 确定删除弹窗 -->
						<div class="modal fade delete-box" id="deleteAlert" tabindex="-1" role="dialog" aria-labelledby="deleteAlertLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
							      	<div class="modal-header">
							      		<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
							      	</div>
							      	<div class="modal-body">
							      		<p class="pic"><span></span></p>
							      		<p class="text">是否确认删除？</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" id="btn-confirm" value="确定" />
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="取消" />
							        	</p>
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
							      		<p class="text">保存成功</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="确定" />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			

		<!-- <script type="text/javascript">
			$(document).ready(function() {
			});
			jQuery(function($) {
				var footable = null,
				$row = null,
				isAll = false, //true为全选，false为未选中
				$table = $('.table-box table'), //获取表格元素
				$bgRow = null;
				
				$('.contract table').footable({ //响应式表格初始化
					breakpoints:{
						phone: 600,
				        tablet: 980
					},
					log: function(message, type) {
						$bgRow = $table.find('tbody tr').not('.footable-row-detail');
						if (message = 'footable_initialized') {
							$bgRow.each(function(index) {
								if (index % 2 == 1) {
									$(this).css({
										'background': '#fbfbfb'
									});
								}
							});
						}
						if (message == 'footable_row_expanded' || message == 'footable_row_collapsed') {
							$bgRow.each(function(index) {
								if (index % 2 == 1) {
									$(this).css({
										'background': '#fbfbfb'
									});
								}
							});
						}
					}
				});
				/* $('td a.edit').on('click',function(e){ //编辑
			    	e.stopPropagation();
			    	$('#editSalesman').modal('show');
			    	TableEdit.util.createForm(this,'editSalesman');
			    	//设置弹窗位置
				    var $alertbox = $('.edit-box .modal-dialog')
				    	alertWidth = $alertbox.width();

				    $alertbox.css({'margin-left': ( - alertWidth/2) + 'px'});
			    }); */
			    
			    
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
			
			//获取合同类型
			function getConType(el){
				var data = eval(el);
				$("#sComID").val(data.id);
				$("#sComDesc").val(data.name); 
				$("#sComSpan").text(data.name);
			}
			
			
			function del(sAgentContractNO){
		    	$.jconfirm({
						title:"友情提示", 
						message:"确定要删除经销商合同信息吗？",
						confirmButton:"确认",
						cancelButton:"取消",
						confirm:function() {
							$.ajax({
				                cache: false,
				                type: "POST",
				                url:'agentContractClean?sAgentContractNO='+sAgentContractNO,
				                async: false,
				                error: function(request) {
				                    alert("Connection error");
				                },
				                success: function(data) {
				                	$.jalert({
				    					title:"提示", 
				    					message:"删除成功"
				    				});
				                	window.location.href="agentContractList"; 
				                	//$('#deleteAlert').modal('hide');
				                }
				            })
						},
						cancel:function() {
						}
					});
			}
			
			function filterList(){
				var sAgentContractNO = $("#sAgentContractNO").val();
				var sComID = $("#sComID").val();
				window.location.href="contract?sAgentContractNO="+sAgentContractNO+"&sComID="+sComID;
			}
			
			function exportExcel(){
				var sAgentContractNO = $("#sAgentContractNO").val();
				var sComID = $("#sComID").val();
				window.location.href="/contract/exprotExcel?sAgentContractNO="+sAgentContractNO+"&sComID="+sComID;
			}
			
			function batchDel(){
				alert(1);
				var contractNoArray= new Array();
				/*  $(".chk").each(function(){
			          if ($(this).attr('checked') ==true) {
			                alert($(this).val());
			            }
			     }); */
			     $('.checked-wrap input').each(function(index){
			    		if ($(this).attr('checked') =='checked') {
			    			contractNoArray.push($(this).val());
			    		}
			     });
			     $.ajax({
		                cache: false,
		                type: "POST",
		                url:'agentContractBatchClean?batchNo='+contractNoArray.toString(),
		                async: false,
		                error: function(request) {
		                    alert("Connection error");
		                },
		                success: function(data) {
		                	$.jalert({
		    					title:"提示", 
		    					message:"删除成功"
		    				});
		                	window.location.href="agentContractList"; 
		                }
		            })
			     
			}
			
			
		</script> -->
</e:point>