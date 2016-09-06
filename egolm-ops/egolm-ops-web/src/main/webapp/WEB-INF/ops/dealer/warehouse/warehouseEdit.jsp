<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="仓库管理"  currentTopMenu="基础资料编辑" currentSubMenu="" css="css/warehouseEdit.css" js="" localCss="" localJs="dealer/warehouse/warehouse-base.js,dealer/warehouse/warehouseEdit.js" /> 
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/dealer/warehouse/warehouseEdit.jsp">

					<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="warehouseList">仓库管理</a> &gt; 
								<a class="active" href="warehouseEdit">基础资料编辑</a>
							</p>
						</div>
						<div class="add-box">
							<form action="",method="post" id="warehouseFrom" name="warehouseFrom" onsubmit = "return check();">
								<input type="hidden" id="type" name="type" value="${type }" />
								<input type="hidden" id="nAgentID" name="nAgentID" value="${data.nAgentID}" />
								<div class="warehouse-addr">
									<h1>仓库信息</h1>
									<p class="line"></p>
									<div class="addr-box">
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">仓库编号：</span>
													<label class="col-xs-7">
														<c:if test="${type eq 'edit' }">
															<input type="hidden" id="sWarehouseNO" name="sWarehouseNO" value="${data.sWarehouseNO}" />
															${data.sWarehouseNO}
														</c:if>
														<c:if test="${type eq 'add' }">
															<input id="sWarehouseNO" name="sWarehouseNO" class="border border-radius bg-color" type="text" value="" />
														</c:if>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">仓库名称：</span>
													<label class="col-xs-7">
														<input id="sWarehouseName" name="sWarehouseName" class="border border-radius bg-color"
											type="text" value="${data.sWarehouseName}" />
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">最小起订金额：</span>
													<label class="col-xs-7">
														<input id="nMinDCAmount" name="nMinDCAmount" class="border border-radius bg-color" type="text"
											value="${data.nMinDCAmount}" />
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">所属经销商：</span>
													<label class="col-xs-7">
														<c:if test="${type eq 'edit' }">
															${data.sAgentName}
														</c:if>
														<c:if test="${type eq 'add' }">
															<div class="select-wrap">
																<input id="nAgentIDSel" name="nAgentIDSel" class="border-radius" type="text" disabled="disabled" value="请选择">
																<span id="seletAgent" class="dr"><img src="${resourceHost}/images/icon-select.png"></span>
															</div>
														</c:if>
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">省：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="province" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
												          	<span id="provinceSpan">请选择</span>
												          	<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
												        </a>
												        <input type="hidden" id="sProvince" name="sProvince" value="${data.sProvince}"/>
												        <input type="hidden" id="sProvinceID" name="sProvinceID" value="${data.sProvinceID}" />
												        <ul id="province-menu" class="dropdown-menu" aria-labelledby="province">
												          	 <c:if test="${!empty provinceDatas}">
                               							 		<c:forEach items="${provinceDatas}" var="province">
                                    								<li value="${province.sRegionNO}">${province.sRegionDesc}</li>
                                						 		</c:forEach>
                            						 		</c:if>
												        </ul>
													</div>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">市：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="city" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
												          	<span id="citySpan">请选择</span>
												          	<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
												        </a>
												        <input type='hidden' id="sCity" name="sCity"  value="${data.sCity}" />
												        <input type='hidden' id="sCityID" name="sCityID" value="${data.sCityID}" />
												        <ul id="city-menu" class="dropdown-menu" aria-labelledby="city">
												        </ul>
													</div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">行政区：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="district" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
												          	<span id="districtSpan">请选择</span>
												          	<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
												        </a>
												        <input type='hidden' id="sDistrict" name="sDistrict" value="${data.sDistrict}" />
												        <input type='hidden' id="sDistrictID" name="sDistrictID" value="${data.sDistrictID}" />
												        <ul id="district-menu" class="dropdown-menu" aria-labelledby="district">
												        </ul>
													</div>
												</div>
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">地址：</span>
													<label class="col-xs-7">
														<input id="sAddress" name="sAddress" class="border border-radius bg-color" type="text"
											value="${data.sAddress}" />
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">仓库类型：</span>
													<div class="col-xs-7 dropdown-wrap">
														<a id="whType" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
												          	<span id="whTypeSpan">请选择</span>
												          	<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"/></span>
												        </a>
												        <input type='hidden' id="sWarehouseType" name="sWarehouseType" value="${data.sWarehouseType}" />
												        <input type='hidden' id="sWarehouseTypeID" name="sWarehouseTypeID" value="${data.sWarehouseTypeID}" />
												        <ul id="whType-menu" class="dropdown-menu" aria-labelledby="whType">
												         	<c:if test="${!empty whType}">
                               							 		<c:forEach items="${whType}" var="whType">
                                    								<li value="${whType.sComID}">${whType.sComDesc}</li>
                                						 		</c:forEach>
                            						 		</c:if>
												        </ul>
													</div>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">配送区域：</span>
													<div class="col-xs-7 dropdown-wrap">
														<div class="select-wrap">
															<input value="${deliverRegionID }" id="deliverRegion" name="deliverRegion" type="hidden" /> 
															<input value="${deliverRegionName }" id="deliverRegionDesc" name="deliverRegionDesc" type="hidden" />
															<c:if test="${deliverRegionName eq '' || deliverRegionName eq null}">
																<input id="deliverRegionSel" name="deliverRegionSel" class="border-radius" type="text" disabled="disabled" value="请选择">
															</c:if>
															<c:if test="${deliverRegionName ne '' && deliverRegionName ne null}">
																<input id="deliverRegionSel" name="deliverRegionSel" class="border-radius" type="text" disabled="disabled" value="${deliverRegionName }">											
															</c:if>
															<span id="seletDistrict" class="dr"><img src="${resourceHost}/images/icon-select.png"></span>
														</div>
													</div>
												</div>
											</div>
										</div>
										<p class="row">
											<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<span class="col-xs-4 col-sm-2">备注：</span>
												<label class="col-xs-7 col-sm-9">
													<textarea id="sMemo" name="sMemo" class="border border-radius bg-color" rows="4"
											value="${data.sMemo}"></textarea>
												</label>
											</small>
										</p>
									</div>
								</div>
								
								<p class="row">
									<label class="col-xs-12">
										<input id="submit" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="保存"/>
										<input id="cancel" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="取消"/>
									</label>
								</p>
							</form>
						
						</div>
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			 
		<script type="text/javascript">
			$(document).ready(function() {
				initSelect();
			});
			function initSelect(){
				//经销商类别
				$("#agenttypeSpan").text("${data.SAgentType}");
				//省
				$("#provinceSpan").text("${data.SProvince}");
				//市
				$("#citySpan").text("${data.SCity}");
				//区域
				$("#districtSpan").text("${data.SDistrict}");
			}
		</script>
</e:point>