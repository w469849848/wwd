jQuery(function($){
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
				var temp = "<li ap_L='"+JSON.stringify(datasArr[i]['ap_L'])+"' ap_R='"+JSON.stringify(datasArr[i]['ap_R'])+"' ap_M1='"+JSON.stringify(datasArr[i]['ap_M1'])+"' ap_M2='"+JSON.stringify(datasArr[i]['ap_M2'])+"' ap_M3='"+JSON.stringify(datasArr[i]['ap_M3'])+"' ap_M4='"+JSON.stringify(datasArr[i]['ap_M4'])+"' >";
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
			switchTab(JSON.stringify(datasArr[0]['ap_L']),JSON.stringify(datasArr[0]['ap_R']),JSON.stringify(datasArr[0]['ap_M1']),JSON.stringify(datasArr[0]['ap_M2']),JSON.stringify(datasArr[0]['ap_M3']),JSON.stringify(datasArr[0]['ap_M4']));
		}
	}
	
	//导航个数超出4个宽度修正
	/*var $rGoodNav = $('#floor_tab ul li');
	$rGoodNav.css({'width': 100/$rGoodNav.length +'%'});*/
});

/**
 * tab选项卡切换
 * @param span
 */
function selectTab(obj){
	var _this = $(obj);
	var _parent = _this.parent();
	_this.parent().siblings().children("a").removeClass("active");
	_this.addClass("active");
	switchTab(_parent.attr('ap_L'), _parent.attr('ap_R'), _parent.attr('ap_M1'), _parent.attr('ap_M2'), _parent.attr('ap_M3'), _parent.attr('ap_M4'));
}

/**
 * 切换tab选项卡展示不同的广告位
 * @param LJson 左广告位
 * @param RJson 右广告位
 * @param M1Json 中1广告位
 * @param M2Json 中2广告位
 * @param M3Json 中3广告位
 * @param M4Json 中4广告位
 */
function switchTab(LJson,RJson,M1Json,M2Json,M3Json,M4Json){
	if(LJson != "" && LJson != undefined && LJson != '{}'){
		var apLObj = JSON.parse(LJson);
		saveAdPos(apLObj['nApID'],apLObj['sApPathUrl'],'ap_L','show' );
	}else{
		$('#ap_L>div.item-wrap').empty();
	}
	
	if(RJson != "" && RJson != undefined && RJson != '{}'){
		var apRObj = JSON.parse(RJson);
		saveAdPos(apRObj['nApID'],apRObj['sApPathUrl'],'ap_R','show');
	}else{
		$('#ap_R>div.item-wrap').empty();
	}
	
	if(M1Json != "" && M1Json != undefined && M1Json != '{}'){
		var M1Obj = JSON.parse(M1Json);
		saveAdPos(M1Obj['nApID'],M1Obj['sApPathUrl'],'ap_M1','show');
	}else{
		$('#ap_M1>div.item-wrap').empty();
	}
	
	if(M2Json != "" && M2Json != undefined && M2Json != '{}'){
		var M2Obj = JSON.parse(M2Json);
		saveAdPos(M2Obj['nApID'],M2Obj['sApPathUrl'],'ap_M2','show');
	}else{
		$('#ap_M2>div.item-wrap').empty();
	}
	
	if(M3Json != "" && M3Json != undefined && M3Json != '{}'){
		var M3Obj = JSON.parse(M3Json);
		saveAdPos(M3Obj['nApID'],M3Obj['sApPathUrl'],'ap_M3','show');
	}else{
		$('#ap_M3>div.item-wrap').empty();
	}
	
	if(M4Json != "" && M4Json != undefined && M4Json != '{}'){
		var M4Obj = JSON.parse(M4Json);
		saveAdPos(M4Obj['nApID'],M4Obj['sApPathUrl'],'ap_M4','show');
	}else{
		$('#ap_M4>div.item-wrap').empty();
	}
	
}

/**
 * 广告位选择
 * @param nApID 广告位ID
 * @param sApPathUrl 广告位团片地址
 * @param sign 位置标记
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

	var adPos = {};
	adPos['nApID'] = nApID;
	adPos['sApPathUrl'] = sApPathUrl;
	
	if (sign == 'ap_L') {
		_this.parent().attr('ap_L', JSON.stringify(adPos));
		var data = queryAds(nApID,sBelongNo);
		if(data != "" && data != null){
			var result = showAd(data,"ap_L_slide");
			if(result != "" && result != null){
				$('#ap_L>div.item-wrap').empty().append(result);
			}else{
				$('#ap_L>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else{
			$('#ap_L>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
		}
	} else if (sign == 'ap_R') {
		_this.parent().attr('ap_R', JSON.stringify(adPos));
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
	} else if (sign == 'ap_M1') {
		_this.parent().attr('ap_M1', JSON.stringify(adPos));
		var data = queryAds(nApID,sBelongNo);
		if(data != "" && data != null){
			var result = showAd(data,"ap_M1_slide");
			if(result != "" && result != null){
				$('#ap_M1>div.item-wrap').empty().append(result);
			}else{
				$('#ap_M1>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else{
			$('#ap_M1>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
		}
	} else if (sign == 'ap_M2') {
		_this.parent().attr('ap_M2', JSON.stringify(adPos));
		var data = queryAds(nApID,sBelongNo);
		if(data != "" && data != null){
			var result = showAd(data,"ap_M2_slide");
			if(result != "" && result != null){
				$('#ap_M2>div.item-wrap').empty().append(result);
			}else{
				$('#ap_M2>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else{
			$('#ap_M2>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
		}
	} else if (sign == 'ap_M3') {
		_this.parent().attr('ap_M3', JSON.stringify(adPos));
		var data = queryAds(nApID,sBelongNo);
		if(data != "" && data != null){
			var result = showAd(data,"ap_M3_slide");
			if(result != "" && result != null){
				$('#ap_M3>div.item-wrap').empty().append(result);
			}else{
				$('#ap_M3>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else{
			$('#ap_M3>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
		}
	} else if (sign == 'ap_M4') {
		_this.parent().attr('ap_M4', JSON.stringify(adPos));
		var data = queryAds(nApID,sBelongNo);
		
		if(data != "" && data != null){
			var result = showAd(data,"ap_M4_slide");
			
			if(result != "" && result != null){
				$('#ap_M4>div.item-wrap').empty().append(result);
			}else{
				$('#ap_M4>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
			}
		}else{
			$('#ap_M4>div.item-wrap').empty().append(dafultShowAp(sApPathUrl));
		}
	} else {
		layer.alert("获取广告位失败", {icon: 2}, function(index){
			layer.close(index);
		});
	}
	adPos = null;
	result = true;
	return result;
}

/**
* 二级导航名称编辑弹出框
*/
function openNav(){
	
	var navTemp = "";
	$("#floor_tab").find("ul>li").each(function(){
		var _this = $(this);
		navTemp += "<li ap_L='"+_this.attr("ap_L")+"' ap_M1='"+_this.attr("ap_M1")+"' ap_M2='"+_this.attr("ap_M2")+"' ap_M3='"+_this.attr("ap_M3")+"' ap_M4='"+_this.attr("ap_M4")+"' ap_R='"+_this.attr("ap_R")+"' style='cursor:move;'>";
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
		navTemp += "<li ap_L='' ap_R='' ap_M1='' ap_M2='' ap_M3='' ap_M4='' style='cursor:move;'>";
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
		navStr += "<li ap_L='"+$(this).attr('ap_L')+"' ap_R='"+$(this).attr('ap_R')+"' ap_M1='"+$(this).attr('ap_M1')+"' ap_M2='"+$(this).attr('ap_M2')+"' ap_M3='"+$(this).attr('ap_M3')+"' ap_M4='"+$(this).attr('ap_M4')+"'>";
	    navStr += "<a";
	    if(index == 0){
	    	navStr += " class='active'";
	    	switchTab($(this).attr('ap_L'),$(this).attr('ap_R'),$(this).attr('ap_M1'),$(this).attr('ap_M2'),$(this).attr('ap_M3'),$(this).attr('ap_M4'));
		}
		navStr += " href='javascript:void(0)' onclick=\"selectTab(this)\">";
		navStr += "<span>"+$(this).find("div.border-radius>p").text()+"</span>";
		navStr += "</a>"
		navStr += "</li>";
	});
	if(navStr == ""){
		layer.alert("请配置二级分类", {icon: 3}, function(index){
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
 * 组装JSON数据结构
 */
function packageJson(){
	var jsonObject = {};
	var apArray = [];
	/**
	 * 楼层名称判断
	 */
	if($.trim($("input[name='floorName']").val()) == ""){
		$('input[name="floorName"]').tips({
			side:2,
            msg:'请填楼层名称',
            time:2,
            x:0,
            y:5
        });
		return;
	}else{
		jsonObject['floorName'] = $("input[name='floorName']").val();
	}
	/**
	 * 广告位
	 */
	var flag = false;
	$('#floor_tab>ul>li').each(function(index){
		
		var apObj = {};
		var _this = $(this);
		
		apObj['name'] = _this.find('a>span').text(); //获取tab名称
		if(_this.attr('ap_L') == "" || _this.attr('ap_R') == "" || _this.attr('ap_M1') == "" || _this.attr('ap_M2') == "" || _this.attr('ap_M3') == "" || _this.attr('ap_M4') == "" ){
			layer.alert("第"+(index + 1)+"个选项卡存在未配置广告位", {icon: 3}, function(index){
				layer.close(index);
			});
			flag = true;
			return false;
		}
		
		apObj['ap_L'] = JSON.parse(_this.attr('ap_L'));
		apObj['ap_R'] = JSON.parse(_this.attr('ap_R'));
		apObj['ap_M1'] = JSON.parse(_this.attr('ap_M1'));
		apObj['ap_M2'] = JSON.parse(_this.attr('ap_M2'));
		apObj['ap_M3'] = JSON.parse(_this.attr('ap_M3'));
		apObj['ap_M4'] = JSON.parse(_this.attr('ap_M4'));
		
		apArray.push(apObj);
	});
	
	if(flag){
		return ;
	}
	
	jsonObject['datas'] = apArray;
	console.log("组装json数据结构为："+JSON.stringify(jsonObject));
	$('input[name="sLayoutContent"]').val(JSON.stringify(jsonObject));
	$('#tplSettingForm').submit();
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
			if(sign == "ap_L"){
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
				if(!!$(this).attr('ap_M1')){
					var obj = JSON.parse($(this).attr('ap_M1'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_M2')){
					var obj = JSON.parse($(this).attr('ap_M2'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_M3')){
					var obj = JSON.parse($(this).attr('ap_M3'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_M4')){
					var obj = JSON.parse($(this).attr('ap_M4'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
			}
			if(sign == "ap_R"){
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
				
				if(!!$(this).attr('ap_M1')){
					var obj = JSON.parse($(this).attr('ap_M1'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_M2')){
					var obj = JSON.parse($(this).attr('ap_M2'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_M3')){
					var obj = JSON.parse($(this).attr('ap_M3'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_M4')){
					var obj = JSON.parse($(this).attr('ap_M4'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
			}
			if(sign == "ap_M1"){
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
				
				if(!!$(this).attr('ap_M2')){
					var obj = JSON.parse($(this).attr('ap_M2'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_M3')){
					var obj = JSON.parse($(this).attr('ap_M3'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_M4')){
					var obj = JSON.parse($(this).attr('ap_M4'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
			}
			if(sign == "ap_M2"){
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
				if(!!$(this).attr('ap_M1')){
					var obj = JSON.parse($(this).attr('ap_M1'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				
				if(!!$(this).attr('ap_M3')){
					var obj = JSON.parse($(this).attr('ap_M3'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_M4')){
					var obj = JSON.parse($(this).attr('ap_M4'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
			}
			if(sign == "ap_M3"){
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
				if(!!$(this).attr('ap_M1')){
					var obj = JSON.parse($(this).attr('ap_M1'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				
				if(!!$(this).attr('ap_M3')){
					var obj = JSON.parse($(this).attr('ap_M3'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_M4')){
					var obj = JSON.parse($(this).attr('ap_M4'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
			}
			if(sign == "ap_M4"){
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
				if(!!$(this).attr('ap_M1')){
					var obj = JSON.parse($(this).attr('ap_M1'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_M2')){
					var obj = JSON.parse($(this).attr('ap_M2'));
					if(obj['nApID'] == nApID){
						layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
							layer.close(index);
						});
						flag = true;
						return false;
					}
				}
				if(!!$(this).attr('ap_M3')){
					var obj = JSON.parse($(this).attr('ap_M3'));
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
			if(!!$(this).attr('ap_M1')){
				var obj = JSON.parse($(this).attr('ap_M1'));
				if(obj['nApID'] == nApID){
					layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
						layer.close(index);
					});
					flag = true;
					return false;
				}
			}
			if(!!$(this).attr('ap_M2')){
				var obj = JSON.parse($(this).attr('ap_M2'));
				if(obj['nApID'] == nApID){
					layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
						layer.close(index);
					});
					flag = true;
					return false;
				}
			}
			if(!!$(this).attr('ap_M3')){
				var obj = JSON.parse($(this).attr('ap_M3'));
				if(obj['nApID'] == nApID){
					layer.alert("该广告位已经被使用,请重新选择", {icon: 2}, function(index){
						layer.close(index);
					});
					flag = true;
					return false;
				}
			}
			if(!!$(this).attr('ap_M4')){
				var obj = JSON.parse($(this).attr('ap_M4'));
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
