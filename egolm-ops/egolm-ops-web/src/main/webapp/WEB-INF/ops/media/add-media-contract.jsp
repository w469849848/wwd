<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="广告合同管理"  currentTopMenu="广告管理" currentSubMenu="广告合同管理" css="css/add-media-contract.css" js="" localCss="" localJs="media/add-media-contract.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/media/add-media-contract.jsp">


				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/media/mediaContract/list">广告管理</a> &gt; 
								<a href="${webHost}/media/mediaContract/list">广告合同管理</a> &gt; 
								<c:if test="${not empty advContractData.nAgentID}">
								<a class="active" href="${webHost}/media/mediaContract/loadMsgById?id=${adVertData.nContractID}">广告合同编辑</a>
								</c:if>
								<c:if test="${empty advContractData.nAgentID}">
								<a class="active" href="${webHost}/media/mediaContract/addIndex">新增广告合同</a>
								</c:if>
							</p>
						</div>
						
						<div class="adcontract"> <!-- 广告合同管理 -->
							<form action ="" method="post" id="adContractFrom" name="adContractFrom" onsubmit = "return check();"  enctype="multipart/form-data">
							 
							<input type="hidden" name="nContractID" id ="nContractID" value="${advContractData.nContractID}"/>
							<input type="hidden" id ="sContractNO_hidden" value="${advContractData.sContractNO}"/>  
							  
							  <p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">合同编码：</span>
										<label class="col-xs-7 col-sm-9 dropdown-wrap">
									 
											
										   <input class="border border-radius bg-color" type="text" name="sContractNO_show" id = "sContractNO_show" value="${advContractData.sContractNO}"  readonly="readonly"/>
										   <input type="hidden" name="sContractNO" id ="sContractNO" value="${advContractData.sContractNO}"/>
										</label>
									</small>
								</p> 
								
								<div class="row">
							    <div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">固定扣点率：</span>
											<label class="col-xs-7">
											<input class="border border-radius bg-color" type="text" name="nRatio" id = "nRatio" value="${advContractData.nRatio }"/>
											</label>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">税号：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text" name="sTaxCode" id = "sTaxCode" value="${advContractData.sTaxCode }"/>
											</label>
											
										</div>
										
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">经销商：</span>
											<div class="col-xs-7 dropdown-wrap">
											<input type="hidden" id="nAgentID" name="nAgentID" value="${advContractData.nAgentID }"/> 
												<a id="nAgent-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="nAgent-memu" class="dropdown-menu" aria-labelledby="nAgent-id">
										           								          	
										        </ul>										 
											</div>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">组织机构：</span>
											<input type="hidden" id="sOrgNO" name="sOrgNO" value="${advContractData.sOrgNO }"/> 
											<input type="hidden" id="sOrgNODesc" name="sOrgNODesc" value="${advContractData.sOrgNODesc }"/> 
											<div class="col-xs-7 dropdown-wrap">
												<a id="sOrgNO-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sOrgNO-memu" class="dropdown-menu" aria-labelledby="sOrgNO-id">
										           
										        </ul>										 
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">生效日期：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text" name="dActiveDate" id = "dActiveDate" value="<fmt:formatDate value="${advContractData.dActiveDate}" pattern="yyyy-MM-dd"/> "/>
												<span class="dr"><img src="${resourceHost}/images/arrow-black.png"></span>
											</label>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">终止日期：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text" name="dExpireDate" id = "dExpireDate" value="<fmt:formatDate value="${advContractData.dExpireDate}" pattern="yyyy-MM-dd"/>"/>
											  <span class="dr"><img src="${resourceHost}/images/arrow-black.png"></span>
											</label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">税率：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text" name="nTaxRate" id = "nTaxRate" value="${advContractData.nTaxRate }" maxlength="2"/>
											</label>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">税比：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text" name="nTaxPct" id = "nTaxPct" value="${advContractData.nTaxPct }"/>
											</label>
										</div>
									</div>
								</div>
								 
								
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6">
											    <span class="col-xs-4 input-tips">税别：</span>
											<div class="col-xs-7 dropdown-wrap">
											    <input type="hidden" id="sTaxTypeID" name="sTaxTypeID" value="${advContractData.sTaxTypeID }"/>
											    <input type="hidden" id="sTaxType" name="sTaxType" value="${advContractData.sTaxType }"/>
												<a id="sTaxType-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sTaxType-menu" class="dropdown-menu" aria-labelledby="sTaxType-btn">
										           								          	
										        </ul>										 
											</div>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											   <span class="col-xs-4 input-tips">交易方式：</span>
											   <input type="hidden" id="sTradeModeID" name="sTradeModeID" value="${advContractData.sTradeModeID }"/>
											   <input type="hidden" id="sTradeMode" name="sTradeMode" value="${advContractData.sTradeMode }"/>
											<div class="col-xs-7 dropdown-wrap">
												<a id="sTradeMode-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sTradeMode-menu" class="dropdown-menu" aria-labelledby="sTradeMode-btn">
										           
										        </ul>										 
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">付款账期：</span>
											<input type="hidden" id="sPaytTermID" name="sPaytTermID" value="${advContractData.sPaytTermID }"/>
											<input type="hidden" id="sPaytTerm" name="sPaytTerm" value="${advContractData.sPaytTerm }"/>
											<div class="col-xs-7 dropdown-wrap">
												<a id="sPaytTermID-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sPaytTermID-menu" class="dropdown-menu" aria-labelledby="sPaytTermID-btn"> 
										           
										        </ul>										 
											</div>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">付款方式：</span>
											<div class="col-xs-7 dropdown-wrap">
											 <input type="hidden" id="sPaytModeID" name="sPaytModeID" value="${advContractData.sPaytModeID }"/>
											 <input type="hidden" id="sPaytMode" name="sPaytMode" value="${advContractData.sPaytMode }"/>
												<a id="sPaytModeID-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sPaytModeID-menu" class="dropdown-menu" aria-labelledby="sPaytModeID-btn">
										           
										        </ul>										 
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">开户银行：</span>
											 <input type="hidden" id="sBank" name="sBank" value="${advContractData.sBank }"/> 

											<div class="col-xs-7 dropdown-wrap">
												<a id="sBankID-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sBankID-menu" class="dropdown-menu" aria-labelledby="sBankID-btn"> 
										           
										        </ul>										 
											</div>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">合同状态：</span>
											<div class="col-xs-7 dropdown-wrap">
											 <input type="hidden" id="nContractTag" name="nContractTag" value="${advContractData.nContractTag }"/> 
												<a id="nContractTag-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="nContractTag-menu" class="dropdown-menu" aria-labelledby="nContractTag-btn">
										           
										        </ul>										 
											</div>
										</div>
									</div>
								</div>
								 
								
							  <div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">银行账户：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text" name="sBankAccount" id="sBankAccount" value="${advContractData.sBankAccount }"/>
												
											</label>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">银行账号：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text" name="sBankAccountNO" id="sBankAccountNO" value="${advContractData.sBankAccountNO }" maxlength="24"/>
											</label>
										</div>
									</div>
								</div> 
								 
								 <div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">付款天数：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text" name="nPaytDay" id="nPaytDay" value="${advContractData.nPaytDay }"/>
											</label>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">付款联系人：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text" name="sPaytContact" id="sPaytContact" value="${advContractData.sPaytContact }"/>
											</label>
										</div>
									</div>
								</div>
								
								
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">联系电话：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text" name="sPaytContactTel" id="sPaytContactTel" value="${advContractData.sPaytContactTel }" onkeyup="(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)" onblur="this.v();" maxlength="11"/>
											</label>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">付款中心：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text" name="sPaytCenterNO" id="sPaytCenterNO" value="${advContractData.sPaytCenterNO }"/>
											</label>
										</div>
									</div>
								</div>
								
								
								
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">备注：</span>
										<label class="col-xs-7 col-sm-10 dropdown-wrap">
											<textarea class="border border-radius bg-color" rows="6" name="sMemo" id="sMemo">${advContractData.sMemo }</textarea>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2"></span>
										<label class="col-xs-7 col-sm-10">
											<input id="submit" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="提交" />
											<input id="cancel" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="取消" />
										</label>
									</small>
								</p>
							</form>
						</div> 
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>	 
