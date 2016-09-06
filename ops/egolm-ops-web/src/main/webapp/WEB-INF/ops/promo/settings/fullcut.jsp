<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<style>
	.JWindowBody {left:50%;margin-left:-250px;top:50%;margin-top:-190px;}
	table {font-size:12px;}
	.table tbody>tr>td {height:34px;}
</style>
<e:resource title="促销管理"  currentTopMenu="促销管理" currentSubMenu="促销管理" css="css/fullcut.css" js="js/common.js" localCss="" localJs="dealer/warehouse/priorityManageList.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/promo/settings/fullcut.jsp">
<div class="promo_fullcut clearfix">
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
	<div class="fr addRule">
		<button onclick="addRule();">添加规则</button>
	</div>
</div>
<div id="PromoGoodsList">
	<input type="hidden" name="sPromoPaperNO" id = "sPromoPaperNO" value="${promo.sPromoPaperNO}"/>
	<input type="hidden" name="sAgentContractNO" id = "sAgentContractNO" value="${promo.sAgentContractNO}"/>
	<div class="rule-wrap">
		<c:forEach items="${resultDatas }" var="list" varStatus="s">
			<div>
			<table class="rule-table rule-table-${s.index}" idx="${s.index}">
				<thead>
					<tr>
						<c:if test="${promo.sPromoActionTypeID eq '4'}">
							<th data-hide="phone">规则编号</th>
							<th data-hide="phone">满足金额</th>
							<th data-hide="phone">折扣金额</th>
						</c:if>
						<c:if test="${promo.sPromoActionTypeID eq '5'}">
							<th data-hide="phone">规则编号</th>
							<th data-hide="phone">满足金额</th>
							<th data-hide="phone">折扣比例</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<input type="text" name="ruleId" value="${list.nRuleID}" readonly="readonly"></input>
							<input type="hidden" name="nRuleID" value="${list.nRuleID}" ></input>
						</td>
							<td><input type="text" name="nMeetAmount" value="${list.nMeetAmount}"></input></td>
						<c:if test="${promo.sPromoActionTypeID eq '4'}">
							<td><input type="text" name="nDisAmount" value="${list.nDisAmount}"></input></td>
						</c:if>
						<c:if test="${promo.sPromoActionTypeID eq '5'}">
							<td><input type="text" name="nDisRate" value="${list.nDisRate}"></td>
						</c:if>
					</tr>
					<tr>
						<c:if test="${promo.sSettingModeID eq 'B' }">
							<td><button onclick="ToAddGoods('${s.index}');">添加品牌</button></td>
						</c:if>
						<c:if test="${promo.sSettingModeID eq 'C' }">
							<td><button onclick="ToAddGoods('${s.index}');">添加分类</button></td>
						</c:if>
						<c:if test="${promo.sSettingModeID eq 'G' }">
							<td><button onclick="ToAddGoods('${s.index}');">添加商品</button></td>
						</c:if>
						<td><button onclick="deleteRule('${s.index}');">删除规则</button></td>
					</tr>
				</tbody>
			</table>
			<table class="rule-table-promoList-${s.index}">
				<thead>
					<tr>
						<c:if test="${promo.sSettingModeID eq 'B' }">
							<th>品牌编号</th>
							<th>品牌名称</th>
						</c:if>
						<c:if test="${promo.sSettingModeID eq 'C' }">
							<th>分类编号</th>
							<th>分类名称</th>
						</c:if>
						<c:if test="${promo.sSettingModeID eq 'G' }">
							<th>商品编号</th>
							<th>商品名称</th>
						</c:if>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list.promoList }" var="data" varStatus="status">
						<tr>
							<c:if test="${promo.sSettingModeID eq 'B' }">
								<td>${data.sBrandID}</td>
								<td>${data.sBrandName}</td>							
								<input type="hidden" name="sBrandID" value="${data.sBrandID}">
							</c:if>
							<c:if test="${promo.sSettingModeID eq 'C' }">
								<td>${data.sCategoryNO}</td>
								<td>${data.sCategoryDesc}</td>
								<input type="hidden" name="sCategoryNO" value="${data.sCategoryNO}">
							</c:if>
							<c:if test="${promo.sSettingModeID eq 'G' }">
								<td>${data.nGoodsID}</td>
								<td>${data.sGoodsDesc}</td>
								<input type="hidden" name="nGoodsID" value="${data.nGoodsID}">
							</c:if>
							<td><a class="delete" href='javascript:void(0);'
								onclick='deleteRow(this);'>删除</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
		</c:forEach>
	</div>
	<div class="savePromoDtl">
		<button onclick="savePromoDtl();">保存</button><button onclick="backPromoMain();">返回</button>
	</div>
</div>
</e:point>
<script type="text/javascript">
	$(document).ready(function(){
		
		 $("#PromoGoodsList").find("input[name='nDisAmount']").blur(function(){
			 if($.trim($(this).val()) != '' && !isNaN($.trim($(this).val()))){
				$(this).removeClass("err-border");
			}
		 });
		 $("#PromoGoodsList").find("input[name='nDisRate']").blur(function(){
			 if($.trim($(this).val()) != '' && !isNaN($.trim($(this).val()))){
				$(this).removeClass("err-border");
			}
		 });
		 
		 $("#PromoGoodsList").find("input[name='nMeetAmount']").blur(function(){
			 if($.trim($(this).val()) != '' && !isNaN($.trim($(this).val()))){
				$(this).removeClass("err-border");
			}
		 });
	});

	function ToAddGoods(idx) {
		$.jwindow({
			url : "select?promo.sPromoPaperNO=${promo.sPromoPaperNO}",
			title : "选择【${promo.sPromoTheme}】商品",
			width: 1200,
			height: 600,
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

					var promoModeID = "${promo.sSettingModeID}";
					var hiddenHtml = "";
					var hasRecord = false;
					if(promoModeID == 'B'){
						hiddenHtml = "<input type='hidden' name='sBrandID' value='"+nGoodsID+"'>";
						if($(".rule-table-promoList-"+idx).find("input[name='sBrandID'][value='"+nGoodsID+"']").length > 0){
							hasRecord = true;
						}
					}else if(promoModeID == 'C'){
						hiddenHtml = "<input type='hidden' name='sCategoryNO' value='"+nGoodsID+"'>";
						if($(".rule-table-promoList-"+idx).find("input[name='sCategoryNO'][value='"+nGoodsID+"']").length > 0){
							hasRecord = true;
						}
					}else if(promoModeID == 'G'){
						hiddenHtml = "<input type='hidden' name='nGoodsID' value='"+nGoodsID+"'>";
						if($(".rule-table-promoList-"+idx).find("input[name='nGoodsID'][value='"+nGoodsID+"']").length > 0){
							hasRecord = true;
						}
					};
					
					if(!hasRecord){
						var html = "<tr>"
							+ "<td>"+nGoodsID+"</td>"
							+ "<td>"+sGoodsDesc+"</td>"
							+ hiddenHtml
							+ "<td>"
							+ "	  <a class='delete' href='javascript:void(0);' onclick='deleteRow(this);'>删除</a>"
							+ "</td>"
						+"</tr>";
						
						$(".rule-table-promoList-"+idx).append(html);						
					}
				});
				$.closeJWindow(WinID);
			}
		});
	}
	
	function addRule(){
		var ruleTh = "";
		var ruleTd = "";
		var ruleBut = "";
		
		var promoTh = "";
		var promoActionTypeID = "${promo.sPromoActionTypeID}";
		var promoModeID = "${promo.sSettingModeID}";
		console.log($(".rule-table").length);
		var nextIdx = getNextRuleID();
		if(promoActionTypeID == '4'){
			ruleTh =  "							<th data-hide='phone'>规则编号</th> "
			 + "							<th data-hide='phone'>满足金额</th> "
			 + "							<th data-hide='phone'>折扣金额</th> "
			 + "							<th></th> ";
			ruleTd =  "							<td><input type='text' name='nMeetAmount' value=''></input></td> "
			 + "							<td><input type='text' name='nDisAmount' value=''></input></td> " ;
			 
			if(promoModeID == 'B'){
				ruleBut = "添加品牌";
				promoTh = "							<th>品牌编号</th> "
						+ "							<th>品牌名称</th> ";
			}else if(promoModeID == 'C'){
				ruleBut = "添加分类";
				promoTh = "							<th>分类编号</th> "
				 		+ "							<th>分类名称</th> ";
			}else if(promoModeID == 'G'){
				ruleBut = "添加商品";
				promoTh = "							<th>商品编号</th> "
					 	+ "							<th>商品名称</th> ";
			};
		}else if(promoActionTypeID == '5'){
			ruleTh = "	<th data-hide='phone'>规则编号</th> "
				 + "							<th data-hide='phone'>满足金额</th> "
				 + "							<th data-hide='phone'>折扣比例</th> ";
				 
			ruleTd =   "							<td><input type='text' name='nMeetAmount' value=''></td> "
				 + "							<td><input type='text' name='nDisRate' value=''></td> ";
			if(promoModeID == 'B'){
				ruleBut = "添加品牌";
				promoTh = "							<th>品牌编号</th> "
						+ "							<th>品牌名称</th> ";
			}else if(promoModeID == 'C'){
				ruleBut = "添加分类";
				promoTh = "							<th>分类编号</th> "
				 		+ "							<th>分类名称</th> ";
			}else if(promoModeID == 'G'){
				ruleBut = "添加商品";
				promoTh = "							<th>商品编号</th> "
					 	+ "							<th>商品名称</th> ";
			};
		}
		
		var html = "<div><table class='rule-table rule-table-"+nextIdx+"' idx='"+nextIdx+"'> "
			 + "				<thead> "
			 + "					<tr> "
			 + 							ruleTh
			 + "					</tr> "
			 + "				</thead> "
			 + "				<tbody> "
			 + "					<tr> "
			 + "						<td><input type='text' name='ruleId' value='"+nextIdx+"' readonly='readonly'></input><input type='hidden' name='nRuleID' value='"+nextIdx+"'></input></td> "
			 + 							ruleTd
			 + "					</tr> "
			 + "					<tr>"
			 + "						<td><button onclick='ToAddGoods("+nextIdx+");'>"+ruleBut+"</button></td> "
			 + "						<td><button onclick='deleteRule("+nextIdx+");'>删除规则</button></td> "
			 + "					</tr>"				
			 + "				</tbody> "
			 + "			</table> "
			 + "			<table class='rule-table-promoList-"+nextIdx+"'> "
			 + "				<thead> "
			 + "					<tr> "
			 + promoTh
			 + "						<th></th> "
			 + "					</tr> "
			 + "				</thead> "
			 + "				<tbody> "
			 + "				</tbody>"
			 + "			</table></div>";
		$(".rule-wrap").append(html);
		
		 $("#PromoGoodsList").find("input[name='nDisAmount']").blur(function(){
			 if($.trim($(this).val()) != '' && !isNaN($.trim($(this).val()))){
				$(this).removeClass("err-border");
			 }else{
				 $(this).addClass("err-border");
			 }
		 });
		 $("#PromoGoodsList").find("input[name='nDisRate']").blur(function(){
			 if($.trim($(this).val()) != '' && !isNaN($.trim($(this).val()))){
				$(this).removeClass("err-border");
			 }else{
				 $(this).addClass("err-border");
			 }
		 });
		 
		 $("#PromoGoodsList").find("input[name='nMeetAmount']").blur(function(){
			 if($.trim($(this).val()) != '' && !isNaN($.trim($(this).val()))){
				$(this).removeClass("err-border");
			 }else{
				 $(this).addClass("err-border");
			 }
		 });
	}
	
	function deleteRow(obj){
		Ego.alert("确认删此商品吗",function(){
			$(obj).parent().parent().remove();
		});
	}
	
	function deleteRule(idx){
		Ego.alert("确认删除此规则及以下商品吗",function(){
			$(".rule-table-promoList-"+idx).parent().remove();
		});
	}
	
	function savePromoDtl() {
		var jsonStr = {};
		var PromoDtlList = [];
		var isVal=true;
		$("#PromoGoodsList").find(".rule-table").each(function(){
			var promoDtl = {};
			var nRuleID = $(this).find("input[name='nRuleID']").val();
			var nDisAmount = $.trim($(this).find("input[name='nDisAmount']").val());
			var nDisRate = $.trim($(this).find("input[name='nDisRate']").val());
			var nMeetAmount = $.trim($(this).find("input[name='nMeetAmount']").val());
			var idx = $(this).attr("idx");
			
			if(nMeetAmount == ''){
				$(this).find("input[name='nMeetAmount']").addClass("err-border");
				isVal = false;
			}else if(isNaN(nMeetAmount)){
				$(this).find("input[name='nMeetAmount']").addClass("err-border");
				isVal = false;
			}
			
			
			var promoActionTypeID = "${promo.sPromoActionTypeID}";
			if(promoActionTypeID == '4'){
				if(nDisAmount == ''){
					$(this).find("input[name='nDisAmount']").addClass("err-border");
					isVal = false;
				}else if(isNaN(nDisAmount)){
					$(this).find("input[name='nDisAmount']").addClass("err-border");
					isVal = false;
				}				
			}else{
				if(nDisRate == ''){
					$(this).find("input[name='nDisRate']").addClass("err-border");
					isVal = false;
				}else if(isNaN(nDisRate)){
					$(this).find("input[name='nDisRate']").addClass("err-border");
					isVal = false;
				}
								
			}
			
			/* if($(".rule-table-promoList-"+idx).find("tbody").find("tr").length <= 0){
				Ego.error("存在未添加商品的规则，请添加商品，或者删除此规则.",null);
				isVal = false;
			} */
			
			$(".rule-table-promoList-"+idx).find("tbody").find("tr").each(function(){
				var nGoodsID = $(this).find("input[name='nGoodsID']").val();
				var sBrandID = $(this).find("input[name='sBrandID']").val();
				var sCategoryNO = $(this).find("input[name='sCategoryNO']").val();
				
				var promoDtl={};
				promoDtl["sCategoryNO"]=sCategoryNO;
				promoDtl["sBrandID"]=sBrandID;
				promoDtl["nGoodsID"]=nGoodsID;
				promoDtl["nLimitQty"]=0;
				promoDtl["nMaxLimitQty"]=0;
				promoDtl["nTag"]=0;
				promoDtl["nRuleID"]=nRuleID;
				promoDtl["sGroupNO"]="";
				promoDtl["nMeetQty"]=null;
				promoDtl["nMeetAmount"]=nMeetAmount;
				promoDtl["nDisRate"]=nDisRate;
				promoDtl["nDisAmount"]=nDisAmount;
				promoDtl["nPrice"]=null;
				promoDtl["nAmount"]=null;
				promoDtl["nPoint"]=null;
				
				PromoDtlList.push(promoDtl);
			});
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
		 	       		Ego.success("添加成功",function(){
		 	       			window.location.href = webHost + '/promotion/setting?promo.sPromoPaperNO='+$("#sPromoPaperNO").val();
		 	       		});
	 		    	}else{
	 		    		 
	 		   		}
	 	       }
	 	    });   
	}
	function backPromoMain(){
		window.location.href = webHost + "/promotion/list";
	}
	
	function getNextRuleID(){
		var maxId = 0;
		if($("input[name='ruleId']").length == 0){
			maxId = 0;
		}else{
			$("input[name='ruleId']").each(function(){
				var i = $(this).val();
				console.log(i);
				if(parseInt(maxId) < parseInt(i)){
					maxId = i;
				}
			});			
		}
		return parseInt(maxId)+1;
	}
</script>


