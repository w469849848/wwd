<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
<form id="pagerForm" method="post" action="<%=request.getContextPath() %>/api/adPos/list">
	<input type="hidden" name="pageNum" value="1" />  <!--【 必须】 value=1可以写死-->
	<input type="hidden" name="numPerPage" value="${model.numPerPage}" /> <!--【可选】每页显示多少条-->
	<input type="hidden" name="orderField" value="${param.orderField}" />  <!--【可选】查询排序-->
	<input type="hidden" name="orderDirection" value="${param.orderDirection}" />  <!--【可选】 升序降序-->
</form>
<div class="pageHeader">
	<form rel="pagerForm" onsubmit="return navTabSearch(this);" action="<%=request.getContextPath() %>/api/adPos/list" method="post">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>合同编号:</label>
				ht001
			</li>
			<li>
				<label>商品名称/条码</label>
				<input type="text" name="sApTitle"/>
			</li>
		 
		</ul>
		 
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li>
				<li><a class="button" href="demo_page6.html" target="dialog" mask="true" title=""><span>高级检索</span></a></li>
			</ul>
		</div>
	</div>
	</form>
</div>

<div class="pageContent"> 
 <form method="post" action="<%=request.getContextPath() %>/goods/tGoodsDealer/submitAgentContractGoods" class="pageForm required-validate" enctype="multipart/form-data" onsubmit="return iframeCallback(this);">

	<div id="w_list_print">
	 	<table class="list" width="98%" targetType="navTab" asc="asc" desc="desc" layoutH="116"   >
		<thead> 
			<tr>
				<th width="22"><input type="checkbox" group="ids" class="checkboxCtrl"></th>
				<th width="80">商品名称</th>
				<th width="50">订货倍数</th>
				<th width="50">最低起订量</th>
				<th width="50">建议零售价</th>
				<th width="50">建议零售单位</th>
				<th width="120">推荐描述</th> 
			</tr>
		</thead>
		<tbody> 
			     <c:forEach items="${tGoodsList }" var = "tGoods">
						<tr target="sid_obj" rel="${tGoods.nGoodsID }">
						     
						    <td><input name="boxs"  type="checkbox"></td>
							<td>${tGoods.sGoodsDesc }</td>
							 <td><input name="nSaleUints" value="${tGoods.nOrderUnits}" type="text"></td>
							<td><input name="nMinSaleQty" value="${tGoods.nGoodsID}" type="text"></td>
							<td><input name="nRealSalePrice" value="" type="text"></td>
							<td><input name="sUnit" value="${tGoods.sUnit}" type="text"></td>
							<td><input name="sMemo" value="${tGoods.sMemo}" type="text"></td>
							
							<input type = "hidden" name = "tGoodsIds" value = "${tGoods.nGoodsID}"/>
							<input type = "hidden" name = "sMainBarcode" value = "${tGoods.sMainBarcode}"/>
							<input type = "hidden" name = "sGoodsDesc" value = "${tGoods.sGoodsDesc}"/>
							<input type = "hidden" name = "sSpec" value = "${tGoods.sSpec}"/>
							<input type = "hidden" name = "sHome" value = "${tGoods.sHome}"/>
							<input type = "hidden" name = "nSalePrice" value = "${tGoods.nNormalSalePrice}"/>
							<input type = "hidden" name = "nLifeCycle" value = "${tGoods.nLifeCycle}"/> 
						</tr> 
 				 </c:forEach>
		</tbody>
	</table>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">提交</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
	</div>
	</form>
	
 
</div>