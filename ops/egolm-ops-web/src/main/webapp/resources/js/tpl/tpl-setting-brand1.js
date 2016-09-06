jQuery(function($){
	//表单异步提交
	$('#tplSettingForm').ajaxForm(function(data) { 
	  	var res = JSON.parse(data);
      	if(res.IsValid==true){
      		layer.alert(res.ReturnValue, {icon: 1}, function(index){
    			layer.close(index);
    		});
      	}else{
      		layer.alert(res.ReturnValue, {icon: 2}, function(index){
    			layer.close(index);
    		});
      	}
      	$("#cancelButton").val("返回");
   });
   /**解析json*/
	if(!!JsonData){
		var jsonObject = JSON.parse(JsonData);
		if(!!JSON.stringify(jsonObject['adPos'])){
			var adPosObj = jsonObject['adPos'];
			saveAdPos(adPosObj['nApID'],adPosObj['sApPathUrl'],'ap_L','show');
		}
		
		if(!!JSON.stringify(jsonObject['brand'])){
			saveBrand(JSON.stringify(jsonObject['brand']));
		}
	}
});


/**
 * 保存广告位
 * @param nApID 广告ID
 * @param sApPathUrl  图片地址
 * @param sign
 */
function saveAdPos(nApID, sApPathUrl, sign, isShow){
	
	if(isShow != "show"){
		if(!checkAp(nApID)){
			return false;
		}
	}
	
	var sBelongNo = $("input[name='sBelongNo']").val();
	
	nApID = nApID || '';
	sApPathUrl = sApPathUrl || '';
	
	var result = false;
	var apObj = {};
	apObj['nApID'] = nApID;
	apObj['sApPathUrl'] = sApPathUrl;
	
	$('#brand').attr('adPos',JSON.stringify(apObj));
	
	var data = queryAds(nApID,sBelongNo);
	if(data != "" && data != null){
		var result = showAd(data,"ap_L_slide");
		console.log(result);
		if(result != "" && result != null){
			$('#brand>ul.clearfix>li.ap-sign>div.brand-item>div.item-wrap').empty().append(result);
		}else{
			$('#brand>ul.clearfix>li.ap-sign>div.brand-item>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
		}
	}else{
		$('#brand>ul.clearfix>li.ap-sign>div.brand-item>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
	}

	result = true;
	return result;
}

/**
 * 保存品牌数据
 * @param brandJson
 */
function saveBrand(brandJson){
	var result = false;
	if(!!brandJson){
		var brandStr = "";
		var temp = "";
		var count = 0;
		var brandArray = JSON.parse(brandJson);
		if(brandArray.length > 0){
			for(var i=0; i<brandArray.length; i++){
				count += 1;
				
				temp += "<div class='brand-item'>";
					temp += "<a href='#' id='"+brandArray[i]['brandId']+"'><img src='"+brandArray[i]['imgPath']+"'/></a>";
				temp += "</div>";
				
				if(count == 2){
					brandStr += "<li class='brand-sign'>"+temp+"</li>";
					temp = "";
					count = 0;
				}
				if(i == brandArray.length - 1){
					brandStr += "<li class='brand-sign'>"+temp+"</li>";
				}
			}
			
			$("#brand>ul.clearfix>li.brand-sign").remove();
			$("#brand>ul.clearfix").append(brandStr);
			
			result = true;
			$('#brand').attr('brand', brandJson);
		}else{
			$("#brand>ul.clearfix>li.brand-sign").empty();
		}
	}else{
		$("#brand>ul.clearfix>li.brand-sign").empty();
	}
	
	return result;
}

/**
 * 获取品牌数据
 */
function getBrandJson(){
	var _this = $('#brand');
	if(!_this){
		layer.alert("获取品牌数据异常", {icon: 2}, function(index){
			layer.close(index);
		});
		return;
	}
	var value = "";
	value = _this.attr('brand');
	return value;
}

/**
 * 组装Json数据
 */
function packageJson(){
	var jsonObject = {};
	
	if($('#brand').attr('adPos') == "" || $('#brand').attr('adPos') == '{}'){
		layer.alert("未配置广告位数据", {icon: 2}, function(index){
			layer.close(index);
		});
		return ;
	}
	
	if($('#brand').attr('brand') == "" || $('#brand').attr('brand') == '[]'){
		layer.alert("未配置品牌数据", {icon: 2}, function(index){
			layer.close(index);
		});
		return ;
	}
	
	jsonObject['adPos'] = JSON.parse($('#brand').attr('adPos'));
	jsonObject['brand'] = JSON.parse($('#brand').attr('brand'));
	
	console.log("组装Json数据="+JSON.stringify(jsonObject));
	$('input[name="sLayoutContent"]').val(JSON.stringify(jsonObject));
	$('#tplSettingForm').submit();
	return ;
}

/**
 * 检查广告位是否被选择
 * @param nApID
 */
function checkAp(nApID){
	
	if(JsonApID.indexOf("["+nApID+"]") > 0){
		layer.alert("此广告位已被选择，请重新选择", {icon: 2}, function(index){
			layer.close(index);
		});
		return false;
	}

	return true;
}


