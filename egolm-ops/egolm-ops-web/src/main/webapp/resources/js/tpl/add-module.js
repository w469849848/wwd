jQuery(function($) {
/*
	$('#submit').on('click', function() { //保存编辑
		
		//提交代码
		
		if(true){ //保存成功
			$('#successAlert').modal('show');
		}
	});
*/
	//单选组radio -- 是否楼层
	$(".floor-wrap input.chk-radio").on('click',function(){
		/*var $this = $(this);
		$("input[name=nIsFloor]").attr('checked',false);*/
		if($(this).val() == "是"){
			$("#floor_Y").attr('checked',true);
			$("#floor_N").attr('checked',false);
		}else{
			$("#floor_Y").attr('checked',false);
			$("#floor_N").attr('checked',true);
		}
	});
	
	$(".module-option").on('click',function(){
		$("#nModuleType").val($(this).text());
		$("#nModuleTypeText").text($(this).text());
	});
	
	$(".display-option").on('click',function(){
		$("#sDisplayNo").val($(this).attr("val"));
		$("#sDisplayArea").val($(this).text());
		$("#displayAreaText").text($(this).text());
	});
	
	//表单异步提交
	  $('#moduleForm').ajaxForm(function(data) {   
		  	var res = JSON.parse(data);
	      	if(res.IsValid==true){
	      		layer.alert(res.ReturnValue, {icon: 1}, function(index){
        			layer.close(index);
        			window.location.href="list"; 
        		});
	      	}else{
	      		layer.alert(res.ReturnValue, {icon: 2}, function(index){
        			layer.close(index);
        		});
	      	}
	    }); 
});



//处理表单
function commitForm(){
	if(validatorForm()){
		$("#moduleForm").submit();
	}
}

//表单验证
function validatorForm(){
	if($.trim($("#sModuleName").val())==""){
		$("#sModuleName").tips({
			side:2,
			msg:'模块名称不能为空',
			time:2,
			x:15,
			y:10
		});
		return false;
	}
	
	var nIsFloor = $('input:radio[name="nIsFloor"]:checked').val();
	if(nIsFloor == undefined){
		$("#nIsFloor").tips({
			side:2,
			msg:'请选择是否楼层',
			time:2,
			x:15,
			y:-450
		});
		return false;
	}
	
	if($("#nModuleType").val()==""){
		$("#moduleType").tips({
			side:2,
			msg:'请选择模块类别',
			time:2,
			x:15,
			y:10
		});
		return false;
	}
	
	if($("#sDisplayNo").val()==""){
		$("#display_area").tips({
			side:2,
			msg:'请选择适用范围',
			time:2,
			x:15,
			y:10
		});
		return false;
	}
	
	if($.trim($("#sPcPath").val())==""){
		$("#sPcPath").tips({
			side:2,
			msg:'PC端界面模板路径',
			time:2,
			x:15,
			y:10
		});
		return false;
	}
	if($.trim($("#sWxPath").val())==""){
		$("#sWxPath").tips({
			side:2,
			msg:'WX端界面模板路径',
			time:2,
			x:15,
			y:10
		});
		return false;
	}
	if($.trim($("#sBgPath").val())==""){
		$("#sBgPath").tips({
			side:2,
			msg:'后台管理界面模板路径',
			time:2,
			x:15,
			y:10
		});
		return false;
	}
	
	return true;
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