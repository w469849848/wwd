<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="商品价格批量管理"  currentTopMenu="商品价格管理" currentSubMenu="商品价格批量管理" css="css/goodsPriceLevelBatch.css" js="js/common.js" localCss="" localJs="goods/price/goodsPriceLevelBatch.js,media/media-base.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/goods/price/goodsPriceLevelBatch.jsp">
	<div class="main-content">

		<div class="page-content">

			<div class="wh_titer">
				<p class="wh_titer_f">
					<a href="goodsPriceLevelList">首页</a> &gt; 
					<a href="goodsPriceLevelList">商品价格管理</a> &gt; 
					<a href="goodsPriceLevelList">商品价格管理</a> &gt; 
					<a class="active" href="goodsPriceLevelBatch">商品价格批量管理</a>
				</p>
			</div>

			<div class="add-leve">
				<div class="form">
					<form id="goodsPriceLevelBatchForm" name="goodsPriceLevelBatchForm" action="goodsPriceLevelBatch"
						method="post" enctype="multipart/form-data">
						<input type="hidden" name="showDetail" value="${showDetail }">
						<div class="row">
							<div class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
								<div class="col-xs-12 col-sm-6">
									<span class="col-xs-4 input-tips">合同编号：</span>
									<div class="col-xs-7 dropdown-wrap" id="divLeve">
										<a id="contract-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> 
											<span id="sConstractSpan" >
												<c:choose>
													<c:when test="${constractNO ne '' && constractNO ne null}">
														${constractNO }
													</c:when>
													<c:otherwise>
														请选择
													</c:otherwise>
												</c:choose></span>
											<input type="hidden" id="constractNO" name="constractNO" value="${constractNO }">
											<span class="dr"><img src="${resourceHost}/images/arrow-black.png"></span>
										</a>
										<ul id="constract-menu" class="dropdown-menu" aria-labelledby="constract-btn">
											<c:forEach items="${agent }" var="a">
										 		<li><a id="${a.sAgentContractNO}" name="${a.sAgentContractNO}">${a.sAgentContractNO}</a></li>
										 	</c:forEach>
										</ul>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6">
									<span class="col-xs-4 input-tips">等级：</span>
									<div class="col-xs-7 dropdown-wrap" id="divLeve">
										<a id="level-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> 
											<span id="sLevelSpan" >选择等级</span>
											<input type="hidden" id="nLevel" name="nLevel" value="${nLevel }">
											<span class="dr"><img src="${resourceHost}/images/arrow-black.png"></span>
										</a>
										<ul id="level-menu" class="dropdown-menu" aria-labelledby="level-btn">
											
										</ul>
									</div>
								</div>
							</div>
						</div>
						<p class="row">
							<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7"> <span
								class="col-xs-4 col-sm-2"></span> <label
								class="col-xs-7 col-sm-9"> <input id="submitForm"
									class="border-radius border col-xs-6 col-sm-3 col-md-3"
									type="button" value="查询" /> <input
									class="cancel border-radius border col-xs-6 col-sm-3 col-md-3"
									type="button" value="返回" onclick="location.href='goodsPriceLevelList'" />
							</label>
							</small>
						</p>
					</form>
				</div>
				<div class="queryInfo" style="display: none;">
					<form id="applyBatchFrom" name="applyBatchFrom" action=""
						method="post" enctype="multipart/form-data">
						<input type="hidden" id="applyConstractNO" name="applyConstractNO" value="${constractNO }">
						<input type="hidden" id="applyLevel" name="applyLevel" value="${nLevel }">
						<div class="row">
							<div class="col-xs-12 col-sm-6">
								<span class="col-xs-4 input-tips">合同总商品数：</span><span class="col-xs-4 input-tips">${count }个</span>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12 col-sm-6">
								<span class="col-xs-4 input-tips">在${nLevelDesc }等级中存在数：</span><span class="col-xs-4 input-tips">${setCount }个</span>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12 col-sm-6">
								<span class="col-xs-4 input-tips">未设置：</span><span class="col-xs-4 input-tips">${noSetCount }个</span>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-12 col-sm-6">
								<span class="col-xs-4 input-tips">普通会员：</span><span class="col-xs-4 input-tips disRate"><input type="text" name="disRate" value="${disRate }">%</span>
							</div>	
						</div>
						<div class="row">
							<div class="col-xs-12 col-sm-6">
								<span class="col-xs-4 input-tips">范围：</span>
								<div class="col-xs-7 dropdown-wrap" id="divLeve">
									<a id="scope-btn" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> 
										<span id="scopeSpan" >选择设置范围</span>
										<input type="hidden" id="scope" name="scope" value="">
									<span class="dr"><img src="${resourceHost}/images/arrow-black.png"></span>
									</a>
									<ul id="scope-menu" class="dropdown-menu" aria-labelledby="scope-btn">
										<li><a id="0" name="all">全部</a></li>
										<li><a id="1" name="not">未设置</a></li>
										<li><a id="2" name="yes">已设置</a></li>
									</ul>
								</div>
							</div>
						</div>
						<p class="row">
							<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7"><label
								class="col-xs-7 col-sm-9"> <input id="applyForm"
									class="border-radius border col-xs-6 col-sm-3 col-md-3"
									type="button" value="应用" />
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