<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="../../../../resources/common/jstl.jsp"%>
<!-- 图片 -->
<c:if test="${ap_type == 'img' }">
   <c:forEach items="${resultMap }" var = "map"> 
        document.write("<div style='float:left;overflow:hidden;'>");
  	    document.write("<img width='${map.ad_width}' height='${map.ad_hight}' src='${map.ad_path}' style='border:none;' />");
   		document.write("</div>");
   </c:forEach> 
</c:if> 


<!-- 文本 -->
<c:if test="${ap_type == 'text' }">
 <c:forEach items="${resultMap }" var = "map"> 
 	  document.write("<div style='width='${map.ad_width }';height='${map.ad_hight }';float:left;overflow:hidden;'>");
 	  document.write("<a href='${map.ad_url }' target='_blank'>");
	  document.write(${map.ad_text});
	  document.write("</a>");
	  document.write("</div>");  
 </c:forEach> 
</c:if>

<!-- 幻灯 -->  
<c:if test="${ap_type == 'slide' }">
<!--   document.write("<script\/>");
  	   document.write("jQuery('document').ready(function(){");  
	   document.write("jQuery('#qdshop_advert').KinSlideshow({btn:{btn_bgColor:'#FFFFFF',btn_bgHoverColor:'#FF8921',btn_fontColor:'#000000',btn_fontHoverColor:'#EEEEEE',btn_borderColor:'#666666',btn_borderHoverColor:'#FFFFFF',btn_borderWidth:1}});");
 	   document.write("})");
 	   document.write("</script>"); -->
 	   document.write("<div class='hdp' id='qdshop_advert'  >");
  	   document.write("<ul>");
 <c:forEach items="${resultMap }" var = "map">  
 	   document.write("<a href='#' target='_blank'><img src='${map.ad_path}' width='${map.ad_width}' height='${map.ad_hight}' ad_id ='${map.ad_id}' ap_id='${map.ap_id }'  /></a>");
  </c:forEach>
	   document.write("</ul>");
 	  document.write("</div>");
</c:if>

<!--  滚动-->
<c:if test="${ap_type == 'scroll' }">

	  document.write("<div class='conti_left' id='advert_left'><span></span></div>");
	  document.write("<div class='conti'>");
	  document.write("<ul>");
   <c:forEach items="${resultMap }" var = "map"> 
	  document.write("<li>");
	  
	  document.write("<a href='<%=request.getContextPath() %>/api/adVertView/advert_redirect?id=${map.ad_id}' target='_blank'><img src='${map.ad_path}' width='${map.ad_width}' height='${map.ad_hight}'  ad_id ='${map.ad_id}' ap_id='${map.ap_id }' /></a>");
	 
	  document.write("</li>");
	</c:forEach>
	  document.write("</ul>");
	  document.write("</div>");
	  document.write("<div class='conti_right' id='advert_right'><span></span></div>");
</c:if>