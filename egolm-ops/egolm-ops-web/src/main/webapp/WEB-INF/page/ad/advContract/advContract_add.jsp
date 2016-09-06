<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
<div class="pageContent">
	<form method="post" action="<%=request.getContextPath() %>/api/advContract/add" class="pageForm required-validate" enctype="multipart/form-data" onsubmit="return iframeCallback(this);">
		<div class="pageFormContent nowrap" layoutH="97">
		<input type = "text" name = "nContractID" value = "${advContractData.nContractID}"/> 
  			<dl>
				<dt>广告位合同编号</dt> 
				<dd>
					<input type="text" name="sContractNO" id="sContractNO" maxlength="100" size="80" class="required"  value="${advContractData.sContractNO}"/> 
				</dd>
			</dl>
  			<dl>
				<dt>交易方式</dt> 
				<dd>
				<input type="hidden" name="sTradeMode" maxlength="100" size="80" class="required"  value = "购销"/>
 					<select name = "sTradeModeID" id = "sTradeModeID">
				     <option value ="1">购销</option> 
				   </select>
				</dd>
			</dl>
			<dl>
				<dt>合同生效日期</dt>
				<dd>
					 <input type="text" name="dActiveDate" class="date" readonly="true"  value = "${advContractData.dActiveDate }"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
				<span class="info">yyyy-MM-dd</span>
 				</dd>
			</dl>
			<dl>
				<dt>合同终止日期</dt>
				<dd>
				<input type="text" name="dExpireDate" class="date" readonly="true"  value = "${advContractData.dExpireDate }"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
				<span class="info">yyyy-MM-dd</span>
 				</dd>
			</dl>
			<dl>
				<dt>固定扣点率</dt>
				<dd>
				 	<input type="text" name="nRatio" maxlength="100" size="80" class="required"  value="${advContractData.nRatio}"/>
				</dd>
			</dl>
			<dl>
				<dt>税别</dt>
				<dd><input type="hidden" name="sTaxType" maxlength="100" size="80" class="required"  value = "普通税" />
				   <select name = "sTaxTypeID" id = "sTaxTypeID">
				     <option value ="1">普通税</option>
				     <option value ="2">增值税</option>
				   </select>
				</dd>
			</dl>
			<dl>
				<dt>税率</dt>
				<dd>
				  	<input type="text" name="nTaxRate" maxlength="100" size="80" class="required"  value="${advContractData.nTaxRate}"/>
				</dd>
			</dl>
			 
			<dl>
				<dt>税比</dt>
				<dd>
					<input type="text" name="nTaxPct" maxlength="20" size="80" class="required" value="${advContractData.nTaxPct}"/>
					 
				</dd>
			</dl>
			<dl>
				<dt>付款账期</dt>
				<dd> 
				<input type="hidden" name="sPaytTerm" maxlength="100" size="80" class="required" value = "货到" />
				   <select name = "sPaytTermID" id = "sPaytTermID">
				     <option value ="0">货到</option>
				     <option value ="1">周结</option>
				     <option value ="2">半月结</option>
				     <option value ="3">月结</option>
				   </select>
				</dd>
			</dl>
			<dl>
				<dt>付款天数</dt>
				<dd>
					  <input type="text" name="nPaytDay" maxlength="20" size="80" class="required" value="${advContractData.nPaytDay}"/>
				</dd>
			</dl>
			<dl>
				<dt>付款联系人</dt>
				<dd>
 					 <input type="text" name="sPaytContact" maxlength="20" size="80" class="required" value="${advContractData.sPaytContact}"/>
				</dd>
			</dl>
			<dl>
				<dt>付款联系人电话</dt>
				<dd>
					<input type="text" name="sPaytContactTel" maxlength="20" size="80" class="required digits"  value="${advContractData.sPaytContactTel}"/>
					 
				</dd>
			</dl>
			<dl>
				<dt>付款方式</dt>
				<dd>
					<input type="hidden" name="sPaytMode" maxlength="100" size="80" class="required" value = "现金" />
				   <select name = "sPaytModeID" id = "sPaytModeID">
 				     <option value ="1">现金</option>
				     <option value ="2">支票</option>
 				   </select>
				</dd>
			</dl>
			<dl>
				<dt>银行账号</dt>
				<dd>
					 <input type="text" name="sBankAccountNO" maxlength="20" size="80" class="required digits"  value="${advContractData.sBankAccountNO}"/>
				   
				</dd>
			</dl>
			<dl>
				<dt>银行账户</dt>
				<dd>
					<input type="text" name="sBankAccount" maxlength="20"  size="80"  value="${advContractData.sBankAccount}" />
					 
				</dd>
			</dl> 
			<dl>
				<dt>开户账户</dt>
				<dd>
					<input type="text" name="sBank" maxlength="20"  size="80"  value="${advContractData.sBank}" />
					 
				</dd>
			</dl> 
			<dl>
				<dt>税号</dt>
				<dd>
					<input type="text" name="sTaxCode" maxlength="20"  size="80"  value="${advContractData.sTaxCode}" />
					 
				</dd>
			</dl> 
			<dl>
				<dt>付款中心</dt>
				<dd>
					<input type="text" name="sPaytCenterNO" maxlength="20"  size="80"  value="${advContractData.sPaytCenterNO}" />
					 
				</dd>
			</dl> 
			<dl>
				<dt>合同状态</dt>
				<dd>
 					 <select name = "nContractTag" id = "nContractTag">
 				     <option value ="2">可付款</option> 
 				   </select>
				</dd>
			</dl> 
			<dl>
				<dt>备注</dt>
				<dd>
					<input type="text" name="sMemo" maxlength="20"  size="80"  value="${advContractData.sMemo}" />
					 
				</dd>
			</dl> 
			<dl>
				<dt>创建人</dt>
				<dd>
					<input type="text" name="sCreateUser" maxlength="20"  size="80"  value="admin" />
					 
				</dd>
			</dl> 
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
	</form>
</div>
<script>
   $(function(){
	   var sContractNO = Math.floor(Math.random()*10000000);
	   $("#sContractNO").val("C"+sContractNO); 
   });
</script>