<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<c:set scope="application" var="egolmHost"     value="${e:egolmHost('')}" />
<c:set scope="application" var="mediaHost"     value="${e:mediaHost('')}" />
<c:set scope="application" var="resourceHost"  value="${e:resourceHost('')}${serverName}/resources/assets" />
<c:set scope="application" var="localHost"     value="${e:localHost()}" />
<c:set scope="application" var="serverName"    value="${e:serverName()}" />
<c:set scope="application" var="webHost"       value="${egolmHost}${serverName}" />
<e:resource title="模板设置" currentTopMenu="" currentSubMenu="" css="" js="" localCss="tpl/tpl-setting.css,tpl/index.css,tpl/tpl-manage.css,tpl/slider.css" showFooter="false" showHeader="false" showSubMenu="false" showMenu="false" showTopMenu="false" localJs="tpl/tpl-setting.js,tpl/jQuery-jcSlider.js,tpl/jQuery-easing.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/tpl/tpl-setting-pop-ad-detail.jsp">
<script type="text/javascript">
        $(function () {
            $('#pic_wrap').jcSlider({
                loading: false,                 //预加载loading开关设置，提供true,false
                loadpic: '../Slider/img/loading.gif',     //预加载loading图片路径，相对定位,如../img/riddick.png
                play: true,                     //是否开起自动播放功能，提供true,false
                play_speed: 2000,               //自动播放速度设置，提供easing值 或 数值(mm)
                slider_btn: true,               //左右按钮开关，提供true,false
                slider_speed: 500,              //图片切换速度设置，提供easing值 或 数值(mm)
                slider_num: true,               //数字按钮开关，提供true,false
                offset: 0,                      //设置左右按钮偏移量(px)
                btn_event: 'mouseover',             //数字按钮事件设置，提供click,mouseover等
                btn_position: 'middle',         //数字按钮位置，提供left,middle,right
                num_offsetW: 0,                 //设置数字按钮的X偏移(px)
                num_offsetH: 400,               //设置数字按钮的Y偏移(px)
                scaling: false,                  //是否设置图片大小，提供true,false
                width: 956,                     //设置图片宽度单位(px)
                height: 300,                    //设置图片高度单位(px)        
                sliderModle: 'xScroll'
            });
            var tagli = $("#imgShow li");
            if (tagli.length > 0) {
                $('#pic_wrap').css('display', 'block');
            }
            var _w1 = $('#pic_wrap').width();
            var _w2 = $('#sliderNum').width();
            $('#sliderNum').css('left', (_w1 - _w2) / 2);
        });
    </script>
<div class="main-content">
        <div id="pic_wrap" style="display: none">
            <ul id="imgShow">
                <li>
                    <div class="middle-out">
                        <div class="middle-in">
                            <img src="http://img.egolm.com/egolm/ad/adpos/web/SUZU/2016/05/13/2016_05_13_14_16_02_23616907.jpg@160h_160w" width="573" height="300" />
                        </div>
                        <div align="center" style="margin-top: 5px; padding-top: 5px;">
                            Chrysanthemum
                        </div>
                    </div>
                </li>
                <c:forEach items="${datas}" var="d">
                   <li>
	                    <div class="middle-out">
	                        <div class="middle-in">
	                            <img src="http://img.egolm.com/${d.sAdPathUrl }@${d.nAdHeight }h_${d.nAdWidth }w" width="${d.nAdWidth }" height="${d.nAdHeight }" />
	                        </div>
	                        <div align="center" style="margin-top: 5px; padding-top: 5px;">
	                            ${d.sGoodsDesc }
	                        </div>
	                    </div>
	                </li>
	              </c:forEach>
            </ul>
        </div>
    </div>
</e:point>