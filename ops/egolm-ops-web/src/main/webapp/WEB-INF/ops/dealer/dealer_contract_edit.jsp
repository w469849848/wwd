<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="经销商合同管理"  currentTopMenu="经销商管理" currentSubMenu="合同管理" css="css/add-dealer.css" js="" localCss="dealer/dealer.css" localJs="dealer/edit-dealer-contract.js,dealer/dealer-base.js,dealer/dealer-warehouse-support.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/dealer/dealer_contract_edit.jsp">

			<div class="main-content">

				<div class="page-content">

					<div class="wh_titer">
						<p class="wh_titer_f">
						您的位置：
							<a href="${webHost}/index">首页</a> &gt; 
							<a href="agentList">经销商管理</a>&gt; 
							<a href="agentContractList">合同管理</a>&gt; 
							<a class="active" href="agentContractEdit">编辑经销商合同</a>
						</p>
					</div>

				<div class="add-box">
							
							<form action="" method="post" id="agentContractFrom" name="agentContractFrom" onsubmit = "return check();" >
								<input type="hidden" id="nAgentContractID" name="nAgentContractID" value="${tAgentContract.NAgentContractID}" />
								<input type="hidden" id="sAgentContractNO" name="sAgentContractNO" value="${tAgentContract.SAgentContractNO}" />
								<input type="hidden" id="nContractTag" name="nContractTag" value="${tAgentContract.NContractTag}" />
								<input type="hidden" id="nTag" name="nTag" value="${tAgentContract.NTag}" />
									<div class="dealer-info">
									<h1 class="content-toggle">合同信息</h1>
									<p class="line"></p>
									<div class="info-box content-box">
										<div class="row">
											  <div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												 <div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">经销商：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="agent" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
															<span id="agentNameSpan" >${tAgent.SAgentName}</span>
															<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
														</a>
														<input type="hidden" id="nAgentID" name="nAgentID" value="${tAgentContract.NAgentID}"/>
														<input type="hidden" id="agentName" name="agentName"/>
														<ul id="agent_menu" class="dropdown-menu" aria-labelledby="agent">
															<%-- <c:forEach items="${agentDatas}" var="agent">
																<li><a id="${agent.nAgentID}" name="${agent.sAgentName}" onClick="getAgent(this)">${agent.sAgentName}</a></li>
															</c:forEach> --%>
														</ul>
													</div>
												</div> 
												
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">合同类型：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="contract_type" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
															<span id="sAgentContractTypeSpan" >请选择</span>
															<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
														</a>
														<input type="hidden" id="sAgentContractTypeID" name="sAgentContractTypeID" value="${tAgentContract.SAgentContractTypeID}"/>
														<input type="hidden" id="sAgentContractType" name="sAgentContractType" value="${tAgentContract.SAgentContractType}"/>
														<ul id="contract_type_menu" class="dropdown-menu" aria-labelledby="contract_type">
															<!-- <li><a id="1" name="买卖合同" onClick="getContractType(this)">买卖合同</a></li> -->
														</ul>
													</div>
													
												</div>
											</div>  
										</div>
										
									 	<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">生效日期：</span>
													<label class="col-xs-7 dropdown-wrap">
														<input id="dActiveDate" class="border border-radius bg-color" type="text" name="dActiveDate" value="${tAgentContract.DActiveDate}"/>
														<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">失效日期：</span>
													<label class="col-xs-7 dropdown-wrap">
														<input id="dExpireDate" class="border border-radius bg-color" type="text" name="dExpireDate" value="${tAgentContract.DExpireDate}"/>
														<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
													</label>
												</div>
											</div>
										</div>
										 <div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">合同时间：</span>
													<label class="col-xs-7 dropdown-wrap">
														<input id="dContractDate" class="border border-radius bg-color" type="text" name="dContractDate" value="${tAgentContract.DContractDate}"/>
														<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">区域：</span>
													<div class="col-xs-7 dropdown-wrap">
														<input type="hidden" name ="sOrgNO" id="sOrgNO" value="${tAgentContract.SOrgNO}"/> 
														<a id="sZoneCode-area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          			<span>${org.sOrgDesc == '' ? '请选择' : org.sOrgDesc}</span>
										          			<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										       			 </a>
										        		<ul id="sZoneCode-area-menu" class="dropdown-menu" aria-labelledby="sZoneCode-area-btn"></ul>										 
													</div>
										 		</div> 
											</div> 
									</div>
								</div>
								</div>
								
								<div class="dealer-addr" style="margin-bottom: 20px;">
									<h1 class="account-toggle">账户资料</h1>
									<p class="line"></p>
									<div class="addr-box account-box">
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">税别：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="sTaxType-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
															<span id="sTaxTypeSpan">请选择</span>
															<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
														</a>
														<input type="hidden" id="sTaxTypeID" name="sTaxTypeID" value="${tAgentContract.STaxTypeID}"/>
														<input type="hidden" id="sTaxType" name="sTaxType" value="${tAgentContract.STaxType}"/>
														<ul id="sTaxType-menu" class="dropdown-menu" aria-labelledby="tax_type">
														</ul>
													</div>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">税率：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="nTaxRate" name="nTaxRate"  value="${tAgentContract.NTaxRate}"  />
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">税比：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="nTaxPct" name="nTaxPct"  value="${tAgentContract.NTaxPct}"  />
													</label>
													
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">付款方式：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="sPaytModeID-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
															<span id="sPaytModeSpan" name="sPaytMode">请选择</span>
															<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
														</a>
														<input type="hidden" id="sPaytModeID" name="sPaytModeID" value="${tAgentContract.SPaytModeID}" />
														<input type="hidden" id="sPaytMode" name="sPaytMode" value="${tAgentContract.SPaytMode}"/>
														<ul id="sPaytModeID-menu" class="dropdown-menu" aria-labelledby="pay_mode">
														</ul>
													</div>
												</div>
											</div>
										</div>
									 	<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">付款账期：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="sPaytTermID-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
															<span id="sPaytTermSpan" name="sPaytTerm">请选择</span>
															<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
														</a>
														<input type="hidden" id="sPaytTermID" name="sPaytTermID" value="${tAgentContract.SPaytTermID}"/>
														<input type="hidden" id="sPaytTerm" name="sPaytTerm" value="${tAgentContract.SPaytTerm}"/>
														<ul id="sPaytTermID-menu" class="dropdown-menu" aria-labelledby="pay_tern">
														</ul>
													</div>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">付款天数：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text"  id="nPaytDay" name="nPaytDay"  value="${tAgentContract.NPaytDay}"  />
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">付款联系人：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sPaytContact" name="sPaytContact"  value="${tAgentContract.SPaytContact}"  />
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">联系人电话：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sPaytContactTel" name="sPaytContactTel"  value="${tAgentContract.SPaytContactTel}" />
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">银行账号：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sBankAccountNO" name="sBankAccountNO"  value="${tAgentContract.SBankAccountNO}"  />
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">银行账户：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sBankAccount" name="sBankAccount"  value="${tAgentContract.SBankAccount}"  />
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">开户银行：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sBank" name="sBank"  value="${tAgentContract.SBank}"  />
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">税号：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text"  id="sTaxCode" name="sTaxCode"  value="${tAgentContract.STaxCode}" />
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">付款中心：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sPaytCenterNO" name="sPaytCenterNO"  value="${tAgentContract.SPaytCenterNO}"  />
													</label>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="dealer-info">
									<h1 class="warehouse-toggle">仓库信息</h1>
									<p class="line"></p>
									<div class="info-box warehouse-box">
										<div class="row">
											  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
												 <div class="col-xs-12 col-sm-3 mr">
													<span class="col-xs-5 input-tips warehouse-title">仓库：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="warehouse-list" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
															<span id="sWarehouseNO-choice" >请选择</span>
															<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
														</a>
														<input type="hidden" id="sWarehouseNO" />
														<input type="hidden" id="sWarehouseName" />
														<ul id="warehouse_menu" class="dropdown-menu" aria-labelledby="warehouse">
														</ul>
													</div>
												</div> 
												
												<div class="col-xs-12 col-sm-3">
													<span class="col-xs-6 input-tips warehouse-title">计费类型：</span>
													<div class="col-xs-6 dropdown-wrap">
														<a id="calcaulate" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
															<span id="calculate-choice" >请选择</span>
															<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
														</a>
														<input type="hidden" id="sFeeCalcTypeID" />
														<input type="hidden" id="sFeeCalcType" />
														<ul id="calculate-menu" class="dropdown-menu" aria-labelledby="contract_type">
														</ul>
													</div>
												</div>
												<div class="col-xs-12 col-sm-3 mr calculate-div">
													<span class="col-xs-6 input-tips warehouse-title">计费方式：</span>
													<label class="col-xs-6">
														<input class="border border-radius bg-color" type="text" id="sFeeCalcValue" value="" /><span>%</span>
													</label>
												</div>
												<div class="col-xs-12 col-sm-3">
													<label class="col-xs-6">
														<input id="add-warehouse" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" data-size="${fn:length(warehouses)}" value="＋添加" />
													</label>
												</div>
											</div>  
										</div>
										<c:forEach var="warehouse" items="${warehouses}" varStatus="status" >
											<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
												 <div class="col-xs-12 col-sm-3 mr warehouse-div">
													<span class="col-xs-6 input-tips warehouse-title"></span>
													<label class="col-xs-6">
														<input type="hidden" name="warehouses[${status.index}].sWarehouseNO" value="${warehouse.sWarehouseNO}" >
														<input class="border border-radius bg-color" type="text" readonly="readonly" name="warehouses[${status.index}].sWarehouseName" value="${warehouse.sWarehouseName}"  />
													</label>
												</div>
												<div class="col-xs-12 col-sm-3 mr">
													<span class="col-xs-6 input-tips warehouse-title"></span>
													<label class="col-xs-6">
														<input type="hidden" name="warehouses[${status.index}].sFeeCalcTypeID" value="${warehouse.sFeeCalcTypeID}" >
														<input class="border border-radius bg-color" type="text" readonly="readonly" name="warehouses[${status.index}].sFeeCalcType" value="${warehouse.sFeeCalcType}"  />
													</label>
												</div>
												<div class="col-xs-12 col-sm-3 mr calculate-div">
													<span class="col-xs-6 input-tips warehouse-title"></span>
													<label class="col-xs-6">
														<input class="border border-radius bg-color" type="text" readonly="readonly" name="warehouses[${status.index}].sFeeCalcValue" value="${warehouse.sFeeCalcValue}"  /><span>${warehouse.sFeeCalcTypeID==5?'¥':'%'}</span>
													</label>
												</div>
												<div class="col-xs-12 col-sm-3">
													<label class="col-xs-6"> 
														<input class="remove-warehouse border-radius border col-xs-6 col-sm-3 col-md-3" type="button" data-rm="${warehouse.canDelete}" value="x移除" />
													</label>
												</div>
											</div>  
											</div>
										</c:forEach>
									</div>
								</div>
								<p class="row">
									<label class="col-xs-12">
										<input id="submit" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="保存"  />
										<input id="cancel" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="取消" />
									</label>
								</p>
							</form>
								<%-- <div class="dealer-addr margin-bottom">
									<h1>商品信息</h1>
									<p class="line"></p>
									<div class="addr-box">
										<table class="footable table" data-page-size="10">
									<thead class="bg-color">
										<tr>
											<th data-toggle="true">条形码</th>
											<th data-hide="phone">商品名称</th>
											<th data-hide="phone">保质期</th>
											<th data-hide="phone,tablet">规格</th>
											<th data-hide="phone">商品价格</th>
											<th data-hide="phone,tablet">包装数量</th>
											<th data-hide="phone">库存数量</th>
											<th data-hide="phone,tablet">供应商</th>
											<th data-hide="phone,tablet">配送方式</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${tAgentContractGoods}" var="d">
										<tr>
											<td>${d.SMainBarcode}</td>
											<td>${d.SGoodsDesc}</td>
											<td>${d.NLifeCycle}</td>
											<td>${d.SSpec}</td>
											<td>${d.NSalePrice}</td>
											<td>${d.SUnit}</td>
											<td>${d.NTag}</td>
											<td>${d.NAgentName}</td>
											<td>${d.SUnit}</td>
											
										</tr>
									</c:forEach>
									</tbody>
								</table>
									</div>	
								</div> --%>
						</div>
				</div>
				
				<script id="warehouse-tpl" type="text/template" >
						<div class="row warehouse-tpl" >
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div class="col-xs-12 col-sm-3 mr warehouse-div">
								<span class="col-xs-6 input-tips warehouse-title"></span> 
								<label class="col-xs-6">
									<input type="hidden" name="warehouseNO" value="warehouseNOValue" />
									<input class="border border-radius bg-color" type="text" readonly="readonly" name="warehouseName" value="warehouseNameValue" />
								</label>
							</div>
							<div class="col-xs-12 col-sm-3">
								<span class="col-xs-6 input-tips warehouse-title"></span> 
								<label class="col-xs-6"> 
									<input type="hidden" name="feeCalculateNO" value="feeCalculateNOValue" />
									<input class="border border-radius bg-color" type="text" readonly="readonly" name="feeCalculateName" value="feeCalculateNameValue" />
								</label>
							</div>
							<div class="col-xs-12 col-sm-3 mr calculate-div">
								<span class="col-xs-6 input-tips warehouse-title"></span> 
								<label class="col-xs-6"> 
									<input class="border border-radius bg-color" type="text" readonly="readonly" name="feeCalculateAmount" value="feeCalculateAmountValue" /><span>amountUnit</span>
								</label>
							</div>
							<div class="col-xs-12 col-sm-3">
								<label class="col-xs-6"> 
									<input class="remove-warehouse border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="x移除" />
								</label>
							</div>
						</div>
						</div>
				</script>
						
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
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="确定"  />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
				<!-- /.page-content -->
			</div>
		<script type="text/javascript">
			$(document).ready(function() {
				initSelect();
				initDate();
			});
			function initSelect(){
				//经销商
				$("#agentNameSpan").text("${tAgent.SAgentName}");
				//合同类型
				$("#sAgentContractTypeSpan").text("${tAgentContract.SAgentContractType}");
				//税比
				$("#sTaxTypeSpan").text("${tAgentContract.STaxType}");
				//付款方式
				$("#sPaytModeSpan").text("${tAgentContract.SPaytMode}");
				//付款账期
				$("#sPaytTermSpan").text("${tAgentContract.SPaytTerm}");
			}
			function initDate(){
				var dActiveDate = new Date("${tAgentContract.DActiveDate}"); 
				var dExpireDate = new Date("${tAgentContract.DExpireDate}"); 
				var dContractDate = new Date("${tAgentContract.DContractDate}"); 
				$("#dActiveDate").val(dActiveDate.pattern("yyyy/MM/dd hh:mm"));
				$("#dExpireDate").val(dExpireDate.pattern("yyyy/MM/dd hh:mm"));
				$("#dContractDate").val(dContractDate.pattern("yyyy/MM/dd hh:mm"));
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