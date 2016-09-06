<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="商品导入第三步"  currentTopMenu="商品管理" currentSubMenu="商品导入第三步" css="css/goods-import.css" js="" localCss="" localJs="goods/goods-import-third.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/goods/goods-import-third.jsp">
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
									<p class="dashed dashed-step2 active"></p>
								</li>
								<li>
									<a class="btn-step btn-step2 bg-color border active" href="${webHost}/goods/tGoodsDealer/importSecond?sAgentContractNO=${sAgentContractNO }">第二步</a>
								</li>
								<li>
									<p class="dashed dashed-step3 active"></p>
								</li>
								<li>
									<a class="btn-step btn-step3 bg-color border active" href="#">第三步</a>
								</li>
								<li>
									<p class="dashed"></p>
								</li>
							</ul> 
														
							<div class="table-step3">
							<from action = "" id ="thirdSubmitForm"   method = "post" onsubmit = "return check();" > 
										<input type="hidden" id="stepPage"  value="3"/>
									 	<input type="hidden" id ="sAgentContractNO" name = "sAgentContractNO" value="${sAgentContractNO }"/>
 									 	<input type="hidden" id ="sGoodIds" name = "sGoodIds" value="${sGoodIds }"/> 
  							 
								  <div class="table-head">
									<table class="footable table even">
										<thead class="bg-color">
											<tr>
												<th></th>
												<th data-toggle="true">商品名称</th>
												<th data-hide="">订货倍数</th>
												<th data-hide="phone">最低起订量</th>
												<th data-hide="phone">建议零售价</th>
												<th data-hide="phone">建议零售单位</th>
												<th data-hide="phone">推荐描述</th>
												<th data-hide="phone,tablet">是否拆零（物流）</th>
												<th data-hide="phone,tablet">是否季节性商品</th>
												<th data-hide="phone,,tablet">是否可退换货</th>
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
												<th data-hide="">订货倍数</th>
												<th data-hide="phone">最低起订量</th>
												<th data-hide="phone">建议零售价</th>
												<th data-hide="phone">建议零售单位</th>
												<th data-hide="phone">推荐描述</th>
												<th data-hide="phone,tablet">是否拆零（物流）</th>
												<th data-hide="phone,tablet">是否季节性商品</th>
												<th data-hide="phone,,tablet">是否可退换货</th>
											</tr>
										</thead>
										<tbody id="thirdMsgId">
											 
										</tbody>
									</table>
								</div>
								<div class="footer">
									<div class="batch">
										<label>
											<input type="checkbox" class="chk" />
											<span class="chk-bg"></span>
											<span class="txt">全选/取消</span>
										</label>
									</div>
									<a class="btn-apply border border-radius f-50" href="javascript:void(0)"  id="submit" >提交申请</a>
									 
								</div>
							</div>
							</from>						
						</div>
 
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->
</e:point>		

