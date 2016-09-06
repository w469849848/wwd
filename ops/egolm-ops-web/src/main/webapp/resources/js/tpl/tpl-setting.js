jQuery(function($){
	
	
	$('.sort-item a').on('click',function(){
		$(this).parents('li:first').remove();
	});
	
	
	/*$('.header-nav .mask-wrap').on('click',function(){ //显示  专区选择 弹窗
		console.log('专区选择！');
		$('#editDivision').modal('show');
	});
	
	$('.div-setting .result-wrap ul li a').on('click',function(){ //删除专区
		console.log('删除专区！');
		$(this).parents('li:first').remove();
	});*/
	
	$('.dropdown-menu .item-one').on('click',function(){ //选中一级菜单
		var itemOnId = $(this).attr('id');//一级菜单ID
		//回复所有二级选择
		$('.item-group-wrap .item-group').each(function(){
				$(this).show();
		});
		
		$(this).parents('div.dropdown-wrap:first').find('span.check-content').text($(this).text());
		$(this).parents('div.dropdown-wrap:first').find('span.check-content').attr('id',$(this).attr('id'));
		
		//移除之前选中的二级和三级菜单
		$('.three-lv-wrap .item-group-wrap .chk').each(function(){
			$(this).parent().removeClass('checked');
			$(this).attr('checked',false);
			$(this).parents('div.dropdown-wrap:first').find('span.check-content').text("");
		}); 
		
		//隐藏其他二级选择
		$('.item-group-wrap .item-group').each(function(){
				var pid = $(this).attr('pid');
				if(pid!=itemOnId) $(this).hide();
		});
		
	});
	
	//商品分类选择
	var categoryName_u = $("#categoryName").val();
	if (categoryName_u != '') {
		$("#categoryType_btn").find("span").eq(0).text(categoryName_u);
	}
	$("#category-menu li").click(function() {
		var litext = $(this).text();
		var livalue = $(this).attr('id');
		$("#categoryType_btn").find("span").eq(0).text(litext);
		$("#categoryID").val(livalue);
		$("#categoryName").val(litext);
	});
	
	
	
	
	$('.div-setting .scroll-wrap .footable a').on('click',function(){ //添加选中的专区
		var sTplName = $(this).attr('name');
		var sTplNo = $(this).attr('id');
		var isChose = false;
		$('.div-setting .result-wrap ul input').each(function(){
			if(sTplNo==$(this).attr('id')) {
				isChose = true;
			}
		})
		if(isChose){
			alert('已经选择了【'+sTplName+'】，不能选择重复专区！');
		}else{
			var navHtml = "<li class='border border-radius bg-color orange'>"+
			"<input type='text' value='"+sTplName+"' id='"+sTplNo+"'/>"+
			"<a href='javascript:void(0)' onclick='$(this).parent().remove();'><img src='../../../resources/assets/images/btn-delete.png'/></a>"+
			"</li>";
			$('.div-setting .result-wrap ul').append(navHtml);
		}
	});
		
	
	/*$('.hot-wrap .hot-ad').on('click',function(){ //显示楼层广告图设置弹窗
		
		console.log('楼层广告模块！');
		popSelectAd(100,100,'L','SUZU');
		$('#editAdPic').modal('show');
		
	});*/
	
	$('.scroll-wrap #see_detail').on('click',function(){ //显示楼层广告图明细弹窗
		var apId = $(this).attr('attr');
		var orgNO = $(this).attr('name');
		console.log('楼层广告明细！'+apId);
		popAdDetail(apId);
		$('#editAdPic').modal('show');
		
	});

	$('.brand-wrap .brand li div.mask').on('click',function(){ //显示推荐品牌设置弹窗 1 (广告图弹窗)
		
		console.log('推荐品牌模块(大图)！');
		
		$('#editAdPic').modal('show');
		
	});
	
	
	$('#editRecBrand .submit').on('click',function(){ //保存选择品牌
		
		if(true){
			
			$('#brandTips').modal('show');
			
		}
		
	});
	
	$('.brand-alert .result-wrap .g-icon > a').on('click',function(){ //删除品牌
		
		console.log('删除品牌！');
		
		$(this).parents('li:first').remove();
		
	});
	
	$('.good-wrap .activity .mask-nav .mask').on('click',function(){ //显示编辑推荐商品分类弹窗
		
		console.log('推荐商品分类！');
		
		$('#editRecGoodsSort').modal('show');
	
	});
	
	
	$('#editRecGoods .submit').on('click',function(){ //保存选择品牌
		
		if(true){
			
			$('#goodTips').modal('show');
			
		}
		
	});
	
	$('.rec-good-sort .input-item li a').on('click',function(){ //删除商品分类
		
		console.log('删除商品分类！');
		
		$(this).parents('li:first').remove();
		
	});
	
	
	$('.floor-goods-type1 .fes-activity > ul li a .mask').on('click',function(){ //显示楼层类型1商品板块广告图编辑弹窗
		
		console.log('楼层商品板块广告图！');
		
		$('#editAdPic').modal('show');
		
	});
	
	$('.floor-goods-type1 .nav-tit .mask').on('click',function(){ //显示  楼层类型1商品专区选择 弹窗
		
		console.log('楼层商品专区选择！');
		
		$('#editDivision').modal('show');
		
	});
	
	$('.floor-goods-type1 .nav-content .mask').on('click',function(){ //楼层类型1商品专区分类选择
		
		console.log('楼层商品专区分类选择！');
		
		$('#editRecGoodsSort').modal('show');
		
	});
	
	$('.floor-goods-type2 .f-content > .mask').on('click',function(){ //楼层类型2小图商品列表选择
		
		console.log('楼层小图商品列表选择');
		
		$('#editRecGoods').modal('show');
	});
	
	$('.floor-goods-type2 .ad1 .mask,.floor-goods-type2 .ad2 .mask').on('click',function(){ //楼层类型2广告图选择
		
		console.log('楼层广告图选择');
		
		$('#editAdPic').modal('show');
		
	});
	
	$('.floor-goods-type2 .nav-tit .mask').on('click',function(){ //显示  楼层类型2商品专区选择 弹窗
		
		console.log('楼层商品专区选择！');
		
		$('#editDivision').modal('show');
		
	});
	
	
	$('.content-sort .mask').on('click',function(){ //楼层类型2详细分类
		
		console.log('楼层广告图选择');
		
		$('#editGoodsSortDetail').modal('show');
		
	});
	
	
	$('#editGoodsSortDetail .submit').on('click',function(){ //保存选择
		
		if(true){
			
			$('#brandTips').modal('show');
			
		}
		
	});

	
	/*add by zhangzhi*/
	//楼层分类切换
	/*$('.f-nav .nav-bar-wrap li>a>span').on('click',function(){
		var $this = $(this).parents('li:first'),
			idx = $this.index(),
			$sort = $this.parents('.floor:first').find('.fes-sort-wrap .fes-sort');
		
		$this.siblings().find('a').removeClass('active');
		$this.find('a').addClass('active');
		
		$sort.addClass('hide');
		$sort.eq(idx).removeClass('hide');
		
	});*/
	
	
	
	//推荐商品蒙层hover
	$('.activity-nav .mask').hover(function(){
		$('.activity-nav .mask').addClass('hover');
	},function(){
		$('.activity-nav .mask').removeClass('hover');
	});
	
	//楼层详细分类蒙层hover
	$('.nav-bar-wrap .mask').hover(function(){
		$('.nav-bar-wrap .mask').addClass('hover');
	},function(){
		$('.nav-bar-wrap .mask').removeClass('hover');
	});
	
	//推荐商品页导航个数超出4个宽度修正
	var $rGoodNav = $('.rd-good-module .activity-nav li');
	$rGoodNav.css({'width': 100/$rGoodNav.length +'%'});
	
	//模块导航个数宽度修正
	var $rGoodNav = $('.tpl-nav ul.clearfix li');
	$rGoodNav.css({'width': 100/$rGoodNav.length +'%'});
	
});

/**
 * 移除已经选中的类型
 * @param obj
 */
function removeLi(obj){
	$(obj).parents('li:first').remove();
}

/**
 * 保存楼层商品分类
 */
function savePopFloorCategory(){
	var checkData = [];
	$('div.scroll-wrap').find('input[id=goodsIs]').each(function(){
		var categoryObj = {};
		categoryObj['categoryID'] = $(this).val();
		categoryObj['categoryName'] = $(this).attr('attr');
		checkData.push(categoryObj);
	});
	var result = parent.saveCateGorys(JSON.stringify(checkData));
	if(result){
		closeLayer();
	}
}

/**
 * 保存导航分类类型
 */
function savePopNavcategory(){
	var checkIdsData = [];
	$('div.scroll-wrap').find('input[id=level_1_categoryId]').each(function(){
		var level_1_categoryId = $(this).val();
		var level_1_categoryName = $(this).parent().find('h2').text();
		var check_1_IdsData = [];
		$(this).parent().find('input[id=level_2_categoryId]').each(function(){
			var level_2_categoryId = $(this).val();
			var level_2_categoryName =  $(this).next().text();
			var check_2_IdsData = [];
			$(this).parent().find('input[id=level_3_categoryId]').each(function(){
				var level_3_categoryId = $(this).val();
				var level_3_categoryName =  $(this).attr('name');
				var categoryobj3 = {};
				categoryobj3['category_id'] = level_3_categoryId;
				categoryobj3['category_name'] = level_3_categoryName;
				check_2_IdsData.push(categoryobj3);
			});
			var categoryobj2 = {};
			categoryobj2['category_id'] = level_2_categoryId;
			categoryobj2['category_name'] = level_2_categoryName;
			categoryobj2['children'] = check_2_IdsData;
			check_1_IdsData.push(categoryobj2);
		});
		var categoryobj1 = {};
		categoryobj1['category_id'] = level_1_categoryId;
		categoryobj1['category_name'] = level_1_categoryName;
		categoryobj1['children'] = check_1_IdsData;
		checkIdsData.push(categoryobj1);
	});
	var result = parent.saveCategorys(JSON.stringify(checkIdsData));
	if(result){
		closeLayer();
		checkIdsData = null;
	}
}

/**
 * 保存楼层广告数据
 */
function savePopAdd(nApID,url,sign){
	var result = parent.saveAdPos(nApID,url,sign);
	if(result){
		closeLayer();
	}
}

/**
 * 保存楼层广告数据
 */
function choseNav(sign){
	var checkData = [];
	$('.div-setting .result-wrap ul li input').each(function(){
		var navObj = {};
		navObj['sTplName'] = $(this).val();
		navObj['sTplNo'] = $(this).attr('id');
		checkData.push(navObj);
	});
	var result = parent.saveZoneNav(JSON.stringify(checkData));
	if(result){
		closeLayer();
	}
}

/*弹出广告位选择框 ,width,height是指要求选择的广告位的高度、宽度*/
function popSelectAd(width,height,sign,orgNO,sDisplayNo,sScopeTypeID){
	layer.open({
		  type: 2,
		  title: '选择广告位',
		  shadeClose: true,
		  shade: 0.6,
		  area: ['62%', '70%'],
		  content: webHost+"/template/setting/pop/ad?width="+width+"&height="+height+"&sign="+sign+"&orgNO="+orgNO+"&sDisplayNo="+sDisplayNo+"&sScopeTypeID="+sScopeTypeID
		});
}

/*弹出导航专区选择框 ,width,height是指要求选择的导航的高度、宽度*/
function popSectionNavigation(sBelongNo,sTplNo,nTag){
	layer.open({
		type: 2,
		title: '选择导航专区',
		shadeClose: true,
		area: ['62%', '60%'],
		content: webHost+"/template/setting/pop/section?sBelongNo="+sBelongNo+"&sTplNo="+sTplNo+"&nTag="+nTag
	});
}

/*弹出广告明细查看*/
function popAdDetail(apId,orgNO){
	layer.open({
		type: 2,
		title: '广告明细',
		shadeClose: true,
		shade: 0.6,
		area: ['100%', '100%'],
		content: webHost+"/template/setting/pop/adDetail?apId="+apId+"&orgNO="+orgNO
	});
}

/*导航模块商品分类选择框*/
function popSelectNavProductCategory(orgNO){
	layer.open({
		  type: 2,
		  title: '选择商品分类',
		  shadeClose: true,
		  shade: 0.6,
		  area: ['40%', '70%'],
		  content: [webHost+"/template/setting/pop/navProductCategory?orgNO="+orgNO,no]
		});
}
/*商品选择框*/
function popSelectProduct(num,orgNo){
	layer.open({
		  type: 2,
		  title: '选择商品',
		  shadeClose: true,
		  shade: 0.6,
		  area: ['80%', '90%'],
		  content: webHost+"/template/setting/pop/product?num="+num+"&orgNO="+orgNo
		});
}

/*品牌选择框*/
function popSelectBrand(num,orgNo){
	layer.open({
		  type: 2,
		  title: '选择品牌',
		  shadeClose: true,
		  shade: 0.6,
		  area: ['80%', '86%'],
		  content: webHost+"/template/setting/pop/brand?num="+num+"&orgNO="+orgNo
		});
}

/*楼层商品分类选择框*/
function popFloorCategory(orgNO){
	layer.open({
		  type: 2,
		  title: '选择商品分类',
		  shadeClose: true,
		  shade: 0.6,
		  area: ['40%', '75%'],
		  content: webHost+"/template/setting/pop/floorCategory?orgNO="+orgNO
		});
}

/*针对iframe layer，iframe页面调用此方法关闭关闭弹出窗口*/
function closeLayer(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	parent.layer.close(index); //再执行关闭 
}
//品牌设置图片
function previewBrand(file){ 
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
			//$(file).next().attr("src",evt.target.result);;
			//上传服务端
			$("#brandform").ajaxSubmit({
				type: "POST",
				url:"uploadBrandImg",
				dataType: "json",
			    success: function(data){
			     	if(data.msg=='success'){
			     		alert("上传图片成功");
			     		$(file).next().attr("src",data.url);
			   		 }
			    	else{
			    		alert("上传图片失败");
			    	}
				}
			});
			
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

//商品设置图片
function previewGoods(file){ 
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
			//$(file).next().attr("src",evt.target.result);;
			//上传服务端
			$("#goodform").ajaxSubmit({
				type: "POST",
				url:"uploadGoodImg",
				dataType: "json",
			    success: function(data){
			     	if(data.msg=='success'){
			     		alert("上传图片成功");
			     		$(file).next().attr("src",data.url);
			   		 }
			    	else{
			    		alert("上传图片失败");
			    	}
				}
			});
			
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

//商品选择
function chooseGood(el){
	//改变商品选中状态
	var goodId = $(el).parent().parent().children().eq(0).attr("id");
	var goodName = $(el).parent().parent().children().eq(0).text();
	var goodUrl = $(el).parent().parent().children().eq(4).text();
	var normalSalesPrice = $(el).parent().parent().children().eq(3).text();
	if($(el).attr('class')=="detail"){
		//判断是否商品数量是否超出
		/*
		$("#goodsBody").find("tr").each(function(index,element){
			 var tdArr = $(this).children();
			 if(tdArr.eq(5).children().hasClass('detail active')){
				 
			 }
		 });
		 */
		 if(_productCount>=goodsCount){
			layer.alert("最多选中"+goodsCount+"个商品", {icon: 1});
			return;
		 }
		 _productCount++;
		// goodIndex=0;//将商品个数重新置0
		$(el).attr('class', 'detail active');
		$(el).text('已选');
		//绑定商品图片
		$("input[name='goodImg']").each(function(index,element){
			if($(element).parent().next().text() == ""){
				$(element).parent().next().attr("id",goodId);
				$(element).parent().next().text(goodName);
				$(element).next().attr("src",goodUrl+"@84h_88w");
				$(element).parent().children().eq(2).attr("value",normalSalesPrice);
				return false;
			}
		});
	}else{
		_productCount--;
		$(el).attr('class', 'detail');
		$(el).text('未选');
		$("input[name='goodImg']").each(function(index,element){
			if($(element).parent().next().attr("id")==goodId){
				$(element).parent().next().attr("id","");
				$(element).parent().next().text("");
				$(element).parent().children().eq(2).attr("value","");
				$(element).next().attr("src",resourceHost+"/images/tpl/icon-add.png");
				return false;
			}
		});
		
	}
}

//品牌选择
function chooseBrand(el){
	//改变品牌选中状态
	var brandId = $(el).parent().parent().children().eq(1).attr("id");
	var brandUrl = $(el).parent().parent().children().eq(1).next().text();
	var brandName = $(el).parent().parent().children().eq(1).text();
//	var brandUrl = $(el).parent().parent().children().eq(0).children().eq(0).children().eq(0).attr("src");
	if($(el).attr('class')=="detail"){
		//判断是否品牌数量是否超出
		 if(selectedBrandCount>=brandCount){
			layer.alert("最多选中"+brandCount+"个品牌", {icon: 1});
			return;
		 }
		
		$(el).attr('class', 'detail active');
		$(el).text('已选');
		selectedBrandCount++;
		//绑定品牌图片
		$("input[name='brandImg']").each(function(index,element){
			if($(element).parent().next().text() == ""){
				$(element).parent().next().attr("id",brandId);
				$(element).parent().next().text(brandName);
				$(element).next().attr("src",brandUrl);
				return false;
			}
		});
	}else{
		$(el).attr('class', 'detail');
		$(el).text('未选');
		selectedBrandCount--;
		$("input[name='brandImg']").each(function(index,element){
			if($(element).parent().next().attr("id")==brandId){
				$(element).parent().next().attr("id","");
				$(element).parent().next().text("");
				$(element).next().attr("src",resourceHost+"/images/tpl/icon-add.png");
				return false;
			}
		});
	}
}


//商品对象
function GoodData(){
	 this.imgPath = "";  
	 this.goodsId = ""; 
     this.goodsName = "";
     this.normalSalesPrice = ""
}
//返回商品封装值
function returnGoods(){
	//获取编辑好的商品信息回显前页面
	var goodsData = [];
	var goodIndex=0;
	var goodsImgIndex=0;
	$("input[name='goodImg']").each(function(index,element){
		var returnDt = new GoodData();
		//处理图片大小，显示页面是@84h_88w,返回前页面是@!160_180
		var gurl = $(element).next().attr("src").split("@");
		returnDt.imgPath = gurl[0];
		returnDt.goodsId = $(element).parent().next().attr("id");
		returnDt.goodsName = $(element).parent().next().text();
		returnDt.normalSalesPrice = $(element).parent().children().eq(2).attr("value");
		goodsData.push(returnDt);
		if($(element).parent().next().text() == ""){
			goodsImgIndex++;
		}
	});
	if(goodsImgIndex>0){
		alert("请选中"+goodsCount+"个商品");
		return;
	}
	/* $("#goodsBody").find("tr").each(function(index,element){
		 var tdArr = $(this).children();
		 if(tdArr.eq(5).children().hasClass('detail active')){
			 var returnDt = new GoodData();
			 returnDt.goodsId =   tdArr.eq(0).attr("id");
			 returnDt.goodsName =   tdArr.eq(0).text();
			 returnDt.normalSalesPrice =   tdArr.eq(3).text();
			 returnDt.imgPath =   tdArr.eq(4).text();
			 goodsData.push(returnDt);
			 goodIndex++;
		 }
	 });
	 if(goodIndex<goodsCount){
		alert("请选中"+goodsCount+"个商品");
		return;
	 }*/
	 var result = parent.saveGoods(JSON.stringify(goodsData));
	 if(result){
		 closeLayer();
	 }else{
		 alert('获取商品数据异常');
	 }
}

function BrandData(){
	this.imgPath = "";  
	this.brandId = ""; 
    this.brandName = ""
}


//获取异步品牌数据
function loadBrandsMsg(index){
	var brandsName = $("#brandsName").val();
	var orgNO = $("#orgNO").val();
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/template/setting/pop/queryBrand',
        data:'orgNO='+orgNO+"&brandsName="+brandsName+'&page.index='+index, 
        async: false,
        error: function(request) {
            Ego.error("系统异常,请刷新重试",null);
        },
        success: function(data) {
        	$("#brandsBody").html("");
        	$('div').remove('.navigation_bar');
        	var dataResult = eval("(" + data + ")"); 
        	var isValid = dataResult.IsValid;
        	var imgUrl = dataResult.imgUrl;
        	if(isValid){
        		var dataList = dataResult.DataList; 
        		if(dataList.length>0){ 
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i]; 
						/* var showNum = data.showNum;
						 if(showNum == 0){
							 showNum = 1;
						 } */
						 $("#brandsBody").append("<tr id='brandsTr'><td><div class='g-icon'><img src='"+imgUrl+data.brandLogoUrl+"@300h_300w' height='100%' width='100%'/></div></td>"+
									"<td style='text-align:center' id='"+data.brandID+"'>"+data.brandName+"</td>"+
									"<td style='display:none'>"+imgUrl+data.brandLogoUrl+"@89h_113w</td>"+
									"<td style='text-align:center;width:50%;'><a class='detail' id='chooseCk' attrs='"+data.brandID+"' onclick='chooseBrand(this)'>未选</a></td></tr>");
					 }
				 }else{
					 $("#brandsBody").html("");
				 }
          	}else{
          		$("#brandsBody").html("");
        		var returnValue = dataResult.ReturnValue  
        		 Ego.error(returnValue,null);
        	}
        	
        	//回显选中的数据
        	$("input[name='brandImg']").each(function(index,element){
        		if($(element).parent().next().text() != ""){
    				var gid = $(element).parent().next().attr("id");
    				 $("#brandsBody").find("tr").each(function(index,element){
    					 var tdArr = $(this).children().find('#chooseCk');
    						 if(gid == tdArr.attr("attrs")){
    							 tdArr.attr("class","detail active");
    						     tdArr.html('已选');
    						 }
    				 });
    			}
        	});
        	
        	//设置分页  
          	var pageHtml = ajaxPager.render(dataResult.page, function(page) {
          		loadBrandsMsg(page.index);
			});
          	$('div').remove('.navigation_bar');
			$('div .batch').append(pageHtml);
        }
    }); 
}


function BrandData(){
	this.imgPath = "";  
	this.brandId = ""; 
    this.brandName = ""
}

//返回品牌
function returnBrands(){
	//获取编辑好的品牌信息回显前页面
	var brandsData = [];
	var brandIndex=0;
	var brandsImgIndex=0;

	//回显选中的数据
	$("input[name='brandImg']").each(function(index,element){
		if($(element).parent().next().text() != ""){
			 var returnDt = new BrandData();
			 returnDt.brandId = $(element).parent().next().attr("id");
			 returnDt.brandName = $(element).parent().next().text();
			 returnDt.imgPath =  $(element).next().attr("src");
			 brandsData.push(returnDt);
			 brandIndex++;
		}
	});
	 console.info(JSON.stringify(brandsData));
	 var result = parent.saveBrand(JSON.stringify(brandsData));
	 if(result){
		 closeLayer();
	 }
}

function goodCancleImg(el){
	$(el).parent().children().eq(1).attr("src",resourceHost+"/images/tpl/icon-add.png");
	$(el).parent().next().text("");
	var id = $(el).parent().next().attr("id");
	if(id!=""&&id!=null){
		_productCount--;
	}
	 $("#goodsBody").find("tr").each(function(index,element){
		 var tdArr = $(this).children();
		 if(tdArr.eq(5).children().hasClass('detail active')){
			 if(id == tdArr.eq(0).attr("id")){
				 tdArr.eq(5).children().attr("class","detail");
				 tdArr.eq(5).children().text('未选');
			 }
		 }
	 });
	 $(el).parent().next().attr("id","");
}

function brandCancleImg(el){
	$(el).prev().attr("src",resourceHost+"/images/tpl/icon-add.png");
	$(el).parent().next().text("");
	var id = $(el).parent().next().attr("id");
	if(id!=""&&id!=null){
		selectedBrandCount--;
	}
	 $("#brandsBody").find("tr").each(function(index,element){
		 var tdArr = $(this).children().find('#chooseCk');
		 if(tdArr.hasClass('detail active')){
			 if(id == tdArr.attr("attrs")){
				tdArr.attr("class","detail");
				tdArr.html('未选');
			 }
		 }
	 });
}


function cleanGoods(){
	_productCount=0;
	$("#goodsBody").find("tr").each(function(index,element){
		 var tdArr = $(this).children();
		 if(tdArr.eq(5).children().hasClass('detail active')){
			tdArr.eq(5).children().attr("class","detail");
			tdArr.eq(5).children().text("未选");
		 }
	 });
	$("input[name='goodImg']").each(function(index,element){
			$(element).parent().next().attr("id","");
			$(element).parent().next().text("");
			$(element).next().attr("src",resourceHost+"/images/tpl/icon-add.png");
	});
}

function cleanBrands(){
	selectedBrandCount=0;
	$("#brandsBody").find("tr").each(function(index,element){
		 var tdArr = $(this).children().find('#chooseCk');
		 if(tdArr.hasClass('detail active')){
			tdArr.attr("class","detail");
			tdArr.html('未选');
		 }
	 });
	$("input[name='brandImg']").each(function(index,element){
			$(element).parent().next().attr("id","");
			$(element).parent().next().text("");
			$(element).next().attr("src",resourceHost+"/images/tpl/icon-add.png");
	});
	
	$('#cleanBrandType').val("cleanBrandAll");
}

//获取异步商品数据
function loadGoodsMsg(index){
	var goodName = $("#goodName").val();
	var categoryNO = $("#categoryID").val();
	var orgNO = $("#orgNO").val();
	$.ajax({
        cache: false,
        type: "POST",
        url:webHost+'/template/setting/pop/ajaxGoods',
        data:'goodName='+goodName+'&categoryNO='+categoryNO+'&orgNO='+orgNO+'&page.index='+index, 
        async: false,
        error: function(request) {
            Ego.error("系统异常,请刷新重试",null);
        },
        success: function(data) {
        	$("#goodsBody").html("");
        	$('div').remove('.navigation_bar');
        	var dataResult = eval("(" + data + ")"); 
        	var isValid = dataResult.IsValid;
        	var imgUrl = dataResult.imgUrl;
        	if(isValid){
        		var dataList = dataResult.DataList; 
        		if(dataList.length>0){ 
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i]; 
						 $("#goodsBody").append("<tr id='goodsTr'><td style='width:15%' id='"+data.goodsId+"'>"+data.goodsName+"</td>"+
									"<td style='width:15%'>"+data.Spec+"</td><td style='width:30%'>超多美味，全家共享</td><td>"+data.agentPrice+"</td>"+
									"<td style='display:none'>"+imgUrl+data.imgPath+"</td>"+
									"<td><a class='detail' onclick='chooseGood(this)'>未选</a></td></tr>");
					 }
				 }else{
					 $("#goodsBody").html("");
				 }
          	}else{
          		$("#goodsBody").html("");
        		var returnValue = dataResult.ReturnValue  
        		 Ego.error(returnValue,null);
        	}
        	
        	//回显选中的数据
        	$("input[name='goodImg']").each(function(index,element){
        		if($(element).parent().next().text() != ""){
    				var gid = $(element).parent().next().attr("id");
    				 $("#goodsBody").find("tr").each(function(index,element){
    					 var tdArr = $(this).children();
    						 if(gid == tdArr.eq(0).attr("id")){
    							 tdArr.eq(5).children().attr("class","detail active");
    							 tdArr.eq(5).children().text('已选');
    						 }
    				 });
    			}
        	});
        	
        	//设置分页  
          	var pageHtml = ajaxPager.render(dataResult.page, function(page) {
          		loadGoodsMsg(page.index);
			});
          	$('div').remove('.navigation_bar');
        	$('div .batch').append(pageHtml);
        }
    }); 
}




/**
 * 判断对象是否为空
 * @param obj
 * @returns {Boolean}
 */
function isEmptyObject(obj) { 
	for ( var name in obj ) { 
		return false; 
	} 
	return true; 
} 

/**
 * 根据广告位ID查询广告信息
 * @param apId
 */
function queryAds(apId,orgNo){
	var result = "";
	if(apId == null || apId == ""){
		alert("广告查询失败，未获取到广告位ID");
	}
	$.ajax({
        cache: false,
        type: "POST",
        url:"queryAds",
        data:{apId:apId,orgNo:orgNo},
        async: false,
        error: function(request) {
            alert("错误提示："+request);
        },
        success: function(data) {
        	var res = JSON.parse(data);
        	if(res.IsValid==true){
        		if(res.datas.length > 0){
        			result = JSON.stringify(res.datas);
        		}
        	}
        }
    });
	
	return result;
}

/**
 * 展示广告信息
 * @param datas
 * @param sign
 */
function showAd(datas,sign){
	var result = "";
	var adArr = JSON.parse(datas);
	if(adArr.length > 0){
		if(adArr[0]['nAdShowGoodsMsgID'] == 1){
			//后台插入的html格式--图文轮播
			var slideHtml2 = '<div style="width:100%;height:100%;overflow:hidden;" id="'+sign+'">' //id要动态生成 
			+'<div class="bd">'
			+'<ul>'
			for(var i=0,length=adArr.length; i<length; i++){
				var temp = '<li style="width:218px;height:249px;">';
				temp += '<a href="#">';
				temp +='<div style="width: 218px; height: 249px;" class="good-item">';
				temp +='<div style="width: 162px; height: 162px;" class="pic">';
				temp +='<img style="width: '+adArr[i]['nAdWidth']+'px; height: '+adArr[i]['nAdHeight']+'px;" src="http://img.egolm.com/'+adArr[i]['sAdPathUrl']+'@'+adArr[i]['nAdWidth']+'w_'+adArr[i]['nAdHeight']+'h" />';
				temp +='</div>';
				temp +='<div style="padding: 0 28px;" class="intro">';
				temp +='<p style="margin: 8px 0; height: 30px;">'+adArr[i]['sGoodsDesc']+'</p>';
				temp +='<p style="" class="orange fw"><i>￥</i>'+adArr[i]['nRealSalePrice']+'/<span>'+adArr[i]['sUnit']+'</span></p>';
				temp +='</div>';
				temp +='</div>';
				temp +='</a>';
				temp +='</li>';
				
				slideHtml2 += temp;
			}
			
			slideHtml2 += '</ul>'
				+'</div>'
				+'</div>';
			
			var $script2 = '<script>'
				+'$("#'+sign+'").slide({' //id要动态生成 
				+'mainCell:".bd ul",'
				+'autoPlay:true,'
				+'interTime:3500,'
				+'delayTime:1500'
				+'});'
				+'</script>';
			
			result = slideHtml2 + $script2;
			
		}else{
			//后台插入的html格式 --单图片轮播
			var slideHtml = '<div style="width:100%;height:100%;overflow:hidden;" id="'+sign+'">' //id要动态生成 
			+'<div class="bd">'
			+'<ul>';
			for(var i=0,length=adArr.length; i<length; i++){
				var temp = '<li style="width:295px;height:220px;">';
						temp += '<a href="#"><img style="width: '+adArr[i]['nAdWidth']+'px; height: '+adArr[i]['nAdHeight']+'px;" src="http://img.egolm.com/'+adArr[i]['sAdPathUrl']+'@'+adArr[i]['nAdHeight']+'h_'+adArr[i]['nAdWidth']+'w"></a>'
					temp +='</li>';
				slideHtml += temp;
			}
			
			slideHtml += '</ul>'
				+'</div>'
				+'</div>';
			
			var $script = '<script>'
				+'$("#'+sign+'").slide({' //id要动态生成 
				+'mainCell:".bd ul",'
				+'autoPlay:true,'
				+'interTime:3500,'
				+'delayTime:1500'
				+'});'
				+'</script>';
			
			result = slideHtml + $script;
		}
	}
	return result;
}

/**
 * 广告位默认展示图片
 * @param sApPathUrl
 */
function dafultShowAp(sApPathUrl){
	var $html = "";
	if(!!sApPathUrl){
		$html = "<a href='#'><img src='"+sApPathUrl+"'/></a>";
	}else{
		$html = "<a href='#'><img src=''/></a>";
	}
	return $html;
}

