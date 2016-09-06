<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
<form method="post" action="<%=request.getContextPath() %>/goods/product/selectGoods" id="goodsListImportForm" class="pageForm required-validate"  onsubmit="return iframeCallback(this);">
		<select multiple="multiple" id="callbacks" name="my-select[]">

			<c:forEach items="${tGoodsList }" var = "tGoods">
			      <option value='${tGoods.nGoodsID }'>${tGoods.sGoodsDesc } | ${tGoods.nShelfLife } |${tGoods.sSpec} | ${tGoods.nNormalSalePrice } | ${tGoods.nCaseUnits } | ${tGoods.nOrderUnits }</option> 
			</c:forEach>
			        
	   </select>
	    <input type = "hidden" id = "tGoods_ids" name = "tGoods_ids"  />
	     <input type = "hidden" id = "sAgentContractNO" name = "sAgentContractNO" value = "ht001"/>
	    <div class="buttonActive"><div class="buttonContent"><button type="button" onclick="selectForm();">保存</button></div></div>
	    <div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
	    </form>
<script> 

  $('#callbacks').multiSelect({
	  afterSelect: function(values){ 
	    setGoodsIDMsg(values,"add");
	  },
	  afterDeselect: function(values){ 
	    setGoodsIDMsg(values,"del");
	  }
  });
  
  function setGoodsIDMsg(id,type){
	  if(type == 'add'){
		  var goodsIds = $("#tGoods_ids").val();
		  $("#tGoods_ids").val(goodsIds+""+id+",");
	  }
	  
	  if(type == 'del'){
		  var goodsIds = $("#tGoods_ids").val();
		  goodsIds = goodsIds.replace(id+",","");
		  $("#tGoods_ids").val(goodsIds);
	  }
  }
  function selectForm(){
	  var goodsIds = $("#tGoods_ids").val();
	  if(goodsIds == ''){
		  alert("请选择商品");
		  return false;
	  }
	  document.getElementById("goodsListImportForm").submit();

  }
</script>