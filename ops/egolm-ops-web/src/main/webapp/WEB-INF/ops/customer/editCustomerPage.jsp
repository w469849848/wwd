<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>

<e:resource title="会员管理" currentTopMenu="会员管理" currentSubMenu="" css=""
	js="js/common.js" localCss="cust/cust-edit.css"
	localJs="jquery.form.js,cust/cust-edit.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp"
	currentPath="/WEB-INF/ops/customer/editCustomerPage.jsp">

	<div class="main-content">

		<div class="page-content">

			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}">首页</a> &gt; <a href="customerList">用户管理</a>
					&gt; <a class="active"
						href="toAddOrEditCust?editCustId=${custInfo.SCustNO }">编辑会员</a>
				</p>
			</div>

			<div class="cust-edit">
				<div class="form">
					<form id="commCustForm" action="" ,method="post">
						<input type="hidden" id="sCustNO" name="sCustNO"
							value="${custInfo.SCustNO }" /> <input
							value="${custInfo.SOpenID }" id="sOpenID" name="sOpenID"
							type="hidden" /><input value="${custInfo.SCustLeveTypeID }"
							id="sCustLeveTypeID" name="sCustLeveTypeID" type="hidden" /> <input
							value="${custInfo.SCustLeveType }" id="sCustLeveType"
							name="sCustLeveType" type="hidden" />
						<p class="row">
							<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6"> <span
								class="col-xs-4 col-sm-2">会员姓名：</span> <label
								class="col-xs-7 col-sm-9 dropdown-wrap"> <input
									class="border border-radius bg-color"
									value="${custInfo.SCustName }" id="sCustName" name="sCustName"
									type="text" />
							</label>
							</small>
						</p>
						<div class="row">
							<div class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
								<div class="col-xs-12 col-sm-6">
									<span class="col-xs-4 input-tips">会员等级：</span>
									<div class="col-xs-7 dropdown-wrap" id="divLeve">
										<a id="area-btn"
											class="dropdown-btn border border-radius bg-color dropdown-toggle"
											href="#" data-toggle="dropdown" role="button"
											aria-haspopup="true" aria-expanded="true"> <span
											id="sCustLeveTypeText">${custInfo.SCustLeveType }</span> <span
											class="dr"><img
												src="${resourceHost}/images/arrow-black.png" /></span>
										</a>
										<ul id="area-menu" class="dropdown-menu"
											aria-labelledby="area-btn">
											<c:forEach items="${gradeList }" var="gradeBean">
												<li class="module-option" value="${gradeBean.sLeveNO }">${gradeBean.sLeveType }</li>
											</c:forEach>
										</ul>
									</div>
								</div>
							</div>
						</div>

						<p class="row">
							<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6"> <span
								class="col-xs-4 col-sm-2">手机号码：</span> <label
								class="col-xs-7 col-sm-9 dropdown-wrap"> <input
									value="${custInfo.SMobile }" id="sMobile" name="sMobile"
									class="border border-radius bg-color" type="text" />
							</label>
							</small>
						</p>

						<p class="row">
							<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6"> <span
								class="col-xs-4 col-sm-2">固话号码：</span> <label
								class="col-xs-7 col-sm-9 dropdown-wrap"> <input
									value="${custInfo.STel }" id="sTel" name="sTel"
									class="border border-radius bg-color" type="text" />
							</label>
							</small>
						</p>

						<p class="row">
							<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6"> <span
								class="col-xs-4 col-sm-2">邮箱：</span> <label
								class="col-xs-7 col-sm-9 dropdown-wrap"> <input
									value="${custInfo.SEmail }" id="sEmail" name="sEmail"
									class="border border-radius bg-color" type="text" />
							</label>
							</small>
						</p>

						<p class="row">
							<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6"> <span
								class="col-xs-4 col-sm-2">传真：</span> <label
								class="col-xs-7 col-sm-9 dropdown-wrap"> <input
									value="${custInfo.SFax }" id="sFax" name="sFax"
									class="border border-radius bg-color" type="text" />
							</label>
							</small>
						</p>

						<p class="row">
							<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6"> <span
								class="col-xs-4 input-tips">开店业务员：</span> <label class="col-xs-4">
									<input value="${custInfo.SSalesmanNO1 }" id="sSalesmanNO1" name="sSalesmanNO1"
									type="hidden" /> <input value="${sSalesNO1.SSalChineseName }"
									disabled="disabled" id="sSalesmanNO1Name" name="sSalesmanNO1Name"
									class="border border-radius bg-color" type="text" />
							</label><label class="col-xs-2 col-sm-2 dropdown-wrap"> &nbsp;<input
									class="border" type="button" name="seletSalesmanNO1"
									style="padding: 0 0 0 0;" id="seletSalesmanNO1" value="选择" />
							</label>
							</small>
						</p>
						
						<p class="row">
							<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6"> <span
								class="col-xs-4 input-tips">维护业务员：</span> <label class="col-xs-4">
									<input value="${custInfo.SSalesmanNO2 }" id="sSalesmanNO2" name="sSalesmanNO2"
									type="hidden" /> <input value="${sSalesNO2.SSalChineseName }"
									disabled="disabled" id="sSalesmanNO2Name" name="sSalesmanNO2Name"
									class="border border-radius bg-color" type="text" />
							</label><label class="col-xs-2 col-sm-2 dropdown-wrap"> &nbsp;<input
									class="border" type="button" name="seletSalesmanNO2"
									style="padding: 0 0 0 0;" id="seletSalesmanNO2" value="选择" />
							</label>
							</small>
						</p>

						<p class="row">
							<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7"> <span
								class="col-xs-4 col-sm-2"></span> <label
								class="col-xs-7 col-sm-9"> <input id="submitForm"
									class="border-radius border col-xs-6 col-sm-3 col-md-3"
									type="button" value="保存" /> <input
									class="cancel border-radius border col-xs-6 col-sm-3 col-md-3"
									type="button" value="返回" onclick="location.href='customerList'" />
							</label>
							</small>
						</p>

					</form>
				</div>
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
							<p class="text" id="msg_p">修改会员基本信息成功</p>
							<p class="btn-box clearfix">
								<input class="bg-color border-radius border" type="button"
									data-dismiss="modal" value="确定" />
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
	function customDropDown(ele) {
		this.dropdown = ele;
		this.options = this.dropdown.find("ul.dropdown-menu > li");
		this.initEvents();
	}

	customDropDown.prototype = {
		initEvents : function() {
			var obj = this;
			// 点击下拉列表的选项
			obj.options.on("click", function() {
				var opt = $(this);
				$("#sCustLeveTypeText").html(opt.html());
				$("#sCustLeveTypeID").val(opt.attr("value"));
				$("#sCustLeveType").val(opt.html());
			});
		},
		getValue : function() {
			return this.value;
		}
	}

	var belong_area = new customDropDown($("#divLeve"));

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
</script>