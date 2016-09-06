<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<html>
<head>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<script type="text/javascript">
	var ctx = "/egolm-shop-web";
	var basectx = "http://demo.egolm.com:80/egolm-shop-web"; 
</script>
</head>

</html>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>万店易购订货平台</title>
	<link rel="stylesheet" href="http://demo.egolm.com/egolm-shop-web/resources/common/css/reset.css" />
	<link rel="stylesheet" href="http://demo.egolm.com/egolm-shop-web/resources/common/css/common.css" />
	<link rel="stylesheet" href="http://demo.egolm.com/egolm-shop-web/resources/common/css/index.css" />
	<link rel="stylesheet" href="http://demo.egolm.com/egolm-shop-web/resources/common/css/header.css" />
	<link rel="stylesheet" href="http://demo.egolm.com/egolm-shop-web/resources/common/css/banner.css" />
	<link rel="stylesheet" href="http://demo.egolm.com/egolm-shop-web/resources/common/iconfont/iconfont.css" />
		
		<script src="http://demo.egolm.com/egolm-shop-web/resources/common/js/jquery-2.0.3.min.js"></script>
		<script src="http://demo.egolm.com/egolm-shop-web/resources/common/js/jquery.SuperSlide.2.1.1.js"></script>
		<script src="http://demo.egolm.com/egolm-shop-web/resources/common/js/head.js"></script>
		<script src="http://demo.egolm.com/egolm-shop-web/resources/common/js/common.js"></script>
		<script src="http://demo.egolm.com/egolm-shop-web/resources/common/js/gunit.js"></script>
		<script src="http://demo.egolm.com/egolm-shop-web/resources/common/js/counter.js"></script>	
		<script src="http://demo.egolm.com/egolm-shop-web/resources/common/js/scrollTop.js"></script>
		
</head>
<body>
<!--顶部导航-->
<input type="hidden" name="index" value="">
<input type="hidden" name="shopNO" value="">
<input type="hidden" name="keyword" value="">
		<div class="header">
			<!--顶部导航条-->
			<div class="nav-wrap">
				<div class="nav-bar ma pw">
					<div class="welcomes fl">
							Hi,
							<span class="userName"></span>
							<span class="shopName"></span>
						欢迎来到万店易购！<span class='userInfo'></span>
					</div>
					<ul class="nav-menu fr clearfix">
						<li class="hide">
							<a class="active" href="#"><i class="icon icon-app"></i>手机APP</a>
						</li>
						<li class="spacer"></li>
						<li class="pr egolm">
							<a class="btn-my-eg" href="javascript:void(0)">我的易购<i class="icon icon-dr"></i></a>
							<ul class="my-eg hide clearfix">
								<li><a href="http://demo.egolm.com:80/egolm-shop-web/order/orders">我的订单</a></li>
								<li><a href="javascript:showOnDevelopment();">我的资产</a></li>
								<li><a href="http://demo.egolm.com:80/egolm-shop-web/user/myAccount">账户信息</a></li>
								<li><a href="http://demo.egolm.com:80/egolm-shop-web/user/myAddress">收货地址</a></li>
								<li><a href="http://demo.egolm.com:80/egolm-shop-web/user/myPassword">密码修改</a></li>
								<li><a href="http://demo.egolm.com:80/egolm-shop-web/user/myFlavors">我的收藏</a></li>
								<li><a href="http://demo.egolm.com:80/egolm-shop-web/user/buyHistory">购买记录</a></li>
							</ul>
						</li>
						<li class="spacer"></li>
						<li class="hide">
							<a href="http://demo.egolm.com:80/egolm-shop-web/user/serviceCenter">服务中心</a>
						</li>
						<li class="spacer"></li>
						<li>
							<a href="http://demo.egolm.com:80/egolm-shop-web/cart/shoppingCart">我的购物车</a>
						</li>
						<li class="spacer"></li>
						<li class="follow pr">
							<a href="javascript:void(0)">关注易购：<i class="icon icon-wechat"></i></a>
							<div class="follow-qrCode hide">
								<img src="/egolm-shop-web/resources/common/images/dinghuohui.jpg"width="82" height="82"/>
							</div>
						</li>
						<li class="follow pr">
							<a href="http://demo.egolm.com:80/egolm-shop-web/logout">注销</a>
						</li>
						<li class="change pr">
							
						</li>
					</ul>
				</div>
			</div>
			
			<!--搜索框-->
			<div class="search-wrap ma pw clearfix">
				<div class="logo fl pr">
					<a href="http://demo.egolm.com:80/egolm-shop-web/shop/index"><img alt="万店易购" src="/egolm-shop-web/resources/common/images/logo.png"/></a>
				</div>
				<div class="search fl clearfix">
				
					<input name="searchContent" class="fl" type="text" placeholder="商品名称 / 条码 / 拼音首字母 " />
					<button class="fl searchButton">搜索</button>
				</div>
				<div class="cart-wrap fr clearfix">
					<div class="cart fl pr clearfix">
						<a href="http://demo.egolm.com:80/egolm-shop-web/cart/shoppingCart">
							<i class="icon icon-cart"></i>
							<i>购物车</i>
							<i class="icon icon-arrow fr"></i>
							<i class="count cartCount" ></i>
						</a>
					</div>
					
					
					<div class="order fl pr clearfix">
						<a href="http://demo.egolm.com:80/egolm-shop-web/order/orders">
							<i class="icon icon-order"></i>
							<i>订单查询</i>
							<i class="icon icon-arrow fr"></i>
							<i class="count orderCount"></i>
						</a>	
					</div>
				</div>
				<p id="hotSearch" class="hot-keywords fl hide">
				</p>
			</div>
	
	
	
	
	
	
	
	
	
	
	${htmlCode}
	
	
	
	
	
	
	
	
	
			
	

<html>
<head>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<script type="text/javascript">
	var ctx = "/egolm-shop-web";
	var basectx = "http://demo.egolm.com:80/egolm-shop-web"; 
</script>
</head>

</html>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>head</title>
	<link rel="stylesheet" href="http://demo.egolm.com/egolm-shop-web/resources/common/css/footer.css" />
</head>
<body>
		<!--底部信息-->
		<div class="footer">
			<div class="footer-bar">
				<ul class="ma clearfix">
					<li><a href="javascript:showOnDevelopment();">万店易购</a></li>
					<li><a href="javascript:showOnDevelopment();">招贤纳士</a></li>
					<li><a href="javascript:showOnDevelopment();">网站地图</a></li>
					<li><a href="javascript:showOnDevelopment();">版权说明</a></li>
					<li><a href="javascript:showOnDevelopment();">常见问题</a></li>
					<li><a href="javascript:showOnDevelopment();">使用协议</a></li>
					<li><a href="javascript:showOnDevelopment();">联系我们</a></li>
					<li></li>
				</ul>
			</div>
			
			<div class="copyright pw ma">
				<p><span class="address"></span>地址：上海市徐汇区枫林路485号枫林创意园区4号楼 <span class="tel"></span>电话：400-638-1707 <span class="email"></span>邮箱：wandian@egolm.com</p>
				<p>版权所有 <span class="copy"></span>2015万店易购  沪ICP备15000078-1</p>
			</div>
			
		</div>
	</body>
</html>
		<script src="http://demo.egolm.com/egolm-shop-web/resources/logic/js/index.js"></script>
</body>
</html>