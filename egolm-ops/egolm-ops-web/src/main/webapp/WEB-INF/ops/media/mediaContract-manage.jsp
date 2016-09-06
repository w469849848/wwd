<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="广告合同管理"  currentTopMenu="广告管理" currentSubMenu="广告合同管理" css="css/mediaContract-manage.css" js="js/common.js" localCss="" localJs="media/mediaContract-manage.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/media/mediaContract-manage.jsp">

				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/media/mediaContract/list">广告管理</a> &gt; 
								<a class="active" href="${webHost}/media/mediaContract/list">广告合同管理</a>
							</p>
						</div>
						
						<div class="advertisement table-box"> <!-- 广告管理 -->
						 <form action="list" id="limitPageForm"  method= "post">
							  <input type="hidden" name="page.index" value="${page.index}"  id="page_index"/>  
								<div class="filter-wrap">
									<label class="">
										<i class="icon-search f-95"></i>
										<input class="filter border-radius bg-color" placeholder="合同编号"  id="sContractNO" name="sContractNO" type="text"  value="${sContractNO }"/>
									</label>
									<span class="pull-right">
											<a class="add-message" href="${webHost}/media/mediaContract/addIndex"><i class="add-icon"></i>新增<span>广告合同</span></a>
									</span>
									<span  class="pull-right" id="query"><a class="add-message" href="#">查询</a> </span>
								</div>
							</form>
							<table class="footable table" data-page-size="5">
								<thead class="bg-color">
									<tr> 
										<th data-hide="phone,tablet">合同编号</th>
										<th data-hide="phone,tablet">经销商名称</th>
										<th data-hide="phone,tablet">合同区域</th>
										<th data-toggle="true">交易方式</th>
										<th data-hide="phone,tablet">合同生效日期/终止日期</th>
										<th data-hide="phone">固定扣点率</th>
										<th data-hide="phone">税别</th>
										<th data-hide="phone,tablet">税率</th>
										<th data-hide="phone,tablet">税比</th>
										<th data-hide="phone,tablet">付款帐期</th>
										<th data-hide="phone,tablet">付款天数</th>
										<th data-hide="phone,tablet">付款方式</th>
										<th data-hide="phone,tablet">创建时间</th>
										<th data-hide="phone">操作</th>
										<th></th> 
									</tr>
								</thead>
								<tbody> 
									<c:forEach items="${advContractList}" var="advContract">
									 <tr>
											<!-- <td>
												<label class="checked-wrap">
													<input type="checkbox" class="chk" />
													<span class="chk-bg"></span>
												</label>
											</td> --> 
											<td>
												${advContract.sContractNO }
											</td>
											<td>${advContract.sAgentName }</td>
											<td>${advContract.sOrgNODesc }</td>
											<td>${advContract.sTradeMode }</td>
											<td><span class="orange"><fmt:formatDate value="${advContract.dActiveDate}" type="date"/> </span>/<span><fmt:formatDate value="${advContract.dExpireDate}" type="date"/> </span></td>
											<td>${advContract.nRatio }</td>
											<td>${advContract.sTaxType }</td>
											<td>${advContract.nTaxRate }</td>
											<td>${advContract.nTaxPct }</td>
											<td>${advContract.sPaytTerm }</td>
											<td>${advContract.nPaytDay }</td>
											<td>${advContract.sPaytMode }</td>
											<td>${advContract.dCreateDate }</td>
											<td>
												<a class="edit" href="${webHost}/media/mediaContract/loadMsgById?id=${advContract.nContractID}"><img src="${resourceHost}/images/edit.png" alt="编辑" /></a>
												<a class="delete"  pid="${advContract.nContractID }" href="javascript:void(0)"><img src="${resourceHost}/images/delete.png" alt="删除" /></a>
												<a class="detail" href="${webHost}/media/mediaContract/loadDetailMsgById?id=${advContract.nContractID}">详情</a>											
											</td>
										</tr>    
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="12" class="clearfix">
											<!-- <div class="batch">
												<label>
													<input type="checkbox" class="chk" />
													<span class="chk-bg"></span>
													<span class="txt">全选/取消</span>
												</label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量导出" /></label> 
											</div>-->
											 <c:set var="pagerForm" value="limitPageForm" scope="request"/>
											<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
						
					<!-- 编辑 -->
							<!-- <div class="modal fade edit-box" id="editAd" tabindex="-1" role="dialog" aria-labelledby="editAdLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content">
							      	<div class="modal-body">
							        	<form>
							        		<div class="scroll-wrap">
							        			<p><label><span>编号：</span><input type="text" value="WD001"></label></p>
							        			<p><label><span>广告位名称：</span><input type="text" value="老干妈促销"></label></p>
							        			<p><label><span>广告位区域：</span><input type="text" value="微信首页顶部广告位"></label></p>
							        			<p><label><span>广告位类型：</span><input type="text" value="微信广告位"></label></p>
							        			<p><label><span>类别：</span><input type="text" value="滚动"></label></p>
							        			<p><label><span>尺寸：</span><input type="text" value="长720x宽120（px）"></label></p>
							        			<p><label><span>价格：</span><input type="text" value="1000"></label></p>
							        			<p><label><span>展示类型：</span><input type="text" value="全部展示"></label></p>
							        			<p><label><span>状态：</span><input type="text" value="未启用"></label></p>
							        		</div>
							        		<p class="clearfix">
							        			<label class="pull-left"><input id="submit" type="button" value="保存"></label>
							        			<label class="pull-right"><input type="button" data-dismiss="modal" value="取消"></label>
							        		</p>
							        	</form>
							      	</div>
						    	</div>
						  	</div>
						</div> -->
						
					 
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>			 