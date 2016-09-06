<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="物流管理" currentTopMenu="物流管理" currentSubMenu="司机管理"
	css="css/add-salesman.css" 
	js=""
	localCss="driver/driver.css" 
	localJs="media/media-base.js,driver/driver.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp">
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： 
					<a href="${webHost}/">首页</a> &gt; 
					<a href="javascript:void(0);">物流管理</a>&gt; 
					<a href="${webHost}/logistics/driver/index">司机管理</a>&gt;
					<a class="active" href="${webHost}/logistics/driver/modifyDriver?sDrivemanId=${driver.getSDrivemanId()}">修改司机信息</a> 
				</p>
			</div>
			<div class="add-box">
				<form id="modify-driver-form">
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7"> 
							<span class="col-xs-4 col-sm-2"><font color="red">*</font>司机编号：</span>
							<label class="col-xs-7 col-sm-9">
								<input type="hidden" name="sDrivemanId" value="${driver.getSDrivemanId()}" />
								<input name="sDrivemanNo" class="border border-radius bg-color" type="text" value="${driver.getSDrivemanNo()}" />
							</label>
						</small>
					</p>
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
							<span class="col-xs-4 col-sm-2"><font color="red">*</font>司机姓名：</span>
							<label class="col-xs-7 col-sm-9">
								<input name="sDrivemanName" class="border border-radius bg-color" type="text" value="${driver.getSDrivemanName()}" />
							</label>
						</small>
					</p>
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
							<span class="col-xs-4 col-sm-2"><font color="red">*</font>用户密码：</span>
							<label class="col-xs-7 col-sm-9">
								<input name="sDrivemanPwd" class="border border-radius bg-color" type="text" value="${driver.getSDrivemanPwd()}" />
							</label>
						</small>
					</p>
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
						<span class="col-xs-4 col-sm-2"><font color="red">*</font>联系方式：</span>
							<label class="col-xs-7 col-sm-9">
								<input name="sTel" class="border border-radius bg-color" type="text" value="${driver.getSTel()}" />
							</label>
						</small>
					</p>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
							<div class="col-xs-12 col-sm-6 mr">
								<span class="col-xs-4 input-tips"><font color="red">*</font>所属区域：</span>
								<div class="col-xs-7 dropdown-wrap">
									<a class="dropdown-btn border border-radius bg-color dropdown-toggle adapt-list" 
									   href="javascript:void(0)" data-toggle="dropdown" role="button"
									   aria-haspopup="true" aria-expanded="true">
									   <span class="item-name" id="current-org">${org.sOrgDesc == null ? '请选择' : org.sOrgDesc}</span>
									   <input type="hidden" name="sOrgNO" id="sOrgNO" value="${org.sOrgNO}"/>
									   <span class="dr">
									   <img src="${resourceHost}/images/arrow-black.png" />
									   </span>
									</a>
									<ul id="org-list" class="dropdown-menu" aria-labelledby="salesman-type">
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
							<div class="col-xs-12 col-sm-6 mr">
								<span class="col-xs-4 input-tips adapte-second"><font color="red">*</font>经销商：</span>
								<div class="col-xs-7 dropdown-wrap">
									<a class="dropdown-btn border border-radius bg-color dropdown-toggle adapt-list" 
								   		href="javascript:void(0)" data-toggle="dropdown" role="button"
								   		aria-haspopup="true" aria-expanded="true">
								   		<span class="item-name" id="current-agent">${agent.getSAgentName() == null ? '请选择' : agent.getSAgentName()}</span>
								   		<input type="hidden" name="nAgentID" id="nAgentID" value="${agent.getNAgentID()}" />
								   		<span class="dr"><img src="${resourceHost}/images/arrow-black.png" /></span>
									</a>
									<ul id="agent-list" class="dropdown-menu" aria-labelledby="salesman-type"></ul>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
							<div class="col-xs-12 col-sm-6 mr">
								<span class="col-xs-4 input-tips adapte-second"><font color="red">*</font>所属仓库：</span>
								<div class="col-xs-7 dropdown-wrap">
									<a class="dropdown-btn border border-radius bg-color dropdown-toggle adapt-list" 
								   		href="javascript:void(0)" data-toggle="dropdown" role="button"
								   		aria-haspopup="true" aria-expanded="true">
								   		<span class="item-name" id="current-ware-house">${driver.getSWarehouseName() == null ?'请选择' : driver.getSWarehouseName()}</span>
									    <input type="hidden" name="sWareHouseNo" id="sWareHouseNo" value="${driver.getSWareHouseNo()}"/>
									    <input type="hidden" name="sWarehouseName" id="sWarehouseName" value="${driver.getSWarehouseName()}" />
								   		<span class="dr"><img src="${resourceHost}/images/arrow-black.png" /></span>
									</a>
									<ul id="warehouse-list" class="dropdown-menu" aria-labelledby="salesman-type"></ul>
								</div>
							</div>
						</div>
					</div>
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
						<span class="col-xs-4 col-sm-2"><font color="white">&nbsp;&nbsp;</font>备注：</span>
						<label class="col-xs-7 col-sm-9">
						<textarea name="sMemo" class="border border-radius bg-color" rows="4" >${driver.getSMemo()}</textarea>
						</label>
						</small>
					</p>
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
						<span class="col-xs-4 col-sm-2"></span>
						<label class="col-xs-7 col-sm-9">
						<input id="submit-modify-driver" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="保存" />
						<input id="cancel-create-driver" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="取消" />
						</label>
						</small>
					</p>
				</form>
			</div>

			<!--保存成功-->
			<div class="modal fade success-box" id="successAlert" tabindex="-1" role="dialog" aria-labelledby="successAlertLabel">
				<div class="modal-dialog" role="document">
					<div class="modal-content border-radius">
						<div class="modal-header">
							<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
						</div>
						<div class="modal-body">
							<p class="pic">
								<span></span>
							</p>
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

