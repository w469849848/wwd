<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="广告合同管理"  currentTopMenu="广告管理" currentSubMenu="广告合同管理" css="css/mediaContract-detail.css" js="" localCss="" localJs="" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/media/mediaContract-detail.jsp">


				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/media/mediaContract/list">广告合同管理</a> &gt;
								<a class="active" href="${webHost}/media/mediaContract/loadDetailMsgById?id=${advContractData.nContractID}">合同详情</a>
							</p>
						</div>
							
						<div class="add-box">
							
							<form>
								
								<div class="dealer-info">
									<h1>合同信息</h1>
									<p class="line"></p>
									<div class="info-box">
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">合同编码：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.sContractNO}"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">合同状态：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.nContractTag}"/>
													</label>
												</div>
											</div>
										</div>
										 
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">经销商：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.nAgentID}"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">组织机构：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.sOrgNO}"/>
													</label>
												</div>
											</div>
										</div> 
									 
										
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">生效日期：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="<fmt:formatDate value="${advContractData.dActiveDate}" type="date"/>"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">失效日期：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="<fmt:formatDate value="${advContractData.dExpireDate}" type="date"/>"/>
													</label>
												</div>
											</div>
										</div> 
										
									</div>
								</div>
								
								<div class="dealer-addr margin-bottom">
									<h1>账户资料</h1>
									<p class="line"></p>
									<div class="addr-box">
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">税号：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.sTaxCode}"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">税别：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.sTaxType}"/>
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">税率：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.nTaxRate}"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">税比：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.nTaxPct}"/>
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">付款方式：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.sPaytMode}"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">付款账期：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.sPaytTerm}"/>
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">付款天数：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled"  value="${advContractData.nPaytDay}"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">付款联系人：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled"  value="${advContractData.sPaytContact}"/>
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">付款中心：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.sPaytCenterNO}"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips"> 联系人电话：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.sPaytContactTel}"/>
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips"> 银行账户：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.sBankAccount}"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">银行账号：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.sBankAccountNO}"/>
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">开户银行：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.sBank}"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">固定扣点率: </span>
													<label class="col-xs-7">
														 <input class="border border-radius bg-color" type="text" disabled="disabled" value="${advContractData.nRatio}"/>
													</label>
												</div>
											</div>
										</div>
										
									</div>
								</div>
								
							</form>
						
						</div>
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>		

