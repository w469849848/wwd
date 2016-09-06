
var nModuleType="";
jQuery(function($) {
	
		//提交表单
	  	/*if(true){ //保存成功
			$('#successAlert').modal('show');
	  	}*/
		//调价模块弹窗样式调整
		$('.add-tpl .tpl-nav ul li').css({'width': (100/$('.add-tpl .tpl-nav ul li').length) + '%'});
		
		//添加模块
		$('#btn-add-tpl').on('click',function(){
			
			$('#addTplAlert').modal('show');
			loadModuleList(1);
			
		});
		
		//添加模板--切换分类
		$('.tpl-nav ul li').on('click',function(){
			nModuleType = $(this).attr("moduleType");
			$(this).addClass('active').siblings().removeClass('active');
			loadModuleList(1);
		});
		//表单异步提交
		$('#tplForm').ajaxForm(function(data) { 
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

/*异步加载添加模板列表*/
function loadModuleList(index){
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/template/module/ajaxlist',
        data:'nModuleType='+nModuleType+'&page.index='+index, 
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
					 var html="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i]; 
						 
						html=html+"<li>"
						+"<div class='tpl-item clearfix'>"
						+"<div class='pic pull-left'>"
						+"<img src='http://img.egolm.com"+data.sMiniPic+"' width='161px' height='67px'/>"
						+"</div>"
						+"<div class='intro pull-left'>"
						+"<h1>"+data.sModuleName+"</h1>"
						+"<p>"+data.sRemark+"</p>"
						+"</div>"
						+"<div class='btn-wrap pull-left' onclick=\"addItem('"+data.sModuleNo+"','"+data.sModuleName+"')\">"
						+"<a class='detail' href='javascript:void(0)'>加入</a>"
						+"</div>"
						+"</div>"
						+"</li>";
					 }
					 $("#moduleListUL").html(html);
				 }else{
					 $("#moduleListUL").html("没有找到记录");
				 }
          	}else{
          		$("#moduleListUL").html("加载数据异常");
        		var returnValue = dataResult.ReturnValue;
        		 Ego.error(returnValue,null);
        	}
        	//设置分页  
          	var pageHtml = ajaxPager.render(dataResult.page, function(page) {
          		loadModuleList(page.index);
			});
			$('#paginationDiv').html(pageHtml);
        }
    }); 
}


//处理表单
function commitForm(){
	if(validatorForm()){
		$("#tplForm").submit();
	}
}

//表单验证
function validatorForm(){
	
	if($.trim($("#sTplName").val()) == ""){
		$("#sTplName").tips({
			side:2,
            msg:'请填写模板名称',
            time:2,
            x:15,
            y:10
        });
		$("#sTplName").focus();
		return false;
	}
	
	if(!!!$("#sBelongNo").val()){
		$("#belong_area").tips({
			side:2,
			msg:'请选择所属区域',
			time:2,
			x:15,
			y:10
		});
		return false;
	}else{
		$("input[name='sBelongArea']").val($('#belong_area>a.dropdown-btn>span.item-name').html());
	}
	
	if(!!!$("#sScopeTypeID").val()){
		$("#scope_area").tips({
			side:2,
			msg:'请选择店铺类型',
			time:2,
			x:15,
			y:10
		});
		return false;
	}else{
		$("input[name='sScopeType']").val($('#scope_area>a.dropdown-btn>span.item-name').html());
	}
	
	if(!!!$("#sDisplayNo").val()){
		$("#display_area").tips({
			side:2,
			msg:'请选择使用范围',
			time:2,
			x:15,
			y:10
		});
		return false;
	}else{
		$("input[name='sDisplayArea']").val($('#display_area>a.dropdown-btn>span.item-name').html());
	}
	
	if(!!!$("#nIsHome").val()){
		$("#is_home").tips({
			side:2,
			msg:'请选择页面类型',
			time:2,
			x:15,
			y:10
		});
		return false;
	}
	
	var flag =false;
	if($("#sortItems").find("li").size() > 0){
		var moduleArray = [];
		$("#sortItems").find("li").each(function(i){
			if($.trim($(this).find('input').val()) == ""){
				layer.alert("第"+(i+1)+"个模块名称未填写", {icon: 2}, function(index){
        			layer.close(index);
        		});
				flag = true;
				return false;
			}
			moduleArray.push($(this).attr("val")+"_"+(i+1)+"_"+$.trim($(this).find('input').val()));
		});
		$("#moduleItems").val(moduleArray.join(","));
		moduleArray = null;
	}else{
		$("#moduleTips").tips({
			side:2,
			msg:'请添加模块',
			time:2,
			x:15,
			y:5
		});
		return false;
	}
	
	if(flag){
		return false;
	}
	
	return true;
}
									
