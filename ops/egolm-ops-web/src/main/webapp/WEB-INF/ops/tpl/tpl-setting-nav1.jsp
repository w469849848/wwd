<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>

<e:resource title="模板设置" currentTopMenu="" currentSubMenu="" css="" js="" localCss="tpl/tpl-setting.css,tpl/index.css,tpl/banner.css,tpl/common.css,tpl/header.css,tpl/reset.css,tpl/tpl-manage.css" localJs="jquery.form.js,tpl/Sortable.min.js,tpl/tpl-setting.js,tpl/jquery.SuperSlide.2.1.1.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-setting-nav1.jsp">
<div class="main-content">
<script type="text/javascript">
    var JsonData = '${json}';
    var JsonApID = '${JsonApID}';
	var adPos_M = {};
	var adPos_R = {};
	/* var categoryArray = []; */
	var zoneNav = [];
</script>

	<div class="page-content">
		
		<div class="wh_titer">
			<p class="wh_titer_f">
				您的位置：
				<a href="${webHost}/index">首页</a> &gt; 
				<a href="${webHost }/template/list">模板管理</a> &gt; 
				<a class="active" href="#">模板设置</a>
			</p>
		</div>
		
		<div class="tpl table-box"> <!-- 模板设置 -->
			
			<div class="tpl-nav">
				<ul class="clearfix">
					<c:forEach items="${moduleList}" var="module" varStatus="i">
						<c:if test="${module.SLinkNo eq sLinkNo }">
							<li class="active"><a href="${egolmHost }${serverName }/${module.SBgPath }?sLinkNo=${module.SLinkNo}">${module.SModName }</a></li>
						</c:if>
						<c:if test="${module.SLinkNo ne sLinkNo }">
							<li><a href="${egolmHost }${serverName }/${module.SBgPath }?sLinkNo=${module.SLinkNo}">${module.SModName }</a></li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
			
			<div class="tpl-content">
				<form id="tplSettingForm" action="${webHost}/template/setting/saveJson" method="post">
					<input type="hidden" id="sTplNo" name="sTplNo" value="${sTplNo }"/>
					<input type="hidden" id="sBelongNo" name="sBelongNo" value="${sBelongNo }"/>
					<input type="hidden" id="sLinkNo" name="sLinkNo" value="${sLinkNo }"/>
					<input type="hidden" id="sLayoutContent" name="sLayoutContent" value=""/>
				</form>
				
				<!--导航模块-->
				<div class="nav-module tab-1">
					
					<!--顶部导航-->
					<div class="header">
						
						<!--商品分类-->
						<div class="header-nav-wrap">
							<div class="header-nav ma pw clearfix pr">
								<div class="fl pr sort-wrap">
									<a class="pr" href="javascript:void(0)">${sScopeType }</a>
									
									<div class="sort" id="category">
										<%-- <div class="mask">
											<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
										</div> --%>
										<ul class="clearfix">
											<c:forEach items="${categorylist}" var="cate1">
												<li>
													<div class="sort-title">
														<a href="#" id="${cate1.id }">${cate1.name }</a>
														<span class="dr"></span>
													</div>
													<c:if test="${not empty cate1.children}">
														<div class="sort-content hide">
															<div class="sort-list clearfix">
																<c:forEach items="${cate1.children}" var="cate2">
																	<h1 class="fl"><a href="#" id="${cate2.id }">${cate2.name }</a></h1>
																	<c:if test="${not empty cate2.children}">
																		<ul class="clearfix fl">
																			<c:forEach items="${cate2.children}" var="cate3">
																				<li><a href="#" id="${cate3.id }">${cate3.name }</a></li>
																			</c:forEach>
																		</ul>
																	</c:if>
																</c:forEach>
															</div>
														</div>
													</c:if>
												</li>
											</c:forEach>
										</ul>
									</div>
								
								</div>
								
								<div class="mask-wrap fl pr" id="nav">
									<div class="mask">
										<a class="edit-tips" href="javascript:void(0)" onclick="popSectionNavigation('${sBelongNo}','${sTplNo }','1')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
									</div>
									<ul class="clearfix">
										<!-- <li><a class="active" href="#">首页</a></li> -->
									</ul>
								</div>
							
							</div>
						
						</div>
						
					</div>

					<!--中部楼层-->
					<div class="content ma pr">
						
						<div class="banner-box pr">
							
							<!--banner-->
							<div class="banner" id="ap_M" ap_M="">
								<div class="mask">
									<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(1210,456,'ap_M','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
									<span class="size">1210 × 456（PX）</span>
								</div>
								<div class="item-wrap">
									<a href="#"><img src="${resourceHost }/images/tpl/banner.jpg"></a>
								</div>
							</div>
							
							<!--新闻 公告-->
							<div class="notice">
								<ul class="clearfix">
									<li>
										<a class="pr" href="javascript:void(0)">
											<i class="icon icon-order"></i>
											<div>
												<h1>一键订货</h1>
												<span>我是一段文字代替</span>
											</div>
										</a>
									</li>
									<li>
										<a class="pr" href="javascript:void(0)">
											<i class="icon icon-brand"></i>
											<div>
												<h1>品牌专区</h1>
												<span>我是一段文字代替</span>
											</div>
										</a>
									</li>
									<li>
										<a class="pr" href="javascript:void(0)">
											<i class="icon icon-promotion"></i>
											<div>
												<h1>促销特惠</h1>
												<span>我是一段文字代替</span>
											</div>
										</a>
									</li>
								</ul>
								<div class="notice-ad pr" id="ap_R" ap_R="">
									<div class="mask">
										<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(248,274,'ap_R','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
										<span class="size">248 × 274（PX）</span>
									</div>
									<div class="notice-ad-item">
										<a href="#"><img src="${resourceHost }/images/tpl/advertise/notice-ad.jpg"/></a>
									</div>
								</div>
							</div>
						</div>
					
					</div>
					
					<div class="btn-wrap">
						<label class="btn-submit"><input type="button" value="提交" onclick="packageJson()" /></label>
						<label class="btn-cancel"><input  id="cancelButton" type="button" value="取消" onclick="location.href='${egolmHost}${serverName}/template/list'"/></label>
						<label class="btn-preview pull-right"><input type="button" value="生成预览"  onclick="window.open('${webHost}/template/preview?sTplNo=${sTplNo }')"/></label>
					</div>
					
				</div>
				
			</div>
		</div>
		
		
		
	</div><!-- /.page-content -->
</div><!-- /.main-content -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tpl/tpl-setting-nav1.js"></script>
</e:point>