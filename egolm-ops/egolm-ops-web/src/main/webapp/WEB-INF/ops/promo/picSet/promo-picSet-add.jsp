<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="促销背景新增"  currentTopMenu="促销管理" currentSubMenu="促销背景新增" css="css/report-add.css" js="" localCss="" localJs="promo/promo-picSet-add.js,media/media-base.js,jscolor.min.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/promo/picSet/promo-picSet-add.jsp">

				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="#">促销管理</a> &gt; 
 								<c:if test="${not empty promoPicSetData.nId}">
								<a class="active" href="${webHost}/promoPicSet/loadIndex?nId=${promoPicSetData.nId}">编辑报表数据</a>
								</c:if>
								<c:if test="${empty promoPicSetData.nId}">
								<a class="active" href="${webHost}/promoPicSet/addIndex">新增报表数据</a>
								</c:if>
							</p>
						</div>
						
						<div class="addReport"> <!--报表数据管理 -->
						
							<form action ="",method="post" id="promoPicSetFrom" name="promoPicSetFrom" onsubmit = "return check();" enctype="multipart/form-data"  >
							 <input type="hidden" name="nId" id="nId" value="${promoPicSetData.nId }"/>
							 <div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">区域：</span>
												<input type="hidden" name="sOrgNO" id="sOrgNO"  value="${promoPicSetData.sOrgNO}"/>
												<input type="hidden" name="sOrgDesc" id="sOrgDesc" value="${promoPicSetData.sOrgDesc }"/>
											<div class="col-xs-7 dropdown-wrap">
 												<a id="sOrgNO-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sOrgNO-menu" class="dropdown-menu" aria-labelledby="sOrgNO-id">
										          		 
										        </ul>										 
											</div>
										</div>
										 
									</div>
								</div>
								<%--  <div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">店铺类型：</span>
												<input type="hidden" name="sScopeTypeID" id="sScopeTypeID"  value="${promoPicSetData.sScopeTypeID}"/>
												<input type="hidden" name="sScopeType" id="sScopeType" value="${promoPicSetData.sScopeType }"/>
											<div class="col-xs-7 dropdown-wrap">
 												<a id="sScopeType-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sScopeType-menu" class="dropdown-menu" aria-labelledby="sScopeType-id">
										          		 
										        </ul>										 
											</div>
										</div>
										 
									</div>
								</div> --%>
								
								 <div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">使用范围：</span>
												<input type="hidden" name="sDisplayNO" id="sDisplayNO"  value="${promoPicSetData.sDisplayNO}"/>
												<input type="hidden" name="sDisplayDesc" id="sDisplayDesc" value="${promoPicSetData.sDisplayDesc }"/>
											<div class="col-xs-7 dropdown-wrap">
 												<a id="sDisplayNO-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sDisplayNO-menu" class="dropdown-menu" aria-labelledby="sDisplayNO-id">
										          		 <li value="web">WEB端</li>
										          		<li value="wx">微信端</li>
										          		 <li value="app">APP端</li> 
										        </ul>										 
											</div>
										</div>
										 
									</div>
								</div>
								
								<div class="row">
									<div class="pic-wrap col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="tips-txt col-xs-4 col-sm-2">背景图片：</span>
										<label class="pic-box bg-color border border-radius">
										
											<c:if test="${not empty promoPicSetData.sBackgroundPicUrl}">
											<img src="http://img.egolm.com/${promoPicSetData.sBackgroundPicUrl}"  width="162px" height="162px" id="pic-src-id">
											</c:if>
											<c:if test="${empty promoPicSetData.sBackgroundPicUrl}">
											<img src="${resourceHost}/images/upload-add.png"  width="44px" height="44px" id="pic-src-id">
											</c:if>
											 
											<input type="file" name="sBackgroundPicUrl" id="sBackgroundPicUrl" onchange="preview(this)" value="${promoPicSetData.sBackgroundPicUrl}">												
										</label>
									</div>
								</div>
							 
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">背景色：</span>
										<label class="col-xs-7 col-sm-10 dropdown-wrap">
											<input class="border border-radius bg-color jscolor" type="text"  name = "sBackgroundColour" id = "sBackgroundColour" value="${promoPicSetData.sBackgroundColour }"   />
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
