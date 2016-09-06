<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="业务员管理" currentTopMenu="业务员管理" currentSubMenu="每日线路"
	css="" js="" localCss="member/member.css,member/group.css"
	localJs="member/member.js,member/group.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}"> 首页</a> &gt; 
					<a href="javascript:void(0);"> 业务员管理</a> &gt; 
					<a href="/${serverName}/salesman/line/index"> 每日线路</a> &gt;
				</p>
			</div>
			<input type="hidden" id="forward-group-id" name="forwardGroupId"
				value="${groupId}">
			<div style="position: absolute; display: inline;">
				<div class="tool-bar">
					<div class="base-tree-body">
						<div id='pre-group-content'
							class="menuContent ztreeMC tree-content">
							<ul id="create-group-tree" class="ztree group-tree"></ul>
						</div>
					</div>
					<div class="role-left-side">
						<form id="create-group-form">
							<div class="scroll-wrap">
								<p>
									<label><font color="red">*</font><span id="id-label">组织编号：</span>
										<input id="group-id" name="id" type="text" value=""> <input
										type="hidden" id="group-parentId" name="parentId" type="text"
										value=""> </label>
								</p>
								<p>
									<label><font color="red">*</font><span id="name-label">组织名称：</span>
										<input id="group-name" name="name" type="text" value="">
									</label>
								</p>
								<p>
									<input type="hidden" name="groupTyp" id="groupTyp" /> <input
										type="hidden" name="groupTypId" id="groupTypId" /> <input
										type="hidden" name="regionNO" id="regionNO" /> <label
										for="province"><font color="red">*</font><span
										id="province-label">省：</span> <select id="group-province"
										name="province">
											<option></option>
									</select> </label>
								</p>
								<p>
									<label for="city"><font color="red">*</font><span
										id="city-label">市：</span> <select id="group-city" name="city">
											<option></option>
									</select> </label>
								</p>
							</div>
						</form>
						<p class="clearfix">
							<label class="pull-left"><input type="button"
								class="btn btn-info" id="submit-group-create" value="保存" /></label> <label
								class="pull-right"><input type="button"
								class="btn btn-info" id="cancel-group-create" value="取消"></label>
						</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</e:point>


