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
	
	$("#seletAdPosNO").on('click',function(){
		seletAdPosNO("adPosSelect?type=select");
	});
	
 
	$('td a.delete').on('click', function(e) { //删除弹窗 
		var adId = $(this).attr("pid");
		Ego.alert("是否确认删除广告？",function(){  
			deleteAdV(adId)
		}); 
	}); 

	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});

	$('.batch .chk').on('click', function() { //全选/取消全选
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	

	 $("#query").on('click',function(){  //查询 
		 $("#page_index").val(1);
		 
		 var sApTitle = $("#sApTitle").val();
		 var nApID = $("#nApID").val();
		 if(sApTitle == ''){
			 $("#nApID").val("");
		 }
		 $("#limitPageForm").submit();
	 });
	
	//加载区域
 	 loadTOrgsAndAll("ad-zoneCode-menu","4","loadAll");
	 var sAdZoneCodeID_u = $("#sAdZoneCodeID").val();
	 if(sAdZoneCodeID_u != ''){  //查询返回后  
		  $("#ad-zoneCode-menu").find("li").each(function(){
			  if($(this).attr("value")==sAdZoneCodeID_u){
				  $("#ad-zoneCode-id").find("span").eq(0).text($(this).text());
				 // loadApByApSaleType();
			  }
		 }); 
	 }
	 $("#ad-zoneCode-menu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#ad-zoneCode-id").find("span").eq(0).text(litext);
		 $("#sAdZoneCodeID").val(livalue); 
		 //loadApByApSaleType();
	 });
	
	//广告位置
	 loadCommonMsg("ap-position-menu","sApSaleType");
	 var sApSaleTypeID_u = $("#sApSaleTypeID").val();
	 if(sApSaleTypeID_u != ''){  //查询返回后  
		  $("#ap-position-menu").find("li").each(function(){
			  if($(this).attr("value")==sApSaleTypeID_u){
				  $("#ap-position-id").find("span").eq(0).text($(this).text());
				  //loadApByApSaleType();
			  }
		 }); 
	 }
	 $("#ap-position-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value");  
		 $("#ap-position-id").find("span").eq(0).text(litext);
		 $("#sApSaleTypeID").val(livalue);
		 //loadApByApSaleType();
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


//根据广告位置获取广告位
function loadApByApSaleType(){
	var sApSaleTypeID= $("#sApSaleTypeID").val();
	var sAdZoneCodeID = $("#sAdZoneCodeID").val();
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/media/mediaPos/loadMsgByApSaleType?sApSaleTypeID='+sApSaleTypeID+'&sAdZoneCodeID='+sAdZoneCodeID,
        data:'',
        async: false,
        error: function(request) {
        	Ego.error("系统异常,请刷新后重试.",null);
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")");
         	var isValid = dataResult.IsValid; 
        	if(isValid){
        		var dataList = dataResult.DataList; 
        		if(dataList.length>0){ 
					 var apMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 apMsg+="<li value='"+data.nApID+"' nContractID='"+data.nContractID+"' >"+data.sApTitle+"</li> "; 
					 }
					 $("#adv-name-menu").html(apMsg);
					 //广告位
					 $("#adv-name-menu li").click(function(){
						 var litext = $(this).text(); 
						 var livalue =  $(this).attr("value"); 
						 var nContractID =  $(this).attr("nContractID"); 
						 
						 var resultText = "";
						 if(litext.length >10){
							 resultText = litext.substring(0,10)+"...";
						 }else{
							 resultText= litext;
						 }
						 	
						 $("#adv-name-id").find("span").eq(0).text(resultText);
						 $("#nApID").val(livalue);  
					 });
				 }else{
					 $("#adv-name-menu").html(""); 
				 }
          	}else{
        		var returnValue = dataResult.ReturnValue;  
        		Ego.error(returnValue,null);
        	}
        }
    }); 
}



//删除广告
function deleteAdV(adId){ 
	$.ajax({
        cache: false,
        type: "POST",
        url:'delete',
        data:'id='+adId,
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
        			window.location.href = webHost + '/media/mediaContext/list';
        		  }); 
	     	  }else{
	     		 Ego.error(returnValue,null);
	     	  } 
        }
    });  
}



/* 选择 窗口 */
function seletAdPosNO(content_url) {
	 
	layer.open({
		type : 2,
		title : '广告位选择',
		shadeClose : true,
		shade : 0.6,
		area : [ '60%', '80%' ],
		content : content_url
	});
}

function getAdPosNO(selectNo,selectName,selectWidth,selectHeight){
	$("#nApID").val(selectNo);
	$("#sApTitle").val(selectName);
}