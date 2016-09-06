/*
	//百度地图API常用的对象总结
	var map = new BMap.Map("container");                        //container是指定的容器，创建地图实例
	//Map对象下面对应的常用方法
	map.centerAndZoom(point,level);                             //point对应的地理坐标，level对应的地图级别
	map.addOverlay(marker);                                     //添加覆盖物
	map.clearOverlays();										//清除所有的覆盖物
	map.removeOverlay(overlay:Overlay);                         //清除指定覆盖物                      
	var point = new BMap.Point(lng,lat);                        //lng对应地址的经度，lat对应地址的纬度
	var marker = new BMap.Marker(point);           				//point对应地址的地理坐标
	var autoComplete = new BMap.Autocomplete({
		"input":"suggestId",                       				//suggestId是input框对应的id
		"location":map                            				//map指的是作用域
	});
	var geoCoder = new BMap.GeoCoder();          				//GeoCoder指的是地理编码
	var infoWindow = new BMap.InfoWindow(address, opts);        //address窗口描述对应的信息，opts是js中的对象，对应的是窗口的信息
	var opts = {
		width:200px;
		height:100px;
		title:"信息窗口",
	};
 */
 
var map;
var pointList = [];
var colorList = [
                 {
                	 color:"#FFB6C1"
                 },
                 {
                	 color:"#9370DB"
                 },
                 {
                	 color:"#6495ED"
                 },
                 {
                	 color:"#FFFF00"
                 },
                 {
                	 color:"#C0C0C0"
                 },
                 ];
 
$(function(){
	var lng = $("#lng").val();
	var lat = $("#lat").val();
	var address = $("#shopAddress").val();
	var SDistrict = $("#SDistrict").val();   //区县名称
	map = init(lng,lat,address,SDistrict);
});

//------------------------页面方法start------------------------------ 
//查询区域下面的店铺 
function searchZone(){
	//清空
	$("#suggestId").val("");
	$("#search").val("");
	$("#searchLat").val("");
	$("#searchLng").val("");
	
	map.clearOverlays();
	//每次查询的时候，都清空pointList数据
	pointList = [];
	var sOrgNO = $("#sOrgNOSel").find("option:selected").text();
	var shopNum = $("#shopNum").val();
	
	if(sOrgNO=="请选择"){
		$("#sOrgNOSel").css({"border":"1px solid red"});
		return false;
	}else{
		$("#sOrgNOSel").css({"border":""});
	}
	
	if(shopNum==""){
		shopNum = 5;
	}else{
		if(isNaN(shopNum)){
			$("#shopNum").css({"border":"1px solid red"});
			return false;
		}else{
			$("#shopNum").css({"border":""});
		}
	}
	
	//查询区域通过orgNO
	$.ajax({
		url:"queryOrgZone",
		dataType:"json",
		type:"GET",
		data:{
			sOrgNO:sOrgNO,
			shopNum:shopNum
		},
		async:false,
		success:function(data){
			console.log("data="+data);
			var result = data.ReturnValue;
			var resInfo = eval("("+result+")");
			var res = $.parseJSON(result);
			var dataList = resInfo.DataList;
			for(var i in dataList){
				var sAddress = dataList[i].sAddress;
				var sCity = dataList[i].sCity;
				var sProvince = dataList[i].sProvince;
				sAddress = sProvince+""+sCity+""+sAddress;
				addGeocoder("",sAddress,sCity,map,"a1");
			}
		}
	});
	
	//将区域下面的县区通过Boundary()添加到map上
	$.ajax({
		url:"queryDistrictByOrgNO",
		dataType:"json",
		type:"GET",
		data:{
			sOrgNO:sOrgNO,
		},
		success:function(data){
			console.log("data="+data);
			var result = data.ReturnValue;
			var resInfo = eval("("+result+")");
			var res = $.parseJSON(result);
			var dataList = resInfo.DataList;
			for(var i in dataList){
				//获取区域下面的区县
				var sDistrict = dataList[i].sDistrict;
				//区域对应的颜色
				var color = colorList[i].color;
				addBoundary(sDistrict,color,map);
			}
		}
	});
}

//更改店铺地址，经纬度
function updateAddress(){
	var lng = $("#lng1").val();
	var lat = $("#lat1").val();
	var nShopID = $("#nShopID").val();
	var sNewAddress = $("#clickVal").val();
	var sNewShopName = $("#newShopName").val();
	
	if(sNewShopName.trim()==""){
		$("#newShopName").css({"border":"1px solid red"});
		return false;
	}else{
		$("#newShopName").css({"border":""});
	}
	
	if(lng.trim()==""){
		$("#lng1").css({"border":"1px solid red"});
		return false;
	}else{
		$("#lng1").css({"border":""});
	}
	
	if(lat.trim()==""){
		$("#lat1").css({"border":"1px solid red"});
		return false;
	}else{
		$("#lat1").css({"border":""});
	}
	
	if(sNewAddress.trim()==""){
		$("#clickVal").css({"border":"1px solid red"});
		return false;
	}else{
		$("#clickVal").css({"border":""});
	}
	
	$.ajax({
		url:"updateShopInfo",
		dataType:"json",
		type:"GET",
		data:{
			lng:lng,
			lat:lat,
			nShopID:nShopID,
			sNewAddress:sNewAddress,
			sNewShopName:sNewShopName
		},
		success:function(data){
			console.log("data="+data);
			alert(data.ReturnValue);
			//清空
			$("#shopNum").val("");
			$("#suggestId").val("");
			$("#search").val("");
			$("#searchLat").val("");
			$("#searchLng").val("");
		},
		error:function(){
			alert("修改店铺经纬度失败");
		}
	});
}

//在中心点附近定位位置
function searchService(){
	//清空
	$("#shopNum").val("");
	$("#searchLat").val("");
	$("#searchLng").val("");
	
	var searchVal = $("#search").val();
	var lng = $("#lng1").val();
	var lat = $("#lat1").val();
	searchLocation(lng,lat,searchVal);
}

//根据经纬度定位位置
function searchAddress(){
	//清空
	$("#shopNum").val("");
	$("#suggestId").val("");
	$("#search").val("");
	
	var lng = $("#searchLng").val();
	var lat = $("#searchLat").val();
	
	if(lng.trim()==""){
		$("#searchLng").css({"border":"1px solid red"});
		return;
	}else{
		$("#searchLng").css({"border":""});
	}
	
	if(lat.trim()==""){
		$("#searchLat").css({"border":"1px solid red"});
		return;
	}else{
		$("#searchLat").css({"border":""});
	}
	var point = addPoint(lng,lat);
	addGeocoder(point,"","",map,"p1");
}
//-------------------------end------------------------------ 
//添加行政边界Boundary
function addBoundary(SDistrict,color,map){
	var boundary = new BMap.Boundary();
	boundary.get(SDistrict,function(rs){
		//获取边界点point的集合
		var count = rs.boundaries.length; 
		
		var geocoder = new BMap.Geocoder();
		geocoder.getPoint(SDistrict,function(point){
			if(point){
				//将label组装好
				var label = addLabel(SDistrict,point,map);
				for(var i = 0;i<count;i++){
					addPolygon(rs.boundaries[i],color,SDistrict,label,map);
				}
			}
		})
	});
}

//添加多边形覆盖物
function addPolygon(pointList,color,SDistrict,label,map){
	var polygon = new BMap.Polygon(pointList,{
		strokeWeight: 1,                 //边线的宽度，以像素表示
		strokeOpacity:0.5,				 //边线的透明度				
		fillColor:color,             //填充颜色，参数为空的时候，折线覆盖物没有填充效果
		strokeColor: "#000000",			 //边线颜色
//		enableMassClear:false,           //调用map.clearOverlays时，清除覆盖物
	});
	map.addOverlay(polygon);  
	
	polygon.addEventListener("click",function(){
		
	});
	polygon.addEventListener("mouseover",function(){
		//添加覆盖物label
		map.addOverlay(label);
	});
	polygon.addEventListener("mouseout",function(){
		//清除覆盖物label
		map.removeOverlay(label);
	});
}

//在覆盖物上面添加label
function addLabel(districtName,cityPoint,map){
	var opts = {
		offset:new BMap.Size(0,0),
		position:cityPoint,
//		enableMassClear:false,     //调用map.clearOverlays的时候是否清除此覆盖物
	};
	//城市的名称
	var label = new BMap.Label(districtName,opts);
	return label;
}

//在指定区域类搜索餐馆，公园，网吧
function searchLocation(lng,lat,searchVal){
	var point = addPoint(lng,lat);
	var circle = new BMap.Circle(point,1200,{
		fillColor:"blue", 
		strokeWeight: 1 ,
		fillOpacity: 0.3, 
		strokeOpacity: 0.3
	});
	map.clearOverlays();
    map.addOverlay(circle);
    var local =  new BMap.LocalSearch(map, {
    	renderOptions: {
    		map: map, 
    		autoViewport: false
    	}
    });  
    local.searchNearby(searchVal,point,1200);
}

//添加point
function addPoint(lng,lat){
    var point = new BMap.Point(lng,lat);
	return point;
}

//添加标注，marker是可以移动的
function addMarker(point,address,map){
	var marker = new BMap.Marker(point);
	marker.enableDragging();            //设置marker可以移动
	map.clearOverlays();
	map.addOverlay(marker);
	map.centerAndZoom(point,15);
	var infoWindow = addInfoWindow(address);
	marker.addEventListener("click",function(e){
		map.openInfoWindow(infoWindow,point);
	});
	
	marker.addEventListener("dragend",function(e){
		var point = e.point;
		addGeocoder(point,"","",map,"p1");
	});
	
	marker.addEventListener("dragstart",function(e){
		var point = e.point;
		console.log("lng="+point.lng+";lat="+point.lat);
	})
}

//添加标注，并且展示最佳视角
function addMarker1(point,map,shopAddress){
	//给指定点添加标注
	var marker = new BMap.Marker(point);
	map.addOverlay(marker);    //添加标注
	map.centerAndZoom(point, 15); 
	//给标注添加click事件
	var infoWindow = addInfoWindow(shopAddress);
	marker.addEventListener("click",function(){
		map.openInfoWindow(infoWindow,point);
		//展示标注点的最佳视角
		map.setViewport(pointList,{
			zoomFactor:-1,
		});
	});
}

//添加窗口
function addInfoWindow(address){
	var opts = {
		width:200,
		height:100,
//		title:"店铺名称："+shopName, // 信息窗口标题
		title:"信息窗口", // 信息窗口标题
	};
	var infoWindow = new BMap.InfoWindow(address,opts);
	return infoWindow;
}

//添加地址解析
function addGeocoder(point,address,sCity,map,flag){
	var geocoder = new BMap.Geocoder();
	//通过详细地址解析出坐标
	if(flag=="a1"){
		geocoder.getPoint(address, function(point){
			if (point) {
				/**
				 * 判断解析出来的地址是否在当然城市中
				 * 1.在的话，添加到pointList中
				 * 2.不在的话，排除掉
				 */
				geocoder.getLocation(point,function(geocoderResult){
					var addressComponents = geocoderResult.addressComponents;
					//逆向解析出city
					var city = addressComponents.city;
					if(sCity==city){
						//设置在隐藏域中
						pointList.push(point);
						addMarker1(point,map,address);
					}else{
						console.log("city====="+city);
					}
				});
			}else{
				console.log("您选择地址没有解析到结果!");
			}
		}, sCity);
	}else if(flag=="p1"){
		//通过坐标获取详细地址
		geocoder.getLocation(point,function(geocoderResult){
			//地址解析的结果
			var point = geocoderResult.point;
			var address = geocoderResult.address;
			
			var addressComponents = geocoderResult.addressComponents;
			var province = addressComponents.province;
			var city = addressComponents.city;
			var district = addressComponents.district;
			var street = addressComponents.street;
			var streetNumber = addressComponents.streetNumber;
			
			var surroundingPois = geocoderResult.surroundingPois;
			var business = geocoderResult.business;
			$("#lng1").val(point.lng);
			$("#lat1").val(point.lat);
			$("#clickVal").val(address);
			addMarker(point,address,map);
		});
	}else if(flag=="s1"){
		geocoder.getPoint(address,function(point){
			if (point) {
				//在boundary上添加mouseover事件
				addLabel(address,point,map)
			}else{
				console.log("您选择地址没有解析到结果!");
			}
		})
	}
}

//添加自动填充
function addAutocomplete(map){
	var autoComplete = new BMap.Autocomplete({
		"input":"suggestId",
		"location":map,
	});
	autoComplete.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
		var _value = e.fromitem.value;
		var value = "";
		if (e.fromitem.index > -1) {
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		
		value = "";
		if (e.toitem.index > -1) {
			_value = e.toitem.value;
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
	});
	
	var myValue;
	autoComplete.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
		var _value = e.item.value;
		//取得当前选中的详细地址
		myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		addLocalSearch(myValue,map);
	});
}

//添加搜索地址
function addLocalSearch(myValue,map){
	var localSearch = new BMap.LocalSearch(map, { //智能搜索
	    onSearchComplete: myFun
	});
	
	function myFun(){
		//清空
		$("#searchLat").val("");
		$("#searchLng").val("");
		$("#shopNum").val("");
		$("#search").val("");
		
		var point = localSearch.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
		$("#lng1").val(point.lng);
		$("#lat1").val(point.lat);
		//新店铺地址
		$("#clickVal").val(myValue);
		addMarker(point,myValue,map);
	}
	localSearch.search(myValue);
}

//添加控件
function addControl(map){
	var size = new BMap.Size(10,20);
	var cityListControl = new BMap.CityListControl({
		anchor: BMAP_ANCHOR_TOP_LEFT,
		offset: size,
		onChangeAfter:function(){
			var point = map.getCenter();
			addGeocoder(point,"","",map,"p1");
		},
	});
	//添加城市控件
	map.addControl(cityListControl);
}

//添加map
function addMap(){
	var map = new BMap.Map("container");
	map.enableScrollWheelZoom();
	return map;
}

//初始化地图
function init(lng,lat,address,SDistrict){
	var map = addMap();
	var point = addPoint(lng,lat); 
	map.centerAndZoom(point,15);
	//添加标注
	addMarker(point,address,map)
	//添加控件
	addControl(map);
	//添加自动填充
	addAutocomplete(map);
	return map;
}