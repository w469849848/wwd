<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
 
<e:resource title="广告管理"  currentTopMenu="广告管理" currentSubMenu="" css="css/add-media-content.css" js="" localCss="" localJs="media/add-media-content.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/media/add-media-content.jsp">
 

				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/media/mediaContext/list">广告管理</a> &gt; 
								<c:if test="${not empty adVertData.nAdID}">
								<a class="active" href="${webHost}/media/mediaContext/loadMsgById?id=${adVertData.nAdID}">广告编辑</a>
								</c:if>
								<c:if test="${empty adVertData.nAdID}">
								<a class="active" href="${webHost}/media/mediaContext/addIndex">广告新增</a>
								</c:if>
								
							</p>
						</div>
						
						<div class="advertisement"> <!-- 广告管理 -->
							<form action ="",method="post" id="adVertFrom" name="adVertFrom" onsubmit = "return check();"  enctype="multipart/form-data" >								
								<input type="hidden" name="nAdClickNum" id = "nAdClickNum" value="0">
								<input type="hidden" name="nAdGold" id = "nAdGold" value="0">
								<input type="hidden" name="nAdID"  id = "nAdID" value="${adVertData.nAdID}">
								
								<input type="hidden" name="nAgentID" id = "nAgentID"  value="${adVertData.nAgentID }">
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">广告名称：</span>
										<label class="col-xs-7 col-sm-9 dropdown-wrap">
											<input class="border border-radius bg-color" type="text" name="sAdTitle" id = "sAdTitle" value="${adVertData.sAdTitle}"/>
 										</label>
									</small>
								</p>
								
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">广告区域：</span>
											<div class="col-xs-7 dropdown-wrap"> 
											    <input type="hidden" name="sAdZoneCodeID" id = "sAdZoneCodeID" value="${adVertData.sAdZoneCodeID }">
												<input type="hidden" name="sAdZoneCode" id = "sAdZoneCode" value="${adVertData.sAdZoneCode }">
												<a id="sAdZoneCode-area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sAdZoneCode-area-menu" class="dropdown-menu" aria-labelledby="sAdZoneCode-area-btn">
										          	   
										        </ul>
												
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 col-sm-3 input-tips">合同编号：</span>
											<div class="col-xs-7 dropdown-wrap">
												<input type="hidden"  name="nContractID" id = "nContractID" value="${adVertData.nContractID }">
											    <input type="hidden"  name="sContractNO"   id = "sContractNO" value="${adVertData.sContractNO }">
												<a id="sContractID-area-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sContractID-area-menu" class="dropdown-menu" aria-labelledby="sContractID-area-id">
										          	 
										        </ul>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">广告位置：</span>
											<div class="col-xs-7 dropdown-wrap"> 
											<input type="hidden"  name="sApSaleTypeID"  id = "sApSaleTypeID" value="${adVertData.sApSaleTypeID }">
											<input type="hidden"   id = "sApSaleType" value="${adVertData.sApSaleType }">
												<a id="sApSaleType-area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span >请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sApSaleType-area-menu" class="dropdown-menu" aria-labelledby="sApSaleType-area-btn">
										           <!-- 	<li value="wx">微信广告位</li>
										          	<li value="web">WEB广告位</li>
										          	<li value="app">APP广告位</li>   -->
										        </ul>
											</div>
										</div>
								<%-- 		<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 col-sm-3 input-tips">广告位：</span>
											<div class="col-xs-7 dropdown-wrap">
												<input type="hidden" name="nApID" id = "nApID" value="${adVertData.nApID }">
												<input type="hidden"  id = "Aptitle" value="${adVertData.sApTitle }"> 
												<a id="ap-place-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span class="item-name">请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="ap-place-menu" class="dropdown-menu" aria-labelledby="ap-place-id">
										          	 
										        </ul>
											</div>
										</div> --%>
										
										<div class="col-xs-12 col-sm-6" >
											<span class="col-xs-4 col-sm-3 input-tips" >广告位：</span>
											
											<div class="col-xs-7 dropdown-wrap">
												 <div class="select-wrap">
													<input type="hidden" name="nApID" id = "nApID" value="${adVertData.nApID }">
													<input type="text" class="border-radius" id = "sApTitle" value="${adVertData.sApTitle }"  readonly="readonly" placeholder="请选择" > 
													<span class="dr" id="seletAdPosNO"><img src="${resourceHost}/images/icon-select.png"/></span>
												 </div>
											</div>
										</div>
									</div>
								</div>
								 
								
								<div class="row"> 
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">开始时间：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text" name="dAdBeginTime" id = "dAdBeginTime" value="<fmt:formatDate value="${adVertData.dAdBeginTime}" pattern="yyyy-MM-dd" />"/>
												<span class="dr"><img src="${resourceHost}/images/arrow-black.png"></span>
											</label>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4  col-sm-3  input-tips">结束时间：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text" name="dAdEndTime" id = "dAdEndTime" value="<fmt:formatDate value="${adVertData.dAdEndTime}" pattern="yyyy-MM-dd" />"/>
											  <span class="dr"><img src="${resourceHost}/images/arrow-black.png"></span>
											</label>
										</div>
									</div>
								</div>
								<div class="row">
								
								   <input type="hidden" id = "nApWidth" value="${adVertData.nApWidth}"/>
								   <input type="hidden" id = "nApHeight" value="${adVertData.nApHeight}"/>
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">广告宽度：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text"  name="nAdWidth"  id="nAdWidth"  value="${adVertData.nAdWidth}"/>
											</label>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 col-sm-3 input-tips">广告高度：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text"   name="nAdHeight"  id="nAdHeight" value="${adVertData.nAdHeight}"/>
											</label>
										</div>
									</div>
								</div>
								 
								<p class="row" id="sAdText-text-id" style="display: none;">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">广告文本：</span>
										<label class="col-xs-7 col-sm-9 dropdown-wrap">
											<input class="border border-radius bg-color" type="text"   name="sAdText" id="sAdText" value="${adVertData.sAdText }"/>
										</label>
									</small>
								</p> 
								
								
								<input type="hidden"  id = "sAdJumpTypeId_now"  value="${adVertData.sAdJumpTypeId}">
								<input type="hidden"  id = "sAdJumpType_now"  value="${adVertData.sAdJumpType}">
								<input type="hidden"  id = "sAdJumpNo_now"  value="${adVertData.sAdJumpNo}">
								<input type="hidden"  id = "sAdJumpName_now"  value="${adVertData.sAdJumpTypeName}">
								
								
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">广告链接类型：</span>
											  <input type="hidden" name="sAdJumpTypeId" id = "sAdJumpTypeId"  value="${adVertData.sAdJumpTypeId}">
											  <input type="hidden" name="sAdJumpType" id = "sAdJumpType"  value="${adVertData.sAdJumpType }"> 
											<div class="col-xs-7 dropdown-wrap"> 
 												<a id="ad-jump-type-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span class="item-name">请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="ad-jump-type-menu" class="dropdown-menu" aria-labelledby="ad-jump-type-id">
										          	<li value="goods">商品</li>
										          	<li value="brand">品牌</li>
										          	<li value="activity">活动</li>
										          	<li value="other">外部链接</li>
										          	<li value="internalLink">内部链接</li>
										        </ul>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6" id="ad_jump_id">
											<span class="col-xs-4 col-sm-3 input-tips" id="typeName-id">链接商品:</span>
											
											<div class="col-xs-7 dropdown-wrap">
												<div class="select-wrap">
													<input type="hidden" name="sAdJumpNo" id = "sAdJumpNo" value="${adVertData.sAdJumpNo}" > 
													<input type="text"  class="border-radius" name="sAdJumpName" id = "sAdJumpName" value="${adVertData.sAdJumpTypeName}" readonly="readonly" placeholder="请选择" > 
													<span class="dr" id="seletAdVertNO"><img src="${resourceHost}/images/icon-select.png"/></span>
												</div>
 											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">是否显示商品信息：</span>
											  <input type="hidden" name="nAdShowGoodsMsgID" id = "nAdShowGoodsMsgID"  value="${adVertData.nAdShowGoodsMsgID}">
											  <input type="hidden" name="sAdShowGoodsMsg" id = "sAdShowGoodsMsg"  value="${adVertData.sAdShowGoodsMsg }"> 
											<div class="col-xs-7 dropdown-wrap"> 
 												<a id="sAdShowGoodsMsg-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sAdShowGoodsMsg-menu" class="dropdown-menu" aria-labelledby="sAdShowGoodsMsg-id">
										          	 <li value="1">显示</li>
										          	 <li value="0">不显示</li>
										        </ul>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 col-sm-3 input-tips" id="typeName-id"></span>
											<div class="col-xs-7 dropdown-wrap">
												 
											</div>
										</div>
									</div>
								</div>
								
								
								<p class="row" id="default-url-id" style="display: none;">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">广告连接：</span>
										<label class="col-xs-7 col-sm-9 dropdown-wrap">
											<input class="border border-radius bg-color" type="text" placeholder="http://"  name="sAdJumpUrl" id="sAdJumpUrl" value="${adVertData.sAdJumpUrl }"/>
										</label>
									</small>
								</p>
								
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">广告批次：</span>
											<label class="col-xs-6 col-sm-6 dropdown-wrap">
											<input class="border border-radius bg-color" type="text"   name="nBID" id="nBID" value="${adVertData.nBID }"/>
											 
										</label>
										</div>
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 col-sm-3 input-tips">幻灯片序号：</span>
											<label class="col-xs-6 col-sm-6 dropdown-wrap">
											<input class="border border-radius bg-color" type="text" name="nAdSlideSequence" id="nAdSlideSequence" value="${adVertData.nAdSlideSequence }"/>
											 
										   </label>
										</div>
									</div>
								</div>
								
								
								<div class="row">
									<div class="pic-wrap col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="tips-txt col-xs-4 col-sm-2">广告图片：</span>
										<label class="pic-box bg-color border border-radius">
										
											<c:if test="${not empty adVertData.sAdPathUrl}">
											<img src="http://img.egolm.com/${adVertData.sAdPathUrl}"  width="162px" height="162px" id="pic-src-id">
											</c:if>
											<c:if test="${empty adVertData.sAdPathUrl}">
											<img src="${resourceHost}/images/upload-add.png"  width="44px" height="44px" id="pic-src-id">
											</c:if>
											 
											<input type="file" name="sAdPathUrl" id="sAdPathUrl" onchange="preview(this)">												
										</label>
									</div>
								</div>
							 
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2"></span>
										<label class="col-xs-7 col-sm-9">
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

