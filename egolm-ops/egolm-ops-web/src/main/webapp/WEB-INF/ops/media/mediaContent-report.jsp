<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>  
<e:resource title="广告统计"  currentTopMenu="广告管理" currentSubMenu="广告统计" css="css/mediaContent-report.css" js="js/common.js" localCss="" localJs="media/mediaContent-report.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/media/mediaContent-report.jsp">
 				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/media/mediaContext/list">广告管理</a> &gt; 
								<a class="active" href="${webHost}/media/mediaContext/adVertReport">广告统计</a>
							</p>
						</div>
						
						<div class="advertisement table-box"> <!-- 广告管理 -->
							<form action="" id="limitPageForm"  method= "post">
 						
							<div class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i>
									<input class="filter border-radius bg-color" placeholder="广告名称" id="sAdTitle" type="text"  name="sAdTitle" value="${sAdTitle }"/>
								</label>
								<label class="filter-select dropdown-wrap adv-margin">
 								<input type="hidden" name="sApSaleTypeID" id="sApSaleTypeID"> 
									<a id="adv-position-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>广告位类型</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="adv-position-menu" class="dropdown-menu" aria-labelledby="adv-position-id">
										<!-- <li value="wx">微信广告位</li>
										<li value="web">WEB广告位</li>
										<li value="app">APP广告位</li> -->
									</ul>
								</label>
								
								<label class="filter-select dropdown-wrap">
									  <input type="hidden" name="sAdZoneCodeID" id = "sAdZoneCodeID" >

									<a id="sAdZoneCode-area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>区域</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="sAdZoneCode-area-menu" class="dropdown-menu" aria-labelledby="sAdZoneCode-area-btn">
										 
									</ul>
								</label>
								
								<label class="filter-select dropdown-wrap">
									  <input type="hidden" name="sScopeTypeID" id = "sScopeTypeID" >

									<a id="sScopeType-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>店铺类型</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="sScopeType-memu" class="dropdown-menu" aria-labelledby="sScopeType-id">
										 
									</ul>
								</label>
								
								<span class="pull-right">
										<span id="query"><a class="add-message" href="#">查询</a> </span>
								</span>
							</div>
							 </form>
							<table class="footable table" data-page-size="5">
								<thead class="bg-color">
									<tr> 
										<th>编号</th>
										<th data-hide="phone">广告名称</th> 
										<th data-hide="phone">广告价格(元/天)</th> 
										<th data-hide="phone">开始时间/结束时间</th>
										<th data-hide="phone">区域</th>
										<th data-hide="phone">访问量(PV)</th>
										<th data-hide="phone">访客量(UV)</th> 
										<th data-hide="phone">点击数</th>
										<th data-hide="phone">独立点击IP数</th>
										<th data-hide="phone" class="ctr">点击率(CTR)
											<a>
												<i class="fa fa-question-circle-o" aria-hidden="true"></i>								
											</a>
											<div>点击率（CTR）=点击量/访问量*100%</div>
										</th>
										<th data-hide="phone" class="shopCvr">购物车转化率(CVR)
											<a>
												<i class="fa fa-question-circle-o" aria-hidden="true"></i>								
											</a>
											<div>购物车转化率（CVR）=购物车添加次数/点击量 *100%</div>										
										</th>
										<th data-hide="phone">订单数量</th>
										<th data-hide="phone">订单金额(元)</th>
										<th data-hide="phone" class="orderCvr">订单转化率(CVR)
											<a>
												<i class="fa fa-question-circle-o" aria-hidden="true"></i>								
											</a>
											<div>订单转化率（CVR）=订单提交成功次数/点击量 *100%</div>
										</th>
										<th data-hide="phone" class="cpa">订单转化成本(CPA)
											<a>
												<i class="fa fa-question-circle-o" aria-hidden="true"></i>								
											</a>
											<div>转化成本（CPA）=广告消费额/订单提交成功次数</div>
										</th>
										<th data-hide="phone" class="cpc">平均点击价格(CPC)
											<a>
												<i class="fa fa-question-circle-o" aria-hidden="true"></i>								
											</a>
											<div>平均点击价格（CPC）=广告价格/点击量</div>
										</th>
										<th data-hide="phone" class="roi">投资回报率(ROI)
											<a>
												<i class="fa fa-question-circle-o" aria-hidden="true"></i>								
											</a>
											<div>投入产出比/投资回报率（ROI）=订单额/广告价格*100%</div>
										</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="adReportId">
								  
								</tbody>
								<tfoot>
									<tr>
										<td colspan="10" class="clearfix">
											<div class="batch">
											     
												 <label ><input class="border border-radius bg-color f-50" type="button" value="批量导出" pid="export"/></label> 
											</div> 
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
						 
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>			
	
