jQuery(function($) {
	
	
	//版本类型
	 loadCommonMsg("sAppType-menu","AppType");
	 
	 var sAppTypeID_u = $("#sAppTypeID").val();
	 if(sAppTypeID_u != ''){
		 var sAppType_u = $("#sAppType").val();
		 $("#sAppType-id").find("span").eq(0).text(sAppType_u); 
	 }
	 
	 
	 $("#sAppType-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sAppType-id").find("span").eq(0).text(litext);
		 $("#sAppType").val(litext);
		 $("#sAppTypeID").val(livalue); 
	 });
	 
	 
	 $('td a.delete').on('click', function(e) { //删除弹窗 
			var nId = $(this).attr("pid");
			Ego.alert("是否确认删除版本信息？",function(){  
				deleteVersion(nId)
			}); 
	}); 
	 
	 $("#query").on('click',function(){  //查询 
		 $("#page.index").val(1);
		 
		 $("#limitPageForm").submit();
	 });
});


//删除广告
function deleteVersion(nId){ 
	$.ajax({
        cache: false,
        type: "POST",
        url:'delete',
        data:'nId='+nId,
        async: false,
        error: function(request) {
        	Ego.error("系统异常,请刷新后重试.",null);
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")");
       	     var returnValue = dataResult.ReturnValue;

        	var  isValid = dataResult.IsValid;  
        	  if(isValid){
     			  Ego.success(returnValue,function(){
        			window.location.href = webHost + '/system/appVersion/list';
        		  }); 
	     	  }else{
	     		 Ego.error(returnValue,null);
	     	  } 
        }
    });  
}
