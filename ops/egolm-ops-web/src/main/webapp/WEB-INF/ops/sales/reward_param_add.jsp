<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/common/jstl.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>万店易购运营管理平台</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">
<meta name="keywords" content="万店易购运营管理平台" />
<meta name="description" content="万店易购运营管理平台" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/egolm/assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/egolm/assets/css/font-awesome.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/egolm/assets/css/ace.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/egolm/assets/css/ace-rtl.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/egolm/assets/css/ace-skins.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/egolm/assets/css/add-salesman.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/egolm/assets/css/footable.core.css" />
<!--[if lte IE 8]>
		  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/egolm/assets/css/ace-ie.min.css" />
<![endif]-->
<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/ace-extra.min.js"></script>
<!--[if lt IE 9]>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/html5shiv.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/respond.min.js"></script>
<![endif]-->
</head>
<body>
<%@ include file="/resources/common/header.jsp"%>
		<div class="main-container" id="main-container">

			<div class="main-container-inner">
				<%@ include file="/resources/common/left-menu.jsp"%>
				<div class="main-content">
					<div class="page-content">
						<div class="wh_titer">
							<p class="wh_titer_f">
								<a href="index.html">首页</a> &gt; 
								<a href="salesman-manage.html">奖励参数管理</a> &gt; 
								<a class="active" href="add-salesman.html">新增奖励参数</a>
							</p>
						</div>
						
						<div class="add-box"> <!-- 新增经销商 -->
							<form action="${pageContext.request.contextPath}/salesreward/saveSalesRewardParam.do" method="post" id="rewardFrom" name="rewardFrom" >
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">提成比例：</span>
										<label class="col-xs-7 col-sm-9">
											<input class="border border-radius bg-color" type="text"  id="nRoyaltyRate" name="nRoyaltyRate"/>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-12 col-sm-6">
											<span class="col-xs-4">提成方式：</span>
											<label class="col-xs-7">
												<select class="border border-radius bg-color"  id="sRoyaltyType" name="sRoyaltyType"/>
													<option value="业务提成">业务提成</option>
													<option value="奖金提成">奖金提成</option>
												</select>
												<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
											</label>
										</span>
										<span class="col-xs-12 col-sm-6">
											<span class="col-xs-3">业务区域：</span>
											<label class="col-xs-7">
												<select class="border border-radius bg-color"  id="sBizZone" name="sBizZone" >
													<option value="苏州">苏州</option>
													<option value="广州">广州</option>
													<option value="上海">上海</option>
												</select>
												<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
											</label>
										</span>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-12 col-sm-6">
											<span class="col-xs-4 ">审核状态：</span>
											<label class="col-xs-7">
												<select class="border border-radius bg-color" name="nTag"  id="nTag" >
													<option value="1">已审核</option>
													<option value="0">未审核</option>
												</select>
												<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
											</label>
										</span>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">备注：</span>
										<label class="col-xs-7 col-sm-9">
											<textarea class="border border-radius bg-color" rows="4"  id="sMemo" name="sMemo"></textarea>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2"></span>
										<label class="col-xs-7 col-sm-9">
											<input class="border-radius border col-xs-6 col-sm-3 col-md-3" type="submit" value="取消" />
											<input class="border-radius border col-xs-6 col-sm-3 col-md-3" type="submit" value="保存" />
										</label>
									</small>
								</p>
							</form>
						</div>
					</div><!-- /.page-content -->
			</div><!-- /.main-container-inner -->
		</div><!-- /.main-container -->

		
		<!--[if !IE]> -->
		<script type="text/javascript">
			window.jQuery || document.write("<script src='${pageContext.request.contextPath}/resources/egolm/assets/js/jquery-2.0.3.min.js'>"+"<"+"script>");
		</script>
		<!-- <![endif]-->
		
		<!--[if IE]>
		
		<script type="text/javascript">
			window.jQuery || document.write("<script src='${pageContext.request.contextPath}/resources/egolm/assets/js/jquery-1.10.2.min.js'>"+"<"+"script>");
		</script>
		
		<![endif]-->
		
		<script type="text/javascript">
			if("ontouchend" in document) document.write("<script src='${pageContext.request.contextPath}/resources/egolm/assets/js/jquery.mobile.custom.min.js'>"+"<"+"script>");
		</script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/jquery.ui.touch-punch.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/ace-elements.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/ace.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/footable.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/footable.paginate.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/footable.filter.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/edit-table.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/checked.js"></script>
		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/common.js"></script>
<%-- 		<script src="${pageContext.request.contextPath}/resources/egolm/assets/js/jquery.tips.js"></script> --%>
		<script type="text/javascript">
			//处理表单
			function dealForm(){
					$.ajax({
		                cache: false,
		                type: "POST",
		                url:'agentSubmit',
		                data:$('#rewardFrom').serialize(),
		                async: false,
		                error: function(request) {
		                    alert("Connection error");
		                },
		                success: function(data) {
		                	var res = JSON.parse(data);
		                	if(res.IsValid==true){
		                		$.jalert({
									title:"提示", 
									message:res.ReturnValue, 
									confirmButton:"关闭", 
									confirm:function() {
										window.location.href="toSalesRewardParamList"; 
									}
								});
		                	}else{
		                		$.jalert({
									title:"提示", 
									message:res.ReturnValue, 
									confirmButton:"关闭", 
									confirm:function() {
									}
								});
		                	}
		                }
		            }); 
				}
			
			jQuery(function($) {
				var footable = null,
					$row = null,
					isAll = false,
					deleteType = true;
				$('.supplier table').footable({ //响应式表格初始化
					breakpoints:{
						phone: 480,
				        tablet: 1200
					}
				});
			    
			    $('.chk').on('click',function(){ //选中/取消选中
			    	Checked.checked(this);
			    });
			    
			    $('.batch .chk').on('click',function(){ //全选/取消全选
			    	$('.checked-wrap input').each(function(index){
			    		Checked.selectAll(this,isAll);
			    	});
			    	isAll = !isAll;
			    });
			});
		</script>
</body>
</html>