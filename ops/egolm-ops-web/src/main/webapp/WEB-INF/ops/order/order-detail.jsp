<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="订单详情"  currentTopMenu="订单管理" currentSubMenu="订单详情" css="css/order-detail.css,css/order-detail-putaway.css" js="js/common.js" localCss="" localJs="order/order-detail.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/order/order-detail.jsp">
     <div class="main-content">

					<div class="page-content"> 
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/order/tSalesOrderSub/list">订单管理</a> &gt; 
								<a class="active" href="${webHost}/order/tSalesOrderSubDtl/list?sSubOrderID=${tSalesOrderSubMap.sSubOrderID }">订单详情</a>
							</p>
						</div>
						
						<div class="putaway table-box"> <!-- 订单详情表 -->
						<form action="list" id="limitPageForm" method="post">
							<input type="hidden" name="page.index" value="${page.index}" />  
							<input type="hidden" name="sSubOrderID" value = "${tSalesOrderSubMap.sSubOrderID }" />
							<div class="filter-wrap">
								<div>
									<label class="">
										<i class="icon-search f-95"></i>
										<input class="filter border-radius bg-color" placeholder="商品编号/商品名称/条形码" id="orderDetailQueryMsg"  name="orderDetailQueryMsg" value="${orderDetailQueryMsg }"  type="text" />
 									</label>
								    <span class="pull-right" style="margin : auto 8px auto 8px;">
										<span id="query"><a class="add-message" href="${webHost}/order/tSalesOrderSub/list">返回订单列表</a> </span>
								    </span>
								    <span class="pull-right">
										<span id="query"><a class="add-message" href="javascript:$('#limitPageForm').submit();">查询</a> </span>
								    </span>
								</div>
								
								<ul class="clearfix"> 
									<li>订单编号：${tSalesOrderSubMap.sSubOrderID}</li>  
									<li>收货人：${tSalesOrderSubMap.sContacts}</li> 
									<li>收货人电话：${tSalesOrderSubMap.sMobile}${tSalesOrderSubMap.sMobile != null && tSalesOrderSubMap.sTel != null ? '/' : ''}${tSalesOrderSubMap.sTel}</li> 
									<li>配送地址：${tSalesOrderSubMap.sAddress}</li> 
									<li>订单状态：${tSalesOrderSubMap.nOrderStatusName}</li> 
								</ul>
								
								<div class="evaluate">
									<ul class="clearfix">
										<li>
										<div>评价星级：</div>
										<div class="star-wrap">
												<ul >
													<c:forEach begin="1" end="${tSalesOrderSubMap.nEvaluate}" var="i">
														<li class="active"></li>
													</c:forEach>
													<c:if test="${5 - tSalesOrderSubMap.nEvaluate > 0}">
														<c:forEach begin="1" end="${5 - tSalesOrderSubMap.nEvaluate }" var="i">
															<li></li>
														</c:forEach>
													</c:if>
												</ul>
										</div>
										</li>
										<li>评价时间：${tSalesOrderSubMap.dEvaluateDate}</li>
										<li>评价内容：${tSalesOrderSubMap.sEvaluateContent}</li>
									</ul>
								</div>
							</div>
							</form>
							<table class="footable table" data-page-size="10">
							 
								<thead class="bg-color">
									<tr> 
										<th data-hide="phone">商品编号</th>
										<th data-hide="phone">商品名称</th>
										<th data-hide="phone">条形码</th>
										<th data-hide="phone">商品数量</th>
										<th data-hide="phone">单价</th>
										<th data-hide="phone">商品总价</th>
										<th data-hide="phone">优惠金额</th> 
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${orderSubDtlList }" var="orderSubDtl">
										 <tr> 
											 <td>${orderSubDtl.nGoodsID }</td>
											<td>${orderSubDtl.sGoodsDesc }</td>
											<td>${orderSubDtl.sBarcode }</td>
											<td>${orderSubDtl.nSaleQty }</td>
											<td>${orderSubDtl.nSalePrice }</td>
											<td>${orderSubDtl.nSaleAmount }</td>
											<td>${orderSubDtl.nDisAmount }</td>											 
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="10" class="clearfix"> 
											<c:set var="pagerForm" value="limitPageForm" scope="request"/>
											<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
						
					  
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->
 
</e:point>		

