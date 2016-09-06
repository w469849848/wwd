pageSize=10;//每页显示数
stdQueryChecks = "";  //文本的检查条件集合


//设置查询条件
function loadQueryMsg(url){
	var moduleID = $("#moduleID").val(); 
	$.ajax({
        cache: false, 
        type: "POST",
        dataType: "json",
        url:webHost+url , 
         async: false,
        error: function(request,errorThrown) {
        	Ego.error("IDC服务连接异常,请刷新后重试.",null);
        },
        success: function(resultData) {
        	var isValid = resultData.isValid;
        	if(isValid){
        		
        		var data = resultData.data;
        		
        		var dataIsValid = data.isValid;
        		if(dataIsValid){
        			var queryName = data.queryName;   
        	        var queryParams = data.queryParams;  //查询条件
        	        stdQueryChecks = data.stdQueryChecks; //检查条件 
          	        if(queryParams.length >0){
          	        	var queryMsg = "";  //查询条件
          	        	var mapMsg  = {};  //存放顺序与结果的MAP
          	        	var paramIDArray = []; //序号的数组
          	        	
        	        	for(var i=0;i<queryParams.length;i++){ 
        	        	
        	        		var queryM = queryParams[i];
        	        		var paramID = queryM.paramid; //顺序字段 
                			
                			var queryStr= createTitle(queryM); 
                			
                			paramIDArray.push(paramID); 
                			mapMsg[paramID]=queryStr;
        	        	}
        	        	//对数组进行排序 
        	        	paramIDArray = sort(paramIDArray);  
        	        	
        	        	for(var j=0;j<paramIDArray.length;j++){
        	        		var paramId = paramIDArray[j];
        	        		queryMsg+=mapMsg[paramId];
        	        	}

        	        	var queryButtonMsg = "";
        	        	if(queryMsg != ''){
        	        		
        	        		queryMsg +="<input type='hidden' name='queryName' id='queryName' value='"+queryName+"' />  ";
        	        		
        	        		queryButtonMsg +="<a class='btn-filter' href='javascript:void(0)'>查询</a>";
         	        	}
        	        	
        	        	$("#queryMsg").html(queryMsg); 
        	        	$("#queryButton").html(queryButtonMsg);
        	        	bindClickEvent();
        	        }
        		}else{
        			Ego.error("这要提示接口业务错误 异常",null);
        		} 
        		
        	}else{
        		var errors = resultData.errors;
        		var errorMsg  = errors.errorMsg;
        		Ego.error(errorMsg,null);
        	} 
        }
    });  
}




/**
 * 校验条件
 */
function check(){ 
	if(stdQueryChecks != "" && stdQueryChecks.length>0){
		for(var i=0;i<stdQueryChecks.length;i++){
			var stdQuery =stdQueryChecks[i]; 
			var idx = stdQuery.Idx; //较验顺序
			if(i == idx){
				var validateType = stdQuery.ValidateType;
				var paramToValidate = stdQuery.ParamToValidate;  //参数
				var summary = stdQuery.Summary;
				if(validateType =='Required'){
					var inputValue = $("#"+paramToValidate).val();
					if(inputValue == ''){
						Ego.error(summary,null);
						return ;
					}
				}
			}
		}
	}
	return true;
}




/**
 * 设置查询条件的元素
 * @param queryM
 * @returns {String}
 */
function createTitle(queryM){
	var paramID = queryM.paramid; //顺序字段
	var paramName= queryM.paramname; //参数名
	var displayLabel = queryM.displaylabel; //中文描述
	var paramtype = queryM.paramtype;  //查询类型
	
	var queryStr = "";
	if(paramtype.indexOf("String") != -1){ //文本框
		queryStr +="<small>";
		queryStr +="<label class=''>";
		queryStr +=" <i class='icon-search f-95'></i><input class='filter border-radius bg-color' placeholder='"+displayLabel+"' id='"+paramName+"' type='text'  name='"+paramName+"' /> ";
		queryStr +="</label> ";
		queryStr +="</small>";
	}else if(paramtype.indexOf("List") != -1){ //下拉框 
		var picklist = queryM.picklist; 
		queryStr +="<small>";
		queryStr +="<label class='filter-select dropdown-wrap '>";
		queryStr +="	<input type='hidden' name='"+paramName+"' id='"+paramName+"' > ";
		queryStr +="	<a id='"+paramName+"-id' class='dropdown-btn border border-radius bg-color dropdown-toggle' href='#' data-toggle='dropdown' role='button' aria-haspopup='true' aria-expanded='true'>";
		queryStr +="		<span>"+displayLabel+"</span>";
		queryStr +="		<span class='dr'><img src='"+resourceHost+"/images/arrow-black.png'/></span>";
		queryStr +="	</a>";
		queryStr +="	<ul id='"+paramName+"-menu' pid='"+paramName+"' class='dropdown-menu' aria-labelledby='"+paramName+"-id'>"; 
		if(picklist != ''){
			var pickArray = picklist.split(";");
			for(var i=0;i<pickArray.length;i++){
				var pick = pickArray[i];
				if(pick != ''){
					var pk = pick.split(".");
					queryStr +="<li value='"+pk[0]+"'>"+pk[1]+"</li>";
				}  
			}
		}
		
		queryStr +="	</ul>";
		queryStr +="</label>"; 
		queryStr +="</small>";
	}else  if(paramtype.indexOf("Date") != -1){ //日期类型   年月 日   Date ,Date%,%Date% ,EndDate 都一样的  ,pType格式与datetimepicker控制的格式
		 var defaultvalue = queryM.defaultvalue; //默认时间
 		 var date_ = getNowFormatDate(defaultvalue);
		 
		 queryStr +="<small class='report-time'>";
		 queryStr +="	<span class='i-name'>"+displayLabel+":</span>";
		 queryStr +="	<label class='filter-select dropdown-wrap'>";
		 queryStr +="		<input id='"+paramName+"' name='"+paramName+"' pType='Y-m-d' class='filter border-radius bg-color' type='text' value='"+date_+"'/>";
		 queryStr +="		<span class='dr'><img src='"+resourceHost+"/images/arrow-black.png'></span>";
		 queryStr +="	</label>";
		 queryStr +="</small>";
	}else if(paramtype == 'StdQuery' || paramtype =='VendorNO'){  //弹框查询的
		var sqlName = queryM.sql;
		queryStr +="<small>";
		queryStr +="<label class=''>";
		//queryStr +=" <input   id='"+paramName+"' type='hidden'  name='"+paramName+"' /> ";
		queryStr +=" <input class='filter border-radius bg-color' placeholder='"+displayLabel+"' id='"+paramName+"' type='text'  name='"+paramName+"' /> ";
		queryStr +=" <span class='dr alert-select' id='"+paramName+"_alt' pid='"+paramName+"' pName='"+displayLabel+"' sqlName='"+sqlName+"'> ";
		queryStr +=" <img src='"+resourceHost+"/images/icon-select.png'/></span> ";
		queryStr +="</label> ";
		queryStr +="</small>";
	}else{
		queryStr +="<small>";
		queryStr +="<label class=''>";
		queryStr +=" <i class='icon-search f-95'></i><input class='filter border-radius bg-color' placeholder='"+displayLabel+"' id='"+paramName+"' type='text'  name='"+paramName+"' /> ";
		queryStr +="</label> ";
		queryStr +="</small>";
	}
	
	return queryStr;
}
/**
 * 绑定点击事件
 */
function  bindClickEvent(){
	//下拉框绑定事件
	$('.filter-select').each(function(){
		 var pid = $(this).find('ul').attr('pid');
		 $("#"+pid+"-menu li").click(function(){ 
			 var litext = $(this).text();
			 var livalue =  $(this).attr("value");  
			 $("#"+pid+"-id").find("span").eq(0).text(litext);
			 $("#"+pid+"").val(livalue); 
		 });
	});
	
	//日期绑定事件
	var isTime = false;
	$('.report-time').each(function(){
		 var id = $(this).find('input').attr('id');
		 var pType = $(this).find('input').attr('pType');
		 $('#'+id).datetimepicker({
		      	format:pType,      //格式化日期
		      	timepicker:false,    //开启时间选项
		      	yearStart:2000,     //设置最小年份
		     	yearEnd:2050,        //设置最大年份
		      	todayButton:false    //关闭选择今天按钮
		 });
		 isTime=true;
	});
	if(isTime){
		$.datetimepicker.setLocale('ch'); //日期插件设置为中文
	}
	//弹框查询事件
	$('.alert-select').each(function(){
		
		var id = $(this).attr('id');
		var pid = $(this).attr('pid');
		var pName = $(this).attr('pName'); 
		var sqlName = $(this).attr('sqlName');
		$('#'+id).on('click',function(){
			seletNO("reportAlertPage?hiddenId="+pid+"&hiddenName="+pid+"_text&sqlName="+sqlName,pName);
		});
	});
	
}



/**
 * 设置结果	
 * index  分页显示
 * type : parent 表示父页面  child 表示子页面， 用于点击子页面上行后，回显到父页面文本框中
 */
function  loadDataMsg(index,type){
	var backTextNO = ""; // 需要带回到父页面的属性名
	if(type == 'child'){
		backTextNO = $("#hiddenId").val(); 
	}
	
	
	 var layerindex = layer.load(0, {shade: [0.2, '#393D49']});  
	  var menuId = $("#menuId").val(); 
	  var selectMsg = "&";
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
	        url:webHost+'/data/generalReport/idcReportMsg' ,
	        data:'currentPage='+index+'&pageSize='+pageSize+''+selectMsg,
	    //  data:selectMsg,
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
 	        			//设置内容
 	 		        	var titleArray = [];
 	 		        	var dataList = data.dataList;  //内容 
 	 		        	if(dataList.length >0){
 	 		        		var dataMsg = "";
 	 		        		for(var i=0;i<dataList.length;i++){
 	 		        			var dataM = dataList[i];  
 	 		        			
 	 		        			var trOnclickMsg = "";
 	 		        			var tdMsg ="";
 	 		        			for(var k in dataM){ 
 	 		        				tdMsg +="<td id='"+k+"'>"+dataM[k]+"</td>";	        				
 	 		        				if(i ==0){   //取第一个，用于标题展示顺序
 	 		        					titleArray.push(k);
 	 		        				}
 	 		        				
 	 		        				if(type == 'child'){    //回显示列值
 	 		        					 if(k == backTextNO){
 	 		        						trOnclickMsg +=" onclick= bindTrClicked('"+backTextNO+"','"+dataM[k]+"') ";
 	 		        					 }
 	 		        				}
 	 		        			}
 	 		        			dataMsg +="<tr "+trOnclickMsg+"> "+tdMsg+" </tr>"; 
 	 		        		}
 	 	 	        		$("#dataMsg").html(dataMsg);
 	 	 	        		
 	 	 	        		
 	 	 	        		var dictionary = data.dictionary;  //标题
 	 	 	 	        	//设置标题
 	 	 		        	var dataTitle = "<tr>";
 	 	 		        	if(titleArray != null && titleArray.length>0){
 	 	 		        		for(var j=0;j<titleArray.length;j++){
 	 	 		        			var titleKey = titleArray[j];
 	 	 	 	        			dataTitle +="<th data-toggle='true'>"+dictionary[titleKey]+"</th>";
 	 	 		        		}
 	 	 		        	}
 	 	 		        	dataTitle += "</tr>";  
 	 	 	        		$("#dataTitle").html(dataTitle); 
 	 	 		        	 
 	 	 	        		//分页
 	 	 		        	var totalCount = resultData.totalCount; //总数
 	 	 		        	var toalPage = resultData.toalPage;  //页数
 	 	 		        	var currentPage = resultData.currentPage; // 当前面
 	 	 		        	
 	 	 		        	var dataPage = {};
 	 	 		        	dataPage["index"]=currentPage;
 	 	 		        	dataPage["limit"]=pageSize;
 	 	 		        	dataPage["total"]=totalCount;
 	 	 		        	 
 	 	 		        	
 	 	 		        	  //设置分页 
 	 	 		            var pageHtml = ajaxPager.render(dataPage, function(page) {
 	 	 		        	   loadDataMsg(page.index,type);
 	 	 		     		});
 	 	 		            $('div').remove('.navigation_bar');
 	 	 		     		$('.generalReport .batch').append(pageHtml);  
 	 	 	        		
 	 	 		         	$('.oper').show();
	 	 	 		         	
	 	 	 		     	//表格单元格宽度均分
	 	 	 		     	var $td = $('.table-box table tbody tr td');
	 	 	 		     	$td.css({'width': 100/$td.length + '%'});
 	 	 	        		
 	 		        	}else{
 	 		        		$("#dataMsg").html("");
 	 		        		$('.generalReport .batch').html("");
 	 		        		Ego.dialog("未找到匹配数据",null);
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



/**
 * 数组排序
 * @param array
 * @returns
 */
function sort(array){
	for(var i=0;i<array.length-1;i++){  
		  for(var j=i+1;j<array.length;j++){  
		         if(array[i]>array[j]) {  
		             temp=array[i];  
		             array[i]=array[j];  
		             array[j]=temp;  
		         } 
		  }
	} 
	return array;
}

/**
 * 获取时间
 * @param defaultvalue
 * @returns {String}
 */
function getNowFormatDate(defaultvalue) {
    var seperator1 = "-"; 
	var dd = new Date(); 
	dd.setDate(dd.getDate()+Number(defaultvalue));//获取AddDayCount天后的日期 
	var y = dd.getFullYear(); 
	var m = dd.getMonth()+1;//获取当前月份的日期 
	var d = dd.getDate(); 
	var currentdate =  y+"-"+Appendzero(m)+"-"+Appendzero(d); 
	return currentdate;
}

function Appendzero(obj)  
{  
    if(obj<10) return "0" +""+ obj;  
    else return obj;  
} 



/* 选择 窗口 */
function seletNO(content_url,titleName) { 
	layer.open({
		type : 2,
		title : titleName,
		shadeClose : true,
		shade : 0.6,
		area : [ '60%', '80%' ],
		content : content_url
	});
}

function bindTrClicked(backTextNo,selectValue){
	 parent.getSelectNo(backTextNo,selectValue);
	 var index = parent.layer.getFrameIndex(window.name); // 先得到当前iframe层的索引
	 parent.layer.close(index); // 再执行关闭
}