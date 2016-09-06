<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>  
<e:resource title="版本管理"  currentTopMenu="系统管理" currentSubMenu="" css="css/appVersion_list.css" js="js/common.js" localCss="" localJs="base/appVersion_list.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/base/appVersion_list.jsp">
 				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="#">系统管理</a> &gt; 
								<a class="active" href="${webHost}/system/appVersion/list">版本管理</a>
							</p>
						</div>
						
						<div class="appVersion table-box"> <!-- 版本管理 -->
							<form action="list" id="limitPageForm" method= "post">
							  <input type="hidden" name="page.index" value="${page.index}" />  
						
							<div class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="应用名称/版本号" id="sAppQuery" type="text"  name="sAppQuery" value="${sAppQuery }"/>
								</label>
								
								 
								
								 <label class="filter-select dropdown-wrap adv-margin">
 									<input type="hidden" name="sAppTypeID" id="sAppTypeID" value="${sAppTypeID}"> 
 									<input type="hidden" name="sAppType" id="sAppType" value="${sAppType}"> 
									<a id="sAppType-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>版本类型</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="sAppType-menu" class="dropdown-menu" aria-labelledby="sAppType-id">
										 
									</ul>
								</label>
							 
							 
								
								<span class="pull-right">
										<a class="add-message" id="query"  href="#">查询</a>
										<a class="add-message" href="${webHost}/system/appVersion/addIndex"><i class="add-icon"></i>新增<span>版本</span></a>
								</span> 
							</div>
							 </form>
							<table class="footable table" data-page-size="5">
								<thead class="bg-color">
									<tr>
										<!-- <th></th> -->
										<th data-toggle="true">编号</th>
										<th data-hide="phone">应用名称</th>
										<th data-hide="phone">版本号</th>
										<th data-hide="phone">版本类型</th>
										<th data-hide="phone,tablet">应用地址</th> 
										
										<th data-hide="phone,tablet">创建人</th>
										<th data-hide="phone,tablet">创建时间</th>
										<th data-hide="phone,tablet">更新人</th>
										<th data-hide="phone,tablet">更新时间</th>
										<th data-hide="phone">状态</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
								
								   <c:forEach items="${appVersionList }" var="appVersion">
										<tr> 
											<td>${appVersion.nID}</td>
											<td>${appVersion.sAppName}</td>
											<td>${appVersion.sAppVersion }</td>
											<td>${appVersion.sAppType} </td>
											<td><a href="${webHost}/system/appVersion/downloadFile?nId=${appVersion.nID}">${appVersion.sAppUrl}</a> </td>											
											<td>${appVersion.sCreateUser} </td>
											<td><fmt:formatDate value="${appVersion.dCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>  </td>
											<td>${appVersion.sUpdateUser} </td>
											<td> <fmt:formatDate value="${appVersion.dUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/> </td> 
									     
											<td>
												<a class="edit" href="${webHost}/system/appVersion/loadMsgById?nId=${appVersion.nID}"><img src="${resourceHost}/images/edit.png" alt="编辑" /></a>
												<a class="delete" pid="${appVersion.nId}" href="javascript:void(0)"><img src="${resourceHost}/images/delete.png" alt="删除" /></a>
											</td>
										</tr> 
										
									  </c:forEach> 
								</tbody>
								<tfoot>
									<tr>
										<td colspan="10" class="clearfix">
											<div class="batch">
												 
											</div>
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
	
