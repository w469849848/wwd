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
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/promo/promo-list.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置：
					<a href="${webHost}/index">首页</a>
					&gt;
					<a class="active" href="javascript:void(0);">促销管理</a>
				</p>
			</div>

			<div class="goods table-box">
				<!-- 模板列表 -->
				<form action="list" id="limitPageForm" method="post">
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
							<th data-hide="phone">活动编号</th>
							<th data-hide="phone">活动主题</th>
							<th data-hide="phone">活动类型</th>
							<th data-hide="phone">活动名称</th>
							<th data-hide="phone">活动状态</th>
							<th data-hide="phone">是否同步</th>
							<th data-hide="phone">参与终端</th>
							<th data-hide="phone">设置方式</th>
							<th data-hide="phone">区域编号</th>
							<th data-hide="phone">开始时间</th>
							<th data-hide="phone">结束时间</th>
							<th data-hide="phone">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${datas}" var="data">
							<tr>
								<td>${data.sPromoPaperNO}</td>
								<td>${data.sPromoTheme}</td>
								<td>${data.sPromoActionType}</td>
								<td>${data.sPromoName}</td>
								<td>
									<c:if test="${data.nTag eq 0}">预设置</c:if>
									<c:if test="${data.nTag eq 1}">已删除</c:if>
									<c:if test="${data.nTag eq 2}">已审核</c:if>
									<c:if test="${data.nTag eq 3}">已终止</c:if>
								</td>
								<td style="color:${data.nSync ne 1 ? 'red' : ''}">
									<c:if test="${data.nSync eq 1}">已同步</c:if>
									<c:if test="${data.nSync ne 1}">未同步</c:if>
								</td>
								<td>${data.sTerminalType}</td>
								<td>
									<c:if test="${data.sSettingModeID eq 'G'}">商品</c:if>
									<c:if test="${data.sSettingModeID eq 'C'}">分类</c:if>
									<c:if test="${data.sSettingModeID eq 'B'}">品牌</c:if>
									<c:if test="${data.sSettingModeID eq 'A'}">全部商品</c:if>
								</td>
								<td>${data.sOrgNO}</td>
								<td><fmt:formatDate value="${data.dPromoBeginDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td><fmt:formatDate value="${data.dPromoEndDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
								<td>
									<c:if test="${data.nTag ne 3 && data.nSync ne 1}">
										<a href="javascript:AjaxFlushPromo('${data.sPromoPaperNO}', '${data.sPromoName}');">同步数据</a>
										<a href="javascript:ToEditPromoMain('${data.sPromoPaperNO}');">修改主单</a>
										<a href="setting?promo.sPromoPaperNO=${data.sPromoPaperNO}">设置活动</a>
										<c:if test="${data.sBWListTypeID ne 'A'}"><a href="bwList?promo.sPromoPaperNO=${data.sPromoPaperNO}">黑白名单</a></c:if>
										<c:if test="${data.sSettingModeID ne 'G'}"><a href="exList?promoDtl.sPromoPaperNO=${data.sPromoPaperNO}&promoDtl.nTag=2">排除设置</a></c:if>
									</c:if>
									<c:if test="${data.nTag ne 3}">
										<a href="javascript:AjaxDeletePromoByID('${data.sPromoPaperNO}');">终止活动</a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="13" class="clearfix">
								<div class="batch">
									<label>
										<input class="border border-radius bg-color f-50" type="button" onclick="ToEditPromoMain();" value="新增促销" />
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

