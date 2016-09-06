<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<c:set scope="application" var="egolmHost"     value="${e:egolmHost('')}" />
<c:set scope="application" var="mediaHost"     value="${e:mediaHost('')}" />
<c:set scope="application" var="resourceHost"  value="${e:resourceHost('')}${serverName}/resources/assets" />
<c:set scope="application" var="localHost"     value="${e:localHost()}" />
<c:set scope="application" var="serverName"    value="${e:serverName()}" />
<c:set scope="application" var="webHost"       value="${egolmHost}${serverName}" />
<e:resource title="首页" currentTopMenu="" currentSubMenu="" css="css/index.css" js="" localCss="" localJs="index/index.js,index/echarts.min.js,index/world.js,index/china.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/index.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="${webHost}/index" class="active">首页</a> 
				</p>
			</div>
			<div class="container demand_btn">
				<div class="row-fluid">
				<c:forEach var="title" varStatus="status" items="${titles}">
					<c:if test="${status.index % 5 == 0}">
						<div class="col-md-12 col-xs-12 mb_demand1">
					</c:if>
					<e:authorize path="${paths[status.index]}">
						<div class="col-md-2 text-center mb_demands">
							<a href="${webHost}${paths[status.index]}${params[status.index]}">
								<button type="button" class="btn btn-primary wh_demand">
									${titles[status.index]}<span class="quantity" id="${buttons[status.index]}">0</span>
								</button>
							</a>
						</div>
					</e:authorize>
					<c:if test="${status.index == titles.size()-1 || status.index % 5 == 4}">
						</div>
					</c:if>
				</c:forEach>
					<!--
					<div class="col-md-12 col-xs-12 mb_demand1">
						<e:authorize path="/order/tSalesOrderSub/list">
						<div class="col-md-2 text-center mb_demands">
							<a href="${webHost}/order/tSalesOrderSub/list?sSalesOrderTypeID=0&nOrderStatus=2"><button type="button"
									class="btn btn-primary wh_demand">
									待处理订单<span class="quantity" id="saleOrderWaitCount">0</span>
								</button></a>
						</div>
						</e:authorize>
						<e:authorize path="/order/tSalesOrderSub/list">
						<div class="col-md-2 text-center mb_demands">
							<a href="${webHost}/order/tSalesOrderSub/list?sSalesOrderTypeID=2"><button type="button"
									class="btn btn-primary wh_demand">
									待处理退单<span class="quantity" id="refundOrderWaitCount">0</span>
								</button></a>
						</div>
						</e:authorize>
						<e:authorize path="/dealer/acGoods/list">
						<div class="col-md-2 text-center mb_demands">
							<a href="${webHost}/dealer/acGoods/list"><button type="button"
									class="btn btn-primary wh_demand">
									待审核商品<span class="quantity" id="goodsDtlWaitCount">0</span>
								</button></a>
						</div>
						</e:authorize>
						<e:authorize path="/tmpPromo/list">
						<div class="col-md-2 text-center mb_demands">
							<a href="${webHost}/tmpPromo/list"><button type="button"
									class="btn btn-primary wh_demand">
									待审核活动<span class="quantity" id="tmpPromoWaitCount">0</span>
								</button></a>
						</div>
						</e:authorize>
						<e:authorize path="/api/notice/query">
						<div class="col-md-2 text-center mb_demands">
							<a href="${webHost}/api/notice/query"><button type="button"
									class="btn btn-primary wh_demand">
									待审核公告<span class="quantity" id="noticeWaitCount">0</span>
								</button></a>
						</div>
						</e:authorize>
						<div class="col-md-2"></div>
					</div>
					<div class="col-md-12 mb_demand2">
						<div class="col-md-2 text-center mb_demands">
							<a href="${webHost}/media/mediaContext/waitAuditlist"><button type="button"
									class="btn btn-primary wh_demand">
									待审核广告<span class="quantity" id="adWaitCount">0</span>
								</button></a>
						</div>
						<div class="col-md-2 text-center mb_demands">
							<a href="#"><button type="button"
									class="btn btn-primary wh_demand">
									待审核消息<span class="quantity">10</span>
								</button></a>
						</div>
						<div class="col-md-2 text-center mb_demands">
							<a href="${webHost}/salesman/toSalesManList"><button type="button"
									class="btn btn-primary wh_demand">
									待审核业务员<span class="quantity">80</span>
								</button></a>
						</div>
						<div class="col-md-2 text-center mb_demands">
							<a href="${webHost}/driveMan/driveManList"><button type="button"
									class="btn btn-primary wh_demand">
									待审核司机<span class="quantity" id="driverWaitCount">0</span>
								</button></a>
						</div>
						<div class="col-md-2 text-center mb_demands">
							<a href="${webHost}/dealer/agentList"><button type="button"
									class="btn btn-primary wh_demand">
									待审核经销商<span class="quantity" id="agentWaitCount">0</span>
								</button></a>
						</div>
						<div class="col-md-2"></div>
					</div>
					-->
				</div>
			</div>

			<div class="container sChart">
				<div class="row">
					<div class="col-md-12 data_titer">
						<h4 class="wh_data_titer">销售数据统计 倒计时:<span id="num">100</span>秒</h4>
					</div>
					<div class="detail-section">
						<div id="canvas" style="width: 100%;height:860px;"></div>
					</div>
				</div>
			</div>

		</div>
	</div>
</e:point>
