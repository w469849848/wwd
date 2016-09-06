<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
	dt{float:left;width:120px;}
	dd input,select {width:300px;}
	.checkbox input[type=checkbox]{width:auto;float:none;margin-left:2px;-webkit-appearance:checkbox;}
</style>
<form action="save" method="post" id="PromoCreateForm">
	<input type="hidden" name="promo.sPromoPaperNO" value="${promo.sPromoPaperNO}"/>
	<dl>
		<dt><label>活动类型：</label></dt>
		<dd>
			<c:if test="${not empty promo.sPromoActionTypeID}">
				<input type="hidden" name="promo.sPromoActionTypeID" value="${promo.sPromoActionTypeID}" />
				<input type="text" name="promo.sPromoActionType" readonly="readonly" value="${promo.sPromoActionType}">
			</c:if>
			<c:if test="${empty promo.sPromoActionTypeID}">
				<select id="promo_sPromoActionTypeID" name="promo.sPromoActionTypeID" onchange="javascript:changePromoActionTypeID()">
					<option value="1" <c:if test="${promo.sPromoActionTypeID eq 1}">selected</c:if>>批量促销</option>
					<option value="2" <c:if test="${promo.sPromoActionTypeID eq 2}">selected</c:if>>包装折扣</option>
					<option value="3" <c:if test="${promo.sPromoActionTypeID eq 3}">selected</c:if>>组合折扣</option>
					<option value="4" <c:if test="${promo.sPromoActionTypeID eq 4}">selected</c:if>>满减促销</option>
					<option value="5" <c:if test="${promo.sPromoActionTypeID eq 5}">selected</c:if>>满折促销</option>
					<option value="6" <c:if test="${promo.sPromoActionTypeID eq 6}">selected</c:if>>换购促销</option>
				</select>
				<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
				<input id="promo_sPromoActionType" type="hidden" name="promo.sPromoActionType" />
				<script type="text/javascript">
					function changePromoActionTypeID() {
						var promoTypeID = $("#promo_sPromoActionTypeID").val();
						if(promoTypeID == 1) {
							$("#promo_sPromoActionType").val("批量促销");
						} else if(promoTypeID == 2) {
							$("#promo_sPromoActionType").val("包装折扣");
						} else if(promoTypeID == 3) {
							$("#promo_sPromoActionType").val("组合折扣");
						} else if(promoTypeID == 4) {
							$("#promo_sPromoActionType").val("满减促销");
						} else if(promoTypeID == 5) {
							$("#promo_sPromoActionType").val("满折促销");
						} else if(promoTypeID == 6) {
							$("#promo_sPromoActionType").val("换购促销");
						}
						if(promoTypeID == 1 || promoTypeID == 2 || promoTypeID == 3) {
							changeSettingModeID_G(true);
						} else {
							changeSettingModeID_G(false);
						}
					}
					function changeSettingModeID_G(boo) {
						if(boo) {
							$("#promo_sSettingModeID").hide();
							$("#dr_promo_sSettingModeID").hide();
							$("#promo_sSettingModeID").attr("name", "");
							$("#promo_sSettingModeID_Box").find("input").remove();
							$("#promo_sSettingModeID_Box").find("font").remove();
							$("#promo_sSettingModeID_Box").append("<input type='hidden' name='promo.sSettingModeID' value='G'/><input type='text' readonly value='商品'/>");
						} else {
							$("#promo_sSettingModeID_Box").find("input").remove();
							$("#promo_sSettingModeID").attr("name", "promo.sSettingModeID");
							$("#promo_sSettingModeID").show();
							$("#dr_promo_sSettingModeID").show();
						}
					}
					$(document).ready(function() {
						changePromoActionTypeID();
					});
				</script>
			</c:if>
		</dd>
	</dl>
	<dl>
		<dt><label>设置方式：</label></dt>
		<dd id="promo_sSettingModeID_Box">
			<c:if test="${empty promo.sSettingModeID}">
				<select id="promo_sSettingModeID" name="promo.sSettingModeID" class='required'>
					<option value="A" <c:if test="${promo.sSettingModeID eq 'A'}">selected</c:if>>全部商品</option>
					<option value="B" <c:if test="${promo.sSettingModeID eq 'B'}">selected</c:if>>品牌</option>
					<option value="G" <c:if test="${promo.sSettingModeID eq 'G'}">selected</c:if>>商品</option>
					<option value="C" <c:if test="${promo.sSettingModeID eq 'C'}">selected</c:if>>分类</option>
				</select>
				<span id="dr_promo_sSettingModeID" class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
			</c:if>
			<c:if test="${not empty promo.sSettingModeID}">
				<input type="hidden" name="promo.sSettingModeID" value="${promo.sSettingModeID}" />
				<c:if test="${promo.sSettingModeID eq 'A'}"><input type="text" readonly="readonly" value="全部商品"/></c:if>
				<c:if test="${promo.sSettingModeID eq 'B'}"><input type="text" readonly="readonly" value="品牌"/></c:if>
				<c:if test="${promo.sSettingModeID eq 'G'}"><input type="text" readonly="readonly" value="商品"/></c:if>
				<c:if test="${promo.sSettingModeID eq 'C'}"><input type="text" readonly="readonly" value="分类"/></c:if>
			</c:if>
		</dd>
	</dl>
	<dl>
		<dt><label>活动区域：</label></dt>
		<dd>
			<c:if test="${not empty promo.sOrgNO}">
				<input type="hidden" name="promo.sOrgNO" value="${promo.sOrgNO}" />
				<c:forEach items="${orgs}" var="org">
					<c:if test="${promo.sOrgNO eq org.sOrgNO}">
						<input type="text" name="promo.sOrg" value="${org.sOrgDesc}" readonly="readonly" />
					</c:if>
				</c:forEach>
			</c:if>
			<c:if test="${empty promo.sOrgNO}">
				<select id="promo_sOrgNO" name="promo.sOrgNO" onchange="changeOrgNO();" class='required'>
					<c:forEach var="org" items="${orgs}" varStatus="vs" >
						<option <c:if test="${promo.sOrgNO eq org.sOrgNO}">selected</c:if> value="${org.sOrgNO}">${org.sOrgDesc}</option>
					</c:forEach>
				</select>
				<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
				<script type="text/javascript">
					function changeOrgNO() {
						var sOrgNO = $("#promo_sOrgNO").val();
						$.ajax({
							url : "queryContractsByOrgNO",
							type : "post",
							data : {sOrgNO:sOrgNO},
							dataType : "json",
							success : function(json) {
								if(json.IsValid) {
									$("#promo_sAgentContractNO").html("");
									$(json.DataList).each(function() {
										$("#promo_sAgentContractNO").append("<option value='" + this.sAgentContractNO + "'>" + this.sAgentContractNO + "</option>");
									});
								}
							}
						});
					}
					$(document).ready(function() {
						changeOrgNO();
					});
				</script>
			</c:if>
		</dd>
	</dl>
	<dl>
		<dt><label>合同编号：</label></dt>
		<dd>
			<c:if test="${not empty promo.sAgentContractNO}">
				<input type="text" name="promo.sAgentContractNO" value="${promo.sAgentContractNO}" readonly="readonly" />
			</c:if>
			<c:if test="${empty promo.sAgentContractNO}">
				<select id="promo_sAgentContractNO" name="promo.sAgentContractNO" class='required'>
					<option value="">经销商合同编号</option>
				</select>
				<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
			</c:if>
		</dd>
	</dl>
	<dl>
		<dt><label>终端类型：</label></dt>
		<dd class="checkbox">
			<input <c:if test="${fn:contains(terminals, 1) || empty promo.nTerminalTypeID}">checked</c:if> type="checkbox" name="nTerminalTypeID" value="1"/>微信
			<input <c:if test="${fn:contains(terminals, 2) || empty promo.nTerminalTypeID}">checked</c:if> type="checkbox" name="nTerminalTypeID" value="2"/>网页
			<input <c:if test="${fn:contains(terminals, 4) || empty promo.nTerminalTypeID}">checked</c:if> type="checkbox" name="nTerminalTypeID" value="4"/>安卓
			<input <c:if test="${fn:contains(terminals, 6) || empty promo.nTerminalTypeID}">checked</c:if> type="checkbox" name="nTerminalTypeID" value="8"/>苹果
		</dd>
	</dl>
	<dl>
		<dt><label>生效周期：</label></dt>
		<dd class="checkbox">
			<input <c:if test="${fn:contains(cycles, 1) || empty promo.nUseCycle}">checked</c:if> type="checkbox" name="nUseCycle" value="1"/>周一
			<input <c:if test="${fn:contains(cycles, 2) || empty promo.nUseCycle}">checked</c:if> type="checkbox" name="nUseCycle" value="2"/>周二
			<input <c:if test="${fn:contains(cycles, 4) || empty promo.nUseCycle}">checked</c:if> type="checkbox" name="nUseCycle" value="4"/>周三
			<input <c:if test="${fn:contains(cycles, 8) || empty promo.nUseCycle}">checked</c:if> type="checkbox" name="nUseCycle" value="8"/>周四
			<input <c:if test="${fn:contains(cycles, 16) || empty promo.nUseCycle}">checked</c:if> type="checkbox" name="nUseCycle" value="16"/>周五
			<input <c:if test="${fn:contains(cycles, 32) || empty promo.nUseCycle}">checked</c:if> type="checkbox" name="nUseCycle" value="32"/>周六
			<input <c:if test="${fn:contains(cycles, 64) || empty promo.nUseCycle}">checked</c:if> type="checkbox" name="nUseCycle" value="64"/>周日
		</dd>
	</dl>
	<dl>
		<dt><label>促销主题：</label></dt>
		<dd><input type="text" name="promo.sPromoTheme" class="required" value="${promo.sPromoTheme}" /></dd>
	</dl>
	<dl>
		<dt><label>活动名称：</label></dt>
		<dd><input type="text" name="promo.sPromoName" class="required" value="${promo.sPromoName }"/></dd>
	</dl>
	<dl>
		<dt><label>开始时间：</label></dt>
		<dd>
			<input id="PromoBeginDate" type="text" name="promo.dPromoBeginDate" class="required dateISO" value="<fmt:formatDate value="${promo.dPromoBeginDate}" pattern="yyyy-MM-dd"/>" />
		</dd>
	</dl>
	<dl>
		<dt><label>结束时间：</label></dt>
		<dd>
			<input id="PromoEndDate" type="text" name="promo.dPromoEndDate" class="required dateISO" value="<fmt:formatDate value="${promo.dPromoEndDate}" pattern="yyyy-MM-dd"/>" />
		</dd>
	</dl>
	<dl>
		<dt><label>参与类型：</label></dt>
		<dd class="checkbox">
			<select name="promo.nPromoJoinType" class='required'>
				<option value="0" <c:if test="${promo.nPromoJoinType eq 0}">selected</c:if>>不限制</option>
				<!-- <option value="1" <c:if test="${promo.nPromoJoinType eq 1}">selected</c:if>>每个用户在活动期限内只能参与一次</option>
				<option value="2" <c:if test="${promo.nPromoJoinType eq 2}">selected</c:if>>每个用户在活动期限内每天只能参与一次</option> -->
			</select>
			<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
		</dd>
	</dl>
	<dl>
		<dt><label>循环计算：</label></dt>
		<dd class="checkbox">
			<select name="promo.nProperty" class='required'>
				<option value="0" <c:if test="${promo.nProperty eq 0}">selected</c:if>>不允许循环计算</option>
				<option value="2" <c:if test="${promo.nProperty eq 2}">selected</c:if>>允许循环计算</option>
			</select>
			<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
		</dd>
	</dl>
		<dl>
		<dt><label>黑白名单：</label></dt>
		<dd class="checkbox">
			<select name="promo.sBWListTypeID" class='required'>
				<option value="A" <c:if test="${promo.sBWListTypeID eq 'A'}">selected</c:if>>不使用黑白名单</option>
				<option value="B" <c:if test="${promo.sBWListTypeID eq 'B'}">selected</c:if>>使用黑名单</option>
				<option value="W" <c:if test="${promo.sBWListTypeID eq 'W'}">selected</c:if>>使用白名单</option>
			</select>
			<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
		</dd>
	</dl>
	<dl>
		<dt><label>金额上限：</label></dt>
		<dd><input type="text" name="promo.nLimitAmount" class="required number" value="${not empty promo.nLimitAmount ? promo.nLimitAmount : 0}"/></dd>
	</dl>
	<dl>
		<dt><label>活动描述：</label></dt>
		<dd><input type="text" name="promo.sPromoDesc" value="${promo.sPromoDesc}" /></dd>
	</dl>
	<dl>
		<dt><label>活动备注：</label></dt>
		<dd><input type="text" name="promo.sMemo" value="${promo.sMemo }" /></dd>
	</dl>
</form>
<script type="text/javascript">
$("#PromoBeginDate").datetimepicker({
  	format:"Y-m-d", 
  	timepicker:false
});
$("#PromoEndDate").datetimepicker({
  	format:"Y-m-d",
  	timepicker:false
});
</script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-validate-1.14.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/messages_zh.js"></script>