<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="添加用户" currentTopMenu="组织架构管理"
	currentSubMenu="用户"
	css="css/notice-manage.css,css/pagination.css,css/footable.core.css"
	js=""
	localCss="member/member.css,member/group.css" localJs="member/member.js,member/user.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}"> 首页</a> &gt; <a
						href="javascript:void(0);"> 组织架构管理</a> &gt; <a
						href="/${serverName}/member/user/index">用户</a> &gt; <a
						href="/${serverName}/member/user/signup" class="active">
						添加用户</a> &gt;
				</p>
			</div>
			<input type="hidden" id="forward-group-id" name="forwardGroupId" value="${groupId}" >
			<div style="display: inline;background: #FFF;">
				<div class="tool-bar">
					<div class="role-left-side" style="float: none;" >
						<form id="create-user-form">
						<div class="scroll-wrap">
							<p>
								<label><font color="red">*</font><span id="id-label">用户名称：</span>
									<input type="text" id="user-name" name="name" type="text" value="">
								</label>
							</p>
							<p>
								<label><font color="black">*</font><span id="name-label">手机号：</span>
									<input id="user-mobile" name="mobile" type="text" value="">
								</label>
							</p>
							<p>
								<label><font color="red">*</font><span id="name-label">用户密码：</span>
									<input id="user-password" name="password" type="text" value="">
								</label>
							</p>
							<p>
								<label for="province"><font color="red">*</font><span id="province-label">用户类型：</span>
									<select id="user-type" name="type" >
										<!-- <option value="AGENT">经销商</option> -->
										<option value="OPERATOR">运营人员</option>
									</select>
								</label>
							</p>
							<p>
								<!-- <label><font color="red">*</font><span id="name-label">经销商编号：</span>
									<input id="real-id" name="realId" type="text" value="">
								</label> -->
							</p>
						</div>
						</form>
						<!-- <p class="clearfix">
							<label class="pull-left"><input type="button" class="btn btn-info" id="submit-user-create" value="保存" /></label>
							<label class="pull-right" style="margin: 40px 60% auto auto;"><input type="button" class="btn btn-info" id="cancel-user-create" value="取消"></label>
						</p> -->
						<p class="filter-wrap user-create">
							<span><a id="cancel-user-create" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>取消</span></a></span>
							<span><a id="submit-user-create" class="add-notice notice-button" href="javascript:void(0);"><i></i><span>保存</span></a></span>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</e:point>


