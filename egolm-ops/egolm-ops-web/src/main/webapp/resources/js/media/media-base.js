function loadCommonMsg(memuId,sCommonNo){
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/common/queryByCommonNo',
        data:'sCommonNo='+sCommonNo,
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {  
        	var dataResult = eval("(" + data + ")");
         	var isValid = dataResult.IsValid;
         	if(isValid){
        		var dataList = dataResult.DataList ; 
            	if(dataList.length>0){ 
					 var memuMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 memuMsg+="<li value='"+data.sComID+"'>"+data.sComDesc+"</li> "; 
					 }
					 $("#"+memuId).html(memuMsg); 
				 } 
        	}else{
        		var returnValue = data.ReturnValue; 
        		$("#check-msg").text(returnValue)
        		$('#successAlert').modal('show');  
        	}
        }
    }); 
}

/**
 * 根据级别查询组织机构 并根据角色返回全国 
 * @param memuId
 * @param nOrgLevel
 * @param load   当有值是，需要加载全国的区域编码，为空时，不加载
 */
function loadTOrgsAndAll(memuId,nOrgLevel,load){
	var loadAll = "";
	if(load != ''){
		loadAll +='&type=1';
	}
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/org/queryTOrgsByLevel',
        data:'nOrgsLevel='+nOrgLevel+''+loadAll,
        async: false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {  
        	var dataResult = eval("(" + data + ")");
         	var isValid = dataResult.IsValid;
         	if(isValid){
        		var dataList = dataResult.DataList ; 
            	if(dataList.length>0){ 
            		var memuMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 memuMsg+="<li value='"+data.sOrgNO+"'>"+data.sOrgDesc+"</li> "; 
					 }
					 
					 $("#"+memuId).html(memuMsg); 
				 } 
        	}else{
        		var returnValue = data.ReturnValue; 
        		$("#check-msg").text(returnValue)
        		$('#successAlert').modal('show');  
        	}
        }
    }); 
}

/**
 * 根据级别查询组织机构
 * @param memuId
 * @param nOrgLevel
 */
function loadTOrgs(memuId,nOrgLevel){
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/org/queryTOrgsByLevel',
        data:'nOrgsLevel='+nOrgLevel,
        async: false,
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {  
         	var dataResult = eval("(" + data + ")");
          	var isValid = dataResult.IsValid;
          	if(isValid){
        		var dataList = dataResult.DataList ; 
            	if(dataList.length>0){ 
					 var memuMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i];
						 memuMsg+="<li class='org-item' value='"+data.sOrgNO+"'>"+data.sOrgDesc+"</li> "; 
					 } 
					 $("#"+memuId).html(memuMsg); 
				 } 
        	}else{
        		var returnValue = data.ReturnValue; 
        		$("#check-msg").text(returnValue)
        		$('#successAlert').modal('show');  
        	}
        }
    }); 
}



//设置图片
function preview(file){ 
	if(file.files && file.files[0]){ 
		var reader = new FileReader(); 
		if(typeof FileReader==='undefined'){ 
			console.log("浏览器不支持FileReader");
		}else{
			console.log("浏览器支持FileReader");
		} 
		reader.readAsDataURL(file.files[0]);  
		 
		reader.onload = function(evt){   
			console.log("读 取完成"); 
			$("#pic-src-id").attr("src",evt.target.result); 
		},
		reader.onerror = function(evt){   
			console.log("读 取出错"); 
		},
		reader.onabort = function(evt){   
			console.log("读 取中断"); 
		},
		reader.onloadstart = function(evt){   
			console.log("读 取开始"); 
		}
	}else{ 
	} 
}

function previewFile(file){
	if(file.files && file.files[0]){ 
		var reader = new FileReader(); 
		if(typeof FileReader==='undefined'){ 
			console.log("浏览器不支持FileReader");
		}else{
			console.log("浏览器支持FileReader");
		} 
		reader.readAsBinaryString(file.files[0]);  
		 
		reader.onload = function(evt){   
			console.log("读 取完成");
		},
		reader.onerror = function(evt){   
			console.log("读 取出错"); 
		},
		reader.onabort = function(evt){   
			console.log("读 取中断"); 
		},
		reader.onloadstart = function(evt){   
			console.log("读 取开始"); 
		}
	}else{ 
	} 
}



$.fn.serializeObject = function()    
{    
   var o = {};    
   var a = this.serializeArray();    
   $.each(a, function() {    
       if (o[this.name]) {    
           if (!o[this.name].push) {    
               o[this.name] = [o[this.name]];    
           }    
           o[this.name].push(this.value || '');    
       } else {    
           o[this.name] = this.value || '';    
       }    
   });    
   return o;    
};  



$.fn.serializeObject1 = function(){ 
	var formData = new FormData();  
	   var a = this.serializeArray(); 
	   $.each(a, function() {   
	       formData.append(this.name,this.value);
	   });    
   return formData;    
};  
 

function Trim(str)
{ 
    return str.replace(/(^\s*)|(\s*$)/g, ""); 
}

