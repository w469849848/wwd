<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>

<e:resource title="模板设置" currentTopMenu="" currentSubMenu="" css="" js="" localCss="tpl/tpl-setting.css,tpl/index.css,tpl/banner.css,tpl/common.css,tpl/header.css,tpl/reset.css,tpl/tpl-manage.css" localJs="jquery.form.js,tpl/Sortable.min.js,tpl/tpl-setting.js,tpl/jquery.SuperSlide.2.1.1.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-setting-floor1.jsp">
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
			
			<!--楼层商品类型一-->
			<div class="floor-goods-type1 tab-5">
				
				<!--中部楼层-->
				<div class="content pr">
					
					<div class="floor-wrap">
														
						<!--楼层1-->
						<div class="fes-activity floor floor1 pw ma mb-20">
							<div class="f-nav clearfix">
								<div class="pr fl f-icon-wrap">
									<img class="f-icon" class="fl" src="${resourceHost }/images/tpl/1f.png" />
									<input type="text" class="floor-tit fr" value="" id="floorName" name="floorName"/>
								</div>
								<div class="nav-bar-wrap pr fl" id="floor_tab">
									<span class="edit-tips" href="javascript:void(0)" onclick="openNav()"><img src="${resourceHost }/images/tpl/edit-tips.png"/></span>
									<ul>
										<li ap_L="" ap_R="" ap_M1="" ap_M2="" ap_M3="" ap_M4="">
											<a href="javascript:void(0)" class="active" onclick="selectTab(this)">
												<span>默认一</span>
											</a>
										</li>
										<li ap_L="" ap_R="" ap_M1="" ap_M2="" ap_M3="" ap_M4="">
											<a href="javascript:void(0)" onclick="selectTab(this)">
												<span>默认二</span>
											</a>
										</li>
										<li ap_L="" ap_R="" ap_M1="" ap_M2="" ap_M3="" ap_M4="">
											<a href="javascript:void(0)" onclick="selectTab(this)">
												<span>默认三</span>
											</a>
										</li>
										<li ap_L="" ap_R="" ap_M1="" ap_M2="" ap_M3="" ap_M4=""> 
											<a href="javascript:void(0)" onclick="selectTab(this)">
												<span>默认四</span>
											</a>
										</li>
									</ul>
								</div>
							</div>
							<div class="fes-sort-wrap">
								
								<div class="fes-sort">
									<ul class="clearfix">
										<li>
											<div class="fes-item pr" style="border:1px solid #F0F0F0" id="ap_L">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(295,450,'ap_L','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 450（PX）</span>
												</div>
												<div class="item-wrap">
													<%-- <a href="#"><img src="${resourceHost }/images/tpl/activity/doanngo.jpg" /></a> --%>
												</div>
											</div>
										</li>
										
										<li>
											<div class="fes-item pr" style="border:1px solid #F0F0F0" id="ap_M1">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(295,220,'ap_M1','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<%-- <a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a> --%>
												</div>
											</div>
											<div class="fes-item pr" style="border:1px solid #F0F0F0" id="ap_M2">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(295,220,'ap_M2','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<%-- <a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a> --%>
												</div>
											</div>
											<div class="fes-item pr" style="border:1px solid #F0F0F0" id="ap_M3">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(295,220,'ap_M3','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<%-- <a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a> --%>
												</div>
											</div>
											<div class="fes-item pr" style="border:1px solid #F0F0F0" id="ap_M4">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(295,220,'ap_M4','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<%-- <a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a> --%>
												</div>
											</div>
										</li>
										
										<li>
											<div class="fes-item pr" style="border:1px solid #F0F0F0" id="ap_R">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(295,450,'ap_R','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 450（PX）</span>
												</div>
												<div class="item-wrap">
													<%-- <a href="#"><img src="${resourceHost }/images/tpl/activity/doanngo.jpg" /></a> --%>
												</div>
											</div>
										</li>
									</ul>
								</div>
								
								<%-- <div class="fes-sort hide">
									<ul class="clearfix">
										<li>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 450（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/doanngo2.jpg" /></a>
												</div>
											</div>
										</li>
										
										<li>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
										</li>
										
										<li>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 450（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/doanngo2.jpg" /></a>
												</div>
											</div>
										</li>
									</ul>
								</div>
								
								<div class="fes-sort hide">
									<ul class="clearfix">
										<li>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 450（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/doanngo3.jpg" /></a>
												</div>
											</div>
										</li>
										
										<li>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
										</li>
										
										<li>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 450（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/doanngo3.jpg" /></a>
												</div>
											</div>
										</li>
									</ul>
								</div>
								
								<div class="fes-sort hide">
									<ul class="clearfix">
										<li>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 450（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/doanngo4.jpg" /></a>
												</div>
											</div>
										</li>
										
										<li>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
										</li>
										
										<li>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 450（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/doanngo4.jpg" /></a>
												</div>
											</div>
										</li>
									</ul>
								</div>
								
								<div class="fes-sort hide">
									<ul class="clearfix">
										<li>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 450（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/doanngo5.jpg" /></a>
												</div>
											</div>
										</li>
										
										<li>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 220（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/anerle.jpg" /></a>
												</div>
											</div>
										</li>
										
										<li>
											<div class="fes-item pr">
												<div class="mask">
													<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
													<span class="size">295 × 450（PX）</span>
												</div>
												<div class="item-wrap">
													<a href="#"><img src="${resourceHost }/images/tpl/activity/doanngo5.jpg" /></a>
												</div>
											</div>
										</li>
									</ul>
								</div> --%>
							
							</div>
						</div>
						
					</div>
				</div>
				
				<div class="btn-wrap">
					<label class="btn-submit"><input type="button" value="提交" onclick="packageJson()" /></label>
					<label class="btn-cancel"><input type="button"  id="cancelButton" value="取消" onclick="location.href='${egolmHost}${serverName}/template/list'"/></label>
					<label class="btn-preview pull-right"><input type="button" value="生成预览"  onclick="window.open('${webHost}/template/preview?sTplNo=${sTplNo }')"/></label>
				</div>
				
			</div>
				
			</div><!-- tpl-content  -->
		</div>
		
		<!--二级分类弹出框开始-->
		<div class="modal fade edit-box rec-good-sort" id="tabNavModel" tabindex="-1" role="dialog" aria-labelledby="editRecGoodsSortLabel">
		  	<div class="modal-dialog" role="document">
		    	<div class="modal-content border-radius">
		    		<div class="modal-header">
		    			<h1>二级分类设置</h1>
		    			<p class="line"></p>
		    			<a class="btn-close" data-dismiss="modal" aria-label="Close" href="javascript:void(0)"><img src="${resourceHost}/images/btn-close.png"/></a>
		    		</div>
			      	<div class="modal-body">
				        <form>
				        	<div class="input-box clearfix">
				        		<input class="border border-radius bg-color pull-left" type="text" id="addtabnav" name="addtabnav"/>
				        		<a class="pull-right" href="javascript:void(0)" onclick="addNav(this)"><img src="${resourceHost}/images/tpl/add-input.png"/></a>
				        	</div>
				        	<div class="input-item border bg-color border-radius">
				        		<ul class="clearfix" id="tabList">
				        			<!-- <li>
				        				<div class="border-radius">
				        					<a href="javascript:void(0)"><img src="${resourceHost }/images/btn-delete.png"/></a>
				        					<p>热卖商品</p>
				        				</div>
				        			</li> -->
				        		</ul>
				        	</div>
				        	<p class="drap-tips">*拖动分类更改顺序</p>
				        	
				        	<div class="btn-wrap">
								<label class="btn-submit"><input type="button" value="保存" onclick="saveNav()"/></label>
								<label class="btn-cancel"><input data-dismiss="modal" type="button" value="取消" onclick=""/></label>
							</div>
				        </form>
			      	</div>
		    	</div>
		  	</div>
		</div>
		
		<!-- 二级分类弹出框结束 -->	
	</div>
</div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tpl/tpl-setting-floor1.js"></script>
</e:point>