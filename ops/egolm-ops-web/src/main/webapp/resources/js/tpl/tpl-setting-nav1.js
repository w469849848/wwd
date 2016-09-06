jQuery(function($){
	categoryShow();
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
   //解析json数据
   if(!!JsonData){
	   var jsonObject = JSON.parse(JsonData);

	   if(!!JSON.stringify(jsonObject['ap_M'])){
		   var obj_M = jsonObject['ap_M'];
		   saveAdPos(obj_M['nApID'],obj_M['sApPathUrl'],'ap_M','show');
	   }
	   if(!!JSON.stringify(jsonObject['ap_R'])){
		   var obj_R = jsonObject['ap_R'];
		   saveAdPos(obj_R['nApID'],obj_R['sApPathUrl'],'ap_R','show');
	   }
	   if(!!JSON.stringify(jsonObject['nav'])){
		   saveZoneNav(JSON.stringify(jsonObject['nav']));
	   }
   }
});

function categoryShow(){
	$('#category>ul.clearfix>li').on({
		mouseover:function(){
			$(this).find('div.sort-content').removeClass('hide');
			$(this).siblings().find('div.sort-content').addClass('hide');
		},
		mouseout:function(){
			$(this).find('div.sort-content').addClass('hide');
		}
	});
}

/**
 * 保存广告位数据
 * @param nApID 广告位ID
 * @param sApPathUrl 广告位地址
 * @param sign 
 */
function saveAdPos(nApID, sApPathUrl, sign, isShow){
	
	if(isShow != "show"){
		if(!checkAp(sign,nApID)){
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
	
	if(sign == 'ap_M'){
		$('#ap_M').attr("ap_M", JSON.stringify(apObj));
		var data = queryAds(nApID,sBelongNo);
		if(data != "" && data != null){
			var result = showAd(data,"ap_M_slide");
			if(result != "" && result != null){
				$('#ap_M>div.item-wrap').empty().append(result);
			}else{
				$('#ap_M>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else{
			$('#ap_M>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
		}
		result = true;
	}else if(sign == 'ap_R'){
		$('#ap_R').attr("ap_R", JSON.stringify(apObj));
		var data = queryAds(nApID,sBelongNo);
		if(data != "" && data != null){
			var result = showAd(data,"ap_R_slide");
			if(result != "" && result != null){
				$('#ap_R>div.notice-ad-item').empty().append(result);
			}else{
				$('#ap_R>div.notice-ad-item').empty().append(dafultShowAp(sApPathUrl));
			}
		}else{
			$('#ap_R>div.notice-ad-item').empty().append(dafultShowAp(sApPathUrl));
		}
		result = true;
	}else{
		layer.alert("获取广告位异常", {icon: 2}, function(index){
			layer.close(index);
		});
	}
	
	return result;
}

/**
 * 获取专区导航数据
 * @param paramJson
 */
function saveZoneNav(paramJson){
	var result = false;
	console.log("获取导航数据"+paramJson);
	if(!!paramJson){
		var navArray = JSON.parse(paramJson);
		var navStr = "";
		for(var i=0,length=navArray.length; i<length; i++){
			navStr += "<li href='#' sTplNo='"+navArray[i]['sTplNo']+"'>"+navArray[i]['sTplName']+"</li>";
		}
		$('#nav>ul.clearfix').empty().append(navStr);
		result = true;//执行成功返回true
	}else{
		layer.alert("获取专区导航异常", {icon: 2}, function(index){
			layer.close(index);
		});
	}
	return result ;
}

/**
 * 组装Json数据结构
 */
function packageJson(){
	var jsonObject = {};
	
	if(!!$('#ap_M').attr('ap_M') || !!$('#ap_R').attr('ap_R')){
		jsonObject['ap_M'] = JSON.parse($('#ap_M').attr('ap_M'));
		jsonObject['ap_R'] = JSON.parse($('#ap_R').attr('ap_R'));
	}else{
		layer.alert("存在广告位未配置数据", {icon: 3}, function(index){
			layer.close(index);
		});
		return;
	}
	
	var navArr = [];
	$('#nav>ul.clearfix>li').each(function(){
		var navObj = {};
		navObj['sTplNo'] = $(this).attr('sTplNo');
		navObj['sTplName'] = $(this).html();
		navArr.push(navObj);
	});
	
	jsonObject['nav'] = navArr;
	
	console.log("组装的json数据结构=="+JSON.stringify(jsonObject));
	$('input[name="sLayoutContent"]').val(JSON.stringify(jsonObject));
	$('#tplSettingForm').submit();
}


/**
 * 检查广告位是否被选择
 * @param nApID
 */
function checkAp(sign, nApID){
	
	if(JsonApID.indexOf("["+nApID+"]") > 0){
		layer.alert("此广告位已被选择，请重新选择", {icon: 2}, function(index){
			layer.close(index);
		});
		return false;
	}
	
	if(sign == "ap_M"){
		if(!!$('#ap_R').attr('ap_R')){
			var obj = $('#ap_R').attr('ap_R');
			if(obj['nApID'] == nApID){
				layer.alert("此广告位已被选择，请重新选择", {icon: 2}, function(index){
					layer.close(index);
				});
				return false;
			}
		}
	}else{
		if(!!$('#ap_M').attr('ap_M')){
			var obj = $('#ap_M').attr('ap_M');
			if(obj['nApID'] == nApID){
				layer.alert("此广告位已被选择，请重新选择", {icon: 2}, function(index){
					layer.close(index);
				});
				return false;
			}
		}
	}
	
	return true;
}

