<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
<form id="pagerForm" method="post" action="<%=request.getContextPath() %>/goods/tGoodsDealer/importSecond">
	<input type="hidden" name="pageNum" value="1" />  <!--【 必须】 value=1可以写死-->
	<input type="hidden" name="numPerPage" value="${model.numPerPage}" /> <!--【可选】每页显示多少条-->
	<input type="hidden" name="orderField" value="${param.orderField}" />  <!--【可选】查询排序-->
	<input type="hidden" name="orderDirection" value="${param.orderDirection}" />  <!--【可选】 升序降序-->
</form>
<div class="pageHeader">
	<form rel="pagerForm" onsubmit="return navTabSearch(this);" action="<%=request.getContextPath() %>/goods/tGoodsDealer/importSecond" method="post">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>合同编号:</label>
				ht001
			</li>
			<li>
				<label>商品名称/条码</label>
				<input type="text" name="sGoodsDescOrBarcode" value ="${sGoodsDescOrBarcode}"/>
			</li>
			 <li>
				<label>商品分类</label>
				<input type="text" name="sCategoryNO" value ="${sCategoryNO}"/>
			</li>
			<li>
				<label>品牌</label>
				<input type="text" name="sBrand" value ="${sBrand}"/>
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
	<div class="panelBar">
		<ul class="toolBar">
			 
			<li><a class="icon" href="#"><span>全选/取消</span></a></li>
			<li><a class="icon" href="<%=request.getContextPath() %>/goods/tGoodsDealer/importThird" target="navTab" rel="page4" title="商品导入第三步"><span>批量导入</span></a></li>
		   <li><a class="icon" href="<%=request.getContextPath() %>/goods/product/listGoods" target="dialog" rel="dlg_page4"  title="商品类据"><span>从资料库中选择商品</span></a></li>
			
		</ul>
	</div>

	<div id="w_list_print">
	<table class="list" width="98%" targetType="navTab" asc="asc" desc="desc" layoutH="116"   >
		<thead> 
			<tr>
				<th width="22"><input type="checkbox" group="ids" class="checkboxCtrl"></th>
				<th width="80">商品名称</th>
				<th width="80">保质期</th>
				<th width="80">规格</th>
				<th width="80">商品价格</th>
				<th width="80">包装数量</th>
				<th width="80">订货倍数</th> 
			</tr>
		</thead>
		<tbody> 
			     <c:forEach items="${tGoodsList }" var = "tGoods">
						<tr target="sid_obj" rel="${tGoods.nGoodsID }">
						   <td><input name="ids" value="xxx" type="checkbox">${tGoods.nGoodsID}</td>
							<td>${tGoods.sGoodsDesc }</td>
							<td>${tGoods.nShelfLife }</td>
							<td>${tGoods.sSpec}</td>
							<td>${tGoods.nNormalSalePrice }</td>
							<td>${tGoods.nCaseUnits }</td>
							<td>${tGoods.nOrderUnits }</td>
							</tr> 
 				 </c:forEach>
		</tbody>
	</table>
	</div>
	 

</div>