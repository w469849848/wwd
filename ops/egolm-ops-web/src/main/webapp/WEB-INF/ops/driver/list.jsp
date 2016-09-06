<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="物流管理" currentTopMenu="物流管理" currentSubMenu="司机管理"
	css="css/dealer-manage.css,css/pagination.css,css/order-list.css"
	js="js/footable.js,js/checked.js"
	localCss="driver/driver.css" 
	localJs="media/media-base.js,driver/driver.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： 
					<a href="${webHost}/">首页</a> &gt; 
					<a href="${webHost}/logistics/driver/index">物流管理</a>&gt; 
					<a class="active" href="${webHost}/logistics/driver/index">司机管理</a>
				</p>
			</div>
			<div class="driver-manage table-box">
				<form id="driver-search-form" action="${webHost}/logistics/driver/queryDrivers" method="post" >
				<!-- 司机 -->
				<div class="filter-wrap">
					<label class="notice-input">
						<i class="icon-search f-95"></i>
						<input class="filter border-radius bg-color" id="f-sDrivemanNo" name="sDrivemanNoAndName" value="${sDrivemanNoAndName}" placeholder="司机编号/司机姓名" id="filter" type="text" />
					</label>
					<label class="filter-select dropdown-wrap">
						<input type= "hidden" name="driverState" id = "driverState"  value="${driverState.name}"/>
						<a class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
							<span id="driver-status-text">${null != driverState?driverState.description : '审核状态'}</span>
							<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
						</a>
						<ul id="driver-status-memu" class="dropdown-menu">
							<li value="">全部</li>
							<li value="ENABLE">已启用</li>
							<li value="DISABLE">已禁用</li>
 						</ul>
					</label>
					<label class="filter-select dropdown-wrap">
					<span id="search-driver" class="pull-right" >
						<a class="add-dealer" href="javascript:void(0);">
							<i></i><span>查询</span>
						</a>
					</span>
					</label>
					<label class="filter-select dropdown-wrap">
					<span id="create-driver" class="pull-right" >
						<a class="add-dealer" href="javascript:void(0);">
							<i class="fa fa-plus" aria-hidden="true"></i>新增司机<span></span>
						</a>
					</span>
					</label>
				</div>
				</form>
				<table class="footable table" data-page-size="10">
					<thead class="bg-color">
						<tr>
							<th></th>
							<th>司机编号</th>
							<th>司机姓名</th>
							<th>用户密码</th>
							<th>联系方式</th>
							<th>所属仓库</th>
							<th>状态</th>
							<th>备注</th>
							<th>管理</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="driver" items="${drivers}">
							<tr>
								<td>
									<label class="checked-wrap">
									<input type="checkbox" class="chk driver-check" data-tag="${driver.nTag}" data-id="${driver.sDrivemanId}"/> 
									<span class="chk-bg"></span>
									</label>
								</td>
								<td>${driver.sDrivemanNo}</td>
								<td>${driver.sDrivemanName}</td>
								<td>${driver.sDrivemanPwd}</td>
								<td>${driver.sTel}</td>
								<td>${driver.sWarehouseName}</td>
								<td data-tag="${driver.nTag}">
								<c:choose>
								<c:when test="${driver.nTag == 0}">
								<span class="state"><img src="${resourceHost}/images/circle.png" /></span>已启用
								</c:when>
								<c:when test="${driver.nTag == 1}">
								<span class="state"><img src="${resourceHost}/images/close.png" /></span>已禁用
								</c:when>
								<c:otherwise>
								<span class="state"><img src="${resourceHost}/images/close.png" /></span>已删除
								</c:otherwise>
								</c:choose>
								</td>
								<td>${driver.sMemo}</td>
								<td>
									<a class="edit" href="${webHost}/logistics/driver/modifyDriver?sDrivemanId=${driver.sDrivemanId}"><img src="${resourceHost}/images/edit.png" alt="编辑" /></a> 
									<a class="delete" href="javascript:void(0)"><img src="${resourceHost}/images/delete.png" alt="删除" /></a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="10" class="clearfix">
								<div class="batch">
									<label class="checked-wrap">
										<input type="checkbox" class="chk check-all" />
										<span class="chk-bg"></span>
										<span class="txt">全选/取消</span>
									</label> 
									<e:authorize path="/logistics/driver/auditDriver">
										<label>
											<input id="batch-audit" class="border border-radius bg-color f-50" type="button" value="启用／禁用" />
										</label>
									</e:authorize>
									<label>
										<input id="batch-export" class="border border-radius bg-color f-50" type="button" value="批量导出" />
									</label>
								</div>
								<c:set var="pagerForm" value="driver-search-form" scope="request"/>
								<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>

			<!-- 编辑 -->
			<div class="modal fade edit-box" id="editDriver" tabindex="-1" role="dialog" aria-labelledby="editDriverLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-body">
							<form id="modify-driver-form" >
								<div class="scroll-wrap">
									<p>
										<label><span>司机编号：</span>
										<input name="sDrivemanId" id="m-sDrivemanId" type="hidden">
										<input name="sDrivemanNo" id="m-sDrivemanNo" type="text" value="苏州嘉禾"></label>
									</p>
									<p>
										<label><span>司机姓名：</span>
										<input name="sDrivemanName" id="m-sDrivemanName" type="text" value="张先生"></label>
									</p>
									<p>
										<label><span>用户密码：</span>
										<input name="sDrivemanPwd" id="m-sDrivemanPwd" type="text" value="18000000000"></label>
									</p>
									<p>
										<label><span>联系方式：</span>
										<input name="sTel" id="m-sTel" type="text" value="江苏苏州"></label>
									</p>
									<p>
										<label><span>所属仓库：</span>
										<input name="sWareHouseNo" id="m-sWareHouseNo" type="text" value="1111"></label>
									</p>
									<p>
										<label><span>状态：</span>
										<select name="nTag" id="m-nTag">
											<option value="0">启用</option>
											<option value="1">禁用</option>
											<option value="2">删除</option>
										</select>
										</label>
									</p>
									<p>
										<label><span>备注：</span><textarea style="width:400px;display:inline;" name="sMemo" id="m-sMemo"></textarea></label>
									</p>
								</div>
								<p class="clearfix">
									<label class="pull-left">
									<input id="submit-modify-driver" type="button" value="保存">
									</label>
									<label class="pull-right">
									<input type="button" data-dismiss="modal" value="取消">
									</label>
								</p>
							</form>
						</div>
					</div>
				</div>
			</div>

			<div class="modal fade edit-box" id="audit-alert" tabindex="-1" role="dialog" aria-labelledby="editNoticeLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content border-radius">
						<div class="modal-body">
							<form id="notice-modify-form">
								<div class="scroll-wrap" style="text-align : center;" >
							       	<p>
							       		<label>
							        	<span id="a-audit-tag" >确定要启用吗</span>
							        	<!-- <select name="nTag" style="width: 25%;" id="a-audit-tag">
							        		<option value="0" id="enable-value" >启用</option>
							        		<option value="1" id="disable-value" >禁用</option>
							        	</select> -->
							        	</label>
							        </p>
							   	</div>
							    <p class="clearfix">
							    	<label class="pull-left"><input id="submit-audit" type="button" value="确定"></label>
							    	<label class="pull-right"><input type="button" data-dismiss="modal" value="取消"></label>
							    </p>
							</form>
						</div>
					</div>
				</div>
			</div>	
			
			<!-- 确定删除弹窗 -->
			<div class="modal fade delete-box" id="deleteAlert" tabindex="-1" role="dialog" aria-labelledby="deleteAlertLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content border-radius">
						<div class="modal-header">
							<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
						</div>
						<div class="modal-body">
							<p class="pic"><span></span></p>
							<p class="text">是否确认删除？</p>
							<p class="btn-box clearfix">
								<input class="bg-color border-radius border" type="button" id="btn-confirm" value="确定" />
								<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="取消" />
							</p>
						</div>
					</div>
				</div>
			</div>
			
			<!--保存成功-->
			<div class="modal fade success-box" id="successAlert" tabindex="-1" role="dialog" aria-labelledby="successAlertLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content border-radius">
						<div class="modal-header">
							<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
						</div>
						<div class="modal-body">
							<p class="pic"><span></span></p>
							<p class="text">保存成功</p>
							<p class="btn-box clearfix">
								<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="确定" />
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</e:point>