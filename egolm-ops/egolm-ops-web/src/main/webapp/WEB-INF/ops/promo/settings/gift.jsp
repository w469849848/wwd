<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<div class="promo_gift clearfix">
	<div class="fl clearfix">
		<dl>
			<dt>促销类型：</dt>
			<dd>${promo.sPromoActionType}</dd>
		</dl>
		<dl>
			<dt>促销主题：</dt>
			<dd>${promo.sPromoTheme}</dd>
		</dl>
		<dl>
			<dt>促销名称：</dt>
			<dd>${promo.sPromoName}</dd>
		</dl>
		<dl>
			<dt>终端类型：</dt>
			<dd>${sTerminalType }</dd>
		</dl>
	</div>
	<div class="fr ToAddGiftGoods">
		<button onclick="ToAddGiftGoods();">选择换购的商品</button>
	</div>
</div>
<div id="GiftList">
	<c:forEach items="${gifts}" var="gift">
		<div class="gift" id="GIFT${gift.nGoodsID}">
			<div class="gift-title">
				<p class="gift-title-dtl">换购【${gift.sGoodsDesc}】</p>
				<table class="gift-data">
					<thead>
						<tr>
							<th>满足金额</th>
							<th>换购价格</th>
							<th>换购积分</th>
							<th>换购数量</th>
							<th>换购库存</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" value="${gift.nMeetAmount}"/></td>
							<td><input type="text" value="${gift.nPrice}"/></td>
							<td><input type="text" value="${gift.nPoint}"/></td>
							<td><input type="hidden" value="${gift.nGoodsID}"/><input type="text" value="${gift.nLimitQty}"/></td>
							<td><input type="text" value="${gift.nMaxLimitQty}"/></td>
						</tr>
					</tbody>
				</table>
				<div class="addButton">
					<c:if test="${promo.sSettingModeID ne 'A'}">
						<button onclick="ToAddGoods('${gift.nGoodsID}', '${gift.sGoodsDesc}')">添加参与换购的商品</button>
						<button onclick="$('#GIFT${gift.nGoodsID}').remove();">删除</button>
					</c:if>
				</div>
			</div>
			<table class="goods-data" id="GG${gift.nGoodsID}">
				<thead>
					<tr>
						<c:if test="${promo.sSettingModeID eq 'G'}">
							<th>商品名称</th>
							<th>商品编号</th>
							<th>操作</th>
						</c:if>
						<c:if test="${promo.sSettingModeID eq 'B'}">
							<th>品牌名称</th>
							<th>品牌编号</th>
							<th>操作</th>
						</c:if>
						<c:if test="${promo.sSettingModeID eq 'C'}">
							<th>分类名称</th>
							<th>分类编号</th>
							<th>操作</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${datas}" var="data">
						<c:if test="${data.nRuleID eq gift.nRuleID}">
							<c:if test="${promo.sSettingModeID eq 'G'}">
								<tr id="GG${gift.nGoodsID}_${data.nGoodsID}">
									<td>${data.sGoodsDesc}</td>
									<td>${data.nGoodsID}</td>
									<td><a href="javascript:$('#GG${gift.nGoodsID}_${data.nGoodsID}').remove();">删除</a></td>
								</tr>
							</c:if>
							<c:if test="${promo.sSettingModeID eq 'B'}">
								<tr id="GG${gift.nGoodsID}_${data.sBrandID}">
									<td>${data.sBrandName}</td>
									<td>${data.sBrandID}</td>
									<td><a href="javascript:$('#GG${gift.nGoodsID}_${data.sBrandID}').remove();">删除</a></td>
								</tr>
							</c:if>
							<c:if test="${promo.sSettingModeID eq 'C'}">
								<tr id="GG${gift.nGoodsID}_${data.sCategoryNO}">
									<td>${data.sCategoryDesc}</td>
									<td>${data.sCategoryNO}</td>
									<td><a href="javascript:$('#GG${gift.nGoodsID}_${data.sCategoryNO}').remove();">删除</a></td>
								</tr>
							</c:if>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</c:forEach>
</div>
<div class="savePromoDtl">
	<button onclick="savePromoDtl();">保存</button><button onclick="backPromoMain();">返回</button>
</div>
<script type="text/javascript">
function ToAddGiftGoods() {
	var sPromoActionTypeID = "${promo.sPromoActionTypeID}";
	var sSettingModeID = "${promo.sSettingModeID}";
	$.jwindow({
		url : "select?promo.sPromoPaperNO=${promo.sPromoPaperNO}&isGift=true",
		title : "选择【${promo.sPromoTheme}】换购商品",
		width: 1366,
		height: 550,
		type : "post",
		confirm : function(WinID) {
			$("#Selected").find("tr.rows").each(function() {
				TdArray = $(this).find("td");
				var nGoodsID,sGoodsDesc;
				for(var i = 0; i < TdArray.length; i++) {
					var text = $(TdArray[i]).text();
					nGoodsID = (i==0) ? text : nGoodsID;
					sGoodsDesc = (i==1) ? text : sGoodsDesc;
				}
				var gid = "GIFT" + nGoodsID;
				if($("#" + gid).length == 0) {
					var html = "";
					html += "<div class='gift' id='GIFT" + nGoodsID + "'>"
						html += "<div class='gift-title'>";
							html += "<p class='gift-title-dtl'>换购【" + sGoodsDesc + "】</p>";
							html += "<table class='gift-data'><thead><tr><th>满足金额</th><th>换购价格</th><th>换购积分</th><th>换购数量</th><th>换购库存</th></tr></thead><tbody><tr><td><input type='text' value='0'/></td><td><input type='text' value='0'/></td><td><input type='text' value='0'/></td><td><input type='hidden' value='" + nGoodsID + "'/><input type='text' value='1'/></td><td><input type='text' value='0'/></td></tr></tbody></table>";
							html += "<div class='addButton'>";
								if("${promo.sSettingModeID}" != "A") {
									html += "<button onclick='ToAddGoods(\"" + nGoodsID + "\", \"" + sGoodsDesc + "\")'>添加参与换购的商品</button>";
									html += "\n<button onclick=\"$('#GIFT" + nGoodsID + "').remove();\">删除</button>";
								}
							html += "</div>";
						html += "</div>";
						html += "<table class='goods-data' id='GG" + nGoodsID + "'>";
							html += "<thead>";
								html += "<tr>";
									if(sSettingModeID == "G") {
										html += "<th>商品名称</th>";
										html += "<th>商品编号</th>";
										html += "<th>操作</th>";
									} else if(sSettingModeID == "B") {
										html += "<th>品牌名称</th>";
										html += "<th>品牌编号</th>";
										html += "<th>操作</th>";
									} else if(sSettingModeID == "C") {
										html += "<th>分类名称</th>";
										html += "<th>分类编号</th>";
										html += "<th>操作</th>";
									}
								html += "</tr>";
							html += "</thead>";
							html += "<tbody>";
							html += "</tbody>";
						html += "</table>";
					html += "</div>";
					$("#GiftList").append(html);
				}
			});
			$.closeJWindow(WinID);
		}
	});
}

function savePromoDtl() {
	var formObj = [];
	var $Objs = $("#GiftList>.gift");
	for(var k = 0; k < $Objs.length; k++) {
		var giftObj = {};
		giftObj.ids = [];
		var Obj = $Objs[k];
		var nMeetAmount,nPrice,nPoint,nGoodsID;
		var $GiftArray = $(Obj).find(".gift-title>table.gift-data").find("input");
		for(var i = 0; i < $GiftArray.length; i++) {
			var value = $($GiftArray[i]).val();
			giftObj.nMeetAmount = (i==0) ? value : giftObj.nMeetAmount;
			giftObj.nPrice = (i==1) ? value : giftObj.nPrice;
			giftObj.nPoint = (i==2) ? value : giftObj.nPoint;
			giftObj.nGoodsID = (i==3) ? value : giftObj.nGoodsID;
			giftObj.nLimitQty = (i==4) ? value : giftObj.nLimitQty;
			giftObj.nMaxLimitQty = (i==5) ? value : giftObj.nMaxLimitQty;
		}
		var $Rows = $(Obj).find("table.goods-data>tbody>tr");
		for(var i = 0; i < $Rows.length; i++) {
			var datas = $($Rows[i]).find("td");
			for(var m = 0; m < datas.length; m++) {
				if(m == 1) {
					giftObj.ids[i] = $(datas[m]).text();
				}
			}
		}
		formObj[k] = giftObj;
	}
	var jsonObj = {};
	jsonObj.sPromoPaperNO = "${promo.sPromoPaperNO}";
	jsonObj.objArray = formObj;
	$.ajax({
		url : "saveGifts",
		type : "post",
		data : JSON.stringify(jsonObj),
		dataType : "json",
		success : function(json) {
			if(json.IsValid) {
				$.jalert({message:"保存成功", confirm:function(){window.location.reload(true);}});
			}
		}
	});
}

function ToAddGoods(id, desc) {
	var sPromoActionTypeID = "${promo.sPromoActionTypeID}";
	var sSettingModeID = "${promo.sSettingModeID}";
	$.jwindow({
		url : "select?promo.sPromoPaperNO=${promo.sPromoPaperNO}",
		title : "选择换购商品",
		width: 1366,
		height: 550,
		type : "post",
		confirm : function(WinID) {
		
			$("#Selected").find("tr.rows").each(function() {
				var html = "";
				TdArray = $(this).find("td");
				if(sSettingModeID == "G") {
					var nGoodsID,sGoodsDesc;
					for(var i = 0; i < TdArray.length; i++) {
						var text = $(TdArray[i]).text();
						nGoodsID = (i==0) ? text : nGoodsID;
						sGoodsDesc = (i==1) ? text : sGoodsDesc;
					}
					var ggid = "GG" + id + "_" + nGoodsID;
					if($("#" + ggid).length == 0) {
						html += "<tr id='" + ggid + "'>";
						html += "<td>" + sGoodsDesc + "</td>";
						html += "<td>" + nGoodsID + "</td>";
						html += "<td><a href=\"javascript:$('#" + ggid + "').remove();\">删除<a></td>";
						html += "</tr>";
						$("#GG" + id + ">tbody").append(html);
					}
				} else if(sSettingModeID == "B") {
					var sBrandID,sBrandName;
					for(var i = 0; i < TdArray.length; i++) {
						var text = $(TdArray[i]).text();
						sBrandID = (i==0) ? text : sBrandID;
						sBrandName = (i==1) ? text : sBrandName;
					}
					var ggid = "GG" + id + "_" + sBrandID;
					if($("#" + ggid).length == 0) {
						html += "<tr id='" + ggid + "'>";
						html += "<td>" + sBrandName + "</td>";
						html += "<td>" + sBrandID + "</td>";
						html += "<td><a href=\"$('#" + ggid + "').remove();\">删除<a></td>";
						html += "</tr>";
						$("#GG" + id + ">tbody").append(html);
					}
				} else if(sSettingModeID == "C") {
					var sCategoryNO,sCategoryDesc;
					for(var i = 0; i < TdArray.length; i++) {
						var text = $(TdArray[i]).text();
						sCategoryNO = (i==0) ? text : sCategoryNO;
						sCategoryDesc = (i==1) ? text : sCategoryDesc;
					}
					var ggid = "GG" + id + "_" + sCategoryNO;
					if($("#" + ggid).length == 0) {
						html += "<tr id='" + ggid + "'>";
						html += "<td>" + sCategoryDesc + "</td>";
						html += "<td>" + sCategoryNO + "</td>";
						html += "<td><a href=\"$('#" + ggid + "').remove();\">删除<a></td>";
						html += "</tr>";
						$("#GG" + id + ">tbody").append(html);
					}
				}
			});
			$.closeJWindow(WinID);
		}
	});
}

function backPromoMain(){
	window.location.href = webHost + "/promotion/list";
}
</script>