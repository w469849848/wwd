<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="经销商合同新增管理"  currentTopMenu="经销商管理" currentSubMenu="合同管理" css="css/add-dealer.css" js="" localCss="dealer/dealer.css" localJs="dealer/add-dealer-contract.js,dealer/dealer-base.js,dealer/dealer-warehouse-support.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/dealer/dealer_contract_add.jsp">


			<div class="main-content">

				<div class="page-content">

					<div class="wh_titer">
						<p class="wh_titer_f">
							您的位置：
							<a href="${webHost}/index">首页</a> &gt; 
							<a href="agentList">经销商管理</a> &gt;
							<a href="agentContractList">合同管理</a>&gt; 
							<a class="active" href="agentContractAdd">新增经销商合同</a>
						</p>
					</div>

				<div class="add-box">
							
							<form action="" method="post" id="agentContractFrom" name="agentContractFrom" onsubmit = "return check();" >
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
															<span id="agentNameSpan" >请选择</span>
															<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
														</a>
														<input type="hidden" id="nAgentID" name="nAgentID"/>
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
														<input type="hidden" id="sAgentContractTypeID" name="sAgentContractTypeID"/>
														<input type="hidden" id="sAgentContractType" name="sAgentContractType"/>
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
														<input type="hidden" name ="sOrgNO" id="sOrgNO" value=""/> 
														<a id="sZoneCode-area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          			<span>请选择</span>
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
														<input type="hidden" id="sTaxTypeID" name="sTaxTypeID"/>
														<input type="hidden" id="sTaxType" name="sTaxType"/>
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
														<input type="hidden" id="sPaytModeID" name="sPaytModeID"/>
														<input type="hidden" id="sPaytMode" name="sPaytMode"/>
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
														<input type="hidden" id="sPaytTermID" name="sPaytTermID"/>
														<input type="hidden" id="sPaytTerm" name="sPaytTerm"/>
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
														<input id="add-warehouse" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="＋添加" />
													</label>
												</div>
											</div>  
										</div>
									</div>
								</div>
								
								<p class="row">
									<label class="col-xs-12">
										<input id="submit" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="保存"  />
										<input id="cancel" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="取消" />
									</label>
								</p>
							</form>
						
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
						<!-- 编辑 -->
						<!-- <div class="modal fade edit-box" id="editDealer" tabindex="-1" role="dialog" aria-labelledby="editDealerLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content">
							      	<div class="modal-body">
							        	<form>
							        		<div class="scroll-wrap">
							        			<p><label><span>商品条型码：</span><input type="text" id="sMainBarcode" name="sMainBarcode"  value="3110000000"></label></p>
							        			<p><label><span>商品名称：</span><input type="text" id="sGoodsDesc" name="sGoodsDesc" value="318888888"></label></p>
							        			<p><label><span>保质期：</span><input type="text" id="nLifeCycle" name="nLifeCycle" value="苏州嘉禾"></label></p>
							        			<p><label><span>规格：</span><input type="text" id="sSpec" value="sSpec" name="苏州嘉禾123"></label></p>
							        			<p><label><span>商品价格：</span><input type="text" id="nRealSalePrice" name="nRealSalePrice" value="已审核"></label></p>
							        			<p><label><span>包装数量：</span><input type="text" id="sUnit" value="sUnit" name="18000000000"></label></p>
							        			<p><label><span>库存数量：</span><input type="text" id="sMainBarcode" name="sMainBarcode" value="021-6888888"></label></p>
							        			<p><label><span>供应商：</span><input type="text" id="sMainBarcode" name="sMainBarcode" value="021-6777777"></label></p>
							        			<p><label><span>配送方式：</span><input type="text" id="sMainBarcode" name="sMainBarcode" value="021-6777777"></label></p>
							        		</div>
							        		<p class="clearfix">
							        			<label class="pull-left"><input id="goodsSubmit" type="button" value="保存"></label>
							        			<label class="pull-right"><input type="button" data-dismiss="modal" value="取消"></label>
							        		</p>
							        	</form>
							      	</div>
						    	</div>
						  	</div>
						</div> -->
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
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="确定" />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
				</div>
				<!-- /.page-content -->
			</div>
</e:point>