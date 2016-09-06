jQuery(function($){
	
	/**
	 * 首页
	 */
	//推荐商品点击切换效果
	$('.activity-nav>li>a>span').on('click',function(e){
		
		e.stopPropagation();
		
		var $this = $(this).parents('li:first'),
			idx = $this.index(),
			$item = $this.parents('.activity:first').find('.activity-item .mask-wrap');
		
		$this.addClass('active').siblings().removeClass('active');
		
		$item.addClass('hide');
		$item.eq(idx).removeClass('hide');

	});
	
	//楼层分类切换
	$('.f-nav .nav-bar-wrap li>a>span').on('click',function(){
		var $this = $(this).parents('li:first'),
			idx = $this.index(),
			$sort = $this.parents('.floor:first').find('.fes-sort-wrap .fes-sort');
		
		$this.siblings().find('a').removeClass('active');
		$this.find('a').addClass('active');
		
		$sort.addClass('hide');
		$sort.eq(idx).removeClass('hide');
		
	});
	
	
	
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
	
	
	/**
	 * 模板设置部分
	 */
	
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
	
	$(document).on('click','.sort-item a',function(){ //删除添加的商品分类（商品分类设置）
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
		
	$('.banner .mask').on('click',function(){ //显示banner图设置 （广告图弹窗都是同一个弹窗）
		
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
	
	
	
	$('.good-wrap .activity-nav .mask').on('click',function(){ //显示编辑推荐商品分类弹窗
		
		console.log('推荐商品分类！');
		
		$('#editRecGoodsSort').modal('show');
	
	});
	
	$('.good-wrap .activity-item .mask').on('click',function(){ //显示编辑推荐商品弹窗
		
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
	
	
	$('.floor-goods-type1 .fes-sort-wrap .mask').on('click',function(){ //显示楼层类型1商品板块广告图编辑弹窗
		
		console.log('楼层商品板块广告图！');
		
		$('#editAdPic').modal('show');
		
	});
	
	$('.floor-goods-type1 .nav-bar-wrap .mask').on('click',function(){ //显示  楼层类型1商品专区详细分类选择 弹窗
		
		console.log('楼层商品专区选择！');
		
		$('#editDivision').modal('show');
		
	});
	
//	$('.floor-goods-type1 .f-icon-wrap .mask').on('click',function(){ //楼层类型1商品专区分类选择
//		
//		console.log('楼层商品专区分类选择！');
//		
//		$('#editRecGoodsSort').modal('show');
//		
//	});
	
	
	$('.floor-goods-type2 .f-content > .mask').on('click',function(){ //楼层类型2小图商品列表选择
		
		console.log('楼层小图商品列表选择');
		
		$('#editAdPic').modal('show');
	});
	
	$('.floor-goods-type2 .f-item .mask').on('click',function(){ //楼层类型2广告图选择
		
		console.log('楼层广告图选择');
		
		$('#editAdPic').modal('show');
		
	});
	
	$('.floor-goods-type2 .nav-bar-wrap .mask').on('click',function(){ //楼层类型2商品专区分类选择
		
		console.log('楼层商品专区分类选择！');
		
		$('#editRecGoodsSort').modal('show');
		
	});
	
//	$('.floor-goods-type2 .f-icon-wrap .mask').on('click',function(){ //显示  楼层类型2商品专区选择 弹窗
//		
//		console.log('楼层商品专区选择！');
//		
//		$('#editDivision').modal('show');
//		
//	});
	
	$('.f-sort .mask').on('click',function(){ //楼层类型2详细分类
		
		console.log('楼层广告图选择');
		
		$('#editGoodsSortDetail').modal('show');
		
	});
	
	
	
	
	$('#editGoodsSortDetail .submit').on('click',function(){ //保存选择
		
		//后端代码
		
		if(true){
			
			$('#brandTips').modal('show');
			
		}
		
	});
	
	
	
	
	/**
	 * 三级菜单多选
	 * 
	 */
	
	
	//停止冒泡
	var goodsData = [];
	
	$('.item-group').on('click',function(e){ e.stopPropagation(); });
	
	//选中效果 -- 二级分类
	$('.sec-level-wrap .item-group-wrap .chk').on('click',function(){
		
		var data = [],str='',i = 0,j=1;
		
		Checked.checked(this);
		
		data = CheckGroup.showChecked(this);
		
		for(;i < data.length;i++){
			
			for(;j < data[i].length;j++){
				if(j == 1){
					str = str + data[i][j];
				}else{
					str = str + ',' + data[i][j];
				}
				 	
			}
		}
		
		$(this).parents('div.dropdown-wrap:first').find('span.check-content').text(str);
		
	});
	
	//选中效果 -- 三级分类
	$('.three-lv-wrap .item-group-wrap .chk').on('click',function(){
		
		var str='';
		
		Checked.checked(this);
		
		goodsData = CheckGroup.showChecked(this);
		
		for(var i = 0;i < goodsData.length;i++){
			
			for(var j = 1;j < goodsData[i].length;j++){
				if( j == 1 && i == 0 ){
					str = str + goodsData[i][j];
				}else{
					str = str + ',' + goodsData[i][j];
				}
				 	
			}
		}
		
		$(this).parents('div.dropdown-wrap:first').find('span.check-content').text(str);

	});
	
	//添加分类
	$('.good-sort .btn-add').on('click',function(){
		
		var fSort = $('.first-level-wrap .check-content').text(),
			html = '<li class="sort-item active"><div><a href="javascript:void(0)"><img src="assets/images/btn-delete.png"></a><h2>'+ fSort +'</h2>';
		
		for(var i = 0;i < goodsData.length;i++){
			
			var pHtml = '';
			
			for(var j = 0;j < goodsData[i].length;j++){
				if( j == 0 ){
					pHtml = '<p><span>'+ goodsData[i][j] +'：</span>'
				}else{
					pHtml += '<i>' + goodsData[i][j] +'</i>';
				}
				 	
			}
			pHtml += '</p>';
			html += pHtml;
		}
		
		html += '</div></li>';
		
		$('form > .scroll-wrap > ul').append(html);
		
	});
	
	
	//商品和品牌设置部分图片已选后不许再编辑处理
	$('.g-icon input[type=file]').on('change',function(){
		$(this).prop('disabled',true);
	});
	
	
	//推荐商品页导航个数超出4个宽度修正
	var $rGoodNav = $('.rd-good-module .activity-nav li');
	$rGoodNav.css({'width': 100/$rGoodNav.length +'%'});
	
	
	/*
	 * @模拟选择广告位后轮播
	 */
	
	//后台插入的html格式 --单图片轮播
	var slideHtml = '<div style="width:100%;height:100%;overflow:hidden;" id="ad-123">' //id要动态生成 ad-123
						+'<div class="bd">'
							+'<ul>'
								+'<li style="width:295px;height:220px;">'
									+'<a href="#"><img src="assets/images/tpl/activity/anerle.jpg"></a>'
								+'</li>'
								+'<li style="width:295px;height:220px;">'
									+'<a href="#"><img src="assets/images/tpl/activity/anerle.jpg"></a>'
								+'</li>'
							+'</ul>'
						+'</div>'
					+'</div>';
	
	//后台插入的html格式--图文轮播
	var slideHtml2 = '<div style="width:100%;height:100%;overflow:hidden;" id="ad-234">' //id要动态生成 ad-234
						+'<div class="bd">'
							+'<ul>'
								+'<li style="width:218px;height:249px;">'
									+'<a href="#">'
										+'<div style="width: 218px; height: 249px;" class="good-item">'
											+'<div style="width: 162px; height: 162px;" class="pic">'
												+'<img style="width: 90px; height: 120px;" src="assets/images/tpl/index/1.jpg" />'
											+'</div>'
											+'<div style="padding: 0 28px;" class="intro">'
												+'<p style="margin: 8px 0; height: 30px;">海天味极鲜酱油380ml</p>'
												+'<p style="" class="orange fw"><i>￥</i>350.50/<span>盒</span></p>'
											+'</div>'
										+'</div>'
									+'</a>'
								+'</li>'
								+'<li style="width:218px;height:249px;">'
									+'<a href="#">'
										+'<div style="width: 218px; height: 249px;" class="good-item">'
											+'<div style="width: 162px; height: 162px;" class="pic">'
												+'<img style="width: 90px; height: 120px;" src="assets/images/tpl/index/1.jpg" />'
											+'</div>'
											+'<div style="padding: 0 28px;" class="intro">'
												+'<p style="margin: 8px 0; height: 30px;">海天味极鲜酱油380ml</p>'
												+'<p style="" class="orange fw"><i>￥</i>350.50/<span>盒</span></p>'
											+'</div>'
										+'</div>'
									+'</a>'
								+'</li>'
							+'</ul>'
						+'</div>'
					+'</div>';
	
	//轮播js格式
	var $script = '<script>'
						+'$("#ad-123").slide({' //id要动态生成 ad-123
							+'mainCell:".bd ul",'
							+'autoPlay:true,'
							+'interTime:3500,'
							+'delayTime:1500'
						+'});'
				  +'</script>';
				  
	var $script2 = '<script>'
						+'$("#ad-234").slide({' //id要动态生成 ad-234
							+'mainCell:".bd ul",'
							+'autoPlay:true,'
							+'interTime:3500,'
							+'delayTime:1500'
						+'});'
				  +'</script>';
					
	$('#editAdPic .btn-submit input').on('click',function(){
		$('#editAdPic').modal('hide');
		$('#test-123 .item-wrap').empty().append(slideHtml+$script);
		
		$('#test-234 .item-wrap').empty().append(slideHtml2+$script2);
	});
	
	
	
	
	/*
	 * @顶部导航超出8个时滚动处理
	 */
	var $nav = $('.tpl .tpl-nav'),
		navLen = $nav.find('ul li').length,
		width = $nav.find('.scroll-box').width() - 60,
		itemWidth = width/8,
		minLeft = -(navLen - 8) * itemWidth;
		
	if(navLen > 8){
		$nav.css({'padding':'0 30px'});
		$nav.find('ul li').css({'width': itemWidth + 'px'});
		$nav.find('ul').css({ 'width' : (navLen * itemWidth) + 'px','position':'absolute','left':'0'});
		$nav.find('.btn-left').removeClass('hide');
		$nav.find('.btn-right').removeClass('hide');
		
		//点击事件绑定
		$('.btn-left .btn-prev').on('click',function(){
			var left = parseInt($nav.find('ul').css('left'));
			if(left < 0){
				$nav.find('ul').stop(true,true).animate({'left': (left + itemWidth) + 'px'},500);
			}
		});
		$('.btn-right .btn-next').on('click',function(){
			var left = parseInt($nav.find('ul').css('left'));
			if(left >= 0){
				$nav.find('ul').stop(true,true).animate({'left': (left - itemWidth) + 'px'},500);
			}
		});
	}
	
	

});
