
jQuery(function(){ 
	var moduleID = $("#moduleID").val(); 
	var url = '/data/generalReport/idcTitleById?moduleID='+moduleID;
	
	loadQueryMsg(url); 
	$("#queryButton").on('click',function(){
		if(check()){
			loadEchartDataMsg(1);	
		}
	}); 
	
	$("#print").on('click',function(){
		 $("#printid").print();
	}); 
});


//设置结果
function  loadEchartDataMsg(index){
	 var layerindex = layer.load(0, {shade: [0.2, '#393D49']});  
 	  var selectMsg = "";
	  //动态获取表单参数
	   var formData = new FormData();  
	   var a = $('#reportQueryFrom').serializeArray(); 
	   $.each(a, function() { 
	       if(this.name != ''){
	    		selectMsg += this.name+"="+this.value+"&";
	       }
	   }); 
	 
	  $.ajax({
	        cache: false, 
	        type: "POST",
	        dataType: "json",
	        url:webHost+'/data/generalReport/idcEchartMsg' ,
	         data:selectMsg,
	         //data:'queryName=lineChartTest&date1=&date2=',
	        async: false,
	        error: function(request,errorThrown) {
	        	Ego.error("IDC服务连接异常,请刷新后重试.",null);
	        },
	        success: function(resultData) {
	        	var isValid = resultData.isValid;
	        	if(isValid){
	        		var data = resultData.data;   
	        		var dataIsValid  = data.isValid;  //业务成功失败标示
	        		 
	        		if(dataIsValid) {
	        			 var dataList = data.dataList;
 	        			 if(dataList.length >0){
	        				 var char =[];
	        				 var chartMsg = "";
	        				 for(var i=0;i<dataList.length;i++){
	        					 var dataL  = dataList[i]; 
	        					 var chartOption = dataL.chartOption;
	        					 chartMsg+=chartDivMsg("chart"+i);
	        					 char.push(chartOption);
	        				 }
	        				 $("#chartMsg").html(chartMsg);
	        				 
	        				 for( var j=0;j<char.length;j++){
	        					 var myChartTopTen = echarts.init(document.getElementById("chart"+j));
	        					 var option = char[j]; 
	        					 myChartTopTen.setOption(JSON.parse(option));
	        		     		 window.onresize = myChartTopTen.resize;
	        				 }
	        			 }
	        		}else{
	        			var error = data.errors;
	        			var errorMsg = error[0].errorMsg;
	        			Ego.error(errorMsg,null);
	        		}    	
	        		
	        	}else{
	        		var errors = resultData.errors; 
	        		var errorMsg  = errors.errorMsg;
	        		Ego.error(errorMsg,null);
	        	} 	        
	        	
	        }
	    });  
	  layer.close(layerindex);
} 


function  chartDivMsg(id){
	var divMsg = "";
	divMsg += "<div class='col-md-12 col-xs-12 graphical_main' > ";
	divMsg += "<div class='col-lg-6 col-xs-12 graphical_1'>";
	divMsg += "	<div class='col-md-12 col-xs-12 text-center'>";
	divMsg += "		<p class='graphical_pm'></p>";
	divMsg += "	</div>";
	divMsg += "	<div class='col-md-12 col-xs-12 text-center'>";
	divMsg += "		<div class='detail-section'>";
	divMsg += "			<div id='"+id+"' style='width: 100%;height:600px;'></div>";
	divMsg += "		</div>";
	divMsg += "	</div>";
	divMsg += "	<div class='col-md-12 col-xs-12 recent-item1'></div>";
	divMsg += "</div> ";
	divMsg += "</div> ";
	return divMsg; 
}
 