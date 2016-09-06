<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="仓库商品管理"  currentTopMenu="仓库管理" currentSubMenu="仓库商品管理" css="css/warehouseGoodsList.css" js="js/common.js" localCss="" localJs="dealer/warehouse/warehouseGoodsList.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/dealer/warehouse/warehouseGoodsList.jsp">
				<div class="main-content">
					<div class="page-content">
						<div class="wh_titer">
							<p class="wh_titer_f">
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="warehouseList">仓库管理</a> &gt; 
								<a class="active" href="warehouseGoodsList">仓库商品管理</a>
							</p>
						</div>
					<div class="whgoods audit table-box border-radius"> <!-- 审核表 -->
						<form action="warehouseGoodsList" id="limitPageForm"  method= "post" >
							<input type="hidden" name="page.index" value="${page.index}"/>
							<input type="hidden" name="page.limit" value="10"/>
							<div class="filter-wrap">
								<label class="">
									<a id="agent-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span id="agentSpan">经销商</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<input type="hidden" id="nAgentID" name="nAgentID" value="${nAgentID }">
									<input type="hidden" id="sAgentName" name="sAgentName" value="${sAgentName }">
									<ul id="agent-menu" class="dropdown-menu" aria-labelledby="agent-id">
										 <li value=""><a id="" name="全部" >全部</a></li>
										 <c:forEach items="${agent }" var="a">
										 	<li><a id="${a.nAgentID}" name="${a.nAgentID}" >${a.sAgentName}</a></li>
										 </c:forEach>
									</ul>
								</label>
								<label class="">
									<a id="warehouse-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span id="warehouseSpan">仓库</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<input type="hidden" id="sWarehouseNO" name="sWarehouseNO" value="${sWarehouseNO }">
									<ul id="warehouse-menu" class="dropdown-menu" aria-labelledby="warehouse-id">
										 <li value=""><a id="" name="全部" >全部</a></li>
									</ul>
								</label>
								<label class="">
									<a id="category-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span id="categorySpan">商品分类</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<input type="hidden" id="categoryID" name="categoryID" value="${categoryID }">
									<ul id="category-menu" class="dropdown-menu" aria-labelledby="category-id">
										 <li value=""><a id="" name="全部">全部</a></li>
									</ul>
								</label>
								<label class="">
									<a id="brand-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span id="brandSpan">商品品牌</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<input type="hidden" id="brandID" name="brandID" value="${brandID }">
									<ul id="brand-menu" class="dropdown-menu" aria-labelledby="brand-id">
										 <li value=""><a id="" name="全部">全部</a></li>
									</ul>
								</label>
								<label class="label-shopName">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="商品名称/商品条码" name="goodsDesc" value="${goodsDesc }" id="filter" type="text">
								</label>
								<lable>
									<span class="pull-right">
										<a id="query" class="add-level add-man" href="#">查询</a>
									</span>
								</lable>
							</div>
						</form>
							<table class="footable table even" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th></th>
										<th data-toggle="true">仓库编号</th>
										<th data-toggle="true">仓库</th>
										<th data-toggle="true">商品条码</th>
										<th data-toggle="true">商品名称</th>
										<th data-toggle="true">库存</th>
										<th data-hide="phone">零售价格</th>
										<th data-hide="phone">零售单位</th>
										<th data-hide="phone">状态</th>
										<!-- <th></th> -->
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${datas}" var="d">
										<tr>
											<td>	
												<input type="hidden" id="gid" value="${d.nGoodsID}" name="gid">
												<input type="hidden" id="whNO" value="${d.sWarehouseNO}" name="whNO">
												<label class='checked-wrap'>
													<input type='checkbox' class='chk goods-check' name='${d.sGoodsDesc}'  data-id='${d.nGoodsID}'/>
													<input type="hidden" id="nTag_${d.nGoodsID}" value="${d.nTag}">
													<input type="hidden" id="tagName_${d.nGoodsID}" value="${d.tagName}">
													<input type="hidden" id="sAgentContractNO_${d.nGoodsID}" value="${d.sAgentContractNO }">
													<input type='hidden'   id='nAgentID_${d.nGoodsID}' value='${d.nAgentID }'  />
													<span class="chk-bg"></span>
												</label>
											</td>
											<td>${d.sWarehouseNO}</td>
											<td>${d.sWarehouseName}</td>
											<td>${d.sMainBarcode}</td>
											<td>${d.sGoodsDesc}</td>
											<td><input type="text" id="nStockQty" name="nStockQty" value="<fmt:formatNumber value="${d.nStockQty}" type="currency" pattern="#"/>" ></input></td>
											<td><input type="text" id="nPrice" name="nPrice" value="${d.nPrice }" ></input></td>
											<td><input type="text" id="sUnit" name="sUnit" value="${d.sUnit }" ></input></td>
											<td>${d.tagName=='down'?'已下架':'已上架' }</td>
											<%-- <td>
												<c:choose>
													<c:when test="">
														<a class="delete" href="javascript:goodsPutawayOrUnShelve('${d.nGoodsID }','0')" >下架</a>
													</c:when>
													<c:otherwise>
														<a class="delete" href="javascript:goodsPutawayOrUnShelve('${d.nGoodsID }','1')" >下架</a>
													</c:otherwise>
												</c:choose>
											</td> --%>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="10" class="clearfix">
											<div class="batch">
												<label>
													<input type="checkbox" class="chk check-all" />
													<span class="chk-bg"></span>
													<span class="txt">全选/取消</span>
												</label>
												<label><input id="up" class="border border-radius up_down bg-color f-50" type="button" value="批量上架" /></label>
												<label><input id="down" class="border border-radius up_down bg-color f-50" type="button" value="批量下架" /></label>
												<label><input class="border border-radius bg-color f-50" type="button" value="保存" onclick="savePage()"/></label>
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