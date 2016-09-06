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
		var goodArray = jsonObject['datas'];
		if(goodArray.length > 0){
			var navStr = "";
			for(var i=0,length=goodArray.length; i<length; i++){
				navStr += "<li onclick=\"selectTab(this)\"";
				if(i == 0){
					navStr += " class='active'";
					switchTab(JSON.stringify(goodArray[i]['goods']));
				}
				navStr += " goods='"+JSON.stringify(goodArray[i]['goods'])+"'>";
					navStr += "<a class='ac-nav' href='javascript:void(0)'>";
						navStr += "<span>"+goodArray[i]['name']+"</span>";
					navStr += "</a>";
				navStr += "</li>";
			}
		}
		$('#nav > ul').empty().append(navStr);
	}
});

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
 * 选项卡切换
 * @param obj
 */
function selectTab(obj){
	var _this = $(obj);
	_this.siblings().removeClass("active");
	_this.addClass("active");
	switchTab( _this.attr('goods'));
} 

/**
 * 商品列表根据tab切换展示不同的数据
 * @param goodJson
 */
function switchTab(goodJson){
	if(!!goodJson){
		var goodArray = JSON.parse(goodJson);
		if(goodArray.length > 0){
			var goodStr = "";
			for(var i=0,length=goodArray.length;i<length;i++){
				goodStr += "<li>";
					goodStr += "<div class='n-g-item'>";
						goodStr += "<a href='#' id='"+goodArray[i]['goodsId']+"'>";
							goodStr += "<div class='item-box'>";
									goodStr += "<div class='pic'>";
										goodStr += "<img src='"+goodArray[i]['imgPath']+"@110w_110h'/>";
									goodStr += "</div>";
									goodStr += "<div class='intro'>";
										goodStr += "<p>"+goodArray[i]['goodsName']+"</p>";
									goodStr += "</div>";
							goodStr += "</div>";
						goodStr += "</a>";
					goodStr += "</div>";
				goodStr += "</li>";
			}
			$('#goods>ul.clearfix').empty().append(goodStr);
		}else{
			$('#goods>ul.clearfix').empty();
		}
	}else{
		$('#goods>ul.clearfix').empty();
	}
}

/**
* 二级导航名称编辑弹出框
*/
function openNav(){
	
	var navTemp = "";
	$("#nav").find("ul.clearfix>li").each(function(){
		var _this = $(this);
		navTemp += "<li goods='"+_this.attr("goods")+"' style='cursor:move;'>";
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
		navTemp += "<li goods='' style='cursor:move;'>";
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
		navStr += "<li onclick=\"selectTab(this)\"";
		if(index == 0){
			navStr += " class='active'";
			switchTab($(this).attr('goods'));
		}
		navStr += " goods='"+$(this).attr('goods')+"'>";
			navStr += "<a class='ac-nav' href='javascript:void(0)'>";
				navStr += "<span>"+$(this).find("div.border-radius>p").text()+"</span>";
			navStr += "</a>";
		navStr += "</li>";
	});
	if(navStr == ""){
		layer.alert("请填写二级分类名称", {icon: 2}, function(index){
			layer.close(index);
		});
		return;
	}
	$('#nav > ul').empty().html(navStr);
	$('#tabNavModel').modal('hide');
	//推荐商品页导航个数超出4个宽度修正
	var $rGoodNav = $('.rd-good-module .activity-nav li');
	$rGoodNav.css({'width': 100/$rGoodNav.length +'%'});
}


/**
* 保存商品
* @goodsJson 商品数组
*/
function saveGoods(goodsJson){
	var result = false;
	console.log("获取商品数据："+goodsJson);
	var _this = $('#nav').find('ul.clearfix>li.active');
	if(!_this){
		layer.alert("请填写二级分类名称", {icon: 2}, function(index){
			layer.close(index);
		});
		return;
	}

	if(goodsJson != ""){
		_this.attr('goods',goodsJson);
		switchTab(goodsJson);
		result = true;
	}else{
		layer.alert("获取商品数据异常", {icon: 2}, function(index){
			layer.close(index);
		});
	}
	return result;
}

/**
 * 获取商品数据
 */
function getGoodsJson(){
	var _this = $('#nav>ul.clearfix>li.active');
	if(!_this){
		layer.alert("获取商品数据异常", {icon: 2}, function(index){
			layer.close(index);
		});
		return;
	}
	var value = "";
	value = _this.attr('goods');
	return value;
}

/**
 * 组装数据
 */
function packageJson(){
	var jsonObject = {}; 
	var goodsArray = [];
	var flag = false;
	$('#nav>ul.clearfix>li').each(function(i){
		var goodsObj = {};
		if($(this).attr('goods') != "" || $(this).attr('goods') != '[]'){
			goodsObj['name'] = $(this).find('a>span').text();
			goodsObj['goods'] = JSON.parse($(this).attr("goods"));
		}else{
			layer.alert("第"+(i+1)+"个选项卡未配置商品数据", {icon: 3}, function(index){
    			layer.close(index);
    		});
			flag = true;
			return false;
		}
		goodsArray.push(goodsObj);
	});
	if(flag){
		return ;
	}
	if(goodsArray.length == 0){
		layer.alert("请配置商品数据", {icon: 3}, function(index){
			layer.close(index);
		});
		return;
	}
	
	jsonObject['datas'] = goodsArray;
	$('input[name="sLayoutContent"]').val(JSON.stringify(jsonObject));
	$('#tplSettingForm').submit();
	return;
}

