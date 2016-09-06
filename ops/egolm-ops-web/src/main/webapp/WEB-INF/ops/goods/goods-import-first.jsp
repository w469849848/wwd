<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="商品导入"  currentTopMenu="商品管理" currentSubMenu="商品导入" css="css/goods-import.css" js="js/common.js" localCss="" localJs="goods/goods-import-first.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/goods/goods-import-first.jsp">
 <div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/goods/tGoodsDealer/importFirst">商品管理</a> &gt; 
								<a class="active" href="${webHost}/goods/tGoodsDealer/importFirst">商品导入</a>
							</p>
						</div>
						
						<div class="goods-import table-box">
							
							<ul class="import-nav clearfix">
								<li>
									<p class="dashed dashed-step1 active"></p>
								</li>
								<li>
									<a class="btn-step btn-step1 bg-color border active" href="/egolm-ops-web/goods/tGoodsDealer/importFirst">第一步</a>
								</li>
								<li>
									<p class="dashed dashed-step2"></p>
								</li>
								<li>
									<a class="btn-step btn-step2 bg-color border" href="#">第二步</a>
								</li>
								<li>
									<p class="dashed dashed-step3"></p>
								</li>
								<li>
									<a class="btn-step btn-step3 bg-color border" href="#">第三步</a>
								</li>
								<li>
									<p class="dashed"></p>
								</li>
							</ul>
							<form action="list" id="limitPageForm"  method= "post">
							    <input type="hidden" name="page.index" value="${page.index}" /> 
							    <input type="hidden" name="page.limit" value="10" />  
							 </form>
							 
							 
							<div class="table-step1">
							   <input type="hidden" id="stepPage"  name="stepPage" value="1"/>
								<div class="scroll-wrap">
									<table class="footable table even">
										<thead class="bg-color hide">
											<tr>
												<th></th>
												<th data-toggle="true"></th>
												<th data-hide="phone"></th>
												<th data-hide="phone"></th>
												<th></th>
											</tr>
										</thead>
										<tbody>
										  <c:forEach items="${agentList }" var="agent">
												<tr>
													<td>
														<label class="checked-wrap">
															<input type="radio"  class="chk-radio"  id="sAgentContractNO_first" name="sAgentContractNO_first" value="${agent.sAgentContractNO}"/>
															<span class="chk-bg"></span>
														</label>
													</td>
													<td>
														<div class="td-box">${agent.dCreateDate}
															<p>合同编码：<span>${agent.sAgentContractNO}</span></p>
															<p>合同时间：<span><fmt:formatDate value="${agent.dCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span></p>
															<p>合同状态：<span>${agent.nContractTag}</span></p>
														</div>
													</td>
													<td>
														<div class="td-box">
															<p>经销商ID：<span>${agent.nAgentID}</span></p>
															<p>合同类型：<span>${agent.sAgentContractType}</span></p>
															<p>税别：<span>${agent.sTaxType}</span></p>
														</div>
													</td>
													<td>
														<div class="td-box">
															<p>组织机构编码：<span>${agent.sOrgNO}</span></p>
															<p>生效日期：<span><fmt:formatDate value="${agent.dActiveDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span></p>
															<p>税率：<span>${agent.nTaxRate}</span></p>
														</div>
													</td>
													<td>
														<div class="td-box">
															<p>合同类型ID：<span>${agent.sAgentContractTypeID}</span></p>
															<p>失效日期：<span><fmt:formatDate value="${agent.dExpireDate}" pattern="yyyy-MM-dd HH:mm:ss"/></span></p>
															<p>税比：<span>${agent.nTaxPct}</span></p>
														</div>
													</td>
												</tr>
											</c:forEach> 
										</tbody>
									</table>
								</div>
								<div class="footer clearfix">
									<a class="next-step border border-radius f-50" href="javascript:void(0)" step="1">下一步</a>
									<div class="navigation_bar pull-right">
										<ul class="clearfix">
											       <c:set var="pagerForm" value="limitPageForm" scope="request"/>
													<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
										</ul>
									</div>
								</div>							
							</div>
							
 
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->
				
</e:point>		

