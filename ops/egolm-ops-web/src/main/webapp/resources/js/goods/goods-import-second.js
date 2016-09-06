jQuery(function($) {
	var footable = null,
	$row = null,
 	isAll2 = false, //true为全选，false为未选中--第二步
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
	
	loadSenondMsg(); 
	//加载分类
	loadCategoryTree("category-menu-name","sCategoryNO");
	//加载品牌
	loadBrandMsg();
	
	 
	
	$("#query").on('click',function(){  //查询
		loadSenondMsg();
	});
	
	
	$('.next-step').on('click',function(){ //下一步
		var tGoods_second_id = ""; 
		
		$('.select_goods_check').each(function(){  
			if($(this).attr('checked')  == 'checked') {
				tGoods_second_id += $(this).val()+',';
			}
		});
		
		if(tGoods_second_id == ''){ 
			Ego.error("至少需要选择一个商品",null);
			return false;
		}
	 	var sAgentContractNO = $("#sAgentContractNO").val();
		window.location.href=webHost+"/goods/tGoodsDealer/importThird?sGoodIds="+tGoods_second_id+"&sAgentContractNO="+sAgentContractNO;
	});
	
 

	 $('.all_select_goods_check').on('click', function() { //全选/取消全选------ 第二步 
		Checked.selectAll(this, isAll2);
		$('.table-step2 .checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll2);
		});
		isAll2 = !isAll2;
	});  
	
	$('.table-step2 .checked-wrap input').each(function(index) { 
		Checked.selectAll(this, isAll2); 
	});
	
	

	
	///----------------------弹窗部分--------------------------------
	//显示资料库
	$('#showGoodsMsg_id').on('click',function(){
		$(document).keypress(function(e) {    //回车查询
		    // 回车键事件  
	         if(e.which == 13) {
	    	    window.event.returnValue = false;
	         }  
		 }); 
		
		 loadGoodsMsg(1); //加载商品数据
	     loadRedisMsg(); //加载缓存数据 
	     $('.result-box  .chk').each(function(index) {  //将右边框中的复选框 设为全选中
				Checked.selectAll($(this));
		 });
			
	 	//加载分类
	    $("#goods-sort-menu").html("");
	    $("#sCategoryNO-select").val("");
	 	$("#goods-sort-id").find("span").eq(0).text("请选择"); 
	 	loadCategoryTree("goods-sort-menu","sCategoryNO-select");
		$('#database').modal('show');  //显示弹出框  
		
	 
		$('.result-box .batch .chk').on('click', function() { //全选/取消全选 ------ 已选商品列表
 			$('.result-box .chk').each(function(index) {
				Checked.selectAll(this, isAll5);
			}); 
			isAll5 = !isAll5;
		}); 
		
		$('.result-box .checked-wrap .chk').off().on('click', function() { //单个选 
			 Checked.checked($(this));
			 if($('.result-box .checked-wrap .chk').filter('[checked=checked]').length == $('.result-box .checked-wrap .chk').length) {
					 $('.result-box .batch .chk').attr('checked',true);
					 $('.result-box .batch .chk').parents('label:first').addClass('checked'); 
			}else {
					$('.result-box .batch .chk').attr('checked',false);
				    $('.result-box .batch .chk').parents('label:first').removeClass('checked'); 
			}
		 }); 
		
		  
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
					 
				 $('.result-box .checked-wrap .chk').off().on('click', function() { //单个选
					 Checked.checked(this); 
					 if($('.result-box .checked-wrap .chk').filter('[checked=checked]').length == $('.result-box .checked-wrap .chk').length) {
							 $('.result-box .batch .chk').attr('checked',true);
							 $('.result-box .batch .chk').parents('label:first').addClass('checked'); 
					}else {
							$('.result-box .batch .chk').attr('checked',false);
						    $('.result-box .batch .chk').parents('label:first').removeClass('checked'); 
					}
			     });  
				 
			}
		});
		 loadGoodsMsg(1); 
		 
		
	});
	
	//还原选中的商品
	$('.btn-box .btn-remove').on('click',function(){ 
		$('.result-box table tbody input').each(function(index){

			var $this = $(this);
				checked = $this.attr('checked');
			if(!!checked){ 
				 var right_del_goodid = "";  //右侧删除的商品
				$("#selected-goods-id").find('tr').each(function(){
					if($(this).find("#nGoodsID").attr('checked') == 'checked'){
						right_del_goodid =$(this).find("#nGoodsID").attr("value")+","; 
						
						var old_del_goodid = $("#right_del_goodid").val();
						$("#right_del_goodid").val(old_del_goodid+right_del_goodid);
					}				
					 
				});  
				
				var $row = $this.parents('tr:first').clone();
				$this.parents('tr:first').remove();
				loadGoodsMsg(1);
			}
		});
		
	});
	
	$('.btn-wrap .btn-submit').on('click',function(){   //确认选中的商品
		var selecGoods = [];
		$('.result-box table tbody input').each(function(index){ 
				var $this = $(this);
				var checked=$this.attr('checked');
				if(checked=='checked'){ 
					selecGoods.push($this.attr('value')); 
			     }
		}); 
		console.log("====点了确认选中的商品====");
		$('#database').modal('hide'); 
		var trLength = $("#selected-goods-id").find('tr').length; //确认框中商品的个数  ，如为0，则清除缓存
			 
		selectGoods(selecGoods,trLength);
	});
	
	
	$('.modal  .modal-dialog .btn-wrap').on('click',function(){   //弹框后的查询 
	     loadGoodsMsg(1); //加载商品数据
	});
	
});

//加载第二步的数据
function loadSenondMsg(){ 
	var sOrgNO= $("#sOrgNO").val();
	var sAgentContractNO = $("#sAgentContractNO").val();
    var sGoodsDescOrBarcode = $("#sGoodsDescOrBarcode").val();
    var sCategoryNO = $("#sCategoryNO").val();
    var sBrand = $("#sBrand").val();
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/goods/tGoodsDealer/loadSecondMsg',
        data:'sAgentContractNO='+sAgentContractNO+'&sGoodsDescOrBarcode='+sGoodsDescOrBarcode+'&sCategoryNO='+sCategoryNO+'&sBrand='+sBrand,
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {  
        	 var dataResult = eval("(" + data + ")"); 
         	var isValid = dataResult.IsValid;
         
         	 if(isValid){ 
        		var dataList = dataResult.DataList.tGoodsList ;  
        		var cdnImgUrl=dataResult.DataList.cdnImgUrl;
 
        		if(dataList.length>0){ 
					 var secondMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var goods = dataList[i]; 
						 
						 secondMsg+="<tr>";
						 secondMsg+="	<td>";
						 secondMsg+="		<label class='checked-wrap'>";
						 secondMsg+="			<input type='checkbox' class='chk select_goods_check' id='tGoods_second_id' name='tGoods_second_id' value='"+goods.nGoodsID+"' />";
						 secondMsg+="			<span class='chk-bg'></span>";
						 secondMsg+="		</label>";
						 secondMsg+="	</td>";
						 secondMsg+="	<td>";
						 secondMsg+="		<div class='good-info clearfix'>";
						 secondMsg+="			<img class='pull-left' src='"+cdnImgUrl+""+goods.sURL+"@77w_76h' width='77' height='76' />";
						 secondMsg+="			<p>"+goods.nGoodsID+"</p>";
						 secondMsg+="			<p>"+goods.sGoodsDesc+"</p>";
						 secondMsg+="			<p>"+goods.sMainBarcode +"</p>";
						 secondMsg+="		</div>";
						 secondMsg+="	</td>";
						 secondMsg+="	<td>"+goods.nShelfLife +"天</td>";
						 secondMsg+="	<td>"+goods.sSpec +"</td>";
						 secondMsg+="	<td>￥"+goods.nNormalSalePrice+"</td>";
						 secondMsg+="	<td>"+goods.nCaseUnits+"/箱</td>";
						 secondMsg+="	</tr> ";
					 } 
					 $("#secondMsgId").html(secondMsg); 
					 
					 $('.select_goods_check').off().on('click', function() { //单个选中/取消选中 
 						Checked.checked(this);
						 if($('.select_goods_check').filter('[checked=checked]').length == $('.select_goods_check').length) {
							$('.all_select_goods_check').attr('checked',true);
							$('.all_select_goods_check').parents('label:first').addClass('checked');
						}else {
							$('.all_select_goods_check').attr('checked',false);
							$('.all_select_goods_check').parents('label:first').removeClass('checked');
						} 
					});
					
					$('.all_select_goods_check').off().on('click', function() { //全选/取消全选 
 						Checked.checked(this);
						$('.table-step2 .checked-wrap input').each(function(index) {
							Checked.checked(this);
						});
 					}); 
					 
					 if($('.select_goods_check').length >0){
						 $('.all_select_goods_check').attr('checked',true);
						 $('.all_select_goods_check').parents('label:first').addClass('checked');
						 $("input[name='tGoods_second_id']").each(function(){ 
							 $(this).attr('checked',true);
							 $(this).parents('label:first').addClass('checked');
						 }); 
					 }
					
					 $("#second-next-id").show(); //显示第二步
				 }else{
					 var noMsg = "<tr ><td colspan='6'>暂无商品</td></tr>";
					 $("#secondMsgId").html(noMsg);
					  $('.all_select_goods_check').attr('checked',false);
					  $('.all_select_goods_check').parents('label:first').removeClass('checked');
				 }
        	}else{
        		var returnValue=  dataResult.ReturnValue;
        		Ego.error(returnValue,null);
        	} 
        }
    }); 
}



/**
 * 加载资料库中的数据
 * @param index
 */
function loadGoodsMsg(index){ 
  var goodsNameOrBarCode = $("#goodsNameOrBarCode").val();
  var sCategoryNO = $("#sCategoryNO-select").val();
  var sAgentContractNO = $("#sAgentContractNO").val();
  
   var select_goods = ""; // 右侧框中已选择的商品 
	$("#selected-goods-id").find('tr').each(function(){  
		select_goods += ""+$(this).find("#nGoodsID").attr("value")+",";  
	});
	if(select_goods != ''){
		select_goods = select_goods.substring(0,select_goods.length-1);
	} 
	var right_del_goodid = $("#right_del_goodid").val();  //已删除的商品
	 
	if(right_del_goodid != ''){
		right_del_goodid= right_del_goodid.substring(0,right_del_goodid.length-1);
	}
	
	
	$.ajax({
      cache: false,
      type: "POST",
      url:webHost+'/goods/tGoodsDealer/listGoods',
      data:'goodsNameOrBarCode='+goodsNameOrBarCode+"&sCategoryNO="+sCategoryNO+"&sAgentContractNO="+sAgentContractNO+"&page.index="+index+"&select_goods="+select_goods+"&del_goods="+right_del_goodid,
      async: false,
      error: function(request) {
    	  Ego.error("系统连接异常,请刷新后重试.",null);
      },
      success: function(data) {  
      	 var dataResult = eval("(" + data + ")"); 
       	var isValid = dataResult.IsValid; 
       	$('.select-box-all-check').attr('checked',false);
       	 if(isValid){
       		  var cdnImgUrl = dataResult.cdnImgUrl;
      		  var dataList = dataResult.DataList ;   
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
						 goodsMsg+="			<img class='pull-left' src='"+cdnImgUrl+""+data.sURL+"@77w_76h' width='77' height='76'>";
						 goodsMsg+="			<p>"+data.nGoodsID+"</p>";
						 goodsMsg+="			<p>"+data.sGoodsDesc+"</p>";
						 goodsMsg+="			<p class='nb'>"+data.sMainBarcode+"</p>";
						 goodsMsg+="		</div>";
						 goodsMsg+="	</td>";
						 goodsMsg+="	<td>"+data.sSpec+"</td>";
						 goodsMsg+="	<td>"+data.nCaseUnits+"/"+data.sUnit+"</td>";
						 goodsMsg+="</tr>";
					 }
					 $("#show-goods-Id").html(goodsMsg);	
					 
					 $('.select-box .batch .chk').off().on('click', function() { //全选/取消 选中 
						 
 						     Checked.checked(this);
 						     var $this = $(this);
							$('.select-box .checked-wrap .chk').each(function(index) { 
								Checked.selectAll(this, !$this.attr('checked')); 
							}); 
					 });
					 $('.select-box .checked-wrap .chk').off().on('click', function() { //单个选
 						 Checked.checked(this); 
						 if($('.checked-wrap .chk').filter('[checked=checked]').length == $('.checked-wrap .chk').length) {
 							 $('.select-box .batch .chk').attr('checked',true);
								$('.select-box .batch .chk').parents('label:first').addClass('checked'); 
							}else {
 								$('.select-box .batch .chk').attr('checked',false);
								$('.select-box .batch .chk').parents('label:first').removeClass('checked'); 
							}
					 }); 
					 
					 if($('.select-box .checked-wrap .chk').length >0){
						 $('.select-box .batch .chk').attr('checked',true);
						 $('.select-box .batch .chk').parents('label:first').addClass('checked');
						 $("input[name='nGoodsID']").each(function(){ 
							 $(this).attr('checked',true);
							 $(this).parents('label:first').addClass('checked');
						 }); 
					 }
				
				 }else{ 
					 var noMsg = "<tr ><td colspan='4' align='center'>暂无商品</td></tr>"; 
					 $("#show-goods-Id").html(noMsg); 
					 $('.select-box .batch .chk').attr('checked',false);
					 $('.select-box .batch .chk').parents('label:first').removeClass('checked'); 
				 } 
      	}else{
      		var returnValue=  dataResult.ReturnValue;
      		Ego.error(returnValue,null);
      	}
       //设置分页  
       //设置分页 
       	var pageHtml = ajaxPager.render(dataResult.page, function(page) {
        	 loadGoodsMsg(page.index);
		});
       	$('div').remove('.navigation_bar');
		$('.select-box .batch').append(pageHtml);
			
      } 
  }); 
}

//加载缓存中的数据
function loadRedisMsg(){
  var goodsNameOrBarCode = $("#goodsNameOrBarCode").val();
  var sCategoryNO = $("#sCategoryNO").val();
  var sAgentContractNO = $("#sAgentContractNO").val();

	$.ajax({
      cache: false,
      type: "POST",
      url:webHost+'/goods/tGoodsDealer/loadRedisMsg',
      data:'goodsNameOrBarCode='+goodsNameOrBarCode+"&sCategoryNO="+sCategoryNO+"&sAgentContractNO="+sAgentContractNO,
      async: false,
      error: function(request) {
    	  Ego.error("系统连接异常,请刷新后重试.",null);
      },
      success: function(data) {  
      	 var dataResult = eval("(" + data + ")");
       
       	var isValid = dataResult.IsValid;
       
       	 if(isValid){
      		var dataList = dataResult.DataList ;  
      		var cdnImgUrl = dataResult.cdnImgUrl;
      		if(dataList.length>0){ 
					 var goodsMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var goods = dataList[i]; 
						 goodsMsg+="<tr>";
						 goodsMsg+="	<td>";
						 goodsMsg+="		<label class='checked-wrap'>";
						 goodsMsg+="			<input type='checkbox' class='chk' name='nGoodsID' id='nGoodsID' value='"+goods.nGoodsID+"' />";
						 goodsMsg+="			<span class='chk-bg'></span>";
						 goodsMsg+="		</label>";
						 goodsMsg+="	</td>";
						 goodsMsg+="	<td>";
						 goodsMsg+="		<div class='g-info clearfix'>";
						 goodsMsg+="			<img class='pull-left' src='"+cdnImgUrl+""+goods.sURL+"@77w_76h' width='77' height='76'>";
						 goodsMsg+="			<p>"+goods.nGoodsID+"</p>";
						 goodsMsg+="			<p>"+goods.sGoodsDesc+"</p>";
						 goodsMsg+="			<p class='nb'>"+goods.sMainBarcode+"</p>";
						 goodsMsg+="		</div>";
						 goodsMsg+="	</td>";
						 goodsMsg+="	<td>"+goods.sSpec+"</td>";
						 goodsMsg+="	<td>"+goods.nCaseUnits+"/"+goods.sUnit+"</td>";
						 goodsMsg+="</tr>";
					 }
					 $("#selected-goods-id").html(goodsMsg);
					/* $('.result-box   .chk').on('click', function() { //选中/取消选中    
							Checked.checked(this);
					 });
					 $("input[name='nGoodsID']").off().on('click', function() { //单个选
						 console.log("右侧的单个选择。。。");
						 Checked.checked(this);
					 });*/
				 }else{
					 $("#selected-goods-id").html("");
				 }
      	}else{
      		var returnValue=  dataResult.ReturnValue;
      		Ego.error(returnValue,null);
      	} 
      }
  }); 
}


/**加载品牌数据***/
function loadBrandMsg(){
	   $.ajax({
			type:'POST',
			url:webHost+'/goods/brand/list',
			dataType:"json",
			cache: false,
			error: function(request) {
		    	  Ego.error("系统连接异常,请刷新后重试.",null);
		    },
			success: function (data) {
				 var isValid = data.IsValid;
				 if(isValid){
					 var dataList = data.DataList ;  
		         		if(dataList.length>0){ 
							 var brandMsg="<li value=''>全部</li>";
							 for(var i = 0;i<dataList.length;i++){
								 var data = dataList[i];
								 brandMsg+="<li value='"+data.sBrandID+"'>"+data.sBrandName+"</li> "; 
							 }
							 $("#brand-name").html(brandMsg); 
							 $("#brand-name li").click(function(){ 
								 var litext = $(this).text();
								 var livalue =  $(this).attr("value");  
								 $("#brand-id").find("span").eq(0).text(litext);
								 $("#sBrand").val(livalue); 
							 });
						 } 
				 }else{
					 var returnValue = data.ReturnValue;
					 Ego.error(returnValue,null);
				 }
			} 
		});
}
function selectGoods(tGoodsIds,trLength){
	var sAgentContractNO = $("#sAgentContractNO").val(); 
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/goods/tGoodsDealer/selectGoods',
        data:'tGoods_ids='+tGoodsIds+'&sAgentContractNO='+sAgentContractNO+'&trLength='+trLength,
         async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {
			 window.location.href=webHost+"/goods/tGoodsDealer/importSecond?sAgentContractNO="+sAgentContractNO;   
        }
	}); 
}