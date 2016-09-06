<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%> 
<e:resource title="经销商合同管理"  currentTopMenu="经销商管理" currentSubMenu="合同详情" css="css/add-dealer.css" js="" localCss="dealer/dealer.css" localJs="dealer/dealer-warehouse-support.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/dealer/dealer_contract_detail.jsp">

			<div class="main-content">

				<div class="page-content">

					<div class="wh_titer">
						<p class="wh_titer_f">
							您的位置：
							<a href="${webHost}/index">首页</a> &gt;
							<a href="agentList">经销商管理</a> &gt;
							<a href="agentContractList">合同管理</a>&gt; 
							<a class="active" href="agentContractEdit">经销商合同详情</a>
						</p>
					</div>

				<div class="add-box">
							
							<form>
								
								<div class="dealer-info">
									<h1 class="content-toggle">合同信息</h1>
									<p class="line"></p>
									<div class="info-box content-box">
										<div class="row">
											  <div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												 <div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">经销商：</span>
													<label class="col-xs-7">
														<input type="hidden" id="sAgentContractNO" value="${tAgentContract.SAgentContractNO}">
														<input class="border border-radius bg-color" type="text" id="sAgentName" name="sAgentName"  value="${tAgent.SAgentName}" />
													</label>
												</div> 
												
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">合同类型：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sAgentContractType" name="sAgentContractType"  value="${tAgentContract.SAgentContractType}" />
													</label>
												</div>
											</div>  
										</div>
										
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">生效日期：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color"  value="<fmt:formatDate value='${tAgentContract.DActiveDate}' type='date' pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" id="dActiveDate" name="dActiveDate"   />
														<%-- <fmt:formatDate  value="${tAgentContract.DActiveDate}"  pattern=""yyyy-MM-dd HH:mm:ss" /> --%>
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">失效日期：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" value="<fmt:formatDate value='${tAgentContract.DExpireDate}' type='date' pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" id="dExpireDate" name="dExpireDate"    />
													</label>
												</div>
											</div>
										</div>
										 <div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 ">
													<span class="col-xs-4 input-tips">合同时间：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" value="<fmt:formatDate value='${tAgentContract.DContractDate}' type='date' pattern="yyyy-MM-dd HH:mm:ss"/>" type="text"  id="dContractDate" name="dContractDate"  />
													</label>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="dealer-addr margin-bottom">
									<h1 class="account-toggle">账户资料</h1>
									<p class="line"></p>
									<div class="addr-box account-box">
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">税别：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sTaxType" name="sTaxType"  value="${tAgentContract.STaxType}" />
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">税率：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="nTaxRate" name="nTaxRate"  value="${tAgentContract.NTaxRate}"  />
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">税比：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="nTaxPct" name="nTaxPct"  value="${tAgentContract.NTaxPct}"  />
													</label>
													
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">付款方式：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sPaytMode" name="sPaytMode"  value="${tAgentContract.SPaytMode}"  />
													</label>
												</div>
											</div>
										</div>
									 	<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">付款账期：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sPaytTerm" name="sPaytTerm"  value="${tAgentContract.SPaytTerm}"  />
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">付款天数：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text"  id="nPaytDay" name="nPaytDay"  value="${tAgentContract.NPaytDay}"  />
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">付款联系人：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sPaytContact" name="sPaytContact"  value="${tAgentContract.SPaytContact}"  />
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">联系人电话：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sPaytContactTel" name="sPaytContactTel"  value="${tAgentContract.SPaytContactTel}" />
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">银行账号：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sBankAccountNO" name="sBankAccountNO"  value="${tAgentContract.SBankAccountNO}"  />
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">银行账户：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sBankAccount" name="sBankAccount"  value="${tAgentContract.SBankAccount}"  />
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">开户银行：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sBank" name="sBank"  value="${tAgentContract.SBank}"  />
													</label>
												</div>
												<div class="col-xs-12 col-sm-6">
													<span class="col-xs-4 input-tips">税号：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text"  id="sTaxCode" name="sTaxCode"  value="${tAgentContract.STaxCode}" />
													</label>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
												<div class="col-xs-12 col-sm-6 mr">
													<span class="col-xs-4 input-tips">付款中心：</span>
													<label class="col-xs-7">
														<input class="border border-radius bg-color" type="text" id="sPaytCenterNO" name="sPaytCenterNO"  value="${tAgentContract.SPaytCenterNO}"  />
													</label>
												</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="dealer-info">
									<h1 class="warehouse-toggle">仓库信息</h1>
									<p class="line"></p>
									<div class="info-box warehouse-box">
										<c:forEach var="warehouse" items="${warehouses}" >
											<div class="row">
											<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
												 <div class="col-xs-12 col-sm-3 mr">
													<span class="col-xs-6 input-tips warehouse-title">仓库：</span>
													<label class="col-xs-6">
														<input class="border border-radius bg-color" type="text" readonly="readonly" value="${warehouse.sWarehouseName}"  />
													</label>
												</div>
												<div class="col-xs-12 col-sm-3 mr">
													<span class="col-xs-6 input-tips warehouse-title">计费类型：</span>
													<label class="col-xs-6">
														<input class="border border-radius bg-color" type="text" readonly="readonly" value="${warehouse.sFeeCalcType}"  />
													</label>
												</div>
												<div class="col-xs-12 col-sm-3 mr calculate-div">
													<span class="col-xs-6 input-tips warehouse-title">计费方式：</span>
													<label class="col-xs-6">
														<input class="border border-radius bg-color" type="text" readonly="readonly" value="${warehouse.sFeeCalcValue}"  /><span>${warehouse.sFeeCalcTypeID==5?'¥':'%'}</span>
													</label>
												</div>
											</div>  
											</div>
										</c:forEach>
									</div>
								</div>
								
								<div class="dealer-addr margin-bottom">
									<h1 class="goods-toggle">商品信息</h1>
									<p class="line"></p>
									<div class="addr-box goods-box">
										<table class="footable table" data-page-size="10">
									<thead class="bg-color">
										<tr>
											<th data-toggle="true">条形码</th>
											<th data-hide="phone">商品名称</th>
											<th data-hide="phone">保质期</th>
											<th data-hide="phone,tablet">规格</th>
											<th data-hide="phone">商品价格</th>
											<th data-hide="phone,tablet">包装数量</th>
											<th data-hide="phone">库存数量</th>
											<th data-hide="phone,tablet">供应商</th>
											<th data-hide="phone,tablet">配送方式</th>
										</tr>
									</thead>
									<tbody class="contract-goods">
									<c:forEach items="${tAgentContractGoods}" var="d">
										<tr>
											<td>${d.SMainBarcode}</td>
											<td>${d.SGoodsDesc}</td>
											<td>${d.NLifeCycle}</td>
											<td>${d.SSpec}</td>
											<td>${d.NSalePrice}</td>
											<td>${d.SUnit}</td>
											<td>${d.NTag}</td>
											<td>${d.NAgentName}</td>
											<td>${d.SUnit}</td>
											
										</tr>
									</c:forEach>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="10" class="clearfix goods-pager">
											
											</td>
										</tr>
									</tfoot>
								</table>
								</div>	
								</div>
								
							</form>
						
						</div>

				</div>
				<!-- /.page-content -->
			</div>
			 

	<script type="text/javascript">
		$(document).ready(
			function() {
				$("#sNationID").change(function() {
						var sNationChange = $("#sNationID").find("option:selected").text();
						$("#sNation").val(sNationChange);
				});
				$("#sProvinceID").change(function() {
					$.get("getCityByProvinceId?sProvinceID="+ $("#sProvinceID").val(),
						function(data) {
							if (data.IsValid) {
							var result = "<option>选择城市</option>";
							$.each(data.DataList,function(n,value) {
								result += "<option value='"+value.sCode+"'>"+ value.sCodeDesc+ "</option>";
							});
							$("#sCityID").html('');
							$("#sCityID").append(result);
							$("#sDistrictID").html('');
						}
					}, "json");
					var sProvince = $("#sProvinceID").find("option:selected").text();
					$("#sProvince").val(sProvince);
				});
				$("#sCityID").change(function() {
					$.get("getAreaByCityId?sCityID="+ $("#sCityID").val(),
					function(data) {
						if (data.IsValid) {
							var result = "<option>选择区域</option>";
							$.each(data.DataList,function(n,value) {
									result += "<option value='"+value.sCode+"'>"+ value.sCodeDesc+ "</option>";
							});
							$("#sDistrictID").html('');
							$("#sDistrictID").append(result);
						}
					}, "json");
					var sCity = $("#sCityID").find("option:selected").text();
					$("#sCity").val(sCity);
				});
				$("#sDistrictID").change(function() {
						var sDistrict = $("#sDistrictID").find("option:selected").text();
						$("#sDistrict").val(sDistrict);
				});
			});
		//表单检验
		function check() {
			if ($("#sAgentName").val() == "") {
				$("#sAgentName").tips({
					side : 3,
					msg : '请填写经销商名称',
					bg : '#AE81FF',
					time : 2
				});
				$("#sAgentName").focus();
				return false;
			}
			var myreg = /^(((13[0-9]{1})|159)+\d{8})$/;
			if ($("#sMobile").val().length > 0) {
				if ($("#sMobile").val().length != 11
						&& !myreg.test($("#sMobile").val())) {
					$("#sMobile").tips({
						side : 3,
						msg : '手机格式不正确',
						bg : '#AE81FF',
						time : 3
					});
					$("#sMobile").focus();
					return false;
				}
			}
			if($("#sNation").val()==""){
				$("#sNationID").tips({
					side:3,
		            msg:'请选择国家',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#sNationID").focus();
				return false;
			}
			if($("#sProvince").val()==""){
				$("#sProvinceID").tips({
					side:3,
		            msg:'请选择省份',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#sProvinceID").focus();
				
				return false;
			}
			if($("#sCity").val()==""){
				$("#sCityID").tips({
					side:3,
		            msg:'请选择市',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#sCityID").focus();
				return false;
			}
			if($("#sDistrict").val()==""){
				$("#sDistrictID").tips({
					side:3,
		            msg:'请选择地区',
		            bg:'#AE81FF',
		            time:2
		        });
				$("#sDistrictID").focus();
				return false;
			}
			if ($("#sEmail").val().length > 0) {
				if (!ismail($("#sEmail").val())) {
					$("#sEmail").tips({
						side : 3,
						msg : '邮箱格式不正确',
						bg : '#AE81FF',
						time : 3
					});
					$("#sEmail").focus();
					return false;
				}
			}
			return true;
		}
		//处理表单
		function dealForm() {
			if (check()) {
				$.ajax({
					cache : false,
					type : "POST",
					url : 'agentUpdate',
					data : $('#agentFrom').serialize(),
					async : false,
					error : function(request) {
						alert("Connection error");
					},
					success : function(data) {
						$.jalert({
							title : "提示",
							message : "更新成功"
						});
						window.location.href = "agentList";
					}
				});
			}
		}

		jQuery(function($) {
			var footable = null, $row = null, isAll = false, deleteType = true;

			$('.supplier table').footable({ //响应式表格初始化
				breakpoints : {
					phone : 480,
					tablet : 1200
				}
			});

			$('.chk').on('click', function() { //选中/取消选中
				Checked.checked(this);
			});

			$('.batch .chk').on('click', function() { //全选/取消全选
				$('.checked-wrap input').each(function(index) {
					Checked.selectAll(this, isAll);
				});
				isAll = !isAll;
			});
		});
	</script>
</e:point>