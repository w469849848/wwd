<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
<div class="pageContent">
	<form method="post" action="<%=request.getContextPath() %>/api/adPos/add" class="pageForm required-validate" enctype="multipart/form-data" onsubmit="return iframeCallback(this);">
		<div class="pageFormContent nowrap" layoutH="97">
		<input type = "hidden" name = "nApID" value = "${adPosData.nApID }"/> 
  			<dl>
				<dt>合同编号</dt> 
				<dd>
					<select name = "nContractID" id = "nContractID">
					</select>
				</dd>
			</dl>
  			<dl>
				<dt>广告位名称</dt> 
				<dd>
					<input type="text" name="sApTitle" maxlength="100" size="80" class="required"  value="${adPosData.sApTitle}"/> 
				</dd>
			</dl>
			<dl>
				<dt>广告位简介</dt>
				<dd>
					<textarea name="sApContent" class="required" cols="80" rows="2">${adPosData.sApContent}</textarea>
 				</dd>
			</dl>
			<dl>
				<dt>广告位默认内容</dt>
				<dd>
					<textarea name="sApText" class="required" cols="80" rows="2">${adPosData.sApText}</textarea> 当此广告位没有设置广告时,并且广告位类别为文本
 				</dd>
			</dl>
			<dl>
				<dt>广告位类型</dt>
				<dd>
				 <select name="sApSaleType" class="required combox">
 					<option value="wx">微信广告位</option>
         		 	<option value="web">WEB广告位</option>
         		    <option value="app">App广告位</option> 
				</select> 
				</dd>
			</dl>
			<dl>
				<dt>区域</dt>
				<dd>
				 <select name="sZoneCode" class="required combox">
 					<option value="SHJZ">石家庄</option>
					<option value="TIYN">太原</option>
					<option value="SHEN">沈阳</option>
				    <option value="TELN">铁岭</option>
					<option value="SHMY">上海母婴</option>
					<option value="SHBS">上海</option>
					<option value="NAJN">南京</option>
					<option value="SUZU">苏州</option>
					<option value="NATN">南通</option>
					<option value="HZDD">杭州大店</option>
					<option value="HNZU">杭州</option>
					<option value="NIBO">宁波</option>
					<option value="BNBU">蚌埠</option>
					<option value="NACH">南昌</option>
					<option value="HUNA">长沙</option>
					<option value="XIAN">西安</option>
					<option value="LNZU">兰州</option>
				</select> 
				</dd>
			</dl>
			<dl>
				<dt>广告位类别</dt>
				<dd>
				 <select name="sApType" class="required combox">
 					 <option value="img" <c:if test="${adPosData.sApType=='img'}">selected</c:if>>图片</option>
         		 	<option value="slide" <c:if test="${adPosData.sApType=='slide'}">selected</c:if>>幻灯</option>
         		    <option value="scroll" <c:if test="${adPosData.sApType=='scroll'}">selected</c:if>>滚动</option>
         			 <option value="text" <c:if test="${adPosData.sApType=='text'}">selected</c:if>>文字</option>
				</select> 
				</dd>
			</dl>
			 
			<dl>
				<dt>广告位价格</dt>
				<dd>
					<input type="text" name="nApPrice" maxlength="20" size="80" class="required" value="${adPosData.nApPrice}"/>
					 <span class="info">月</span>
				</dd>
			</dl>
			<dl>
				<dt>系统类型</dt>
				<dd> 
				<select name="sApSysType" class="required combox">
 					<option value="1" selected>是</option>
					<option value="0" >否</option> 
				</select> 
					 <span  class="info">系统广告不可删除，主要处理商城预留广告位</span>
				</dd>
			</dl>
			<dl>
				<dt>广告状态</dt>
				<dd>
					 <select name="nApStatus" class="required combox">
 						<option value="1" selected>启用</option>
						<option value="0" >不启用</option> 
					</select> 
				</dd>
			</dl>
			<dl>
				<dt>展示方式</dt>
				<dd>
 					 <select name="nApShowType" class="required combox">
 					 	 <option value="0" selected>全部展示</option>  
 						<option value="1" >随机展示</option>
					</select>
				</dd>
			</dl>
			<dl>
				<dt>广告位宽度</dt>
				<dd>
					<input type="text" name="nApWidth" maxlength="20" size="80" class="required digits"  value="${adPosData.nApWidth}"/>
					 
				</dd>
			</dl>
			<dl>
				<dt>广告位高度</dt>
				<dd>
					<input type="text" name="nApHeight" maxlength="20" size="80" class="required digits"  value="${adPosData.nApHeight}" />
					 
				</dd>
			</dl>
			<dl>
				<dt>广告位默认图片</dt>
				<dd>
					<input type="file" name="acc"  id="acc"   />
					 <span class="preview"> <img src="<%=request.getContextPath() %>/resources/images/preview.jpg" width="25" height="25"  id="logoShow" style="cursor:help"/> </span> 
				    <c:if test="${empty adPosData.sApPathUrl}">
				    	<span id="nothis"><strong class="q"></strong><strong class="w">暂无图片</strong><strong class="c"></strong></span> 
				    </c:if>
				    
					<div class="bigimgpre" id="logoImg" style="display:none;"><img src="${adPosData.sApPathUrl }"  width="${adPosData.nApWidth }" height="${adPosData.nApHeight}" id="logoShow2"/> </div>
				   
				</dd>
			</dl>
			<dl>
				<dt>默认链接</dt>
				<dd>
					<input type="text" name="sApAccURL" maxlength="20"  size="80"  value="${adPosData.sApAccURL}" />
					 
				</dd>
			</dl> 
			
		</div>
		<div class="formBar">
			<ul>
				<li><div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div></li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
	</form>
</div>
<script>
   $(function(){
	   jQuery("#logoShow").mouseover(function(){
		    jQuery("#logoImg").css('display','block');
	   }).mouseout(function(){
			jQuery("#logoImg").css('display','none');
		}); 
	   loadContractIDMsg();
   });
   
   //获取合同编号信息
   function loadContractIDMsg(){
	   $.ajax({
			type:'POST',
			url:'api/advContract/listToJson',
			dataType:"json",
			cache: false,
			success: function (data) {
				 var isValid = data.IsValid;
				 if(isValid){
					 var dataList = data.DataList; 
					 if(dataList.length>0){ 
						 var contractId="";
						 for(var i = 0;i<dataList.length;i++){
							 var data = dataList[i];
							 contractId+="<option value='"+data.nContractID+"'>"+data.sContractNO+"</option>"; 
						 }
						 $("#nContractID").html(contractId);
						 
					 }
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
   }
</script>