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
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/promo/setting.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置：
					<a href="${webHost}/index">首页</a>
					&gt;
					<a href="list">促销管理</a>
					&gt;
					<a class="active" href="${webHost}/promotion/setting?promo.sPromoPaperNO=${promo.sPromoPaperNO}">促销设置</a>
				</p>
			</div>
			<form id="saveDtl" action="saveDtl">
				<div style="display:none;">
					<input type="hidden" name="promoDtl.sPromoPaperNO">
					<input type="hidden" name="promoDtl.sAgentContractNO">
				</div>
				<div id="PromoDtl" style="display:none;">
				
				</div>
			</form>
			<c:if test="${promo.sPromoActionTypeID eq '1' || promo.sPromoActionTypeID eq '2'}"><%@ include file="settings/batch.jsp" %></c:if>
			<c:if test="${promo.sPromoActionTypeID eq '4' || promo.sPromoActionTypeID eq '5'}"><%@ include file="settings/fullcut.jsp" %></c:if>
			<c:if test="${promo.sPromoActionTypeID eq '6'}"><%@ include file="settings/gift.jsp" %></c:if>
			<c:if test="${promo.sPromoActionTypeID eq '3'}"><%@ include file="settings/group.jsp" %></c:if>
		</div>
	</div>
</e:point>

