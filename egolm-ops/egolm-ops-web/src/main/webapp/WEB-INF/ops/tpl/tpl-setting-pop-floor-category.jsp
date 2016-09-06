<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<c:set scope="application" var="egolmHost"     value="${e:egolmHost('')}" />
<c:set scope="application" var="mediaHost"     value="${e:mediaHost('')}" />
<c:set scope="application" var="resourceHost"  value="${e:resourceHost('')}${serverName}/resources/assets" />
<c:set scope="application" var="localHost"     value="${e:localHost()}" />
<c:set scope="application" var="serverName"    value="${e:serverName()}" />
<c:set scope="application" var="webHost"       value="${egolmHost}${serverName}" />
<e:resource title="模板设置" currentTopMenu="" currentSubMenu="" css="" js="" localCss="tpl/tpl-setting.css,tpl/index.css,tpl/tpl-manage.css" showFooter="false" showHeader="false" showSubMenu="false" showMenu="false" showTopMenu="false" localJs="tpl/tpl-setting.js,tpl/check-group.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-setting-pop-floor-category.jsp">
	<div class="modal fade edit-box good-sort in" id="editGoodSort" tabindex="-1" role="dialog" aria-labelledby="editGoodSortLabel" style="display: block; padding-right: 0px;">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
						    		<div class="modal-header">
						    			<h1> </h1>
						    			<p class="line"></p>
						    		</div>
							      	<div class="modal-body">
							        	<form>
											<div class="three-lv-wrap">
												<a class="btn-add" href="javascript:void(0)"><img src="${e:resourceHost('')}${serverName}/resources/assets/images/add-icon.png"></a>
												<div class="dropdown-wrap">
													<a class="dropdown-btn border border-radius bg-color dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
											          	<span class="item-name check-content">未选择</span>
											          	<span class="dr"><img src="${e:resourceHost('')}${serverName}/resources/assets/images/arrow-black.png"></span>
											        </a>
											        <ul class="dropdown-menu check-group" aria-labelledby="">
											          	<li class="clearfix">
												          	<div class="item-group-wrap">
																	<c:forEach items="${datas.scopeTypeList[0].categoryList}" var="o">
																	<c:if test="${o.parent =='00' }">
																		<div class="item-group">
													          					<h1>${o.categoryName }【一级】</h1>
													          					<c:forEach items="${datas.scopeTypeList[0].categoryList}" var="t">
											          							<c:if test="${t.parent == o.categoryID}">
											          								<h1><label class="checked-wrap pull-left"></label>${t.categoryName }【二级】</h1>
											          								<div class="sort-group clearfix">
											          										<c:forEach items="${datas.scopeTypeList[0].categoryList}" var="s">
									          												<c:if test="${s.parent == t.categoryID}">
											          												<div class="sort-checkbox pull-left clearfix">
																					          			<label class="checked-wrap pull-left">
																											<input id="categoryID${s.categoryID }" type="checkbox" class="chk" value="${s.categoryID }"  attr="${s.categoryName  }"/>
																											<span class="chk-bg"></span>
																										</label>
																										<span class="item-name pull-left">${s.categoryName }<input type='hidden'  id="categoryID" value="${s.categoryID }"/></span>
																					          		</div>
											          										</c:if>
											          										</c:forEach>
											          								</div>
											          							</c:if>
													          					</c:forEach>
													          			</div>
																	</c:if>
																	</c:forEach>
												          	</div>
											          	</li>
											        </ul>
												</div>
											</div>
							        		<div class="scroll-wrap border border-radius bg-color">
							        			<ul>
							        			</ul>
							        		</div>
							        		<div class="btn-wrap">
												<label class="btn-submit"><input type="button" value="保存" onclick="savePopFloorCategory();"/></label>
												<label class="btn-cancel"><input data-dismiss="modal" type="button" value="取消" onclick="closeLayer();"></label>
											</div>
							        	</form>
							      	</div>
						    	</div>
						  	</div>
						</div>
</e:point>