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

<e:resource title="模板管理" currentTopMenu="模板管理" currentSubMenu="模板管理" css="" js="js/common.js" localCss="tpl/tpl-manage.css" localJs="tpl/tpl-manage.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-manage.jsp">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/assets/css/pagination.css" />
	<div class="main-content">
		<div class="page-content">
			
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置：
					<a href="${webHost}/index">首页</a> &gt; 
					<a class="active" href="${webHost }/template/list">模板管理</a>
				</p>
			</div>
			
		<form id="limitPageForm" action="list" method="post">
			<input type="hidden" name="page.index" value="${page.index}" />
			<input type="hidden" name="page.limit" value="10" />
			<input type="hidden" id="sBelongArea" name="sBelongArea" value="${sBelongArea }" />
			<div class="tpl table-box"> <!-- 模板 -->
				<div class="filter-wrap clearfix">
					<label class="">
						<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="模板名称" type="text" id="sTplName" name="sTplName" value="${sTplName }"/>
					</label>
					<label class="filter-select dropdown-wrap" id="belong_area">
						<a id="contract-type" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
							<span>${sBelongArea }</span>
							<span class="dr"><img src="${resourceHost }/images/arrow-black.png"/></span>
							<input type="hidden" id="sBelongNo" name="sBelongNo" value="${sBelongNo }" />
						</a>
						<ul id="contract-menu" class="dropdown-menu" aria-labelledby="contract-type">
							<li val="">区域</li>
							<c:forEach items="${zonelist}" var="zone" varStatus="i">
								<li val="${zone.sBelongNo }">${zone.sBelongArea }</li>
							</c:forEach>
						</ul>
					</label>
		</form>
					<span>
						<a class="btn-filter" href="javascript:$('#limitPageForm').submit();">查询</a>
					</span>
					<span class="pull-right">
						<a class="add-message" href="${webHost }/template/addorupdate"><i class="add-icon"></i>新增<span>模板</span></a>
					</span>
				</div>
				<table class="footable table">
					<thead class="bg-color">
						<tr>
							<th data-hide="phone" style="text-align: center">序号</th>
							<th data-toggle="true" style="text-align: center">模板名称</th>
							<th data-hide="phone" style="text-align: center">所属区域</th>
							<th data-hide="phone" style="text-align: center">店铺类型</th>
							<th data-hide="phone" style="text-align: center">使用范围</th>
							<th data-hide="phone" style="text-align: center">是否首页</th>
							<th data-hide="phone" style="text-align: center">状态</th>
							<th data-hide="phone,tablet" style="text-align: center">描述</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${datas.result}" var="tpl" varStatus="i">
							<tr>
								<td style="text-align: center">${i.count+(page.index-1)*10}</td>
								<td style="text-align: center">${tpl.sTplName }</td>
								<td style="text-align: center">${tpl.sBelongArea }</td>
								<td style="text-align: center">${tpl.sScopeType }</td>
								<td style="text-align: center">${tpl.sDisplayArea }</td>
								<td style="text-align: center">
									<c:if test="${tpl.nIsHome == '1' }">是</c:if>
									<c:if test="${tpl.nIsHome == '0' }">否</c:if>
								</td>
								<td style="text-align: center">
									<c:if test="${tpl.nTag == '1' }">
										<span class="state"><img src="${resourceHost }/images/circle.png"/></span>已发布
									</c:if>
									<c:if test="${tpl.nTag == '0' }">
										<span class="state"><img src="${resourceHost }/images/close.png"/></span>待发布
									</c:if>
								</td>
								<td style="text-align: center">${tpl.sTplDesc }</td>
								<td style="text-align: center">
									<a class="edit" href="javascript:toEdit('${tpl.sTplNo }','${tpl.nTag }')"><img src="${resourceHost }/images/edit.png" alt="编辑" /></a>
									<a class="delete" href="javascript:deleteTpl('${tpl.sTplNo}')"><img src="${resourceHost }/images/delete.png" alt="删除" /></a>
									<a class="detail" href="${egolmHost}${serverName}/template/setting?sTplNo=${tpl.sTplNo }">模板设置</a>
									<c:if test="${tpl.nTag == '1' }">
										<a class="detail orange" href="javascript:updateStatus('${tpl.sTplNo}','0')">取消发布</a>
									</c:if>
									<c:if test="${tpl.nTag == '0' }">
										<a class="detail orange" href="javascript:updateStatus('${tpl.sTplNo}','1')">发布</a>
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
			
		</div><!-- /.page-content -->
	</div><!-- /.main-content -->
	<script type="text/javascript">
	
		function toEdit(tplNo,status){
			var url="${egolmHost}${serverName}/template/addorupdate?sTplNo="+tplNo;
			if(status=='1'){
				alert("已发布状态模板不可以修改，请先取消发布再进行修改。");
				return;
			}else{
				location.href=url;
			}
		}
	
		jQuery(function($){
			
			function customDropDown(ele){
		        this.dropdown = ele;
		        this.spanele = this.dropdown.find("a > span").eq(0);
		        this.inputele = this.dropdown.find("a > input");
		        this.options=this.dropdown.find("ul.dropdown-menu > li");
		        this.initEvents();
		    }
		    customDropDown.prototype={
		        initEvents:function(){
		            var obj=this;
		            //点击下拉列表的选项
		            obj.options.on("click",function(){
		            	var opt = $(this);
		            	obj.inputele.val(opt.attr("val"));
		            	obj.spanele.html(opt.html());
		            	$('input[name="sBelongArea"]').val(opt.html());
		            });
		        },
		        getValue:function(){
		            return this.value;
		        }
		    }
			
			
			var belong_area = new customDropDown($("#belong_area"));
		});
	</script>
</e:point>
