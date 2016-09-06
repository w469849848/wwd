jQuery(function($) {
 	adEchartsMsg();
});

function adEchartsMsg(){
	var nAdId = $("#nAdId").val();
 	$.ajax({
        cache: false,
        type: "GET",
        url:webHost+'/media/mediaContext/adLineReport', 
        data:'nAdId='+nAdId,
        dataType: "json",
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) { 
        	 
        	var isValid = data.IsValid; 
         	if(isValid){
	               var myChart = echarts.init(document.getElementById('canvas'));
	               var sAdTitle = data.sAdTitle;
	               var xAxis = data.xAxis; 
	               var showNum =data.showNum;
	               var showIpNum = data.showIpNum;
	               var clickNum = data.clickNum;
	               var clickIpNum = data.clickIpNum;
         		   var option = echartsOptions(sAdTitle,xAxis,showNum,showIpNum,clickNum,clickIpNum);
         		   console.log(option);
         		   myChart.setOption(option);
         		  window.onresize = myChart.resize;
	         	  
         	}else{
         		Ego.error("广告统计异常.",null);
         	}
        }
    }); 
}  
 

function echartsOptions(sAdTitle,xAxis,showNum,showIpNum,clickNum,clickIpNum){
	option = {
		    title: {
		        text: sAdTitle
		    },
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['显示数','独立IP显示数','点击数','独立IP点击数']
		    },
		    toolbox: {
		        feature: {
		            saveAsImage: {}
		        }
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : false,
		            data : xAxis
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'显示数',
		            type:'line',
		            stack: '总量',
		            areaStyle: {normal: {}},
		            data:showNum
		        },
		        {
		            name:'独立IP显示数',
		            type:'line',
		            stack: '总量',
		            areaStyle: {normal: {}},
		            data:showIpNum
		        },
		        {
		            name:'点击数',
		            type:'line',
		            stack: '总量',
		            areaStyle: {normal: {}},
		            data:clickNum
		        },
		        {
		            name:'独立IP点击数',
		            type:'line',
		            stack: '总量',
		            areaStyle: {normal: {}},
		            data:clickIpNum
		        } 
		    ]
		};
     return option;
}