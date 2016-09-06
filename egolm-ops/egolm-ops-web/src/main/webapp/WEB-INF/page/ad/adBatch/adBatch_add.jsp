<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
<div class="pageContent">
	<form method="post" action="<%=request.getContextPath() %>/api/adBatch/add" class="pageForm required-validate" enctype="multipart/form-data" onsubmit="return iframeCallback(this);">
		<div class="pageFormContent nowrap" layoutH="97">
		<input type = "hidden" name = "nBID" /> 
  			<dl>
				<dt>广告位合同编号</dt> 
				<dd>
					<input type="text" name="sBatchName" id="sBatchName" maxlength="100" size="80" class="required"  value="${adPosData.sBatchName}"/> 
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
	   var sBatchName = Math.floor(Math.random()*10000000);
	   $("#sBatchName").val(sBatchName); 
   });
</script>