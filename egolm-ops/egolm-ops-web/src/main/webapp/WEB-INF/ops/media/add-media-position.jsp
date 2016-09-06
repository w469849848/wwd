<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="广告位管理"  currentTopMenu="广告管理" currentSubMenu="广告位管理" css="css/add-media-position.css" js="" localCss="" localJs="media/add-media-position.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/media/add-media-position.jsp">

				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/media/mediaPos/list">广告位管理</a> &gt;  
								<c:if test="${not empty adPosData.nApID}">
									<a class="active" href="${webHost}/media/mediaPos/loadMsgByID?id=${adPosData.nApID}">编辑广告位</a>
								</c:if>
								<c:if test="${empty adPosData.nApID}">
								  	<a class="active" href="${webHost}/media/mediaPos/addIndex"> 新增广告位</a>
								</c:if>
								
								
								
							</p>
						</div>
						
						<div class="advertisement"> <!-- 广告管理 -->
						
							<form action ="",method="post" id="adPosFrom" name="adPosFrom" onsubmit = "return check();"  enctype="multipart/form-data"  >
								<input type="hidden" name="nApID" value = "${adPosData.nApID }"/>
 								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">广告位名称：</span>
										<label class="col-xs-7 col-sm-10 dropdown-wrap">
											<input class="border border-radius bg-color" type="text"  name = "sApTitle" id = "sApTitle" value = "${adPosData.sApTitle}"/>
											<!-- <span class="txt-limt"><span>0</span>/40</span> -->
										</label>
									</small>
								</p>
								
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">广告位简介：</span>
										<label class="col-xs-7 col-sm-10 dropdown-wrap">
											<textarea class="border border-radius bg-color" rows="6" name="sApContent" id="sApContent">${adPosData.sApContent}</textarea>
										</label>
									</small>
								</p> 
							 
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">广告位价格：</span>
											<label class="col-xs-7"> 
												<input class="border border-radius bg-color" type="text" name="nApPrice" id="nApPrice" value="<fmt:formatNumber value="${adPosData.priceYuan}" pattern="0.00"/>"/>
											    <span class="txt-limt"><span>单位:元/天</span></span>
											</label>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">店铺类型：</span>
											<label class="col-xs-7">
												<input type="hidden" name ="sScopeTypeID" id="sScopeTypeID" value="${adPosData.sScopeTypeID}"/> 
											    <input type="hidden" name ="sScopeType" id="sScopeType" value="${adPosData.sScopeType}"/> 
												<a id="sScopeType-area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span> 
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sScopeType-area-menu" class="dropdown-menu" aria-labelledby="sScopeType-area-btn">
										          	 
										        </ul>
											</label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">广告位宽度：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text"  name="nApWidth"  id="nApWidth"  value="${adPosData.nApWidth}"/>
											</label>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">广告位高度：</span>
											<label class="col-xs-7">
												<input class="border border-radius bg-color" type="text"   name="nApHeight"  id="nApHeight" value="${adPosData.nApHeight}"/>
											</label>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">广告位类型：</span>
											<div class="col-xs-7 dropdown-wrap">
											<input type="hidden" name ="sApSaleTypeID" id="sApSaleTypeID" value="${adPosData.sApSaleTypeID}"/> 
											<input type="hidden" name ="sApSaleType" id="sApSaleType" value="${adPosData.sApSaleType}"/> 
												<a id="sApSaleType-area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span> 
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sApSaleType-area-menu" class="dropdown-menu" aria-labelledby="sApSaleType-area-btn">
										          	 
										        </ul>										 
											</div>										
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">广告位类别：</span>
											<div class="col-xs-7 dropdown-wrap">
												<input type="hidden" name ="sApTypeID" id="sApTypeID" value="${adPosData.sApTypeID}"/> 
												<input type="hidden" name ="sApType" id="sApType" value="${adPosData.sApType}"/> 
												<a id="sApType-area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sApType-area-menu" class="dropdown-menu" aria-labelledby="sApType-area-btn">
										          	 
										        </ul>										 
											</div>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">区域：</span>
											<div class="col-xs-7 dropdown-wrap">
												<input type="hidden" name ="sZoneCodeID" id="sZoneCodeID" value="${adPosData.sZoneCodeID}"/> 
												<input type="hidden" name ="sZoneCode" id="sZoneCode" value="${adPosData.sZoneCode}"/> 
												<a id="sZoneCode-area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sZoneCode-area-menu" class="dropdown-menu" aria-labelledby="sZoneCode-area-btn">
										          		 
										        </ul>										 
											</div>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">展示方式：</span>
											<div class="col-xs-7 dropdown-wrap">
											<input type="hidden" name ="sApShowTypeID" id="sApShowTypeID" value="${adPosData.sApShowTypeID}"/> 
											<input type="hidden" name ="sApShowType" id="sApShowType" value="${adPosData.sApShowType}"/> 
												<a id="sApShowType-area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sApShowType-area-menu" class="dropdown-menu" aria-labelledby="sApShowType-area-btn">
										          	<li value="all">全部展示</li>
										          	<li value="rand">随机展示</li> 
										        </ul>										 
											</div>
										</div>
									</div>
								</div>
					                <input type="hidden" name ="sApSysTypeID" id="sApSysTypeID" value="${adPosData.sApSysTypeID}"/> 
									<input type="hidden" name ="sApSysType" id="sApSysType" value="${adPosData.sApSysType}"/> 
									<input type="hidden" name ="sApStatusID" id="sApStatusID" value="${adPosData.sApStatusID}"/>
									<input type="hidden" name ="sApStatus" id="sApStatus" value="${adPosData.sApStatus}"/> 
							<%-- 	<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">系统广告：</span>
											<div class="col-xs-7 dropdown-wrap">
												<input type="hidden" name ="sApSysTypeID" id="sApSysTypeID" value="${adPosData.sApSysTypeID}"/> 
												<input type="hidden" name ="sApSysType" id="sApSysType" value="${adPosData.sApSysType}"/> 
												<a id="sApSysType-salesman-type" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sApSysType-salesman-menu" class="dropdown-menu" aria-labelledby="sApSysType-salesman-type">
										          	<li value="1">是</li>
										          	<li value="0">否</li>
										        </ul>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6 second-input">
											<span class="col-xs-4 input-tips">是否启用：</span>
											<div class="col-xs-7 dropdown-wrap">
												<input type="hidden" name ="sApStatusID" id="sApStatusID" value="${adPosData.sApStatusID}"/>
												<input type="hidden" name ="sApStatus" id="sApStatus" value="${adPosData.sApStatus}"/> 
												<a id="sApStatus-royalty-way" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sApStatus-royalty-menu" class="dropdown-menu" aria-labelledby="sApStatus-royalty-way">
										          	<li value="1">启用</li>
										          	<li value="0">未启用</li>
										        </ul>
											</div>
										</div>
									</div>
								</div> --%>
								<p class="row" id="sApText-text-id" style="display: none;">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">广告位默认内容：</span>
										<label class="col-xs-7 col-sm-10 dropdown-wrap">
											<input class="border border-radius bg-color" type="text" name="sApText" id="sApText" value="${adPosData.sApText}"/>
										</label>
									</small>
								</p>
								<!-- <p class="row ad-tips">注：系统广告不可删除，主要处理上传预留广告位</p> -->
								
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">广告默认链接：</span>
										<label class="col-xs-7 col-sm-10 dropdown-wrap">
											<input class="border border-radius bg-color" type="text" placeholder="http://"  name = "sApJumpUrl" id ="sApJumpUrl" value="${adPosData.sApAccURL}"/>
										</label>
									</small>
								</p>
								
								<div class="row">
									<div class="pic-wrap col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="tips-txt col-xs-4 col-sm-2">广告位默认图：</span>
										<label class="pic-box bg-color border border-radius"> 
											<c:if test="${not empty adPosData.sApPathUrl}">
											<img src="http://img.egolm.com${adPosData.sApPathUrl}"  width="162px" height="162px" id="pic-src-id">
											</c:if>
											<c:if test="${empty adPosData.sApPathUrl}">
											<img src="${resourceHost}/images/upload-add.png"  width="44px" height="44px" id="pic-src-id">
											</c:if>
											
											<input type="file" name="sApPathUrl"  id="sApPathUrl" onchange="preview(this)">												
										</label>
										
									</div>
								</div>
								
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
