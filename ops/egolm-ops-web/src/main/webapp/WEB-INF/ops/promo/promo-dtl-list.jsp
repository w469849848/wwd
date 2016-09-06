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
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/promo/promo-dtl-list.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置：
					<a href="${webHost}/index">首页</a>
					&gt;
					<a href="${webHost}/promotion/list">促销管理</a>
					<c:if test="${promo.sPromoActionTypeID ne '6'}">
						&gt;
						<a class="active" href="javascript:void(0);">${promo.sPromoActionType}</a>
					</c:if>
					<c:if test="${promo.sPromoActionTypeID eq '6'}">
						&gt;
						<a href="${webHost}/promotion/giftList?promo.sPromoPaperNO=${promo.sPromoPaperNO}">换购商品</a>
						&gt;
						<a class="active" href="javascript:void(0);">${promo.sPromoActionType}</a>
					</c:if>
					
				</p>
			</div>

			<div class="goods table-box">
				<!-- 模板列表 -->
				<form action="view?promoDtl.sPromoPaperNO=${promoDtl.sPromoPaperNO}&promoDtl.nTag=0" id="limitPageForm" method="post">
					<input type="hidden" name="page.index" value="${page.index}" /> <input type="hidden" name="page.limit" value="20" />
				</form>
				<table class="footable table" data-page-size="13">
					<thead class="bg-color">
						<tr>
							<th data-hide="phone">活动编号</th>
							<th data-hide="phone">合同编号</th>
							<th data-hide="phone">活动主题</th>
							<th data-hide="phone">活动类型</th>
							<th data-hide="phone">活动名称</th>
							<c:if test="${promo.sSettingModeID eq 'G'}">
								<th data-hide="phone">商品编号</th>
								<th data-hide="phone">商品名称</th>
							</c:if>
							<c:if test="${promo.sSettingModeID eq 'B'}">
								<th data-hide="phone">品牌编号</th>
								<th data-hide="phone">品牌名称</th>
							</c:if>
							<c:if test="${promo.sSettingModeID eq 'C'}">
								<th data-hide="phone">分类编号</th>
								<th data-hide="phone">分类名称</th>
							</c:if>
							<c:if test="${promo.sPromoActionTypeID eq '1'}">
								<th data-hide="phone">满足数量</th>
								<th data-hide="phone">活动单价</th>
							</c:if>
							<c:if test="${promo.sPromoActionTypeID eq '2'}">
								<th data-hide="phone">满足数量</th>
								<th data-hide="phone">活动单价</th>
								<th data-hide="phone">包装总价</th>
							</c:if>
							<c:if test="${promo.sPromoActionTypeID eq '3'}">
								<th data-hide="phone">组合编号</th>
								<th data-hide="phone">满足数量</th>
								<th data-hide="phone">活动单价</th>
							</c:if>
							<c:if test="${promo.sPromoActionTypeID eq '4'}">
								<th data-hide="phone">规则编号</th>
								<th data-hide="phone">满足金额</th>
								<th data-hide="phone">折扣金额</th>
							</c:if>
							<c:if test="${promo.sPromoActionTypeID eq '5'}">
								<th data-hide="phone">规则编号</th>
								<th data-hide="phone">满足金额</th>
								<th data-hide="phone">折扣比例</th>
							</c:if>
							<c:if test="${promo.sPromoActionTypeID eq '6'}">
								<th data-hide="phone">规则编号</th>
							</c:if>
							<th data-hide="phone">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${datas}" var="data">
							<tr>
								<td>${data.sPromoPaperNO}</td>
								<td>${data.sAgentContractNO}</td>
								<td>${data.sPromoTheme}</td>
								<td>${data.sPromoActionType}</td>
								<td>${data.sPromoName}</td>
								<c:if test="${promo.sSettingModeID eq 'G'}">
									<td>${data.nGoodsID}</td>
									<td>${data.sGoodsDesc}</td>
								</c:if>
								<c:if test="${promo.sSettingModeID eq 'B'}">
									<td>${data.sBrandID}</td>
									<td>${data.sBrandName}</td>
								</c:if>
								<c:if test="${promo.sSettingModeID eq 'C'}">
									<td>${data.sCategoryNO}</td>
									<td>${data.sCategoryDesc}</td>
								</c:if>
								<c:if test="${promo.sPromoActionTypeID eq '1'}">
									<td>${data.nMeetQty}</td>
									<td>${data.nPrice}</td>
								</c:if>
								<c:if test="${promo.sPromoActionTypeID eq '2'}">
									<td>${data.nMeetQty}</td>
									<td>${data.nPrice}</td>
									<td>${data.nAmount}</td>
								</c:if>
								<c:if test="${promo.sPromoActionTypeID eq '3'}">
									<td>${data.sGroupNO}</td>
									<td>${data.nMeetQty}</td>
									<td>${data.nPrice}</td>
								</c:if>
								<c:if test="${promo.sPromoActionTypeID eq '4'}">
									<td>${data.nRuleID}</td>
									<td>${data.nMeetAmount}</td>
									<td>${data.nDisAmount}</td>
								</c:if>
								<c:if test="${promo.sPromoActionTypeID eq '5'}">
									<td>${data.nRuleID}</td>
									<td>${data.nMeetAmount}</td>
									<td>${data.nDisRate}</td>
								</c:if>
								<c:if test="${promo.sPromoActionTypeID eq '6'}">
									<td>${data.nRuleID}</td>
								</c:if>
								<td><a href="javascript:void(0);" onclick="PromoDelGoods('0', '${data.sPromoPaperNO}','${data.sAgentContractNO }','${data.nGoodsID }','${data.sBrandID }','${data.sCategoryNO }', '${data.sGroupNO}', '${data.nRuleID}');">移除</a></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="13" class="clearfix">
								<div class="batch">
									<label>
										<c:if test="${promo.sSettingModeID eq 'A'}">
											<input class="border border-radius bg-color f-50" type="button" onclick="PromoAddGoods('${promo.sPromoPaperNO}', '${promo.sAgentContractNO}', '', '', '');" value="新增规则" />
										</c:if>
										<c:if test="${promo.sSettingModeID ne 'A'}">
											<input class="border border-radius bg-color f-50" type="button" onclick="javascript:window.location.href='selectDtl?promo.sPromoPaperNO=${promo.sPromoPaperNO}&nRuleID=${promoDtl.nRuleID}'" value="新增" />
										</c:if>
									</label>
								</div>
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

