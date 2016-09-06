jQuery(function($) {
	var footable = null,
	$row = null, 
	isAll3 = false, //true为全选，false为未选中--第三步 
	step = 1, //第一步
	$table = $('.table-box table'), //获取表格元素
	$bgRow = null;
	$('.goods-import table').footable({ //响应式表格初始化
		debug: true,
		breakpoints: {
			phone: 600,
			tablet: 980
		},
		log: function(message, type) {
			$bgRow = $table.find('tbody tr').not('.footable-row-detail');
			if (message = 'footable_initialized') {
				$bgRow.each(function(index) {
					if (index % 2 == 1) {
						$(this).css({
							'background': '#fbfbfb'
						});
					}
				});
			}
			if (message == 'footable_row_expanded' || message == 'footable_row_collapsed') {
				$bgRow.each(function(index) {
					if (index % 2 == 1) {
						$(this).css({
							'background': '#fbfbfb'
						});
					}
				});
			}
		}
	});
	
	$('.table-step3 .batch .chk').on('click', function() { //全选/取消全选 ------ 第三步
		 $("input[name='tGoods_third_id']").each(function(index) {
			Checked.selectAll(this, isAll3);
		 }); 
		 Checked.selectAll($('.table-step3 .batch .chk'), isAll3);
		isAll3 = !isAll3;
	});
	
	
	loadThirdMsg();
	
	$('input[name="nRealSalePrice"]').focus(function(){
        //让当前得到焦点的文本框改变其背景色
		$(this).css("border","none");
        $(this).css("border-bottom","1px solid #e5e5e5");
    });
	$('input[name="nSaleUints"]').focus(function(){
        //让当前得到焦点的文本框改变其背景色
		$(this).css("border","none");
        $(this).css("border-bottom","1px solid #e5e5e5");
    });
	$('input[name="nMinSaleQty"]').focus(function(){
        //让当前得到焦点的文本框改变其背景色
		$(this).css("border","none");
        $(this).css("border-bottom","1px solid #e5e5e5");
    });
	
	$('#submit').on('click', function() { //提交审核
		var isChecked = false;
		var isVal=true;
		 
		$('input[name="tGoods_third_id"]').each(function(){ 
			var check=$(this).attr('checked');
			if(check=="checked"){
				isChecked = true;
				//订货倍数 
				var nSaleUints = $(this).parents('tr:first').find('input[name="nSaleUints"]');
				var nSaleUints_value= nSaleUints.val();  
 				if(nSaleUints_value ==''){
 					nSaleUints.css('border','1px solid red');
					isVal=false;
				}else if(isNaN(nSaleUints_value)){
					nSaleUints.css('border','1px solid red');
					isVal=false;
				}
 				
 				//最低起订量
 				var nMinSaleQty = $(this).parents('tr:first').find('input[name="nMinSaleQty"]');
				var nMinSaleQty_value= nMinSaleQty.val();  
 				if(nMinSaleQty_value ==''){
 					nMinSaleQty.css('border','1px solid red');
					isVal=false;
				}else if(isNaN(nMinSaleQty_value)){
					nMinSaleQty.css('border','1px solid red');
					isVal=false;
				}
				
				
				//建议零售价 
				var realSalePrice = $(this).parents('tr:first').find('input[name="nRealSalePrice"]');
				var first_sAgentContractNO_value= realSalePrice.val(); 
 				if(first_sAgentContractNO_value ==''){
					realSalePrice.css('border','1px solid red');
					isVal=false;
				}else if(isNaN(first_sAgentContractNO_value)){
					realSalePrice.css('border','1px solid red');
					isVal=false;
				}
			}
		});
		if(!isChecked){
			Ego.error("请选择需要申请的商品.",null);
			return ;
		}
		if(isVal){ 
			 thirdSubmitForm(); 
		}  
	});
});



function thirdSubmitForm(){ 
	var tGoods_third_id= [];
	var sMainBarcode = [];
	var sGoodsDesc = [];
	var sSpec = [];
	var sHome = [];
	var nSalePrice = [];
	var nLifeCycle = [];
	var nSaleUints = [];
	var nMinSaleQty = [];
	var nRealSalePrice = [];
	var sUnit = [];
	var sMemo = [];
	
	var datas={};
	
	var goodsArray = [];
	
	$('input[name="tGoods_third_id"]:checked').each(function(){ 
		var goodsDtl={};
		goodsDtl["tGoodsId"]=$(this).val();
		goodsDtl["sGoodsNO"]=$(this).parents('tr:first').find('#sGoodsNO').val(); 
		goodsDtl["sCategoryNO"]=$(this).parents('tr:first').find('#sCategoryNO').val();
		goodsDtl["sBrandID"]=$(this).parents('tr:first').find('#sBrandID').val();
		goodsDtl["sBrand"]=$(this).parents('tr:first').find('#sBrand').val(); 
		goodsDtl["sMainBarcode"]=$(this).parents('tr:first').find('#sMainBarcode').val();
		goodsDtl["sGoodsDesc"]=$(this).parents('tr:first').find('#sGoodsDesc').val();
		goodsDtl["sSpec"]=$(this).parents('tr:first').find('#sSpec').val();
		goodsDtl["sHome"]=$(this).parents('tr:first').find('#sHome').val();
		goodsDtl["nSalePrice"]=$(this).parents('tr:first').find('#nSalePrice').val();
		goodsDtl["nLifeCycle"]=$(this).parents('tr:first').find('#nLifeCycle').val();
		goodsDtl["nSaleUints"]=$(this).parents('tr:first').find('#nSaleUints').val();
		goodsDtl["nMinSaleQty"]=$(this).parents('tr:first').find('#nMinSaleQty').val();
		goodsDtl["nRealSalePrice"]=$(this).parents('tr:first').find('#nRealSalePrice').val();
		goodsDtl["sUnit"]=$(this).parents('tr:first').find('#sUnit').val();
		goodsDtl["sMemo"]=$(this).parents('tr:first').find('#sMemo').val();
		
 		
		//32=拆零(物流)
		var  sell_piece_by_piece_checked =  $(this).parents('tr:first').find('#sell_piece_by_piece').attr('checked')
		if(sell_piece_by_piece_checked == 'checked'){
			goodsDtl["sell_piece_by_piece"]=32;
		}else{
			goodsDtl["sell_piece_by_piece"]=0;
		}
		//64=季节性商品
		var  seasonal_goods_checked =  $(this).parents('tr:first').find('#seasonal_goods').attr('checked')
		if(seasonal_goods_checked == 'checked'){
			goodsDtl["seasonal_goods"]=64;
		}else{
			goodsDtl["seasonal_goods"]=0;
		}
		//128=是否可退换货
		var  can_return_checked =  $(this).parents('tr:first').find('#can_return').attr('checked')
		if(can_return_checked == 'checked'){
			goodsDtl["can_return"]=128;
		}else{
			goodsDtl["can_return"]=0;
		} 
		goodsArray.push(goodsDtl);
	});
	if(goodsArray.length ==0 ){ 
		Ego.error("商品申请失败，请刷新界面后重试.",null);
		return;
	}
 
	datas["sAgentContractNO"]=$("#sAgentContractNO").val();
	datas["goodsDtls"]=goodsArray;
	 
 	  $.ajax({
        cache: false,
        contentType: "application/json; charset=utf-8",  
        type: "POST",
        dataType: "json",
        url:'submitAgentContractGoods',
        data: JSON.stringify(datas),  
        async: false,
        error: function(request,errorThrown) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {
        	var isValid = data.IsValid;
        	var returnValue = data.ReturnValue;       	 	 
        	
        	if(isValid){
   			   Ego.success(returnValue,function(){
      			   window.location.href = webHost + '/goods/tGoodsDealer/importFirst';
      		  }); 
	     	}else{
	     		 Ego.error(returnValue,null);
	     	}
        }
    });   
}


//加载第三步数据
function loadThirdMsg(){ 
	var sOrgNO= $("#sOrgNO").val();
	var sAgentContractNO = $("#sAgentContractNO").val();
	var sGoodIds= $("#sGoodIds").val();
	$.ajax({
      cache: false,
      type: "POST",
      url:webHost+'/goods/tGoodsDealer/loadThirdMsg',
      data:'sAgentContractNO='+sAgentContractNO+'&sGoodIds='+sGoodIds,
      async: false,
      error: function(request) {
    	  Ego.error("系统连接异常,请刷新后重试.",null);
      },
      success: function(data) {  
      	 var dataResult = eval("(" + data + ")");
       
       	var isValid = dataResult.IsValid;
       
       	 if(isValid){
      		var dataList = dataResult.DataList.tGoodsList ;  
      		if(dataList.length>0){ 
					 var thirdMsgId="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i]; 
						 thirdMsgId+="<tr>";
						 
						 thirdMsgId+="<input type = 'hidden' name = 'sMainBarcode' id = 'sMainBarcode' value = '"+data.sMainBarcode+"'/>";
						 thirdMsgId+="<input type = 'hidden' name = 'sGoodsDesc' id = 'sGoodsDesc'  value = '"+data.sGoodsDesc+"'/>";
						 thirdMsgId+="<input type = 'hidden' name = 'sSpec'  id = 'sSpec' value = '"+data.sSpec+"'/>";
						 thirdMsgId+="<input type = 'hidden' name = 'sHome' id = 'sHome' value = '"+data.sHome+"'/>";
						 thirdMsgId+="<input type = 'hidden' name = 'nSalePrice' id = 'nSalePrice' value = '"+data.nNormalSalePrice+"'/>";
						 thirdMsgId+="<input type = 'hidden' name = 'nLifeCycle' id = 'nLifeCycle' value = '"+data.nLifeCycle+"'/> ";
						 thirdMsgId+="<input type = 'hidden' name = 'sGoodsNO' id = 'sGoodsNO' value = '"+data.sGoodsNO+"'/> ";
						 thirdMsgId+="<input type = 'hidden' name = 'sCategoryNO' id = 'sCategoryNO' value = '"+data.sCategoryNO+"'/> ";
						 thirdMsgId+="<input type = 'hidden' name = 'sBrandID' id = 'sBrandID' value = '"+data.sBrandID+"'/> ";
						 thirdMsgId+="<input type = 'hidden' name = 'sBrand' id = 'sBrand' value = '"+data.sBrand+"'/> ";
 
						 thirdMsgId+="	<td class='td-1'>";
						 thirdMsgId+="		<label class=checked-wrap>";
						 thirdMsgId+="			<input type=checkbox class='chk goods-third-chk' id='tGoods_third_id' name='tGoods_third_id' value='"+data.nGoodsID+"'  />";
						 thirdMsgId+="			<span class=chk-bg></span>";
						 thirdMsgId+="		</label>";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="	<td class='td-2'> "+data.sGoodsDesc+"("+data.nGoodsID+")</td>";
						 thirdMsgId+="	<td class='td-3'>";
						 thirdMsgId+="		<input type=text id='nSaleUints' name='nSaleUints' value='"+data.nOrderUnits+"'/>";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="	<td class='td-4'>";
						 thirdMsgId+="		<input type=text id='nMinSaleQty' name='nMinSaleQty' value='"+data.nOrderUnits+"'/>";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="	<td class='td-5'>";
						 thirdMsgId+="		<input type=text id='nRealSalePrice' name='nRealSalePrice'  value='"+data.nRealSalePrice+"'/>";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="	<td class='td-6'>";
						 thirdMsgId+="		<input type=text id='sUnit' name='sUnit' value='"+data.sUnit+"' readonly='readonly' />";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="	<td  class='td-7'>";
						 thirdMsgId+="		<input type=text id='sMemo' name='sMemo' value='"+data.sMemo+"'/>";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="	<td  class='td-8'>";
						 thirdMsgId+="		<label class='checked-wrap'>";   //是否拆零
						 thirdMsgId+="			<input type='checkbox' class='chk' id='sell_piece_by_piece' name='sell_piece_by_piece' value='32'  />";
						 thirdMsgId+="			<span class='chk-bg'></span>";
						 thirdMsgId+="		</label>";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="	<td  class='td-9'>";
						 thirdMsgId+="		<label class=checked-wrap>";
						 thirdMsgId+="			<input type=checkbox class=chk id='seasonal_goods' name='seasonal_goods' value='64'  />";
						 thirdMsgId+="			<span class=chk-bg></span>";
						 thirdMsgId+="		</label>";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="	<td  class='td-10'>";
						 thirdMsgId+="		<label class=checked-wrap>";
						 thirdMsgId+="			<input type=checkbox class=chk id='can_return' name='can_return' value='128'  />";
						 thirdMsgId+="			<span class=chk-bg></span>";
						 thirdMsgId+="		</label>";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="</tr>";
						 											 
					 } 
					 $("#thirdMsgId").html(thirdMsgId);		
					 
					 $("input[name='tGoods_third_id']").off().on('click', function() { //单个选 
						 Checked.checked(this); 
						 if($('.goods-third-chk').filter('[checked=checked]').length == $('.goods-third-chk').length) {
 							 $('.table-step3 .batch .chk').attr('checked',true);
							 $('.table-step3 .batch .chk').parents('label:first').addClass('checked'); 
						}else {
							$('.table-step3 .batch .chk').attr('checked',false);
							$('.table-step3 .batch .chk').parents('label:first').removeClass('checked'); 
						}
					 }); 
					 //32=拆零(物流)
					 $("input[name='sell_piece_by_piece']").off().on('click', function() { //单个选 
						 Checked.checked(this); 
					 });
					 //64=季节性商品
					 $("input[name='seasonal_goods']").off().on('click', function() { //单个选 
						 Checked.checked(this); 
					 });
					 //128=是否可退换货
					 $("input[name='can_return']").off().on('click', function() { //单个选 
						 Checked.checked(this); 
					 });
					 
				 } 
      	}else{
      		var returnValue=  dataResult.ReturnValue;
      		Ego.error(returnValue,null);
      	} 
      }
  }); 
}