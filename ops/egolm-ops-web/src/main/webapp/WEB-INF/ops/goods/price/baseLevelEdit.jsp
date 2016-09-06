<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="基础等级管理"  currentTopMenu="商品价格管理" currentSubMenu="基础等级管理" css="css/baseLevelEdit.css" js="js/common.js" localCss="" localJs="goods/price/baseLevelEdit.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/goods/price/baseLevelEdit.jsp">
	<div class="main-content">

		<div class="page-content">

			<div class="wh_titer">
				<p class="wh_titer_f">
					<a href="goodsPriceLevelList">首页</a> &gt; 
					<a href="baseLevelList">商品价格管理</a> &gt; 
					<a href="baseLevelList">基础等级管理</a> &gt; 
					<a class="active" href="baseLevelEdit">${curtitle }</a>
				</p>
			</div>

			<div class="add-leve">
				<div class="form">
					<form id="baseLevelForm" name="baseLevelForm" action=""
						method="post" enctype="multipart/form-data">
						<input type="hidden" value="${nLevel }" name="nLevel" id="nLevel" />
						<input type="hidden" value="${type }" name="type" id="type" />
						<div class="row">
							<div class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
								<div class="col-xs-12 col-sm-6">
									<span class="col-xs-4 input-tips">合同编号：</span>
									<div class="col-xs-7 dropdown-wrap" id="divLeve">
										<a id="area-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> 
											<span id="sConstractSpan" >
												<c:choose>
													<c:when test="${type eq 'add' }">
														请选择
													</c:when>
													<c:otherwise>
														${constractNO }
													</c:otherwise>
												</c:choose>
											</span>
											<input type="hidden" id="constractNO" name="constractNO" value="${constractNO }">
											<span class="dr"><img src="${resourceHost}/images/arrow-black.png"></span>
										</a>
										<ul id="area-menu" class="dropdown-menu" aria-labelledby="area-btn">
											<c:forEach items="${agent }" var="a">
										 		<li><a id="${a.sAgentContractNO}" name="${a.sAgentContractNO}" onClick="getAgentContent(this)">${a.sAgentContractNO}</a></li>
										 	</c:forEach>
										</ul>
									</div>
								</div>
							</div>
						</div>
						
						<p class="row">
							<small class="col-xs-10 col-sm-7 col-md-7 col-lg-6"> <span
								class="col-xs-4 col-sm-2">等级名称：</span> <label
								class="col-xs-7 col-sm-4 dropdown-wrap"> <input
									class="border border-radius bg-color"
									value="${sLevelName}" id="sLevelName" name="sLevelName" 
									type="text" />
							</label>
							</small>
						</p>
						<p class="row">
							<small class="col-xs-10 col-sm-7 col-md-7 col-lg-6"> <span
								class="col-xs-4 col-sm-2">默认折扣：</span><label
								class="col-xs-7 col-sm-4 dropdown-wrap">
								<input type="hidden" value="${nDisRate }" name="oldNDisRate" id="oldNDisRate" />
								<input
									class="border border-radius bg-color"
									value="${nDisRate }" id="nDisRate"
									name="nDisRate" type="text" />
							</label><span class="col-xs-7 col-sm-4">%</span>
							</small>
						</p>

						<p class="row">
							<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7"> <span
								class="col-xs-4 col-sm-2"></span> <label
								class="col-xs-7 col-sm-9"> <input id="submitForm"
									class="border-radius border col-xs-6 col-sm-3 col-md-3"
									type="button" value="保存" /> <input
									class="cancel border-radius border col-xs-6 col-sm-3 col-md-3"
									type="button" value="返回" onclick="location.href='baseLevelList'" />
							</label>
							</small>
						</p>
					</form>
				</div>
			</div>
		</div>
		<!-- /.page-content -->
	</div>
</e:point>