<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="模板设置" currentTopMenu="" currentSubMenu="" css="" js="" localCss="tpl/tpl-setting.css,tpl/index.css,tpl/banner.css,tpl/common.css,tpl/header.css,tpl/reset.css,tpl/tpl-manage.css" localJs="jquery.form.js,tpl/Sortable.min.js,tpl/tpl-setting.js,tpl/jquery.SuperSlide.2.1.1.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-setting-product1.jsp">
<script>
	var JsonData = '${json}';
</script>

<div class="main-content">

<div class="page-content">
		
		<div class="wh_titer">
			<p class="wh_titer_f">
				您的位置：
				<a href="${webHost }/index">首页</a> &gt; 
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
			
			<!--推荐商品模块-->
			<div class="rd-good-module tab-3">
				
				<!--中部楼层-->
				<div class="content pr">
					
					<div class="good-wrap">
						
						<!--分类一-->							
						<div class="activity pw ma">
							<div class="clearfix nav pr" id="nav">
								<span class="edit-tips" href="javascript:void(0)" onclick="openNav()"><img src="${resourceHost}/images/tpl/edit-tips.png"/></span>
								<ul class="activity-nav fl clearfix">
									<!-- <li class="active" goods="">
										<a class="ac-nav" href="javascript:void(0)">
											<span onclick="selectTab(this)">新品上架</span>
										</a>
									</li>
									<li goods="">
										<a class="ac-nav" href="javascript:void(0)">
											<span onclick="selectTab(this)">疯狂抢购</span>
										</a>
									</li>
									<li goods="">
										<a class="ac-nav" href="javascript:void(0)">
											<span onclick="selectTab(this)">热卖商品</span>
										</a>
									</li>
									<li goods="">
										<a class="ac-nav" href="javascript:void(0)">
											<span onclick="selectTab(this)">猜您喜欢</span>
										</a>
									</li> -->
								</ul>
								<%-- <div class="fl exchange clearfix">
									<a class="btn-refresh fr" class="clearfix" href="javascript:void(0)"><img class="fl" src="${resourceHost}/images/tpl/refresh.png"/><span class="fl">换一换</span></a>
								</div> --%>
							</div>
							<div class="activity-item">
								
								<!--新品上市-->
								<div class="mask-wrap pr" id="goods">
									<div class="mask">
										<a class="edit-tips" href="javascript:void(0)" onclick="popSelectProduct(6,'${sBelongNo}')"><img src="${resourceHost}/images/tpl/edit-tips.png"/></a>
									</div>
									<ul class="new-goods clearfix">
										<%-- <li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li> --%>
									</ul>
									
								</div>
								
								<!--今日抢购-->
								<%-- <div class="mask-wrap pr hide">
									<div class="mask">
										<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost}/images/tpl/edit-tips.png"/></a>
									</div>
									<ul class="buy-today clearfix">
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
									</ul>
									
								</div>
								
								<!--热卖商品-->
								<div class="mask-wrap pr hide">
									<div class="mask">
										<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost}/images/tpl/edit-tips.png"/></a>
									</div>
									<ul class="hot-sales clearfix">
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="n-g-item">
												<a href="">
													<div class="item-box">
														<div class="pic">
															<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
														</div>
														<div class="intro">
															<p>欢乐家黄桃980g</p>
														</div>
													</div>
												</a>
											</div>
										</li>
									</ul>
									
								</div>
								
								<!--猜你喜欢-->
								<div class="mask-wrap pr hide">
									<div class="mask">
										<a class="edit-tips" href="javascript:void(0)"><img src="${resourceHost}/images/tpl/edit-tips.png"/></a>
									</div>
									<ul class="recommend-goods clearfix">
									<li>
										<div class="n-g-item">
											<a href="">
												<div class="item-box">
													<div class="pic">
														<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
													</div>
													<div class="intro">
														<p>欢乐家黄桃980g</p>
													</div>
												</div>
											</a>
										</div>
									</li>
									<li>
										<div class="n-g-item">
											<a href="">
												<div class="item-box">
													<div class="pic">
														<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
													</div>
													<div class="intro">
														<p>欢乐家黄桃980g</p>
													</div>
												</div>
											</a>
										</div>
									</li>
									<li>
										<div class="n-g-item">
											<a href="">
												<div class="item-box">
													<div class="pic">
														<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
													</div>
													<div class="intro">
														<p>欢乐家黄桃980g</p>
													</div>
												</div>
											</a>
										</div>
									</li>
									<li>
										<div class="n-g-item">
											<a href="">
												<div class="item-box">
													<div class="pic">
														<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
													</div>
													<div class="intro">
														<p>欢乐家黄桃980g</p>
													</div>
												</div>
											</a>
										</div>
									</li>
									<li>
										<div class="n-g-item">
											<a href="">
												<div class="item-box">
													<div class="pic">
														<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
													</div>
													<div class="intro">
														<p>欢乐家黄桃980g</p>
													</div>
												</div>
											</a>
										</div>
									</li>
									<li>
										<div class="n-g-item">
											<a href="">
												<div class="item-box">
													<div class="pic">
														<img src="${resourceHost}/images/tpl/activity/item1.jpg"/>
													</div>
													<div class="intro">
														<p>欢乐家黄桃980g</p>
													</div>
												</div>
											</a>
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
					<label class="btn-cancel"><input  id="cancelButton" type="button" value="取消" onclick="location.href='${egolmHost}${serverName}/template/list'"/></label>
					<label class="btn-preview pull-right"><input type="button" value="生成预览"  onclick="window.open('${webHost}/template/preview?sTplNo=${sTplNo }')"/></label>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/tpl/tpl-setting-product1.js"></script>
</e:point>