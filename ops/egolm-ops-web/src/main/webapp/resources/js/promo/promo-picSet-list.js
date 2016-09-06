jQuery(function($) { 
	 $(".show").click(function(){
 		 var nId = $(this).attr('pid');
 		 var displayNo = $(this).attr('pDisplay');
 		 window.open("showIndex?nId="+nId+"&displayNo="+displayNo);
	 });
	 $(".edit").click(function(){
 		 var nId = $(this).attr('pid'); 
 		window.location.href = "loadIndex?nId="+nId;
	 });
	 
	 $(".delete").click(function(){
 		 var nId = $(this).attr('pid'); 
 		deletePic(nId);
	 });
	 
	 $("#query").click(function(){ 
		 $("#page_index").val(1);
		 $("#limitPageForm").submit();
	 });
	 
	//区域
	loadTOrgs("sOrgNO-menu","4");
	var sOrgNO_u = $("#sOrgNO").val();
	 if(sOrgNO_u != ''){  //编辑时
		 var sOrgDesc_u = $("#sOrgDesc").val();
		  
			$("#sOrgNO-id").find("span").eq(0).text(sOrgDesc_u); 
			 
	  }
	$("#sOrgNO-menu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sOrgNO-id").find("span").eq(0).text(litext);
		 $("#sOrgNO").val(livalue);
		 $("#sOrgDesc").val(litext); 
	 });
	
	//使用范围
	var sDisplayNO_u = $("#sDisplayNO").val();
	 if(sDisplayNO_u != ''){  //编辑时
		 var sDisplayDesc_u = $("#sDisplayDesc").val();
			$("#sDisplayNO-id").find("span").eq(0).text(sDisplayDesc_u); 
			 
	 }
	$("#sDisplayNO-menu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sDisplayNO-id").find("span").eq(0).text(litext);
		 $("#sDisplayNO").val(livalue);
		 $("#sDisplayDesc").val(litext); 
	 });
	
	$(".pull-left").mouseover(function(){ 
		   $(this).parent().find("#adPicImg").css('display','block');
	 }).mouseout(function(){
		  $(this).parent().find("#adPicImg").css('display','none');
    }); 
	 $(document).keypress(function(e) {    //回车查询
		    // 回车键事件  
	       if(e.which == 13) {  
	    	   e.preventDefault();  //禁掉回车
	       }  
	 }); 
}); 


function deletePic(nId){ 
	 
 	$.ajax({ 
        type: "GET",
        url:'delete',
        data: "nId="+nId,  
        async: false,
        error: function(request,errorThrown) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")"); 
        	console.log(dataResult);
        	var isValid = dataResult.IsValid;
        	var returnValue = dataResult.ReturnValue 
        	if(isValid){
        		layer.close(layerindex);
        		 Ego.success(returnValue,function(){
        			window.location.href = webHost + '/promoPicSet/list';
        		 });  
        	}else{
        		layer.close(layerindex);
        		Ego.error(returnValue,null);
        	}
        }
    }); 
}