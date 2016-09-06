<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<e:resource title="分类管理" currentTopMenu="城市管理" currentSubMenu="模板管理" css="" js="js/common.js" localCss="tpl/category-add.css" localJs="jquery.form.js,tpl/category-update.js,tpl/jsAddress.js,tpl/Sortable.min.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/category-update.jsp">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/pagination.css" />
<script type="text/javascript">
	var $index = 0;
	var $items = '${items}';
</script>
	<div class="main-content">

		<div class="page-content">
			
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置：
					<a href="#">首页</a> &gt; 
					<a href="list">分类管理</a> &gt; 
					<a class="active" href="add">商品分类编辑</a>
				</p>
			</div>
			
			<div class="add-box"> <!-- 新增商品分类 -->
				<form id="categoryForm" action="update" method="post">
					<input type="hidden" name="sScopeType" value="${cg.sScopeType }" />
				    <input type="hidden" name="sScopeTypeID" value="${cg.sScopeTypeID }" />
				    
				    <input type="hidden" name="sOrgNO" value="${cg.sOrgNO }" />
				    <input type="hidden" name="sOrgName" value="${cg.sOrgName }" />
				    
				    <input type="hidden" name="cateItems" value="" />
				    
					<div class="area clearfix">
						<span class="tips pull-left">所属区域：</span>
						<label class="pull-left filter-select dropdown-wrap">
							<input type="text" id="orgNo_input" value="${cg.sOrgName }" disabled="disabled"/>
							<span class="dr"><img src="${resourceHost }/images/arrow-black.png"/></span>
						</label>
					</div>
					<div class="channel clearfix">
						<span class="tips pull-left">店铺类型：</span>
						<div class="dropdown-wrap pull-left">
							<a class="dropdown-btn border bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
								<span class="item-name" id="scope-name" disabled="disabled">${cg.sScopeType }</span>
								<span class="dr"><img src="${resourceHost }/images/arrow-black.png"/></span>
							</a>
						</div>
					</div>
					<div class="sort">
						<div class="tips">商品分类：</div>
						<div class="sort-list">
							<c:forEach items="${categoryMap.DataList}" var="cg">
								<div class="item-wrap">
									<h1 class="f-sort">
										<label class="checked-wrap">
											<input type="checkbox" class="chk" scategoryNO="${cg.scategoryNO }" scategoryName="${cg.scategoryName }" level="${cg.level }" supCategoryNO="${cg.supCategoryNO }" />
											<span class="chk-bg" ></span>
										</label>
										<span>${cg.scategoryName }</span>
									</h1>
									<ul class="sec-sort">
										<c:forEach items="${cg.child}" var="cg1">
											<li>
												<div class="sec-tit">
													<label class="checked-wrap">
														<input type="checkbox" class="chk" scategoryNO="${cg1.scategoryNO }" scategoryName="${cg1.scategoryName }" level="${cg1.level }" supCategoryNO="${cg1.supCategoryNO }">
														<span class="chk-bg"></span>
													</label>
													<span>${cg1.scategoryName }</span>
												</div>
												<ul class="th-sort clearfix">
													<c:forEach items="${cg1.child}" var="cg2">
														<li>
															<div>
																<label class="checked-wrap">
																	<input type="checkbox" class="chk" scategoryNO="${cg2.scategoryNO }" scategoryName="${cg2.scategoryName }" level="${cg2.level }" supCategoryNO="${cg2.supCategoryNO }">
																	<span class="chk-bg"></span>
																</label>
																<span>${cg2.scategoryName }</span>
															</div>
														</li>
													</c:forEach>
												</ul>
											</li>
										</c:forEach>
									</ul>
								</div>
							</c:forEach>
						</div>
						<!-- <p>*拖动分类更改顺序</p> -->
					</div>
					<div class="btn-wrap">
						<label class="btn-submit"><input type="button" value="保存" onclick="commitForm()"></label>
						<label class="btn-cancel"><input data-dismiss="modal" type="button" value="取消" onclick="location.href='${egolmHost}${serverName}/category/list'"></label>
					</div>
				</form>
			</div>
			
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
								<label class="btn-submit"><input type="button" value="保存" onclick="commitForm()"></label>
								<label class="btn-cancel"><input data-dismiss="modal" type="button" value="取消" onclick="location.href='${egolmHost}${serverName}/template/module/list'"></label>
							</div>
				      	</div>
			    	</div>
			  	</div>
			</div>
			
		</div><!-- /.page-content -->
	</div><!-- /.main-content -->
</e:point>
<script type="text/javascript">
		/* jQuery(function($){
			sort_1();
			sort_1_1();
			sort_1_2();
		});
		
		function sort_1(){
			window.x = new Sortable(child_1, {
				group: "words",
				store: {
					get: function (sortable) {
						var order = localStorage.getItem(sortable.options.group);
						return order ? order.split('|') : [];
					},
					set: function (sortable) {
						var order = sortable.toArray();
						localStorage.setItem(sortable.options.group, order.join('|'));
					}
				}
			});
		}
		
		function sort_1_1(){
			window.x = new Sortable(child_1_1, {
				group: "words",
				store: {
					get: function (sortable) {
						var order = localStorage.getItem(sortable.options.group);
						return order ? order.split('|') : [];
					},
					set: function (sortable) {
						var order = sortable.toArray();
						localStorage.setItem(sortable.options.group, order.join('|'));
					}
				}
			});
		}
		
		function sort_1_2(){
			window.x = new Sortable(child_1_2, {
				group: "words",
				store: {
					get: function (sortable) {
						var order = localStorage.getItem(sortable.options.group);
						return order ? order.split('|') : [];
					},
					set: function (sortable) {
						var order = sortable.toArray();
						localStorage.setItem(sortable.options.group, order.join('|'));
					}
				}
			});
		} */
</script>