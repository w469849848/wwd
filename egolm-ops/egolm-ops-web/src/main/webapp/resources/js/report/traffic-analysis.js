jQuery(function(){
	
	//响应式表格初始化
	$('.table-data table').footable({
		debug: true,
		breakpoints: {
			phone: 480,
			tablet: 800
		},
		log: function(message, type) {
		 
		}
	});
			
	$('.tit').find('a').each(function(index){
		$(this).on('click',function(){
			var pid = $(this).attr('pid');
			console.log(pid);
			$('.tit').find('a').removeClass("active");
			$(this).addClass("active");
			$("#sAccessMode").val(pid);
			
			loadTrafficAnalysisMsg();
			loadTopTenGoods();
			loadLineMsg();
		});
	});
	
	
	
	 //店铺类型
	$('.shop-type').find('a').each(function(index){
		  $(this).on('click',function(){
			    var pid = $(this).attr('pid');
			    $('.shop-type').find('a').removeClass("active");
				$(this).addClass("active");
				$("#sScopeTypeID").val(pid);
				
				loadTrafficAnalysisMsg();
				loadTopTenGoods();
				loadLineMsg();
				//loadTopTenZone();
		  });
	}); 
	
	
	
	 
	//PC  天
	$('#pc-day').on('click',function(){
		$("#pc-day").addClass("active");
		$("#pc-hour").removeClass("active"); 
		$("#selectDateType").val("day");
		loadTrafficAnalysisMsg();
		loadTopTenGoods();
		loadLineMsg(); 
		//loadTopTenZone();
	});
	//PC  小时
	$('#pc-hour').on('click',function(){
		$("#pc-day").removeClass("active");
		$("#pc-hour").addClass("active");
		$("#selectDateType").val("hour");
		loadTrafficAnalysisMsg();
		loadTopTenGoods();
		loadLineMsg();
		//loadTopTenZone();
	});
	
	//切换到PC端统计
	$('.traffic-analysis-mobile .btn-pc').on('click',function(){
		$('.traffic-analysis-pc').toggleClass('hide');
		$('.traffic-analysis-mobile').toggleClass('hide');
	});
	loadTrafficAnalysisMsg();
	loadTopTenGoods();
	loadLineMsg();
	//loadTopTenZone();
});



/**
 * 加载今日等数据
 */
function  loadTrafficAnalysisMsg(){
	var sAccessMode = $("#sAccessMode").val(); //终端类型
	var sScopeTypeID = $("#sScopeTypeID").val(); //店铺类型 
	var selectDateType = $("#selectDateType").val();//时间类型
	 
	
	  $.ajax({
	        cache: false, 
	        type: "POST",
	        dataType: "json",
	        url:'loadDateFlow', 
	        data:'selectDateType='+selectDateType+'&sScopeTypeID='+sScopeTypeID+'&sAccessMode='+sAccessMode,
	        async: false,
	        error: function(request,errorThrown) {
	        	Ego.error("系统连接异常,请刷新后重试.",null);
	        },
	        success: function(data) { 
	        	var isValid = data.IsValid;
	        	var dataList = data.DataList;
	        	var trafficMsg = "";
	       	 	 if(dataList.length >0){
	       	 		 for(var i = 0 ;i<dataList.length;i++){
	       	 			 var dataL = dataList[i];
	       	 			 
	       	 			 var  bounceRate = dataL.bounceRate;
 	       	 			bounceRate= FloatMul(bounceRate,100) +"%";  
	       	 			 
	       	 			 var custTakeRates = dataL.custTakeRates;
	       	 			custTakeRates =  FloatMul(custTakeRates,100) +"%"; 
	       	 			 
	       	 			trafficMsg +="<tr>";
		       	 		trafficMsg +="	<td>"+dataL.dayName+"</td>"; 
		       	 		trafficMsg +="	<td>"+dataL.pv+"</td>"; 
		       	 		trafficMsg +="	<td>"+dataL.uv+"</td>"; 
		       	 		trafficMsg +="	<td>"+dataL.ip+"</td>"; 
		       	 		trafficMsg +="	<td>"+bounceRate+"</td>"; 
		       	 		trafficMsg +="	<td>"+dataL.siteVisitDepth+"</td>"; 
		       	 		trafficMsg +="	<td>"+custTakeRates+"</td>"; 
		       	 		trafficMsg +="</tr>"; 
	       	 		 }
	       	 		 $("#traffic-id").html(trafficMsg);
	       	 	 } 
	        }
	    });  
}


/**
 * 加载7天内TOP10的商品数据
 */
function  loadTopTenGoods(){
	var sAccessMode = $("#sAccessMode").val(); //终端类型
	var sScopeTypeID = $("#sScopeTypeID").val(); //店铺类型
	var selectDateType = $("#selectDateType").val();//时间类型
 
	  $.ajax({
	        cache: false, 
	        type: "POST",
	        dataType: "json",
	        url:'loadTopTenGoods', 
	        data:'selectDateType='+selectDateType+'&sScopeTypeID='+sScopeTypeID+'&sAccessMode='+sAccessMode,
	        async: false,
	        error: function(request,errorThrown) {
	        	Ego.error("系统连接异常,请刷新后重试.",null);
	        },
	        success: function(data) { 
	        	var isValid = data.IsValid;
	        	var dataList = data.DataList;
	        	var myChartTopTen = echarts.init(document.getElementById('recent-pc1'));
	        	var xAxis_data = []; //x轴数据
	        	var cylinder_data = []; //圆柱里的数据  
	        	if( dataList != ''){
	        		if(dataList.length >0){
		       	 		 for(var i = 0 ;i<dataList.length;i++){
		       	 			var data_value = {};
		       	 			var dataL = dataList[i]; 
		       	 			xAxis_data.push(dataL.sGoodsDesc);
		       	 			data_value["value"]=dataL.cou;
		       	 			data_value["name"]=dataL.sGoodsDesc;
		       	 			cylinder_data.push(data_value);
		       	 	     } 
		       	 	}
	        	}
	        	
         	   var option = echartsOptionsTop10("最近7天被访问的宝贝TOP10",xAxis_data,cylinder_data);
        	   myChartTopTen.setOption(option);
     		   window.onresize = myChartTopTen.resize;
	        }
	    });  
}

/**
 * 加载7天内访问量最高的TOP10 区域
 */
function  loadTopTenZone(){
	var sAccessMode = $("#sAccessMode").val(); //终端类型
	var sScopeTypeID = $("#sScopeTypeID").val(); //店铺类型
	var selectDateType = $("#selectDateType").val();//时间类型
 
	  $.ajax({
	        cache: false, 
	        type: "POST",
	        dataType: "json",
	        url:'loadTopTenZone', 
	        data:'selectDateType='+selectDateType+'&sScopeTypeID='+sScopeTypeID+'&sAccessMode='+sAccessMode,
	        async: false,
	        error: function(request,errorThrown) {
	        	Ego.error("系统连接异常,请刷新后重试.",null);
	        },
	        success: function(data) { 
	        	var isValid = data.IsValid;
	        	var dataList = data.DataList; 
	        	var myChartTopTenZone = echarts.init(document.getElementById('recent-pc2'));
	        	var xAxis_data = []; //x轴数据
	        	var cylinder_data = []; //圆柱里的数据  
	        	
	        	if(dataList.length >0){
	       	 		 for(var i = 0 ;i<dataList.length;i++){
	       	 			var data_value = {};
	       	 			var dataL = dataList[i];  
	       	 			xAxis_data.push(dataL.sOrgDesc);
	       	 			data_value["value"]=dataL.cou;
	       	 			data_value["name"]=dataL.sOrgDesc;
	       	 			cylinder_data.push(data_value);
	       	 	     } 
	       	 	} 
         	   var option = echartsOptionsTop10("加载7天内访问量最高的TOP10",xAxis_data,cylinder_data); 
         	   myChartTopTenZone.setOption(option);
     		   window.onresize = myChartTopTenZone.resize;
	        }
	    });  
} 

/**
 * 7天内TOP 10 饼图 
 * @param xAxis_data
 * @param cylinder_data
 * @returns {___anonymous_option}
 */
function echartsOptionsTop10(text,xAxis_data,cylinder_data){
	option = {
		    title : {
		        text: text, 
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data:  xAxis_data
		    },
		    series : [
		        {
		            name: '',
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:cylinder_data, 
		            itemStyle: {
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                }
		            }
		        }
		    ]
		};
	return option; 
}

/**
 * 加载线性图
 * @param selectDateType
 */
function loadLineMsg(){
	var sScopeTypeID = $("#sScopeTypeID").val(); //店铺类型
	var sAccessMode = $("#sAccessMode").val(); //终端类型
	var selectDateType = $("#selectDateType").val();//时间类型
	$.ajax({
        cache: false, 
        type: "POST",
        dataType: "json",
        url:'loadLineMsg', 
        data:'selectDateType='+selectDateType+'&sScopeTypeID='+sScopeTypeID+'&sAccessMode='+sAccessMode,
        async: false,
        error: function(request,errorThrown) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) { 
        	var isValid = data.IsValid;  
        	var dataList = data.DataList;
        	console.log("dataList="+dataList);
        	
        	if(dataList.length >0){
      	 		 for(var i = 0 ;i<dataList.length;i++){
      	 			var dataL = dataList[i]; 
      	 			console.log(dataL.xAxis);
      	 			
      	 			var myChartLine = echarts.init(document.getElementById('line-chart-pc'));
      	       	   var option = echartsOptionsLine(dataL.xAxis,dataL.pv,dataL.uv,dataL.ip);
      	       	    myChartLine.setOption(option);
      	       	   window.onresize = myChartLine.resize;
      	 	     } 
      	 	} 
        }
    }); 
}

/**
 * 加载折线图
 * @param x_data
 * @param pv_data
 * @param uv_data
 * @param ip_data
 * @returns {___anonymous_option}
 */
function echartsOptionsLine(x_data,pv_data,uv_data,ip_data){
	option = {
		    title: {
		       
		    },
		    tooltip: {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['浏览量','访客数','IP数']
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    toolbox: {
		        feature: {
		            saveAsImage: {}
		        }
		    },
		    xAxis: {
		        type: 'category',
		        boundaryGap: false,
		        data: x_data
		    },
		    yAxis: {
		        type: 'value'
		    },
		    series: [
		        {
		            name:'浏览量',
		            type:'line',
		            stack: '总量',
		            data:pv_data
		        },
		        {
		            name:'访客数',
		            type:'line',
		            stack: '总量',
		            data:uv_data
		        },
		        {
		            name:'IP数',
		            type:'line',
		            stack: '总量',
		            data:ip_data
		        } 
		    ]
		};
	return option;
}