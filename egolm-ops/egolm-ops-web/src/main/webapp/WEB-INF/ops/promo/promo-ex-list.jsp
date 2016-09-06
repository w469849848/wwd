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
<e:resource title="促销管理" currentTopMenu="促销管理" currentSubMenu="" css="css/common-list.css" js="js/common.js" localJs="promo/promo.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/promo/promo-ex-list.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置：
					<a href="${webHost}/index">首页</a>
					&gt;
					<a href="${webHost}/promotion/list">促销管理</a>
					&gt;
					<a class="active" href="">排除商品</a>
				</p>
			</div>

			<div class="goods table-box">
				<!-- 模板列表 -->
				<form action="exList?promoDtl.sPromoPaperNO=${promo.sPromoPaperNO}&promoDtl.nTag=2" id="limitPageForm" method="post">
					<input type="hidden" name="page.index" value="${page.index}" />
					<input type="hidden" name="page.limit" value="20" />
				</form>
				<table class="footable table" data-page-size="13">
					<thead class="bg-color">
						<tr>
							<th data-hide="phone">活动编号</th>
							<th data-hide="phone">合同编号</th>
							<th data-hide="phone">活动主题</th>
							<th data-hide="phone">活动类型</th>
							<th data-hide="phone">活动名称</th>
							<th data-hide="phone">商品编号</th>
							<th data-hide="phone">商品名称</th>
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
								<td>${data.nGoodsID}</td>
								<td>${data.sGoodsDesc}</td>
								<td><a href="javascript:void(0);" onclick="PromoDelGoods('2', '${data.sPromoPaperNO}','${data.sAgentContractNO }','${data.nGoodsID }','','', '', '');">移除</a></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="13" class="clearfix">
								<div class="batch">
									<label>
										<input class="border border-radius bg-color f-50" type="button" onclick="PromoAddExGoods();" value="新增排除商品" />
										<%-- <input class="border border-radius bg-color f-50" type="button" onclick="javascript:window.location.href='exSelect?promo.sPromoPaperNO=${promo.sPromoPaperNO}'" value="新增排除商品" /> --%>
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

<script type="text/javascript">
function PromoAddExGoods() {
	$.jwindow({
		width: 1200,
		height: 600,
		title : "添加排除商品",
		url : "exSelect?promo.sPromoPaperNO=${promo.sPromoPaperNO}",
		type : "post",
		confirm : function(WinID) {
			var ids = [];
			var index = 0;
			$("#Selected").find("tr.rows").each(function() {
				TdArray = $(this).find("td");
				var nGoodsID,sGoodsDesc;
				for(var i = 0; i < TdArray.length; i++) {
					var text = $(TdArray[i]).text();
					ids[index] = (i==0) ? text : ids[index];
				}
				index++
			});
			$.ajax({
				url : "exSave?ex.sPromoPaperNO=${promo.sPromoPaperNO}&ex.sAgentContractNO=${promo.sAgentContractNO}",
				data : {"ids":JSON.stringify(ids)},
				dataType: "json",
				success : function(json) {
					if(json.IsValid) {
						$.closeJWindow(WinID);
						$.jalert({message: "操作成功", confirm:function() {window.location.reload(true);}});
					} else {
						$.jalert({message: "操作失败"});
					}
				}
			});
		}
	});
}
</script>