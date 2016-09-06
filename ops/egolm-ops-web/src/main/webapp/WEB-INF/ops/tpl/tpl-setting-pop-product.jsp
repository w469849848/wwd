<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<c:set scope="application" var="egolmHost"     value="${e:egolmHost('')}" />
<c:set scope="application" var="mediaHost"     value="${e:mediaHost('')}" />
<c:set scope="application" var="resourceHost"  value="${e:resourceHost('')}${serverName}/resources/assets" />
<c:set scope="application" var="localHost"     value="${e:localHost()}" />
<c:set scope="application" var="serverName"    value="${e:serverName()}" />
<c:set scope="application" var="webHost"       value="${egolmHost}${serverName}" />
<e:resource title="模板设置" currentTopMenu="" currentSubMenu="" css="" js="" localCss="tpl/tpl-setting.css,tpl/index.css,tpl/tpl-manage.css" showFooter="false" showHeader="false" showSubMenu="false" showMenu="false" showTopMenu="false" localJs="jquery.form.js,tpl/tpl-setting.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-setting-pop-product.jsp">

<style>
/*推荐商品弹窗*/
.modal-body{ padding-left: 27px; padding-right: 27px; padding-top: 0; overflow: hidden;}
.modal-body .table-box{ border: none; max-height: 550px; }
.modal-body .table-box .result-wrap>p{ margin: 0 0 10px 0; }
.modal-body .table-box .result-wrap ul{ list-style: none; margin: 0; }
.modal-body .table-box .result-wrap ul li{ position: relative; float: left; padding: 0 30px 0 12px; border-radius: 2px !important; -moz-border-radius: 2px !important; -webkit-border-radius: 2px !important; margin-right: 10px; }
.modal-body .table-box .result-wrap ul li p{ margin: 0; line-height: 2.5; width: 100px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis; }
.modal-body .table-box .result-wrap ul li:last-child{ margin-right: 0; }
.modal-body .table-box .result-wrap ul li>a{ position: absolute; top: 9px; right: 5px; display: block; width: 16px; height: 16px; }
.modal-body .table-box .result-wrap ul li>a img{ display: block; }
.modal-body .table-box table td a.active{ color: #ff6400; }
.modal-body .table-box table td .g-icon{ position: relative; width: 80px; height: 64px; background-color: #fff; border: 1px solid #e5e5e5; }
.modal-body .table-box table td .g-icon img{ position: absolute; margin: auto; top: 0; left: 0; right: 0; bottom: 0; }

.modal-body .table-box .result-wrap .scroll-wrap{ height: 132px; max-height: 132px; overflow-x: hidden; overflow-y: auto; margin-bottom: 10px; }
.modal-body .table-box .result-wrap ul li{ padding: 0; margin: 10px; }
.modal-body .table-box .result-wrap ul li .g-icon{ position: relative; width: 100px; height: 100px; border: 1px solid #e5e5e5; }
.modal-body .table-box .result-wrap ul li .g-icon>img{ position: absolute; margin: auto; top: 0; bottom: 0; right: 0; left: 0; }
.modal-body .table-box .result-wrap ul li .g-icon>a{ position: absolute; top: -9px; right: -8px; width: 16px; height: 16px; z-index: 9999; display: block; }
.modal-body .table-box .result-wrap ul li .g-icon>a img{ display: block; }
.modal-body .table-box .result-wrap ul li .g-icon>input{ position: absolute; z-index: 999; top: 0; width: 100%; height: 100%; filter: alpha(opacity=0); -moz-opacity: 0; -khtml-opacity: 0; opacity: 0; }

.modal-body .table-box .filter-wrap{ padding-left: 0; padding-right: 0; padding-top: 0; }
.modal-body .table-box .filter-wrap label{ width: 51%; }
.modal-body .table-box .filter-wrap label.filter-select{ width: 200px !important; }
.modal-body .table-box .filter-wrap label.filter-select a span:first-child{ width: auto !important; }
</style>
<script type="text/javascript">
	var resourceHost = "${resourceHost}";
	var goodsCount = "${goodsCount}";
	var _productCount=0;
	jQuery(function($){
		var goodsJson = parent.getGoodsJson();
		if(goodsJson!=""&&goodsJson!= undefined){
			var goodsResult = eval(goodsJson); 
			//回显历史商品数据
			$("input[name='goodImg']").each(function(index,element){
				if($(element).parent().next().text() == ""){
					$(element).parent().next().attr("id",goodsResult[index].goodsId);
					$(element).parent().next().text(goodsResult[index].goodsName);
					$(element).next().attr("src",goodsResult[index].imgPath+"@84h_88w");
					$(element).parent().children().eq(2).attr("value",goodsResult[index].normalSalesPrice);
					_productCount++;
				}
			});
		}
		loadGoodsMsg(1);
	});
</script>
<div style="background-color: #ffffff">
  	<div class="modal-body">
        	<form id="limitPageForm" action="" enctype="multipart/form-data" method="post">
        		<input type="hidden" name="page.index" value="${page.index}" />
				<input type="hidden" name="page.limit" value="10" />
				<input type="hidden" name="orgNO" id="orgNO" value="${orgNO}" />
				<input type="hidden" name="linkNo" id="linkNo" value="${linkNo}" />
        		<div class="table-box">
        			
        			<div class="result-wrap">
						<div class="scroll-wrap">
							<ul class="clearfix">
							
							<c:forEach begin='1' end="${goodsCount}">
								<li>
									<div class="g-icon pr">
										<input type="text" id="goodImg"  name="goodImg"   onchange="previewGoods(this)"/>
										<img src="${resourceHost}/images/tpl/icon-add.png"  />
										<input type="text"   name="normalSalesPrice" value=""/>
										<a href="javascript:void(0)" onclick="goodCancleImg(this)"><img src="${resourceHost}/images/btn-delete.png"/></a>
									</div>
									<p></p>
								</li>
							</c:forEach>
							</ul>
						</div>
					 	<div>*拖动专区更换顺序</div>
					</div>
					<div class="filter-wrap">
						<label class="">
							<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="商品名称" id="goodName" name="goodName" type="text" />
						</label>
						<label class="filter-select dropdown-wrap">
							<a id="categoryType_btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
								<span id="categorySpan" class="item-name">商品分类</span>
								<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
							</a>
							<input type="hidden" id="categoryID" name="categoryID"/>
							<input type="hidden" id="categoryName" name="categoryName"/>
							<ul id="category-menu" class="dropdown-menu" aria-labelledby="category_type">
								<c:forEach items="${categoryDatas.scopeTypeList[0].categoryList}" var="o">
									<c:if test="${o.parent =='00' }">
	          							<li  id="${o.categoryID }" class="item-one">${o.categoryName }</li>
									</c:if>
								</c:forEach>
							</ul>
						</label>
						<span class="pull-right">
								<a class="add-message" style="margin-left: 5px;" href="javascript:void(0)" onclick="loadGoodsMsg(1)">查询</a>
								<a class="add-message" href="javascript:void(0)" onclick="cleanGoods()">清空<span>已选商品</span></a>
						</span>
					</div>
					
					<div class="table-scroll">
						<div class="table-head">
							<table class="footable table even border border-radius" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th style="width:15%">商品名称</th>
										<th style="width:15%">商品规格</th>
										<th style="width:30%">描述</th>
										<th>价格</th>
										<th></th>
									</tr>
								</thead>
							</table>
						</div>
						
						<div class="scroll-wrap">
							<table class="footable table even border border-radius" data-page-size="10">
								<thead class="bg-color hide">
									<tr>
										<th>商品名称</th>
										<th>商品规格</th>
										<th>描述</th>
										<th>价格</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="goodsBody">
									 <%-- <c:forEach items="${datas}" var="goodsList">
									 	<tr id="goodsTr">
									 	<!-- ${goodsList.goodsName}  ${goodsList.Unit} -->
											<td style="width:15%" id="${goodsList.goodsId}">${goodsList.goodsName}</td>
											<td style="width:15%">${goodsList.Spec}</td>
											<td style="width:30%">超多美味，全家共享</td>
											<td>¥${goodsList.agentPrice} </td>
											<td style="display:none">${imgUrl}${goodsList.imgPath}</td>
											<td>
												<a class="detail" onclick="chooseGood(this)" >未选</a>
											</td>
										</tr>
									 </c:forEach> --%>
								</tbody>
							</table>
						</div>
					</div>
					<!-- 分页 -->
					<div class="batch pull-right"  style="margin-top: 15px;"></div> 
        		</div>
        		<div class="btn-wrap" style="margin: 35px 5px 0px;border-top: 0px solid #e5e5e5;">
					<label class="btn-submit"><input type="button" value="确定" onclick="returnGoods();"/></label>
					<label class="btn-cancel"><input type="button" value="取消" onclick="closeLayer()"/></label>
				</div>
        	</form>
      	</div>
      	</div>
</e:point>