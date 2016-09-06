<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<c:set scope="application" var="resourceHost"
	value="${e:resourceHost('')}${serverName}/resources/assets" />

<e:resource title="会员等级" currentTopMenu="会员管理" currentSubMenu="会员等级" css=""
	js="js/common.js" localCss="cust/grade-manage.css"
	localJs="cust/grade-manage.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp"
	currentPath="/WEB-INF/ops/customer/grade-manage.jsp">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/assets/css/pagination.css" />

	<div class="main-content">

		<div class="page-content">

			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}">首页</a> &gt; <a href="#">用户管理</a> &gt; <a
						class="active" href="leveList">用户等级</a>
				</p>
			</div>

			<div class="grade table-box">
				<div class="filter-wrap clearfix">
					<form id="limitPageForm" method="post">
						<input type="hidden" name="page.index" value="${page.index}" /> <input
							type="hidden" name="page.limit" value="10" /> <label class="">
							<i class="icon-search f-95"></i><input
							class="filter border-radius bg-color" placeholder="等级名称"
							name="sLeveType" value="${sLeveType }" id="filter" type="text" />
						</label>
					</form>
					<span class="pull-right"> <a class="add-message"
						href="javascript:$('#limitPageForm').submit();"><i
							class="search-icon"></i>查询</a> <a class="add-message"
						href="toAddGrade"><i class="add-icon"></i>新增<span>等级</span></a>
					</span>
				</div>
				<table class="footable table even" data-page-size="5">
					<thead class="bg-color">
						<tr>
							<th data-toggle="true">等级图标</th>
							<th data-hide="">等级名称</th>
							<th data-hide="phone">所须积分</th>
							<th data-hide="phone">状态</th>
							<th data-hide="phone,tablet">最后修改时间</th>
							<th data-hide="phone,tablet">创建人</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${datas}" var="d">
							<tr title="${d.sLeveNO}">
								<td>
									<div class="u-info clearfix">
										<img src="${d.sLeveIcon}" width="44px" height="44px"
											id="pic-src-id" />
									</div>
								</td>
								<td>${d.sLeveType }</td>
								<td>${d.nRequiredIntegral }</td>
								<td><c:if test="${d.nTag == 0}">
										<span class="state"><img
											src="${pageContext.request.contextPath}/resources/egolm/assets/images/circle.png" />
										</span>未禁用
											</c:if> <c:if test="${d.nTag == 1}">
										<span class="state"><img
											src="${pageContext.request.contextPath}/resources/egolm/assets/images/close.png" />
										</span>已禁用
											</c:if></td>
								<td><fmt:formatDate value='${d.dLastUpdateTime }'
										pattern='yyyy-MM-dd HH:mm:ss' /></td>
								<td>${d.sCreateUserName }</td>
								<td><a class="edit" href="toEditLeve?sLeveNO=${d.sLeveNO}"><img
										src="${resourceHost}/images/edit.png" alt="编辑" /></a> <a
									class="delete" title="${d.sLeveNO}"><img
										src="${resourceHost}/images/delete.png" alt="删除" /></a> <c:if
										test="${d.nTag == 0}">
										<a class="detail orange"
											href="javascript:updateTag('${d.sLeveNO}',1)">禁用</a>
									</c:if> <c:if test="${d.nTag == 1}">
										<a class="detail orange"
											href="javascript:updateTag('${d.sLeveNO}',0)">启用</a>
									</c:if></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="10" class="clearfix">
								<c:set var="pagerForm" value="limitPageForm" scope="request"/>
								<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>

			<!-- 编辑 -->
			<div class="modal fade edit-box" id="editUser" tabindex="-1"
				role="dialog" aria-labelledby="editUserLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content border-radius">
						<div class="modal-body">
							<form action="toEditCustomer" id="toEditPageForm">
								<input type="hidden" id="editCustId" name="editCustId" value="" />
							</form>
						</div>
					</div>
				</div>
			</div>

			<!-- 确定删除弹窗 -->
			<div class="modal fade delete-box" id="deleteAlert" tabindex="-1"
				role="dialog" aria-labelledby="deleteAlertLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content border-radius">
						<div class="modal-header">
							<a class="pull-right" data-dismiss="modal"
								href="javascript:void(0)"></a>
						</div>
						<div class="modal-body">
							<p class="pic">
								<span></span>
							</p>
							<p class="text">是否确认删除？</p>
							<p class="btn-box clearfix">
								<input class="bg-color border-radius border" type="button"
									id="btn-confirm" value="确定" /> <input
									class="bg-color border-radius border" type="button"
									data-dismiss="modal" value="取消" />
							</p>
						</div>
					</div>
				</div>
			</div>

			<!--保存成功-->
			<div class="modal fade success-box" id="successAlert" tabindex="-1"
				role="dialog" aria-labelledby="successAlertLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content border-radius">
						<div class="modal-header">
							<a class="pull-right" data-dismiss="modal"
								href="javascript:void(0)"></a>
						</div>
						<div class="modal-body">
							<p class="pic">
								<span></span>
							</p>
							<p class="text">保存成功</p>
							<p class="btn-box clearfix">
								<input class="bg-color border-radius border" type="button"
									data-dismiss="modal" value="确定" />
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /.page-content -->
	</div>
	<!-- /.main-content -->

</e:point>


<script type="text/javascript">
	
	
	
</script>