<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="新增模板" currentTopMenu="模板管理" currentSubMenu="新增模板" css="" js="js/common.js" localCss="tpl/add-tpl.css" localJs="jquery.form.js,tpl/add-tpl.js,tpl/Sortable.min.js,tpl/jquery.tips.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-add.jsp">
	<style type="text/css">
		.module-wrap ul li input{
			cursor : move;
		}
	</style>
	<div class="main-content">
		<div class="page-content">
			<div class="wh_titer">
				<p class="wh_titer_f">
					您的位置：
					<a href="${webHost}/index">首页</a> &gt; 
					<a href="${webHost }/template/list">模板管理</a> &gt;
					<c:if test="${empty tpl.STplNo }">
						<a class="active" href="${webHost }/template/addorupdate">新增模板</a>
					</c:if> 
					<c:if test="${not empty tpl.STplNo }">
						<a class="active" href="${webHost }/template/addorupdate?sTplNo=${tpl.STplNo}">修改模板</a>
					</c:if> 
					
				</p>
			</div>
			
			<div class="add-box"> <!-- 新增模板 -->
				<form id="tplForm" action="${webHost }/template/save" method="post">
					<input type="hidden" id="sTplNo" name="sTplNo" value="${tpl.STplNo }" />
					<input type="hidden" id="nTag" name="nTag" value="${tpl.NTag }" />
					<input type="hidden" id="moduleItems" name="moduleItems" value="" />
					<input type="hidden" id="sBelongArea" name="sBelongArea" value="${tpl.SBelongArea }" />
					<input type="hidden" id="sDisplayArea" name="sDisplayArea" value="${tpl.SDisplayArea }" />
					<input type="hidden" id="sScopeType" name="sScopeType" value="${tpl.SScopeType }" />
					<p class="row" style="margin-bottom:8px">
						<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
							<span class="col-xs-4 col-sm-2">模板名称：</span>
							<label class="col-xs-7 col-sm-9">
								<input class="border border-radius bg-color" type="text" id="sTplName" name="sTplName" value="${tpl.STplName }" maxlength="20"/>
							</label>
							<span style="color:red">&nbsp;*</span>
						</small>
					</p>
					<p class="row" style="margin-bottom:8px">
						<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
							<span class="col-xs-4 col-sm-2">模板描述：</span>
							<label class="col-xs-7 col-sm-9">
								<input class="border border-radius bg-color" type="text" id="sTplDesc" name="sTplDesc" value="${tpl.STplDesc }"  maxlength="50"/>
							</label>
						</small>
					</p>
					<div class="row">
						<div class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
							<div class="col-xs-12 col-sm-6 mr">
								<span class="col-xs-4 input-tips">所属区域：</span>
								<div class="col-xs-7 dropdown-wrap" id="belong_area">
									<a class="dropdown-btn border border-radius bg-color dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
							          	<c:if test="${not empty tpl.SBelongArea }">
								          	<span class="item-name">${tpl.SBelongArea }</span>
							          	</c:if>
							          	<c:if test="${empty tpl.SBelongArea }">
								          	<span class="item-name">请选择</span>
							          	</c:if>
							          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
							          	<input type="hidden" id="sBelongNo" name="sBelongNo" value="${tpl.SBelongNo }"/>
							        </a>
							        <ul class="dropdown-menu" aria-labelledby="salesman-type">
							          	<c:forEach items="${zonelist}" var="zone" varStatus="i">
											<li val="${zone.sBelongNo }">${zone.sBelongArea }</li>
										</c:forEach>
							        </ul>
								</div>
								<span style="color:red">&nbsp;*</span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
							<div class="col-xs-12 col-sm-6 mr">
								<span class="col-xs-4 input-tips">店铺类型：</span>
								<div class="col-xs-7 dropdown-wrap" id="scope_area">
									<a class="dropdown-btn border border-radius bg-color dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
							          	<c:if test="${not empty tpl.SScopeType }">
								          	<span class="item-name">${tpl.SScopeType }</span>
							          	</c:if>
							          	<c:if test="${empty tpl.SScopeType }">
								          	<span class="item-name">请选择</span>
							          	</c:if>
							          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
							          	<input type="hidden" id="sScopeTypeID" name="sScopeTypeID" value="${tpl.SScopeTypeID }"/>
							        </a>
							        <ul class="dropdown-menu" aria-labelledby="salesman-type">
							          	<c:forEach items="${scopedatas.datas}" var="scope" varStatus="i">
											<li val="${scope.sComID }">${scope.sComDesc }</li>
										</c:forEach>
							        </ul>
								</div>
								<span style="color:red">&nbsp;*</span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
							<div class="col-xs-12 col-sm-6 mr">
								<span class="col-xs-4 input-tips">使用范围：</span>
								<div class="col-xs-7 dropdown-wrap" id="display_area">
									<a class="dropdown-btn border border-radius bg-color dropdown-toggle" href="javascript:void(0)" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
							          	<c:if test="${not empty tpl.SDisplayArea }">
								          	<span class="item-name">${tpl.SDisplayArea }</span>
							          	</c:if>
							          	<c:if test="${empty tpl.SDisplayArea }">
								          	<span class="item-name">请选择</span>
							          	</c:if>
							          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
							          	<input type="hidden" id="sDisplayNo" name="sDisplayNo" value="${tpl.SDisplayNo }"/>
							        </a>
							        <ul class="dropdown-menu" aria-labelledby="salesman-type">
							          	<li val="web">PC端</li>
							          	<!-- <li val="wx">微信端</li>
							          	<li val="app">APP端</li> -->
							        </ul>
								</div>
								<span style="color:red">&nbsp;*</span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
							<div class="col-xs-12 col-sm-6">
								<span class="col-xs-4 input-tips">页面类型：</span>
								<div class="col-xs-7 dropdown-wrap" id="is_home">
									<a class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
							          	<c:if test="${not empty tpl.NIsHome }">
								          	<c:if test="${tpl.NIsHome == 1 }">
									          	<span class="item-name">首页</span>
								          	</c:if>
								          	<c:if test="${tpl.NIsHome == 0 }">
									          	<span class="item-name">专区</span>
								          	</c:if>
							          	</c:if>
							          	<c:if test="${empty tpl.NIsHome }">
								          	<span class="item-name">请选择</span>
							          	</c:if>
							          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
							          	<input type="hidden" id="nIsHome" name="nIsHome" value="${tpl.NIsHome}"/>
							        </a>
							        <ul class="dropdown-menu" aria-labelledby="area-btn">
							          	<li val="1">首页</li>
							          	<!-- <li val="0">专区</li> -->
							        </ul>
								</div>
								<span style="color:red">&nbsp;*</span>
							</div>
						</div>
					</div>
					
					<div class="module-wrap">
						
						<div class="row tit">
							<a id="btn-add-tpl" class="detail" href="javascript:void(0)">添加模块</a>
							<span class="orange" id="moduleTips">备注：拖动模块可以调整模块显示顺序</span>
						</div>
						
						<p class="row path">
							<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
								<label class="col-xs-11 col-sm-11 line"></label>
							</small>
						</p>
						
						<div class="row">
							<ul class="sortItems" id="sortItems">
								<c:forEach items="${modulelist}" var="module" varStatus="i">
									<li val="${module.SLinkNo}_${module.SModuleNo}">
										<p class="row module">
											<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
												<label class="col-xs-11 col-sm-11">
													<input class="border border-radius bg-color" value="${module.SModName }_${module.NSequence}" type="text" />
													<a class="btn-delete" href="javascript:void(0)"><img class="delete_img" src="${resourceHost}/images/btn-delete.png"/></a>
												</label>
											</small>
										</p>
									</li>
								</c:forEach>
							</ul>
							
						</div>
						
					</div>
					
					<p class="row">
						<small class="col-xs-10 col-sm-10 col-md-7 col-lg-6">
							<span class="col-xs-4 col-sm-2"></span>
							<label class="col-xs-7 col-sm-9">
								<input id="submit_btn" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="保存" onclick="commitForm()"/>
								<input class="cancel border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="取消" onclick="location.href='${webHost }/template/list'"/>
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
				      		<p class="text">保存成功</p>
				        	<p class="btn-box clearfix">
				        		<input class="bg-color border-radius border" type="button" data-dismiss="modal" value="确定" />
				        	</p>
				      	</div>
			    	</div>
			  	</div>
			</div>
			
			<!--添加模块-->
			<div class="modal fade add-tpl" id="addTplAlert" tabindex="-1" role="dialog" aria-labelledby="addTplAlertLabel">
			  	<div class="modal-dialog" role="document">
			    	<div class="modal-content border-radius">
				      	<div class="modal-header">
				      		<div class="tit-tips">添加模块</div>
				      		<a class="pull-right" data-dismiss="modal" href="javascript:void(0)"></a>
				      	</div>
				      	<div class="modal-body">
				      		<div class="tpl-wrap">
				      			
				      			<div class="tpl-nav">
				      				<ul class="clearfix">
				      					<li class="active" moduleType=""><a href="javascript:void(0)">全部</a></li>
				      					<c:forEach items="${datas.moduleType}" var="moduleType" varStatus="i">
					      					<li moduleType="${moduleType}"><a href="javascript:void(0)">${moduleType}</a></li>
				      					</c:forEach>
				      				</ul>
				      			</div>
					      		
					      		<div class="tpl-list-wrap">
					      			<div class="tpl-list">
					      				<ul id="moduleListUL">
					      						
					      				</ul>
					      			</div>
					      		</div>
					      		<!-- 分页开始  -->
					      		<div class="pagging-wrap clearfix" id="paginationDiv">
					      			
					      		</div>
					      		<!-- 分页结束  -->
				      		</div>
				      	</div>
			    	</div>
			  	</div>
			</div>
			
		</div><!-- /.page-content -->
	</div><!-- /.main-content -->
	<!--拖动排序插件  -->
	<script type="text/javascript">
		jQuery(function($){
			sort();
			deleteModule();
		});
		
		function sort(){
			window.x = new Sortable(sortItems, {
				group: "words",
				store: {
					get: function (sortable) {
						var order = localStorage.getItem(sortable.options.group);
						return order ? order.split('|') : [];
					},
					set: function (sortable) {
						var order = sortable.toArray();
						localStorage.setItem(sortable.options.group, order.join('|'));
					}
				}
			});
		}
		
		function deleteModule(){
			$('#sortItems a').each(function(){
				$(this).on('click',function(){
					$(this).parent().parent().parent().parent().remove();
					event.stopPropagation(); 
					return false; 
					
				}); 
			});
		}
		
		
	</script>
	<script type="text/javascript">
		jQuery(function($){
			function customDropDown(ele){
		        this.dropdown = ele;
		        this.spanele = this.dropdown.find("a > span").eq(0);
		        this.inputele = this.dropdown.find("a > input");
		        this.options=this.dropdown.find("ul.dropdown-menu > li");
		        this.initEvents();
		    }
		    customDropDown.prototype={
		        initEvents:function(){
		            var obj=this;
		            //点击下拉列表的选项
		            obj.options.on("click",function(){
		            	var opt = $(this);
		            	obj.inputele.val(opt.attr("val"));
		            	obj.spanele.html(opt.html());
		            });
		        },
		        getValue:function(){
		            return this.value;
		        }
		    }
			
			
			var belong_area = new customDropDown($("#belong_area"));
			var is_home = new customDropDown($("#is_home"));
			var display_area = new customDropDown($("#display_area"));
			var scope_area = new customDropDown($("#scope_area"));
		});
		
		//添加模块
		function addItem(sModuleNo,sModuleName){
			var module = "";
			module += "<li val='NaN_"+sModuleNo+"'>";
			module += "<p class='row module'>";
			module += "<small class='col-xs-10 col-sm-10 col-md-7 col-lg-6'>";
			module += "<label class='col-xs-11 col-sm-11'>";
			module += "<input class='border border-radius bg-color' value='"+sModuleName+"' type='text' />";
			module += "<a class='btn-delete' href='javascript:void(0)'><img class='delete_img' src='"+resourceHost+"/images/btn-delete.png' /></a>";
			module += "</label>";
			module += "</small>";
			module += "</p>";
			module += "</li>";
			$('#sortItems').append(module);
			deleteModule();
			layer.msg('添加模块成功。',{time: 1000});
		}
		  
	</script>
</e:point>