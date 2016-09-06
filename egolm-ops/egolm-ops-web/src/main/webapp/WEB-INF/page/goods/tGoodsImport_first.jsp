<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
 
<div class="pageContent">
	<form method="post" action="<%=request.getContextPath() %>/goods/tGoodsDealer/importSecond" class="pageForm required-validate" enctype="multipart/form-data" onsubmit="return iframeCallback(this);">
		<div class="pageFormContent nowrap" layoutH="97">
 			<dl>
				<dt>合同:</dt>
				<dd>
					<textarea name="sAgentContractNO" id="sAgentContractNO" class="required" cols="80" rows="2">ht001</textarea>
 				</dd>
			</dl>
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">下一步</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
	</form>
</div>

 <script type="text/javascript">
$(function(){
	  
});
</script>
 