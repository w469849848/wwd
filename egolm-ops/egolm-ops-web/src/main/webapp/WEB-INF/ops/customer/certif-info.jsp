<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>

<e:resource title="店铺证照编辑" currentTopMenu="店铺证照编辑" currentSubMenu="" css=""
	js="js/common.js" localCss="cust/certif-info.css"
	localJs="jquery.form.js,cust/cust-base.js,cust/certif-info.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp"
	currentPath="/WEB-INF/ops/customer/certif-info.jsp">

	<div class="main-content">

		<div class="page-content">

			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}">首页</a> &gt; <a href="#">会员管理</a> &gt; <a
						href="certifList">店铺证照</a> &gt;
					<c:if test="${empty shopCertif.SShopNO }">
						<a class="active" href="toAddCertif">新增店铺证照</a>
					</c:if>
					<c:if test="${not empty shopCertif.SShopNO }">
						<a class="active"
							href="toAddOrEditShopCertif?sShopNO=${shopCertif.SShopNO }">修改店铺证照信息</a>
					</c:if>
				</p>
			</div>




			<div class="add-box">

				<form action="saveFormShopInfo" method="post" id="certifForm" name="certifForm" enctype="multipart/form-data" >
					
					<input type="hidden" id="nTag"
						name="nTag" value="${shopCertif.NTag}" />

					<div class="certif-info">
						<h1>店铺证照信息</h1>
						<p class="line"></p>
						<div class="info-box">
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12 col-sm-6 mr">
										<span class="col-xs-4 input-tips">所属店铺：</span> <label
											class="col-xs-4"> <input value="${shopInfo.SShopNO }"
											id="sShopNO" name="sShopNO" type="hidden" />
											<input value="${shopInfo.SShopName }" disabled="disabled"
											id="sShopName" name="sShopName"
											class="border border-radius bg-color" type="text" /></label><label
											class="col-xs-2 col-sm-2 dropdown-wrap"> &nbsp;<input
											class="border" type="button" name="seletSShopNO" style="padding: 0 0 0 0;"
											id="seletSShopNO" value="选择" />
										</label>
									</div>
									<div class="col-xs-12 col-sm-6">
										<span class="col-xs-4 input-tips">证照类型：</span>
										<div class="col-xs-7 dropdown-wrap">
											<a id="certiftype"
												class="dropdown-btn border border-radius bg-color dropdown-toggle"
												href="#" data-toggle="dropdown" role="button"
												aria-haspopup="true" aria-expanded="true"> <span
												id="certiftypeSpan">请选择</span> <span class="dr"><img
													src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png" /></span>
											</a> <input type="hidden" id="sCertifType" name="sCertifType" value="${shopCertif.SCertifType }"/> <input
												type="hidden" id="sCertifTypeID" name="sCertifTypeID" value="${shopCertif.SCertifTypeID }"/>
											<ul id="certiftype-menu" class="dropdown-menu"
												aria-labelledby="certiftype">
											</ul>
										</div>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12 col-sm-6 mr">
										<span class="col-xs-4 input-tips">生效日期：</span> <label
											class="col-xs-7 dropdown-wrap"> <input
											id="dValidDate" class="border border-radius bg-color"
											type="text" name="dValidDate"
											value='<fmt:formatDate value="${shopCertif.DValidDate }" pattern="yyyy-MM-dd"/>' /> <span class="dr"><img
												src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
										</label>
									</div>
									<div class="col-xs-12 col-sm-6">
										<span class="col-xs-4 input-tips">到期日期：</span> <label
											class="col-xs-7 dropdown-wrap"> <input
											id="dExpiryDate" class="border border-radius bg-color"
											type="text" name="dExpiryDate"
											value='<fmt:formatDate value="${shopCertif.DExpiryDate }" pattern="yyyy-MM-dd"/>' /> <span class="dr"><img
												src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
										</label>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12 col-sm-6 mr">
										<span class="col-xs-4 input-tips">证照号码：</span> <label
											class="col-xs-7"> <input
											value="${shopCertif.SCertifNO }" id="sCertifNO"
											name="sCertifNO" class="border border-radius bg-color"
											type="text" />
										</label>
									</div>
									<div class="col-xs-12 col-sm-6">
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12">
										<span class="col-xs-4 input-tips">描述：</span> <label
											class="col-xs-7 col-sm-7 dropdown-wrap"> <textarea
												rows="3" class="border border-radius bg-color" id="sMemo"
												name="sMemo">${shopCertif.SMemo }</textarea>
										</label>
									</div>
								</div>
							</div>

						</div>
					</div>

					<div class="shop-pic">
						<h1>店铺证照图片</h1>
						<p class="line"></p>
						<div class="info-box">
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12">
										<span class="col-xs-3 input-tips" style="padding: 0px 38px;">图片描述：</span> <label
											class="col-xs-7 col-sm-7 dropdown-wrap"> <textarea
												rows="3" class="border border-radius bg-color" id="sPicDesc"
												name="sPicDesc">${shopCertifPic.SPicDesc }</textarea>
										</label>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="pic-wrap col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<span class="col-xs-3 input-tips" style="padding: 0px 38px;">店铺证照：</span> <label
										class="col-xs-7 col-sm-7 dropdown-wrap pic-box bg-color border border-radius"> <c:if
											test="${shopCertifPic.SURL==null }">
											<img src="${resourceHost}/images/upload-add.png" width="64px"
												height="64px" id="pic-src-id">
										</c:if> <c:if test="${shopCertifPic.SURL!=null }">
											<img src="${shopCertifPic.SURL}" width="189px" height="189px"
												id="pic-src-id">
										</c:if> <input type="file" name="sURL" id="sURL"
										onchange="preview(this)">
									</label>
								</div>
							</div>
						</div>
						
					</div>

					<p class="row">
						<label class="col-xs-12"> <input id="submitForm"
							class="border-radius border col-xs-6 col-sm-3 col-md-3"
							type="button" value="保存" /> <input
							class="cancel border-radius border col-xs-6 col-sm-3 col-md-3"
							type="button" value="返回" onclick="location.href='certifList'" />
						</label>
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
							<p class="text" id="msg_p">保存店铺证照信息成功</p>
							<p class="btn-box clearfix">
								<input class="bg-color border-radius border" type="button"
									data-dismiss="modal" value="确定" id="back_btn" />
							</p>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- /.page-content -->
	</div>
</e:point>
<script>
	/* 选择店铺窗口 */
	function seletSShopNO(content_url) {
		layer.open({
			type : 2,
			title : '选择店铺',
			shadeClose : true,
			shade : 0.6,
			area : [ '70%', '90%' ],
			content : content_url
		});
	}
	
	function getShopNO(sShopNO,sShopName){
		$("#sShopNO").val(sShopNO);
		$("#sShopName").val(sShopName);
	}
</script>