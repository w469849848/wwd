<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>  
<c:set scope="application" var="resourceHost"  value="${e:resourceHost('')}${serverName}/resources/assets" />

<e:resource title="会员管理" currentTopMenu="会员管理" currentSubMenu="会员管理" css="" js="js/common.js" localCss="cust/cust-manage.css" localJs="cust/cust-manage.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/customer/cust-manage.jsp">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/pagination.css" />

			<div class="main-content">

				<div class="page-content">

					<div class="wh_titer">
						<p class="wh_titer_f">
							您的位置： <a href="/${serverName}">首页</a> &gt; <a href="#">会员管理</a> &gt; <a
								class="active" href="customerList">会员管理</a>
						</p>
					</div>

					<div  class="cust table-box">
						<div class="filter-wrap clearfix">
							<form id="limitPageForm" method="post">
							<input type="hidden" name="page.index" value="${page.index}" />
							<input type="hidden" name="page.limit" value="10" />
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="会员名称" name="sCustName" value="${sCustName }" id="filter" type="text" />
								</label>
								<span class="pull-right">
									<a class="add-message" href="javascript:$('#limitPageForm').submit();"><i class="search-icon"></i>查询</a>
									<a class="add-message" href="toAddCustomer"><i class="add-icon"></i>新增<span>会员</span></a>
								</span>
							</form>
							</div>
						<table class="footable table even" data-page-size="5">
							<thead class="bg-color">
								<tr>
									<th></th>
									<th data-toggle="true">会员姓名</th>
									<th data-hide="">手机</th>
									<th data-hide="phone,tablet">会员等级</th>
									<th data-hide="phone,tablet">邮箱</th>
									<!-- <th data-hide="phone,tablet">开店业务员</th>
									<th data-hide="phone,tablet">维护业务员</th> -->
									<th data-hide="phone">状态</th>
									<th data-hide="">修改时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${datas}" var="d">
									<tr title="${d.sCustNO}">
										<td><label class="checked-wrap">
											 <input type="hidden" value="${d.sCustNO }" id="sCustNO"/>
											 <input type="hidden" value="${d.sCustLeveTypeID }" id="sCustLeveTypeID"/>
										 <input type="checkbox" class="chk cust-check" data-id="${d.sCustNO}" data-ltid="${d.sCustLeveTypeID }" data-tag="${d.nTag}"/> 
										 <span class="chk-bg"></span>
										</label>
										</td>
										<td>${d.sCustName }</td>
										<td>${d.sMobile }</td>
										<td>${d.sCustLeveType }</td>
										<td>${d.sEmail }</td>
										<%-- <td>${d.sSalChineseNameNO1 }</td>
										<td>${d.sSalChineseNameNO2 }</td> --%>
										<td>
											<c:if test="${d.nTag != 1}">
												<span class="state"><img
													src="${pageContext.request.contextPath}/resources/egolm/assets/images/circle.png" />
												</span>启用
											</c:if> 
											<c:if test="${d.nTag == 1}">
												<span class="state"><img
													src="${pageContext.request.contextPath}/resources/egolm/assets/images/close.png" />
												</span>禁用
											</c:if>
										</td>
										<td><fmt:formatDate value='${d.dLastUpdateTime }' pattern='yyyy-MM-dd HH:mm:ss'/></td>
										<td style="text-align: center">
												<a class="edit" href="toAddOrEditCust?editCustId=${d.sCustNO}"><img src="${resourceHost}/images/edit.png" alt="编辑" /></a>
												<a class="detail orange" href="javascript:resetPassword('${d.sCustNO}')">重置密码</a>
												<!-- <a class="delete" href="javascript:deleteCust('${d.sCustNO}')"><img src="${resourceHost}/images/delete.png" alt="删除" /></a> -->
												
												<c:if test="${d.nTag != 1}">
													<a class="detail orange" href="javascript:updateTag('${d.sCustNO}',1)">禁用</a>
												</c:if>
												<c:if test="${d.nTag == 1}">
													<a class="detail orange" href="javascript:updateTag('${d.sCustNO}',0)">启用</a>
												</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="10" class="clearfix">
										<div class="batch">
											<label>
												<input type="checkbox" class="chk check-all" />
													<span class="chk-bg"></span>
												<span class="txt">全选</span>
											</label>
											<label>
												<input id="batch-update-cust" class="border border-radius bg-color f-50" type="button" value="批量禁用/启用" />
											</label>
											<label>
												<input id="batch-reset-password" class="border border-radius bg-color f-50" type="button" value="批量重置密码" />
											</label>
										</div>
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
									<form action="toAddOrEditCust" id="toEditPageForm">
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
											data-dismiss="modal" value="确定" id="back_btn"/>
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
		