<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="模块管理" currentTopMenu="模板管理" currentSubMenu="模块管理" css="" js="js/common.js" localCss="tpl/tpl-manage.css" localJs="tpl/module-manage.js,tpl/show-big-img.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/module-manage.jsp">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/pagination.css" />
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					<a href="${webHost}/index">首页</a> &gt;  <a href="${egolmHost}${serverName}/template/module/list">模块列表</a>
				</p>
			</div>

				<form id="limitPageForm" method="post">
					<input type="hidden" name="page.index" value="${page.index}" />
					<input type="hidden" name="page.limit" value="10" />
					<input type="hidden" id="nModuleType" name="nModuleType" value="${nModuleType }" />
						<div class="tpl table-box"> <!-- 模板 -->
							<div class="filter-wrap clearfix">
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="模块名称" name="sModuleName" value="${sModuleName }" id="filter" type="text" />
								</label>
								<label class="filter-select dropdown-wrap">
									<a id="contract-type" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span id="nModuleTypeText">${nModuleTypeText }</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="contract-menu" class="dropdown-menu" aria-labelledby="contract-type">
											<li class="module-option">模块类别</li>
											<li class="module-option">导航类</li>
										          	<li class="module-option">商品类</li>
										          	<li class="module-option">广告类</li>
										          	<li class="module-option">品牌类</li>
										          	<li class="module-option">活动类</li>
									</ul>
								</label>
				</form>
								<span>
									<a class="btn-filter" href="javascript:$('#limitPageForm').submit();">查询</a>
								</span>
								<span class="pull-right">
									<!-- <a class="add-message" href="javascript:$('#limitPageForm').submit();"><i class="search-icon"></i>查询</a> -->
									<a class="add-message" href="${egolmHost}${serverName}/template/module/add"><i class="add-icon"></i>新增<span>模块</span></a>
								</span>
							</div>
							<table class="footable table">
								<thead class="bg-color">
									<tr>
										<th data-toggle="true" style="text-align: center">序号</th>
										<th data-hide="phone" style="text-align: center">缩略图</th>
										<th data-hide="phone" style="text-align: center">模块类别</th>
										<th data-hide="phone" style="text-align: center">模块名称</th>
										<th data-hide="phone" style="text-align: center">使用范围</th>
										<th data-hide="phone" style="text-align: center">状态</th>
										<th data-hide="phone,tablet" style="text-align: center">描述</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${datas.result}" var="module" varStatus="i">
										<tr>
											<td style="text-align: center">${i.count+(page.index-1)*10}</td>
											<td style="text-align: center"><img class="show-big" src="http://img.egolm.com${module.sMiniPic}" width="44px" height="44px" id="pic-src-id"></td>
											<td style="text-align: center">${module.nModuleType }</td>
											<td style="text-align: center">${module.sModuleName }</td>
											<td style="text-align: center">${module.sDisplayArea }</td>
											<td style="text-align: center">
												<c:if test="${module.nStatus=='禁用' }">
													<span class="state"><img src="${resourceHost}/images/close.png"/></span>禁用
												</c:if>
												<c:if test="${module.nStatus=='启用' }">
													<span class="state"><img src="${resourceHost}/images/circle.png"/></span>启用
												</c:if>
												
											</td>
											<td style="text-align: center">${module.sRemark }</td>
											<td style="text-align: center">
												<a class="edit" href="${egolmHost}${serverName}/template/module/edit?sModuleNo=${module.sModuleNo}"><img src="${resourceHost}/images/edit.png" alt="编辑" /></a>
												<a class="delete" href="javascript:deleteModule('${module.sModuleNo}')"><img src="${resourceHost}/images/delete.png" alt="删除" /></a>
												
												<c:if test="${module.nStatus=='启用' }">
													<a class="detail orange" href="javascript:updateStatus('${module.sModuleNo}','禁用')">禁用</a>
												</c:if>
												<c:if test="${module.nStatus=='禁用' }">
													<a class="detail orange" href="javascript:updateStatus('${module.sModuleNo}','启用')">启用</a>
												</c:if>
											</td>
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
						<div class="modal fade edit-box" id="editContract" tabindex="-1" role="dialog" aria-labelledby="editContractLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content">
							      	<div class="modal-body">
							        	<form>
							        		<div class="scroll-wrap">
							        			<p><label><span>序号：</span><input type="text" value="10"></label></p>
							        			<p><label><span>缩略图：</span><input type="text" value="基础类"></label></p>
							        			<p><label><span>模块类别：</span><input type="text" value="头部布局"></label></p>
							        			<p><label><span>模块名称：</span><input type="text" value="是"></label></p>
							        			<p><label><span>状态：</span><input type="text" value="已禁用"></label></p>
							        			<p><label><span>描述：</span><input type="text" value="对首页布局及展示内容进行管理"></label></p>
							        		</div>
							        		<p class="clearfix">
							        			<label class="pull-left"><input id="submit" type="button" value="保存"></label>
							        			<label class="pull-right"><input type="button" data-dismiss="modal" value="取消"></label>
							        		</p>
							        	</form>
							      	</div>
						    	</div>
						  	</div>
						</div>
						
						<!-- 确定删除弹窗 -->
						<div class="modal fade delete-box" id="deleteAlert" tabindex="-1" role="dialog" aria-labelledby="deleteAlertLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
							      	<div class="modal-header">
							      		<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
							      	</div>
							      	<div class="modal-body">
							      		<p class="pic"><span></span></p>
							      		<p class="text">是否确认删除？</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" id="btn-confirm" value="确定" />
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="取消" />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
						
						<!--保存成功-->
						<div class="modal fade success-box" id="successAlert" tabindex="-1" role="dialog" aria-labelledby="successAlertLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
							      	<div class="modal-header">
							      		<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
							      	</div>
							      	<div class="modal-body">
							      		<p class="pic"><span></span></p>
							      		<p class="text">保存成功</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="确定" />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>