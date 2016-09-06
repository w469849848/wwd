<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
	dt{float:left;width:120px;}
	dd input,select {width:300px;}
</style>
<form action="saveGift" method="post" id="PromoGiftSaveForm">
	<input type="hidden" name="promoDtl.sPromoPaperNO" value="${promoDtl.sPromoPaperNO}"/>
	<input type="hidden" name="promoDtl.sAgentContractNO" value="${promoDtl.sAgentContractNO}"/>
	<input type="hidden" name="promoDtl.nGoodsID" value="${promoDtl.nGoodsID}"/>
	<dl>
		<dt><label>规则编号：</label></dt>
		<dd>
			<input type="text" name="promoDtl.nRuleID" class="required digits" />
		</dd>
	</dl>
	<dl>
		<dt><label>满足金额：</label></dt>
		<dd>
			<input type="text" name="promoDtl.nMeetAmount" class="required number" />
		</dd>
	</dl>
	<dl>
		<dt><label>换购金额：</label></dt>
		<dd>
			<input type="text" name="promoDtl.nPrice" class="required number" />
		</dd>
	</dl>
	<dl>
		<dt><label>换购积分：</label></dt>
		<dd>
			<input type="text" name="promoDtl.nPoint" class="required digits" />
		</dd>
	</dl>
	<dl>
		<dt><label>换购数量：</label></dt>
		<dd>
			<input type="text" name="promoDtl.nLimitQty" class="required number" />
		</dd>
	</dl>
	<dl>
		<dt><label>最大换购数量：</label></dt>
		<dd>
			<input type="text" name="promoDtl.nMaxLimitQty" class="required number" />
		</dd>
	</dl>
</form>
<script src="${pageContext.request.contextPath}/resources/js/jquery-validate-1.14.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/messages_zh.js"></script>
