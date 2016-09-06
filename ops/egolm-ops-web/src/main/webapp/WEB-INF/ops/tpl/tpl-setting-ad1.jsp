<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="模板设置" currentTopMenu="" currentSubMenu="" css="" js="" localCss="tpl/tpl-setting.css,tpl/index.css,tpl/banner.css,tpl/common.css,tpl/header.css,tpl/reset.css,tpl/tpl-manage.css" localJs="jquery.form.js,tpl/Sortable.min.js,tpl/tpl-setting.js,tpl/jquery.SuperSlide.2.1.1.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-setting-ad1.jsp">
<script type="text/javascript">
	var JsonData = '${json}';
	var JsonApID = '${JsonApID}'
</script>


<div class="main-content">
	<div class="page-content">
		
		<div class="wh_titer">
			<p class="wh_titer_f">
				您的位置：
				<a href="${webHost}/index">首页</a> &gt; 
				<a href="${webHost }/template/list">模板管理</a> &gt; 
				<a class="active" href="#">模板设置</a>
			</p>
		</div>

	<div class="tpl table-box">
		
		<div class="tpl-nav">
				<ul class="clearfix">
					<c:forEach items="${moduleList}" var="module" varStatus="i">
						<c:if test="${module.SLinkNo eq sLinkNo }">
							<li class="active"><a href="${egolmHost }${serverName }/${module.SBgPath }?sLinkNo=${module.SLinkNo}">${module.SModName }</a></li>
						</c:if>
						<c:if test="${module.SLinkNo ne sLinkNo }">
							<li><a href="${egolmHost }${serverName }/${module.SBgPath }?sLinkNo=${module.SLinkNo}">${module.SModName }</a></li>
						</c:if>
					</c:forEach>
				</ul>
		</div>
		<form id="tplSettingForm" action="${webHost}/template/setting/saveJson" method="post">
			<input type="hidden" id="sBelongNo" name="sBelongNo" value="${sBelongNo }"/>
			<input type="hidden" id="sLinkNo" name="sLinkNo" value="${sLinkNo }"/>
			<input type="hidden" id="sLayoutContent" name="sLayoutContent" value=""/>
		</form>
		<div class="tpl-content">
				
				<!--广告模块-->
				<div class="ad-module tab-4">
					
					<!--中部楼层-->								
					<div class="content pr">
						<div class="hot-wrap">
							<div class="hot-ad mb-20 pw ma pr" id="ap" adPos="">
								<a href="javascript:void(0)"><img src="${resourceHost}/images/tpl/advertise/hot-ad2.jpg" /></a>
								<div class="mask">
									<a class="edit-tips" href="javascript:void(0)" onclick="popSelectAd(1210,120,'ap_L','${sBelongNo}','${sDisplayNo}','${sScopeTypeID}')"><img src="${resourceHost}/images/tpl/edit-tips.png"/></a>
									<span class="size">1210 × 120（PX）</span>
								</div>
							</div>
						</div>
					</div>
					
					<div class="btn-wrap">
						<label class="btn-submit"><input type="button" value="提交" onclick="packageJson()" /></label>
						<label class="btn-cancel"><input id="cancelButton" type="button" value="取消" onclick="location.href='${egolmHost}${serverName}/template/list'"/></label>
						<label class="btn-preview pull-right"><input type="button" value="生成预览"  onclick="window.open('${webHost}/template/preview?sTplNo=${sTplNo }')"/></label>
					</div>
					
				</div>
				
		</div>
	</div>
</div>
</div>
<script type="text/javascript">
jQuery(function($){
	//表单异步提交
	$('#tplSettingForm').ajaxForm(function(data) { 
	  	var res = JSON.parse(data);
      	if(res.IsValid==true){
      		layer.alert(res.ReturnValue, {icon: 1}, function(index){
    			layer.close(index);
    		});
      	}else{
      		layer.alert(res.ReturnValue, {icon: 2}, function(index){
    			layer.close(index);
    		});
      	}
      	$("#cancelButton").val("返回");
   });
	
	if(!!JsonData){
		var jsonObject = JSON.parse(JsonData);
		saveAdPos(jsonObject['nApID'],jsonObject['sApPathUrl'],'ap_L','show');
	}
});
/**
 * 保存广告位
 * @param nApID 广告ID
 * @param sApPathUrl  图片地址
 * @param sign
 */
function saveAdPos(nApID, sApPathUrl, sign, isShow){
	
	if(isShow != "show"){
		if(!checkAp(nApID,sign)){
			return false;
		}
	}
	
	var sBelongNo = $("input[name='sBelongNo']").val();
	var result = false;
	
	var apObj = {};
	apObj['nApID'] = nApID;
	apObj['sApPathUrl'] = sApPathUrl;
	
	var data = queryAds(nApID,sBelongNo);
	if(data != "" && data != null){
		$('#ap').attr('adPos',JSON.stringify(apObj));
		
		var result = showAd(data,"ap_slide");
		if(result != "" && result != null){
			$('#ap').children('a').remove();
			$('#ap').prepend(result);
		}else{
			$('#ap').children('a').remove();
			$('#ap').prepend(dafultShowAp(sApPathUrl));
		}
	}else{
		$('#ap').children('a').remove();
		$('#ap').prepend(dafultShowAp(sApPathUrl));
	}
	result = true;
	return result;
}

/**
 * 组装数据结构
 */
function packageJson(){
	if($('#ap').attr('adPos') == ""){
		layer.alert("未配置广告位数据", {icon: 3}, function(index){
			layer.close(index);
		});
	}
	console.log("组装json数=="+$('#ap').attr('adPos'));
	$('input[name="sLayoutContent"]').val($('#ap').attr('adPos'));
	$('#tplSettingForm').submit();
}

/**
 * 检查广告位是否被选择
 * @param nApID
 */
function checkAp(nApID,sign){
	
	if(JsonApID.indexOf("["+nApID+"]") > 0){
		layer.alert("此广告位已被选择，请重新选择", {icon: 2}, function(index){
			layer.close(index);
		});
		return false;
	}
	return true;
}
</script>
</e:point>