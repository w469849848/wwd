<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
<form id="pagerForm" method="post" action="<%=request.getContextPath() %>/api/adPos/list">
	<input type="hidden" name="pageNum" value="1" />  <!--【 必须】 value=1可以写死-->
	<input type="hidden" name="numPerPage" value="${model.numPerPage}" /> <!--【可选】每页显示多少条-->
	<input type="hidden" name="orderField" value="${param.orderField}" />  <!--【可选】查询排序-->
	<input type="hidden" name="orderDirection" value="${param.orderDirection}" />  <!--【可选】 升序降序-->
</form>
<div class="pageHeader">
	<form rel="pagerForm" onsubmit="return navTabSearch(this);" action="<%=request.getContextPath() %>/api/adPos/list" method="post">
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
			<li><a class="add" href="<%=request.getContextPath() %>/api/adPos/index" target="navTab" rel="page1" title="新增广告位" fresh="false"><span>添加</span></a></li>
			<li><a class="delete" href="<%=request.getContextPath() %>/api/adPos/delete?id={sid_user}"  target="ajaxTodo" title="广告位删除后,对应的广告也会同步删除,是否继续?" warn=""><span>删除</span></a></li>
			<li><a class="edit" href="<%=request.getContextPath() %>/api/adPos/loadMsgByID?id={sid_user}" target="navTab" rel="page1" title="编辑广告位" fresh="false"><span>编辑</span></a></li>
			<li class="line">line</li>
			<li><a class="icon" href="demo/common/dwz-team.xls" target="dwzExport" targetType="navTab" title=""><span>导出EXCEL</span></a></li>
			<li><a class="icon" href="javascript:$.printBox('w_list_print')"><span>打印</span></a></li>
		</ul>
	</div>

	<div id="w_list_print">
	<table class="list" width="98%" targetType="navTab" asc="asc" desc="desc" layoutH="116"   >
		<thead> 
			<tr>
				<th width="40" >编号</th>
				<th width="120" >合同编号</th>
				<th width="120" >广告位名称</th>
				<th width="80" >广告位区域</th>
				<th width="80" >广告位类型</th>
				<th width="50">类别</th>
				<th width="100">宽度</th>
				<th width="100">高度</th>
				<th width="100">价格(元/月)</th>
				<th width="100">展示类型</th>
				<th width="100">广告状态</th>
				<th width="100">操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${adPosList }" var = "adPos">
			<tr target="sid_user" rel="${adPos.nApID}"> 
					<td>${adPos.nApID }</td>
					<td>${adPos.sContractNO }</td>
					<td>${adPos.sApTitle}</td>
					<td>${adPos.sZoneCode}</td>
					<td> 
						 <c:if test="${adPos.sApSaleType == 'wx' }">微信广告位</c:if>
						 <c:if test="${adPos.sApSaleType == 'app' }">App广告位</c:if>
						 <c:if test="${adPos.sApSaleType == 'web' }">WEB广告位</c:if>					
					</td>
					<td> 
					    <c:if test="${adPos.sApType == 'img' }">图片</c:if>
						<c:if test="${adPos.sApType == 'scroll' }">滚动</c:if>
						<c:if test="${adPos.sApType == 'slide' }">幻灯</c:if>
						<c:if test="${adPos.sApType == 'text' }">文字</c:if> 
					</td>
					<td>${adPos.nApWidth }</td>
					<td>${adPos.nApHeight }</td>
					<td>${adPos.nApPrice }</td>
					<td> 
						<c:if test="${adPos.nApShowType ==0 }">全部展示</c:if> 
						<c:if test="${adPos.nApShowType == 1 }">随机展示</c:if>  
					</td>
					<td>
						<c:if test="${adPos.nApStatus ==0 }">未启用</c:if> 
						<c:if test="${adPos.nApStatus ==1 }">启用</c:if> 					 
					</td>
					<td> 
					<a class="button" href="javascript:;" onclick="alertMsg.info('<%=request.getContextPath() %>/api/adVertView/advert_invoke?nApID=${adPos.nApID}&sZoneCode=${adPos.sZoneCode}')"><span>调用代码</span></a> 
					   
					</td>
					
			</tr> 
		</c:forEach>
			
		</tbody>
	</table>
	</div>
	
		<%@ include file="../../../../resources/common/limit-navtab.jsp"%>

</div>