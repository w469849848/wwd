jQuery(function($) {
	
	var isAll = false, //是否全选
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;
	
	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});
	
	$('.batch .chk').on('click', function() { //全选/取消全选
		$('input[name="orderid-chk"]').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	 
	
	//单选组
	$('input[name=order-status]').on('click',function(){
		$('input[name=order-status]').attr('checked',false);
		$(this).attr('checked',true); 
	});
	
	
	
	$('.batch .border').on('click',function(){   //点击批量标记和批量导出按钮
		var   operate =  $(this).attr("pid") ;
		var subOrderid = "";
		var orderStatusArray = [];  
		$('input[name="orderid-chk"]').each(function(index){ 
			var $this = $(this);
			var checked=$this.attr('checked');  
			if(checked=='checked'){
				var orderid = $this.attr('value');  //订单号
				subOrderid +="'"+orderid+"',"; 
				var orderStatus = $("#orderStatus_"+orderid).val();  //订单状态 
				orderStatusArray.push(orderStatus);
		     } 
		});  
		 
		if(operate =='marked' ){ // 批量标记 
			if(subOrderid ==''){
		    	 Ego.error("请选择需要操作的订单",null);
				return false;
			}
			subOrderid = subOrderid.substring(0,subOrderid.length-1);
		    $("#subOrderid").val(subOrderid);
			
			
			$('.order-status-radio').show();  //显示单选按钮组
			
 			var result = isRepeat(orderStatusArray);   //去除重复数据
 			if(result.length>1){ //表明所选择的数据的状态不一致，意味着不能进行状态变更
				$("#orderStatusResult").val("yes");//设置上值为 重复 
		    	 Ego.error("当前选中的订单状态不一致,无法批量更新状态!",null);
			}else{
				var status = result[0];
				$("#orderStatusResult").val("no");//设置上值为 未重复  ,允许状态变更
				$("#orderStatus").val(status); 
				
				if((status & 16) == 16){ //订单完成状态 
			    	 Ego.error("当前选中的订单已完成",null);
				}else if((status & 3) == 3 || (status & 7) == 7){ 
			    	 Ego.error("当前选中的订单已取消",null);
				}else{ 
					if((status & 128) == 128){ //配送中 
						$("#status8").hide();
						$("#status1").hide();
						$("#status16").show();
					}else if((status & 2) == 2){ //订单提交
						$("#status8").show();
						$("#status1").show();
						$("#status16").hide();
					}
					$('#editAd').modal('show');
				}
			} 
		}
		 if(operate == 'export'){  //批量导出 
		    if(subOrderid !=''){
		    	subOrderid = subOrderid.substring(0,subOrderid.length-1); 
			    $("#subOrderid").val(subOrderid);
			} 
		    exportExcel();
		 }
	});
	
	$(document).on('click', '#submit', function(e) { //保存编辑 
		  updateOrderStatus();
	});
	
	$("#query").on('click',function(){ //查询 
		$("#page_index").val("1");
		$("#limitPageForm").submit();
	});
	
	//订单状态
	var nOrderStatus_q = $("#nOrderStatus").val();
	if(nOrderStatus_q != ''){
		 $("#order-status-memu").find("li").each(function(){
			  if($(this).attr("value")==nOrderStatus_q){
				  $("#order-status-id").find("span").eq(0).text($(this).text());
			  }
		 }); 
	}
	 $("#order-status-memu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#order-status-id").find("span").eq(0).text(litext);
		 $("#nOrderStatus").val(livalue); 
		  
	 });
	 
	 //区域
	 loadTOrgs("sOrgNo-memu","4");
	 var sOrgNO_q = $("#sOrgNO").val();
		if(sOrgNO_q != ''){
		    $("#sOrgNo-memu").find("li").each(function(){
			  if($(this).attr("value")==sOrgNO_q){
				  $("#sOrgNo-id").find("span").eq(0).text($(this).text());
			  }
		 }); 
	 }
	
	 $("#sOrgNo-memu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sOrgNo-id").find("span").eq(0).text(litext);
		 $("#sOrgNO").val(livalue); 
	 });
});

/**
 * 更新订单状态
 */
function  updateOrderStatus(){
	var subOrderid = $("#subOrderid").val();
	var orderStatus =  "";
	  $('input[name="order-status"]').each(function(){
		  if($(this).attr("checked")=='checked'){
			  orderStatus = this.value;
		  }
	 });
	  if(orderStatus == ''){ 
    	 Ego.error("请选择需要更新的状态",null);
		  return false;
	  }
 
	  $.ajax({
	        cache: false, 
	        type: "POST",
	        dataType: "json",
	        url:'updateOrderStatus',
	        data: 'subOrderid='+subOrderid+'&orderStatus='+orderStatus,  
	        async: false,
	        error: function(request,errorThrown) {
	        	Ego.error("系统连接异常,请刷新后重试.",null);
	        },
	        success: function(data) {
	        	var isValid = data.IsValid;
	        	var returnValue = data.ReturnValue;	       	 	 
 	    		if(isValid) {
	    			Ego.success(returnValue, function(){
	    				$("#limitPageForm").submit();
	    			});
	    		}else {
	    			Ego.error(returnValue,null);
	    		}
	        }
	    });  
}


function  exportExcel(){
	var subOrderid = $("#subOrderid").val(); //复选框选中的订单  
	 
	var orderQueryMsg = $("#orderQueryMsg").val();
	var sSalesOrderTypeID = $("#sSalesOrderTypeID").val();
	var sOrgNO = $("#sOrgNO").val();
	 window.location.href=webHost+"/order/tSalesOrderSub/exportExcel?orderQueryMsg="+orderQueryMsg+"&sSalesOrderTypeID="+sSalesOrderTypeID+"&sOrgNO="+sOrgNO+"&subOrderid="+subOrderid;
}


//去除重复数据
function isRepeat(arr) {
	    var result = [], hash = {};
	    for (var i = 0, elem; (elem = arr[i]) != null; i++) {
	        if (!hash[elem]) {
	            result.push(elem);
	            hash[elem] = true;
	        }
	    }
	    return result;
}