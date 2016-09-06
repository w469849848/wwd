jQuery(function($) {

	var isAll = false, //是否全选
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null,
		footable = null;

	$('.putaway table').footable({ //响应式表格初始化
		debug: true,
		breakpoints: {
			phone: 480,
			tablet: 991
		},
		log: function(message, type) {
			$bgRow = $table.find('tbody tr').not('.footable-row-detail,.reject-elem');
			if (message == 'footable_initialized') {

				$bgRow.each(function(index) {

					if (index % 2 == 1) {
						$(this).css({
							'background': '#fbfbfb'
						});
					}
				});
			}
			if (message == 'footable_row_expanded' || message == 'footable_row_collapsed') {
				
				var isEdit = $('.btn-fail').attr('class').toLocaleLowerCase().indexOf('isedit') > -1 ? true : false; //是否正在编辑
				
				if( isEdit ){
					$('.footable-row-detail').hide();
				}
				
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

	$('table tbody .chk').on('click', function() { //选中/取消选中 
		var $this = $(this),
			$tr = $this.parents('tr:first'),
			isEdit = $('.btn-fail').attr('class').toLocaleLowerCase().indexOf('isedit') > -1 ? true : false; //是否正在编辑
			
		Checked.checked(this);
		
		if($this.attr('checked') != 'checked'){
			$tr.next('.reject-elem').remove();
			
			//去掉正在编辑的状态
			if( $('.reject-elem').length <= 0){ $('.btn-fail').removeClass('isedit'); }
		}else if( $this.attr('checked') == 'checked' && isEdit ){
			
			var $elem = '<tr class="reject-elem"><td colspan="10">驳回原因：<span class="border border-radius">由于<input type="text" />的原因，您的商品未能通过审核</span></td></tr>';
			$tr.after($elem);
			
		}

	});
	
	
	//批量通过
	$('.btn-pass').on('click',function(){
		var sPaperNO = $('#sPaperNO').val(); 
		var goodsJson = {};
		var goodsArray = [];
		var isChecked = false;
		var nTagChecked = false;
		$('.putaway table tbody input[type=checkbox]').each(function(index) { 
			var $this = $(this),
				$tr = $this.parents('tr:first'); 
			
			var goodId = {};
			if ($this.attr('checked') == 'checked') {
				var nGoodId = $(this).attr("value");
				var nTag = $("#nTag"+nGoodId).val();
				if(nTag == 2){
					nTagChecked = true;
				}
				//$tr.remove(); //删除选中的行 
				goodId["nGoodId"]=nGoodId;
				goodId["errMsg"]="";
				goodsArray.push(goodId);
				isChecked= true;
			} 
		});
		if(isChecked){
			if(nTagChecked){
				Ego.error("选择的数据中存在已通过的商品,不允许重复批量通过.",null);
			}else{
				goodsJson["sPaperNO"]=sPaperNO;
				goodsJson["auditType"]="succ";
				goodsJson["tGoodsList"]=goodsArray; 
				
				auditMsg(JSON.stringify(goodsJson));
			}
			
		}else{ 
			Ego.error("请选择需要审核通过的数据.",null);
		}
		
	});
	

	//批量驳回
	$('.btn-fail').on('click',function(){
		
		var isEdit = $(this).attr('class').toLocaleLowerCase().indexOf('isedit') > -1 ? true : false, //是否正在编辑
			footable =  $table.data('footable');
 		$('.footable-row-detail').hide(); //隐藏表格下拉信息 
 		var isChecked = false;
		if(!isEdit){
			 
			$('.putaway table tbody input[type=checkbox]').each(function(index){ 
				var $this = $(this),
					$tr = $this.parents('tr:first'),
					footable = $(this).parents('table:first').data('footable');
				
				$tr.removeClass('footable-detail-show');
				
				if($this.attr('checked') == 'checked'){
					isChecked = true;
					var goodsId = $this.attr("value");
					var sMemo = $("#sMemo"+goodsId).val();
 					var $elem = "<tr class='reject-elem'><td colspan='11'>驳回原因：<span class='border border-radius'>由于<input type='text' name='errorMsg' id='errorMsg_"+goodsId+"' value='"+sMemo+"' />的原因，您的商品未能通过审核</span></td></tr>";

					$tr.after($elem);
					$('.btn-fail').addClass('isedit');
				}
			});
			 
			if(!isChecked){
				Ego.error("请选择需要驳回的商品.",null);
			}
			
		}else{
			var isEmpty = false; //输入信息是否有空
			
			$('.putaway table tbody input[type=text]').each(function(index){ 
				var $this = $(this); 
				if($this.val() == ''){ 
					$this.css('border','1px solid red');
					isEmpty = true;
					return false;
				}else{
					$this.css("border","none");
				}
			});
			
			if(!isEmpty){ //不为空，提交审核，删除选中的行
				var sPaperNO = $('#sPaperNO').val(); 
				var goodsJson = {};
				var goodsArray = [];
				
				var isChecked = false;
				var nTagChecked = false;
				$('.putaway table tbody input[type=checkbox]').each(function(index){
					if ($(this).attr('checked') == 'checked') {
						var goodId = {};
						var goodsID = $(this).attr("value");
						var errorMsg = $("#errorMsg_"+goodsID).val();
						
						var nTag = $("#nTag"+goodsID).val();
						if(nTag == 2){
							nTagChecked = true;
						}
						
 						goodId["nGoodId"]=goodsID;
						goodId["errMsg"]=errorMsg;
						goodsArray.push(goodId);
						isChecked= true;
					}
				});
				//后台代码--提交驳回
				if(isChecked){
					if(nTagChecked){
						Ego.error("已通过的商品不允许驳回.",null);
					}else{
						goodsJson["sPaperNO"]=sPaperNO;
						goodsJson["auditType"]="fail";
						goodsJson["tGoodsList"]=goodsArray;
 						auditMsg(JSON.stringify(goodsJson));
					} 
					
				}else{ 
					Ego.error("请选择需要驳回的数据.",null);
				}
				
				
			}
		}
	});

	$('.batch .chk').on('click', function() { //全选/取消全选 
		var _this = $(this),
			isEdit = $('.btn-fail').attr('class').toLocaleLowerCase().indexOf('isedit') > -1 ? true : false; //是否正在编辑
			
		Checked.checked(this);
		
		$('.checked-wrap input').each(function(index) { 
			var $this = $(this),
				$tr = $this.parents('tr:first');
			
			Checked.selectAll(this, !_this.attr('checked')); 
			if(isEdit){ //编辑状态下 
				if( _this.attr('checked') != 'checked' ){
					$('.reject-elem').remove();
					$('.btn-fail').removeClass('isedit');
				}else{
					var $elem = '<tr class="reject-elem"><td colspan="10">驳回原因：<span class="border border-radius">由于<input type="text" />的原因，您的商品未能通过审核</span></td></tr>';
					$('.reject-elem').next('.reject-elem').remove();
					$tr.after($elem);
				}
			}
			
		}); 
 		isAll = !isAll;
	});
	
	 
	 //加载数据
	loadDtlMsg(1);
	loadCategoryTree("category-memu","sCategoryNO");
	
	//加载品牌
	loadBrandMsg();  
	
	$("#query").on('click',function(){  //查询
		loadDtlMsg(1);
	});
	
});


//加载数据
function loadDtlMsg(index){ 
	 var sPaperNO = $('#sPaperNO').val(); 
	 var goodsNameOrMainBarCode  = $("#goodsNameOrMainBarCode").val();
	  var sCategoryNO = $("#sCategoryNO").val();
	  var sBrandID = $("#sBrandID").val();
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/dealer/acGoodsDtl/searchList',
        data:'sPaperNO='+sPaperNO+'&goodsNameOrMainBarCode='+goodsNameOrMainBarCode+'&sCategoryNO='+sCategoryNO+'&sBrandID='+sBrandID+"&page.index="+index+"&page.limit=10&page.limitKey=nGoodsID",
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {  
        	var dataResult = eval("(" + data + ")"); 
         	var isValid = dataResult.IsValid;
         	if(isValid){
        		var dataList = dataResult.DataList ; 
            	if(dataList.length>0){ 
					 var acGoodsDtlMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
 						 acGoodsDtlMsg+="<tr> "; 
						 acGoodsDtlMsg+="	<td> "; 
						 acGoodsDtlMsg+="		<label class='checked-wrap'> "; 
						 acGoodsDtlMsg+="			<input type='checkbox' class='chk  good-audit-detail-chk' name='nGoodsID' id='nGoodsID' value='"+data.nGoodsID+"'  /> "; 
						 acGoodsDtlMsg+="    		<input type='hidden'   id='nTag"+data.nGoodsID+"' value='"+data.nTag+"'  />  ";
						 acGoodsDtlMsg+="    		<input type='hidden'   id='sMemo"+data.nGoodsID+"' value='"+data.sMemo+"'  />  ";
						 acGoodsDtlMsg+="			<span class='chk-bg'></span> "; 
						 acGoodsDtlMsg+="		</label> "; 
						 acGoodsDtlMsg+="	</td> "; 
						 acGoodsDtlMsg+="	<td>"+data.sMainBarcode+"</td> "; 
						 acGoodsDtlMsg+="	<td>"+data.sGoodsDesc+"</td> "; 
						 acGoodsDtlMsg+="	<td>"+data.nSaleUnits+"</td> "; 
						 acGoodsDtlMsg+="	<td>"+data.nMinSaleQty+"</td> "; 
						 acGoodsDtlMsg+="	<td>¥"+data.nRealSalePrice+"</td> "; 
						 acGoodsDtlMsg+="	<td>"+data.sUnit+"</td> "; 
						 acGoodsDtlMsg+="	<td>"+data.sMemo+"</td> "; 
						 acGoodsDtlMsg+="	<td>"+data.goodsTagName+"</td> "; 
						 acGoodsDtlMsg+="	<td><span class='state reject'>";
						      if(data.nTag == 2){
						 acGoodsDtlMsg+="  	  <span class='state'><img src='"+webHost+"/resources/assets/images/circle.png'/></span>通过";
						      }
						      if(data.nTag == 8  ){
									 acGoodsDtlMsg+= "<img src='"+webHost+"/resources/assets/images/close.png'/></span>驳回";
							  } 
							  if(data.nTag == 0){
									 acGoodsDtlMsg+=	 "<img src='"+webHost+"/resources/assets/images/close.png'/></span>制单";
							  } 
						 acGoodsDtlMsg+=	 "</td> "; 
						 acGoodsDtlMsg+="</tr> "; 
					 }
					 $("#acGoodsDtlMsg").html(acGoodsDtlMsg); 
					 
					 
					  $("input[name='nGoodsID']").off().on('click', function() { //单个选
						 Checked.checked(this);
 						 if($('.good-audit-detail-chk').filter('[checked=checked]').length == $('.good-audit-detail-chk').length) {
								$('.all-chk').attr('checked',true);
								$('.all-chk').parents('label:first').addClass('checked');
								 
						 }else {
 							$('.all-chk').attr('checked',false);
							$('.all-chk').parents('label:first').removeClass('checked'); 
						 }
					 }); 
				 }else{
					 $("#acGoodsDtlMsg").html(''); 
				 }
        	}else{
        		var returnValue = data.ReturnValue;  
        		Ego.error(returnValue,null);
        	}
         	
         	//设置分页 
          	var pageHtml = ajaxPager.render(dataResult.page, function(page) {
          		loadDtlMsg(page.index);
			});
          	$('div').remove('.navigation_bar');
			$('tfoot .batch').append(pageHtml);
        }
    });
}

//审核 
function auditMsg(jsonStr){
 	$.ajax({
		cache: false,
		contentType: "application/json; charset=utf-8",  
        type: "POST",
        dataType: "json",
        url:'auditAcGoodsDtl',
        data: jsonStr,  
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {  
          	var returnValue = data.ReturnValue; 
          	var isValid = data.IsValid;
          	
          	if(isValid){
          		Ego.success(returnValue,function(){
        			$('.all-chk').attr('checked',false);
					$('.all-chk').parents('label:first').removeClass('checked'); 
					var sPaperNO = $("#sPaperNO").val();
					window.location.href=webHost+"/dealer/acGoodsDtl/toDtlPage?sPaperNO="+sPaperNO;
          		}); 
	        }else{
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
								 $("#sBrandID").val(livalue); 
							 });
						 } 
				 }else{
					 var returnValue = data.ReturnValue;
					 Ego.error(returnValue,null);
				 }
			} 
		});
}