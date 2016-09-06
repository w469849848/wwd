<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="业务员管理"  currentTopMenu="业务员管理" currentSubMenu="" css="css/add-salesman.css" js="" localCss="" localJs="salesman/add-salesman.js,salesman/salesman-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/sales/salesman_edit.jsp">
				<div class="main-content">
					<div class="page-content">
						<div class="wh_titer">
							<p class="wh_titer_f">您的位置：
								<a href="/${serverName}">首页</a> &gt; 
								<a href="toSalesManList">业务员管理</a>&gt; 
								<a class="active" href="#">编辑业务员</a>
							</p>
						</div>
						<div class="add-box"> <!--  -->
							<form  action ="" method="post" id="salesFrom" name="salesFrom" onsubmit = "return check();" enctype="multipart/form-data"  >
								<input type="hidden" id="sSaleId" name="sSaleId" value="${salesMan.SSaleId}"/>
								<input type="hidden" id="sCreateUserName" name="sCreateUserName" value="${salesMan.SCreateUserName}" />
								<input type="hidden" id="dCreateTime" name="dCreateTime" value="${createTime}" />
								<input type="hidden" id="nCreateUserID" name="nCreateUserID" value="${salesMan.NCreateUserID}" />
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">业务员编号：</span>
										<label class="col-xs-7 col-sm-9">
											<input readonly="readonly" class="border border-radius bg-color" type="text"  id="sSalNum" name="sSalNum" value="${salesMan.SSalNum }"/>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">业务员姓名：</span>
										<label class="col-xs-7 col-sm-9">
											<input class="border border-radius bg-color" type="text"  id="sSalChineseName" name="sSalChineseName" value="${salesMan.SSalChineseName }"/>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">业务员密码：</span>
										<label class="col-xs-7 col-sm-9">
											<input class="border border-radius bg-color" type="text"  id="sPassWord" name="sPassWord" value="${salesMan.SPassWord }"/>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">业务员英文名字：</span>
										<label class="col-xs-7 col-sm-9">
											<input class="border border-radius bg-color" type="text" id="sSalEngName" name="sSalEngName" value="${salesMan.SSalEngName }"/>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">手机号码：</span>
										<label class="col-xs-7 col-sm-9">
											<input class="border border-radius bg-color" type="text"  id="sSalMobileNo" name="sSalMobileNo" value="${salesMan.SSalMobileNo }"/>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">电话/座机：</span>
										<label class="col-xs-7 col-sm-9">
											<input class="border border-radius bg-color" type="text"  id="sSalTelNo" name="sSalTelNo" value="${salesMan.SSalTelNo }"/>
										</label>
									</small>
								</p>
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">业务员类型：</span>
											<div class="col-xs-7 dropdown-wrap">
										         <input type='hidden' id="sSalType" name="sSalType"  value="${salesMan.SSalType }"/>
										        <input type='hidden' id="nSalTypeId" name="nSalTypeId"  value="${salesMan.NSalTypeId }"/>
												<a id="sSalType-type" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
										        </a>
										        <ul id="sSalType-menu" class="dropdown-menu" aria-labelledby="sSalType-type" onmouseleave="changeSalBizZone('sSalType-menu')">
										        </ul>
											</div>
										</div>
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 col-sm-3 input-tips">业务区域：</span>
											<div class="col-xs-7 filter-wrap">
												<label class="filter-select dropdown-wrap adv-margin">
												<input type="hidden" name ="sOrgDesc" id="sOrgDesc" value="${salesMan.SOrgDesc }"/> 
												<input type="hidden" name ="sOrgNO" id="sOrgNO" value="${salesMan.SOrgNO }"/>
													<a class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
														<span class="item-name">${salesMan.SOrgDesc }</span>
														<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
													</a>
													<ul id="dropdown-menu" class="dropdown-menu lv-first no-scroll" aria-labelledby="adv-position">
													</ul>
												</label>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">所属单位：</span>
											<div class="col-xs-7 dropdown-wrap">
												<input type="hidden" name ="sAgentID" id="sAgentID" value="${salesMan.SAgentID }"/>
												<input type="hidden" name ="sAgentNO" id="sAgentNO" />
												<input type="hidden" name ="sAgentName" id="sAgentName" value="${salesMan.SAgentName}"/>
												<a id="zone-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>${salesMan.SAgentName }</span>
										          	<span class="dr"><img src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
										        </a>
										        <ul id="zone-menu" class="dropdown-menu" aria-labelledby="zone">
										        </ul>
											</div>
										</div>
									</div>
								</div>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">备注：</span>
										<label class="col-xs-7 col-sm-9">
											<textarea class="border border-radius bg-color" rows="4"  id="sSalMemo" name="sSalMemo">${salesMan.SSalMemo }</textarea>
										</label>
									</small>
								</p>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2"></span>
										<label class="col-xs-7 col-sm-9">
											<c:if test="${type=='edit' }">
												<input id="submit" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="提交" />
											</c:if>
											<input id="cancel" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="取消" />
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
							      		<p class="pic"><span></span></p>
							      		<p class="text" id="check-msg">保存成功</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="确定" onclick="window.location.href='toSalesManList'"/>
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
						<div class="modal fade success-box" id="warrAlert" tabindex="-1" role="dialog" aria-labelledby="successAlertLabel">
					  	<div class="modal-dialog" role="document">
					    	<div class="modal-content border-radius">
						      	<div class="modal-header">
						      		<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
						      	</div>
						      	<div class="modal-body">
						      		<p class="pic"><span></span></p>
						      		<p class="text" id="check-msg-warr">温馨提示</p>
						        	<p class="btn-box clearfix">
						        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="确定" />
						        	</p>
						      	</div>
					    	</div>
					  	</div>
					</div>
					</div><!-- /.page-content --> 
			</div><!-- /.main-container --> 
</e:point>