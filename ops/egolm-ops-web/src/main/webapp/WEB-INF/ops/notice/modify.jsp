<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="公告管理" currentTopMenu="公告管理"
	currentSubMenu="新增公告"
	css="css/add-notice.css,css/pagination.css,css/footable.core.css"
	js="js/footable.js,js/checked.js,js/notice-manage.js,js/add-notice.js"
	localCss="" 
	localJs="member/member.js,notice/notice.js,media/media-base.js"/>
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp">
	<div class="main-content">
		<div class="page-content">						
			<div class="wh_titer">
				<p class="wh_titer_f">您的位置：
					<a href="/${serverName}">首页</a> &gt; 
					<a href="javascript:void(0);">公告管理</a> &gt; 
					<a href="/${serverName}/api/notice/query">公告管理</a> &gt; 
					<a class="active" href="/${serverName}/api/notice/toAdd">更新公告</a>
				</p>
			</div>
			<div class="add-box"> <!-- 新增公告 -->
				<form id="modify-notice-form" >
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
						<span class="col-xs-3 col-sm-2">公告标题：</span>
						<label class="col-xs-8 col-sm-9 dropdown-wrap">
							<input type="hidden" name="sNoticeId" type="text"  value="${dataMap.sNoticeId}"/>
							<input class="input-title border border-radius bg-color" name="sNoticeTitle" type="text"  value="${dataMap.sNoticeTitle}"/>
							<span class="txt-limt"><span>0</span>/40</span>
						</label>
						</small>
					</p>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
							<span class="col-xs-3 col-sm-2 input-tips">发布地点：</span>
							<div class="col-xs-8 col-sm-9">
							<div class="col-xs-5 dropdown-wrap">
								<a class="dropdown-btn border border-radius bg-color dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
									<span class="item-name" id="current-org">${dataMap.sOrgDesc}</span>
									<input type="hidden" name="sOrgNO" id="sOrgNO" value="${dataMap.sOrgNO}"/>
									<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
							    </a>
							    <ul id="topOrgMenu" class="dropdown-menu" aria-labelledby="area-btn">
							    </ul>
							</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
							<span class="col-xs-3 col-sm-2 input-tips">发布时间：</span>
							<div class="col-xs-8 col-sm-9">
							<label class="col-xs-5 time1 dropdown-wrap">
								<input class="border border-radius bg-color" id="pub-date-picker" name="dPubDate" type="text" value="<fmt:formatDate value='${dataMap.dPubDate}' pattern="yyyy-MM-dd hh:mm:dd"/>" />
								<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
							</label>
							</div>
						</div>
						<div class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
							<span class="col-xs-3 col-sm-2 input-tips">下架时间：</span>
							<div class="col-xs-8 col-sm-9">
							<label class="col-xs-5 time1 dropdown-wrap">
								<input class="border border-radius bg-color" id="out-date-picker" name="dOutDate" type="text" value="<fmt:formatDate value='${dataMap.dOutDate}' pattern="yyyy-MM-dd hh:mm:dd"/>" />
								<span class="dr"><img src="${resourceHost}/images/arrow-black.png"/></span>
							</label>
							</div>
						</div>
					</div>
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
						<span class="col-xs-3 col-sm-2">公告内容：</span>
						<label class="col-xs-8 col-sm-9">
							<textarea name="sNoticeContent" class="border border-radius bg-color" rows="20">${dataMap.sNoticeContent}</textarea>
						</label>
						</small>
					</p>
					<p class="row">
						<small class="col-xs-12 col-sm-12 col-md-9 col-lg-7">
						<span class="col-xs-3 col-sm-2"></span>
						<label class="col-xs-8 col-sm-9">
							<input id="submit-modify-notice" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="保存" />
							<input id="cancel-create-notice" class="border-radius border col-xs-6 col-sm-3 col-md-3" type="button" value="取消" />
						</label>
						</small>
					</p>
				</form>
			</div>
		</div>
	</div>
</e:point>