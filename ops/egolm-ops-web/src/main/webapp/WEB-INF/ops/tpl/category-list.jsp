<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>

<e:resource title="分类管理" currentTopMenu="城市管理" currentSubMenu="分类管理" css="" js="js/common.js" localCss="tpl/category-list.css" localJs="tpl/category-list.js,tpl/jsAddress.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/category-list.jsp">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/pagination.css" />
<script type="text/javascript">
	var provinceList = JSON.parse('${orglist}');
</script>
	<div class="main-content">

		<div class="page-content">
			
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置：
					<a href="${webHost}/index">首页</a> &gt; 
					<a href="#">城市管理</a> &gt; 
					<a class="active" href="list">分类管理</a>
				</p>
			</div>
			<!-- 查询 -->
			
			<div class="sort-wrap table-box"> <!-- 商品分类 -->
				<div class="filter-wrap clearfix">
					<form id="limitPageForm" action="list" method="post">
					<input type="hidden" name="page.index" value="${page.index}" />
					<input type="hidden" name="page.limit" value="10" />
					
					<input type="hidden" name="sScopeType" value="${sScopeType }" />
					<input type="hidden" name="sScopeTypeID" value="${sScopeTypeID}" />
					<div class="area pull-left">
						<span>所属区域：</span>
						<label class="filter-select dropdown-wrap">
							<input type="hidden" name="sOrgNO" value="${sOrgNO }"/>
							<input type="text" name="sOrgName" value="${sOrgName }"/>
							<span class="dr"><img src="${resourceHost }/images/arrow-black.png"/></span>
						</label>
					</div>
					<div class="channel pull-left">
						<span>店铺类型：</span>
						<label class="filter-select dropdown-wrap">
							<a class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
								<c:if test="${empty sScopeType }">
									<span class="item-name" id="scope-name">请选择</span>
								</c:if>
								<c:if test="${not empty sScopeType }">
									<span class="item-name" id="scope-name">${sScopeType }</span>
								</c:if>
								<span class="dr"><img src="${resourceHost }/images/arrow-black.png"/></span>
							</a>
							<ul class="dropdown-menu" aria-labelledby="contract-type" id="scope-ul">
								<li val="">全部</li>
								<c:forEach items="${scopedatas.datas}" var="scope" varStatus="i">
									<li val="${scope.sComID }">${scope.sComDesc }</li>
								</c:forEach>
							</ul>
						</label>
					</div>
					</form>
					<div class="pull-left">
						<a class="btn-filter" href="javascript:$('#limitPageForm').submit();">查询</a>
					</div>
					<span class="pull-right">
						<a class="add-message" href="add"><i class="add-icon"></i>新增<span>商品分类</span></a>
					</span>
				</div>
				<table class="footable table">
					<thead class="bg-color">
						<tr>
							<th></th>
							<th data-hide="phone">所属区域</th>
							<th data-toggle="true">店铺类型</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${datas.result}" var="cg" varStatus="i">
							<tr>
								<td>
									<label class="checked-wrap">
										<input type="checkbox" class="chk" name="catebox" value="${cg.sOrgNO}-${cg.sScopeTypeID}" />
										<span class="chk-bg"></span>
									</label>
								</td>
								<td>${cg.sOrgName}</td>
								<td>${cg.sScopeType}</td>
								<td>
									<a class="edit" href="${egolmHost}${serverName}/category/update?sOrgNO=${cg.sOrgNO}&sScopeTypeID=${cg.sScopeTypeID}"><img src="${resourceHost }/images/edit.png" alt="编辑" /></a>
									<a class="delete" href="javascript:deleteCategory('${cg.sOrgNO}','${cg.sScopeTypeID }')"><img src="${resourceHost }/images/delete.png" alt="删除" /></a>
									<!-- <a class="detail" href="javascript:void(0)">查看</a> -->
								</td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="10" class="clearfix">
								<div class="batch">
									<label>
										<input type="checkbox" class="chk">
										<span class="chk-bg"></span>
										<span class="txt">全选/取消</span>
									</label>
									<label><input class="border border-radius bg-color f-50" type="button" value="批量导出" onclick="bacthExport()"></label>
									<label><input class="border border-radius bg-color f-50" type="button" value="批量删除" onclick="batchDelete()"></label>
								</div>
								
								<div class="navigation_bar pull-right">
									<ul class="clearfix">
										<!-- <li>
											<a href="javascript:void(0)" class="nav_first"></a>
										</li>
										<li>
											<a href="javascript:void(0)" class="nav_float"></a>
										</li>
										<li class="active"><a href="javascript:void(0)">1</a></li>
										<li><a href="javascript:void(0)">2</a></li>
										<li><a href="javascript:void(0)">3</a></li>
										<li><a href="javascript:void(0)">…</a></li>
										<li><a href="javascript:void(0)">7</a></li>
										<li><a href="javascript:void(0)">8</a></li>
										<li><a href="javascript:void(0)">9</a></li>
										<li><a href="javascript:void(0)" class="nav_right"></a></li>
										<li><a href="javascript:void(0)" class="nav_last"></a></li> -->
										<c:set var="pagerForm" value="limitPageForm" scope="request"/>
										<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
									</ul>
								</div>
								
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
			
			<form id="exportForm" action="export" method="post">
				<input name="param" value="" hidden="hidden"/>
			</form>
			
			<!--区域选择弹窗-->
			<div class="modal fade area-alert" id="areaAlert" tabindex="-1" role="dialog" aria-labelledby="areaAlertLabel">
			  	<div class="modal-dialog" role="document">
			    	<div class="modal-content border-radius">
			    		<div class="modal-header">
			    			<h1>区域选择</h1>
			    			<p class="line"></p>
			    			<a class="btn-close" data-dismiss="modal" aria-label="Close" href="javascript:void(0)"><img src="${resourceHost }/images/btn-close.png"/></a>
			    		</div>
				      	<div class="modal-body">
				       		<div class="select-box clearfix">
				       			<div class="province-box pull-left">
				       				<select id="addProvince"></select>
				       				<a href="javascript:void(0)"><img src="${resourceHost }/images/arrow-black.png"/></a>
				       			</div>
				       			<div class="city-box pull-left">
				       				<select id="addCity"></select>
				       				<a href="javascript:void(0)"><img src="${resourceHost }/images/arrow-black.png"/></a>
				       			</div>
				       			<div class="area-box pull-left">
				       				<select id="addArea"></select>
				       				<a href="javascript:void(0)"><img src="${resourceHost }/images/arrow-black.png"/></a>
				       			</div>
				       		</div>
				       		<div class="btn-wrap">
								<label class="btn-submit"><input type="button" value="保存"></label>
								<label class="btn-cancel"><input data-dismiss="modal" type="button" value="取消"></label>
							</div>
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
