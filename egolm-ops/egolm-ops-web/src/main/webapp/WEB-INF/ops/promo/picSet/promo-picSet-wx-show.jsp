<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="mytags.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="author" content="name=Insect"/>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Cache-Control" content="no-cache">
		<meta http-equiv="Expires" content="0">	
		<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black" />
		<meta name="format-detection" content="telephone=no" />
		<meta name="format-detection" content="email=no" />
		<meta name="x5-orientation" content="portrait">
		<title>万店订货惠</title>
		<link rel="stylesheet" href="<c:url value='/resources/wx/css/common.css'/>" />
		<link rel="stylesheet" href="<c:url value='/resources/wx/css/index.css'/>" />
	</head>
	<body>
		
		<script src="<c:url value='/resources/wx/js/common.js'/>"></script>
		<script src="<c:url value='/resources/wx/js/zepto.min.js'/>"></script>
		
		<div class="wrap">
			<!--中部-->
			<div class="main">
				<div class="main-wrap">
					<!--首页-->
					<div class="index-wrap">
   					<input type="hidden"  id="nId" value="${nId }"/>
					<!--活动-->
					<div class="activity-wrap ">
						<!--活动主页-->
						<div style="background: #ffa946;" class="activity curPage">
							<div class="header">
								<a class="btn-back" href="#"><img src="<c:url value='/resources/wx/images/back.png'/>"/></a>
								<h1>促销活动</h1>
							</div>
							<div style="background: url(<c:url value='/resources/wx/images/activity-header.jpg'/>) no-repeat;" class="head"></div>
							
							<div id="wxActivityId">
								
							</div> 
							
						</div> 
 
					</div> 
					</div>
 
				</div>
			</div>
			
			<!--底部tab-->
			<div class="footer">
				<ul class="clearfix">
					<li class="btn-index active" data-tag="index">
						<a href="javascript:void(0)">
							<i class="icon icon-home"></i>
							<p>首页</p>
						</a>
					</li>
					<li class="btn-sort" data-tag="sort">
						<a href="javascript:void(0)">
							<i class="icon icon-sort"></i>
							<p>分类</p>
						</a>
					</li>
					<li class="btn-activity" data-tag="scan">
						<div class="eye">
							<a href="javascript:void(0)">
								<img src="<c:url value='/resources/wx/images/f-scan.png'/>"/>
							</a>
						</div>
					</li>
					<li class="btn-cart" data-tag="cart">
						<a id="target" href="javascript:void(0)">
							<i class="icon icon-cart"></i>
							<p>购物车</p>
						</a>
					</li>
					<li class="btn-personal" data-tag="personal">
						<a href="javascript:void(0)">
							<i class="icon icon-me"></i>
							<p>我</p>
						</a>
					</li>
				</ul>
			</div>
			
		</div> 
	</body>
</html>
 <script src="<c:url value='/resources/assets/js/jquery-2.0.3.min.js'/>"></script> 
<script>
 $(function(){ 
	 loadPic();
 });
 
 function loadPic(){ 
	 console.log("load---");
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
	        		 console.log(imgUrl);
	        		 console.log(promoPicSet);
	        		 if(promoPicSet != ''){
	        			 var promoPic = promoPicSet[0];
		        		
	  	        		 var picUrl = imgUrl+""+promoPic.sBackgroundPicUrl; 
		        		 var sBackgroundColour = promoPic.sBackgroundColour;
	 	        		 $('.activity-wrap .head').css('background',"url("+picUrl+")" ); 
		        	 	 $('.activity-wrap .head').css("background-repeat","no-repeat");
		        		 $('.activity-wrap .activity').css("background-color",sBackgroundColour);
		        		 $('.activity-wrap .activity').css("background-size","100% auto");
	        		 }
	        		  
	        		 
	        		 //设置 活动
	        		 var promoStr ="";
	        		 var dataList = result.data.dataList;
	        		 console.log(dataList.length);
 	        		 if(dataList.length>0){
	        			 for(var i=0;i<dataList.length;i++){
	        				 var promoMainData = dataList[i];
	        				 var sUrl = promoMainData.sUrl;
	         				 if(typeof(sUrl) != "undefined" || sUrl == null){
	        					 sUrl = imgUrl+""+sUrl;
	        				 }else{
	        					 sUrl = ctx+'/resources/wx/images/entrance-xlbk.jpg';
	        				 }
	         				 
	         				promoStr+="<div class='floor'>";
	         				promoStr+="	<div class='tit' style='background: url("+ctx+"/resources/wx/images/title1.jpg) no-repeat;' class='clearfix'>";
	         				promoStr+="		<div class='fl'>";
	         				promoStr+="			<p style='color: #fff'><i style='background: #fff;' class='spacer'></i>"+promoMainData.sPromoName+"</p>";
	         				promoStr+="		</div>";
	         				promoStr+="		<div class='fr time'>"+promoMainData.dPromoBeginDate+"至"+promoMainData.dPromoEndDate+"</div>";
	         				promoStr+="	</div>";
	         				promoStr+="	<ul>";
	         				promoStr+="		<li>";
	         				promoStr+="			<div class='item btn-moldbaby'>";
	         				promoStr+="				<a href='javascript:void(0)'><img class='lazy' src='"+sUrl+"'/></a>";
	         				promoStr+="			</div>";
	         				promoStr+="		</li>";
	         				promoStr+="	</ul>";
	         				promoStr+="</div> ";
	         		
	        			 }
	        		 }
 	        		$("#wxActivityId").html(promoStr);
	         	}else{
	         	 
	         	}
	        }
	    }); 
	}
</script>
