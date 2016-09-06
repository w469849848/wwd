jQuery(function(){
	loadDataMsg(1);
	 
	
	$("#query").on('click',function(){
		loadDataMsg(1);
	});
});


function  loadDataMsg(index){
	  var queryAttr = $("#queryAttr").val();
	  $.ajax({
	        cache: false, 
	        type: "POST",
	        dataType: "json",
	        url:webHost+'/system/ywReport/list' ,
	        data:'page.index='+index+'&queryAttr='+queryAttr,
	        async: false,
	        error: function(request,errorThrown) {
	        	Ego.error("系统连接异常,请刷新后重试.",null);
	        },
	        success: function(data) {  
	        	var isValid = data.IsValid;
	        	var dataList = data.DataList; 
	        	var sReportTitle = data.sReportTitle;
	        	 
	        	 
	        	
	        	//设置内容
	        	if(dataList.length >0){
	        		var dataMsg = "";
	        		for(var i=0;i<dataList.length;i++){
	        			var dataM = dataList[i]; 
	        			dataMsg +="<tr>";
	        			dataMsg +="<td>"+dataM.sMenuID+"</td>";
	        			dataMsg +="<td>"+dataM.sMenuName+"</td>";
	        			dataMsg +="<td>"+dataM.sReportTitle+"</td>";
	        			dataMsg +="<td>"+dataM.sReportType+"</td>";
	        			dataMsg +="<td>"+dataM.sCreateUser+"</td>";
	        			dataMsg +="<td>"+dataM.dCreateDate+"</td>";
	        			dataMsg +="<td>"+dataM.dLastUpdateTime+"</td>";
	        			dataMsg +="<td><a class='edit' href='"+webHost+"/system/ywReport/loadMsgById?menuId="+dataM.sMenuID+"'><img src='"+resourceHost+"/images/edit.png' alt='编辑' /></a></td>";
	        			dataMsg +=" </tr>"; 
	        		}
	        		$("#dataMsg").html(dataMsg);
	        	}else{
	        		$("#dataMsg").html("");
	        	}
	        	
	        	 //设置分页  
	            //设置分页 
	           var pageHtml = ajaxPager.render(data.page, function(page) {
	        	   loadDataMsg(page.index);
	     		});
	            $('div').remove('.navigation_bar');
	     		$('.reportManager .batch').append(pageHtml);
	        }
	    });  
} 