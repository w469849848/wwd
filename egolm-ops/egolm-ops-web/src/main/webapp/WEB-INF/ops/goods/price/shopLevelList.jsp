<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="商铺等级设置"  currentTopMenu="商品价格管理" currentSubMenu="商铺等级设置" css="css/shopLevelList.css" js="js/common.js" localCss="" localJs="goods/price/shopLevelList.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/goods/price/shopLevelList.jsp">
				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								<a href="goodsPriceLevelList">首页</a> &gt; 
								<a href="shopLevelList">商品价格管理</a> &gt; 
								<a class="active" href="shopLevelList">商铺等级设置</a>
							</p>
						</div>
						
					<div class="audit table-box border-radius"> <!-- 审核表 -->
						<form action="shopLevelList" id="limitPageForm"  method= "post">
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
										<span id="shopLevelSpan">商铺等级</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<input type="hidden" id="shopLevel" name="shopLevel" value="${shopLevel }">
									<ul id="shopLevel-menu" class="dropdown-menu" aria-labelledby="shopLevel-id">
										 <li value=""><a id="" name="全部">全部</a></li>
									</ul>
								</label>
								<label class="label-shopName">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="店铺名称" name="sShopName" value="${shopName }" id="filter" type="text">
								</label>
								<lable>
									<span class="pull-right">
										 <a id="add" class="add-level" href="shopLevelEdit?type=add"><i class="add-icon"></i>新增</a><a id="query" class="add-level add-man" href="#">查询</a>
									</span>
								</lable>
							</div>
						</form>
							<table class="footable table even" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th data-toggle="true">商铺编号</th>
										<th data-toggle="true">商铺名称</th>
										<th data-toggle="true">商铺等级</th>
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
											<td>${d.sShopNO}</td>
											<td>${d.sShopName}</td>
											<td>${d.sLevelName }</td>
											<td>${d.dCreateUser}</td>
											<td>${d.dCreateDate}</td>
											<td>${d.dUpdateUser}</td>
											<td>${d.dUpdateDate}</td>
											<td>
												<a class="edit" href="shopLevelEdit?constractNO=${d.sAgentContractNO }&nLevel=${d.nLevelId }&sShopNO=${d.sShopNO }&shopName=${d.sShopName}&type=edit"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/edit.png" alt="编辑" /></a>
												<a class="delete" href="javascript:void(0)" nLevelId="${d.nLevelId }" sAgentContractNO="${d.sAgentContractNO }" sShopNO="${d.sShopNO }" ><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/delete.png" alt="删除" /></a>
												<%-- <a class="detail" href="agentEdit?nLevel=${d.nLevel }&type=detail">详情</a> --%>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="10" class="clearfix">
											<!-- <div class="batch">
												<label>
													<input type="checkbox" class="chk" />
													<span class="chk-bg"></span>
													<span class="txt">全选/取消</span>
												</label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量导出" onClick="exportExcel();"/></label>
											</div> -->
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