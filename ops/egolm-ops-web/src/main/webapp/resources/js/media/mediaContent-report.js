jQuery(function($) {

	var footable = null,
		$row = null,
		isAll = false, //true为全选，false为未选中
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	$('.advertisement table').footable({ //响应式表格初始化
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
	

 
	
 
	//广告位置
	 loadCommonMsg("adv-position-menu","sApSaleType");
	 $("#adv-position-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value");  
		 $("#adv-position-id").find("span").eq(0).text(litext);
		 $("#sApSaleTypeID").val(livalue); 
	 });
	 
		//广告区域
 	 loadTOrgsAndAll("sAdZoneCode-area-menu","4","loadAll");
	 $("#sAdZoneCode-area-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value");  
		 $("#sAdZoneCode-area-btn").find("span").eq(0).text(litext);
		 $("#sAdZoneCodeID").val(livalue); 
	 });
	 
	 //店铺类型	 
	 loadCommonMsg("sScopeType-memu","ScopeType");
	 $("#sScopeType-memu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value");  
		 $("#sScopeType-id").find("span").eq(0).text(litext);
		 $("#sScopeTypeID").val(livalue); 
	 });
	 
	 
	 
	 $("#query").on('click',function(){    //查询
		    var sApSaleTypeID = $("#sApSaleTypeID").val();
			var sAdZoneCodeID =$("#sAdZoneCodeID").val();
			var sScopeTypeID = $("#sScopeTypeID").val();
			 if(sApSaleTypeID == ''){ 
				Ego.error("请选择广告位类型",null);
				return ;
			} 
			if(sAdZoneCodeID == ''){ 
				Ego.error("请选择广告区域",null);
				return ;
			}
			if(sScopeTypeID == ''){
				Ego.error("请选择店铺类型",null);
				return ;
			}
			loadAdReportMsg(1); 
	 });
	 
	 $(document).keypress(function(e) {    //回车查询
		    // 回车键事件  
		       if(e.which == 13) {  
		    	   e.preventDefault();  //禁掉回车
		       }  
	 }); 
	 
	 $('.batch .border').on('click',function(){ //导出
		 var   operate =  $(this).attr("pid") ;
		 if(operate == 'export'){
			 exportExcel();
		 } 
	 });
	 
});

 

/**
 * 加载报表数据
 */
function loadAdReportMsg(index){
	var layerindex = layer.load(0, {shade: [0.2, '#393D49']});  
	var sAdTitle = $("#sAdTitle").val();
	var sApSaleTypeID = $("#sApSaleTypeID").val();
	var sAdZoneCodeID =$("#sAdZoneCodeID").val();
	var sScopeTypeID = $("#sScopeTypeID").val();
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/media/mediaContext/adReport',
        data:'sAdTitle='+sAdTitle+'&sApSaleTypeID='+sApSaleTypeID+'&sAdZoneCodeID='+sAdZoneCodeID+'&page.index='+index+'&sScopeTypeID='+sScopeTypeID, 
        async: false,
        error: function(request) {
            Ego.error("系统异常,请刷新重试",null);
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")"); 
        	var isValid = dataResult.IsValid;
        	
        	if(isValid){
        		var dataList = dataResult.DataList; 
        		if(dataList.length>0){ 
					 var apReportMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i]; 
						 var showNum = data.showNum;
						 if(showNum == 0){
							 showNum = 1;
						 } 
						 apReportMsg+=" <tr> "; 
						 apReportMsg+=" <td>"+data.nAdID+"</td> "; 
						 apReportMsg+=" <td class='clickSelect' pid='"+data.nAdID+"' id='c_"+data.nAdID+"'>"+data.sAdTitle+"</td> ";
						 apReportMsg+=" <td>"+data.nApPrice/100+"</td> ";
						 apReportMsg+=" <td><span class='orange'>"+data.dAdBeginTime+"</span>/"+data.dAdEndTime+"</td> ";
						 apReportMsg+=" <td>"+data.sAdZoneCode+"</td> ";
						 apReportMsg+=" <td>"+data.showNum+"</td> ";
						 apReportMsg+=" <td>"+data.showIpNum+"</td> "; 
						 apReportMsg+=" <td>"+data.clickNum+"</td> ";
						 apReportMsg+=" <td>"+data.clickIpNum+"</td> ";
						 apReportMsg+=" <td>"+data.ctr+"</td> ";
						 apReportMsg+=" <td>"+data.shop_cvr+"</td> ";
						 apReportMsg+=" <td>"+data.orderCount+"</td> ";
						 apReportMsg+=" <td>"+data.orderTotal+"</td> ";  
						 apReportMsg+=" <td>"+data.order_cvr+"</td> "; 
						 apReportMsg+=" <td>"+data.cpa+"</td> "; 
						 apReportMsg+=" <td>"+data.cpc+"</td> ";
						 apReportMsg+=" <td>"+data.roi+"</td> ";
						 apReportMsg+=" </tr> ";  
					 } 
					 $("#adReportId").html(apReportMsg);  
					 bindClickEvent();
				 }else{
					 $("#adReportId").html("");
				 }
        		layer.close(layerindex);
          	}else{
          		layer.close(layerindex);
          		$("#adReportId").html("");
        		var returnValue = dataResult.ReturnValue;
        		Ego.error(returnValue,null);
        		
        	}
        	//设置分页  
          	var pageHtml = ajaxPager.render(dataResult.page, function(page) {
          		loadAdReportMsg(page.index);
			});
          	$('div').remove('.navigation_bar');
			$('tfoot .batch').append(pageHtml);
        }
    }); 
}
function  exportExcel(){
	var sAdTitle = $("#sAdTitle").val();
	var sApSaleTypeID = $("#sApSaleTypeID").val();
	var sAdZoneCodeID =$("#sAdZoneCodeID").val();
	var sScopeTypeID = $("#sScopeTypeID").val();
	 if(sApSaleTypeID == ''){ 
		Ego.error("请选择广告位类型",null);
		return ;
	} 
	if(sAdZoneCodeID == ''){ 
		Ego.error("请选择广告区域",null);
		return ;
	}
	if(sScopeTypeID == ''){
		Ego.error("请选择店铺类型",null);
		return ;
	}
	
	window.location.href=webHost+'/media/mediaContext/exportExcel?sAdTitle='+sAdTitle+'&sApSaleTypeID='+sApSaleTypeID+'&sAdZoneCodeID='+sAdZoneCodeID+'&sScopeTypeID='+sScopeTypeID;
}


function bindClickEvent(){
	$('.clickSelect').each(function(){
		var pid = $(this).attr('pid');
		$('#c_'+pid).on('click',function(){
			seletReportNO(webHost+"/media/mediaContext/adEChartReport?nAdId="+pid+"");
		});
	});
}

/* 选择 窗口 */
function seletReportNO(content_url) {
	 
	 layer.open({
		type : 2,
		title : '广告七天浏览统计图形报表',
		shadeClose : true,
		shade : 0.6,
		area : [ '60%', '80%' ],
		content : content_url
	}); 
}