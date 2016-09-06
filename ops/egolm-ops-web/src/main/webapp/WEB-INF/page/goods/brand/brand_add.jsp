<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
 
<div class="pageContent">
	<form method="post" action="<%=request.getContextPath() %>/goods/brand/add" class="pageForm required-validate" enctype="multipart/form-data" onsubmit="return iframeCallback(this);">
		<div class="pageFormContent nowrap" layoutH="97">
 			<dl>
				<dt>品牌名称</dt>
				<dd>
					<textarea name="sBrandName" class="required" cols="80" rows="2">茅台（MOUTAI）</textarea>
 				</dd>
			</dl>
			<dl>
				<dt>母品牌编码</dt>
				<dd>
				       <ul id="brand-ztree" class="ztree"></ul>
 						<input id="add-brand-parent-id" type="text" name="sParentBrandID" value="" />
   				</dd>
			</dl>
			<dl>
				<dt>品牌发源地</dt>
				<dd>
				  <input type="text" name="sCradle" id="sCradle" maxlength="100" size="80" class="required"  value = "上海"  /> 
   				</dd>
			</dl>
		    <dl>
				<dt>品牌类型</dt>
				<dd>
				  <input type="hidden" name="sBrandType" id="sBrandType" maxlength="100" size="80" class="required"    /> 
				     <select id="sBrandTypeID" name="sBrandTypeID"> 
				     </select>
				</dd>
			</dl>
			 
			<dl>
				<dt>品牌图片</dt>
				<dd>
 				<input type="file" name="sLogoUrl"  id="sLogoUrl"   />
				</dd>
			</dl>
			 <dl>
				<dt>排序优先级</dt>
				<dd>
					<input type="text" name="nSortPriority" maxlength="100" size="80"   value = "1"  class="required digits"/> 
				</dd>
			</dl>
			 
			<dl>
				<dt>备注</dt>
				<dd>
					<input type="text" name="sMemo" maxlength="100" size="80"  value="可以为空"   /> 
				</dd>
			</dl>
			<dl>
				<dt>状态标识</dt>
				<dd>
					<input type="text" name="nTag" maxlength="100" size="80" class="required digits"  value="1" /> 
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
//zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
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
			   $('#add-brand-parent-id').val(treeNode.id);
			}
		}
}

   $(function(){ 
	   loadBrandTypeMsg();
	   loadBrandZteeMsg()
	    
   });
   $("#sBrandTypeID").change(function(){
	   var text = $("#sBrandTypeID  option:selected").text(); 
	   $("#sBrandType").val(text); 
   });
   /**加载品牌类型数据***/
   function loadBrandTypeMsg(){
	   $.ajax({
			type:'POST',
			url:'common/queryByCommonNo',
			data:'sCommonNo=BrandType',
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
						 $("#sBrandTypeID").html(brandoption);
						 var text = $("#sBrandTypeID  option:selected").text(); 
						 $("#sBrandType").val(text); 
					 }
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
   }
   
   
	function loadBrandZteeMsg(){
		$.ajax({
			type:'POST',
			url:'goods/brand/brandZtree',
			dataType:"json",
			cache: false,
			success: function (data) {
				 var isValid = data.IsValid;
				 if(isValid){
					 var zNodes = data.DataList; 
					 zTreeObj = $.fn.zTree.init($("#brand-ztree"), setting, zNodes); 
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
	}
</script>