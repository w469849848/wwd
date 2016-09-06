function loadCommonMsg(memuId,sCommonNo){
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/common/queryByCommonNo',
        data:'sCommonNo='+sCommonNo,
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

function loadTOrgs(memuId,nOrgLevel){
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/org/queryTOrgsByLevel',
        data:'nOrgsLevel='+nOrgLevel,
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