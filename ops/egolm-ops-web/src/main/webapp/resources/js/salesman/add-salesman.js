jQuery(function($) {
	
	initSalOrgTree();
	    
	$('#submit').on('click', function() { //保存编辑
		//提交代码
		if(check()){ //保存成功
			saveSalesFrom();
		}
	});
	 
	 $("#cancel").click(function(){
			window.location.href="toSalesManList";
	});
	 
		//业务员类型
	 loadCommonMsg("sSalType-menu","SalesManType");
	 var sSalType = $("#sSalType").val();
	 if(sSalType !=''){
		 $("#sSalType-type").find("span").eq(0).text(sSalType);
	 }
	 $("#sSalType-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#sSalType-type").find("span").eq(0).text(litext);
		 $("#nSalTypeId").val(livalue);
		 $("#sSalType").val(litext);
	 });
	  
});

function 	initSalOrgTree(){
		$.ajax({
			cache: false,
			contentType:false,
			processData : false,
			type: "GET",
			url:'initSalOrgTree',
			async: false,
			error: function(request) {
				alert("Connection error");
			},
			success: function(data) {
				var dataResult = eval("(" + data + ")");
				var isValid = dataResult.IsValid;
				var returnValue =  eval(''+dataResult.ReturnValue+'');
				if(isValid){
					var jsonDataTree = transData(returnValue, 'sOrgNO', 'sUpOrgNO', 'children');    
					console.log(jsonDataTree);    
					
					var categoryTreeMsg = "";
					function creatSelectTree(d){
							for(var i=0;i<d.length;i++){
								 categoryTreeMsg+="<li value="+d[i].sOrgNO+">";
								 categoryTreeMsg+="	<span class='item-name'>"+d[i].sOrgDesc+"</span>";
								 categoryTreeMsg+="	<ul class='lv-second'>";
								 if(d[i].children&&d[i].children.length){//如果有子集
									 for(var j=0;j<d[i].children.length;j++){
										 categoryTreeMsg+="<li value="+d[i].children[j].sOrgNO+">";
										 categoryTreeMsg+="	<span class='item-name'>"+d[i].children[j].sOrgDesc+"</span>";
										 categoryTreeMsg+="	<ul class='lv-third'>";
										 if(d[i].children[j].children&&d[i].children[j].children.length){//如果有子集
											 for(var k=0;k<d[i].children[j].children.length;k++)
												 categoryTreeMsg+="	 <li value="+d[i].children[j].children[k].sOrgNO+"><span class='item-name'>"+d[i].children[j].children[k].sOrgDesc+"</span></li>";
										 }
										 categoryTreeMsg+="			</ul>";
										 categoryTreeMsg+="		</li>"; 
									 }
//									 		categoryTreeMsg+=creatSelectTree(d[i].children);//递归调用子集
						    	 }else{//没有子集直接显示
						     		categoryTreeMsg+="	 <li value="+d[i].sOrgNO+"><span class='item-name'>"+d[i].sOrgDesc+"</span></li>";
					    		 }
								 categoryTreeMsg+="			</ul>";
								 categoryTreeMsg+="		</li>"; 
					     	 }
				 	  return categoryTreeMsg;//返回最终html结果
					}
					//插入业务区域
					var menu = creatSelectTree(jsonDataTree);
					$("#dropdown-menu").html(menu);
					
					//三级菜单 --- 一级
					$('.lv-first>li').hover(function(){
						$('.lv-first').find('.select').removeClass('select');
						$(this).addClass('select').siblings().removeClass('select');
					},function(){});
					
					//三级菜单 --- 二级
					$('.lv-second>li').hover(function(){
						$('.lv-second').find('.select').removeClass('select');
						$(this).addClass('select').siblings().removeClass('select');
					},function(){});
					
					//第三级点击,显示选择信息
					$('.lv-third>li').on('click',function(e){ 
						var $this = $(this),
							lv3 = $this.find('.item-name').text(),
							lv2 = $this.parents('ul.lv-third:first').siblings('.item-name').text(),
							lv1 = $this.parents('ul.lv-second:first').siblings('.item-name').text();
						
						$this.parents('ul.lv-first:first').siblings('.dropdown-btn').find('.item-name').text(lv1 + ',' + lv2 + ',' + lv3);
						
						$('#sOrgNO').val($this.attr('value'));
						$('#sOrgDesc').val(lv3);
					});
					
					//重置选中状态
					$(document).on('click',function(){
						$('.lv-first').find('.select').removeClass('select');
					});
					
				}else{
					$("#check-msg-warr").text(returnValue)
					$('#warrAlert').modal('show');  
				}
			}
		}); 
}
 
/**   
 * json格式转树状结构   
 * @param   {json}      json数据   
 * @param   {String}    id的字符串   
 * @param   {String}    父id的字符串   
 * @param   {String}    children的字符串   
 * @return  {Array}     数组   
 */    
function transData(a, idStr, pidStr, chindrenStr){    
    var r = [], hash = {}, id = idStr, pid = pidStr, children = chindrenStr, i = 0, j = 0, len = a.length;    
    for(; i < len; i++){    
        hash[a[i][id]] = a[i];    
    }    
    for(; j < len; j++){    
        var aVal = a[j], hashVP = hash[aVal[pid]];    
        if(hashVP){    
            !hashVP[children] && (hashVP[children] = []);    
            hashVP[children].push(aVal);    
        }else{    
            r.push(aVal);    
        }    
    }    
    return r;    
}    

//关联业务员类型和所属机构
function changeSalBizZone(){
	var sSalType = $('#sSalType').val();
	var nSalTypeId = $('#nSalTypeId').val();
	if(nSalTypeId==1){//如果是万店易购，默认所属机构是万店易购
		$('#sAgentID').val(nSalTypeId);
		$('#sAgentName').val(sSalType);
		$('#zone-btn span:first').text(sSalType);
		$('#zone-btn').unbind();
	}else{
		$('#sAgentID').val("");
		$('#sAgentName').val("");
		$('#zone-btn span:first').text("请选择");
		$('#zone-btn').bind("click",function(){
			layer.open({
				type : 2,
				title : '选择经销商',
				shadeClose : true,
				shade : 0.6,
				area : [ '70%', '90%' ],
				content : 'toAgentList'
			});
		});
	}
}

//选择经销商后，更新所属机构值
function setSalBizZoneVal(nAgentID,sAgentNO,sAgentName){
	$('#sAgentID').val(nAgentID);
	$('#sAgentName').val(sAgentName);
	$('#zone-btn span:first').text(sAgentName);
	$('#sAgentNO').text(sAgentNO);
}

function check(){ 
	if($("#sSalNum").val()==""){ 
		$("#check-msg-warr").text("请填写业务员编号！")
		$('#warrAlert').modal('show');  
		$("#sSalNum").focus();
		return false;
	}else if($("#sSalNum").val().length>30){
		$("#check-msg-warr").text("业务员编号不能超过30个字数！")
		$('#warrAlert').modal('show');  
		$("#sSalNum").focus();
		return false;
	}
	if($("#sSalMemo").val().length>180){
		$("#check-msg-warr").text("备注不能超过180个字数！")
		$('#warrAlert').modal('show');  
		$("#sSalMemo").focus();
		return false;
	}
	if($("#sSalChineseName").val()==""){ 
		$("#check-msg-warr").text("请填写业务员姓名！")
		$('#warrAlert').modal('show');  
		$("#sSalChineseName").focus();
		return false;
	}else if($("#sSalChineseName").val().length>40){
		$("#check-msg-warr").text("业务员姓名不能超过40个字数！")
		$('#warrAlert').modal('show');  
		$("#sSalChineseName").focus();
		return false;
	}
	if($("#sSalEngName").val()==""){ 
		$("#check-msg-warr").text("请填写业务员英文名字！")
		$('#warrAlert').modal('show');  
		$("#sSalEngName").focus();
		return false;
	}else if($("#sSalEngName").val().length>15){
		$("#check-msg-warr").text("业务员英文名字不能超过15个字数！")
		$('#warrAlert').modal('show');  
		$("#sSalEngName").focus();
		return false;
	}
	 var reg = /^0?1[3|4|5|8][0-9]\d{8}$/;
	if($("#sSalMobileNo").val()==""){ 
		$("#check-msg-warr").text("请填写手机号码！")
		$('#warrAlert').modal('show');  
		$("#sSalMobileNo").focus();
		return false;
	}else if(!reg.test($("#sSalMobileNo").val())){
		$("#check-msg-warr").text("填写正确的手机号码！")
		$('#warrAlert').modal('show');  
		$("#sSalMobileNo").focus();
		return false;
	}
	if($("#sPassWord").val()==""){ 
		$("#check-msg-warr").text("请选择业务员密码！")
		$('#warrAlert').modal('show');  
		$("#sPassWord").focus();
		return false;
	}else if($("#sPassWord").val().length>100){
		$("#check-msg-warr").text("业务员密码不能超过100个字数！")
		$('#warrAlert').modal('show');  
		$("#sPassWord").focus();
		return false;
	}
	if($("#sOrgDesc").val()==""){ 
		$("#check-msg-warr").text("请选择业务区域！")
		$('#warrAlert').modal('show');  
		$("#sOrgDesc").focus();
		return false;
	}
	if($("#sSalTelNo").val()==""){ 
		$("#check-msg-warr").text("请填写电话/座机！")
		$('#warrAlert').modal('show');  
		$("#sSalTelNo").focus();
		return false;
	}else if(!($("#sSalTelNo").val().match(/\d{3}-\d{8}|\d{4}-\d{7}/))){
		$("#check-msg-warr").text("请填写正确的电话/座机！")
		$('#warrAlert').modal('show');  
		$("#sSalTelNo").focus();
		return false;
	}
	if($("#sSalType").val()==""){ 
		$("#check-msg-warr").text("请选择业务员类型！")
		$('#warrAlert').modal('show');  
		$("#sSalType").focus();
		return false;
	}
	return true;
}


function saveSalesFrom(){	
	var formData = $('#salesFrom').serializeObject1();   
	$.ajax({
        cache: false,
        contentType:false,
        processData : false,
        type: "POST",
        url:'saveSalesMan',
        data: formData,
        async: false,
        error: function(request) {
            alert("Connection error");
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")");
        	console.log("dataResult="+dataResult);
        	var isValid = dataResult.IsValid;
        	var returnValue = dataResult.ReturnValue 
        	if(isValid){
        		$("#check-msg").text(returnValue)
        		$('#successAlert').modal('show');  
        	}else{
        		$("#check-msg").text(returnValue)
        		$('#successAlert').modal('show');  
        	}
        }
    }); 
}
