<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
 
<div class="pageContent">
	<form method="post" action="<%=request.getContextPath() %>/goods/goodsColorGroup/add" class="pageForm required-validate" enctype="multipart/form-data" onsubmit="return iframeCallback(this);">
		<div class="pageFormContent nowrap" layoutH="97">
 			<dl>
				<dt>色码组号</dt>
				<dd>
					<textarea name="sGroupNO" id="sGroupNO" class="required" cols="80" rows="2"></textarea>
 				</dd>
			</dl>
			<dl>
				<dt>色码组名称</dt>
				<dd>
				       <textarea name="sGroupName"  id="sGroupName"  class="required" cols="80" rows="2"></textarea>
   				</dd>
			</dl>
			<dl>
				<dt>色码号</dt>
				<dd>
				  <input type="text" name="sColorNO" id="sColorNO" maxlength="100" size="80" class="required"  value = "red"  /> 
   				</dd>
			</dl>
		      
			<dl>
				<dt>创建人</dt>
				<dd>
					<input type="text" name="sCreateUser" maxlength="100" size="80" class="required"  value="admin" /> 
				</dd>
			</dl> 
			<dl>
				<dt>确认人</dt>
				<dd>
					<input type="text" name="sConfirmUser" maxlength="100" size="80" class="required" value="admin2"  /> 
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

 <script type="text/javascript">
$(function(){
	   var sGroupNO = Math.floor(Math.random()*10000000);
	   $("#sGroupNO").val("G"+sGroupNO);
	    
	   var sGroupName = Math.floor(Math.random()*10);
	   $("#sGroupName").val("色码组名称"+sGroupName); 
});
</script>
 