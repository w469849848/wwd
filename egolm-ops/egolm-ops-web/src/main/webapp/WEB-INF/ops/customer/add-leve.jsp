<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>

<e:resource title="会员等级" currentTopMenu="会员管理" currentSubMenu="会员等级" css=""
	js="js/common.js" localCss="cust/add-leve.css"
	localJs="jquery.form.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp"
	currentPath="/WEB-INF/ops/customer/add-leve.jsp">

	<div class="main-content">

		<div class="page-content">

			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置： <a href="/${serverName}">首页</a> &gt; <a href="#">会员管理</a>&gt; <a
						class="active" href="leveList">会员等级</a> &gt; <c:if test="${empty leveInfo.SLeveNO }"> <a class="active"
						href="toAddGrade">新增等级</a></c:if><c:if test="${not empty leveInfo.SLeveNO }"> <a class="active"
						href="toEditLeve?sLeveNO=${leveInfo.SLeveNO }">修改等级信息</a></c:if>
				</p>
			</div>

			<div class="add-leve">
				<div class="form">
					<form id="gradeForm" name="gradeForm" action="addOrUpdateLeve"
						method="post" enctype="multipart/form-data">
						<input type="hidden" value="${leveInfo.SLeveNO }" name="sLeveNO" id="sLeveNO" />
						<p class="row">
							<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6"> <span
								class="col-xs-4 col-sm-2">等级名称：</span> <label
								class="col-xs-7 col-sm-9 dropdown-wrap"> <input
									class="border border-radius bg-color"
									value="${leveInfo.SLeveType }" id="sLeveType" name="sLeveType"
									type="text" />
							</label>
							</small>
						</p>
						<p class="row">
							<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6"> <span
								class="col-xs-4 col-sm-2">所须积分：</span> <label
								class="col-xs-7 col-sm-9 dropdown-wrap"> <input
									class="border border-radius bg-color"
									value="${leveInfo.NRequiredIntegral }" id="nRequiredIntegral"
									name="nRequiredIntegral" type="text" />
							</label>
							</small>
						</p>

						<div class="row">
							<div class="pic-wrap col-xs-10 col-sm-10 col-md-7 col-lg-6">
								<span class="tips-txt col-xs-4 col-sm-2">等级图标：</span> <label
									class="pic-box bg-color border border-radius"> <c:if
										test="${leveInfo.SLeveIcon==null }">
										<img src="${resourceHost}/images/upload-add.png" width="44px"
											height="44px" id="pic-src-id">
									</c:if> <c:if test="${leveInfo.SLeveIcon!=null }">
										<img src="${leveInfo.SLeveIcon}" width="168px" height="168px"
											id="pic-src-id">
									</c:if> <input type="file" name="sLeveIcon" id="sLeveIcon"
									onchange="preview(this)">
								</label>
							</div>
						</div>

						<p class="row">
							<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7"> <span
								class="col-xs-4 col-sm-2"></span> <label
								class="col-xs-7 col-sm-9"> <input id="submitForm"
									class="border-radius border col-xs-6 col-sm-3 col-md-3"
									type="button" value="保存" onclick="commitForm()" /> <input
									class="cancel border-radius border col-xs-6 col-sm-3 col-md-3"
									type="button" value="返回" onclick="location.href='leveList'" />
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

<script type="text/javascript">
	jQuery(function($) {
		//表单异步提交
		$('#gradeForm').ajaxForm(function(data) {
			var res = JSON.parse(data);
			if (res.IsValid == true) {
				$.jalert({
					title : "提示",
					message : res.ReturnValue,
					confirmButton : "关闭",
					confirm : function() {
						window.location.href = "leveList";
					}
				});
			} else {
				$.jalert({
					title : "提示",
					message : res.ReturnValue,
					confirmButton : "关闭",
					confirm : function() {
					}
				});
			}
		});
	});

	//处理表单
	function commitForm() {
		if (validatorForm()) {
			$("#gradeForm").submit();
		}
	}

	//表单验证
	function validatorForm() {
		if ($("#sLeveType").val() == "") {
			alert("等级名称不能为空。");
			return false;
		}
		if ($("#nRequiredIntegral").val() == "") {
			alert("所须积分不能为空。");
			return false;
		}
		if(!/^[0-9]*$/.test($("#nRequiredIntegral").val())){  
	        alert("所须积分请输入数字!");  
	        return false;
	    } 
		return true;
	}
	
	//设置图片
	function preview(file){ 
		if(file.files && file.files[0]){ 
			var reader = new FileReader(); 
			if(typeof FileReader==='undefined'){ 
				console.log("浏览器不支持FileReader");
			}else{
				console.log("浏览器支持FileReader");
			} 
			reader.readAsDataURL(file.files[0]);  
			 
			reader.onload = function(evt){   
				console.log("读 取完成"); 
				$("#pic-src-id").attr("src",evt.target.result); 
			},
			reader.onerror = function(evt){   
				console.log("读 取出错"); 
			},
			reader.onabort = function(evt){   
				console.log("读 取中断"); 
			},
			reader.onloadstart = function(evt){   
				console.log("读 取开始"); 
			}
		}else{ 
		} 
	}
</script>
