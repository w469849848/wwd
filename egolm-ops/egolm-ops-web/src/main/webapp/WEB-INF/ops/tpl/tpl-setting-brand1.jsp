<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="模板设置" currentTopMenu="" currentSubMenu="" css="" js="" localCss="tpl/tpl-setting.css,tpl/index.css,tpl/banner.css,tpl/common.css,tpl/header.css,tpl/reset.css,tpl/tpl-manage.css" localJs="jquery.form.js,tpl/Sortable.min.js,tpl/tpl-setting.js,tpl/jquery.SuperSlide.2.1.1.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-setting-brand1.jsp">

<script type="text/javascript">
var JsonData = '${json}';
var JsonApID = '${JsonApID}';
</script>

<div class="main-content">
	<div class="page-content">
		<div class="wh_titer">
			<p class="wh_titer_f">
				您的位置：
				<a href="${webHost}/index">首页</a> &gt; 
				<a href="${webHost }/template/list">模板管理</a> &gt; 
				<a class="active" href="#">模板设置</a>
			</p>
		</div>
		
		
		
	<div class="tpl table-box">
	
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
					<input type="hidden" id="sBelongNo" name="sBelongNo" value="${sBelongNo }"/>
					<input type="hidden" id="sLinkNo" name="sLinkNo" value="${sLinkNo }"/>
					<input type="hidden" id="sLayoutContent" name="sLayoutContent" value=""/>
				</form>
				
				<!--推荐品牌模块-->
				<div class="rd-brand-module tab-2">
					
					<!--中部楼层-->
					<div class="content pr">
						<div class="brand-wrap">
															
							<!--品牌条 新-->
							<div class="brand pw pr ma mb-20" id="brand" adPos="" brand="">
								<div class="mask">
									<a class="edit-tips" href="javascript:void(0)" onclick="popSelectBrand(16,'${sBelongNo}')"><img src="${resourceHost}/images/tpl/edit-tips.png"/></a>
								</div>
								<div class="brand-nav clearfix">
									<div class="fl clearfix tit"><i class="icon-hot fl"><img src="${resourceHost}/images/tpl/icon-hot.png"></i><span class="fl">热门品牌</span></div>
									<div class="fr"><a href="#">更多&gt;&gt;</a></div>
								</div>
								
								<ul class="clearfix">
									<li class="ap-sign">
										<div class="brand-item pr">
											<div class="mask">
												<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(297,179,'ap_L','${sBelongNo }','${sDisplayNo}','${sScopeTypeID }')" ><img src="${resourceHost}/images/tpl/edit-tips.png"/></a>
												<span class="size">297 × 179（PX）</span>
											</div>
											<div class="item-wrap">
												<%-- <a href="#"><img src="${resourceHost}/images/tpl/brand/item1.jpg" /></a> --%>
											</div>
										</div>
									</li>
									<%-- <li class="brand-sign">
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
									</li>
									<li class="brand-sign">
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
									</li>
									<li class="brand-sign">
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
									</li>
									<li class="brand-sign">
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
									</li>
									<li class="brand-sign">
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
									</li>
									<li class="brand-sign">
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
									</li>
									<li class="brand-sign">
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
									</li>
									<li class="brand-sign">
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
										<div class="brand-item">
											<a href="#"><img src="${resourceHost}/images/tpl/brand/item2.jpg"/></a>
										</div>
									</li> --%>
								</ul>
								
							</div>
							
						</div>
					</div>
					
					<div class="btn-wrap">
						<label class="btn-submit"><input type="button" value="提交" onclick="packageJson()" /></label>
						<label class="btn-cancel"><input id="cancelButton" type="button" value="取消" onclick="location.href='${egolmHost}${serverName}/template/list'"/></label>
						<label class="btn-preview pull-right"><input type="button" value="生成预览"  onclick="window.open('${webHost}/template/preview?sTplNo=${sTplNo }')"/></label>
					</div>
					
				</div>
				
		</div>
	</div>
</div>
	</div><!-- /.page-content -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tpl/tpl-setting-brand1.js"></script>
</e:point>