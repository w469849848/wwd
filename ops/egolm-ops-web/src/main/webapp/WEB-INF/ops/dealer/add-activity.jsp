<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="活动申请"  currentTopMenu="活动申请" currentSubMenu="" css="css/add-activity.css,css/add-salesman.css" js="" localCss="" localJs="dealer/add-activity.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/dealer/add-activity.jsp">
 
			 <div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="#">促销管理</a> &gt; 
								<a class="active" href="add-activity.html">新增活动</a>
							</p>
						</div>
						
						<div class="add-box">
								
							<form  action ="",method="post" id="activityForm" name="activityForm" onsubmit = "return check();"  enctype="multipart/form-data">
								  <input type="hidden" id="nTmpPromoID" name="nTmpPromoID" value="${activityData.nTmpPromoID}">
								
								<div class="add-activity">
								
									<h1>添加活动</h1>
									<p class="line"></p>
									<ul class="time clearfix">
										<li>
											<span>活动时间：</span>
											<span>
												<label class="dropdown-wrap">
													<input  id="dTmpPromoBeginDate" name="dTmpPromoBeginDate" value="<fmt:formatDate value="${activityData.dTmpPromoBeginDate }" pattern="yyyy-MM-dd HH:mm:ss"/>"   class="border border-radius bg-color" type="text" />
													<span class="dr"><img src="${resourceHost }/images/arrow-black.png"></span>
												</label>
												<span class="gap">-</span>
												<label class="dropdown-wrap">
													<input id="dTmpPromoEndDate" name="dTmpPromoEndDate" value="<fmt:formatDate value="${activityData.dTmpPromoEndDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" class="border border-radius bg-color" type="text" />
													<span class="dr"><img src="${resourceHost }/images/arrow-black.png"></span>
												</label>
											</span>
										</li>
										<li>
											<span>短信时间：</span>
											<span>
												<label class="dropdown-wrap">
													<input class="border border-radius bg-color" type="text"   id="dTmpPromoSmsBeginTime" name="dTmpPromoSmsBeginTime" value="<fmt:formatDate value="${activityData.dTmpPromoSmsBeginTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
													<span class="dr"><img src="${resourceHost }/images/arrow-black.png"></span>
												</label>
												<span class="gap">-</span>
												<label class="dropdown-wrap">
													<input class="border border-radius bg-color" type="text" id="dTmpPromoSmsEndTime" name="dTmpPromoSmsEndTime"  value="<fmt:formatDate value="${activityData.dTmpPromoSmsEndTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
													<span class="dr"><img src="${resourceHost }/images/arrow-black.png"></span>
												</label>
											</span>
										</li>
										<li>
											<span>公告时间：</span>
											<span>
												<label class="dropdown-wrap">
													<input class="border border-radius bg-color" type="text"  id="dTmpPromoNoticeBeginTime" name="dTmpPromoNoticeBeginTime"  value="<fmt:formatDate value="${activityData.dTmpPromoNoticeBeginTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
													<span class="dr"><img src="${resourceHost }/images/arrow-black.png"></span>
												</label>
												<span class="gap">-</span>
												<label class="dropdown-wrap">
													<input class="border border-radius bg-color" type="text" id="dTmpPromoNoticeEndTime" name="dTmpPromoNoticeEndTime"  value="<fmt:formatDate value="${activityData.dTmpPromoNoticeEndTime }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
													<span class="dr"><img src="${resourceHost }/images/arrow-black.png"></span>
												</label>
											</span>
										</li>
										<li>
											<span>活动类型：</span>
											<span>
											      <input   type="hidden" id="sTmpPromoActionTypeID" name="sTmpPromoActionTypeID" value="${activityData.sTmpPromoActionTypeID}"/>  
												  <input   type="hidden" id="sTmpPromoActionType" name="sTmpPromoActionType" value="${activityData.sTmpPromoActionType}"/> 
											
												<label class="filter-select dropdown-wrap">
													<a id="tmp-promo-type-id"  class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
														<span class="item-name">请选择</span>
														<span class="dr"><img src="${resourceHost }/images/arrow-black.png"></span>
													</a>
													<ul id="tmp-promo-type-memu" class="dropdown-menu" aria-labelledby="tmp-promo-type-id">
														 
													</ul>
												</label>
											</span>
										</li>
										<li>
											<span>活动区域：</span>
											<span>
												 <input   type="hidden" id="sZoneCode" name="sZoneCode" value="${activityData.sZoneCode}"/>	
												<input   type="hidden" id="sZoneName" name="sZoneName" value="${activityData.sZoneName}"/>	
												<label class="filter-select dropdown-wrap">
													<a id="tmp-zone-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
														<span class="item-name">请选择</span>
														<span class="dr"><img src="${resourceHost }/images/arrow-black.png"></span>
													</a>
													<ul id="tmp-zone-memu" class="dropdown-menu" aria-labelledby="tmp-zone-id">
														 
													</ul>
												</label>
											</span>
										</li>
									</ul>
									
									<div class="clearfix ac-content">
										<div class="pull-left">
											<label>
												<span>活动档期：</span>
												<input class="border border-radius bg-color" type="text" placeholder="请输入活动专题（如双十一活动）"    id="sTmpPromoSchedule" name="sTmpPromoSchedule" value="${activityData.sTmpPromoSchedule}"/>
											</label>
											<label>
												<span>活动标题：</span>
												<input class="border border-radius bg-color" type="text" placeholder="请输入活动标题"   id="sTmpPromoTitle" name="sTmpPromoTitle" value="${activityData.sTmpPromoTitle}"/>
											</label>
											<label>
												<span>活动附件：<i class="tips">(100K以内800*300)</i></span>
												<label class="upload-file">
													<input type="file"  id="sTmpPromoAttr" name="sTmpPromoAttr" onchange="previewFile(this)"/>
													<span><i class="add-icon"></i>添加附件</span>
												</label>
											</label>
										</div>
										<div class="pull-right">
											<label>
												<span>短信内容描述：</span>
												<textarea class="border border-radius bg-color" id="sTmpPromoSmsMemo" name="sTmpPromoSmsMemo">${activityData.sTmpPromoSmsMemo}</textarea>
											</label>
											<label>
												<span>活动公告描述：</span>
												<textarea class="border border-radius bg-color" id="sTmpPromoMemo" name="sTmpPromoMemo">${activityData.sTmpPromoMemo}</textarea>
											</label>
										</div>
									</div>
									
								</div>
								
								<div class="btn-wrap clearfix">
									<div class="btn-box clearfix">
										<label class="pull-right"><input id="submit" class="border border-radius" type="button" value="保存" /></label>
										<label class="pull-left"><input  id="cancel" class="border border-radius" type="button" value="取消" /></label>
									</div>
								</div>
								
							</form>
							
						</div>

						 
						
					</div><!-- /.page-content -->
				
				</div><!-- /.main-content -->
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->
</e:point>		

