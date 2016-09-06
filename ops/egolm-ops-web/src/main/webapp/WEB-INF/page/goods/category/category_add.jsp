<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
  
<div class="pageContent">
	<form method="post" action="<%=request.getContextPath() %>/goods/category/add" class="pageForm required-validate" enctype="multipart/form-data" onsubmit="return iframeCallback(this);">
		<div class="pageFormContent nowrap" layoutH="97">
 			<dl>
				<dt>分类方式</dt>  
				<dd>
					<input type="hidden" name="sCategoryType" id="sCategoryType" maxlength="100" size="80" class="required"    /> 
				     <select id="sCategoryTypeID" name="sCategoryTypeID"> 
				     </select> 
 				</dd>
			</dl>
			 
			 
			<dl>
				<dt>分类名称</dt>
				<dd>
				 <input type="text" name="sCategoryDesc" maxlength="100" size="80" class="required"  value="酒水饮料"  /> 
				</dd>
			</dl>
			 
			 
			<dl>
				<dt>分类级别</dt>
				<dd>
					<input type="text" name="nCategoryLevel" maxlength="100" size="80"    /> 
				</dd>
			</dl>
			<dl>
				<dt>上级页面</dt>
				<dd> 
 						<ul id="cate-ztree" class="ztree"></ul>
 						<input id="add-cate-parent-id" type="text" name="sUpCategoryNO" value="" />
 				</dd>
			</dl>
		 
			<dl>
				<dt>创建人</dt>
				<dd>
					<input type="text" name="sCreateUser" maxlength="100" size="80" class="required"  value="admin" /> 
				</dd>
			</dl>
			<dl>
				<dt>更新人</dt>
				<dd>
					<input type="text" name="sChangeUser" maxlength="100" size="80" class="required"  value="admin1" /> 
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
<link rel="stylesheet" type="text/css" href="resources/z_tree/3.5/zTreeStyle.css" type="text/css"/> 
<script type="text/javascript" src="resources/z_tree/3.5/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="resources/z_tree/3.5/jquery.ztree.excheck-3.5.js"></script>
<script>
		var zTreeObj;
		// zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
		var setting = {
				data: {
					simpleData: {
						enable: true,
						idKey: "id",
						pIdKey: "pId",
						rootPId: 0
					}
				},
				callback:{
					onClick:function(e,treeId,treeNode){ 
					   $('#add-cate-parent-id').val(treeNode.id); 
					}
				}
		}

 
	
		$(document).ready(function(){ 
			   var sCategoryNO = Math.floor(Math.random()*10000000);
			   $("#sCategoryNO").val(sCategoryNO);   
			   loadCategoryTypeMsg();
		 });
 
 
		$("#sCategoryTypeID").change(function(){
			   var value = $("#sCategoryTypeID  option:selected").val();
			   var text = $("#sCategoryTypeID  option:selected").text(); 
			   $("#sCategoryType").val(text); 
			   loadCateZteeMsg(value);
		});
		/**加载品牌类型数据***/
		function loadCategoryTypeMsg(){
			   $.ajax({
					type:'POST',
					url:'common/queryByCommonNo',
					data:'sCommonNo=CategoryType',
					dataType:"json",
					cache: false,
					success: function (data) {
						 var isValid = data.IsValid;
						 if(isValid){
							 var dataList = data.DataList; 
							 if(dataList.length>0){ 
								 var brandoption="";
								 for(var i = 0;i<dataList.length;i++){
									 var data = dataList[i];
									 brandoption+="<option value='"+data.sComID+"'>"+data.sComDesc+"</option>"; 
								 }
								 $("#sCategoryTypeID").html(brandoption);
								 var text = $("#sCategoryTypeID  option:selected").text(); 
								 $("#sCategoryType").val(text); 
								 var value = $("#sCategoryTypeID  option:selected").val();
								 loadCateZteeMsg(value);
							 }
						 }else{
							 alert(data.ReturnValue);
						 }
					} 
				});
		}
		
		/**
		加载上级结构树
		*/
		function loadCateZteeMsg(sCategoryTypeID){
			$.ajax({
				type:'POST',
				url:'goods/category/categoryZtree?sCategoryTypeID='+sCategoryTypeID,
				dataType:"json",
				cache: false,
				success: function (data) {
					 var isValid = data.IsValid;
					 if(isValid){
						 var zNodes = data.DataList; 
						 zTreeObj = $.fn.zTree.init($("#cate-ztree"), setting, zNodes); 
					 }else{
						 alert(data.ReturnValue);
					 }
				} 
			});
		}
</script>