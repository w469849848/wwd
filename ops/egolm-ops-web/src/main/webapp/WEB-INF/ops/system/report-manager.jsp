<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="报表数据配置"  currentTopMenu="系统管理" currentSubMenu="报表数据配置" css="css/report-manage.css" js="js/common.js" localCss="" localJs="system/report-manage.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/system/report-manager.jsp">

				<div class="main-content">
					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="#">系统管理</a> &gt; 
								<a class="active" href="${webHost}/system/ywReport/index">报表数据配置</a>
							</p>
						</div>
						
						<div class="reportManager table-box"> <!-- 广告管理 -->
						  <form action="" id="limitPageForm"  method= "post"> 
						
							<div class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="菜单ID/名称" id="queryAttr" name="queryAttr" type="text" value="${queryAttr }"/>
								</label>
								 
								
								<span class="pull-right"> 
										<a class="add-message" href="${webHost}/system/ywReport/addIndex"><i class="add-icon"></i>新增</a>
								</span>
								 
								<span class="pull-right" id="query"><a class="add-message" href="#">查询</a> </span>
							</div>
							</form>
							<table class="footable table" data-page-size="5">
								<thead class="bg-color">
									<tr>
										 
										<th data-hide="phone,tablet">菜单ID</th>
										<th data-toggle="true">菜单名称</th>
										<th data-hide="phone,tablet">统计报表标题</th>
										<th data-hide="phone">统计报表类型</th>
										<th data-hide="phone">创建人</th>
										<th data-hide="phone">创建时间</th> 
										<th data-hide="phone">最后更新时间</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="dataMsg">
								
								 
								</tbody>
								<tfoot>
									<tr>
										<td colspan="11" class="clearfix">
										 
										</td>
									</tr>
								</tfoot>
							</table>
						</div> 
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>

