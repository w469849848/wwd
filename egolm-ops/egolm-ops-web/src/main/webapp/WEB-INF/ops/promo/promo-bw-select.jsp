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
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/promo/promo-bw-select.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置：
					<a href="${webHost}/index">首页</a>
					&gt;
					<a href="${webHost}/promotion/list">促销管理</a>
					&gt;
					<a href="${webHost}/promotion/bwList?promo.sPromoPaperNO=${promo.sPromoPaperNO}">名单管理</a>
					&gt;
					<a class="active" href="">名单选择</a>
				</p>
			</div>

			<div class="goods table-box">
				<!-- 模板列表 -->
				<form action="bwSelect?promo.sPromoPaperNO=${promo.sPromoPaperNO}" id="limitPageForm" method="post">
					<input type="hidden" name="page.index" value="${page.index}" />
					<input type="hidden" name="page.limit" value="20" />
				</form>
				<table class="footable table" data-page-size="13">
					<thead class="bg-color">
						<tr>
							<th data-hide="phone">活动编号</th>
							<th data-hide="phone">活动主题</th>
							<th data-hide="phone">活动名称</th>
							<th data-hide="phone">客户编号</th>
							<th data-hide="phone">客户名称</th>
							<th data-hide="phone">商铺编号</th>
							<th data-hide="phone">商铺名称</th>
							<th data-hide="phone">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${datas}" var="data">
							<tr>
								<td>${promo.sPromoPaperNO}</td>
								<td>${promo.sPromoTheme}</td>
								<td>${promo.sPromoName}</td>
								<td>${data.sCustNO}</td>
								<td>${data.sCustName}</td>
								<td>${data.sShopNO}</td>
								<td>${data.sShopName}</td>
								<td><a href="javascript:AjaxToAddBWList('${promo.sPromoPaperNO}', '${data.sShopNO}');">添加到名单</a></td>
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

