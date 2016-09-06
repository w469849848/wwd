<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="活动详情"  currentTopMenu="活动详情" currentSubMenu="" css="css/add-activity.css,css/add-salesman.css" js="" localCss="" localJs="" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/dealer/activity-detail.jsp">
 
			<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/tmpPromo/list">促销管理</a> &gt; 
								<a class="active" href="${webHost }/tmpPromo/loadDetailMsgById?id=${activityData.nTmpPromoID }">活动申请详情</a>
							</p>
						</div>
							
						<div class="add-box">
							
							<form>
								
								<div class="dealer-info">
									<h1>活动申请信息</h1>
									<p class="line"></p>
									<div class="info-box">
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">活动类型：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled"  value="${activityData.sTmpPromoActionType }"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">活动区域：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${activityData.sZoneName }"/>
													</label>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">活动档期：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${activityData.sTmpPromoSchedule }"/>
													</label>
												</div>
											</div>
										</div>
										<p class="row">
											<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<span class="col-xs-4 col-sm-2">活动公告描述：</span>
												<label class="col-xs-7 col-sm-10 dropdown-wrap">
													<textarea class="border border-radius bg-color" rows="6" >${activityData.sTmpPromoMemo}</textarea>
												</label>
											</small>
										</p>
										 
									 <p class="row">
											<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<span class="col-xs-4 col-sm-2">活动内容描述：</span>
												<label class="col-xs-1 col-sm-10 dropdown-wrap">
													<textarea class="border border-radius bg-color" rows="6" >${activityData.sTmpPromoSmsMemo}</textarea>
												</label>
											</small>
										</p>
											 
										
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">活动开始日期：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="<fmt:formatDate value="${activityData.dTmpPromoBeginDate }" type="both"/> "/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">活动结束日期：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="<fmt:formatDate value="${activityData.dTmpPromoEndDate }" type="both"/>"/>
													</label>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">短信开始日期：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="<fmt:formatDate value="${activityData.dTmpPromoSmsBeginTime }" type="both"/>"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">短信结束日期：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="<fmt:formatDate value="${activityData.dTmpPromoSmsEndTime }" type="both"/>"/>
													</label>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">公告开始日期：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="<fmt:formatDate value="${activityData.dTmpPromoNoticeBeginTime }" type="both"/> "/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">公告结束日期：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="<fmt:formatDate value="${activityData.dTmpPromoNoticeEndTime }" type="both"/> "/>
													</label>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">创建人：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled"  value="${activityData.sCreateUser }"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">创建时间：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${activityData.dCreateDate }"/>
													</label>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">审核人：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled"  value="${activityData.sConfirmUser }"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">审核时间：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${activityData.dConfirmDate }"/>
													</label>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">活动状态：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled"  value="${activityData.nTag }"/>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">最后更新时间：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" disabled="disabled" value="${activityData.dLastUpdateTime }"/>
													</label>
												</div>
											</div>
										</div>
										
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">附件：</span>
													<label class="col-xs-7">
																<a href="${webHost}/tmpPromo/downloadFile?id=${activityData.nTmpPromoID}">下载</a>
													</label>
												</div>
											</div>
										</div>
									 
									</div>
								</div> 
							</form>
						
						</div>
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->
</e:point>		

