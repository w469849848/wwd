jQuery(function($){
	
	$('.tpl-nav ul li').on('click',function(){ //导航点击效果
		
		var idx = $(this).index();
		
		idx++;
		
		$(this).addClass('active').siblings().removeClass('active');
		
		//切换模板
		$('.tab-'+ idx).removeClass('hide').siblings().addClass('hide');
	});
	
	$('.sort').on('click',function(){ //显示 商品分类设置窗口
			
		console.log('商品分类设置！');
		
		$('#editGoodSort').modal('show');
		
	});
	
	$('.sort-item a').on('click',function(){
		$(this).parents('li:first').remove();
	});
	
	
	$('.header-nav .mask-wrap').on('click',function(){ //显示  专区选择 弹窗
		
		console.log('专区选择！');
		
		$('#editDivision').modal('show');
		
	});
	
	$('.div-setting .result-wrap ul li a').on('click',function(){ //删除专区
		
		console.log('删除专区！');
		
		$(this).parents('li:first').remove();
	
	});
		
	$('.banner .bd .mask').on('click',function(){ //显示banner图设置 （广告图弹窗都是同一个弹窗）
		
		console.log('banner图设置！');
		
		$('#editAdPic').modal('show');
		
	});
	
	$('.notice .notice-ad').on('click',function(){ //显示 公告区 广告图设置 弹窗 （广告图弹窗都是同一个弹窗）
		
		console.log('公告区广告设置！');
		
		$('#editAdPic').modal('show');
		
	});
	
	$('.hot-wrap .hot-ad').on('click',function(){ //显示楼层广告图设置弹窗
		
		console.log('楼层广告模块！');
		
		$('#editAdPic').modal('show');
		
	});

	$('.brand-wrap .brand li div.mask').on('click',function(){ //显示推荐品牌设置弹窗 1 (广告图弹窗)
		
		console.log('推荐品牌模块(大图)！');
		
		$('#editAdPic').modal('show');
		
	});
	
	$('.brand-wrap .brand > div.mask').on('click',function(){ //显示推荐品牌设置弹窗 2
		
		console.log('推荐品牌设置(小图)！');
		
		$('#editRecBrand').modal('show');
		
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
	
	$('.good-wrap .activity .mask-item .mask').on('click',function(){ //显示编辑推荐商品弹窗
		
		console.log('推荐商品设置！');
		
		$('#editRecGoods').modal('show');
	
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
	
	$('.floor-goods-type2 .nav-content .mask').on('click',function(){ //楼层类型2商品专区分类选择
		
		console.log('楼层商品专区分类选择！');
		
		$('#editRecGoodsSort').modal('show');
		
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
	
	
});
