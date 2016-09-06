<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<style>
	.JWindowBody {left:50%;margin-left:-250px;top:50%;margin-top:-190px;}
	table {font-size:12px;}
	.table tbody>tr>td {height:34px;}
</style>
<e:resource title="促销管理" currentTopMenu="批量促销" currentSubMenu="" css="css/common-list.css" js="js/common.js" localJs="promo/promo.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/promo/promo-gift-select.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置：
					<a href="${webHost}/index">首页</a>
					&gt;
					<a href="${webHost}/promotion/list">促销管理</a>
					&gt;
					<a href="${webHost}/promotion/giftList?promo.sPromoPaperNO=${promo.sPromoPaperNO}">换购商品</a>
					&gt;
					<a class="active" href="">选择换购商品</a>
				</p>
			</div>

			<div class="goods table-box">
				<!-- 模板列表 -->
				<form action="giftSelect?promo.sPromoPaperNO=${promo.sPromoPaperNO}" id="limitPageForm" method="post">
					<input type="hidden" name="page.index" value="${page.index}" />
					<input type="hidden" name="page.limit" value="20" />
					<div class="filter-wrap">
						<label class="" style="width:400px;">
							<i class="icon-search f-95"></i><input style="width:350px;" class="filter border-radius bg-color" placeholder="检索关键字" name="searchText" value="${searchText}" type="text" />
						</label>
						<span class="pull-right">
							<span id="query">
								<a class="add-message" href="javascript:$.limitTo(1);">查询</a>
							</span>
						</span>
					</div>
				</form>
				<table class="footable table" data-page-size="13">
					<thead class="bg-color">
						<tr>
							<th>商品编号</th>
							<th>商品名称</th>
							<th>商品规格</th>
							<th>商品单位</th>
							<th>商品条码</th>
							<th>商品品牌</th>
							<th>商品分类</th>
							<th>经销商</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${datas}" var="data">
							<tr>
								<td>${data.nGoodsID}</td>
								<td>${data.sGoodsDesc}</td>
								<td>${data.sSpec}</td>
								<td>${data.sUnit}</td>
								<td>${data.sMainBarcode}</td>
								<td>${data.sBrand}</td>
								<td>${data.sCategoryDesc}</td>
								<td>${data.sAgentName}</td>
								<td style="width:130px;"><a href="javascript:void(0);" onclick="PromoAddGiftGoods('${promo.sPromoPaperNO}', '${promo.sAgentContractNO}', '${data.nGoodsID}');">添加到换购商品列表</a></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="13" class="clearfix">
								<div class="navigation_bar pull-right">
									<ul class="clearfix">
										<li><a href="javascript:$.limitTo(${page.index > 1 ? 1 : 0});" class="nav_first"></a></li>
										<li><a href="javascript:$.limitTo(${page.index - 1});" class="nav_float"></a></li>
										<c:forEach items="${page.pageIndexs}" var="idx"><li <c:if test="${idx eq page.index}">class="active"</c:if>><a href="javascript:$.limitTo(${idx});">${idx}</a></li></c:forEach>
										<li><a href="javascript:$.limitTo(${(page.index*page.limit >= page.total) ? 0 : page.index + 1});" class="nav_right"></a></li>
										<li><a href="javascript:$.limitTo(${page.index == page.pageTotal ? 0 : page.pageTotal});" class="nav_last"></a></li>
									</ul>
								</div>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</e:point>

