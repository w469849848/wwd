<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="报表数据配置"  currentTopMenu="系统管理" currentSubMenu="报表数据配置" css="css/report-add.css" js="" localCss="" localJs="system/report-add.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/system/report-add.jsp">

				<div class="main-content">

					<div class="page-content">
						
						<div class="wh_titer">
							<p class="wh_titer_f">
								您的位置：
								<a href="${webHost}/index">首页</a> &gt; 
								<a href="${webHost}/system/ywReport/index">报表数据管理</a> &gt;   
 								<c:if test="${not empty reportSqlData.sMenuID}">
								<a class="active" href="${webHost}/system/ywReport/loadMsgById?menuId=${reportSqlData.sMenuID}">编辑报表数据</a>
								</c:if>
								<c:if test="${empty reportSqlData.sMenuID}">
								<a class="active" href="${webHost}/system/ywReport/addIndex">新增报表数据</a>
								</c:if>
							</p>
						</div>
						
						<div class="addReport"> <!--报表数据管理 -->
						
							<form action ="",method="post" id="addReportFrom" name="addReportFrom" onsubmit = "return check();"   >
							 <input type="hidden" name="sMenuID" id="sMenuID" value="${reportSqlData.sMenuID }"/>
							 <div class="row">
									<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<div class="col-xs-12 col-sm-6">
											<span class="col-xs-4 input-tips">报表类型：</span>
												<input type="hidden" name="sReportTypeID" id="sReportTypeID"  value="${reportSqlData.sReportTypeID}"/>
												<input type="hidden" name="sReportType" id="sReportType" value="${reportSqlData.sReportType }"/>
											<div class="col-xs-7 dropdown-wrap">
 												<a id="sReportType-id" class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
										          	<span>请选择</span>
										          	<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
										        </a>
										        <ul id="sReportType-menu" class="dropdown-menu" aria-labelledby="sReportType-id">
										          		 <li value="s">统计报表</li>
										          		 <li value="o">图形报表</li>
										        </ul>										 
											</div>
										</div>
										 
									</div>
								</div>
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">菜单名称：</span>
										<label class="col-xs-7 col-sm-10 dropdown-wrap">
											<input class="border border-radius bg-color" type="text"  name = "sMenuName" id = "sMenuName"  value="${reportSqlData.sMenuName }"/>
											<!-- <span class="txt-limt"><span>0</span>/40</span> -->
										</label>
									</small>
								</p>
								
								
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">报表标题：</span>
										<label class="col-xs-7 col-sm-10 dropdown-wrap">
											<input class="border border-radius bg-color" type="text"  name = "sReportTitle" id = "sReportTitle" value="${reportSqlData.sReportTitle }" placeholder="标题列以  | 分隔"/>
 										</label>
									</small>
								</p>
								
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">报表脚本：</span>
										<label class="col-xs-12 col-sm-10 dropdown-wrap">
											<textarea class="border border-radius bg-color" rows="20" name="sReportSql" id="sReportSql"  
											placeholder="脚本中的参数where 条件后面跟上1=1条件,参数放置在{}中, 示例: where 1=1 and id={id}, ,禁止出现 drop,update,delete,create,<,>,& 非法关键字和字符.">${reportSqlData.sReportSql }</textarea>
										</label>
									</small>
								</p> 
							 
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2">排序字段：</span>
										<label class="col-xs-7 col-sm-10 dropdown-wrap">
											<input class="border border-radius bg-color" type="text"  name = "sReportSortField" id = "sReportSortField" value="${reportSqlData.sReportSortField }"  placeholder="排序字段根据脚本中的列值设定"/>
 										</label>
									</small>
								</p> 
								 
							 
								
								<p class="row">
									<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
										<span class="col-xs-4 col-sm-2"></span>
										<label class="col-xs-7 col-sm-10">
											<input id="submit" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="提交" />
											<input id="cancel" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="取消" />
										</label>
									</small>
								</p>
							</form>
						</div> 
						
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->
</e:point>			
