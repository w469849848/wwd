jQuery(function($) {

	var footable = null,
		$row = null,
		isAll = false, //true为全选，false为未选中
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	$('.activity table').footable({ //响应式表格初始化
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

	$('td a.delete').on('click', function(e) { //显示删除弹窗 
		var activityId = $(this).attr("pid");
		Ego.alert("是否确认删除活动？",function(){  
			deletePromo(activityId);
		});
		
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
	
	$('.batch .border-radius').on('click',function(){  //批量审核，批量下线 
		 var pid = $(this).attr("pid"); //点击的操作
		 var tmpId = "";
		 $('input[name="tmpPromoId"]').each(function(){ 
			 var check=$(this).attr('checked');
			 if(check=="checked"){
				 console.log($(this).val());
					tmpId += $(this).val()+',';
			 }
				
		 });
		 if(tmpId == ''){  
			 Ego.error("请选择需要操作的数据",null);
			 return false;
		 }
		 if(pid == 'pass'){
			 auditPromo(tmpId,2);
		 }else if(pid == 'stop'){
			 auditPromo(tmpId,4);
		 }else{ 
			 Ego.error("操作失败,未获取到操作方式",null);
			 return false;
		 }
		 
	});
	
	
	//区域
	 loadTOrgs("area-menu","4");
	 $("#area-menu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#area-id").find("span").eq(0).text(litext);
		 $("#zoneCode").val(livalue); 
	 });

});
//审核活动
function auditPromo(tmpId,nTag){
	$.ajax({
	      cache: false,
	      type: "POST",
	      url:'auditPromo',
	      data:'id='+tmpId+"&nTag="+nTag,
	      async: false,
	      error: function(request) {
	    	  Ego.error("系统连接异常,请刷新后重试.",null);
	      },
	      success: function(data) {
	      	    var dataResult = eval("(" + data + ")");
 	       	    var isValid = dataResult.IsValid;  
	       	    var returnValue = dataResult.ReturnValue ;
	       	  
		       	if(isValid){
		      	   Ego.success(returnValue,function(){
		      		 window.location.href = webHost + '/tmpPromo/list';
		      	   }); 
		       	}else{
		            Ego.error(returnValue,null);
		        }  
	      }
	}); 
}



//删除活动
function deletePromo(activityId){ 
	 
	$.ajax({
	      cache: false,
	      type: "POST",
	      url:'delete',
	      data:'id='+activityId,
	      async: false,
	      error: function(request) {
	    	  Ego.error("系统连接异常,请刷新后重试.",null);
	      },
	      success: function(data) {
	      	 var dataResult = eval("(" + data + ")"); 
	         var   isValid = dataResult.IsValid;   
	       	 var returnValue = dataResult.ReturnValue;
	       	  if(isValid){
	      	     Ego.success(returnValue,function(){
	      		   window.location.href = webHost + '/tmpPromo/list';
	      	     }); 
		      }else{
		            Ego.error(returnValue,null);
		      } 
	      }
   });  
}