jQuery(function($){
	//拖动排序
	sort();
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
	/**解析json数据*/
	if(!!JsonData){
		var jsonObject = JSON.parse(JsonData);
		if(jsonObject['floorName'] == "" || jsonObject['floorName'] == undefined){
			$("input[name='floorName']").val($('.tpl-nav>ul.clearfix>li.active>a').text());
		}else{
			$("input[name='floorName']").val(jsonObject['floorName']);
		}
		var datasArr = jsonObject['datas'];
		if(datasArr.length > 0){
			var tabStr = "";
			for(var i=0,length=datasArr.length; i<length; i++){
				var temp = "<li ap_L='"+JSON.stringify(datasArr[i]['ap_L'])+"' ap_R='"+JSON.stringify(datasArr[i]['ap_R'])+"' ap_1st='"+JSON.stringify(datasArr[i]['ap_1st'])+"' ap_2nd='"+JSON.stringify(datasArr[i]['ap_2nd'])+"' ap_3rd='"+JSON.stringify(datasArr[i]['ap_3rd'])+"' ap_4th='"+JSON.stringify(datasArr[i]['ap_4th'])+"' ap_5th='"+JSON.stringify(datasArr[i]['ap_5th'])+"' ap_6th='"+JSON.stringify(datasArr[i]['ap_6th'])+"' category='"+JSON.stringify(datasArr[i]['category'])+"' >";
					temp += "<a href='javascript:void(0)' onclick=\"selectTab(this)\"";
					if(i == 0){
						temp += " class='active'";
					}
					temp += ">";
						temp += "<span>"+datasArr[i]['name']+"</span>";
					temp += "</a>";
				temp += "</li>";
				tabStr += temp;
			}
			$('#floor_tab>ul').empty().append(tabStr);
			switchTab(JSON.stringify(datasArr[0]['ap_L']),JSON.stringify(datasArr[0]['ap_R']),JSON.stringify(datasArr[0]['ap_1st']),JSON.stringify(datasArr[0]['ap_2nd']),JSON.stringify(datasArr[0]['ap_3rd']),JSON.stringify(datasArr[0]['ap_4th']),JSON.stringify(datasArr[0]['ap_5th']),JSON.stringify(datasArr[0]['ap_6th']),JSON.stringify(datasArr[0]['category']));
		}
	}
	//导航个数超出4个宽度修正
	/*var $rGoodNav = $('#floor_tab ul li');
	$rGoodNav.css({'width': 100/$rGoodNav.length +'%'});*/
});

/**
 * 选项卡切换
 * @param obj
 */
function selectTab(obj){
	var _this = $(obj);
	var _parent = _this.parent();
	_this.parent().siblings().children("a").removeClass("active");
	_this.addClass("active");
	switchTab(_parent.attr('ap_L'), _parent.attr('ap_R'), _parent.attr('ap_1st'), _parent.attr('ap_2nd'), _parent.attr('ap_3rd'), _parent.attr('ap_4th'), _parent.attr('ap_5th'), _parent.attr('ap_6th'), _parent.attr('category'));
} 
/**
 * tab切换 展示不同tab的商品
 */
function switchTab(apLJson,apRJson,ap1stJson,ap2ndJson,ap3rdJson,ap4thJson,ap5thJson,ap6thJson,categoryJson){
	if(!isEmptyObject(apLJson) && apLJson != undefined && apLJson != '{}'){
		var apLObj = JSON.parse(apLJson);
		saveAdPos(apLObj['nApID'],apLObj['sApPathUrl'],'ap_L','show');
	}else{
		$('#ap_L>div.item-wrap').empty();
	}
	
	if(!isEmptyObject(apRJson) && apRJson != undefined && apRJson != '{}'){
		var apRObj = JSON.parse(apRJson);
		saveAdPos(apRObj['nApID'],apRObj['sApPathUrl'],'ap_R','show');
	}else{
		$('#ap_R>div.item-wrap').empty();
	}
	
	if(!isEmptyObject(ap1stJson) && ap1stJson != undefined && ap1stJson != '{}'){
		var ap1stObj = JSON.parse(ap1stJson);
		saveAdPos(ap1stObj['nApID'],ap1stObj['sApPathUrl'],'ap_1st','show');
	}else{
		$('#ap_1st>div.item-wrap').empty();
	}
	
	if(!isEmptyObject(ap2ndJson) && ap2ndJson != undefined && ap2ndJson != '{}'){
		var ap2ndObj = JSON.parse(ap2ndJson);
		saveAdPos(ap2ndObj['nApID'],ap2ndObj['sApPathUrl'],'ap_2nd','show');
	}else{
		$('#ap_2nd>div.item-wrap').empty();
	}
	
	if(!isEmptyObject(ap3rdJson) && ap3rdJson != undefined && ap3rdJson != '{}'){
		var ap3rdObj = JSON.parse(ap3rdJson);
		saveAdPos(ap3rdObj['nApID'],ap3rdObj['sApPathUrl'],'ap_3rd','show');
	}else{
		$('#ap_3rd>div.item-wrap').empty();
	}
	
	if(!isEmptyObject(ap4thJson) && ap4thJson != undefined && ap4thJson != '{}'){
		var ap4thObj = JSON.parse(ap4thJson);
		saveAdPos(ap4thObj['nApID'],ap4thObj['sApPathUrl'],'ap_4th','show');
	}else{
		$('#ap_4th>div.item-wrap').empty();
	}
	
	if(!isEmptyObject(ap5thJson) && ap5thJson != undefined && ap5thJson != '{}'){
		var ap5thObj = JSON.parse(ap5thJson);
		saveAdPos(ap5thObj['nApID'],ap5thObj['sApPathUrl'],'ap_5th','show');
	}else{
		$('#ap_5th>div.item-wrap').empty();
	}
	if(!isEmptyObject(ap6thJson) && ap6thJson != undefined && ap6thJson != '{}'){
		var ap5thObj = JSON.parse(ap6thJson);
		saveAdPos(ap5thObj['nApID'],ap5thObj['sApPathUrl'],'ap_6th','show');
	}else{
		$('#ap_6th>div.item-wrap').empty();
	}
	
	if(!isEmptyObject(categoryJson) && categoryJson != undefined && categoryJson != '[]'){
		saveCateGorys(categoryJson);
	}else{
		$('#category>p.clearfix').remove();
	}
}

/**
* 拖动排序
*/
function sort(){
	window.x = new Sortable(tabList, {
		group: "words",
		store: {
			get: function (sortable) {
				var order = localStorage.getItem(sortable.options.group);
				return order ? order.split('|') : [];
			},
			set: function (sortable) {
				var order = sortable.toArray();
				localStorage.setItem(sortable.options.group, order.join('|'));
			}
		}
	});
}


/**
* 二级导航名称编辑弹出框
*/
function openNav(){
	
	var navTemp = "";
	$("#floor_tab").find("ul>li").each(function(){
		var _this = $(this);
		navTemp += "<li ap_L='"+_this.attr("ap_L")+"' ap_R='"+_this.attr("ap_R")+"' ap_1st='"+_this.attr("ap_1st")+"' ap_2nd='"+_this.attr("ap_2nd")+"' ap_3rd='"+_this.attr("ap_3rd")+"' ap_4th='"+_this.attr("ap_4th")+"' ap_5th='"+_this.attr("ap_5th")+"' ap_6th='"+_this.attr("ap_6th")+"' category='"+_this.attr("category")+"' style='cursor:move;'>";
		navTemp += "<div class='border-radius'>";
		navTemp += "<a href='javascript:void(0)' onclick=\"removeNav(this);\"><img src='"+resourceHost+"/images/btn-delete.png'/></a>";
		navTemp += "<p>"+_this.find("a>span").text()+"</p>";
		navTemp += "</div>";
		navTemp += "</li>";
	});
	$('#tabNavModel').find('ul#tabList').html(navTemp);
	$('#tabNavModel').modal('show');
	navTemp = null;
	return;
	
}


/**
 * 增加导航模块
 */
function addNav(obj){
	var _input = $(obj).siblings("input[name='addtabnav']");
	var value = $.trim(_input.val());
	if(value == null || value == ""){
		_input.tips({
			side:1,
            msg:'请填写分类名称',
            time:2,
            x:0,
            y:200
        });
		_input.focus();
		return;
	}else{
		var flag = false;
		$('#tabList>li').each(function(){
			if(value == $(this).find('div.border-radius>p').text()){
				layer.alert("二级分类名称已创建,请重新输入", {icon: 2}, function(index){
					layer.close(index);
				});
				flag = true;
				return false;
			}
		});
		if(flag){
			return;
		}
		
		var navTemp = "";
		navTemp += "<li ap_L='' ap_R='' ap_1st='' ap_2nd='' ap_3rd='' ap_4th='' ap_5th='' ap_6th='' category='' style='cursor:move;'>";
		navTemp += "<div class='border-radius'>";
		navTemp += "<a href='javascript:void(0)' onclick=\"removeNav(this);\"><img src='"+resourceHost+"/images/btn-delete.png'/></a>";
		navTemp += "<p>"+value+"</p>";
		navTemp += "</div>";
		navTemp += "</li>";
		$('#tabNavModel').find('ul#tabList').append(navTemp);
		_input.val("");
		navTemp = null;
	}
	return ;
}

/**
 * 删除导航模块
 */
function removeNav(obj){
	if(obj != null){
		$(obj).parent().parent().remove();
	}
	return;
}

/**
 * 保存编辑好的导航名称
 */
function saveNav(){
	var navStr = "";
	$("#tabList>li").each(function(index){
		navStr += "<li ap_L='"+$(this).attr('ap_L')+"' ap_R='"+$(this).attr('ap_R')+"' ap_1st='"+$(this).attr('ap_1st')+"' ap_2nd='"+$(this).attr('ap_2nd')+"' ap_3rd='"+$(this).attr('ap_3rd')+"' ap_4th='"+$(this).attr('ap_4th')+"' ap_5th='"+$(this).attr('ap_5th')+"' ap_6th='"+$(this).attr('ap_6th')+"' category='"+$(this).attr('category')+"'>";
	    navStr += "<a";
	    if(index == 0){
	    	navStr += " class='active'";
	    	switchTab($(this).attr('ap_L'),$(this).attr('ap_R'),$(this).attr('ap_1st'),$(this).attr('ap_2nd'),$(this).attr('ap_3rd'),$(this).attr('ap_4th'),$(this).attr('ap_5th'),$(this).attr('ap_6th'),$(this).attr('category'));
		}
		navStr += " href='javascript:void(0)' onclick=\"selectTab(this)\">";
		navStr += "<span>"+$(this).find("div.border-radius>p").text()+"</span>";
		navStr += "</a>"
		navStr += "</li>";
	});
	if(navStr == ""){
		layer.alert("请填写二级分类名称", {icon: 2}, function(index){
			layer.close(index);
		});
		return;
	}
	$('#floor_tab > ul').empty().html(navStr);
	$('#tabNavModel').modal('hide');
	
	//导航个数超出4个宽度修正
	/*var $rGoodNav = $('#floor_tab ul li');
	$rGoodNav.css({'width': 100/$rGoodNav.length +'%'});*/
}

/**
 * 组装JSON数据结构
 */
function packageJson(){
	var jsonObject = {};
	var apArray = [];
	/**
	 * 楼层名称判断
	 */
	if($.trim($("input[name='floorName']").val()) == ""){
		layer.alert("请填写楼层名称", {icon: 3}, function(index){
			layer.close(index);
		});
		return;
	}else{
		jsonObject['floorName'] = $("input[name='floorName']").val();
	}
	
	var flag = false;
	$('#floor_tab>ul>li').each(function(index){
		var apObj = {};
		var _this = $(this);
		apObj['name'] = _this.find('a>span').text(); //获取tab名称
		if(_this.attr('ap_L') == "" || _this.attr('ap_R') == "" || _this.attr('ap_1st') == "" || _this.attr('ap_2nd') == "" || _this.attr('ap_3rd') == "" || _this.attr('ap_4th') == "" || _this.attr('ap_5th') == "" || _this.attr('ap_6th') == "" ){
			layer.alert("第"+(index + 1)+"个选项卡存在未配置广告位", {icon: 3}, function(index){
				layer.close(index);
			});
			flag = true;
			return false;
		}
		
		if(_this.attr('category') == "" || _this.attr('category') == null){
			layer.alert("第"+(index + 1)+"个选项卡未配置分类数据", {icon: 3}, function(index){
				layer.close(index);
			});
			flag = true;
			return false;
		}
		
		apObj['ap_L'] = JSON.parse(_this.attr('ap_L'));
		apObj['ap_R'] = JSON.parse(_this.attr('ap_R'));
		apObj['ap_1st'] = JSON.parse(_this.attr('ap_1st'));
		apObj['ap_2nd'] = JSON.parse(_this.attr('ap_2nd'));
		apObj['ap_3rd'] = JSON.parse(_this.attr('ap_3rd'));
		apObj['ap_4th'] = JSON.parse(_this.attr('ap_4th'));
		apObj['ap_5th'] = JSON.parse(_this.attr('ap_5th'));
		apObj['ap_6th'] = JSON.parse(_this.attr('ap_6th'));
		
		apObj['category'] = JSON.parse(_this.attr('category'));
		
		apArray.push(apObj);
	});
	
	if(flag){
		return ;
	}
	jsonObject['datas'] = apArray;
	$("input[name='sLayoutContent']").val(JSON.stringify(jsonObject));
	$("#tplSettingForm").submit();
}

/**
* 保存广告位
* @nApID 广告位ID
* @sApPathUrl 广告位图片路径
* @sign 广告位位置标记
* @isShow 判断是加载展示还是重新选取广告位展示
*/
function saveAdPos(nApID, sApPathUrl, sign, isShow){
	if(isShow != "show"){
		if(!checkAp(nApID,sign)){
			return false;
		}
	}
	
	var _this = $("#floor_tab").find('ul>li>a.active');
	if(!_this){
		layer.alert("请先配置二级分类", {icon: 3}, function(index){
			layer.close(index);
		});
		return;
	}
	
	var sBelongNo = $("input[name='sBelongNo']").val();
	
	nApID = nApID || '';
	sApPathUrl = sApPathUrl || '';
	var result = false;
	
	var apObj = {};
	apObj['nApID'] = nApID;
	apObj['sApPathUrl'] = sApPathUrl;
	
	if(sign != null || sign != ""){
		if('ap_L' == sign){
			_this.parent().attr("ap_L", JSON.stringify(apObj));
			var data = queryAds(nApID,sBelongNo);
			if(data != "" && data != null){
				var result = showAd(data,"ap_L_slide");
				if(result != "" && result != null){
					$('#ap_L>div.item-wrap').empty().append(result);
				}else{
					$('#ap_L>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
				}
			}else{
				console.log("==="+dafultShowAp(sApPathUrl));
				$('#ap_L>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else if('ap_R' == sign){
			_this.parent().attr("ap_R", JSON.stringify(apObj));
			var data = queryAds(nApID,sBelongNo);
			if(data != "" && data != null){
				var result = showAd(data,"ap_R_slide");
				if(result != "" && result != null){
					$('#ap_R>div.item-wrap').empty().append(result);
				}else{
					$('#ap_R>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
				}
			}else{
				$('#ap_R>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else if('ap_1st' == sign){
			_this.parent().attr("ap_1st", JSON.stringify(apObj));
			var data = queryAds(nApID,sBelongNo);
			if(data != "" && data != null){
				var result = showAd(data,"ap_1st_slide");
				if(result != "" && result != null){
					$('#ap_1st>div.item-wrap').empty().append(result);
				}else{
					$('#ap_1st>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
				}
			}else{
				$('#ap_1st>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else if('ap_2nd' == sign){
			_this.parent().attr("ap_2nd", JSON.stringify(apObj));
			var data = queryAds(nApID,sBelongNo);
			if(data != "" && data != null){
				var result = showAd(data,"ap_2nd_slide");
				if(result != "" && result != null){
					$('#ap_2nd>div.item-wrap').empty().append(result);
				}else{
					$('#ap_2nd>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
				}
			}else{
				$('#ap_2nd>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else if('ap_3rd' == sign){
			_this.parent().attr("ap_3rd", JSON.stringify(apObj));
			var data = queryAds(nApID,sBelongNo);
			if(data != "" && data != null){
				var result = showAd(data,"ap_3rd_slide");
				if(result != "" && result != null){
					$('#ap_3rd>div.item-wrap').empty().append(result);
				}else{
					$('#ap_3rd>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
				}
			}else{
				$('#ap_3rd>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else if('ap_4th' == sign){
			_this.parent().attr("ap_4th", JSON.stringify(apObj));
			var data = queryAds(nApID,sBelongNo);
			if(data != "" && data != null){
				var result = showAd(data,"ap_4th_slide");
				if(result != "" && result != null){
					$('#ap_4th>div.item-wrap').empty().append(result);
				}else{
					$('#ap_4th>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
				}
			}else{
				$('#ap_4th>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else if('ap_5th' == sign){
			_this.parent().attr("ap_5th", JSON.stringify(apObj));
			var data = queryAds(nApID,sBelongNo);
			if(data != "" && data != null){
				var result = showAd(data,"ap_5th_slide");
				if(result != "" && result != null){
					$('#ap_5th>div.item-wrap').empty().append(result);
				}else{
					$('#ap_5th>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
				}
			}else{
				$('#ap_5th>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else if('ap_6th' == sign){
			_this.parent().attr("ap_6th", JSON.stringify(apObj));
			var data = queryAds(nApID,sBelongNo);
			if(data != "" && data != null){
				var result = showAd(data,"ap_6th_slide");
				if(result != "" && result != null){
					$('#ap_6th>div.item-wrap').empty().append(result);
				}else{
					$('#ap_6th>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
				}
			}else{
				$('#ap_6th>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else{
			layer.alert("广告位数据获取失败", {icon: 2}, function(index){
    			layer.close(index);
    		});
		}
		result = true;
	}else{
		layer.alert("广告位数据获取失败", {icon: 2}, function(index){
			layer.close(index);
		});
	}
	return result;
}

/**
* 保存商品分类
* @paramJson 商品分类数组
*/
function saveCateGorys(paramJson){
	var _this = $("#floor_tab").find('ul>li>a.active');
	if(!_this){
		layer.alert("请先配置二级分类", {icon: 3}, function(index){
			layer.close(index);
		});
		return;
	}
	var result  = false;
	if(!!paramJson){
		var categoryStr = "";
		var temp = "";
		var count = 0;
		var categoryArray = JSON.parse(paramJson);
		if(categoryArray.length > 0){
			for(var i=0; i<categoryArray.length; i++){
				count += 1;
				if(i%2 == 0){
					temp += "<a href='#' class='fl'>"+categoryArray[i]['categoryName']+"</a>";
				}else{
					temp += "<a href='#' class='fr'>"+categoryArray[i]['categoryName']+"</a>";
				}
				if(count == 2){
					categoryStr += "<p class='clearfix'>"+temp+"</p>";
					temp = "";
					count = 0;
				}
				if(i == categoryArray.length - 1){
					categoryStr += "<p class='clearfix'>"+temp+"</p>";
				}
			}
			$("#category").find('p.clearfix').remove();
			$("#category").append(categoryStr)
			result = true;
			_this.parent().attr('category', paramJson);
		}else{
			$("#category").find('p.clearfix').remove();
		}
	}else{
		$("#category").find('p.clearfix').remove();
	}
	return result;
}

/**
 * 检查广告位是否被选择
 * @param nApID
 */
function checkAp(nApID,sign){
	
	if(JsonApID.indexOf("["+nApID+"]") > 0){
		layer.alert("此广告位已被选择，请重新选择", {icon: 2}, function(index){
			layer.close(index);
		});
		return false;
	}
	
	var flag = false;
	$('#floor_tab>ul>li').each(function(index){
		if($(this).children('a').hasClass('active')){
			if(sign == 'ap_L'){
				if(!!$(this).attr('ap_R')){
					var obj = JSON.parse($(this).attr('ap_R'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_1st')){
					var obj = JSON.parse($(this).attr('ap_1st'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_2nd')){
					var obj = JSON.parse($(this).attr('ap_2nd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_3rd')){
					var obj = JSON.parse($(this).attr('ap_3rd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_4th')){
					var obj = JSON.parse($(this).attr('ap_4th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_5th')){
					var obj = JSON.parse($(this).attr('ap_5th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_6th')){
					var obj = JSON.parse($(this).attr('ap_6th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
			}
			if(sign == 'ap_R'){
				if(!!$(this).attr('ap_L')){
					var obj = JSON.parse($(this).attr('ap_L'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				
				if(!!$(this).attr('ap_1st')){
					var obj = JSON.parse($(this).attr('ap_1st'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_2nd')){
					var obj = JSON.parse($(this).attr('ap_2nd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_3rd')){
					var obj = JSON.parse($(this).attr('ap_3rd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_4th')){
					var obj = JSON.parse($(this).attr('ap_4th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_5th')){
					var obj = JSON.parse($(this).attr('ap_5th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_6th')){
					var obj = JSON.parse($(this).attr('ap_6th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
			}
			if(sign == 'ap_1st'){
				if(!!$(this).attr('ap_L')){
					var obj = JSON.parse($(this).attr('ap_L'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_R')){
					var obj = JSON.parse($(this).attr('ap_R'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				
				if(!!$(this).attr('ap_2nd')){
					var obj = JSON.parse($(this).attr('ap_2nd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_3rd')){
					var obj = JSON.parse($(this).attr('ap_3rd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_4th')){
					var obj = JSON.parse($(this).attr('ap_4th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_5th')){
					var obj = JSON.parse($(this).attr('ap_5th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_6th')){
					var obj = JSON.parse($(this).attr('ap_6th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
			}
			if(sign == 'ap_2nd'){
				if(!!$(this).attr('ap_L')){
					var obj = JSON.parse($(this).attr('ap_L'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_R')){
					var obj = JSON.parse($(this).attr('ap_R'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_1st')){
					var obj = JSON.parse($(this).attr('ap_1st'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				
				if(!!$(this).attr('ap_3rd')){
					var obj = JSON.parse($(this).attr('ap_3rd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_4th')){
					var obj = JSON.parse($(this).attr('ap_4th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_5th')){
					var obj = JSON.parse($(this).attr('ap_5th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_6th')){
					var obj = JSON.parse($(this).attr('ap_6th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
			}
			if(sign == 'ap_3rd'){
				if(!!$(this).attr('ap_L')){
					var obj = JSON.parse($(this).attr('ap_L'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_R')){
					var obj = JSON.parse($(this).attr('ap_R'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_1st')){
					var obj = JSON.parse($(this).attr('ap_1st'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_2nd')){
					var obj = JSON.parse($(this).attr('ap_2nd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				
				if(!!$(this).attr('ap_4th')){
					var obj = JSON.parse($(this).attr('ap_4th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_5th')){
					var obj = JSON.parse($(this).attr('ap_5th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_6th')){
					var obj = JSON.parse($(this).attr('ap_6th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
			}
			if(sign == 'ap_4th'){
				if(!!$(this).attr('ap_L')){
					var obj = JSON.parse($(this).attr('ap_L'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_R')){
					var obj = JSON.parse($(this).attr('ap_R'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_1st')){
					var obj = JSON.parse($(this).attr('ap_1st'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_2nd')){
					var obj = JSON.parse($(this).attr('ap_2nd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_3rd')){
					var obj = JSON.parse($(this).attr('ap_3rd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				
				if(!!$(this).attr('ap_5th')){
					var obj = JSON.parse($(this).attr('ap_5th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_6th')){
					var obj = JSON.parse($(this).attr('ap_6th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
			}
			if(sign == 'ap_5th'){
				if(!!$(this).attr('ap_L')){
					var obj = JSON.parse($(this).attr('ap_L'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_R')){
					var obj = JSON.parse($(this).attr('ap_R'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_1st')){
					var obj = JSON.parse($(this).attr('ap_1st'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_2nd')){
					var obj = JSON.parse($(this).attr('ap_2nd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_3rd')){
					var obj = JSON.parse($(this).attr('ap_3rd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_4th')){
					var obj = JSON.parse($(this).attr('ap_4th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				
				if(!!$(this).attr('ap_6th')){
					var obj = JSON.parse($(this).attr('ap_6th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
			}
			if(sign == 'ap_6th'){
				if(!!$(this).attr('ap_L')){
					var obj = JSON.parse($(this).attr('ap_L'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_R')){
					var obj = JSON.parse($(this).attr('ap_R'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_1st')){
					var obj = JSON.parse($(this).attr('ap_1st'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_2nd')){
					var obj = JSON.parse($(this).attr('ap_2nd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_3rd')){
					var obj = JSON.parse($(this).attr('ap_3rd'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_4th')){
					var obj = JSON.parse($(this).attr('ap_4th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_5th')){
					var obj = JSON.parse($(this).attr('ap_5th'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				
			}
		}else{
			if(!!$(this).attr('ap_L')){
				var obj = JSON.parse($(this).attr('ap_L'));
				if(obj['nApID'] == nApID){
					layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
						layer.close(index);
					});
					flag = true;
					return false;
				}
			}
			if(!!$(this).attr('ap_R')){
				var obj = JSON.parse($(this).attr('ap_R'));
				if(obj['nApID'] == nApID){
					layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
						layer.close(index);
					});
					flag = true;
					return false;
				}
			}
			if(!!$(this).attr('ap_1st')){
				var obj = JSON.parse($(this).attr('ap_1st'));
				if(obj['nApID'] == nApID){
					layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
						layer.close(index);
					});
					flag = true;
					return false;
				}
			}
			if(!!$(this).attr('ap_2nd')){
				var obj = JSON.parse($(this).attr('ap_2nd'));
				if(obj['nApID'] == nApID){
					layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
						layer.close(index);
					});
					flag = true;
					return false;
				}
			}
			if(!!$(this).attr('ap_3rd')){
				var obj = JSON.parse($(this).attr('ap_3rd'));
				if(obj['nApID'] == nApID){
					layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
						layer.close(index);
					});
					flag = true;
					return false;
				}
			}
			if(!!$(this).attr('ap_4th')){
				var obj = JSON.parse($(this).attr('ap_4th'));
				if(obj['nApID'] == nApID){
					layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
						layer.close(index);
					});
					flag = true;
					return false;
				}
			}
			if(!!$(this).attr('ap_5th')){
				var obj = JSON.parse($(this).attr('ap_5th'));
				if(obj['nApID'] == nApID){
					layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
						layer.close(index);
					});
					flag = true;
					return false;
				}
			}
			if(!!$(this).attr('ap_6th')){
				var obj = JSON.parse($(this).attr('ap_6th'));
				if(obj['nApID'] == nApID){
					layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
						layer.close(index);
					});
					flag = true;
					return false;
				}
			}
		}
	});
	
	if(flag){
		return false;
	}
	
	return true;
}

/**
 * 获取到已选择的商品分类数据
 * @returns {String}
 */
function getCategoryJson(){
	var result = "";
	var _this = $('#floor_tab>ul>li>a.active').parent('li');
	if(!!_this){
		if(!!_this.attr('category')){
			result = _this.attr('category');
		}
	}
	return result;
}
