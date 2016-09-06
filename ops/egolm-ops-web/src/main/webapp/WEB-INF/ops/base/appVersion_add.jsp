<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
 
<e:resource title="版本管理"  currentTopMenu="系统管理" currentSubMenu="" css="css/appVersion_add.css" js="" localCss="" localJs="base/appVersion_add.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/base/appVersion_add.jsp">
				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="#">系统管理</a> &gt; 
								 	<c:if test="${not empty appVersion.nID}">
								<a class="active" href="${webHost}/system/appVersion/loadMsgById?nId=${appVersion.nID}">版本编辑</a>
								</c:if>
								<c:if test="${empty appVersion.nID}">
								<a class="active" href="${webHost}/system/appVersion/addIndex">版本新增</a>
								</c:if> 
								 
								
							</p>
						</div>
						
						<div class="appVersion"> <!-- 广告管理 -->
							<form action ="",method="post" id="appVersionFrom" name="appVersionFrom" onsubmit = "return check();"  enctype="multipart/form-data" >								
								 <input type="hidden" name="nID" id="nID" value="${appVersion.nID}"/>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">应用名称：</span>
										<label class="col-xs-7 col-sm-9 dropdown-wrap">
											<input class="border border-radius bg-color" type="text" name="sAppName" id = "sAppName" value="${appVersion.sAppName}"/>
 										</label>
									</small>
								</p>
									<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">版本类型：</span>
											 <input type="hidden" name="sAppTypeID" id="sAppTypeID" value="${appVersion.sAppTypeID}"> 
 											 <input type="hidden" name="sAppType" id="sAppType" value="${appVersion.sAppType}"> 
											<div class="col-xs-7 dropdown-wrap"> 
 												<a id="sAppType-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sAppType-menu" class="dropdown-menu" aria-labelledby="sAppType-id">
										           
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
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">版本号：</span>
										<label class="col-xs-7 col-sm-9 dropdown-wrap">
											<input class="border border-radius bg-color" type="text" name="sAppVersion" id = "sAppVersion" placeholder="如:1.1.0" value="${appVersion.sAppVersion}"  onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" />
 										</label>
									</small>
								</p>
							
								
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">版本附件：</span>
										<label class="upload-file"> 
											<input type="file" name="sAppUrl" id="sAppUrl" >
											
											<c:if test="${not empty  appVersion.sAppUrl}">
											    <span id="fileId">${appVersion.sAppUrl}</span>		
											</c:if>
											<c:if test="${ empty  appVersion.sAppUrl}">
											    <span id="fileId"><i class="add-icon"></i>添加附件</span>		
											</c:if>							
										</label>
									</small>
								</p>
								
							 
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

