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

  
	$('td a.call').on('click', function(e) { //调用代码
		e.stopPropagation(); 
		var nApID = $(this).attr("pid");
		var zoneCode = $(this).attr("pZoneCode");
 		Ego.dialog("/shop/loadAdvertMsg?nApID="+nApID+"&sZoneCode="+zoneCode+"",200,null);
	});

 	$('td a.delete').on('click', function() { //删除弹窗  
 		var adPosId = $(this).attr("pid"); //广告位ID
 		var apStatus = $(this).attr("pStatus"); //广告位状态
 		
 		if(apStatus == 1){
 			Ego.error("所选广告位已启用,不允许删除.",null);
 		}else{
 			Ego.alert("删除广告位,会同步删除对应的广告,是否确认删除？",function(){ 
				deleteAdPos(adPosId);  
 			});
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
	
	$("#pos-export").on('click',function(){  //批量导出
		$('input[name="nApId-chk"]:checked').each(function(){ 
		});
	});
	
	 $("#query").on('click',function(){  //查询
		 $("#page_index").val(1);
		 $("#limitPageForm").submit();
	 });
	
	//添加区域  
	 loadTOrgsAndAll("ap-zoneCode-menu","4","loadAll");
	 var sApZoneCode_u = $("#sZoneCodeID").val();
	 if(sApZoneCode_u != ''){  //查询返回后 
		  $("#ap-zoneCode-menu").find("li").each(function(){
			  if($(this).attr("value")==sApZoneCode_u){
				  $("#ap-zoneCode-id").find("span").eq(0).text($(this).text());
			  }
		 }); 
	 }
	 $("#ap-zoneCode-menu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value");  
		 $("#ap-zoneCode-id").find("span").eq(0).text(litext);
		 $("#sZoneCodeID").val(livalue); 
	 });
	 
	 //广告位类型 
	 loadCommonMsg("ap-position-menu","sApSaleType");
	 $("#ap-position-menu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#ap-position-id").find("span").eq(0).text(litext);
		 $("#sApSaleTypeID").val(livalue); 
	 });
	 
	 var sApSaleTypeID_u = $("#sApSaleTypeID").val();
	 if(sApSaleTypeID_u != ''){  //查询返回后  
		  $("#ap-position-menu").find("li").each(function(){
			  if($(this).attr("value")==sApSaleTypeID_u){
				  $("#ap-position-id").find("span").eq(0).text($(this).text());
			  }
		 }); 
	 }
	 
	 $(document).keypress(function(e) {    //回车查询
		    // 回车键事件  
	       if(e.which == 13) {  
	    	   e.preventDefault();  //禁掉回车
	       }  
	 }); 
	 
});

 
 


//删除广告位
function deleteAdPos(adPosId){ 
	 
	$.ajax({
        cache: false,
        type: "POST",
        url:'delete',
        data:'id='+adPosId,
        async: false,
        error: function(request) {
        	Ego.error("系统异常,请刷新后重试.",null);
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")"); 
         	var  isValid = dataResult.IsValid;  
         	  var returnValue = dataResult.ReturnValue;
         	  if(isValid){
         			Ego.success(returnValue,function(){
            			window.location.href = webHost + '/media/mediaPos/list';
            		}); 
         	  }else{
         		 Ego.error(returnValue,null);
         	  } 
        }
    });  
}