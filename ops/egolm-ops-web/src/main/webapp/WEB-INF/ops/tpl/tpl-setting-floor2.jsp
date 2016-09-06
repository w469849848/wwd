<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="模板设置" currentTopMenu="" currentSubMenu="" css="" js="" localCss="tpl/tpl-setting.css,tpl/index.css,tpl/banner.css,tpl/common.css,tpl/header.css,tpl/reset.css,tpl/tpl-manage.css" localJs="jquery.form.js,tpl/Sortable.min.js,tpl/tpl-setting.js,tpl/jquery.SuperSlide.2.1.1.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-setting-floor2.jsp">
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
				
				<!--楼层内容模块  -->
				<!--楼层商品类型二-->
				<div class="floor-goods-type2 tab-6">
					
					<!--中部楼层-->
					<div class="content pr">
						
						<div class="floor-wrap">
							<!--楼层2-->
							<div class="floor floor2 mb-10 pw ma">
								<div class="f-nav clearfix">
									<div class="fl f-icon-wrap pr">
										<img class="f-icon" class="fl" src="${resourceHost }/images/tpl/2f.png" />
										<input type="text" class="floor-tit fr" value="" name="floorName" id="floorName"/>
									</div>
									<div class="nav-bar-wrap pr fl" id="floor_tab">
										<span class="edit-tips" onclick="openNav()"><img src="${resourceHost }/images/tpl/edit-tips.png"/></span>
										<ul>
											<li ap_L="" ap_R="" ap_1st="" ap_2nd="" ap_3rd="" ap_4th="" ap_5th="" ap_6th="" category="">
												<a href="javascript:void(0)" class="active" onclick="selectTab(this)">
													<span>默认一</span>
												</a>
											</li>
											<li ap_L="" ap_R="" ap_1st="" ap_2nd="" ap_3rd="" ap_4th="" ap_5th="" ap_6th="" category="">
												<a href="javascript:void(0)" onclick="selectTab(this)">
													<span>默认二</span>
												</a>
											</li>
											<li ap_L="" ap_R="" ap_1st="" ap_2nd="" ap_3rd="" ap_4th="" ap_5th="" ap_6th="" category="">
												<a href="javascript:void(0)" onclick="selectTab(this)">
													<span>默认三</span>
												</a>
											</li>
										</ul>
									</div>
								</div>			
								
								<div class="f-content pr pw ma">
									
									<div class="fes-sort-wrap">
										
										<div class="fes-sort">
											
											<ul class="clearfix">
												<li>
													<div class="f-item pr fl" id="ap_L">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(333,250,'ap_L','${sBelongNo }','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">333 × 250（PX）</span>
														</div>
														<div class="item-wrap">
															<%-- <a href="#"><img src="${resourceHost }/images/tpl/activity/wine1.jpg"/></a> --%>
														</div>
													</div>
													<div class="fl f-sort pr bg-2f" id="category">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)" onclick="popFloorCategory('${sBelongNo}')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
														</div>
														<!-- <p class="clearfix">
															<a href="#" class="fl">11</a>
															<a href="#" class="fr">碳酸饮料</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">茶/咖啡</a>
															<a href="#" class="fr">牛奶/果汁</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">饮用水</a>
															<a href="#" class="fr">冲调饮品</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">功能饮料</a>
															<a href="#" class="fr">冰淇淋</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">雪糕</a>
															<a href="#" class="fr">雪糕</a>
														</p> -->
													</div>
												</li>
												<li>
													<div class="f-item fz pr fl" id="ap_R">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(437,249,'ap_R','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">437 × 249（PX）</span>
														</div>
														<div class="item-wrap">
															<%-- <a href="#">
																<div style="width: 218px; height: 249px;" class="good-item">
																	<div style="width: 162px; height: 162px;" class="pic">
																		<img style="width: 90px; height: 120px;" src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div style="padding: 0 28px;" class="intro">
																		<p style="margin: 8px 0; height: 30px;">海天味极鲜酱油380ml</p>
																		<p style="" class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</div>
															</a> --%>
														</div>
													</div>
													<div class="f-item pr fl" id="ap_1st">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(217,248,'ap_1st','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">217 × 248(PX)</span>
														</div>
														<div class="item-wrap">
															<%-- <a href="#">
																<img style="width: 218px; height: 249px;" src="${resourceHost }/images/tpl/activity/anerle.jpg">
															</a> --%>
														</div>
													</div>
													<div class="f-item pr fl" id="ap_2nd">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(217,248,'ap_2nd','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">217 × 248(PX)</span>
														</div>
														<div class="item-wrap">
															<%-- <a href="#">
																<div style="width: 218px; height: 249px;" class="good-item">
																	<div style="width: 162px; height: 162px;" class="pic">
																		<img style="width: 90px; height: 120px;" src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div style="padding: 0 28px;" class="intro">
																		<p style="margin: 8px 0; height: 30px;">海天味极鲜酱油380ml</p>
																		<p style="" class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</div>
															</a> --%>
														</div>
													</div>
												</li>
												<li>
													<div class="f-item pr fl" id="ap_3rd">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(217,248,'ap_3rd','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">217 × 248(PX)</span>
														</div>
														<div class="item-wrap">
															<%-- <a href="#">
																<div style="width: 218px; height: 249px;" class="good-item">
																	<div style="width: 162px; height: 162px;" class="pic">
																		<img style="width: 90px; height: 120px;" src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div style="padding: 0 28px;" class="intro">
																		<p style="margin: 8px 0; height: 30px;">海天味极鲜酱油380ml</p>
																		<p style="" class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</div>
															</a> --%>
														</div>
													</div>
													<div class="f-item pr fl" id="ap_4th">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(217,248,'ap_4th','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">217 × 248(PX)</span>
														</div>
														<div class="item-wrap">
															<%-- <a href="#">
																<div style="width: 218px; height: 249px;" class="good-item">
																	<div style="width: 162px; height: 162px;" class="pic">
																		<img style="width: 90px; height: 120px;" src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div style="padding: 0 28px;" class="intro">
																		<p style="margin: 8px 0; height: 30px;">海天味极鲜酱油380ml</p>
																		<p style="" class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</div>
															</a> --%>
														</div>
													</div>
													<div class="f-item pr fl" id="ap_5th">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(217,248,'ap_5th','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">217 × 248(PX)</span>
														</div>
														<div class="item-wrap">
															<%-- <a href="#">
																<div style="width: 218px; height: 249px;" class="good-item">
																	<div style="width: 162px; height: 162px;" class="pic">
																		<img style="width: 90px; height: 120px;" src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div style="padding: 0 28px;" class="intro">
																		<p style="margin: 8px 0; height: 30px;">海天味极鲜酱油380ml</p>
																		<p style="" class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</div>
															</a> --%>
														</div>
													</div>
													<div class="f-item pr fl" id="ap_6th">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(217,248,'ap_6th','${sBelongNo}','${sDisplayNo}','${sScopeTypeID }')"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">217 × 248(PX)</span>
														</div>
														<div class="item-wrap">
															<%-- <a href="#">
																<div style="width: 218px; height: 249px;" class="good-item">
																	<div style="width: 162px; height: 162px;" class="pic">
																		<img style="width: 90px; height: 120px;" src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div style="padding: 0 28px;" class="intro">
																		<p style="margin: 8px 0; height: 30px;">海天味极鲜酱油380ml</p>
																		<p style="" class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</div>
															</a> --%>
														</div>
													</div>
												</li>
											</ul>
										
										</div>
										
										<%-- <div class="fes-sort hide">
											
											<ul class="clearfix">
												<li>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">333 × 250（PX）</span>
														</div>
														<div class="item-wrap">
															<a href="#"><img src="${resourceHost }/images/tpl/activity/wine1.jpg"/></a>
														</div>
													</div>
													<div class="fl f-sort pr bg-2f">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
														</div>
														<p class="clearfix">
															<a href="#" class="fl">22</a>
															<a href="#" class="fr">碳酸饮料</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">茶/咖啡</a>
															<a href="#" class="fr">牛奶/果汁</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">饮用水</a>
															<a href="#" class="fr">冲调饮品</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">功能饮料</a>
															<a href="#" class="fr">冰淇淋</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">雪糕</a>
														</p>
													</div>
												</li>
												<li>
													<div class="f-item fz pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">437 × 249（PX）</span>
														</div>
														<div class="item-wrap">
															<a href="#"><img src="${resourceHost }/images/tpl/activity/wine2.jpg"/></a>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
												</li>
												<li>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
												</li>
											</ul>
										
										</div>
										
										<div class="fes-sort hide">
											
											<ul class="clearfix">
												<li>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">333 × 250（PX）</span>
														</div>
														<div class="item-wrap">
															<a href="#"><img src="${resourceHost }/images/tpl/activity/wine1.jpg"/></a>
														</div>
													</div>
													<div class="fl f-sort pr bg-2f">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
														</div>
														<p class="clearfix">
															<a href="#" class="fl">33</a>
															<a href="#" class="fr">碳酸饮料</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">茶/咖啡</a>
															<a href="#" class="fr">牛奶/果汁</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">饮用水</a>
															<a href="#" class="fr">冲调饮品</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">功能饮料</a>
															<a href="#" class="fr">冰淇淋</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">雪糕</a>
														</p>
													</div>
												</li>
												<li>
													<div class="f-item fz pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">437 × 249（PX）</span>
														</div>
														<div class="item-wrap">
															<a href="#"><img src="${resourceHost }/images/tpl/activity/wine2.jpg"/></a>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
												</li>
												<li>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
												</li>
											</ul>
										
										</div>
										
										<div class="fes-sort hide">
											
											<ul class="clearfix">
												<li>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">333 × 250（PX）</span>
														</div>
														<div class="item-wrap">
															<a href="#"><img src="${resourceHost }/images/tpl/activity/wine1.jpg"/></a>
														</div>
													</div>
													<div class="fl f-sort pr bg-2f">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
														</div>
														<p class="clearfix">
															<a href="#" class="fl">44</a>
															<a href="#" class="fr">碳酸饮料</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">茶/咖啡</a>
															<a href="#" class="fr">牛奶/果汁</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">饮用水</a>
															<a href="#" class="fr">冲调饮品</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">功能饮料</a>
															<a href="#" class="fr">冰淇淋</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">雪糕</a>
														</p>
													</div>
												</li>
												<li>
													<div class="f-item fz pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">437 × 249（PX）</span>
														</div>
														<div class="item-wrap">
															<a href="#"><img src="${resourceHost }/images/tpl/activity/wine2.jpg"/></a>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
												</li>
												<li>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
												</li>
											</ul>
										
										</div>
										
										<div class="fes-sort hide">
											
											<ul class="clearfix">
												<li>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">333 × 250（PX）</span>
														</div>
														<div class="item-wrap">
															<a href="#"><img src="${resourceHost }/images/tpl/activity/wine1.jpg"/></a>
														</div>
													</div>
													<div class="fl f-sort pr bg-2f">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
														</div>
														<p class="clearfix">
															<a href="#" class="fl">55</a>
															<a href="#" class="fr">碳酸饮料</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">茶/咖啡</a>
															<a href="#" class="fr">牛奶/果汁</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">饮用水</a>
															<a href="#" class="fr">冲调饮品</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">功能饮料</a>
															<a href="#" class="fr">冰淇淋</a>
														</p>
														<p class="clearfix">
															<a href="#" class="fl">雪糕</a>
														</p>
													</div>
												</li>
												<li>
													<div class="f-item fz pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">437 × 249（PX）</span>
														</div>
														<div class="item-wrap">
															<a href="#"><img src="${resourceHost }/images/tpl/activity/wine2.jpg"/></a>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
												</li>
												<li>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
													<div class="f-item pr fl">
														<div class="mask">
															<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost }/images/tpl/edit-tips.png"/></a>
															<span class="size">162 × 162(PX)</span>
														</div>
														<div class="good-item">
															<div class="item-wrap">
																<a href="#">
																	<div class="pic">
																		<img src="${resourceHost }/images/tpl/index/1.jpg" />
																	</div>
																	<div class="intro">
																		<p>海天味极鲜酱油380ml</p>
																		<p class="orange fw"><i>￥</i>350.50/<span>盒</span></p>
																	</div>
																</a>
															</div>
														</div>
													</div>
												</li>
											</ul>
										
										</div>
										
									</div>		
								</div>
							</div> --%>
							
						</div>
					</div>
					
					<div class="btn-wrap">
						<label class="btn-submit"><input type="button" value="提交" onclick="packageJson()" /></label>
						<label class="btn-cancel"><input  id="cancelButton" type="button" value="取消" onclick="location.href='${egolmHost}${serverName}/template/list'"/></label>
						<label class="btn-preview pull-right"><input type="button" value="生成预览"  onclick="window.open('${webHost}/template/preview?sTplNo=${sTplNo }')"/></label>
					</div>
					
				</div>
				<!--楼层内容模块  -->
			</div>
		</div>
	</div> 
	</div>
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
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tpl/tpl-setting-floor2.js"></script>
</e:point>