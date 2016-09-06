jQuery(function($) {
	
	//初始化统计数据
	indexCountMsg();
	
	indexEchartsMsg();
	
	jump(100); 
});


function jump(count) { 
    window.setTimeout(function(){ 
        count--; 
        if(count > 0) { 
            $('#num').text(count); 
            jump(count); 
        } else { 
        	indexEchartsMsg();
        	jump(100); 
        }
    }, 1000); 
} 

function indexEchartsMsg(){
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/indexECharts', 
        dataType: "json",
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) { 
        	//var dataResult = eval("(" + data + ")");
        	var isValid = data.IsValid;
        	var userType = data.userType;
         	if(isValid){
	               var myChart = echarts.init(document.getElementById('canvas'));
	               var dataList = data.DataList;
	               if(userType == 'AGENT'){     //经销商账号登陆的
		         	   var xAxis_data = []; //x轴数据
		         	   var series_total = []; //柱状金额数据
		         	   var series_qty = []; //柱状订单数据 
		         	   if(dataList.length>0){
		         		   for(var i = 0;i<dataList.length;i++){
		         			   var dataMsg = dataList[i]; 
		         			   xAxis_data.push(dataMsg.xAxis);
		         			   series_qty.push(dataMsg.qty);
		         			   series_total.push(dataMsg.sumTotal);
		         		   }
		         	   } 
	         		   var option = echartsOptions(xAxis_data,series_qty,series_total);
	         		  myChart.setOption(option);
	         		   window.onresize = myChart.resize;
	         	  }
	         	 
	         	  if(userType == 'OPERATOR' || userType == 'ADMIN'){  //运维人员账号登陆的
	         		  if(dataList.length>0){
	         			  var allProTotal = 0;  //全国销量总额
	         			  var proTotal = []; //省的销售金额
	         			 for(var i = 0;i<dataList.length;i++){
	         				   var dataMsg = dataList[i]; 
	         				   allProTotal +=parseFloat(dataMsg.sumTotal);
	         				   proTotal.push(dataMsg.sumTotal);
	         			 }
	         			 var option = echarChinaMapOption(dataList,allProTotal,proTotal);
		         		  myChart.setOption(option);
		         		  window.onresize = myChart.resize;
		         		  myChart.on('click', function (params) { //点击省份事件  
		         		       if(typeof(params.data.upOrgNO)  !='undefined' ){
		         		    	  loadProvenceMsg(params.data.upOrgNO,params.data.name,params.data.sRegionNO);   
		         		       } 
		         		  });
	         		  }
	         		 
	         	  } 
         	}
        }
    }); 
}

/**
 * 
 * @param upOrgNO  区域编码 SUZU 
 * @param proName  区域名称 苏州
 * @param sRegionNO  320000 
 */
function loadProvenceMsg(upOrgNO,proName,sRegionNO){
 	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/indexEchartsProvince', 
        dataType: "json",
        data:"upOrgNo="+upOrgNO+"&orgName="+proName+"&sRegionNO="+sRegionNO,
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {
        	   var isValid = data.IsValid;
        	   if(isValid){
        		   provinceOption(data,proName);
        	   }
        	   
        }
    }); 
}
//设置省下的市的数据
function provinceOption(data,proName){
	 var  proPingyinName = data.orgNamePinying;   //省份的拼音 小写 
	 var dataList = data.DataList;
	 
	 var dataTotalStr = "";  // 金额的数
	 var dataQtyStr = ""; //订单的数
	 
	 var citySumTotal = 0 ; // 该省的订单总金额
	 var cityTotal = []; //各市的订单金额
	 if(dataList.length>0){
		 for(var i=0;i<dataList.length;i++){
			 var  cityData = dataList[i];
			 var cityName = cityData.sOrgDesc;
			 var bool = cityName.indexOf("市"); 
			 if(bool <0){
				 cityName= cityName+"市";
			 }
			 dataTotalStr += "{name:'"+cityName+"',value:"+cityData.sumTotal+"},";
			 dataQtyStr += "{name:'"+cityName+"',value:"+cityData.qty+"},";
			 cityTotal.push(cityData.sumTotal);
			 citySumTotal+=parseFloat(cityData.sumTotal);
		 }
	 }
	 if(dataTotalStr != ''){
		 dataTotalStr = dataTotalStr.substring(0,dataTotalStr.length-1);
		 dataTotalStr = eval("(" + dataTotalStr + ")");
	 }
	 if(dataQtyStr != ''){
		 dataQtyStr = dataQtyStr.substring(0,dataQtyStr.length-1);
		 dataQtyStr = eval("(" + dataQtyStr + ")");
	 }
	
	 var maxPrice = Math.max.apply(null, cityTotal);  //计算最大的金额
	 
	 var jsonUrl = "resources/json/"+proPingyinName+".json";
   	$.get(jsonUrl, function (chinaJson) {
   	    echarts.registerMap(proPingyinName, chinaJson);
   	    var chart = echarts.init(document.getElementById('canvas'));
   	    window.onresize = chart.resize;
   	    chart.setOption({
   	    	title: {
   		        text: proName+'订单销量,总金额:'+citySumTotal.toFixed(2)+'元', 
   		        left: 'center'
   		    },
   		    tooltip: {
   		        trigger: 'item'
   		    },
   		    /*legend: {
   		    	orient: 'vertical',
   		    	left: 'left',
   		    	data:['订单金额']
   		    },*/
		    visualMap: {
		        min: 0,
		        max: maxPrice+1000,
		        left: 'left',
		        top: 'bottom',
		        text: ['高','低'],           // 文本，默认为数值文本
		        calculable: true,
		        color: ['orangered','yellow','lightskyblue']
		    },
		    toolbox: {
		        show: true,
		        orient: 'vertical',
		        left: 'right',
		        top: 'center',
		        feature: {
		            dataView: {readOnly: false},
		            restore: {},
		            saveAsImage: {}
		        }
		    }, 
   	        series: [
   	                 {
		   	        	name: '订单金额',
		   	            type: 'map',
		   	            map: proPingyinName, 
		   	            roam: false,
		   	            label: {
		   	                normal: {
		   	                    show: true
		   	                },
		   	                emphasis: {
		   	                    show: true
		   	                }
		   	            },
		   	            data:[
		   	                   /*{name:'苏州市',value:100},
		   	                   {name:'扬州市',value:100},
		   	                   {name:'盐城市',value:100}*/
		   	                    dataTotalStr
		   	                 ]
		   	        } 
   	           ]
   	    });
   	});
}




//设置全国地图中各省的值
function mapValueData(name,dataList) {
	 var resultValue=""; 
	 for(var i = 0;i<dataList.length;i++){
		   var dataMsg = dataList[i];
		   if(dataMsg.upOrgDesc == name){
 			   resultValue = "{name: '"+name+"',value:"+dataMsg.sumTotal+",qty:"+dataMsg.qty+",upOrgNO:'"+dataMsg.upOrgNO+"',sRegionNO:'"+dataMsg.sRegionNO+"' }";
 			   break;
		   } 
	 }
	 if(resultValue == ''){ 
		 resultValue = "{name: '"+name+"',value:0 }";
 	 }
	resultValue = eval("(" + resultValue + ")");
    return resultValue;
}

 
/**
 * 加载全国地图
 * @param dataList
 * @param allProTotal全国销量总额
 * @param proTotal  省份销量集合
 * @returns {___anonymous_option}
 */
function echarChinaMapOption(dataList,allProTotal,proTotal){
	var maxPrice = Math.max.apply(null, proTotal); 
	option = {
		    title: {
		        text: '全国订单销量,总金额:'+allProTotal.toFixed(2)+'元', 
		        left: 'center'
		    },
		    tooltip: {
		        trigger: 'item'
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data:['订单金额']
		    },
		    visualMap: {
		        min: 0,
		        max: maxPrice+2000,
		        left: 'left',
		        top: 'bottom',
		        text: ['高','低'],           // 文本，默认为数值文本
		        calculable: true,
		        color: ['orangered','yellow','lightskyblue']
		    },
		    toolbox: {
		        show: true,
		        orient: 'vertical',
		        left: 'right',
		        top: 'center',
		        feature: {
		            dataView: {readOnly: false},
		            restore: {},
		            saveAsImage: {}
		        }
		    },
		    series: [
		        {
		            name: '订单总金额',
		            type: 'map',
		            mapType: 'china',
		            roam: false,
		            label: {
		                normal: {
		                    show: true
		                },
		                emphasis: {
		                    show: true
		                }
		            },
		            data:[
		                mapValueData("北京",dataList),
		                mapValueData("天津",dataList),
		                mapValueData("上海",dataList),
		                mapValueData("重庆",dataList),
		                mapValueData("河北",dataList),
		    			mapValueData("河南",dataList) ,
		                mapValueData("云南",dataList) ,
		                mapValueData("辽宁",dataList) ,
		                mapValueData("黑龙江",dataList) ,
		                mapValueData("湖南",dataList) ,
		                mapValueData("安徽",dataList) ,
		                mapValueData("山东",dataList) ,
		                mapValueData("新疆",dataList) ,
		                mapValueData("江苏",dataList) ,
		                mapValueData("浙江",dataList) ,
		                mapValueData("江西",dataList) ,
		                mapValueData("湖北",dataList) ,
		                mapValueData("广西",dataList) ,
		                mapValueData("甘肃",dataList) ,
		                mapValueData("山西",dataList) ,
		                mapValueData("内蒙古",dataList) ,
		                mapValueData("陕西",dataList) ,
		                mapValueData("吉林",dataList) ,
		                mapValueData("福建",dataList) ,
		                mapValueData("贵州",dataList) ,
		                mapValueData("广东",dataList) ,
		                mapValueData("青海",dataList) ,
		                mapValueData("西藏",dataList) ,
		                mapValueData("四川",dataList) ,
		                mapValueData("宁夏",dataList) ,
		                mapValueData("海南",dataList) ,
		                mapValueData("台湾",dataList) ,
		                mapValueData("香港",dataList) ,
		                mapValueData("澳门",dataList) 
		            ]
		        } 
		    ]
		};
	return option;
}

/**
 *  区域人员图表
 * @param xAxis_data
 * @param series_qty
 * @param series_data
 * @returns {___anonymous_option}
 */
function echartsOptions(xAxis_data,series_qty,series_data){
	var maxPrice = Math.max.apply(null, series_data); 
	option = {
		    
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['金额','订单数']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            dataView : {show: true, readOnly: false},
		            magicType : {show: true, type: ['line', 'bar']},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            data : xAxis_data
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'金额',
		            type:'bar',
		            data:series_data,
		            markPoint : {
		                data : [
		                    {type : 'max', name: '最大值'},
		                    {type : 'min', name: '最小值'}
		                ]
		            },
		            markLine : {
		                data : [
		                    {type : 'average', name: '平均值'}
		                ]
		            }
		        },
		        {
		            name:'订单数',
		            type:'bar',
		            data:series_qty,
		            markPoint : {
		                data : [
		                    {name : '年最高', value : 182.2, xAxis: 7, yAxis: 183, symbolSize:18},
		                    {name : '年最低', value : 2.3, xAxis: 11, yAxis: 3}
		                ]
		            },
		            markLine : {
		                data : [
		                    {type : 'average', name : '平均值'}
		                ]
		            }
		        }
		    ]
		};
	 return option;
}



//统计数据
function indexCountMsg(){
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/indexCount', 
        dataType: "json",
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) { 
          	$("#adWaitCount").text(data.adWaitCount);   //广告数据
         	$("#goodsDtlWaitCount").text(data.goodsDtlWaitCount); //商品数据
         	$("#tmpPromoWaitCount").text(data.tmpPromoWaitCount);//活动数据
         	$("#saleOrderWaitCount").text(data.saleOrderWaitCount); //销售订单
         	$("#refundOrderWaitCount").text(data.refundOrderWaitCount); //退货订单
         	$("#noticeWaitCount").text(data.noticeWaitCount); // 公告数据
         	$("#agentWaitCount").text(data.agentWaitCount); //经销商数据
         	$('#driverWaitCount').text(data.driverWaitCount);
        }
    }); 
}