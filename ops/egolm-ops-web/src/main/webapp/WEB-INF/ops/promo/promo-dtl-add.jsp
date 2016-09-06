<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
	dt{float:left;width:120px;}
	dd input,select {width:300px;}
</style>
<form action="saveDtl" method="post" id="BatchPromoDtlSaveForm">
	<input type="hidden" name="promoDtl.sPromoPaperNO" value="${promoDtl.sPromoPaperNO}"/>
	<input type="hidden" name="promoDtl.sAgentContractNO" value="${promoDtl.sAgentContractNO}"/>
	<input type="hidden" name="promoDtl.nGoodsID" value="${promoDtl.nGoodsID}"/>
	<input type="hidden" name="promoDtl.sBrandID" value="${promoDtl.sBrandID}"/>
	<input type="hidden" name="promoDtl.sCategoryNO" value="${promoDtl.sCategoryNO}"/>
	<c:if test="${promo.sPromoActionTypeID eq '1' || promo.sPromoActionTypeID eq '2'}">
		<dl>
			<dt><label>满足数量：</label></dt>
			<dd>
				<input type="text" name="promoDtl.nMeetQty" class="required number"/>
			</dd>
		</dl>
		</dl>
			<dt><label>批量单价：</label></dt>
			<dd>
				<input type="text" name="promoDtl.nPrice" class="required number"/>
			</dd>
		</dl>
	</c:if>
	<c:if test="${promo.sPromoActionTypeID eq '3'}">
		<dl>
			<dt><label>组合编号：</label></dt>
			<dd>
				<input type="text" name="promoDtl.sGroupNO" class="required digits"/>
			</dd>
		</dl>
		<dl>
			<dt><label>满足数量：</label></dt>
			<dd>
				<input type="text" name="promoDtl.nMeetQty" class="required number"/>
			</dd>
		</dl>
		<dl>	
			<dt><label>组合单价：</label></dt>
			<dd>
				<input type="text" name="promoDtl.nPrice" class="required number"/>
			</dd>
		</dl>
	</c:if>
	<c:if test="${promo.sPromoActionTypeID eq '4' || promo.sPromoActionTypeID eq '5'}">
		<dl>
			<dt><label>规则编号：</label></dt>
			<dd>
				<input id="promoDtl_nRuleID" type="text" name="promoDtl.nRuleID" class="required digits rule" onchange="changeRuleID(this.value);"/>
			</dd>
		</dl>
		<dl>
			<dt><label>满足金额：</label></dt>
			<dd>
				<input id="promoDtl_nMeetAmount" type="text" name="promoDtl.nMeetAmount" class="required number rule"/>
			</dd>
		</dl>
	</c:if>
	<c:if test="${promo.sPromoActionTypeID eq '4'}">
		<dl>	
			<dt><label>折扣金额：</label></dt>
			<dd>
				<input id="promoDtl_nDisAmount" type="text" name="promoDtl.nDisAmount" class="required number rule"/>
			</dd>
		</dl>
	</c:if>
	<c:if test="${promo.sPromoActionTypeID eq '5'}">
		<dl>	
			<dt><label>折扣比例：</label></dt>
			<dd>
				<input id="promoDtl_nDisRate" type="text" name="promoDtl.nDisRate" class="required rate rule"/>
			</dd>
		</dl>
	</c:if>
</form>
<script src="${pageContext.request.contextPath}/resources/js/jquery-validate-1.14.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/messages_zh.js"></script>
<script type="text/javascript">
function changeRuleID(nRuleID) {
	$.ajax({
		url : "queryAmountByRuleID",
		type : "post",
		async : false,
		data : {"promoDtl.sPromoPaperNO":"${promoDtl.sPromoPaperNO}", "promoDtl.nRuleID":nRuleID},
		dataType : "json",
		success : function(json) {
			if(json.IsValid) {
				if(json.DataList) {
					$("#promoDtl_nMeetAmount").val(json.DataList.nMeetAmount);
					$("#promoDtl_nDisAmount").val(json.DataList.nDisAmount);
					$("#promoDtl_nDisRate").val(json.DataList.nDisRate);
					$("#promoDtl_nMeetAmount").attr("readonly", true);
					$("#promoDtl_nDisAmount").attr("readonly", true);
					$("#promoDtl_nDisRate").attr("readonly", true);
				} else {
					$("#promoDtl_nMeetAmount").attr("readonly", false);
					$("#promoDtl_nDisAmount").attr("readonly", false);
					$("#promoDtl_nDisRate").attr("readonly", false);
				}
			}
		}
	});
}
jQuery.validator.addMethod("rate", function(value, element) {  
    var length = value.length;  
    var regex = /^0\.[0-9]{1,2}$/;  
    return this.optional(element) || regex.test(value);
}, "请输入正确的比例数值，例如：0.95，即95折");
jQuery.validator.addMethod("rule", function(value, element) {  
	var boo = false;
	var nMeetAmount = $("#promoDtl_nMeetAmount").val();
	var nDisAmount = $("#promoDtl_nDisAmount").val();
	var nDisRate = $("#promoDtl_nDisRate").val();
	var nRuleID = $("#promoDtl_nRuleID").val();
    $.ajax({
    	url : "validateRuleID",
    	type : "post",
    	dataType : "json",
    	async : false,
    	data : {"promoDtl.sPromoPaperNO":"${promoDtl.sPromoPaperNO}", "promoDtl.sAgentContractNO":"${promoDtl.sAgentContractNO}", "promoDtl.nMeetAmount":nMeetAmount, "promoDtl.nRuleID":nRuleID, "promoDtl.nDisAmount":nDisAmount, "promoDtl.nDisRate":nDisRate},
    	success : function(json) {
    		boo = json.IsValid;
    	}
    });
    return this.optional(element) || boo;
}, "折扣金额与现有规则不匹配");   
</script>