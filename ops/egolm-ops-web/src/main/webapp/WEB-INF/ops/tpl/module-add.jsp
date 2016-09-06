<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="模块管理" currentTopMenu="模板管理" currentSubMenu="模块管理" css="" js="js/common.js" localCss="tpl/add-module.css" localJs="jquery.form.js,tpl/add-module.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/module-add.jsp">

				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${egolmHost}${serverName}/template/module/list">模块列表</a> &gt; 
								<c:if test="${module.SModuleNo==null }">
								<a class="active" href="javascript:void(0)">新增模块</a>
								</c:if>
								<c:if test="${module.SModuleNo!=null }">
								<a class="active" href="javascript:void(0)">修改模块</a>
								</c:if>
							</p>
						</div>
						
						<div class="module"> <!-- 模块管理 -->
							<form id="moduleForm" action="${egolmHost}${serverName}/template/module/add" method="post" enctype="multipart/form-data">
								<input type="hidden" value="${module.SModuleNo }" name="sModuleNo" id="sModuleNo">
								<input type="hidden" value="${module.NModuleType }" name="nModuleType" id="nModuleType">
								<input type="hidden" value="${module.NStatus }" name="nStatus" id="nStatus">
								<input type="hidden" value="${module.SMiniPic}" name="oldMiniPic">
								<input type="hidden" value="${module.SDisplayNo}" name="sDisplayNo" id="sDisplayNo">
								<input type="hidden" value="${module.SDisplayArea}" name="sDisplayArea" id="sDisplayArea">
								<p class="row">
									<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
										<span class="col-xs-4 col-sm-2">模块名称：</span>
										<label class="col-xs-7 col-sm-9 dropdown-wrap">
											<input class="border border-radius bg-color" id="sModuleName" name="sModuleName" value="${module.SModuleName }" type="text" maxlength="30"/>
										</label>
										<span style="color:red">&nbsp;*</span>
									</small>
								</p>
								<p class="floor-wrap row">
									<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
										<span class="col-xs-4 col-sm-2">是否楼层：</span>
										<small class="col-xs-7 col-sm-9 dropdown-wrap" id="nIsFloor">
											<span class="dropdown-wrap">
												<label class="checked-wrap">
													<input type="radio" id="floor_Y" name="nIsFloor" class="chk-radio" <c:if test="${module.NIsFloor=='是' }">checked="checked"</c:if> value="是" />
													<span class="chk-bg"></span>
												</label>
											是
											</span>
											<span class="dropdown-wrap">
												<label class="checked-wrap">
													<input type="radio" id="floor_N" name="nIsFloor" class="chk-radio"  <c:if test="${module.NIsFloor=='否' }">checked="checked"</c:if> value="否" />
													<span class="chk-bg"></span>
												</label>
												否
											</span>
											<span style="color:red">&nbsp;*</span>
										</small>
										
									</small>
								</p>
								
								<div class="row">
									<div class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">模块类别：</span>
											<div class="col-xs-7 dropdown-wrap" id="moduleType">
												<a id="area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span id="nModuleTypeText">${module.NModuleType }</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="area-menu" class="dropdown-menu" aria-labelledby="area-btn">
										          	<li class="module-option">导航类</li>
										          	<li class="module-option">商品类</li>
										          	<li class="module-option">广告类</li>
										          	<li class="module-option">品牌类</li>
										          	<li class="module-option">活动类</li>
										        </ul>		
											</div>
											<span style="color:red">&nbsp;*</span>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">使用范围：</span>
											<div class="col-xs-7 dropdown-wrap" id="display_area">
												<a id="area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span id="displayAreaText">${module.SDisplayArea }</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="area-menu" class="dropdown-menu" aria-labelledby="area-btn">
										          	<li class="display-option" val="web">PC端</li>
										          	<!-- <li class="display-option" val="wx">微信端</li>
										          	<li class="display-option" val="app">APP端</li> -->
										        </ul>		
											</div>
											<span style="color:red">&nbsp;*</span>
										</div>
									</div>
								</div>
								
								<div class="row">
									<div class="pic-wrap col-xs-10 col-sm-10 col-md-7 col-lg-6">
										<span class="tips-txt col-xs-4 col-sm-2">缩略图：</span>
										<label class="pic-box bg-color border border-radius">
											<c:if test="${module.SMiniPic==null }">
											<img src="${resourceHost}/images/upload-add.png" width="44px" height="44px" id="pic-src-id">
											</c:if>
											<c:if test="${module.SMiniPic!=null }">
											<img src="http://img.egolm.com${module.SMiniPic}" width="168px" height="168px" id="pic-src-id">
											</c:if>
											
											<input type="file" name="sMiniPic"  id="sMiniPic" onchange="preview(this)">												
										</label>
									</div>
								</div>
								
								<div class="path-wrap">
									
									<p class="row path">
										<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
											<label class="col-xs-11 col-sm-11 tit"></label>
										</small>
									</p>
									
									<p class="row path">
										<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
											<label class="col-xs-11 col-sm-11">
												<input class="border border-radius bg-color" id="sPcPath" name="sPcPath" value="${module.SPcPath }" placeholder="PC端界面模板路径" type="text"  maxlength="50"/>
											</label>
											<span style="color:red">&nbsp;*</span>
										</small>
									</p>
									
									<p class="row path">
										<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
											<label class="col-xs-11 col-sm-11">
												<input class="border border-radius bg-color" id="sWxPath" name="sWxPath"  value="${module.SWxPath }" placeholder="微信端界面模板路径" type="text"  maxlength="50"/>
											</label>
											<span style="color:red">&nbsp;*</span>
										</small>
									</p>
									
									<p class="row path">
										<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
											<label class="col-xs-11 col-sm-11">
												<input class="border border-radius bg-color" id="sBgPath" name="sBgPath" value="${module.SBgPath }" placeholder="后台管理界面路径" type="text"  maxlength="50"/>
											</label>
											<span style="color:red">&nbsp;*</span>
										</small>
									</p>
									
									<p class="row path">
										<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
											<label class="col-xs-11 col-sm-11">
												<textarea class="border border-radius bg-color" rows="6" id="sRemark" name="sRemark" placeholder="描述" maxlength="100">${module.SRemark }</textarea>
											</label>
										</small>
									</p>
									
								</div>
								
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2"></span>
										<label class="col-xs-7 col-sm-9">
											<input id="submit" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="保存" onclick="commitForm()"/>
											<input class="cancel border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="取消" onclick="location.href='${egolmHost}${serverName}/template/module/list'"/>
										</label>
									</small>
								</p>
							</form>
						</div>
						
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>