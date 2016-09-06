<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="商品导入第二步"  currentTopMenu="商品管理" currentSubMenu="商品导入第二步" css="css/goods-import.css" js="" localCss="" localJs="goods/goods-import-second.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/goods/goods-import-second.jsp">

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
									<a class="btn-step btn-step1 bg-color border active" href="${webHost}/goods/tGoodsDealer/importFirst">第一步</a>
								</li>
								<li>
									<p class="dashed dashed-step2"></p>
								</li>
								<li>
									<a class="btn-step btn-step2 bg-color border active "  href="${webHost}/goods/tGoodsDealer/importSecond?sAgentContractNO=${sAgentContractNO }">第二步</a>
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
							
	 
							
							<div class="table-step2  ">
								<form action = "importSecond" id = "secondForm" method = "post">
								<div class="filter-wrap">
								     <input type="hidden" id="stepPage"  name="stepPage" value="2"/>
								 	<input type="hidden" id ="sAgentContractNO" name = "sAgentContractNO" value="${sAgentContractNO }"/>
 									<label class="fl">
										<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="商品名称/条码" id="sGoodsDescOrBarcode"  name="sGoodsDescOrBarcode" value="${sGoodsDescOrBarcode }" type="text" />
									</label>
									<label class="filter-select dropdown-wrap fl">
									   <input type="hidden" id="sCategoryNO" name="sCategoryNO"/>
										<a id="category-menu-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
											<span class="item-name">商品分类</span>
											<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										</a>
										<ul  id="category-menu-name"  class="dropdown-menu  lv-first no-scroll" aria-labelledby="category-menu-id">
											 
										</ul>
									</label>
									
									<label class="filter-select dropdown-wrap fl">
										<input type="hidden" id = "sBrand" name = "sBrand" value="${sBrand }"/>
										<a id="brand-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
											<span class="item-name">品牌</span>
											<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										</a>
										<ul id="brand-name"  class="dropdown-menu" aria-labelledby="brand-id">
											 
										</ul>
									</label>
									
									<span id="query">
										<a class="btn-filter" href="#">查询</a>
									</span>
		
								</div>
									</form>
								<div class="table-head">
									<table class="footable table even">
										<thead class="bg-color">
											<tr>
												<th></th>
												<th data-toggle="true">商品名称</th>
												<th data-hide="phone">保质期</th>
												<th data-hide="phone">规格</th>
												<th data-hide="phone">商品价格</th>
												<th data-hide="phone">包装数量</th>
											</tr>
										</thead>
									</table>
								</div>
								<div class="scroll-wrap">
									<table class="footable table even">
										<thead class="bg-color hide">
											<tr>
												<th></th>
												<th data-toggle="true">商品名称</th>
												<th data-hide="phone">保质期</th>
												<th data-hide="phone">规格</th>
												<th data-hide="phone">商品价格</th>
												<th data-hide="phone">包装数量</th>
											</tr>
										</thead>
										<tbody id="secondMsgId">
											         
										</tbody>
									</table>
								</div>
								<div class="footer clearfix">
									<div class="batch">
										<label>
											<input type="checkbox" class="chk all_select_goods_check" id="secondMsg-check-id" name="secondMsg-check-id"/>
												<span class="chk-bg"></span>
												<span class="txt">全选/取消</span>
										</label>
										<label><input class="border border-radius bg-color f-50" type="button" value="从资料库选择商品"  id="showGoodsMsg_id"/></label>
 									</div>
									<a class="next-step border border-radius f-50" href="javascript:void(0)"  step="2">下一步</a>
									 
								</div>
							</div>
							
 
						
						</div>
						
						<!-- 编辑 -->
						<div class="modal fade database" id="database" tabindex="-1" role="dialog" aria-labelledby="databaseLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
							      	<div class="modal-body">
							        	<form>
							        		<input type="hidden" id ="sCategoryNO-select" name ="sCategoryNO-select" /> 
							        		<div class="filter-wrap">
												<label class="search-input">
													<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="商品名称/条码" id="goodsNameOrBarCode" type="text">
												</label>
												<label class="filter-select dropdown-wrap">
													<a id="goods-sort-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
														<span class="item-name">商品分类</span>
														<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
													</a>
													<ul  id="goods-sort-menu" class="dropdown-menu lv-first no-scroll" aria-labelledby="goods-sort-id">
 
													</ul>
												</label>
												<label class="btn-wrap" id="select-Query-id">
													<input class="btn-filter" type="button" value="查询" />
												</label>
											</div>
							        		
							        		<div class="clearfix">
							        			
							        			<div class="pull-left select-box">
							        				<div class="scroll-wrap">
							        					<table class="footable table even">
															<thead class="bg-color">
																<tr>
																	<th></th>
																	<th data-toggle="true">商品名称</th>
																	<th data-hide="">规格</th>
																	<th data-hide="phone">包装数量</th>
																</tr>
															</thead>
															<tbody  id="show-goods-Id">
																    
															</tbody>
														</table>
							        				</div>
							        				<div class="pagination-wrap clearfix">
														<div class="batch">
															<label>
																<input type="checkbox" class="chk" />
																<span class="chk-bg"></span>
																<span class="txt">全选/取消</span>
															</label>
														</div> 
													 
													</div>
							        			</div>
							        		 	<input type = "hidden" name="right_del_goodid" id = "right_del_goodid" /> 
							        			
							        			<div class="btn-box pull-left">
							        				<a class="btn-select" href="javascript:void(0)"><img src="${resourceHost}/images/select-ok.png" /></a>
							        				<a class="btn-remove" href="javascript:void(0)"><img src="${resourceHost}/images/select-cancel.png"/></a>
							        			</div>
							        			
							        			<div class="pull-left result-box">
								        			<div class="scroll-wrap">
								        				
								        				<table class="footable table even">
															<thead class="bg-color">
																<tr>
																	<th>已选商品</th>
																	<th data-toggle="true">商品名称</th>
																</tr>
															</thead>
															<tbody id="selected-goods-id">
																<!--已选商品-->
																
															</tbody>
															<tfoot>
																<tr>
																	<td colspan="10" class="clearfix">
																		<div class="batch">
																			<label>
																				<input type="checkbox" class="chk" />
																				<span class="chk-bg"></span>
																				<span class="txt">全选/取消</span>
																			</label>
																		</div>
																	</td>
																</tr>
															</tfoot>
														</table>
								        					
								        			</div>
							        			</div>
							        			
							        		</div>
							        		
							        		<div class="btn-wrap">
												<label class="btn-submit"><input type="button" value="确定"></label>
												<label class="btn-cancel" data-dismiss="modal"><input type="button" value="返回"></label>
											</div>
							        	</form>
							      	</div>
						    	</div>
						  	</div>
						</div>
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->
</e:point>		

