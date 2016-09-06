<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="业务员管理"  currentTopMenu="业务员管理" currentSubMenu="" css="css/salesman-manage.css"   js="js/common.js"  localCss="" localJs="salesman/salesman-manage.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/sales/salesman_list.jsp">
				<div class="main-content">
					<div class="page-content">
						<div class="wh_titer">
							<p class="wh_titer_f">您的位置：
								<a href="/${serverName}">首页</a> &gt; 
								<a href="javascript:void(0);">业务员管理</a> &gt; 
								<a class="active" href="toSalesManList">业务员管理</a>
							</p>
						</div>
					<div class="audit table-box border-radius"> <!-- 审核表 -->
						<form action="toSalesManList" id="limitPageForm">
							<input type="hidden" name="page.index" value="${page.index}"/>
							<input type="hidden" name="page.limit" value="10"/>
							<input type="hidden" name="page.limitKey" value="dCreateTime DESC"/>		
							<div class="filter-wrap">
								<label class="">
									<i class="icon-search f-95"></i>
									<input class="filter border-radius bg-color"  width="60px" placeholder="业务员姓名/业务员编号" id="sSalParam" name="sSalParam" type="text" value="${sSalParamTrim}" />
								</label>
								<label class="">
									<a id="tag-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										<span id="tagSpan">全部</span>
										<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
									</a>
									<input type="hidden" id="nTag" name="nTag" value="${nTag }">
									<ul id="tag-menu" class="dropdown-menu" aria-labelledby="tag-id">
										 <li value=""><a id="" name="全部">全部</a></li>
										 <li value=""><a id="0" name="已启用">已启用</a></li>
										 <li value=""><a id="1" name="已禁用">已禁用</a></li>
									</ul>
								</label>
								<lable>
									<span class="pull-right">
											<a class="add-man"  href="toAddSalesMan"><i class="add-icon"></i>新增业务员</a>
											<a class="add-man" href="#" onclick='$("#limitPageForm").submit()'>查询<span></span></a>
									</span>
								</lable>
							</div>
							</form>
							<table class="footable table even" data-page-size="10">
								<thead class="bg-color">
									<tr>
										<th></th>
										<th data-toggle="true">业务员编号</th>
										<th data-hide="phone">业务员姓名</th>
										<th data-hide="phone">英文名字</th>
										<th data-hide="phone">业务员类型</th>
										<th data-hide="phone,tablet">所属单位</th>
										<th data-hide="phone">手机号码</th>
										<th data-hide="phone">座机</th>
										<th data-hide="phone">业务区域</th>
										<th data-hide="phone,tablet">创建时间</th>
										<!-- <th data-hide="phone">修改时间</th> -->
										<th data-hide="phone">备注</th>
										<th data-hide="phone">状态</th>
										<th>管理</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${datas.DataList}" var="d">
										<tr>
											<td>
												<label class="checked-wrap">
													<input type="checkbox" class="chk"  onclick="changeChkStatus(this)" id="SaleId_chk" value="${d.sSaleId}"  attr="${d.nTag}" data-id="${d.sSaleId}" />
													<span class="chk-bg"></span>
												</label>
											</td>
											<td>${d.sSalNum}</td>
											<td>${d.sSalChineseName}</td>
											<td>${d.sSalEngName}</td>
											<td>${d.sSalType}</td>
											<td>${d.sAgentName}</td>
											<td>${d.sSalMobileNo}</td>
											<td>${d.sSalTelNo}</td>
											<td>${d.sOrgDesc}</td>
											<td><fmt:formatDate value="${d.dCreateTime}" type="date" /></td>
											<%-- <td><fmt:formatDate value="${d.dModifyTime}" type="date" /></td> --%>
											<td>${d.sSalMemo}</td>
											<td><span class="state">
											<c:if test="${d.nTag ==0}">
												<img src="${pageContext.request.contextPath}/resources/egolm/assets/images/circle.png"/></span>已启用
											</c:if>
											<c:if test="${d.nTag ==1}">
												<img src="${pageContext.request.contextPath}/resources/egolm/assets/images/close.png"/></span>已禁用
											</c:if>
											</td>
											<td>
												<a class="edit"  href="toEditSalesMan?nSalesManID=${d.sSaleId}&type=edit"><img src="${resourceHost}/images/edit.png" alt="编辑" /></a>
												<a class="delete" pid="${d.sSaleId}" href="javascript:void(0)" ><img src="${resourceHost}/images/delete.png" alt="删除" /></a>
												<a class="change" href="javascript:seletSalesmanNO('salesmanNOList?saleNO=${d.sSaleId }')" ><img src="${resourceHost}/images/reset.png" alt="删除" /></a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="14" class="clearfix">
											<div class="batch">
												<label>
													<input type="checkbox" class="chk" />
													<span class="chk-bg"></span>
													<span class="txt">全选/取消</span>
												</label>
												<label><input class="border border-radius bg-color f-50" id="batch-confirm" type="button" value="启用／禁用" /></label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量重置密码"  id="batch-reset"/></label>
												<label><input class="border border-radius bg-color f-50" type="button" value="批量导出"  onClick="exportExcel();"/></label>
												
											</div>
											<c:set var="pagerForm" value="limitPageForm" scope="request"/>
											<jsp:include page="/WEB-INF/common/pager.jsp"></jsp:include>
										</td>
									</tr>
								</tfoot>
							</table>
						</div>
						<!-- 确定删除弹窗 -->
						<div class="modal fade delete-box" id="deleteAlert" tabindex="-1" role="dialog" aria-labelledby="deleteAlertLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
							      	<div class="modal-header">
							      		<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
							      	</div>
							      	<div class="modal-body">
							      		<input type="hidden"  id = "delete-salesmane-id"  />
							      		<p class="pic"><span></span></p>
							      		<p class="text">是否确认删除业务员？</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" id="btn-confirm" value="确定" />
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="取消" />
							        	</p>
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
						<!--保存成功-->
						<div class="modal fade success-box" id="successAlert" tabindex="-1" role="dialog" aria-labelledby="successAlertLabel">
						  	<div class="modal-dialog" role="document">
						    	<div class="modal-content border-radius">
							      	<div class="modal-header">
							      		<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
							      	</div>
							      	<div class="modal-body">
							      		<p class="pic"><span></span></p>
							      		<p class="text" id="check-msg">保存成功2</p>
							        	<p class="btn-box clearfix">
							        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="确定" />
							        	</p>
							      	</div>
						    	</div>
						  	</div>
						</div>
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>