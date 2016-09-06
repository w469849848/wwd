jQuery(function($) {
	var footable = null,
		$row = null,
		isAll1 = false, //true为全选，false为未选中--第一步
		isAll2 = false, //true为全选，false为未选中--第二步
		isAll3 = false, //true为全选，false为未选中--第三步
		isAll4 = false, //true为全选，false为未选中--资料库弹窗商品列
		isAll5 = false, //true为全选，false为未选中--资料库弹窗已选商品
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
	
	//显示资料库
	$('.btn-database').on('click',function(){
		loadGoodsMsg("","");
		$('#database').modal('show');  //显示弹出框 
		
		 $("#goods-sort-menu li").click(function(){  //商品分类选择
			 var litext = $(this).text();
			 var livalue =  $(this).attr("value"); 
			 $("#goods-sort-id").find("span").eq(0).text(litext);
			 $("#sCategoryNO").val(livalue);
 		 });
		 
		 
		 
	});
	$('.select-box .batch .chk').on('click', function() { //全选/取消全选 ------ 资料库商品列表
		$('.select-box .checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll4);
		});
		isAll4 = !isAll4;
	});
	
	$('.result-box .batch .chk').on('click', function() { //全选/取消全选 ------ 已选商品列表
		$('.result-box .checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll5);
		});
		isAll5 = !isAll5;
	});
	
	//选中商品移动到结果框
	$('.btn-box .btn-select').on('click',function(){ 
		$('.select-box table tbody input').each(function(index){

			var $this = $(this);
				checked = $this.attr('checked');
			if(!!checked){
				var $row = $this.parents('tr:first').clone();
				$('.result-box table tbody').append($row);
				$this.parents('tr:first').remove();
			}
		});
		
	});
	
	//还原选中的商品
	$('.btn-box .btn-remove').on('click',function(){
		
		$('.result-box table tbody input').each(function(index){

			var $this = $(this);
				checked = $this.attr('checked');
			if(!!checked){
				var $row = $this.parents('tr:first').clone();
				$('.select-box table tbody').append($row);
				$this.parents('tr:first').remove();
			}
		});
		
	});
	
	$('.btn-wrap .btn-submit').on('click',function(){   //确认选中的商品
		var selecGoods = [];
		$('.result-box table tbody input').each(function(index){ 
				var $this = $(this);
				var checked=$this.attr('checked');
				if(checked=='checked'){
					console.log($this.attr('value'));
					selecGoods.push($this.attr('value')); 
			}
		}); 
		$('#database').modal('hide');
		selectGoods(selecGoods);
	});
	
	
	$('.modal  .modal-dialog .btn-wrap').on('click',function(){   //弹框后的查询
	     var goodsNameOrBarCode = $("#goodsNameOrBarCode").val();
	     var sCategoryNO = $("#sCategoryNO").val();
	      
	     loadGoodsMsg(goodsNameOrBarCode,sCategoryNO);
	});


	$(document).on('click','.chk',function(){
		Checked.checked(this);
	});

	$('.table-step1 .batch .chk').on('click', function() { //全选/取消全选-------第一步
		$('.table-step1 .checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll1);
		});
		isAll1 = !isAll1;
	});
	
	$('.table-step2 .batch .chk').on('click', function() { //全选/取消全选 ------ 第二步
		$('.table-step2 .checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll2);
		});
		isAll2 = !isAll2;
	});
	
	$('.table-step3 .batch .chk').on('click', function() { //全选/取消全选 ------ 第二步
		$('.table-step3 .checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll3);
		});
		isAll3 = !isAll3;
	});
	
	$('.next-step').on('click',function(){ //下一步
		var nAgentID= $("#nAgentID").val();
		var sOrgNO= $("#sOrgNO").val();
		
		step = $(this).attr("step");
		if(step == 1){
			var first_sAgentContractNO_value = "";
			$('input[name="sAgentContractNO_first"]:checked').each(function(){ 
				console.log($(this).val());
				first_sAgentContractNO_value= $(this).val();
			});
			if(first_sAgentContractNO_value == ''){
				alert("请选择一个合同");
				return false;
			}
			
			 window.location.href=basectx+"/goods/tGoodsDealer/importSecond?sAgentContractNO="+first_sAgentContractNO_value+"&nAgentID="+nAgentID; 
 		}
		
		if(step == 2){
 			var tGoods_second_id = "";
			$('input[name="tGoods_second_id"]:checked').each(function(){ 
				console.log($(this).val());
				tGoods_second_id += $(this).val()+',';
			});
			if(tGoods_second_id == ''){
				alert("请选择一个商品");
				return false;
			}
			alert(tGoods_second_id);
		 	var sAgentContractNO = $("#sAgentContractNO").val();
			window.location.href=basectx+"/goods/tGoodsDealer/importThird?sGoodIds="+tGoods_second_id+"&sAgentContractNO="+sAgentContractNO+"&nAgentID="+nAgentID;
 		}
		
		
		if(step == 3){ return false; }
		
		$('.table-step' + step).addClass('hide'); //隐藏上一步表格
		step++;
		$('.table-step' + step).removeClass('hide'); //显示下一步表格
		$('a.btn-step' + step).addClass('active');
		$('p.dashed-step' + step).addClass('active'); 
	}); 
	
	if($("#stepPage").val() == 2){
		loadSenondMsg();
	}
	if($("#stepPage").val() ==3){
		loadThirdMsg();
	}
	
	
	$('#submit').on('click', function() { //提交审核
		//提交代码 
		if(check()){ //保存成功
			thirdSubmitForm();
		}
	});
	
	
});
 
function check(){
	return true;
}


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
		goodsArray.push(goodsDtl);
	});
	
	datas["nAgentID"]=$("#nAgentID").val();
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
            alert("Connection error"); 
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")");
        	console.log("dataResult="+dataResult);
        	var isValid = dataResult.IsValid;
        	var returnValue = dataResult.ReturnValue 
       	 	alert(returnValue);  
        }
    }); 
}


//加载第二步的数据
function loadSenondMsg(){ 
	var nAgentID= $("#nAgentID").val();
	var sOrgNO= $("#sOrgNO").val();
	var sAgentContractNO = $("#sAgentContractNO").val();
    var sGoodsDescOrBarcode = $("#sGoodsDescOrBarcode").val();
    var sCategoryNO = $("#sCategoryNO").val();
    var sBrand = $("#sBrand").val();
	$.ajax({
        cache: false,
        type: "POST",
        url:basectx+'/goods/tGoodsDealer/loadSecondMsg',
        data:'sAgentContractNO='+sAgentContractNO+'&nAgentID='+nAgentID+'&sGoodsDescOrBarcode='+sGoodsDescOrBarcode+'&sCategoryNO='+sCategoryNO+'&sBrand='+sBrand,
        async: false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {  
        	 var dataResult = eval("(" + data + ")");
         
         	var isValid = dataResult.IsValid;
         
         	 if(isValid){
        		var dataList = dataResult.DataList.tGoodsList ;  
        		if(dataList.length>0){ 
					 var secondMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 console.log(data.sGoodsName);
						 
						 secondMsg+="<tr>";
						 secondMsg+="	<td>";
						 secondMsg+="		<label class='checked-wrap'>";
						 secondMsg+="			<input type='checkbox' class='chk' id='tGoods_second_id' name='tGoods_second_id' value='"+data.nGoodsID+"' />";
						 secondMsg+="			<span class='chk-bg'></span>";
						 secondMsg+="		</label>";
						 secondMsg+="	</td>";
						 secondMsg+="	<td>";
						 secondMsg+="		<div class='good-info clearfix'>";
						 secondMsg+="			<img class='pull-left' src='"+basectx+"/resources/egolm/assets/goods/good.jpg' />";
						 secondMsg+="			<p>"+data.sGoodsDesc+"</p>";
						 secondMsg+="			<p>"+data.sGoodsName+"</p>";
						 secondMsg+="			<p>"+data.sMainBarcode +"</p>";
						 secondMsg+="		</div>";
						 secondMsg+="	</td>";
						 secondMsg+="	<td>"+data.nShelfLife +"天</td>";
						 secondMsg+="	<td>"+data.sSpec +"</td>";
						 secondMsg+="	<td>"+data.nNormalSalePrice+"￥</td>";
						 secondMsg+="	<td>"+data.nCaseUnits+"/箱</td>";
						 secondMsg+="	</tr> ";
					 }
					 $("#secondMsgId").html(secondMsg);					  
				 } 
        	}else{
        		var returnValue=  dataResult.ReturnValue;
        		alert(returnValue);
        	} 
        }
    }); 
}

//加载第三步数据
function loadThirdMsg(){
	var nAgentID= $("#nAgentID").val();
	var sOrgNO= $("#sOrgNO").val();
	var sAgentContractNO = $("#sAgentContractNO").val();
	var sGoodIds= $("#sGoodIds").val();
	$.ajax({
        cache: false,
        type: "POST",
        url:basectx+'/goods/tGoodsDealer/loadThirdMsg',
        data:'sAgentContractNO='+sAgentContractNO+'&nAgentID='+nAgentID+'&sGoodIds='+sGoodIds,
        async: false,
        error: function(request) {
            alert("Connection error");
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
						 
						 thirdMsgId+="	<td>";
						 thirdMsgId+="		<label class=checked-wrap>";
						 thirdMsgId+="			<input type=checkbox class=chk id='tGoods_third_id' name='tGoods_third_id' value='"+data.nGoodsID+"'  />";
						 thirdMsgId+="			<span class=chk-bg></span>";
						 thirdMsgId+="		</label>";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="	<td>"+data.sGoodsDesc+"("+data.nGoodsID+")</td>";
						 thirdMsgId+="	<td>";
						 thirdMsgId+="		<input type=text id='nSaleUints' name='nSaleUints' value='"+data.nOrderUnits+"'/>";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="	<td>";
						 thirdMsgId+="		<input type=text id='nMinSaleQty' name='nMinSaleQty' value='"+data.nGoodsID+"'/>";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="	<td>";
						 thirdMsgId+="		<input type=text id='nRealSalePrice' name='nRealSalePrice'  />";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="	<td>";
						 thirdMsgId+="		<input type=text id='sUnit' name='sUnit' value='"+data.sUnit+"'/>";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="	<td>";
						 thirdMsgId+="		<input type=text id='sMemo' name='sMemo' value='"+data.sMemo+"'/>";
						 thirdMsgId+="	</td>";
						 thirdMsgId+="</tr>";
					 }
					 $("#thirdMsgId").html(thirdMsgId);					  
				 } 
        	}else{
        		var returnValue=  dataResult.ReturnValue;
        		alert(returnValue);
        	} 
        }
    }); 
}

//加载资料库中的数据
function loadGoodsMsg(goodsNameOrBarCode,sCategoryNO){
	$.ajax({
        cache: false,
        type: "POST",
        url:basectx+'/goods/product/listGoods',
        data:'goodsNameOrBarCode='+goodsNameOrBarCode+"&sCategoryNO="+sCategoryNO,
        async: false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {  
        	 var dataResult = eval("(" + data + ")");
         
         	var isValid = dataResult.IsValid;
         
         	 if(isValid){
        		var dataList = dataResult.DataList ;  
        		console.log("dataList="+dataList.length);
        		if(dataList.length>0){ 
					 var goodsMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 goodsMsg+="<tr>";
						 goodsMsg+="	<td>";
						 goodsMsg+="		<label class='checked-wrap'>";
						 goodsMsg+="			<input type='checkbox' class='chk' name='nGoodsID' id='nGoodsID' value='"+data.nGoodsID+"' />";
						 goodsMsg+="			<span class='chk-bg'></span>";
						 goodsMsg+="		</label>";
						 goodsMsg+="	</td>";
						 goodsMsg+="	<td>";
						 goodsMsg+="		<div class='g-info clearfix'>";
						 goodsMsg+="			<img class='pull-left' src='"+basectx+"/resources/egolm/assets/avatars/user1.jpg'>";
						 goodsMsg+="			<p>"+data.sGoodsDesc+"</p>";
						 goodsMsg+="			<p>"+data.sGoodsName+"</p>";
						 goodsMsg+="			<p class='nb'>"+data.sMainBarcode+"</p>";
						 goodsMsg+="		</div>";
						 goodsMsg+="	</td>";
						 goodsMsg+="	<td>"+data.sSpec+"</td>";
						 goodsMsg+="	<td>"+data.nCaseUnits+"/"+data.sUnit+"</td>";
						 goodsMsg+="</tr>";
					 }
					 $("#showWindowsId").html(goodsMsg);					  
				 }else{
					 console.log('要设为空');
					 $("#showWindowsId").html("");
				 }
        	}else{
        		var returnValue=  dataResult.ReturnValue;
        		alert(returnValue);
        	} 
        }
    }); 
}


function selectGoods(tGoodsIds){
	var sAgentContractNO = $("#sAgentContractNO").val();
	var nAgentID = $("#nAgentID").val();
	$.ajax({
        cache: false,
        type: "POST",
        url:basectx+'/goods/product/selectGoods',
        data:'tGoods_ids='+tGoodsIds+'&sAgentContractNO='+sAgentContractNO+'&nAgentID='+nAgentID,
         async: false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
			 window.location.href=basectx+"/goods/tGoodsDealer/importSecond?sAgentContractNO="+sAgentContractNO+"&nAgentID="+nAgentID;  

        }
	}); 
}