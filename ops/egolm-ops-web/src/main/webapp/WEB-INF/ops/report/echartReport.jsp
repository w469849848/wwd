<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>  
<e:resource title="商品销售报表"  currentTopMenu="数据管理" currentSubMenu="" css="css/echartReport.css" js="js/common.js" localCss="" localJs="/report/echartReport.js,/report/report.js,index/echarts.min.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/report/echartReport.jsp">
 				<div class="main-content">									 
					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="#">数据管理</a> &gt; 
								<a class="active" href="${webHost}/data/generalReport/index?moduleID=${moduleID}&ModuleName=${ModuleName}">${ModuleName}</a>
							</p>
						</div>
						
						<div class="echartReport table-box border-radius"> <!-- 报表统计 -->
						
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
							 
						    <div class="recent" id="chartMsg">
								
							</div>
							 
							 
						</div> 
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>			
	
