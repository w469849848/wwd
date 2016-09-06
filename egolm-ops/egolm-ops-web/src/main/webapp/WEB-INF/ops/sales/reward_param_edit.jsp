<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="业务员管理"  currentTopMenu="业务员管理" currentSubMenu="" css="" js="" localCss="" localJs="" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/sales/reward_param_edit.jsp">


				<div class="main-content">
					<div class="page-content">
						<div class="wh_titer">
							<p class="wh_titer_f">
								<a href="/${serverName}">首页</a> &gt; 
								<a href="salesman-manage.html">奖励参数管理</a> &gt; 
								<a class="active" href="add-salesman.html">新增奖励参数</a>
							</p>
						</div>
						
						<div class="add-box"> <!-- 新增经销商 -->
							<form action="${pageContext.request.contextPath}/salesreward/saveSalesRewardParam.do" method="post" id="rewardFrom" name="rewardFrom" >
							    <input type="hidden" id="nSalRoyID" name="nSalRoyID" value="${reward.NSalRoyID}" />
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">提成比例：</span>
										<label class="col-xs-7 col-sm-9">
											<input class="border border-radius bg-color" type="text"  id="nRoyaltyRate" name="nRoyaltyRate" value="${reward.NRoyaltyRate }"/>
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
											<textarea class="border border-radius bg-color" rows="4"  id="sMemo" name="sMemo"> ${reward.SMemo }</textarea>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2"></span>
										<label class="col-xs-7 col-sm-9">
										    <a href="" class="border-radius border col-xs-6 col-sm-3 col-md-3"  type="submit" >关闭</a>
											<input class="border-radius border col-xs-6 col-sm-3 col-md-3"  type="submit" value="关闭"  />
											<c:if test="${type=='edit' }">
													<input class="border-radius border col-xs-6 col-sm-3 col-md-3" type="submit" value="保存" />
											</c:if>
										</label>
									</small>
								</p>
							</form>
						</div>
					</div><!-- /.page-content -->
			</div><!-- /.main-container-inner -->
		 
		
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
			$(document).ready(function() {
			});
			//表单检验
			function check(){
				if($("#sSalNum").val()==""){
					$("#sSalNum").tips({
						side:3,
			            msg:'请填写业务员编号',
			            bg:'#AE81FF',
			            time:2
			        });
					$("#sSalNum").focus();
					return false;
				}
				var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
				if($("#sSalMobileNo").val().length>0){
					if($("#sSalMobileNo").val().length != 11 && !myreg.test($("#sSalMobileNo").val())){
						$("#sMobile").tips({
							side:3,
				            msg:'手机格式不正确',
				            bg:'#AE81FF',
				            time:3
				        });
						$("#sSalMobileNo").focus();
						return false;
					}
				}
			}
			//处理表单
			function dealForm(){
				if(check()){
					$.ajax({
		                cache: false,
		                type: "POST",
		                url:'agentSubmit',
		                data:$('#salesFrom').serialize(),
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
										window.location.href="toSalesManList"; 
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
</e:point>