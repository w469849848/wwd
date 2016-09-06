<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
<div class="pageContent">
	<form method="post" action="<%=request.getContextPath() %>/api/adVert/add" class="pageForm required-validate" enctype="multipart/form-data" onsubmit="return iframeCallback(this);">
		<div class="pageFormContent nowrap" layoutH="97">
		<input type = "hidden" name = "nAdID" value = "${adVertData.nAdID}"/>
 			<dl>
				<dt>广告名称</dt>
				<dd>
					<input type="text" name="sAdTitle" maxlength="100" size="80" class="required"  value = "${adVertData.sAdTitle }"/> 
				</dd>
			</dl>
			<dl>
				<dt>广告位置</dt>
				<dd>
				 <select name="ap_sale_type" class="required combox" ref="combox_ap_msg" refUrl="<%=request.getContextPath() %>/api/adPos/loadMsgByApSaleType?sApSaleType={value}">
 					<option value="">请选择</option>
 					<option value="wx" <c:if test="${adVertData.sApSaleType =='wx' }">selected="selected"</c:if>>微信广告位</option>
         		 	<option value="web" <c:if test="${adVertData.sApSaleType =='web' }">selected="selected"</c:if>>WEB广告位</option>
         		    <option value="app" <c:if test="${adVertData.sApSaleType =='app' }">selected="selected"</c:if>>App广告位</option> 
				 </select> 
				
 				</dd>
			</dl>
			<dl>
			  <dt>广告位</dt>
			  <select name="nApID"   class="required combox" id="combox_ap_msg">
 					 
				 </select> 
			</dl>
			<dl>
				<dt>合同号</dt>
				<dd>
					<input type="text" name="nContractID" id="nContractID" maxlength="100" size="80" class="required"  value = "${adVertData.nContractID }"/> 
				</dd>
			</dl>	
			 		
			<dl>
				<dt>区域</dt>
				<dd>
				 <select name="sAdZoneCode" class="required combox">
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
				<dt>开始时间</dt>
				<dd>
				 <input type="text" name="dAdBeginTime" class="date" readonly="true"  value = "${adVertData.dAdBeginTime }"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
				<span class="info">yyyy-MM-dd</span>
				</dd>
			</dl>
			 
			<dl>
				<dt>结束时间</dt>
				<dd>
					<input type="text" name="dAdEndTime" class="date" readonly="true" value = "${adVertData.dAdEndTime }"/>
				<a class="inputDateButton" href="javascript:;">选择</a>
				<span class="info">yyyy-MM-dd</span>
				</dd>
			</dl>
			 
			 
			 
			<dl>
				<dt>广告图片</dt>
				<dd>
					<input type="file" name="acc"  id="acc"   />  
				    <span class="preview"> <img src="<%=request.getContextPath() %>/resources/images/preview.jpg" width="25" height="25"  id="logoShow" style="cursor:help"/> </span> 
				    <c:if test="${empty adVertData.path}">
				    	<span id="nothis"><strong class="q"></strong><strong class="w">暂无图片</strong><strong class="c"></strong></span> 
				    </c:if>
				    
					<div class="bigimgpre" id="logoImg" style="display:none;"><img src="${adVertData.path }"  width="${adVertData.ap_width }" height="${adVertData.ap_height}" id="logoShow2"/> </div>
				 
				</dd>
			</dl>
			<dl>
				<dt>幻灯片序号</dt>
				<dd>
					<input type="text" name="nAdSlideSequence" maxlength="20"  size="80"  value = "${adVertData.nAdSlideSequence}" class="digits"/>
					 
				</dd>
			</dl>
			<dl>
				<dt>广告链接</dt>
				<dd>
					<input type="text" name="sAdUrl" maxlength="20"  size="80"  value = "${adVertData.sAdUrl }"/>
					 
				</dd>
			</dl> 
			<dl>
				<dt>广告批次</dt>
				<dd>
  					<select id = "nBID" name = "nBID">
  					
  					</select>					 
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
	   loadBIDMsg();
   });
   
   $("#combox_ap_msg").change(function(){
	   var value = $("#combox_ap_msg  option:selected").val();
	   if(value != ''){
		   loadContractMsg(value);
	   }
	});
   
   function loadContractMsg(nApId){
	   $.ajax({
			type:'POST',
			url:'api/adPos/listToJson?nApID='+nApId,
			dataType:"json",
			cache: false,
			success: function (data) {
				 var isValid = data.IsValid;
				 if(isValid){
					 var dataList = data.DataList;  
					 $("#nContractID").val(dataList.nContractID); 
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
   }
   
   
   //加载批次数据
   function loadBIDMsg(){
	   $.ajax({
			type:'POST',
			url:'api/adBatch/listToJson',
			dataType:"json",
			cache: false,
			success: function (data) {
				 var isValid = data.IsValid;
				 if(isValid){
					 var dataList = data.DataList; 
					 if(dataList.length>0){ 
						 var nBIDS="";
						 for(var i = 0;i<dataList.length;i++){
							 var data = dataList[i];
							 nBIDS+="<option value='"+data.nBID+"'>"+data.sBatchName+"</option>"; 
						 }
						 $("#nBID").html(nBIDS);
						 
					 }
				 }else{
					 alert(data.ReturnValue);
				 }
			} 
		});
   }
</script>