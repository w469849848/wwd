<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<c:set scope="application" var="egolmHost" value="${e:egolmHost('')}" />
<c:set scope="application" var="mediaHost" value="${e:mediaHost('')}" />
<c:set scope="application" var="resourceHost" value="${e:resourceHost('')}${serverName}/resources/assets" />
<c:set scope="application" var="localHost" value="${e:localHost()}" />
<c:set scope="application" var="serverName" value="${e:serverName()}" />
<c:set scope="application" var="webHost"
	value="${egolmHost}${serverName}" />
<e:resource title="组织架构管理"  
            currentTopMenu="组织架构管理"
	        currentSubMenu="组织架构管理" 
	        js="js/countUp.js"
	        localJs="common.js"
	        css="css/bootstrap.min.css,css/login.css" 
	        localCss="common.css"
	        showHeader="false"
	        showTopMenu="false" 
	        showFooter="false" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" >
	<!-- <div class="hander"></div> -->
	<div class="login_main">
		<div class="login_main_l">
			<div class="login_logo">
				<img src="${resourceHost}/images/login/logo.png" class="img-responsive wh_logo" alt="Responsive image"> 
					<img src="${resourceHost}/images/login/slogan.png" alt="img" class="img-responsive slogan">
			</div>
			<div class="login_sum">
				<h1>400-638-1707</h1>
				<p class="login_total">全国统一热线</p>
				<p class="login_total" id="myTargetElement" style=" font-size: 12px; "><span class="address"></span>地址：上海市徐汇区枫林路485号枫林创意园区4号楼</p><p class="login_total" id="myTargetElement" style="font-size: 12px;">邮箱：wandian@egolm.com</p>
				<p class="login_total" id="myTargetElement" style="font-size: 12px; ">版权所有 2015万店易购 沪ICP备15000078-1</p>
			</div>
		</div>
		<div class="login_main_r">
			<div class="login_content">
				<!-- <span href="javascript:void(0)" class="erweima"></span> -->
				<div class="wh_form">
					<div class="wh_login_titer">
						<a href="javascript:void(0)" class="erweima"></a>
					</div>

					<form id="sign-form" class="login_hid login-qrcode" action="${webHost}/member/user/signin" method="post">
						<h4 class="login-tit">登录</h4>
						<div class="wh_username">
							<i class="ico_user">
							<img src="${resourceHost}/images/login/login_check1.jpg"></i> 
							<input type="user" id="username" class="user_inp login_input" placeholder="登录名" name="username" value="${username}" autocomplete="off" style="padding-left: 40px;">
						</div>
						<div class="wh_password">
							<i class="ico_user">
							<img src="${resourceHost}/images/login/login_check2.jpg"></i> 
							<input type="password" id="password" class="password_inp login_input" placeholder="密码" name="password" value="${password}" autocomplete="off" style="padding-left: 40px;border: 0px solid #d5d5d5">
						</div>
						<c:if test="${e:showCaptcha()}">
						<div class="yzm_loginth">
							<div class="wh_login_yzm">
								<div class="wh_yzm">
									<i class="ico_user">
									<img src="${resourceHost}/images/login/login_check3.png"></i> 
									<input type="text" id="captcha" class="yzm_inp login_input" placeholder="验证码" name="captcha" autocomplete="off" maxlength="4" style="padding-left: 40px;">
								</div>
							</div>
							<div class="yzm_img">
								<a href="javascript:void(0)"></a>
								<img id="captcha-img" src="${webHost}/captcha/gen" alt="Responsive image">
							</div>
						</div>
						</c:if>
						<div class="wh_login_chk">
							<div class="login_chk">
								<input type="checkbox" name="rememberme" style="-webkit-appearance: checkbox;" ${username != null ?'checked="checked"':''}>&nbsp;&nbsp;&nbsp;
								<span id="rememberme" class="chk_inp">记住我</span>
							</div>
							<div class="chk_paw">
								<%-- <a href="${webHost}/forget/password" class="chk_inp">忘记密码?</a> --%>
							</div>
						</div>
						<div class="login_btn">
							<input type="submit" value="登录" class="login_btnth"></input>
						</div>
						<!-- <div class="register_titer"><p>没有账号？<a href="${webHost}/member/user/signup">立即注册</a></p> </div> -->
					</form>

					<!-- 扫二维码 -->
					<div class="sm_login login-2qrcode">
						<h4 class="sm_login_titer">扫码登录</h4>
						<p class="sm_bg text-center">
							<img src="${resourceHost}/images/login/qr_code.png">
						</p>
						<p class="sm_titer text-center">用万店易购APP,扫码安全登录</p>
					</div>

				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function(){
			var authResult = '${authResult}';
			// console.log(authResult);
			if('USERNAME_OR_PASSWORD_ERROR' == authResult) {
				Common.showMessage("登录名或密码错误！");
			}else if('CAPTCHA_ERROR' == authResult) {
				Common.showMessage("验证码错误！");
			}else if('USER_CAN_NOT_MATCH' == authResult){
				Common.showMessage('登录名存在重复, 请联系系统管理员!');
			}else {
				//Common.showMessage("登录失败！");
			}
			
			$('.erweima').on("click",function(){
			   	if($('.login_hid').hasClass('btn-2qrcode')){
			   		$('.erweima').css("background","url(${resourceHost}/images/login/erweima_th.png) no-repeat");
			   		$('.login_hid').removeClass('btn-2qrcode').addClass('btn-2login');
			   		$('.login_hid').css("display","none");
			   		$('.sm_login').css("display","block");
			   	}else{
			   		$('.erweima').css("background","url(${resourceHost}/images/login/erweima.png) no-repeat");
			   		$('.login_hid').removeClass('btn-2login').addClass('btn-2qrcode');
			   		$('.sm_login').css("display","none");
			   		$('.login_hid').css("display","block");
			   }
			});
			$('#captcha-img').on('click',function(){
				$(this).attr('src',webHost + '/captcha/gen?v=' + new Date());
			});
			$('#rememberme').on('click',function(){
				var checked = $(this).siblings()[0].checked;
				checked ? $(this).siblings()[0].checked = false : $(this).siblings()[0].checked = true;
			});
			
			$('#sign-form').submit(function(){
				if($.trim($('#username').val()) == '') {
					Common.showMessage("请输入登录名！");
					return false;
				}
				else if($.trim($('#password').val()) == '') {
					Common.showMessage("请输入密码！");
					return false;
				}
				else if($('#captcha').length > 0 && $.trim($('#captcha').val()) == '') {
					Common.showMessage("请输入验证码！");
					return false;
				} else {
					return true;
				}
			});
		});
	</script>
</e:point>
