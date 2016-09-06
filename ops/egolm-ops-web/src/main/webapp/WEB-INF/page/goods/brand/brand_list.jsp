<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
<form id="pagerForm" method="post" action="<%=request.getContextPath() %>/goods/brand/list">
	<input type="hidden" name="pageNum" value="1" />  <!--【 必须】 value=1可以写死-->
	<input type="hidden" name="numPerPage" value="${model.numPerPage}" /> <!--【可选】每页显示多少条-->
	<input type="hidden" name="orderField" value="${param.orderField}" />  <!--【可选】查询排序-->
	<input type="hidden" name="orderDirection" value="${param.orderDirection}" />  <!--【可选】 升序降序-->
</form>
<div class="pageHeader">
	<form rel="pagerForm" onsubmit="return navTabSearch(this);" action="<%=request.getContextPath() %>/goods/brand/list" method="post">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>品牌名称</label>
				<input type="text" name="ap_title"/>
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
			<li><a class="add" href="<%=request.getContextPath() %>/goods/brand/index" target="navTab" rel="page1" title="新增品牌" fresh="false"><span>添加</span></a></li>
			<li><a class="delete" href="<%=request.getContextPath() %>/goods/brand/delete?nBrandID={sid_user}"  target="ajaxTodo" title="品牌删除后,将不可恢复,是否继续?" warn=""><span>删除</span></a></li>
			<li><a class="edit" href="<%=request.getContextPath() %>/goods/brand/loadMsgByID?id={sid_user}" target="navTab" rel="page1" title="编辑品牌" fresh="false"><span>编辑</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" targetType="navTab" title=""><span>导出EXCEL</span></a></li>
			<li><a class="icon" href="javascript:$.printBox('w_list_print')"><span>打印</span></a></li>
		</ul>
	</div>

	<div id="w_list_print">
	<table class="list" width="98%" targetType="navTab" asc="asc" desc="desc" layoutH="116"   >
		<thead> 
			<tr>
				<th width="40" >品牌编号</th>
				<th width="120" >品牌名称</th>
				<th width="80" >品牌类型名称</th>
				<th width="80" >图片地址</th> 
			</tr>
		</thead>
		<tbody id="result">
				VM4777:28
				<tr target='sid_user' rel='4'>
					<td>4</td>
					<td>1223</td>
					<td>可口可乐</td>
					<td>http://cdn.egolm.com/brandLogo/2016/04/15/2016_04_15_19_25_41_60831200.png</td>
				</tr>
				<tr target='sid_user' rel='5'>
					<td>B615465563257048</td>
					<td>百事可乐</td>
					<td>可口可乐</td>
					<td>http://cdn.egolm.com/brandLogo/B615465563257048/2016/04/15/2016_04_15_19_26_49_98260361.png</td>
				</tr>
				<tr target='sid_user' rel='8'>
					<td>B19970330381504</td>
					<td>7喜</td>
					<td>一线</td>
					<td>undefined</td>
				</tr>
				<tr target='sid_user' rel='9'>
					<td>B235454689246565</td>
					<td>121212</td>
					<td>一线</td>
					<td>undefined</td>
				</tr>
				<tr target='sid_user' rel='10'>
					<td>B235465923544819</td>
					<td>121212</td>
					<td>一线</td>
					<td>undefined</td>
				</tr>
			</tbody>
	</table>
	</div>
	
		<%@ include file="../../../../resources/common/limit-navtab.jsp"%>
 
</div>

<script  type="text/javascript">
   $(function(){
	   // loadBrandMsg();
   });
   
   
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
						 var resultStr="";
						 for(var i = 0;i<dataList.length;i++){
							 var data = dataList[i];
							 resultStr +="<tr target='sid_user' rel='"+data.nbrandID+"'>";
							 resultStr +="<td>"+data.sbrandNO+"</td>";
							 resultStr +="<td>"+data.sbrandName+"</td>";
							 resultStr +="<td>"+data.sbrandTypeName+"</td>";
							 resultStr +="<td>"+data.sbrandImg+"</td>";
							 resultStr +="</tr>";
 						 }
						 console.log(resultStr);
						 $("#result").html(resultStr); 
					 }
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
   }

</script>