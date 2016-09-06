<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="商品价格管理"  currentTopMenu="商品价格管理" currentSubMenu="商品价格管理" css="css/goodsPriceLevelList.css" js="js/common.js" localCss="" localJs="goods/price/goodsPriceLevelList.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/goods/price/goodsPriceLevelList.jsp">
				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								<a href="goodsPriceLevelList">首页</a> &gt; 
								<a href="goodsPriceLevelList">商品价格管理</a> &gt; 
								<a class="active" href="goodsPriceLevelList">商品价格管理</a>
							</p>
						</div>
						
					<div class="audit table-box border-radius"> <!-- 审核表 -->
						<form action="goodsPriceLevelList" id="limitPageForm"  method= "post" >
							<input type="hidden" name="page.index" value="${page.index}"/>
							<input type="hidden" name="page.limit" value="10"/>
							<input type="hidden" name="type" value="${type }"/>
							<div class="filter-wrap">
								<label class="">
									<a id="constract-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span id="sConstractSpan">合同编号</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<input type="hidden" id="constractNO" name="constractNO" value="${constractNO }">
									<ul id="constract-menu" class="dropdown-menu" aria-labelledby="constract-id">
										 <li value=""><a id="" name="全部" >全部</a></li>
										 <c:forEach items="${constract }" var="c">
										 	<li><a id="${c.sAgentContractNO}" name="${c.sAgentContractNO}" >${c.sAgentContractNO}</a></li>
										 </c:forEach>
									</ul>
								</label>
								<label class="">
									<a id="shopLevel-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span id="shopLevelSpan">等级</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<input type="hidden" id="shopLevel" name="shopLevel" value="${shopLevel }">
									<ul id="shopLevel-menu" class="dropdown-menu" aria-labelledby="shopLevel-id">
										 <li value=""><a id="" name="全部">全部</a></li>
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
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="商品名称/商品编号" name="goodsDesc" value="${goodsDesc }" id="filter" type="text">
								</label>
								<lable>
									<span class="pull-right">
										<a id="add" class="add-level" href="goodsPriceLevelBatch">批量设置</a><a id="query" class="add-level add-man" href="#">查询</a>
									</span>
								</lable>
							</div>
						</form>
							<table class="footable table even" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th data-toggle="true">合同编号</th>
										<th data-toggle="true">商品名称</th>
										<th data-toggle="true">原价</th>
										<th data-hide="phone">设置价格</th>
										<th data-hide="phone">等级</th>
										<th data-hide="phone">创建用户</th>
										<th data-hide="phone">创建时间</th>
										<th data-hide="phone,tablet">修改用户</th>
										<th data-hide="phone,tablet">修改时间</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${datas}" var="d">
										<tr>
											<input type="hidden" id="acNO" value="${d.sAgentContractNO}" name="acNO">
											<input type="hidden" id="gid" value="${d.nGoodsID}" name="gid">
											<td>${d.sAgentContractNO}</td>
											<td>${d.sGoodsDesc}</td>
											<td>${d.nRealSalePrice }</td>
											<td class="td-3">
												<input type="text" id="nSalePrice" name="nSalePrice" oldValue="${d.nRealSalePrice }" value="${d.nSalePrice }" ></input>
											</td>
											<td>
												<input type="hidden" id="oldLevel" name="oldLevel" value="${d.nLevelID }">
												<c:choose>
													<c:when test="${d.lvList ne null}">
													    <select id="s-level" name="s-level" onchange="levelChange(this);">
															<option value="">选择等级</option>
															<c:forEach items="${d.lvList }" var="list">
																<c:choose>
																	<c:when test="${list.nLevel eq d.nLevelID }">
																		<option selected="selected" value="${list.nLevel }" >${list.sLevelName }</option>
																	</c:when>
																	<c:otherwise>
																		<option value="${list.nLevel }" disRate="${list.nDisRate }">${list.sLevelName }</option>
																	</c:otherwise>
																</c:choose>
															</c:forEach>
														</select>
													</c:when>
													<c:otherwise>
														${d.sLevelName}
													</c:otherwise>
												</c:choose>
											</td>
											<td>${d.sCreateUser}</td>
											<td>${d.dCreateDate}</td>
											<td>${d.sUpdateUser}</td>
											<td>${d.dUpdateDate}</td>
											<td>
												<a class="delete" href="javascript:goodsPriceLevelReset('${d.sAgentContractNO }','${d.nLevelId }','${d.nGoodsID }')" ><img src="${pageContext.request.contextPath}/resources/assets/images/reset.png" alt="删除" /></a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="10" class="clearfix">
											<div class="batch">
												<label><input class="border border-radius bg-color f-50" type="button" value="保存" onClick="savePage();"/></label>
											</div>
											<c:set var="pagerForm" value="limitPageForm" scope="request"/>
											<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
										</td>
									</tr>
									<%-- <tr>
										<td colspan="4" >
											当前设置只应用当前页
										</td>
										<td colspan="1" align="right">等级</td>
										<td colspan="2">
											<label class="foot-label">
												<a id="foot-shop-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
													<span id="foot-shopSpan">请选择</span>
													<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
												</a>
												<input type="hidden" id="foot-nlevel" name="foot-nlevel" value="">
												<ul id="foot-shop-menu" class="dropdown-menu" aria-labelledby="foot-shop-id">
												</ul>
											</label>
										</td>
										<td colspan="1" align="right">折扣率</td>
										<td colspan="2">
											<input id="foot-disRate" type="text" style="width: 20%;"></input>折</td>
											
									</tr>
									<tr>
										<td colspan="10" align="right"><label class="apply"><input class="border border-radius bg-color f-50" type="button" value="应用" onClick="exportExcel();"/></label></td>
									</tr> --%>
								</tfoot>
							</table>
						</div>
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
 </e:point>