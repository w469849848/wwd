<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<div class="promo_batch clearfix">
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
	<div  class="fr ToAddGoods">
		<button onclick="ToAddGoods();">添加商品</button>
	</div>
</div>
<div id="BatchGoodsList">
	<table> 
	<input type="hidden" name="sPromoPaperNO" id = "sPromoPaperNO" value="${promo.sPromoPaperNO}"/>
	<input type="hidden" name="sAgentContractNO" id = "sAgentContractNO" value="${promo.sAgentContractNO}"/>
		<thead>
			<tr>
				<th>商品编号</th>
				<th>商品名称</th>
				<th>满足数量</th>
				<th>活动单价</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${promoDtlList }" var="promoDtl">
				   	 <tr>
					 	<input type = 'hidden' name = 'nGoodsID' id = 'nGoodsID' value = "${promoDtl.nGoodsID }"/> 
						<td>${promoDtl.nGoodsID }</td>
						<td>${promoDtl.sGoodsDesc }</td>
						<td> <input type="text" id="nMeetQty_${promoDtl.nGoodsID }" name="nMeetQty" value="${promoDtl.nMeetQty }"/></td>
						<td> <input type="text" id="nPrice_${promoDtl.nGoodsID }" name="nPrice" value="${promoDtl.nPrice }"/></td>
						<td><a class='delete' href='javascript:void(0);' onclick='deleteRow(this);'><img src="${resourceHost}/images/delete.png" alt="删除" /></a></td>
					 </tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="SavePromoGoods">
		<button onclick="SavePromoGoods();">保存</button> &nbsp;&nbsp;&nbsp;
		<button onclick="backPromoMain();">返回</button>
	</div>
</div>
<script type="text/javascript"> 
	$(document).ready(function(){
    	 $("#BatchGoodsList").find("input[name='nMeetQty']").blur(function(){ 
    		 if(Trim($(this).val()) != '' && !isNaN(Trim($(this).val()))){
 				$(this).removeClass("err-border");
 			}else{
 				$(this).addClass("err-border");
			 }
    	 });
    	 $("#BatchGoodsList").find("input[name='nPrice']").blur(function(){
    		 if(Trim($(this).val()) != '' && !isNaN(Trim($(this).val()))){
 				$(this).removeClass("err-border");
 			}else{
 				$(this).addClass("err-border");
			 }
    	 });
     });

	function SavePromoGoods() {
		var jsonStr = {};
		var PromoDtlList = [];
		var isVal=true;
		$("#BatchGoodsList>table>tbody>tr").each(function() { 
			var nGoodsID = $(this).find('#nGoodsID').val();
			 
			var nMeetQty = Trim($("#nMeetQty_"+nGoodsID).val());
			var nPrice = Trim($("#nPrice_"+nGoodsID).val());
			 
			if(nMeetQty == ''){
				$("#nMeetQty_"+nGoodsID).addClass("err-border");
				isVal = false;
			}else if(isNaN(nMeetQty)){
				$("#nMeetQty_"+nGoodsID).addClass("err-border");
				isVal = false;
			}
			
			if(nPrice == ''){
				$("#nPrice_"+nGoodsID).addClass("err-border");
				isVal = false;
			}else if(isNaN(nPrice)){
				$("#nPrice_"+nGoodsID).addClass("err-border");
				isVal = false;
			}
			 
			var promoDtl={};
			promoDtl["sCategoryNO"]="";
			promoDtl["sBrandID"]="";
			promoDtl["nGoodsID"]=nGoodsID;
			promoDtl["nLimitQty"]=0;
			promoDtl["nMaxLimitQty"]=0;
			promoDtl["nTag"]=0;
			promoDtl["nRuleID"]=null;
			promoDtl["sGroupNO"]="";
			promoDtl["nMeetQty"]=nMeetQty;
			promoDtl["nMeetAmount"]=null;
			promoDtl["nDisRate"]="0";
			promoDtl["nDisAmount"]="0";
			promoDtl["nPrice"]=nPrice;
			promoDtl["nPrice"]=nPrice;
			promoDtl["nAmount"]=nPrice *nMeetQty;
			promoDtl["nPoint"]=0; 
			
			PromoDtlList.push(promoDtl);
		 
		});
		jsonStr["sPromoPaperNO"]=$("#sPromoPaperNO").val();
		jsonStr["sAgentContractNO"]=$("#sAgentContractNO").val();
		jsonStr["PromoDtlList"]=PromoDtlList;
 		
		if(!isVal){ 
			return;
		}
		
 	  $.ajax({
 	        cache: false,
 	        contentType: "application/json; charset=utf-8",  
 	        type: "POST",
 	        dataType: "json",
 	        url:'saveBatchDtl',
 	        data: JSON.stringify(jsonStr),  
 	        async: false,
 	        error: function(request,errorThrown) {
 	        	Ego.error("系统连接异常,请刷新后重试.",null);
 	        },
 	        success: function(data) {
 	        	var isValid = data.IsValid; 
 	        	if(isValid){
 	        		 Ego.success("活动商品添加成功",function(){
 	        			window.location.href = webHost + '/promotion/setting?promo.sPromoPaperNO='+$("#sPromoPaperNO").val();
 	       		    }); 
 		     	}else{
 		     		 
 		     	}
 	        }
 	    });   
		
	}
	function ToAddGoods() {
		$.jwindow({
			url : "select?promo.sPromoPaperNO=${promo.sPromoPaperNO}",
			title : "选择【${promo.sPromoTheme}】商品",
			width: 1200,
			height: 600,
			type : "post",
			confirm : function(WinID) {
				var goodsListMsg = "";
				$("#Selected").find("tr.rows").each(function() {
					TdArray = $(this).find("td");
					var nGoodsID,sGoodsDesc;
					for(var i = 0; i < TdArray.length; i++) {
						var text = $(TdArray[i]).text();
						nGoodsID = (i==0) ? text : nGoodsID;
						sGoodsDesc = (i==1) ? text : sGoodsDesc;
					}
					var isExists = checkExists(nGoodsID);
					if(!isExists){
						goodsListMsg += "<tr  id='ID_" + nGoodsID + "'>";
						goodsListMsg += "   <input type = 'hidden' name = 'nGoodsID' id = 'nGoodsID' value = '"+nGoodsID+"'/> ";
						goodsListMsg += "	<td>"+nGoodsID+"</td>";
						goodsListMsg += "	<td>"+sGoodsDesc+"</td>";
						goodsListMsg += "	<td> <input type='text' id='nMeetQty_"+nGoodsID+"' name='nMeetQty' /></td>";
						goodsListMsg += "	<td> <input type='text' id='nPrice_"+nGoodsID+"' name='nPrice' /></td>";
						goodsListMsg += "	<td><a class='delete' href='javascript:void(0);' onclick='deleteRow(this);'><img src='"+resourceHost+"/images/delete.png' alt='删除' /></a></td>";
						goodsListMsg += "</tr>"; 
					}
				});
				$("#BatchGoodsList>table>tbody").append(goodsListMsg);
				$.closeJWindow(WinID);
				
				 $("#BatchGoodsList").find("input[name='nMeetQty']").blur(function(){
					 var inputValue = Trim($(this).val());
 		    		 if(inputValue != '' && !isNaN(inputValue)){
		 				$(this).removeClass("err-border");
		 			 }else{
		 				$(this).addClass("err-border");
		 			 }
		    	 });
		    	 $("#BatchGoodsList").find("input[name='nPrice']").blur(function(){
		    		 var inputValue = Trim($(this).val());
		    		 if(inputValue != '' && !isNaN(inputValue)){
		 				$(this).removeClass("err-border");
		 			}else{
		 				$(this).addClass("err-border");
		 			 }
		    	 });
 			}
		});
	}
	
	function deleteRow(obj){
		Ego.alert("确认删此商品吗",function(){
			$(obj).parent().parent().remove();
		});
	}

	
	function checkExists(addNGoodsId){
		var isExists  = false;
		$("#BatchGoodsList>table>tbody>tr").each(function() { 
			var nGoodsID = $(this).find('#nGoodsID').val();
			if(addNGoodsId == nGoodsID){
				isExists = true;
				return isExists;
			}
		});
		return isExists;
	}
	function Trim(str)
	{ 
	    return str.replace(/(^\s*)|(\s*$)/g, ""); 
	}
	function backPromoMain(){
		window.location.href = webHost + "/promotion/list";
	}
</script>