<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="订单管理"  currentTopMenu="订单管理" currentSubMenu="" css="css/order-list.css" js="js/common.js" localCss="order/order.css" localJs="order/order-list.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/order/order-list.jsp">
 
					<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/order/tSalesOrderSub/list">订单管理</a> &gt; 
								<a class="active" href="${webHost}/order/tSalesOrderSub/list">订单列表</a>
							</p>
						</div>
						
						<div class="goods table-box"> <!-- 商品表 -->
						<form action="list" id="limitPageForm" method = "post">
							  <input type="hidden" name="page.index" id="page_index" value="${page.index}" />  
						
							<div class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="订单编号/用户账号/店铺号/手机号码/联系人/配送地址" id="orderQueryMsg" name="orderQueryMsg" value="${orderQueryMsg }" type="text" />
								</label> 
								<input type = "hidden" name="nOrderStatus" id = "nOrderStatus"  value="${nOrderStatus}"/>
								<label class="filter-select dropdown-wrap">
										<a id="order-status-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
											<span>订单状态</span>
											<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										</a>
										<ul id="order-status-memu" class="dropdown-menu" aria-labelledby="order-status-id">
											<li value="-1">全部</li>
											<li value="2">订单提交</li>
											<li value="3">订单取消</li>
											<li value="128">配送中</li>
											<li value="16">订单完成</li>
 										</ul>
								 </label>
								 <label class="filter-select dropdown-wrap">
								 <input type = "hidden" name="sOrgNO" id="sOrgNO" value="${sOrgNO}" />
										<a id="sOrgNo-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
											<span>订单区域</span>
											<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										</a>
										<ul id="sOrgNo-memu" class="dropdown-menu" aria-labelledby="sOrgNo-id">
										 
										</ul>
								 </label>
								 <span class="pull-right">
										<span id="query"><a class="add-message" href="#">查询</a> </span>
								</span>
							</div>
							</form>
							<table class="footable table" data-page-size="13">
								<thead class="bg-color">
									<tr>
									    <th data-hide="phone">	</th> 
										<th data-hide="phone">订单编号</th> 
										<th data-hide="phone">订单区域</th>
										<th data-hide="phone">订单类型</th>
										<th data-hide="phone">订购数量</th>
										<th data-hide="phone">订单金额</th>
										<th data-hide="phone">优惠金额</th>
										<th data-hide="phone">联系人</th> 
										<th data-hide="phone">手机号码</th>
										<th data-hide="phone">配送地址</th>  
										<th data-hide="phone">订单日期</th>
										<th data-hide="phone">订单状态</th>
										<th data-hide="phone">催发状态</th>
										<th data-hide="phone">评价</th>
										<th data-hide="phone"></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${orderSubList}" var="orderSub">
									<tr>
										<td>
											<label class="checked-wrap">
												<input type="checkbox" class="chk" id="orderid-chk" name="orderid-chk" value="${orderSub.sSubOrderID }"/>
												<input type="hidden"  id="orderStatus_${orderSub.sSubOrderID }" name="orderStatus_${orderSub.sSubOrderID }" value="${orderSub.nOrderStatus }"/>
												<span class="chk-bg"></span>
											</label>
										</td>
										<td>${orderSub.sSubOrderID}</td> 
										<td>${orderSub.sOrgNO}</td>
										<td>${orderSub.sSalesOrderType}</td>
										<td>${orderSub.nTotalSaleQty}</td> 
										<td>${orderSub.nTotalSaleAmount}</td> 
										<td>${orderSub.nTotalDisAmount}</td>
										<td>${orderSub.sContacts}</td>
										<td>${orderSub.sCustNO}</td>
										<td>${orderSub.sAddress}</td>
										<td>${orderSub.dOrderDate}</td>
										<td>${orderSub.nOrderStatusName}</td> 
										<td>${orderSub.dLastHastenTime}</td> 
										<td class="star-wrap">
											<div class="fl">
												<ul >
													<c:forEach begin="1" end="${orderSub.evaluate}" var="i">
														<li class="active"></li>
													</c:forEach>
													<c:if test="${5 - orderSub.evaluate > 0}">
														<c:forEach begin="1" end="${5 - orderSub.evaluate }" var="i">
															<li></li>
														</c:forEach>
													</c:if>
												</ul>
											</div>
										</td> 
										<td>
											<a class="detail" href="${webHost}/order/tSalesOrderSubDtl/list?sSubOrderID=${orderSub.sSubOrderID}">详情</a>
										</td>
									</tr>
								   </c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="13" class="clearfix">
										   <div class="batch">
												<label>
													<input type="checkbox" class="chk" />
													<span class="chk-bg"></span>
													<span class="txt">全选/取消</span>
												</label>
												  <label><input class="border border-radius bg-color f-50" type="button" value="批量标记" pid="marked"/></label> 
												  <label><input class="border border-radius bg-color f-50" type="button" value="批量导出" pid="export"/></label>  
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
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->
		
		<!-- 编辑 -->
				<div class="modal fade edit-box" id="editAd" tabindex="-1" role="dialog" aria-labelledby="editAdLabel">
				  	<div class="modal-dialog" role="document">
				    	<div class="modal-content">
					      	<div class="modal-body">
					        	<form>
					        		<input type="hidden" name="subOrderid" id = "subOrderid"/>
					        		<input type="hidden" name="orderStatusResult" id = "orderStatusResult"/> 
					        		<input type="hidden" name="orderStatus" id = "orderStatus"/> 
					        		<div class="scroll-wrap">  
					        			<p>
					        				<label>
					        					<span>标记订单状态：</span>
					        					<label class = "order-status-radio" id="status1">
						        					<span class="checked-wrap">
														<input type="radio" name="order-status" class="chk-radio" value = "3">
														<span class="chk-bg"></span>
													</span>
													<i>订单取消</i>
						        				</label>
						        				<label class = "order-status-radio"  id="status8">
						        					<span class="checked-wrap">
														<input type="radio" name="order-status" class="chk-radio" value = "128">
														<span class="chk-bg"></span>
													</span>
													<i>配送中</i>
						        				</label>
												<label class = "order-status-radio"  id="status16">
													<span class="checked-wrap">
														<input type="radio" name="order-status" class="chk-radio" value = "16">
														<span class="chk-bg"></span>
													</span>
													<i>订单完成</i>
												</label>
					        				</label>
					        			</p>
					        		</div>
					        		<p class="clearfix">
					        			<label class="pull-left"><input id="submit" type="button" value="保存"></label>
					        			<label class="pull-right"><input type="button" data-dismiss="modal" value="取消"></label>
					        		</p>
					        	</form>
					      	</div>
				    	</div>
				  	</div>
				</div>
				
				 
</e:point>		

