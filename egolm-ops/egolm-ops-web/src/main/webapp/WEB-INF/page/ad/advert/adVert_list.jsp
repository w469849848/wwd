<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
<form id="pagerForm" method="post" action="<%=request.getContextPath() %>/api/adVert/list?selectType=all">
	<input type="hidden" name="pageNum" value="1" />  <!--【 必须】 value=1可以写死-->
	<input type="hidden" name="numPerPage" value="${model.numPerPage}" /> <!--【可选】每页显示多少条-->
	<input type="hidden" name="orderField" value="${param.orderField}" />  <!--【可选】查询排序-->
	<input type="hidden" name="orderDirection" value="${param.orderDirection}" />  <!--【可选】 升序降序-->
</form>
<div class="pageHeader">
	<form rel="pagerForm" onsubmit="return navTabSearch(this);" action="<%=request.getContextPath() %>/api/adVert/list?selectType=all" method="post">
	<div class="searchBar">
		<ul class="searchContent">
			<li>
				<label>广告名称:</label>
				<input type="text" name="ad_title"/>
			</li>
			<li>
				<label>广告位置:</label>
				 <select name="ap_sale_type" class="required combox" ref="combox_ap_msg" refUrl="<%=request.getContextPath() %>/api/adPos/loadMsgByApSaleType?ap_sale_type={value}">
 					<option value="">请选择</option>
 					<option value="wx"  >微信广告位</option>
         		 	<option value="web"  >WEB广告位</option>
         		    <option value="app">App广告位</option> 
				 </select> 
			</li>
			<li>
			   <label>广告位名称:</label>
			   <select name="ad_ap_id" class="required combox" id="combox_ap_msg">
 					 <option value="">请选择广告位</option>
				 </select> 
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
			<li><a class="add" href="<%=request.getContextPath() %>/api/adVert/index" target="navTab" rel="page1" title="新增广告" fresh="false"><span>添加</span></a></li>
			<li><a class="delete" href="<%=request.getContextPath() %>/api/adVert/delete?id={sid_user}" target="ajaxTodo" title="" warn=""><span>删除</span></a></li>
			<li><a class="edit" href="<%=request.getContextPath() %>/api/adVert/loadMsgById?id={sid_user}" target="navTab" rel="page1" title="编辑广告" fresh="false"><span>编辑</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" targetType="navTab" title=""><span>导出EXCEL</span></a></li>
			<li><a class="icon" href="javascript:$.printBox('w_list_print')"><span>打印</span></a></li>
		</ul>
	</div>

	<div id="w_list_print">
	<table class="list" width="98%" targetType="navTab" asc="asc" desc="desc" layoutH="116" rel="adAdvertListPage">
		<thead> 
			<tr>
				<th width="100" >广告编号</th>
				<th width="100" >广告名称</th>
				<th width="100">所属广告位</th>
				<th width="100">广告位类别</th>
				<th width="100">所属区域</th>
				<th width="100">开始时间</th>
				<th width="100">结束时间</th>
				<th width="100">点击率</th>
				<th width="90">幻灯片序号</th>
				<th width="100">广告状态	</th>  
			</tr>
		</thead>
		<tbody>
		
		 <c:forEach items="${adVertList}" var="data">
			<tr target="sid_user" rel="${data.nAdID }">
				<td>${data.nAdID }</td>
				<td>${data.sAdTitle }</td>
				<td>${data.sApTitle }</td>
				<td>
				  <c:if test="${data.sApSaleType=='wx'}">微信广告位</c:if>
				  <c:if test="${data.sApSaleType=='web'}">WEB广告位</c:if>
				  <c:if test="${data.sApSaleType=='app'}">App广告位</c:if>
				</td>
				<td>${data.sAdZoneCode}</td>
				<td>${data.dAdBeginTime}</td>
				<td>${data.dAdEndTime}</td>
				<td>${data.nAdClickNum}</td>
				<td>${data.nAdSlideSequence}</td>
				<td>
				   <c:if test="${data.nTag==0}">未审核</c:if>
				   <c:if test="${data.nTag==1}">审核未通过</c:if>
				   <c:if test="${data.nTag==2}">审核通过</c:if>
				</td>
			</tr> 
			</c:forEach>
		</tbody>
	</table>
	</div>
	
	<%@ include file="../../../../resources/common/limit-navtab.jsp"%>
	
	</div>
 