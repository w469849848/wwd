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
<e:resource title="模板设置" currentTopMenu="" currentSubMenu="" css=""  localCss="tpl/tpl-setting.css,tpl/index.css,tpl/tpl-manage.css" showFooter="false" showHeader="false" showSubMenu="false" showMenu="false" showTopMenu="false" localJs="jquery.form.js,tpl/tpl-setting.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-setting-pop-brand.jsp">

<style>
/*推荐商品弹窗*/
.modal-body{ padding-left: 27px; padding-right: 27px; padding-top: 10px; overflow-y: hidden;}
.modal-body .table-box{ border: none; max-height: 510px; }
.modal-body .table-box .result-wrap>p{ margin: 0 0 10px 0; }
.modal-body .table-box .result-wrap ul{ list-style: none; margin: 0; }
.modal-body .table-box .result-wrap ul li{ position: relative; float: left; padding: 0 30px 0 12px; border-radius: 2px !important; -moz-border-radius: 2px !important; -webkit-border-radius: 2px !important; margin-right: 10px; }
.modal-body .table-box .result-wrap ul li p{ margin: 0; }
.modal-body .table-box .result-wrap ul li:last-child{ margin-right: 0; }
.modal-body .table-box .result-wrap ul li>a{ position: absolute; top: 9px; right: 5px; display: block; width: 16px; height: 16px; }
.modal-body .table-box .result-wrap ul li>a img{ display: block; }
.modal-body .table-box table td a.active{ color: #ff6400; }
.modal-body .table-box table td .g-icon{ position: relative; width: 80px; height: 64px; background-color: #fff; border: 1px solid #e5e5e5; }
.modal-body .table-box table td .g-icon img{ position: absolute; margin: auto; top: 0; left: 0; right: 0; bottom: 0; }

.modal-body .table-box .result-wrap .scroll-wrap{ height: 85px; overflow-x: hidden; overflow-y: auto; }
.modal-body .table-box .result-wrap ul li{ padding: 0; margin: 10px; }
.modal-body .table-box .result-wrap ul li .g-icon{ position: relative; width: 60px; height: 46px; border: 1px solid #e5e5e5; }
.modal-body .table-box .result-wrap ul li .g-icon>img{ position: absolute; margin: auto; top: 0; bottom: 0; right: 0; left: 0; }
.modal-body .table-box .result-wrap ul li .g-icon>a{ position: absolute; top: -9px; right: -8px; width: 16px; height: 16px; z-index: 9999; display: block; }
.modal-body .table-box .result-wrap ul li .g-icon>a img{ display: block; }
.modal-body .table-box .result-wrap ul li .g-icon>input{ position: absolute; z-index: 999; top: 0; width: 100%; height: 100%; filter: alpha(opacity=0); -moz-opacity: 0; -khtml-opacity: 0; opacity: 0; }

.modal-body .table-box .filter-wrap{ padding-left: 0; padding-right: 0; padding-top: 15px; }
.modal-body .table-box .filter-wrap label{ width: 51%; }
.modal-body .table-box .filter-wrap label.filter-select{ width: 200px !important; }
.modal-body .table-box .filter-wrap label.filter-select a span:first-child{ width: auto !important; }
</style>
<script type="text/javascript">
	var resourceHost = "${resourceHost}";
	var brandCount = "${brandCount}";
	var selectedBrandCount=0;
	jQuery(function($){
		
		var brandJson = parent.getBrandJson();
		if(brandJson!=""&&brandJson!= undefined){
			var brandResult = eval(brandJson); 
			if(brandResult.length>0){
				$("input[name='brandImg']").each(function(index,element){
					if($(element).parent().next().text() == ""){
						if(null!=brandResult[index]){
							$(element).parent().next().attr("id",brandResult[index].brandId);
							$(element).parent().next().text(brandResult[index].brandName);
							$(element).next().attr("src",brandResult[index].imgPath);
							selectedBrandCount++;
						}
					}
				});
			}
		}
		
		loadBrandsMsg(1);
	});
</script>
<div style="overflow-y: hidden;background-color: #ffffff">
  	 	<div class="modal-body">
        	<form  id="limitPageForm"  action="" enctype="multipart/form-data" method="post">
        		<input type="hidden" name="page.index" value="${page.index}" />
				<input type="hidden" name="page.limit" value="10" />
				<input type="hidden" name="orgNO" id="orgNO" value="${orgNO}" />
        		<div class="table-box">
        			<div class="result-wrap">
						<div class="scroll-wrap">
							<ul class="clearfix">
							<c:forEach begin='1' end="${brandCount}">
								<li>
									<div class="g-icon pr">
										<input type="text" id="brandImg"  name="brandImg"  onchange="previewBrand(this)"/>
										<img src="${resourceHost}/images/tpl/icon-add.png"  height="100%" width="100%" />
										<a href="javascript:void(0)" onclick="brandCancleImg(this)"><img src="${resourceHost}/images/btn-delete.png"/></a>
									</div>
									<p style="text-align: center;"></p>
								</li>
							</c:forEach>
							</ul>
						</div>
					</div>
					<div class="filter-wrap">
						<label class="">
							<i class="icon-search f-95"></i><input class="filter border-radius bg-color" placeholder="品牌名称" id="brandsName" name="brandsName" type="text"  />
						</label>
						<span class="pull-right">
								<a class="add-message"  style="margin-left: 5px;" href="javascript:void(0)" onclick="loadBrandsMsg(1)">查询</a>
								<a class="add-message" href="javascript:void(0)" onclick="cleanBrands()">清空<span>已选品牌</span></a>
								<input type="hidden" id="cleanBrandType" name="cleanBrandType" />
						</span>
					</div>
					<div class="table-scroll" style="padding-bottom: 10px;">
						<div class="table-head">
							<table class="footable table even border border-radius" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th data-toggle="true">品牌图标</th>
										<th data-hide="phone">品牌名称</th>
										<th data-hide="phone"></th>
										<th data-hide="phone"></th>
										<th data-hide="phone"></th>
										<th data-hide="phone"></th>
										<th data-hide="phone">操作</th>
										<th></th>
										<th></th>
									</tr>
								</thead>
							</table>
						</div>
						<div class="scroll-wrap">
							<table class="footable table even border border-radius" data-page-size="10">
								<thead class="bg-color hide">
									<tr>
										<th data-toggle="true">品牌图标</th>
										<th data-hide="phone">品牌名称---</th>
										<th data-hide="phone">操作</th>
									</tr>
								</thead>
								<tbody id="brandsBody">
								</tbody>
							</table>
						</div>
					</div>
					<div class="batch pull-right"></div> 
        		</div>
        		<div class="btn-wrap" style="margin: 40px 0 10px;border-top: 0px solid #e5e5e5;">
					<label class="btn-submit"><input type="button" value="确定" onclick="returnBrands();" /></label>
					<label class="btn-cancel"><input data-dismiss="modal" type="button" value="取消" onclick="closeLayer();"/></label>
				</div>
        	</form>
      	</div>
  </div>
</e:point>