<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>

<e:resource title="店铺管理" currentTopMenu="会员管理" currentSubMenu="修改店铺信息" css=""
	js="js/common.js" localCss="cust/shop-info.css"
	localJs="jquery.form.js,cust/cust-base.js,cust/shop-info.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp"
	currentPath="/WEB-INF/ops/customer/shop-info.jsp">

	<div class="main-content">

		<div class="page-content">

			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}">首页</a> &gt; <a href="#">会员管理</a> &gt; <a
						href="shopList">店铺管理</a> &gt;
					<c:if test="${empty shopInfo.NShopID }">
						<a class="active" href="toAddShop">新增店铺</a>
					</c:if>
					<c:if test="${not empty shopInfo.NShopID }">
						<a class="active"
							href="toAddOrEditShop?nShopID=${shopInfo.NShopID }">修改店铺信息</a>
					</c:if>
				</p>
			</div>




			<div class="add-box">

				<form action="saveFormShopInfo" method="post" id="shopForm" name="shopForm" enctype="multipart/form-data" >
					<input type="hidden" id="nShopID" name="nShopID"
						value="${shopInfo.NShopID}" /> 
					<input type="hidden" id="sShopNO"
						name="sShopNO" value="${shopInfo.SShopNO}" />
					<input type="hidden" id="ntag"
						name="ntag" value="${shopInfo.NTag}" />

					<div class="shop-info">
						<h1>店铺信息</h1>
						<p class="line"></p>
						<div class="info-box">
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12 col-sm-6 mr">
										<span class="col-xs-4 input-tips">店铺名称：</span> <label
											class="col-xs-7"> <input
											class="border border-radius bg-color"
											value="${shopInfo.SShopName }" id="sShopName"
											name="sShopName" type="text" />
										</label>
									</div>
									<div class="col-xs-12 col-sm-6">
										<span class="col-xs-4 input-tips">所属会员：</span> <label
											class="col-xs-4"> <input value="${shopInfo.SCustNO }"
											id="sCustNO" name="sCustNO" type="hidden" />
											<input value="${custInfo.SCustName }" disabled="disabled"
											id="sCustName" name="sCustName"
											class="border border-radius bg-color" type="text" /></label><label
											class="col-xs-2 col-sm-2 dropdown-wrap"> &nbsp;<input
											class="border" type="button" name="seletSCustNO" style="padding: 0 0 0 0;"
											id="seletSCustNO" value="选择" />
										</label>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12 col-sm-6 mr">
										<span class="col-xs-4 input-tips">店铺类型：</span>
										<div class="col-xs-7 dropdown-wrap">
											<a id="shoptype"
												class="dropdown-btn border border-radius bg-color dropdown-toggle"
												href="#" data-toggle="dropdown" role="button"
												aria-haspopup="true" aria-expanded="true"> <span
												id="shoptypeSpan">请选择</span> <span class="dr"><img
													src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png" /></span>
											</a> <input type="hidden" id="sShopType" name="sShopType" value="${shopInfo.SShopType }"/> <input
												type="hidden" id="sShopTypeID" name="sShopTypeID" value="${shopInfo.SShopTypeID }"/>
											<ul id="shoptype-menu" class="dropdown-menu"
												aria-labelledby="shoptype">
											</ul>
										</div>
									</div>
									<div class="col-xs-12 col-sm-6">
										<span class="col-xs-4 input-tips">经营类型：</span>
										<div class="col-xs-7 dropdown-wrap">
											<a id="scopetype"
												class="dropdown-btn border border-radius bg-color dropdown-toggle"
												href="#" data-toggle="dropdown" role="button"
												aria-haspopup="true" aria-expanded="true"> <span
												id="scopetypeSpan">请选择</span> <span class="dr"><img
													src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png" /></span>
											</a> <input type="hidden" id="sScopeType" name="sScopeType" value="${shopInfo.SScopeType }"/> <input
												type="hidden" id="sScopeTypeID" name="sScopeTypeID" value="${shopInfo.SScopeTypeID }" />
											<ul id="scopetype-menu" class="dropdown-menu"
												aria-labelledby="scopetype">
											</ul>
										</div>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12 col-sm-6 mr">
										<span class="col-xs-4 input-tips">手机号码：</span> <label
											class="col-xs-7"> <input value="${shopInfo.STel }"
											id="sTel" name="sTel"
											class="border border-radius bg-color" type="text" />
										</label>
									</div>
									<div class="col-xs-12 col-sm-6">
										<span class="col-xs-4 input-tips">联系人：</span> <label
											class="col-xs-7"> <input value="${shopInfo.SContacts }"
											id="sContacts" name="sContacts"
											class="border border-radius bg-color" type="text" />
										</label>
									</div>
								</div>
							</div>

							

							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12 col-sm-6 mr">
										<span class="col-xs-4 input-tips">邮箱：</span> <label
											class="col-xs-7"> <input value="${shopInfo.SEmail }"
											id="sEmail" name="sEmail"
											class="border border-radius bg-color" type="text" />
										</label>
									</div>
									<div class="col-xs-12 col-sm-6">
										<span class="col-xs-4 input-tips">开店日期：</span> <label
											class="col-xs-7 dropdown-wrap"> <input
											id="dFirstSaleDate" class="border border-radius bg-color"
											type="text" name="dFirstSaleDate"
											value='<fmt:formatDate value="${shopInfo.DFirstSaleDate }" pattern="yyyy-MM-dd"/>' /> <span class="dr"><img
												src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png"></span>
										</label>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12 col-sm-6 mr">
										<span class="col-xs-4 input-tips">经度：</span> <label
											class="col-xs-7"> <input
											value="${shopInfo.SLongitude }" id="sLongitude"
											name="sLongitude" class="border border-radius bg-color"
											type="text" />
										</label>
									</div>
									<div class="col-xs-12 col-sm-6">
										<span class="col-xs-4 input-tips">纬度：</span> <label
											class="col-xs-7"> <input
											value="${shopInfo.SLatitude }" id="sLatitude"
											name="sLatitude" class="border border-radius bg-color"
											type="text" />
										</label>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12 col-sm-6 mr">
										<span class="col-xs-4 input-tips">邮编：</span> <label
											class="col-xs-7"> <input
											value="${shopInfo.SPostalcode }" id="sPostalcode"
											name="sPostalcode" class="border border-radius bg-color"
											type="text" />
										</label>
									</div>
									<div class="col-xs-12 col-sm-6">
										<span class="col-xs-4 input-tips">营业面积：</span> <label
											class="col-xs-7"> <input
											value="${shopInfo.NStoreArea }" id="nStoreArea"
											name="nStoreArea" class="border border-radius bg-color"
											type="text" />
										</label>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12 col-sm-6 mr">
										<span class="col-xs-4 input-tips">省：</span>
										<div class="col-xs-7 dropdown-wrap">
											<a id="province"
												class="dropdown-btn border border-radius bg-color dropdown-toggle"
												href="#" data-toggle="dropdown" role="button"
												aria-haspopup="true" aria-expanded="true"> <span
												id="provinceSpan">请选择</span> <span class="dr"><img
													src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png" /></span>
											</a> <input type="hidden" id="sProvince" name="sProvince" value="${shopInfo.SProvince }"
												value="" /> <input type="hidden" id="sProvinceID"
												name="sProvinceID" value="${shopInfo.SProvinceID }" />
											<ul id="province-menu" class="dropdown-menu"
												aria-labelledby="province">
												<c:if test="${not empty DataList}">
													<c:forEach items="${DataList}" var="province">
														<li value="${province.sRegionNO}">${province.sRegionDesc}</li>
													</c:forEach>
												</c:if>
											</ul>
										</div>
									</div>

									<div class="col-xs-12 col-sm-6">
										<span class="col-xs-4 input-tips">市：</span>
										<div class="col-xs-7 dropdown-wrap">
											<a id="city"
												class="dropdown-btn border border-radius bg-color dropdown-toggle"
												href="#" data-toggle="dropdown" role="button"
												aria-haspopup="true" aria-expanded="true"> <span
												id="citySpan">请选择</span> <span class="dr"><img
													src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png" /></span>
											</a> <input type='hidden' id="sCity" name="sCity" value="${shopInfo.SCity }" /> <input
												type='hidden' id="sCityID" name="sCityID" value="${shopInfo.SCityID }"/>
											<ul id="city-menu" class="dropdown-menu"
												aria-labelledby="city">
											</ul>
										</div>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12 col-sm-6 mr">
										<span class="col-xs-4 input-tips">行政区：</span>
										<div class="col-xs-7 dropdown-wrap">
											<a id="district"
												class="dropdown-btn border border-radius bg-color dropdown-toggle"
												href="#" data-toggle="dropdown" role="button"
												aria-haspopup="true" aria-expanded="true"> <span
												id="districtSpan">请选择</span> <span class="dr"><img
													src="${pageContext.request.contextPath}/resources/egolm/assets/images/arrow-black.png" /></span>
											</a> <input type='hidden' id="sDistrict" name="sDistrict" value="${shopInfo.SDistrict }"/> <input
												type='hidden' id="sDistrictID" name="sDistrictID" value="${shopInfo.SDistrictID }"/>
											<ul id="district-menu" class="dropdown-menu"
												aria-labelledby="district">
											</ul>
										</div>
									</div>

									<div class="col-xs-12 col-sm-6">
										<span class="col-xs-4 input-tips">地址：</span> <label
											class="col-xs-7"> <textarea
												rows="3" class="border border-radius bg-color" id="sAddress"
												name="sAddress">${shopInfo.SAddress }</textarea>
										</label>
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12 col-sm-6 mr">
										<span class="col-xs-4 input-tips">组织机构代码：</span> <label
											class="col-xs-7"> <input value="${shopInfo.SOrgNO }"
											id="sOrgNO" name="sOrgNO"
											class="border border-radius bg-color" type="text" />
										</label>
									</div>
									<div class="col-xs-12 col-sm-6">
										<span class="col-xs-4 input-tips">传真：</span> <label
											class="col-xs-7"> <input value="${shopInfo.SFax }"
											id="sFax" name="sFax" class="border border-radius bg-color"
											type="text" />
										</label>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<c:if test="${empty shopInfo.NShopID }">
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">维护业务员：</span> <label
												class="col-xs-4"><input value="${custInfo.SSalesmanNO1 }" id="sSalesmanNO1" name="sSalesmanNO1"
											type="hidden" /> <input value="${sSalesNO1.SSalChineseName }"
											disabled="disabled" id="sSalesmanNO1Name" name="sSalesmanNO1Name"
											class="border border-radius bg-color" type="text" /></label><label class="col-xs-2 col-sm-2 dropdown-wrap"> &nbsp;<input
											class="border" type="button" name="seletSalesmanNO1"
											style="padding: 0 0 0 0;" id="seletSalesmanNO1" value="选择" />
											</label>
										</div>
									</c:if>
									<c:if test="${not empty shopInfo.NShopID }">
										<div class="col-xs-12 col-sm-6 mr">
											<span class="col-xs-4 input-tips">开店业务员：</span> <label
												class="col-xs-4"> <input
												class="border border-radius bg-color"
												value="${sSalesNO1.SSalChineseName }" 
												name="sShopName" type="text" readonly="readonly"/>
												<input type="hidden" id="sSalesmanNO1" name="sSalesmanNO1" value="${shopInfo.SSalesmanNO1 }"/>
												</label>
										</div>
									</c:if>
									<div class="col-xs-12 col-sm-6">
										<span class="col-xs-4 input-tips">维护业务员：</span> <label
											class="col-xs-4"><input value="${custInfo.SSalesmanNO2 }" id="sSalesmanNO2" name="sSalesmanNO2"
										type="hidden" /> <input value="${sSalesNO2.SSalChineseName }"
										disabled="disabled" id="sSalesmanNO2Name" name="sSalesmanNO2Name"
										class="border border-radius bg-color" type="text" /></label><label class="col-xs-2 col-sm-2 dropdown-wrap"> &nbsp;<input
										class="border" type="button" name="seletSalesmanNO2"
										style="padding: 0 0 0 0;" id="seletSalesmanNO2" value="选择" />
										</label>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12">
										<span class="col-xs-4 input-tips">描述：</span> <label
											class="col-xs-7 col-sm-7 dropdown-wrap"> <textarea
												rows="3" class="border border-radius bg-color" id="sMemo"
												name="sMemo">${shopInfo.SMemo }</textarea>
										</label>
									</div>
								</div>
							</div>

						</div>
					</div>

					<div class="shop-pic">
						<h1>店铺图片信息</h1>
						<p class="line"></p>
						<div class="info-box">
							<div class="row">
								<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<div class="col-xs-12">
										<span class="col-xs-3 input-tips" style="padding: 0px 38px;">图片描述：</span> <label
											class="col-xs-7 col-sm-7 dropdown-wrap"> <textarea
												rows="3" class="border border-radius bg-color" id="sPicDesc"
												name="sPicDesc">${shopPic.SPicDesc }</textarea>
										</label>
									</div>
								</div>
							</div>
							
							<div class="row">
								<div class="pic-wrap col-xs-12 col-sm-12 col-md-9 col-lg-7">
									<span class="col-xs-3 input-tips" style="padding: 0px 38px;">店铺图片：</span> <label
										class="col-xs-7 col-sm-7 dropdown-wrap pic-box bg-color border border-radius"> <c:if
											test="${shopPic.SURL==null }">
											<img src="${resourceHost}/images/upload-add.png" width="64px"
												height="64px" id="pic-src-id">
										</c:if> <c:if test="${shopPic.SURL!=null }">
											<img src="${shopPic.SURL}" width="189px" height="189px"
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
							type="button" value="返回" onclick="location.href='shopList'" />
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
							<p class="text" id="msg_p">保存店铺信息成功</p>
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
	/* 选择客户窗口 */
	function seletSCustNO(content_url) {
		layer.open({
			type : 2,
			title : '选择会员',
			shadeClose : true,
			shade : 0.6,
			area : [ '70%', '90%' ],
			content : content_url
		});
	}
	
	/* 选择业务员窗口 */
	function seletSalesmanNO(content_url) {
		layer.open({
			type : 2,
			title : '选择业务员',
			shadeClose : true,
			shade : 0.6,
			area : [ '70%', '90%' ],
			content : content_url
		});
	}
	
	function getSaleId(saleId,salChinName,saleNO){
		if(saleNO==1){
			$("#sSalesmanNO1").val(saleId);
			$("#sSalesmanNO1Name").val(salChinName);
		}else{
			$("#sSalesmanNO2").val(saleId);
			$("#sSalesmanNO2Name").val(salChinName);
		}
	}
	
	function getCustNO(custNO,custName){
		$("#sCustNO").val(custNO);
		$("#sCustName").val(custName);
	}
</script>