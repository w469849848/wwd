<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="活动背景配置"  currentTopMenu="促销管理" currentSubMenu="活动背景配置" css="css/promo-picSet-list.css" js="js/common.js" localCss="" localJs="promo/promo-picSet-list.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/promo/picSet/promo-picSet-list.jsp">

				<div class="main-content">
					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="#">促销管理</a> &gt; 
								<a class="active" href="${webHost}/promoPicSet/list">活动背景配置</a>
							</p>
						</div>
						
						<div class="promoPicSetManager table-box"> <!-- 广告管理 -->
						  <form action="" id="limitPageForm"  method= "post"> 
								<input type="hidden" name="page.index" id="page_index" value="${page.index}" />
							<div class="filter-wrap">
								<label class="filter-select dropdown-wrap adv-margin">
											<input type="hidden" name="sOrgNO" id="sOrgNO"  value="${promoPicSet.sOrgNO}"/>
											<input type="hidden" name="sOrgDesc" id="sOrgDesc" value="${promoPicSet.sOrgDesc }"/>					
				   				   <a id="sOrgNO-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>区域</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="sOrgNO-menu" class="dropdown-menu" aria-labelledby="sOrgNO-id">
										 
									</ul>
								</label>
								<label class="filter-select dropdown-wrap adv-margin">
 								<input type="hidden" name="sDisplayNO" id="sDisplayNO"  value="${promoPicSet.sDisplayNO}"/>
								<input type="hidden" name="sDisplayDesc" id="sDisplayDesc" value="${promoPicSet.sDisplayDesc }"/>
									<a id="sDisplayNO-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>使用范围</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="sDisplayNO-menu" class="dropdown-menu" aria-labelledby="sDisplayNO-id">
										 	 <li value="web">WEB端</li>
										     <li value="wx">微信端</li>
										     <li value="app">APP端</li> 
									</ul>
								</label>
								
								<span class="pull-right"> 
										<a class="add-message" href="${webHost}/promoPicSet/addIndex"><i class="add-icon"></i>新增</a>
								</span>
								 
								<span class="pull-right" id="query"><a class="add-message" href="#">查询</a> </span>
							</div>
							</form>
							<table class="footable table" data-page-size="5">
								<thead class="bg-color">
									<tr> 
										<th data-toggle="true">区域名称</th>
										<th data-hide="phone,tablet">使用范围</th>
 										<th data-hide="phone">背景图片</th>
										<th data-hide="phone">背景色</th>
										<th data-hide="phone">创建人</th>
										<th data-hide="phone">创建时间</th> 
										<th data-hide="phone">更新人</th>
										<th data-hide="phone">更新时间</th>
										<th data-hide="phone,tablet">操作</th>
									</tr>
								</thead>
								<tbody>
								   <c:forEach items="${datas}" var="data">
									<tr>
 										<td>${data.sOrgDesc}</td>
										<td>${data.sDisplayDesc}</td>
 										<td>
										 <img class="pull-left" src="http://img.egolm.com/${data.sBackgroundPicUrl}@70w_66h" width="70" height="66"  id="show-pic-id"/>
										  <div  id="adPicImg" class="pic-show-alert" style="display:none;">
												   <img src="http://img.egolm.com/${data.sBackgroundPicUrl}"  id="logoShow2"/> 
										</div>
										</td>
								 	
										<td>${data.sBackgroundColour}</td>
										<td>${data.sCreateUser}</td>
										<td>${data.dCreateDate}</td>
										<td>${data.sUpdateUser}</td>
										<td>${data.dUpdateDate}</td>
										<td>
										   <a class="edit" pid="${data.nId}" href="javascript:void(0)"><img src="${resourceHost}/images/edit.png" alt="编辑" /></a>
										   <a class="delete" pid="${data.nId}" href="javascript:void(0)"><img src="${resourceHost}/images/delete.png" alt="删除" /></a>
										   
										   <a class="show" pid="${data.nId}" pDisplay="${data.sDisplayNO }" href="javascript:void(0)"><img src="${resourceHost}/images/preview.png" alt="预览" /></a>
										</td>
									</tr>
								  </c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="11" class="clearfix">
										   <c:set var="pagerForm" value="limitPageForm" scope="request"/>
											<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
										</td>
									</tr>
								</tfoot>
							</table>
						</div> 
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>

