<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ page language="java" import="com.egolm.security.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="业务员管理" currentTopMenu="业务员管理" currentSubMenu="业务员管理" 
	        js=""
	        localJs="salesman/salesman-select.js"
	        css="css/index.css" 
	        localCss="cust/cust-manage.css"
	        showHeader="false"
	        showTopMenu="false" 
	        showFooter="false" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/sales/salesman-select.jsp">
	<div class="page-content">
		<div class="cust table-box">
			<div class="filter-wrap clearfix">
				<form id="limitPageForm" method="post" action="salesmanNOList">
					<label class="">
						<i class="icon-search f-95"></i>
						<input class="filter border-radius bg-color" placeholder="中文名" name="sSalChineseName" value="${sSalChineseName }" id="filter" type="text" />
						<input type="hidden" name="saleNO" value="${saleNO }">
					</label>
					<span class="pull-right"> <a class="add-message" href="javascript:$('#limitPageForm').submit();">
						<i class="search-icon"></i>查询</a>
					</span>
				</form>
			</div>

			<table class="footable table even" data-page-size="5" id="listTable">
				<thead class="bg-color">
					<tr>
						<th></th>
						<th data-toggle="true">业务员编号</th>
						<th data-hide="phone">姓名</th>
						<th data-hide="phone">英文名字</th>
						<th data-hide="phone">业务区域</th>
						<th data-hide="phone">业务员类型</th>
						<th data-hide="phone">手机号码</th>
						<th data-hide="phone,tablet">所属单位</th>
						<th data-hide="phone">状态</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${datas.DataList}" var="d">
						<tr saleId="${d.sSaleId }" salChinName="${d.sSalChineseName }">
							<td>
								<label class='checked-wrap'>
									<input type="radio" class="chk salesMan-check" name="${d.sSalChineseName }"  data-id="${d.sSaleId }"/>
							 		<span class='chk-bg'></span>
								</label>
							</td>
							<td>${d.sSalNum}</td>
							<td>${d.sSalChineseName}</td>
							<td>${d.sSalEngName}</td>
							<td>${d.sSalBizZone}</td>
							<td>${d.sSalType}</td>
							<td>${d.sSalMobileNo}</td>
							<td>${d.sSalOrgName}</td>
							<td><span class="state">
								<c:if test="${d.nTag ==0}">
									<img src="${pageContext.request.contextPath}/resources/egolm/assets/images/close.png" />
								</span>未审核
								</c:if> 
								<c:if test="${d.nTag ==1}">
									<img src="${pageContext.request.contextPath}/resources/egolm/assets/images/circle.png" />
								</span>已审核
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="10" class="clearfix">
							<div class="batch">
								<label><input class="border border-radius bg-color f-50" type="button" value="确定" onClick="savePage();"/></label>
							</div>
							<c:set var="pagerForm" value="limitPageForm" scope="request"/>
							<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</e:point>
