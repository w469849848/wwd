<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>  
<e:resource title="商品销售报表"  currentTopMenu="数据管理" currentSubMenu="" css="css/generalReport.css" js="js/common.js" localCss="" localJs="/report/generalReport.js,/report/report.js,/report/print.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/report/generalReport.jsp">
 				<div class="main-content">									 
					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="#">数据管理</a> &gt; 
								<a class="active" href="${webHost}/data/generalReport/index?moduleID=${moduleID}&ModuleName=${ModuleName}&type=${type}">${ModuleName}</a>
							</p>
						</div>
						
						<div class="generalReport table-box border-radius"> <!-- 报表统计 -->
						
						  <form action ="",method="post" id="reportQueryFrom" > 
						      <input type="hidden" name="moduleID" id="moduleID" value="${moduleID}" />  
						      
						      
						      <!-- 查询条件  开始 -->
								<div class="filter-wrap clearfix" >
								    <div class="pull-left l-box"  id="queryMsg">
								    
								    </div>
									
									<div class="pull-right r-box" id="queryButton">
									     
								     </div>
								</div>
								
								
								
								<!-- 查询条件  结束-->
							 </form>
							<table class="footable table even" data-page-size="10"  id="printid"> 
								<thead class="bg-color" id="dataTitle">
									 
								</thead>
								<tbody id="dataMsg">
								    
								   
								</tbody>
								<tfoot>
									 <tr>
										<td colspan="10" class="clearfix">
											<div class="batch">
											     <label>
													 
												</label>
											     <label class="oper" style="display: none;"><input class="border border-radius bg-color f-50" type="button" value="批量导出" id="export"/></label> 
											     <label class="oper" style="display: none;"><input class="border border-radius bg-color f-50" type="button" value="打印" id="print"/></label> 
											</div> 
										</td>
									</tr>
								</tfoot>
 							</table>
						</div> 
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>			
	
