jQuery(function($) {

	var footable = null,
		$row = null,
		isAll = false, //true为全选，false为未选中
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	$('.advertisement table').footable({ //响应式表格初始化
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

	$('td a.edit').on('click', function(e) { //编辑
		e.stopPropagation();
		footable = $(this).parents('table:first').data('footable');
		$row = $(this).parents('tr:first');
		$('#editAd').modal('show');
		$("#alert-adId").val($(this).attr("pid"));
		$("#alert-adTitle").val($(this).attr("pName"));
	});

	$(document).on('click', '#submit', function(e) { //保存编辑
		if(auditAdMsgByAdId()){
			footable.removeRow($row);
			footable = null;
			$row = null;
		}
		$('#editAd').modal('hide');
		$('#successAlert').modal('show');
		//异步代码 
		 
		
	});

	$('td a.delete').on('click', function(e) { //删除弹窗
		e.stopPropagation();
		footable = $(this).parents('table:first').data('footable');
		$row = $(this).parents('tr:first');
		$('#deleteAlert').modal('show');
	});

	$('#btn-confirm').on('click', function() { //确认删除
		
		//异步代码
		
		if (true) { //删除成功
			$('#deleteAlert').modal('hide');
			footable.removeRow($row);
			footable = null;
			$row = null;
		}
	});

	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});

	$('.batch .chk').on('click', function() { //全选/取消全选
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	

	//广告位置
	 $("#adv-position-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 console.log("广告位置=="+livalue);
		 $("#adv-position-id").find("span").eq(0).text(litext);
		 $("#sApSaleTypeID").val(livalue);
		 loadApByApSaleType(livalue);
	 });
	 
	 
	 $(document).keypress(function(e) {  
		    // 回车键事件  
	       if(e.which == 13) {  
	    	  var sAdTitle  = $("#sAdTitle").val(); 
	    	  var sApSaleTypeID = $("#sApSaleTypeID").val();
	    	  var nApID= $("#nApID").val();
	    	  window.location.href="waitAuditlist?sAdTitle="+sAdTitle+"&nApID="+nApID+"&sApSaleTypeID="+sApSaleTypeID;
	       }  
	  }); 
	 
	 
	 jQuery("#show-pic-id").mouseover(function(){
		    jQuery("#adPicImg").css('display','block');
	 }).mouseout(function(){
			jQuery("#adPicImg").css('display','none');
     }); 
	 
});

/**
 * 广告审核
 */
function auditAdMsgByAdId(){
	var adId = $("#alert-adId").val();
	var nTag = $("#alert-ntag").val();
	var sMemo = $("#alert-sMemo").val();
	var isValid = false;
	$.ajax({
	      cache: false,
	      type: "POST",
	      url:'auditTShopAdvert',
	      data:'id='+adId+'&nTag='+nTag+'&sMemo='+sMemo,
	      async: false,
	      error: function(request) {
	          alert("Connection error");
	      },
	      success: function(data) {
	    	  var dataResult = eval("(" + data + ")");  
	      	  isValid = dataResult.IsValid; 
	      	  var returnValue = dataResult.ReturnValue; 
	      	  $("#alert-audit-msg").text(returnValue);
	      }
	  }); 
	return isValid;
}

//根据广告位置获取广告位
function loadApByApSaleType(sApSaleTypeID){
	$.ajax({
      cache: false,
      type: "POST",
      url:'../advert/adPos/loadMsgByApSaleType?sApSaleTypeID='+sApSaleTypeID,
      data:'',
      async: false,
      error: function(request) {
          alert("Connection error");
      },
      success: function(data) {
      	var dataResult = eval("(" + data + ")"); 
      	var isValid = dataResult.IsValid;
      	
      	if(isValid){
      		var dataList = dataResult.DataList;
      		console.log(dataList);
      		if(dataList.length>0){ 
					 var apMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 apMsg+="<li value='"+data.nApID+"' nContractID='"+data.nContractID+"' >"+data.sApTitle+"</li> "; 
					 }
					 $("#adv-name-menu").html(apMsg);
					 //广告位
					 $("#adv-name-menu li").click(function(){
						 var litext = $(this).text(); 
						 var livalue =  $(this).attr("value"); 
						 var nContractID =  $(this).attr("nContractID"); 
						 $("#adv-name-id").find("span").eq(0).text(litext);
						 $("#nApID").val(livalue);  
					 });
			 }
        }else{
      		var returnValue = dataResult.ReturnValue 
      		$("#check-msg").text(returnValue)
      		$('#successAlert').modal('show');  
      	}
      }
  }); 
}