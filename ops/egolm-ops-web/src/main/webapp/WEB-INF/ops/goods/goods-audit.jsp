<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="商品审核"  currentTopMenu="商品管理" currentSubMenu="商品审核" css="css/goods-audit.css" js="js/common.js" localCss="" localJs="goods/goods-audit.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/goods/goods-audit.jsp">
  

					<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="#">商品管理</a> &gt; 
								<a class="active" href="${webHost}/dealer/acGoods/list">商品审核</a>
							</p>
						</div>
						
						<div class="goods table-box"> <!-- 商品表 -->
						<form action="list" id="limitPageForm" method="post">
							  <input type="hidden" name="page.index" value="${page.index}" /> 
						
							<div class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="表单单号/合同编码" id="selectNo" name="selectNo" type="text"  value="${selectNo }"/>
								</label>
								
								
								<label class="filter-select dropdown-wrap adv-margin">
 								<input type="hidden" name="sOrgNO" id="sOrgNO" value="${sOrgNO }"> 
									<a id="zoneCode-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>区域</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="zoneCode-menu" class="dropdown-menu" aria-labelledby="zoneCode-id">
										 
									</ul>
								</label>
								
								
								<label class="filter-select dropdown-wrap">
								<input type="hidden" id ="sCategoryNO" name ="sCategoryNO"  value="${sCategoryNO }"/> 
									<a id="contract-type" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span  class="item-name">商品分类</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="category-memu" class="dropdown-menu lv-first no-scroll" aria-labelledby="contract-type">
									 
									</ul>
								</label>
								<label class="filter-select dropdown-wrap">
								<input type="hidden" id ="nTag" name ="nTag"  value="${nTag }"/> 
									<a id="ntag-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span  class="item-name">审核状态</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="ntag-memu" class="dropdown-menu" aria-labelledby="ntag-id">
										<li value='-1'>全部</li>
									    <li value="0">未审核</li>
									    <li value="2">通过</li>
									    <li value="8">部分通过</li>
									    <li value="16">驳回</li> 
									</ul>
								</label>
								  <span class="pull-right">
										<span id="query"><a class="add-message" href="#">查询</a> </span>
								</span>
							</div>
							</form>
							<table class="footable table" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th data-toggle="true">表单单号</th>
										<th data-hide="phone">合同编码</th>
										<th data-hide="phone">经销商ID</th>
										<th data-hide="phone,tablet">更新类型</th>
										<th>变更类型</th>
										<th>变更人</th>
										<th>变更日期</th>
										<th data-hide="phone">状态</th>
										<th>管理</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${aCGoodsList}" var="aCGoods">
									<tr>
										<td>${aCGoods.sPaperNO}</td>
										<td>${aCGoods.sAgentContractNO}</td>
										<td>${aCGoods.nAgentID}</td>
										<td>${aCGoods.sUpdateTypeID}</td>
										<td>${aCGoods.sAlterType}</td>
										<td>${aCGoods.sAlterUser}</td>
										<td><fmt:formatDate value="${aCGoods.dAlterDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td> 
											 <c:if test="${aCGoods.nTag ==0 }">
											    <span class="state"><img src="${resourceHost}/images/close.png"/></span>未审核
											 </c:if>
											 <c:if test="${aCGoods.nTag ==2 }">
											   <span class="state"><img src="${resourceHost}/images/circle.png"/></span>通过
											 </c:if>
											 <c:if test="${aCGoods.nTag ==8 }">
											   <span class="state"><img src="${resourceHost}/images/partly-by.png"/></span>部分通过
											 </c:if> 
											 <c:if test="${aCGoods.nTag ==16 }">
											    <span class="state"><img src="${resourceHost}/images/close.png"/></span>驳回
											 </c:if> 
										 </td>
										<td>
											<a class="detail" href="${webHost}/dealer/acGoodsDtl/toDtlPage?sPaperNO=${aCGoods.sPaperNO}">详情</a>
										</td>
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

