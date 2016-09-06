
jQuery(function(){ 
	var moduleID = $("#moduleID").val(); 
	var url = '/data/generalReport/idcTitleById?moduleID='+moduleID;
	
	loadQueryMsg(url); 
	$("#queryButton").on('click',function(){
		if(check()){
			loadDataMsg(1,'parent');  	
		}
	});
	
	$("#export").on('click',function(){
		exportExcel();
	});
	
	$("#print").on('click',function(){
		$.print({
			url : webHost+'/data/generalReport/idcReportMsg',
			print : webHost + '/data/generalReport/print',
			param : $('#reportQueryFrom')
		});
	}); 
});


/**
 * 导出
 */
function exportExcel(){
	var selectMsg = "";
	  //动态获取表单参数
	   var formData = new FormData();  
	   var a = $('#reportQueryFrom').serializeArray(); 
	   $.each(a, function() { 
	       if(this.name != ''){
	    	   selectMsg += this.name+"="+this.value+"&";
	       }
	   });     
	   window.location.href=webHost+"/data/generalReport/exportExcel?"+selectMsg;

}

function getSelectNo(backTextNo,selectValue){
	$("#"+backTextNo).val(selectValue); 
}
