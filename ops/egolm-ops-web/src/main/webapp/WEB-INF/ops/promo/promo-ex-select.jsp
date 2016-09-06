<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>



<style>
	.Select {width:100%;}
	.Select tr th {border:1px solid #A9A9A9;text-align:center;background:#eee;line-height:16px;height:16px;}
	.Select tr td {border:1px solid #eee;line-height:16px;height:16px;}
	.selectfoot {list-style:none;width:100%;margin-top:15px;}
	.selectfoot li {float:left;margin-right:10px;}
</style>
<div style="overflow-y:auto;overflow-x:hidden;padding:5px;margin:-8px;width:50%;float:left;height:99%;border:1px solid #eee;">
	<div style="width:100%;height:40px;">
		<input type="text" id="searchText" style="width:300px;" placeholder="<c:if test="${promo.sSettingModeID eq 'G'}">请输入商品名称</c:if><c:if test="${promo.sSettingModeID eq 'B'}">请输入品牌名称</c:if><c:if test="${promo.sSettingModeID eq 'C'}">请输入分类名称</c:if>"/>
		<input type="hidden" id="search_nTplPageID" value="${tab.nTplPageID}"/>
		<button onclick="search();">查询</button>
	</div>
	<table class="Select" id="SelectList" style="width:100%;">
		<thead>
			<tr style='height:28px;'>
				<th>商品编号</th>
				<th>商品名称</th>
				<th>商品规格</th>
				<th>商品单位</th>
				<th>商品品牌</th>
				<th>商品分类</th>
				<th>经销商</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			
		</tbody>
	</table>
	<div id="selectfooter"></div>
</div>
<div style="overflow-y:auto;overflow-x:hidden;padding:5px;margin:-8px;width:50%;float:right;height:99%;border:1px solid #eee;">
	<div style="width:100%;height:40px;">
	</div>
	<table class="Select" id="Selected" style="width:100%;">
		<thead>
			<tr style='height:28px;'>
				<th>商品编号</th>
				<th>商品名称</th>
				<th>商品规格</th>
				<th>商品单位</th>
				<th>商品品牌</th>
				<th>商品分类</th>
				<th>经销商</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			
		</tbody>
	</table>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		search();
	});
	function search(pageIndex) {
		var searchText = $("#searchText").val();
		var sPromoPaperNO = "${promo.sPromoPaperNO}";
		$.ajax({
			url : "exSearch",
			type : "post",
			data : {searchText:searchText, "promo.sPromoPaperNO":sPromoPaperNO, "page.index":pageIndex},
			dataType : "json",
			success : function(json) {
				if(json.IsValid) {
					var promo = json.promo;
					$("#SelectList>tbody").find("*").remove();
					$(json.datas).each(function() {
						var html = "";
						html += "<tr class='rows' id='ID" + this.nGoodsID + "'>";
						html += "<td>" + this.nGoodsID + "</td>";
						html += "<td>" + this.sGoodsDesc + "</td>";
						html += "<td>" + this.sSpec + "</td>";
						html += "<td>" + this.sUnit + "</td>";
						html += "<td>" + this.sBrand + "</td>";
						html += "<td>" + this.sCategoryDesc + "</td>";
						html += "<td>" + this.sAgentName + "</td>";
						html += "<td><a href=\"javascript:select('" + this.nGoodsID + "');\">选择</a></td>";
						html += "</tr>";
						$("#SelectList>tbody").append(html);
					});
					var page = json.page;
					var indexs = json.indexs;
					var index = page.index;
					var limit = page.limit;
					var total = page.total;
					var pageTotal = (total%limit == 0) ? parseInt(total/limit) : (parseInt(total/limit)+1);
					var nextPage = (index*limit >= total) ? 1 : (index + 1);
					var prevPage = (index > 1) ? (index - 1) : 1;
					
					var pageHtml = "";
					pageHtml += "<ul class=\"selectfoot\">";
					pageHtml += "<li style=''><a href=\"javascript:search(1);\" class=\"nav_first\"></a></li>";
					pageHtml += "<li><a href=\"javascript:search(" + prevPage + ");\" class=\"nav_float\"></a></li>";
					$(json.indexs).each(function() {
						pageHtml += "<li><a href=\"javascript:search(" + this + ");\">" + this + "</a></li>";
					});
					pageHtml += "<li><a href=\"javascript:search(" + nextPage + ");\" class=\"nav_right\"></a></li>";
					pageHtml += "<li><a href=\"javascript:search(" + pageTotal + ");\" class=\"nav_last\"></a></li>";
					pageHtml += "</ul>";
					$("#selectfooter").html(pageHtml);
				}
			}
		});
	}
	
	function select(id) {
		var sid = "ID" + id;
		if($("#Selected").find("#" + sid).length == 0) {
			$("#SelectList").find("#" + sid).each(function() {
				var html = this.outerHTML;
				html = html.replace("select", "del");
				html = html.replace("选择", "删除");
				$("#Selected>tbody").append(html);
			});
		}
	}
	function del(id) {
		var sid = "ID" + id;
		$("#Selected").find("#" + sid).remove();
	}
</script>