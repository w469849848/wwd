<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="店铺数据管理"  currentTopMenu="数据管理" currentSubMenu="店铺数据管理" css="css/traffic-analysis.css" js="" localCss="" localJs="report/traffic-analysis.js,index/echarts.min.js,common.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/report/traffic-analysis.jsp">
      <div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt;
								<a class="active" href="${webHost}/data/shopFlowReport/index">店铺流量统计</a>
							</p>
						</div>
						
						<!--pc端统计-->
						<div class="traffic-analysis traffic-analysis-pc">
							<div class="line-section"> 
								<div class="tit">
									<div class="spacer"></div>
									<a class="btn-pc active" href="javascript:void(0)" pid="WEB">PC端店铺</a>
									<a class="btn-mombile" href="javascript:void(0)" pid="wx">手机端店铺</a>
								</div>
								<div class="shop-type" >
									<a class="btn-day active" href="javascript:void(0)"   pid="1">休闲杂食</a>
									<a class="btn-hour" href="javascript:void(0)"   pid="2">粮油调味</a>
									<a class="btn-hour" href="javascript:void(0)"   pid="3">母婴用品</a>
									<a class="btn-hour" href="javascript:void(0)"   pid="4">文具用品</a>
									<a class="btn-hour" href="javascript:void(0)"   pid="5">蔬菜生鲜</a>
									<a class="btn-hour" href="javascript:void(0)"   pid="9">其它</a>
								</div>
								 <input type="hidden" name="sAccessMode" id = "sAccessMode" value="WEB"/>  <!-- 终端类型 --> 
								 <input type="hidden" name="sScopeTypeID" id = "sScopeTypeID" value="1"/>  <!-- 店铺类型 --> 
								 <input type="hidden" name="selectDateType" id = "selectDateType" value="day"/>  <!-- 时间类型 --> 
								<div class="chart-type">
									<a class="btn-day active" href="javascript:void(0)" id="pc-day">按天</a>
									<a class="btn-hour" href="javascript:void(0)"  id="pc-hour">按小时</a>
								</div>
							    <div id="line-chart-pc" class="line-chart" style="width: 100%;height:360px;"></div>
							    <div class="table-data">
							    	<table class="footable table">
							    		<thead>
							    			<tr>
							    				<th></th>
							    				<th>浏览量(PV)</th>
							    				<th>访客数(UV)</th>
							    				<th>IP数</th>
							    				<th data-hide="phone" class="tcl">跳出率
							    				   <a>
													  <i class="fa fa-question-circle-o" aria-hidden="true"></i>								
													</a>
													<div>跳出率 是只浏览了一个页面便离开网站的访问次数占总的访问次数的百分比。</div>
							    				</th>
							    				<th data-hide="phone" class="pjfwsd">平均访问深度
								    				<a>
													  <i class="fa fa-question-circle-o" aria-hidden="true"></i>								
													</a>
													<div>平均访问深度是用户在店铺内浏览量与访客数的比值。表示客户每次访问的页面数量的均值。</div>
												</th>
							    				<th data-hide="tablet,phone" class="cvr">客户转化率
							    				 <a>
												  <i class="fa fa-question-circle-o" aria-hidden="true"></i>								
												</a>
													<div>客户转化率=订单数/访客量*100%</div>
							    				</th>
							    			</tr>
							    		</thead>
							    		<tbody id="traffic-id">
							    			 
							    		</tbody>
							    	</table>
							    </div>
							</div>
							
							<div class="recent">
								<div class="col-md-12 col-xs-12 graphical_main">
									<div class="col-lg-12 col-xs-12 graphical_1">
										<div class="col-md-12 col-xs-12 text-center">
											<!-- <p class="graphical_pm">最近7天被访问的宝贝TOP10</p> -->
										</div>
										<div class="col-md-12 col-xs-12 text-center">
											<div class="detail-section">
												<div id="recent-pc1" style="width: 100%;height:600px;"></div>
											</div>
										</div>
										<div class="col-md-12 col-xs-12 recent-item1"></div>
		
									</div> 
								</div>
							</div>
							
							<!--  <div class="recent">
								<div class="col-md-12 col-xs-12 graphical_main"> 
									  <div class="col-lg-12 col-xs-12 graphical_2">
										<div class="col-md-12 col-xs-12 text-center">
											<p class="graphical_pm">最近7天访客地区TOP10</p>
										</div>
										<div class="col-md-12 col-xs-12 text-center">
											<div class="detail-section">
												<div id="recent-pc2" style="width: 100%;height:600px;"></div>
											</div>
										</div>
		
										<div class="col-md-12 col-xs-12 recent-item2"></div>
		
									</div>  
								</div>
							</div> -->
						</div>
						 
					
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->
			 
</e:point>		

