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
<e:resource title="模板设置" currentTopMenu="" currentSubMenu="" css="" js="" localCss="tpl/tpl-setting.css,tpl/index.css,tpl/tpl-manage.css" showFooter="false" showHeader="false" showSubMenu="false" showMenu="false" showTopMenu="false" localJs="tpl/tpl-setting.js,tpl/check-group-index.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-setting-pop-navcategory.jsp">
	<div class="modal fade edit-box good-sort in" id="editGoodSort" tabindex="-1" role="dialog" aria-labelledby="editGoodSortLabel" style="display: block; padding-right: 0px;">
  	<div class="modal-dialog" role="document">
    	<div class="modal-content border-radius" style="height: 600px;margin-top: 20px;">
    		<div class="modal-header">
    		 
    		</div>
	      	<div class="modal-body">
	        	<form>
	        		<div class="first-level-wrap">
						<div class="dropdown-wrap">
							<a class="dropdown-btn border border-radius bg-color dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
					          	<span class="item-name check-content" id="">一级分类</span>
					          	<span class="dr"><img src="${e:resourceHost('')}${serverName}/resources/assets/images/arrow-black.png"></span>
					        </a>
					        <ul class="dropdown-menu" aria-labelledby="">
						        <c:forEach items="${datas.scopeTypeList[0].categoryList}" var="o">
									<c:if test="${o.parent =='00' }">
								          	<li id="${o.categoryID }" class="item-one">${o.categoryName }</li>
									</c:if>
								</c:forEach>
					        </ul>
						</div>
					</div>
					<div class="three-lv-wrap">
						<a class="btn-add" href="javascript:void(0)"><img src="${e:resourceHost('')}${serverName}/resources/assets/images/add-icon.png"/></a>
						<div class="dropdown-wrap">
							<a class="dropdown-btn border border-radius bg-color dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
					          	<span class="item-name check-content" id="">子级分类</span>
					          	<span class="dr"><img src="${e:resourceHost('')}${serverName}/resources/assets/images/arrow-black.png"></span>
					        </a>
					        <ul class="dropdown-menu check-group" aria-labelledby="">
					          	<li class="clearfix">
						          	<div class="item-group-wrap">
						          	<c:forEach items="${datas.scopeTypeList[0].categoryList}" var="t">
										<c:if test="${t.level == 2}">
						          		<div class="item-group"  pid="${t.parent }" >
						          			<h1 id="${t.categoryID}">${t.categoryName }</h1>
							          		<div class="sort-group clearfix">
							          		<c:forEach items="${datas.scopeTypeList[0].categoryList}" var="s">
													<c:if test="${s.parent == t.categoryID}">
								          			<div class="sort-checkbox pull-left clearfix">
									          			<label class="checked-wrap pull-left">
															<input type="checkbox" class="chk">
															<span class="chk-bg"></span>
														</label>
														<span class="item-name pull-left" id="${s.categoryID }">${s.categoryName }</span>
									          		</div>
									          		</c:if>
											</c:forEach>
							          		</div>
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
							<label class="btn-submit"><input type="button" value="保存" onclick="savePopNavcategory();"/></label>
							<label class="btn-cancel"><input data-dismiss="modal" type="button" value="取消" onclick="closeLayer();"></label>
					</div>
	        	</form>
    		</div>
 	 	</div>
	</div>
	</div>
</e:point>