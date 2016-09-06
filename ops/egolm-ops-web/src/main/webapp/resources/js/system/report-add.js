jQuery(function($) {

	$('#submit').on('click', function() { //保存编辑 
		//提交代码 
		if(check()){ //保存成功
			addReportForm(); 
		}
	}); 
	
	 var sReportTypeID_u = $("#sReportTypeID").val();
	 console.log(sReportTypeID_u);
	 if(sReportTypeID_u != ''){  //编辑时会有
		 console.log($("#sReportType").val());
		 $("#sReportType-id").find("span").eq(0).text($("#sReportType").val());
	 }
	 
	 
	$("#sReportType-menu li").click(function(){  // 
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sReportType-id").find("span").eq(0).text(litext);
		 $("#sReportTypeID").val(livalue); 
		 $("#sReportType").val(litext); 
	 });
	
	 
	//区域 
	 $("#cancel").click(function(){
			window.location.href="index";
	});
	  
});
 

function check(){ 
	if($("#sReportTypeID").val()==""){    
		Ego.error("请选择报表类型",null);
		$("#sReportTypeID").focus();
		return false;
	}
	
	if($("#sMenuName").val()==""){    
		Ego.error("请填写菜单名称",null);
		$("#sMenuName").focus();
		return false;
	}
	
	if($("#sReportTitle").val()==""){    
		Ego.error("请填写报表标题",null);
		$("#sReportTitle").focus();
		return false;
	}
	
	var sReportSql = $("#sReportSql").val();
	if(sReportSql==""){    
		Ego.error("请填写统计脚本",null);
		$("#sReportSql").focus();
		return false;
	}else{
		if(sReportSql.indexOf("drop")>0 || sReportSql.indexOf("create")>0 || sReportSql.indexOf("update")>0 ||sReportSql.indexOf("delete")>0 
				|| sReportSql.indexOf("<")>0 || sReportSql.indexOf(">")>0 || sReportSql.indexOf("&")>0){
			Ego.error("统计脚本包含非法关键字或字符",null);
			$("#sReportSql").focus();
			return false;
		}
	}
	
	if($("#sReportSortField").val()==""){    
		Ego.error("请填写排序字段",null);
		$("#sReportSortField").focus();
		return false;
	}
	return true;
}


function addReportForm(){	
	  var addMsg = "";
	  //动态获取表单参数
 	   var formData = new FormData();  
	   var a = $('#addReportFrom').serializeArray(); 
	   $.each(a, function() { 
 	       if(this.name != ''){
 	    	  addMsg += this.name+"="+this.value+"&";
	       }
	   });    
	   console.log("="+addMsg);
 	$.ajax({
        type: "POST",
        url:'add',
        data: addMsg,  
        async: false,
        error: function(request) { 
        	Ego.error("系统异常,请刷新后重试.",null);
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")");
        	var isValid = dataResult.IsValid;
        	var returnValue = dataResult.ReturnValue 
        	if(isValid){
        		Ego.success(returnValue,function(){
        			window.location.href = 'index';
        		}); 
        	}else{  
        		Ego.error(returnValue,null);
        	}
        }
    }); 
}
