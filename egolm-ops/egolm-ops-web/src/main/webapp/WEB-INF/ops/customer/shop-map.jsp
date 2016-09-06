<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<e:resource title="会员管理" currentTopMenu="会员管理" currentSubMenu="店铺管理"
	css="" js="js/common.js" localCss="cust/shop-manage.css"
	localJs="cust/shop-map.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp"
	currentPath="/WEB-INF/ops/customer/shop-map.jsp">
	<!-- 操作html -->
	<div style="margin-left: 200px;">
		<div>
			<input id="sCity" type="hidden" value="${SCity }"/>
			<input id="nShopID" type="hidden" value="${NShopID }"/>
			<input id="SDistrict" type="hidden" value="${SDistrict }"/>
		</div>
		<div style="padding-top: 10px;">
			<table>
				<tr>
					<td>
						原店铺地址：
						<c:if test="${!empty SAddress}">
							<c:if test="${!empty lng }">
								<input readonly="readonly" id="shopAddress" value="${SAddress }" style="width: 250px;"/>	
							</c:if>
							<c:if test="${empty lng }">
								<input readonly="readonly" id="shopAddress" style="width: 250px;"/>	
							</c:if>
						</c:if>
						<c:if test="${empty SAddress}">
							<input readonly="readonly" id="shopAddress" value="${SProvince }${SCity }${SDistrict }" style="width: 250px;"/>	
						</c:if>
					</td>
					<td>原店铺名称：<input value="${SShopName }" readonly="readonly"  style="width: 200px;"/></td>
					<td>
						原店铺经度：<input style="width: 200px;" readonly="readonly" id="lng" value="${lng }"/>
					</td>
					<td>
						原店铺纬度：<input style="width: 200px;" readonly="readonly" id="lat" value="${lat }"/>
					</td>
					<td>
					</td>
				</tr>
				<tr>
					<td>新店铺地址：
					<input readonly="readonly" id="clickVal" style="width: 250px;"/></td>
					<td>新店铺名称：<input id="newShopName" onkeyup="checkShopName()" type="text" placeholder="请输入新店铺地址(必填项)" style="width: 200px;"/></td>
					<td>新店铺经度：<input readonly="readonly" id="lng1" style="width: 200px;" /></td>
					<td>
						新店铺纬度：<input readonly="readonly" id="lat1" style="width: 200px;" />
					</td>
					<td>
						<button onclick="updateAddress()" id="updateAddress">更新店铺经纬度</button>
					</td>
				</tr>
				<tr>
					<td>查询　地址：
					<input type="text" id="suggestId" size="20" style="width:250px;"/></td>
					<td>
						搜索　服务：<input id="search" style="width: 150px;" />
						<button onclick="searchService()"  style="width: 50px;" id="search1">search</button></td>
					<td>
						店铺　分布：
						<select id="sOrgNOSel" style="width: 195px;">
							<option>请选择</option>
							<c:forEach items="${zoneList }" var="zone">
								<option value="${zone.sOrgNO }">${zone.sOrgNO }</option>
							</c:forEach>
						</select>
					</td>
					<td>
						店铺的数量：<input id="shopNum" placeholder="默认查询5个店铺" style="width:150px;" type="text">
						<button style="width: 50px;"  id="searchZone" onclick="searchZone()">查询</button>
						<!-- 店铺　距离：<input id="distance" style="width: 150px;" readonly="readonly"/>
						<button onclick="getDistance()" style="width: 50px;" id="distance1">获取</button> -->
					</td>
					<td></td>
				</tr>
				<tr>
					<td colspan="2">
						店铺　经度：
						<input id="searchLng" style="width: 250px;" />
						店铺　纬度：<input id="searchLat" style="width: 200px;" />
					</td>
					<td>
						<button onclick="searchAddress()">手动定位店铺位置</button>
					</td>
					<td>
						<button onclick="javascript:window.location.href='shopList'" style="width: 50px;">返回</button>
						<button onclick="javascript:init('${lng}','${lat}','${SAddress}','${SDistrict }')" style="width: 50px;">复位</button>
					</td>
					<td></td>
				</tr>
			</table>
		</div>
	</div>
	
	<div style="padding-top:10px;padding-left: 5px;height: 100%;" class="main-content" id="container">
	</div>
</e:point>