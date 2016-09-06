<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<style>
	.JWindowBody {left:50%;margin-left:-250px;top:50%;margin-top:-190px;}
</style>
<e:resource title="模板管理-微信" currentTopMenu="模板管理-微信" currentSubMenu="" css="css/template-list.css" js="js/common.js" localJs="template/template-list.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/template/template-list.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置：
					<a href="${webHost}/index">首页</a>
					&gt;
					<a href="${webHost}/tpl/get">模板管理-微信</a>
					&gt;
					<a class="active" href="javascript:void(0);">模板列表</a>
				</p>
			</div>

			<div class="goods table-box">
				<!-- 模板列表 -->
				<form action="get" id="limitPageForm" method="post">
					<input type="hidden" name="page.index" value="${page.index}" /> <input type="hidden" name="page.limit" value="10" /> <input type="hidden" name="page.limitKey" value="nTplPageID" />
					<div class="filter-wrap">
						<label class="" style="width:400px;">
							<i class="icon-search f-95"></i><input style="width:350px;" class="filter border-radius bg-color" placeholder="模板名称" name="queryKey" value="${queryKey}" type="text" />
						</label>
						<label class="" style="width:155px;">
							<select class="filter-status border bg-color border-radius" name="nTerminalTypeID">
								<option value="0">终端类型</option>
								<option value="1" <c:if test="${nTerminalTypeID eq 1}">selected</c:if>>微信</option>
								<option value="2" <c:if test="${nTerminalTypeID eq 2}">selected</c:if>>WEB</option>
								<option value="4" <c:if test="${nTerminalTypeID eq 4}">selected</c:if>>Android</option>
								<option value="8" <c:if test="${nTerminalTypeID eq 8}">selected</c:if>>IOS</option>
							</select>
							<select class="filter-status border bg-color border-radius" name="nScopeTypeID">
								<option value="">经营范围</option>
								<c:forEach items="${scopes }" var="scope">
									<option value="${scope.sScopeTypeID}" <c:if test="${nScopeTypeID eq scope.sScopeTypeID}">selected</c:if>>${scope.sScopeType}</option>
								</c:forEach>
							</select>
						</label>
						<span class="pull-right">
							<span id="query">
								<a class="add-message" href="javascript:$.limitTo(1);">查询</a>
							</span>
						</span>
					</div>
				</form>
				<table class="footable table" data-page-size="13">
					<thead class="bg-color">
						<tr>
							<th data-hide="phone">模板编号</th>
							<th data-hide="phone">模板名称</th>
							<th data-hide="phone">模板宽度</th>
							<th data-hide="phone">区域编号</th>
							<th data-hide="phone">终端类型</th>
							<th data-hide="phone">经营范围</th>
							<th data-hide="phone">模板类型</th>
							<th data-hide="phone">模板状态</th>
							<th data-hide="phone"></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${tplpages}" var="tplpage">
							<tr>
								<td>${tplpage.nTplPageID }</td>
								<td>${tplpage.sPageName }</td>
								<td>${tplpage.nWidth }</td>
								<td>${tplpage.sOrgNO }</td>
								<td>${tplpage.sTerminalType }</td>
								<td>
									<c:forEach items="${scopes}" var="scope">
										<c:if test="${scope.sScopeTypeID eq tplpage.nScopeTypeID}">${scope.sScopeType }</c:if>
									</c:forEach>
								</td>
								<td>
									<c:if test="${tplpage.sPageTypeID eq 'M' }">主页</c:if>
									<c:if test="${tplpage.sPageTypeID eq 'A' }">专区</c:if>
								</td>
								<td>
									<c:if test="${tplpage.nTag == 0 }"><font style="color:red;">未使用</font></c:if>
									<c:if test="${tplpage.nTag == 1 }"><font style="color:green;">使用中</font></c:if>
								</td>
								<td>
									<a href="javascript:ToCreateTplPage(${tplpage.nTplPageID});">修改</a>
									<a href="edit?nTplPageID=${tplpage.nTplPageID}">编辑</a>
									<a href="javascript:AjaxDeleteTplPageByID(${tplpage.nTplPageID});">删除</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="13" class="clearfix">
								<div class="batch">
									<label>
										<input class="border border-radius bg-color f-50" type="button" id="TplPageCreateButton" value="新增模板" />
										<input class="border border-radius bg-color f-50" type="button" id="TplPageFlushButton" value="刷新缓存" />
									</label>
								</div>
								<c:set var="pagerForm" value="limitPageForm" scope="request"/>
								<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</e:point>

