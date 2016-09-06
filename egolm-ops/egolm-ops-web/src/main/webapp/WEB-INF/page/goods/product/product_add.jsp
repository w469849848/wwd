<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
<style type="text/css">
	ul.rightTools {float:right; display:block;}
	ul.rightTools li{float:left; display:block; margin-left:5px}
</style>

<div class="pageContent" style="padding:5px">
	 
 	<div class="tabs">
		<div class="tabsHeader">
			<div class="tabsHeaderContent">
				<ul>
					<li><a href="javascript:;"><span>商品新增</span></a></li>
					<li><a href="javascript:;"><span>商品图片</span></a></li> 
 					<li><a href="javascript:;"><span>商品扩展属性</span></a></li> 
				</ul>
			</div>
		</div>
		<div class="tabsContent"> 
			<div>
			    <div class="pageContent">
					<form method="post" action="<%=request.getContextPath() %>/goods/product/add" class="pageForm required-validate"  onsubmit="return iframeCallback(this);">
						<div class="pageFormContent nowrap" layoutH="97">
				 			
							<dl>
								<dt>商品名称</dt>
								<dd>
									<textarea name="sGoodsDesc" class="required" cols="80" rows="2">五粮液52度整箱装500ml*6瓶</textarea>
				 				</dd>
							</dl>
							<dl>
								<dt>商品简称</dt>
								<dd>
									<textarea name="sGoodsName" class="required" cols="80" rows="2">五粮液52度整箱装500ml*6瓶</textarea>
				 				</dd>
							</dl>
							<dl>
								<dt>分类编码</dt>
								<dd>
									 	<ul id="cate-ztree" class="ztree"></ul>
									 	<input type="hidden" name="sCategoryNO" id="sCategoryNO"   /> 
				 				</dd>
							</dl>
							
							<dl>
								<dt>主编码</dt>
								<dd>
									<input type="text" name="sMainBarcode" id="sMainBarcode" maxlength="100" size="80" class="required digits"  value="120"  /> 
									 
								</dd>
							</dl>
							
							
							
							<dl>
								<dt>规格</dt>
								<dd>
									<input type="text" name="sSpec" maxlength="100" size="80" class="required  "  value="1*6"  /> 
									 
								</dd>
							</dl>
							
							<dl>
								<dt>单位</dt>
								<dd>
									<input type="text" name="sUnit" maxlength="100" size="80" class="required  "  value="箱"  /> 
									 
								</dd>
							</dl>
							
							
							
							<dl>
								<dt>箱装数量</dt>
								<dd>
									<input type="text" name="nCaseUnits" maxlength="100" size="80" class="required digits"  value="6"  /> 
									 
								</dd>
							</dl>
							
							<dl>
								<dt>销售倍数</dt>
								<dd>
									<input type="text" name="nSaleUints" maxlength="100" size="80" class="required digits"  value="2"  /> 
									 
								</dd>
							</dl>
							
							<dl>
								<dt>订货倍数</dt>
								<dd>
									<input type="text" name="nOrderUnits" maxlength="100" size="80" class="required digits"  value="2"  /> 
									 
								</dd>
							</dl>
							
							<dl>
								<dt>品牌</dt>
								<dd>
								     <input type="hidden" name="sBrand" id="sBrand" maxlength="100" size="80" class="required"  /> 
								     <select id="sBrandID" name="sBrandID"> 
								     </select>
								</dd>
							</dl>
							
								<dl>
								<dt>产地</dt>
								<dd>
									<input type="hidden" name="sHome" id="sHome" maxlength="100" size="80" class="required"  /> 
									
									<select id="sHomeID" name="sHomeID"> 
								     </select>
								</dd>
							</dl>
							 <dl>
								<dt>国家</dt>
								<dd>
									<input type="hidden" name="sNation" id="sNation" maxlength="100" size="80" class="required"  /> 
									
									<select id="sNationID" name="sNationID"> 
								     </select>
								</dd>
							</dl>
							 
							<dl>
								<dt>商品种类</dt>
								<dd> 
										<input type="hidden" name="sGoodType" id="sGoodType" maxlength="100" size="80" class="required"  /> 
								     <select id="sGoodTypeID" name="sGoodTypeID"> 
								     </select> 
								 
								</dd>
							</dl>
							<div id="goodType_U" style="display: none;">
							 <dl>
								<dt>主商品编码</dt>
								<dd> 
 								     <select id="nParentID" name="nParentID"> 
								     </select> (当商品种类为子商品编码时显示)
								 
								</dd>
							</dl>
							 <dl>
								<dt>颜色号</dt>
								<dd> 
 								     <select id="sColorNO" name="sColorNO"> 
								     </select> (当商品种类为子商品编码时显示)
								 
								</dd>
							</dl>
							 <dl>
								<dt>尺码号</dt>
								<dd> 
 								     <select id="sSizeNO" name="sSizeNO"> 
								     </select> (当商品种类为子商品编码时显示)
								 
								</dd>
							</dl>
							  <dl>
								<dt>商品条码</dt>
								<dd> 
 								    <input type="text" name="sBarcode" id="sBarcode" maxlength="100" size="80" class="required"  />  
								</dd>
							</dl>
							</div>
							<dl>
								<dt>保质期天数</dt>
								<dd>
									<input type="text" name="nShelfLife" maxlength="100" size="80" class="required digits"  value="120"  /> 
									 
								</dd>
							</dl>
							<dl>
								<dt>标准售价</dt>
								<dd>
									<input type="text" name="nNormalSalePrice" id ="nNormalSalePrice" maxlength="100" size="80" class="required"  value = "3959.00" /> 
									 
								</dd>
							</dl>
							<dl>
								<dt>税率</dt>
								<dd>
									<input type="text" name="nTaxRate" maxlength="100" size="80" class="required"    value = "1"/> 
								</dd>
							</dl>
							<dl>
								<dt>生命周期</dt>
								<dd>
									<input type="text" name="nLifeCycle" maxlength="100" size="80"  value="12"   /> 
								</dd>
							</dl>
							<dl>
								<dt>产品代码</dt>
								<dd>
									<input type="text" name="sProductCode" id="sProductCode" maxlength="100" size="80" class="required  "    /> 
								</dd>
							</dl>
							
							<dl>
								<dt>备注</dt>
								<dd>
									<input type="text" name="sMemo" maxlength="100" size="80" class="required  "  value="整箱装更划算！万店自营，厂商直供，品质保证！真，才更重要" /> 
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
			   
			
			
			</div>
			
			<div>商品展示图片
			  <div class="pageContent">
					<form method="post" action="<%=request.getContextPath() %>/goods/goodsPic/upload" class="pageForm required-validate" enctype="multipart/form-data" onsubmit="return iframeCallback(this);">
						<div class="pageFormContent nowrap" layoutH="97">
						 <input type="text" name="nGoodsID" id="nGoodsID" value="41"  /> 
						 <dl>
								<dt>创建人</dt>
								<dd>
									<input type="text" name="sCreateUser" maxlength="100" size="80" class="required"  value="admin" /> 
								</dd>
							</dl>
 				 			<dl>
								<dt>商品展示图片1</dt>  
								<dd>
									<input type="file" name="sURL" id="sURL"  />  
									<select id="sPicTypeID1" name="sPicTypeID"> 
								     </select>
								     <input type="text" name="sPicType"  ID="sPicType1"  />
								     <input type="text" name="nItem"  ID="nItem1"  placeholder="序号" />
								     <input type="text" name="sPicDesc"  ID="sPicDesc"  placeholder="图片描述"/>
								</dd>
							</dl>
							<dl>
								<dt>商品展示图片2</dt>  
								<dd>
									<input type="file" name="sURL" id="sURL"  /> 
									<select id="sPicTypeID2" name="sPicTypeID"> 
								     </select>
								    <input type="hidden" name="sPicType"  ID="sPicType2"  />
								     <input type="text" name="nItem"  ID="nItem2"  placeholder="序号" />
								     <input type="text" name="sPicDesc"  ID="sPicDesc"   placeholder="图片描述"/>
								</dd>
							</dl>
							<dl>
								<dt>商品展示图片3</dt>  
								<dd>
									<input type="file" name="sURL" id="sURL"  /> 
									<select id="sPicTypeID3" name="sPicTypeID"> 
								     </select>
								    <input type="hidden" name="sPicType"  ID="sPicType3"  />
								     <input type="text" name="nItem"  ID="nItem3" placeholder="序号"   />
								       <input type="text" name="sPicDesc"  ID="sPicDesc"  placeholder="图片描述" />
								</dd>
							</dl>
							 <dl>
								<dt>商品展示图片4</dt>  
								<dd>
									<input type="file" name="sURL" id="sURL"  /> 
									<select id="sPicTypeID4" name="sPicTypeID"> 
								     </select>
								    <input type="hidden" name="sPicType"  ID="sPicType4"  />
								     <input type="text" name="nItem"  ID="nItem4" placeholder="序号"   />
								       <input type="text" name="sPicDesc"  ID="sPicDesc"  placeholder="图片描述" />
								</dd>
							</dl>
						</div>
						 
						
						<div class="formBar">
							<ul>
								<li><div class="buttonActive"><div class="buttonContent"><button type="submit">上传</button></div></div></li>
								<li>
									<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
								</li>
							</ul>
						</div>
					</form> 
				</div>
			</div> 
			
			<div>商品扩展属性			
			   	<div class="pageContent"> 
					<form method="post" action="<%=request.getContextPath() %>/goods/goodsProperty/add" class="pageForm required-validate" enctype="multipart/form-data" onsubmit="return iframeCallback(this);">
						<div class="pageFormContent nowrap" layoutH="97">
						 <input type="text" name="nGoodsID" id="nGoodsID" value="42"  /> 
 				 			<dl>
								<dt>长</dt>  
								<dd>
									  <input type="text" name="nLength" id="nLength"  value = "100" /> 
								</dd>
							</dl>
							<dl>
								<dt>宽</dt>  
								<dd>
									  <input type="text" name="nWidth" id="nWidth"  value = "100"/> 
								</dd>
							</dl>
							<dl>
								<dt>高</dt>  
								<dd>
									  <input type="text" name="nHeight" id="nHeight"  value = "100"/> 
								</dd>
							</dl>
							<dl>
								<dt>重量</dt>  
								<dd>
									  <input type="text" name="nWeight" id="nWeight"  value = "100"/> 
								</dd>
							</dl>
							 <dl>
								<dt>箱长</dt>  
								<dd>
									  <input type="text" name="nCaseLength" id="nCaseLength"  value = "100"/> 
								</dd>
							</dl>
							<dl>
								<dt>箱宽</dt>  
								<dd>
									  <input type="text" name="nCaseWidth" id="nCaseWidth" value = "100" /> 
								</dd>
							</dl>
							<dl>
								<dt>箱高</dt>  
								<dd>
									  <input type="text" name="nCaseHeight" id="nCaseHeight" value = "100" /> 
								</dd>
							</dl>
							<dl>
								<dt>箱重</dt>  
								<dd>
									  <input type="text" name="nCaseWeight" id="nCaseWeight" value = "100" /> 
								</dd>
							</dl>
							<dl>
								<dt>创建人</dt>  
								<dd>
									  <input type="text" name="sCreateUser" id="sCreateUser"  value = "admin"/> 
								</dd>
							</dl>
							<dl>
								<dt>审核人</dt>  
								<dd>
									  <input type="text" name="sConfirmUser" id="sConfirmUser"  value = "admin1"/> 
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
			</div> 
		</div>
		<div class="tabsFooter">
			<div class="tabsFooterContent"></div>
		</div>
	</div>
	
</div>

<link rel="stylesheet" type="text/css" href="resources/z_tree/3.5/zTreeStyle.css" type="text/css"/> 
<script type="text/javascript" src="resources/z_tree/3.5/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="resources/z_tree/3.5/jquery.ztree.excheck-3.5.js"></script>
<script>

var setting = {
		view: {
			selectedMulti: false
		},
		check: {
			enable: true,
			chkStyle: "radio",
			radioType: "level"
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
 			onCheck: onCheck
		}
	};
	
	var code, log, className = "dark";
	function onCheck(e, treeId, treeNode) {
		console.log("" + treeNode.name +"---"+treeNode.id+"-----"+treeNode.sCategoryTypeID);
		var catid = $("#sCategoryNO").val();
		console.log(catid);
		$("#sCategoryNO").val(treeNode.id);
	}	
	
   $(function(){
	   var sMainBarcode = Math.floor(Math.random()*10000000);
	   $("#sMainBarcode").val(sMainBarcode);
	    
	   var sProductCode = Math.floor(Math.random()*10000000);
	   $("#sProductCode").val("P"+sProductCode);
	   
	   var sBarcode = Math.floor(Math.random()*10000000000000);
	   $("#sBarcode").val(sBarcode);
	   
	   loadBrandMsg();  
	   loadGoodTypeMsg();
	   loadHomeMsg();
	   loadCateZteeMsg();
	   loadNationMsg();
	   loadMGoodsMsg();
	   loadGoodsColorGroupMsg();
	   loadGoodsSizeGroupMsg();
	   loadPicTypeMsg();
	 
   });
   
   
   
   /**
	加载分类树
	*/
	function loadCateZteeMsg(){
		$.ajax({
			type:'POST',
			url:'goods/category/categoryZtree',
			dataType:"json",
			cache: false,
			success: function (data) {
				 var isValid = data.IsValid;
				 if(isValid){
					 var zNodes = data.DataList;  
					 $.fn.zTree.init($("#cate-ztree"), setting, zNodes); 
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
	} 
   
   $("#sBrandID").change(function(){
	   var value = $("#sBrandID  option:selected").val();
	   var text = $("#sBrandID  option:selected").text(); 
	   $("#sBrand").val(text); 
   });
   $("#sHomeID").change(function(){
	   var value = $("#sHomeID  option:selected").val();
	   var text = $("#sHomeID  option:selected").text(); 
	   $("#sHome").val(text); 
   });
   $("#sGoodTypeID").change(function(){
	   var value = $("#sGoodTypeID  option:selected").val();
	   var text = $("#sGoodTypeID  option:selected").text(); 
	   $("#sGoodType").val(text); 
	   
	   if(value == 'U'){
		   $("#goodType_U").css('display','block'); 
	   }else{
		   $("#goodType_U").css('display','none'); 
	   }
   });
   
   $("#sNationID").change(function(){
	   var value = $("#sNationID  option:selected").val();
	   var text = $("#sNationID  option:selected").text(); 
	   $("#sNation").val(text); 
   });
   
  function loadChange(){
	 
  }
  
  for(var i=1; i<5;i++){
	   $("#sPicTypeID"+i).change(function(){
		   var value = $("#sPicTypeID"+i+"  option:selected").val();
		   
		   var text = $("#sPicTypeID"+i+"  option:selected").text(); 
		   console.log(i+"---"+text);
		   $("#sPicType"+i).val(text); 
	   });
  }
   
   /**加载品牌数据***/
   function loadBrandMsg(){
	   $.ajax({
			type:'POST',
			url:'goods/brand/list',
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
							 brandoption+="<option value='"+data.sBrandID+"'>"+data.sBrandName+"</option>"; 
						 }
						 $("#sBrandID").html(brandoption);
						 var text = $("#sBrandID  option:selected").text(); 
						 $("#sBrand").val(text); 
					 }
				 }else{
					 alert(data.ReturnValue);
				 }
			},
			error: DWZ.ajaxError
		});
   }
    
   
   /**********加载商品类型************/  
   function loadGoodTypeMsg(){
	   $.ajax({
			type:'POST',
			url:'common/queryByCommonNo',
			data:'sCommonNo=goodType',
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
						 $("#sGoodTypeID").html(brandoption);
						 var text = $("#sGoodTypeID  option:selected").text(); 
						 $("#sGoodType").val(text); 
					 }
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
   }
   
   /**********加载产地************/  
   function loadHomeMsg(){
	   $.ajax({
			type:'POST',
			url:'common/queryByCommonNo',
			data:'sCommonNo=sHome',
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
						 $("#sHomeID").html(brandoption);
						 var text = $("#sHomeID  option:selected").text(); 
						 $("#sHome").val(text); 
					 }
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
   }
   
   
   /**********加载国家************/  
   function loadNationMsg(){
	   $.ajax({
			type:'POST',
			url:'common/queryByCommonNo',
			data:'sCommonNo=NATI',
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
						 
						 $("#sNationID").html(brandoption);
						 var text3 = $("#sNationID  option:selected").text(); 
						 $("#sNation").val(text3); 
					 }
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
   }
     
   /***加载商品种类为M的商品****/
   function loadMGoodsMsg(){
	   $.ajax({
			type:'POST',
			url:'goods/product/list?sGoodTypeID=M',
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
							 brandoption+="<option value='"+data.nGoodsID+"'>"+data.sGoodsDesc+"</option>"; 
 						 }
						 
						 $("#nParentID").html(brandoption);
  					 }
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
   }
   
   
   /***************加载色码组********************/
   function loadGoodsColorGroupMsg(){
	   $.ajax({
			type:'POST',
			url:'goods/goodsColorGroup/list',
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
							 brandoption+="<option value='"+data.sGroupNO+"'>"+data.sColorNO+"</option>"; 
 						 }
						 
						 $("#sColorNO").html(brandoption);
  					 }
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
   }
   /***************加载尺码组********************/
   function loadGoodsSizeGroupMsg(){
	   $.ajax({
			type:'POST',
			url:'goods/goodsColorSize/list',
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
							 brandoption+="<option value='"+data.sGroupNO+"'>"+data.sSizeNO+"</option>"; 
 						 }
						 
						 $("#sSizeNO").html(brandoption);
  					 }
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
   }
   
   
   /***************加载图片类型********************/
   function loadPicTypeMsg(){
	   $.ajax({
			type:'POST',
			url:'common/queryByCommonNo',
			data:'sCommonNo=picType',
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
						 
						 for(var j=1;j<5;j++){
							 $("#sPicTypeID"+j).html(brandoption);
						 	var text = $("#sPicTypeID"+j+"  option:selected").text(); 
						 	$("#sPicType"+j).val(text); 
						 	$("#nItem"+j).val(j);
						 } 
					 }
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
   }
</script>
	

