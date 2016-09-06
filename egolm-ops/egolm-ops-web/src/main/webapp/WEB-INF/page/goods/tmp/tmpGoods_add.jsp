<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
  
<div class="pageContent">
	<form method="post" action="<%=request.getContextPath() %>/goods/tmpGoods/add" class="pageForm required-validate" enctype="multipart/form-data" onsubmit="return iframeCallback(this);">
		<div class="pageFormContent nowrap" layoutH="97">
 			<dl>
				<dt>导入</dt>  
				<dd>
					<input type="file" name="docGoodsFile" id="docGoodsFile" class="required"    /> 
				     
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
 