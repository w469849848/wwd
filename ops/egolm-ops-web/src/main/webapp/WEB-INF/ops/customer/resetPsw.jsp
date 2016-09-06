<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>

<e:resource title="会员管理" currentTopMenu="会员管理" currentSubMenu="" css=""
	js="js/common.js" localCss="cust/reset-pwd.css" localJs="cust/pwd-reset.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp"
	currentPath="/WEB-INF/ops/customer/resetPsw.jsp">
	
	<div class="main-content">

		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}">首页</a> 会员管理 &gt; <a href="custPswManage">密码管理</a>
					&gt; <a class="active" href="resetPsw?ids=${ids }">重置密码</a>
				</p>
			</div>

			<div class="reset-pwd">
				<!-- 重置密码 -->
				<form >
					<input type="hidden" value="${ids }" id="sCustNOIds"/>
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7"> <span
							class="col-xs-4 col-sm-2">新密码：</span> <label
							class="col-xs-7 col-sm-9"> <input name="password"
								id="password" class="border border-radius bg-color" type="password" />
						</label>
						</small>
					</p>
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7"> <span
							class="col-xs-4 col-sm-2">确认密码：</span> <label
							class="col-xs-7 col-sm-9"> <input id=""
								class="border border-radius bg-color" type="password" />
						</label>
						</small>
					</p>
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7"> <span
							class="col-xs-4 col-sm-2">备注：</span> <label
							class="col-xs-7 col-sm-9"> <textarea name="remork"
									class="border border-radius bg-color" rows="4"></textarea>
						</label>
						</small>
					</p>
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7"> <span
							class="col-xs-4 col-sm-2"></span> <label
							class="col-xs-7 col-sm-9"> <input id="reset_psw_btn"
								class="border-radius border col-xs-6 col-sm-3 col-md-3"
								type="button" value="保存" /> <input onclick="location.href='custPswManage'"
								class="border-radius border col-xs-6 col-sm-3 col-md-3"
								type="button" value="返回" />
						</label>
						</small>
					</p>
				</form>
			</div>

			<!--保存成功-->
			<div class="modal fade success-box" id="successAlert" tabindex="-1"
				role="dialog" aria-labelledby="successAlertLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content border-radius">
						<div class="modal-header">
							<a class="pull-right" data-dismiss="modal"
								href="javascript:void(0)"></a>
						</div>
						<div class="modal-body">
							<p class="pic">
								<span></span>
							</p>
							<p class="text" id="msg_p">重置密码成功</p>
							<p class="btn-box clearfix">
								<input class="bg-color border-radius border" type="button"
									data-dismiss="modal" value="确定" />
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /.main-content -->
</e:point>