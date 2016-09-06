<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="会员管理" currentTopMenu="会员管理" currentSubMenu="店铺管理" css="css/bootstrap-select.min.css" js="js/common.js,js/bootstrap-select.min.js" localCss="cust/shop-manage.css,salesman/salesman.css" localJs="cust/shop-manage.js,cust/shop-dialog.js" showHeader="false"
	        showTopMenu="false" 
	        showFooter="false" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/customer/shop-list-dialog.jsp">
			<div class="main-content adapt-dialog">
				<div class="page-content">
					<div  class="shop table-box">
						<div class="filter-wrap clearfix">
							<form id="limitPageForm" method="post" action="${webHost}/shop/list/dialog">
								<label class="">
									<i class="icon-search f-95"></i>
									<input class="filter border-radius bg-color" placeholder="店铺名／店铺地址／店铺编号" name="search" value="${search}" id="filter" type="text" />
								</label>
								<label class="">
									<select name="sOrgNO" class="selectpicker" data-width="140px" title="选择区域">
									<option value="">全部</option>
									<c:forEach var="org" items="${orgs}">
										<option value="${org.sOrgNO}">${org.sOrgDesc}</option>
									</c:forEach>
									</select>
								</label>
								<span class="pull-right"> <a class="add-message" href="javascript:$('#limitPageForm').submit();">
								<i class="search-icon"></i>查询</a>
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
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${shops}" var="d">
									<tr title="${d.nShopID}">
										<td>
											<label class="checked-wrap">
											<input type="hidden" value="${d.nShopID }" id="nShopID"/>
											<input type="hidden" value="${d.sCustLeveTypeID }" id="sCustLeveTypeID"/>
										 	<input type="checkbox" class="chk shop-check" data-city="${d.sCityID}" data-no="${d.sShopNO}" data-name=${d.sShopName} data-addr=${d.sAddress} data-tag="${d.nTag}" /> 
										 	<span class="chk-bg"></span>
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
												<input id="submit-select-shop" class="border border-radius bg-color f-50" type="button" value="确定" />
											</label>
										</div>
										<c:set var="pagerForm" value="limitPageForm" scope="request"/>
										<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</div>
			</div>
</e:point>
		