<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<c:set scope="application" var="resourceHost"
	value="${e:resourceHost('')}${serverName}/resources/assets" />

<e:resource title="会员管理" currentTopMenu="会员管理" currentSubMenu="" css=""
	js="js/common.js" localCss="cust/pwd-manage.css" localJs="cust/pwd-manage.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp"
	currentPath="/WEB-INF/ops/customer/custPswManage.jsp">

	<div class="main-content">

		<div class="page-content">

			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}">首页</a> &gt; <a href="#">用户管理</a> &gt; <a
						class="active" href="custPswManage">密码管理</a>
				</p>
			</div>

			<div class="pwd table-box">

				<div class="filter-wrap clearfix">
					<form id="limitPageForm" method="post">
						<input type="hidden" name="page.index" value="${page.index}" /> <input
							type="hidden" name="page.limit" value="10" /> <label class="">
							<i class="icon-search f-95"></i><input
							class="filter border-radius bg-color" placeholder="会员名称"
							name="sCustName" value="${sCustName }" id="filter" type="text" />
						</label><span class="pull-right"> <a class="add-message"
							href="javascript:$('#limitPageForm').submit();"><i
								class="search-icon"></i>查询</a>
						</span>
					</form>
				</div>
				<table class="footable table even" data-page-size="10">
					<thead class="bg-color">
						<tr>
							<th></th>
							<th data-toggle="true">会员姓名</th>
							<th data-hide="">手机</th>
							<th data-hide="phone,tablet">会员等级</th>
							<th data-hide="phone">状态</th>
							<th data-hide="">修改时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${datas}" var="d" varStatus="ind">

							<tr title="${d.sCustNO}">
								<td><label class="checked-wrap"> <input
										type="checkbox" class="chk" name="pwd_checkboxs" value="${d.sCustNO }" title="${d.nTag }"/> <span
										class="chk-bg"></span>
								</label></td>
								<td>${d.sCustName }</td>
								<td>${d.sMobile }</span></td>
								<td>${d.sCustLeveType }</td>
								<td><c:if test="${d.nTag == 0}">
										<span class="state"><img
											src="${pageContext.request.contextPath}/resources/egolm/assets/images/circle.png" />
										</span>未禁用
											</c:if> <c:if test="${d.nTag == 1}">
										<span class="state"><img
											src="${pageContext.request.contextPath}/resources/egolm/assets/images/close.png" />
										</span>已禁用
											</c:if></td>
								</td>
								<td><fmt:formatDate value='${d.dLastUpdateTime }' pattern='yyyy-MM-dd HH:mm:ss'/></td>
								<td><a class="detail" href="resetPsw?ids=${d.sCustNO }">重置密码</a>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="10" class="clearfix">
								<div class="batch">
									<label> <input type="checkbox" class="chk" /> <span
										class="chk-bg"></span> <span class="txt">全选/取消</span>
									</label> <label><input
										class="border border-radius bg-color f-50" type="button" id="batch_reset_btn"
										value="批量重置" /> </label>
								</div>
								<div class="pagination pagination-centered"></div>

								<c:set var="pagerForm" value="limitPageForm" scope="request"/>
								<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>

		</div>
		<!-- /.page-content -->
	</div>
	<!-- /.main-content -->
</e:point>
