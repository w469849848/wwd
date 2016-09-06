<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="mytags.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<title>万店易购订货平台</title>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta content="telephone=no" name="format-detection">
		<meta name="renderer" content="webkit">
		<meta name="keywords" content="万店易购运营管理平台" />
		<meta name="description" content="万店易购运营管理平台" />
		<link rel="shortcut icon" href="favicon.ico">
		<link rel="stylesheet" href="<c:url value='/resources/css/promo/reset.css'/>" /> 
		<link rel="stylesheet" href="<c:url value='/resources/css/promo/common.css'/>" />
		<link rel="stylesheet" href="<c:url value='/resources/css/promo/header.css'/>" />
		<link rel="stylesheet" href="<c:url value='/resources/css/promo/footer.css'/>" />
		<link rel="stylesheet" href="<c:url value='/resources/css/promo/activity.css'/>" />
	</head>
	<body> 
		
		<!--顶部导航-->
		<div class="header">
			
			<!--顶部导航条-->
			<div class="nav-wrap">
				<div class="nav-bar ma pw">
					<div class="welcomes fl">Hi，<span>用户名</span>，欢迎来到万店易购！</div>
					<ul class="nav-menu fr clearfix">
						 <input type="hidden"  id="nId" value="${nId }"/>
						<li>
							<a href="#">请登录</a>
						</li>
						<li class="pr egolm">
							<a class="btn-my-eg" href="javascript:void(0)">我的易购<i class="icon icon-dr"></i></a>
							<ul class="my-eg hide clearfix">
								<li><a href="#">我的资产</a></li>
								<li><a href="#">账户信息</a></li>
								<li><a href="#">收货地址</a></li>
								<li><a href="#">密码修改</a></li>
								<li><a href="#">我的收藏</a></li>
								<li><a href="#">购买记录</a></li>
							</ul>
						</li>
						<li>
							<a href="#">服务中心</a>
						</li>
						<li>
							<a href="#">我的购物车</a>
						</li>
						 
					</ul>
				</div>
			</div>
			
			<!--搜索框-->
			<div class="search-wrap ma pw clearfix">
				<div class="logo fl pr">
					<a href="#"><img alt="万店易购" src="<c:url value='/resources/assets/images/logo-s.png'/> "/></a>
				</div>
				<div class="search fl clearfix">
					<input class="fl" type="text" placeholder="商品名称" />
					<button class="fl">搜索</button>
				</div>
				<div class="cart-wrap fr clearfix">
					<div class="order fl pr clearfix">
						<i class="icon icon-order"></i>
						<a href="#">订单查询</a>
						<i class="icon icon-arrow fr"></i>
						<i class="count">0</i>
					</div>
					<div class="cart fl pr clearfix">
						<div class="login-tips hide">
							<div class="spacer"></div>
							<p class="txt f-99">登录才能看到购物车里的商品哦</p>
							<p class="btn"><a href="#">登录</a></p>
						</div>
						<i class="icon icon-cart"></i>
						<a href="javascript:void(0)">购物车</a>
						<i class="icon icon-arrow fr"></i>
						<i class="count">0</i>
					</div>
				</div>
			</div>
			
			<!--商品分类-->
			<div class="header-nav ma pw clearfix pr">
				
				<div class="fl pr sort-wrap">
					<a class="pr" href="javascript:void(0)">休闲食品<span class="dr"></span></a>
					
					<div class="sort hide">
						<ul class="clearfix">
							 
						</ul>
					</div>
				
				</div>
				
				<ul class="fl clearfix">
					<li><a href="#">首页</a></li>
					<li><a href="#">新品上线</a></li>
					<li><a href="#">酒水饮料</a></li>
					<li><a href="#">方便速食</a></li>
					<li><a href="#">品牌专区</a></li>
					<li><a href="#">优选推荐</a></li>
					<li><a class="active" href="#">促销特惠</a></li>
					<li><a href="#">优惠特价2</a></li>
					<li><a href="#">公告</a></li>
				</ul>
			</div>
			
		</div>
		
		<!--中部楼层-->
		<div class="content-wrap">
			<div class="content pw ma pr">
				<!--入口-->
				<div class="entrance-wrap">
					<ul class="entrance clearfix" id="promoList">
						<%-- <li>
							<a href="#">
								<div class="item" style="background: url( <c:url value='/resources/assets/images/activity/entrance-bg1.jpg'/>) no-repeat;">
									<h2 class="tit">每日精选千款好货！</h2>
									<p class="date">2016.7.15-7.30</p>
									<div class="btn-go" style="color: #d42d30;">立即前往</div>
								</div>
							</a>
						</li>
						  --%>
					</ul>
					<div class="paging-wrap clearfix">
						<div class="fr paging-box">
							<div class="paging">
								<div class="prev fl" style="right: 1139.5px;">
									<a href="javascript:void(0)">&lt;</a>
								</div>
								<div class="btn-paging fl">
									<ul class="clearfix">
										<li class="active">
											<a href="javascript:void(0)">1</a>
										</li>
										<li>
											<a href="javascript:void(0)">2</a>
										</li>
										<li>
											<a href="javascript:void(0)">3</a>
										</li>
										<li>
											<a href="javascript:void(0)">4</a>
										</li>
										<li>
											<span>...</span>
										</li>
										<li>
											<a href="javascript:void(0)">100</a>
										</li>
									</ul>
								</div>
								<div class="next fl" style="right: 405.5px;">
									<a href="javascript:void(0)">&gt;</a>
								</div>
							</div>
							<div class="ipt-wrap fl">
								<div class="ipt fl">
									<p>共<span>100</span>页，到第<input type="text">页</p>
								</div>
								<div class="btn-sub fl">
									<p><input type="button" value="确定"></p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!--置顶按钮-->
		<div class="to-top">
			<a class="btn-top" href="javascript:void(0)"><img src="<c:url value='/resources/assets/images/elevator/icon-to-top.png'/>"></a>
		</div>
		
		<!--底部信息-->
		<div class="footer">
			<div class="footer-bar">
				<ul class="ma clearfix">
					<li><a href="#">万店易购</a></li>
					<li><a href="#">招贤纳士</a></li>
					<li><a href="#">网站地图</a></li>
					<li><a href="#">版权说明</a></li>
					<li><a href="#">常见问题</a></li>
					<li><a href="#">使用协议</a></li>
					<li><a href="#">联系我们</a></li>
					<li></li>
				</ul>
			</div>
			
			<div class="copyright pw ma">
				<p><span class="address"></span>地址：上海市徐汇区枫林路485号枫林创意园区4号楼 <span class="tel"></span>电话：400-638-1707 <span class="email"></span>邮箱：wandian@egolm.com</p>
				<p>版权所有 <span class="copy"></span></span>2015万店易购  沪ICP备15000078-1</p>
			</div>
			
		</div>
		 
		
		 <script src="<c:url value='/resources/assets/js/jquery-2.0.3.min.js'/>"></script> 
		 <script src="<c:url value='/resources/assets/js/activity.js'/>"></script> 
		 <script src="<c:url value='/resources/assets/js/header.js'/>"></script> 
 		<script src="<c:url value='/resources/assets/js/scrollTop.js'/>"></script>
	</body>
 
</html> 
<script>
 $(function(){ 
	 loadPic();
 });
 
 function loadPic(){  
	 var nId = $("#nId").val();
		$.ajax({
	        cache: false,
	        type: "GET",
	        url:ctx+'/promoPicSet/show', 
	        data:'nId='+nId,
	        dataType: "json",
	        async: false,
	        error: function(request) {
	        	Ego.error("系统连接异常,请刷新后重试.",null); 
	        },
	        success: function(result) { 
 	        	 var isValid = result.isValid;
	        	 if(isValid){
	        		 //设置背景
	        		 var imgUrl = result.data.imgUrl;
	        		 var promoPicSet = result.data.picSetList;
	        		 if(promoPicSet != ''){
	        			 var promoPic = promoPicSet[0];
		        		
	  	        		 var picUrl = imgUrl+""+promoPic.sBackgroundPicUrl; 
		        		 var sBackgroundColour = promoPic.sBackgroundColour;
	 	        		 $('.content-wrap').css('background',"url("+picUrl+")" ); 
		        	 	 $('.content-wrap').css("background-repeat","no-repeat");
		        		 $('.content-wrap').css("background-color",sBackgroundColour);
		        		 $('.content-wrap').css("background-size","100% auto");
	        		 }
	        		  
	        		 
	        		 //设置 活动
	        		 var promoStr ="";
	        		 var dataList = result.data.dataList;
 	        		 if(dataList.length>0){
	        			 for(var i=0;i<dataList.length;i++){
	        				 var promoMainData = dataList[i];
	        				 var sUrl = promoMainData.sUrl;
	         				 if(typeof(sUrl) != "undefined"){
	        					 sUrl = imgUrl+""+sUrl;
	        				 }else{
	        					 sUrl = ctx+'/resources/assets/images/activity/entrance-bg1.jpg';
	        				 }
	         				 
	         				 
	        				 promoStr+="<li>";
	        				 promoStr+="	<a href='#'>";
	        				 promoStr+="		<div class='item' style='background: url("+sUrl+") no-repeat;'>";
	        				 promoStr+="			<h2 class='tit'>"+promoMainData.sPromoName+"</h2>";
	        				 promoStr+="			<p class='date'>"+promoMainData.dPromoBeginDate+"至"+promoMainData.dPromoEndDate+"</p>";
	        				 promoStr+="			<div class='btn-go' style='color: #d42d30;'>立即前往</div>";
	        				 promoStr+="		</div>";
	        				 promoStr+="	</a>";
	        				 promoStr+="</li>";
	        			 }
	        		 }
	        		$("#promoList").html(promoStr);
	         	}else{
	         	 
	         	}
	        }
	    }); 
	}
</script>
