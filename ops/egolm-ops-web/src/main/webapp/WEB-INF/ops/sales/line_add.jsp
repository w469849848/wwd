<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="业务员管理" currentTopMenu="业务员管理" currentSubMenu="线路管理"
	css="css/add-salesman.css,css/bootstrap-select.min.css"
	js="js/bootstrap-select.min.js" localJs="salesman/line_add.js"
	localCss="salesman/salesman.css" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp"
	currentPath="/WEB-INF/ops/sales/line_add.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}">首页</a> &gt; <a href="lineList">线路管理</a>&gt;
					<a class="active" href="#">新增线路</a>
				</p>
			</div>
			<div class="add-box">
				<!-- 新增任务 -->
				<form method="post" id="salesFrom" name="salesFrom">
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7"> 
							<span class="col-xs-4 col-sm-2 shop-tpl">线路名称：</span> 
							<label class="col-xs-7 col-sm-9"> 
								<input class="border border-radius bg-color" type="text" id="sLineName" name="sLineName" />
								<input class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="添加线路店铺" id="select-shop"/>
							</label>
						</small>
					</p>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
							<div class="col-xs-12 col-sm-6 mr">
								<span class="col-xs-4 input-tips shop-tpl">线路店铺：</span>
								<div class="col-xs-7 dropdown-wrap shop-list">
								<table class="footable table even" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th>店铺编号</th>
										<th>店铺名称</th>
										<th>店铺地址</th>
										<th>任务模板</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody class="shop-info">
									
								</tbody>
								</table>
								</div>
							</div>
						</div>
					</div>
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7"> 
							<span class="col-xs-4 col-sm-2 shop-tpl">备注：</span> 
							<label class="col-xs-7 col-sm-9"> 
								<textarea class="border border-radius bg-color" rows="4" id="sRemark" name="sRemark"></textarea>
							</label>
						</small>
					</p>
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7"> 
							<span class="col-xs-4 col-sm-2 shop-tpl"></span> 
							<label class="col-xs-7 col-sm-9"> 
								<input id="submit-line-create" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="提交" /> 
								<input class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="取消" onclick="window.location.href='taskList'" />
							</label>
						</small>
					</p>
					<p class="row">
						
					</p>
				</form>
			</div>
		</div>
	</div>
	<div class="hidden" id="task-tel-options">
		<c:forEach var="data" items="${tpls.DataList}">
			<option value="${data.sTemplateId }">${data.sTemplateName }</option>
		</c:forEach>
	</div>
</e:point>