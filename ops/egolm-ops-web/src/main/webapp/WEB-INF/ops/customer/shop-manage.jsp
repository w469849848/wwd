<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>  
<c:set scope="application" var="resourceHost"  value="${e:resourceHost('')}${serverName}/resources/assets" />

<e:resource title="会员管理" currentTopMenu="会员管理" currentSubMenu="店铺管理" css="" js="js/common.js" localCss="cust/shop-manage.css" localJs="cust/shop-manage.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/customer/shop-manage.jsp">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/pagination.css" />

			<div class="main-content">

				<div class="page-content">

					<div class="wh_titer">
						<p class="wh_titer_f">
							您的位置： <a href="/${serverName}">首页</a> &gt; <a href="#">会员管理</a> &gt; <a
								class="active" href="shopList">店铺管理</a>
						</p>
					</div>

					<div  class="shop table-box">
						<div class="filter-wrap clearfix">
							<form id="limitPageForm" method="post">
							<input type="hidden" name="page.index" value="${page.index}" />
							<input type="hidden" name="page.limit" value="10" />
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="店铺名称" name="sShopName" value="${sShopName }" id="sShopName" type="text" />
								</label>
								<label class="filter-select dropdown-wrap m-r">
										<a id="district-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
											<c:choose>
												<c:when test="${sDistrict != '' && sDistrict != null }">
													<span id="district-span">${sDistrict }</span>
												</c:when>
												<c:otherwise>
													<span id="district-span">所在区域</span>
												</c:otherwise>
											</c:choose>
											<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
											<input id="sDistrictID" type="hidden" name="sDistrictID" value="${sDistrictID }">
											<input id="sDistrict" type="hidden" name="sDistrict" value="${sDistrict }">
										</a>
										<ul id="district-memu" class="dropdown-menu" aria-labelledby="district-id">
											<li value="-1">全部</li>
											<c:forEach items="${districtList }" var="data">
												<li value="${data.sRegionNO }">${data.sRegionDesc }</li>
											</c:forEach>
 										</ul>
								 </label>
								 <label class="m-r">
									<input class="filter border-radius bg-color" placeholder="店铺地址" name="sAddress" value="${sAddress }" id="sAddress" type="text" />
								 </label>
								<span class="pull-right">
										<a class="add-message" href="javascript:$('#limitPageForm').submit();"><i class="search-icon"></i>查询</a>
										<a class="add-message" href="toAddShop"><i class="add-icon"></i>新增<span>店铺</span></a>
								</span>
							</form>
							</div>
						<table class="footable table even" data-page-size="5">
							<thead class="bg-color">
								<tr>
									<th></th>
									<!-- <th data-toggle="true">代码</th> -->
									<th data-toggle="true">名称</th>
									<th data-hide="phone,tablet">店铺类型</th>
									<th data-hide="phone,tablet">经销类型</th>
									<th data-hide="phone,tablet">所属会员</th>
									<th data-toggle="phone,tablet">联系人</th>
									<th data-hide="phone,tablet">电话</th>
									<th data-hide="phone,tablet">所在城市</th>
									<th data-hide="phone,tablet">所在市区</th>
									<th data-hide="phone">状态</th>
									<th data-hide="phone,tablet">店铺地址</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${datas}" var="d">
									<tr title="${d.nShopID}">
										<td><label class="checked-wrap">
											 <input type="hidden" value="${d.nShopID }" id="nShopID"/>
											 <input type="hidden" value="${d.sCustLeveTypeID }" id="sCustLeveTypeID"/>
										 <input type="checkbox" class="chk shop-check" data-city="${d.sCityID}" data-no="${d.sShopNO}" data-tag="${d.nTag}" /> <span class="chk-bg"></span>
										</label>
										</td>
										<%-- <td>${d.sShopNO }</td> --%>
										<td>${d.sShopName }</td>
										<td>${d.sShopType }</td>
										<td>${d.sScopeType }</td>
										<td>${d.sCustName }</td>
										<td>${d.sContacts }</td>
										<td>${d.sTel }</td>
										<td>${d.sCity }</td>
										<td>${d.sDistrict }</td>
										<td>
											<c:if test="${d.nTag == 0}">
												<span class="state"><img
													src="${pageContext.request.contextPath}/resources/egolm/assets/images/circle.png" />
												</span>未禁用
											</c:if> 
											<c:if test="${d.nTag == 1}">
												<span class="state"><img
													src="${pageContext.request.contextPath}/resources/egolm/assets/images/close.png" />
												</span>已禁用
											</c:if>
										</td>
										<td>${d.sAddress }</td>
										<td style="text-align: center">
												<a class="edit" href="toAddOrEditShop?nShopID=${d.nShopID}"><img src="${resourceHost}/images/edit.png" alt="编辑" /></a>
												<a class="detail orange" href="javascript:generateDistricts('${d.sShopNO}','${d.sCityID}')">修改市区</a>
												<!-- <a class="delete" href="javascript:deleteShop('${d.nShopID}')"><img src="${resourceHost}/images/delete.png" alt="删除" /></a> -->
												
												<c:if test="${d.nTag == 0}">
													<a class="detail orange" href="javascript:updateTag('${d.sShopNO}',1)">禁用</a>
												</c:if>
												<c:if test="${d.nTag == 1}">
													<a class="detail orange" href="javascript:updateTag('${d.sShopNO}',0)">启用</a>
												</c:if>
												<!-- 定位 -->
												<a class="detail orange" href="javascript:toLocation('${d.nShopID}','${d.sShopNO}','${d.sProvince}${d.sCity}${d.sDistrict }${d.sAddress }','${d.sCity}')">定位</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="14" class="clearfix">
										<div class="batch">
											<label>
												<input type="checkbox" class="chk check-all" />
													<span class="chk-bg"></span>
												<span class="txt">全选</span>
											</label>
											<label>
												<input id="batch-update-shop" class="border border-radius bg-color f-50" type="button" value="批量禁用/启用" />
											</label>
											<label>
												<input id="batch-change-city" class="border border-radius bg-color f-50" type="button" value="批量修改市区" />
											</label>
										</div>
										<c:set var="pagerForm" value="limitPageForm" scope="request"/>
										<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
					
					
					
					
					
					

					<!-- 编辑 -->
					<div class="modal fade edit-box" id="editShop" tabindex="-1"
						role="dialog" aria-labelledby="editShopLabel">
						<div class="modal-dialog" role="document">
							<div class="modal-content border-radius">
								<div class="modal-body">
									<form action="toAddOrEditShop" id="toEditPageForm">
										<input type="hidden" id="nShopID" name="nShopID" value="" />
									</form>
								</div>
							</div>
						</div>
					</div>

					<!-- 确定删除弹窗 -->
					<div class="modal fade delete-box" id="deleteAlert" tabindex="-1"
						role="dialog" aria-labelledby="deleteAlertLabel">
						<div class="modal-dialog" role="document">
							<div class="modal-content border-radius">
								<div class="modal-header">
									<a class="pull-right" data-dismiss="modal"
										href="javascript:void(0)"></a>
								</div>
								<div class="modal-body">
									<p class="pic">
										<span></span>
									</p>
									<p class="text">是否确认删除？</p>
									<p class="btn-box clearfix">
										<input class="bg-color border-radius border" type="button"
											id="btn-confirm" value="确定" /> <input
											class="bg-color border-radius border" type="button"
											data-dismiss="modal" value="取消" />
									</p>
								</div>
							</div>
						</div>
					</div>

					<!--保存成功-->
					<div class="modal fade success-box" id="successAlert" tabindex="-1"
						role="dialog" aria-labelledby="successAlertLabel">
						<div class="modal-dialog" role="document">
							<div class="modal-content border-radius">
								<div class="modal-header">
									<a class="pull-right" data-dismiss="modal"
										href="javascript:void(0)"></a>
								</div>
								<div class="modal-body">
									<p class="pic">
										<span></span>
									</p>
									<p class="text">保存成功</p>
									<p class="btn-box clearfix">
										<input class="bg-color border-radius border" type="button"
											data-dismiss="modal" value="确定" id="back_btn"/>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.page-content -->
			</div>
			<!-- /.main-content -->
		
</e:point>
		