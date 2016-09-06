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
<e:resource title="模板设置" currentTopMenu="" currentSubMenu="" css="" js="" localCss="tpl/tpl-setting.css,tpl/index.css,tpl/tpl-manage.css" showFooter="false" showHeader="false" showSubMenu="false" showMenu="false" showTopMenu="false" localJs="tpl/tpl-setting.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-setting-pop-navigation.jsp">
	<div class="div-setting modal fade edit-box ad-pic in" id="editAdPic" tabindex="-1" role="dialog" aria-labelledby="editAdPicLabel" style="display: block; padding-right: 0px;">
	  	<div class="modal-dialog" role="document">
	    	<div class="modal-content border-radius" style="height: 600px;margin-top: 60px;">
	    		<div class="modal-header">
	    		</div>
		      	<div class="modal-body">
		        	<form>
		        		<div class="table-box ">
		        			<div class="result-wrap">
								<ul class="clearfix">
									 <%-- <li class="border border-radius bg-color orange">
										<input type="text" value="bb专区" />
										<a href="javascript:void(0)"><img src="${resourceHost}/images/btn-delete.png"/></a>
									</li>  --%>
								</ul>
							</div>		
							<div class="table-scroll">
								<div class="table-head">
									<table class="footable table even border border-radius" data-page-size="10">
										<thead class="bg-color">
											<tr>
												<th data-toggle="true">专区名称</th>
												<th data-hide="phone">描述</th>
												<th data-hide="phone">所属区域</th>
												<th data-hide="">操作</th>
											</tr>
										</thead>
									</table>
							</div>
							<div class="scroll-wrap">
								<table class="footable table even border border-radius" data-page-size="10">
									<thead class="bg-color hide">
										<tr>
											<th data-toggle="true">专区名称</th>
											<th data-hide="phone">描述</th>
											<th data-hide="phone">所属区域</th>
											<th data-hide="">操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${datas.result}" var="d">
											<tr>
												<td>${d.sTplName}</td>
												<td>${d.sTplDesc}</td>
												<td>${d.sBelongArea}</td>
												<td>
													<a class="detail"  name="${d.sTplName }" id="${d.sTplNo}" href="javascript:void(0)">选择</a>
												</td>
										</c:forEach>
									</tbody>
								</table>
				        		<div class="btn-wrap">
									<label class="btn-submit"><input type="button" value="保存" onclick="choseNav();"></label>
									<label class="btn-cancel"><input data-dismiss="modal" type="button" value="取消" onclick="closeLayer();"></label>
								</div>
						</div>
		        		</div>
		        		</div>
		        	</form>
		      	</div>
	    	</div>
	  	</div>
</e:point>