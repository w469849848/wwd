<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="商品上下架"  currentTopMenu="商品管理" currentSubMenu="商品上下架" css="css/goods-putaway.css" js="" localCss="" localJs="goods/goods-putaway.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/goods/goods-putaway.jsp">
     
 <div class="main-content">

					<div class="page-content"> 
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="#">商品管理</a> &gt; 
								<a class="active" href="${webHost}/dealer/goods/indexPage">商品上下架</a>
							</p>
						</div>
						
						<div class="putaway table-box"> <!-- 上下架表 -->
 							<div class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="商品编码/商品名称/条形码"  id="goodsNameOrMainBarCode"  type="text"  />
								</label>
								
								<label class="filter-select dropdown-wrap adv-margin">
 								<input type="hidden" name="sOrgNO" id="sOrgNO" value="${sOrgNO }"> 
									<a id="zoneCode-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span>区域</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="zoneCode-menu" class="dropdown-menu" aria-labelledby="zoneCode-id">
										 
									</ul>
								</label>
								
								
								<input type="hidden" name="sCategoryNO" id="sCategoryNO"/>
								<label class="filter-select dropdown-wrap adv-margin">
									<a class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span class="item-name">商品分类</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<ul id="category-menu-name" class="dropdown-menu lv-first no-scroll" aria-labelledby="adv-position">
										 
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
							<table class="footable table" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th></th>
										<th data-toggle="true">商品编号</th>
										<th data-toggle="true">条形码</th>
										<th data-hide="phone">商品名称</th>
										<th data-hide="phone">区域</th>
										<th data-hide="phone">订货倍数</th>
										<th data-hide="phone,tablet">最低起订量</th>
										<th data-hide="phone">建议零售价</th>
										<th data-hide="phone,tablet">建议零售单位</th> 
										 <th data-hide="phone,tablet">商品状态</th>
										 <th data-hide="phone,tablet">推荐描述</th>
									</tr>
								</thead>
								<tbody id="agGoodsID">
									 
									   
									     
								</tbody>
								<tfoot>
									<tr>
										<td colspan="10" class="clearfix">
											<div class="batch">
												<label>
													<input type="checkbox" class="chk" id="all_chk" name="all_chk"/>
													<span class="chk-bg"></span>
													<span class="txt">全选/取消</span>
												</label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量上架"  id="up"/></label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量下架" id="down"/></label> 
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

