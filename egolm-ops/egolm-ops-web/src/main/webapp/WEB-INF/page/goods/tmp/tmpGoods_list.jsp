<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
<form id="pagerForm" method="post" action="<%=request.getContextPath() %>/api/advContract/list">
	<input type="hidden" name="pageNum" value="1" />  <!--【 必须】 value=1可以写死-->
	<input type="hidden" name="numPerPage" value="${model.numPerPage}" /> <!--【可选】每页显示多少条-->
	<input type="hidden" name="orderField" value="${param.orderField}" />  <!--【可选】查询排序-->
	<input type="hidden" name="orderDirection" value="${param.orderDirection}" />  <!--【可选】 升序降序-->
</form>
<div class="pageHeader">
	<form rel="pagerForm" onsubmit="return navTabSearch(this);" action="<%=request.getContextPath() %>/api/tmpGoods/list" method="post">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>广告位名称</label>
				<input type="text" name="sApTitle"/>
			</li>
		 
		</ul>
		 
		<div class="subBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">检索</button></div></div></li>
				<li><a class="button" href="demo_page6.html" target="dialog" mask="true" title="查询框"><span>高级检索</span></a></li>
			</ul>
		</div>
	</div>
	</form>
</div>

<div class="pageContent">
	<div class="panelBar">
		<ul class="toolBar">
 			<li class="line">line</li>
			<li><a class="icon" href="<%=request.getContextPath() %>/goods/tmpGoods/addIndex" target="navTab" rel="dlg_page4"  title="商品资料导入"><span>商品资料导入</span></a></li> 
			<li><span id="check">较验</span></li> 
			<li><span id="uploadToTGoods">上传至资料库</span></li> 
		</ul>
	</div>

	<div id="w_list_print">
	<table class="list" width="98%" targetType="navTab" asc="asc" desc="desc" layoutH="116"   >
		<thead> 
			<tr>
				
				<th width="40" >商品条码</th> 
				<th width="40" >商品名称</th> 
				<th width="40" >商品简称</th>  
				<th width="40" >分类编码 </th> 
				<th width="40" >规格</th>  
				<th width="40" >单位</th>  
				<th width="40" >箱装数量</th>  
				<th width="40" >销售倍数</th> 
				<th width="40" >订货倍数</th>  
				<th width="40" >品牌 </th>
				<th width="40" >产地  </th>
				<th width="40" >国家 </th>
				<th width="40" >商品种类</th> 
				<th width="40" >保质期</th> 
				<th width="40" >标准售价</th> 
				<th width="40" >税率</th> 
				<th width="40" >生命周期</th> 
				<th width="40" >拼音码</th>
				<th width="40" >备注</th> 
				<th width="40" >状态</th>
				<th width="40" >长*宽*高*重量</th>
				<th width="40" >箱长*箱宽*箱高*箱重</th>
				<th width="40" >较验结果</th>
			</tr>
		</thead>
		<tbody id = "msgId">
		 
			
		</tbody>
	</table>
	</div> 
		<%@ include file="../../../../resources/common/limit-navtab.jsp"%> 
</div>

<script>
$(function(){
	loadTmpGoodsMsg();
});

$("#uploadToTGoods").click(function(){
	$.ajax({
		type:'POST',
		url:'goods/tmpGoods/uploadToTGoods',
		dataType:"json",
		cache: false,
		success: function (data) {
			 var isValid = data.IsValid;
			 if(isValid){
				 alert(data.ReturnValue);
			 }else{
				 alert(data.ReturnValue);
			 }
		} 
	});
});



$("#check").click(function(){
	$.ajax({
		type:'POST',
		url:'goods/tmpGoods/check',
		dataType:"json",
		cache: false,
		success: function (data) {
			 var isValid = data.IsValid;
			 if(isValid){
				 loadTmpGoodsMsg();
			 }else{
				 alert(data.ReturnValue);
			 }
		} 
	});
});
 
 
function loadTmpGoodsMsg(){
	   $.ajax({
			type:'POST',
			url:'goods/tmpGoods/list',
			dataType:"json",
			cache: false,
			success: function (data) {
				 var isValid = data.IsValid;
				 if(isValid){
					 var dataList = data.DataList; 
					 if(dataList.length>0){ 
						 var msgHtml="";
						 for(var i = 0;i<dataList.length;i++){
							 var data = dataList[i];
							 var status = data.nStatus;
							 var statusMsg = "";
							 if(status == 0){
								 statusMsg = '制单';
							 }
							 if(status == 2){
								 statusMsg = '通过';
							 }
							 if(status == 4){
								 statusMsg = '未通过';
							 }
							 if(status == 6){
								 statusMsg = '上传失败';
							 }
							 	msgHtml +="<tr target='sid_user' rel="+data.ID +"> "; 
								msgHtml +="	<td>"+data.sBarcode +"</td>";
								msgHtml +="	<td>"+data.sGoodsDesc +"</td>";
								msgHtml +="	<td>"+data.sGoodsName +"</td>";
								msgHtml +="	<td>"+data.sCategoryNO +"</td>";
								msgHtml +="	<td>"+data.sSpec +"</td>";
								msgHtml +="	<td>"+data.sUnit +"</td>";
								msgHtml +="	<td>"+data.nCaseUnits +"</td>";
								msgHtml +="	<td>"+data.nSaleUints +"</td>";
								msgHtml +="	<td>"+data.nOrderUnits +"</td>";
								msgHtml +="	<td>"+data.sBrand +"</td>";
								msgHtml +="	<td>"+data.sHome +"</td>";
								msgHtml +="	<td>"+data.sNation +"</td>";
								msgHtml +="	<td>"+data.sGoodType +"</td>";
								msgHtml +="	<td>"+data.nShelfLife +"</td>";
								msgHtml +="	<td>"+data.nNormalSalePrice +"</td>";
								msgHtml +="	<td>"+data.nTaxRate +"</td>";
								msgHtml +="	<td>"+data.nLifeCycle +"</td>";
								msgHtml +="	<td>"+data.sPinyinCode +"</td>";
								msgHtml +="	<td>"+data.sMemo +"</td>";
								msgHtml +="	<td>"+statusMsg +"</td>";
								msgHtml +="	<td>"+data.nLength +"*"+data.nWidth +"*"+data.nHeight +"*"+data.nWeight +"</td>";
								msgHtml +="	<td>"+data.nCaseLength +"*"+data.nCaseWidth +"*"+data.nCaseHeight +"*"+data.nCaseWeight +"</td>";
								msgHtml +="	<td>"+data.sErrorMsg +"</td>";
								msgHtml +="	</tr>";
						 }
						 console.log(msgHtml);
						 $("#msgId").html(msgHtml);
						 
					 }
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
}
</script>