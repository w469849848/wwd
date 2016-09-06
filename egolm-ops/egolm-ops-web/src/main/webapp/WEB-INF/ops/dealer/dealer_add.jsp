<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="经销商新增"  currentTopMenu="经销商管理" currentSubMenu="新增经销商" css="css/add-dealer.css" js="" localCss="" localJs="dealer/dealer-base.js,dealer/add-dealer.js" /> 
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/dealer/dealer_add.jsp">

					<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="agentList">经销商管理</a> &gt; 
								<a class="active" href="agentAdd">新增经销商</a>
							</p>
						</div>
						
						<div class="add-box">
							
							<form action="",method="post" id="agentFrom" name="agentFrom" onsubmit = "return check();">
								
								<div class="dealer-info">
									<h1>经销商信息</h1>
									<p class="line"></p>
									<div class="info-box">
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">经销商名称：</span>
													<label class="col-xs-7">
														<input id="sAgentName" name="SAgentName" class="border border-radius bg-color" type="text" />
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">经销商抬头：</span>
													<label class="col-xs-7">
														<input id="sAgentTitle" name="SAgentTitle" class="border border-radius bg-color" type="text" />
													</label>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">联系人：</span>
													<label class="col-xs-7">
														<input id="sContact" name="sContact" class="border border-radius bg-color" type="text" />
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">电话：</span>
													<label class="col-xs-7">
														<input id="sTel" name="sTel" class="border border-radius bg-color" type="text" />
													</label>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">传真：</span>
													<label class="col-xs-7">
														<input id="sFax" name="sFax" class="border border-radius bg-color" type="text" />
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">手机：</span>
													<label class="col-xs-7">
														<input id="sMobile" name="sMobile" class="border border-radius bg-color" type="text" />
													</label>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">经销商类别：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="agenttype" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
												          	<span id="agenttypeSpan">请选择</span>
												          	<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
												        </a>
												        <input type="hidden" id="sAgentType" name="sAgentType" />
												        <input type="hidden" id="sAgentTypeID" name="sAgentTypeID" />
												        <ul id="agenttype-menu" class="dropdown-menu" aria-labelledby="agenttype">
												        </ul>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="dealer-addr">
									<h1>经销商地址</h1>
									<p class="line"></p>
									<div class="addr-box">
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">国家：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="country" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
												          	<span id="nationSpan">请选择</span>
												          	<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
												        </a>
												        <input type="hidden" id="sNation" name="sNation" />
												        <input type="hidden" id="sNationID" name="sNationID" />
												        <ul id="country-menu" class="dropdown-menu" aria-labelledby="country-way">
												          	<c:if test="${!empty nationDatas}">
                               								  	<c:forEach items="${nationDatas}" var="nation">
                                							 		<li><a id="${nation.sCode}" name="${nation.sCodeDesc}" onClick="loadNation(this)">${nation.sCodeDesc}</a></li>
                                							 	</c:forEach>
                            								</c:if>
												        </ul>
													</div>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">省：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="province" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
												          	<span id="provinceSpan">请选择</span>
												          	<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
												        </a>
												        <input type="hidden" id="sProvince" name="sProvince" value="" />
												        <input type="hidden" id="sProvinceID" name="sProvinceID" value="" />
												        <ul id="province-menu" class="dropdown-menu" aria-labelledby="province">
												          	 <c:if test="${!empty provinceDatas}">
                               							 		<c:forEach items="${provinceDatas}" var="province">
                                    								<li value="${province.sRegionNO}">${province.sRegionDesc}</li>
                                						 		</c:forEach>
                            						 		</c:if>
												        </ul>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">市：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="city" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
												          	<span id="citySpan">请选择</span>
												          	<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
												        </a>
												        <input type='hidden' id="sCity" name="sCity" />
												        <input type='hidden' id="sCityID" name="sCityID" />
												        <ul id="city-menu" class="dropdown-menu" aria-labelledby="city">
												        </ul>
													</div>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">行政区：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="district" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
												          	<span>请选择</span>
												          	<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
												        </a>
												        <input type='hidden' id="sDistrict" name="sDistrict" />
												        <input type='hidden' id="sDistrictID" name="sDistrictID" />
												        <ul id="district-menu" class="dropdown-menu" aria-labelledby="district">
												        </ul>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">地址：</span>
													<label class="col-xs-7">
														<input id="sAddress" name="sAddress" class="border border-radius bg-color" type="text" />
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">邮编：</span>
													<label class="col-xs-7">
														<input id="sPostalcode" name="sPostalcode" class="border border-radius bg-color" type="text" />
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">电子邮箱：</span>
													<label class="col-xs-7">
														<input id="sEmail" name="sEmail" class="border border-radius bg-color" type="text" />
													</label>
												</div>
											</div>
										</div>
										<p class="row">
											<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<span class="col-xs-4 col-sm-2">备注：</span>
												<label class="col-xs-7 col-sm-9">
													<textarea id="sMemo" name="sMemo" class="border border-radius bg-color" rows="4"></textarea>
												</label>
											</small>
										</p>
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
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>