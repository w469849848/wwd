<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="商品审核详情"  currentTopMenu="商品管理" currentSubMenu="商品审核详情" css="css/good-audit-detail.css,css/goods-putaway.css" js="" localCss="" localJs="goods/good-audit-detail.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/goods/good-audit-detail.jsp">
     <div class="main-content">

					<div class="page-content"> 
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/dealer/acGoods/list">商品审核</a> &gt; 
								<a class="active" href="${webHost}/dealer/acGoodsDtl/toDtlPage?sPaperNO=${sPaperNO }">商品审核详情</a>
							</p>
						</div>
						
						<div class="putaway table-box"> <!-- 上下架表 -->
							<div class="filter-wrap">
								<div>
									<label class="">
										<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="商品名称/条形码" id="goodsNameOrMainBarCode"  type="text" />
									</label>
									<label class="filter-select dropdown-wrap adv-margin">
									<input type="hidden" name="sCategoryNO" id="sCategoryNO"/>
										<a id="category-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
											<span class="item-name">商品分类</span>
											<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										</a>
										<ul id="category-memu" class="dropdown-menu lv-first no-scroll" aria-labelledby="category-id">
											 
										</ul>
									</label>
									
									<label class="filter-select dropdown-wrap">
									<input type="hidden" name="sBrandID" id = "sBrandID"/>
										<a id="brand-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
											<span>品牌</span>
											<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										</a>
										<ul id="brand-name" class="dropdown-menu" aria-labelledby="brand-id">
											 
										</ul>
									</label>
									 <span class="pull-right">
										<span id="query"><a class="add-message" href="#">查询</a> </span>
								     </span>
								</div>
								
								<ul class="clearfix"> 
									<li>录入单编号：${sPaperNO }</li> 
								</ul>
								
							</div>
							<table class="footable table" data-page-size="10">
							<input type="hidden" value="${sPaperNO }" name = "sPaperNO" id ="sPaperNO"/>
								<thead class="bg-color">
									<tr>
										<th></th>
										<th data-toggle="true">条形码</th>
										<th data-hide="phone">商品名称</th>
										<th data-hide="phone">订货倍数</th>
										<th data-hide="phone,tablet">最低起订量</th>
										<th data-hide="phone,table">建议零售价</th>
										<th data-hide="phone,tablet">建议零售单位</th>
										<th data-hide="phone,tablet">推荐描述</th>
										<th data-hide="phone,tablet">商品状态</th>
										<th data-hide="phone">审核状态</th> 
									</tr>
								</thead>
								<tbody id="acGoodsDtlMsg">
									 
								</tbody>
								<tfoot>
									<tr>
										<td colspan="10" class="clearfix">
											<div class="batch">
												<label>
													<input type="checkbox" class="chk all-chk" />
													<span class="chk-bg"></span>
													<span class="txt">全选/取消</span>
												</label>
												<label><input class="border btn-pass border-radius bg-color f-50" type="button" value="批量通过" /></label>
												<label><input class="border btn-fail border-radius bg-color f-50" type="button" value="批量驳回" /></label>
											</div>
											 
										</td>
									</tr>
								</tfoot>
							</table>
						</div> 
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->
 
</e:point>		

