jQuery(function(){
	
	//响应式表格初始化
	$('.table-data table').footable({
		debug: true,
		breakpoints: {
			phone: 480,
			tablet: 800
		},
		log: function(message, type) {
			
		}
	});
	
	//设置图例样式
	function graphicalCol(elem) {
		var graphical_color = $(elem);
		var graphicalColor = ["#ff6400", "#f4b350", "#e87e04", "#00b16a", "#3fc380", "#5c97bf", "#66cc99","#3ba9e1","#3ba9e1","#81cfe0"],
			colorIndex = 0;
		for (var i = 0; i < graphical_color.length; i++) {
			if (colorIndex == graphicalColor.length) {
				colorIndex = 0;
			}
			graphical_color[i].style.backgroundColor = graphicalColor[colorIndex];
			colorIndex++;
		}
	}
	
	//插入图例
	function appendItem(json,elem){
		var data = json.data || [],
			length = data.length || 0,
			$elem = $(elem),
			html = '';
		
		for(var i = 0; i < length; i++){
			html = '<div class="col-xs-5">'
						+'<div class="graphical_col"></div>'
						+'<div class="graphical_num"><span class="item-name">'+ data[i][0] +'</span> : <span>'+ data[i][1]+'%' +'</span></div>'+
					'</div>';
					
			$elem.append(html);
		}
	}
	
	
	
	/*
	 * @流量统计折线图 -- PC
	 */
	var stockPc = null,
		canvasWidth = $('.line-chart').width(),
		canvasHeight = canvasWidth/3 <= 400 ? 400 : canvasWidth/3;
	
	//初始化流量统计
	$.getJSON('assets/json/stock-dataArr.json', function(data) {
		stockPc = new AStock({
			theme: AChart.Theme.Base,
			id: 'line-chart-pc',
			width: canvasWidth,
			height: canvasHeight,
			plotCfg: {
				margin: [60, 50, 60, 50] //画板的边距
			},
			xAxis: { //格式化时间
				type: 'time',
				labels: {
					label: {
						'font-size': '10'
					}
				},
				formatter: function(value) {
					return Chart.Date.format(new Date(value), 'yyyy-mm-dd');
				},
				animate: false
			},
			yAxis: {
				animate: false
			},
			xTickCounts: [1, 8], //设置x轴tick最小数目和最大数目 
			seriesOptions: { //设置多个序列共同的属性
				lineCfg: { //如果数据序列未指定类型，则默认为指定了xxCfg的类型，否则都默认是line
					markers: {
						single: true
					},
					animate: false,
					line: {
						'stroke-width': 1
					},
					lineActived: {
						'stroke-width': 1
					}
				}
			},
			tooltip: {
				valueSuffix: ''
			},
			series: [{
				name: '浏览量',
				pointInterval: 24 * 3600 * 800,
				pointStart: Date.UTC(2016, 05, 01), //从6月1号开始算起
				data: data[0]
			}, {
				name: '访客数',
				data: data[1],
				pointInterval: 24 * 3600 * 800,
				pointStart: Date.UTC(2016, 05, 01) //从6月1号开始算起
			}]
		});
		stockPc.render();
	});
	
	//按天统计
	$('.traffic-analysis-pc .btn-day').on('click',function(){
		$.getJSON('assets/json/stock-dataArr.json', function(data) {
			$('.traffic-analysis-pc .btn-day').toggleClass('active');
			$('.traffic-analysis-pc .btn-hour').toggleClass('active');
			$('#line-chart-pc').empty();
			stockPc = new AStock({
				theme: AChart.Theme.Base,
				id: 'line-chart-pc',
				width: canvasWidth,
				height: canvasHeight,
				plotCfg: {
					margin: [60, 50, 60, 50] //画板的边距
				},
				xAxis: { //格式化时间
					type: 'time',
					labels: {
						label: {
							'font-size': '10'
						}
					},
					formatter: function(value) {
						return Chart.Date.format(new Date(value), 'yyyy-mm-dd');
					},
					animate: false
				},
				yAxis: {
					animate: false
				},
				xTickCounts: [1, 8], //设置x轴tick最小数目和最大数目 
				seriesOptions: { //设置多个序列共同的属性
					lineCfg: { //如果数据序列未指定类型，则默认为指定了xxCfg的类型，否则都默认是line
						markers: {
							single: true
						},
						animate: false,
						line: {
							'stroke-width': 1
						},
						lineActived: {
							'stroke-width': 1
						}
					}
				},
				tooltip: {
					valueSuffix: ''
				},
				series: [{
					name: '浏览量',
					pointInterval: 24 * 3600 * 800,
					pointStart: Date.UTC(2016, 05, 01), //从6月1号开始算起
					data: data[0]
				}, {
					name: '访客数',
					data: data[1],
					pointInterval: 24 * 3600 * 800,
					pointStart: Date.UTC(2016, 05, 01) //从6月1号开始算起
				}]
			});
			stockPc.render();
		});
	});
	
	//按小时统计
	$('.traffic-analysis-pc .btn-hour').on('click',function(){
		$.getJSON('assets/json/stock-dataArr.json', function(data) {
			$('.traffic-analysis-pc .btn-day').toggleClass('active');
			$('.traffic-analysis-pc .btn-hour').toggleClass('active');
			$('#line-chart-pc').empty();
			stockPc = new AStock({
				theme: AChart.Theme.Base,
				id: 'line-chart-pc',
				width: canvasWidth,
				height: canvasHeight,
				plotCfg: {
					margin: [60, 50, 60, 50] //画板的边距
				},
				xAxis: { //格式化时间
					type: 'time',
					labels: {
						label: {
							'font-size': '10'
						}
					},
					formatter: function(value) {
						return Chart.Date.format(new Date(value), 'yyyy-mm-dd:HH');
					},
					animate: false
				},
				yAxis: {
					animate: false
				},
				xTickCounts: [1, 8], //设置x轴tick最小数目和最大数目 
				seriesOptions: { //设置多个序列共同的属性
					lineCfg: { //如果数据序列未指定类型，则默认为指定了xxCfg的类型，否则都默认是line
						markers: {
							single: true
						},
						animate: false,
						line: {
							'stroke-width': 1
						},
						lineActived: {
							'stroke-width': 1
						}
					}
				},
				tooltip: {
					valueSuffix: ''
				},
				series: [{
					name: '浏览量',
					pointInterval: 3600 * 700,
					pointStart: Date.UTC(2016, 05, 00, 16), //从6月1号0点开始算起
					data: data[0]
				}, {
					name: '访客数',
					data: data[1],
					pointInterval: 3600 * 700,
					pointStart: Date.UTC(2016, 05, 00, 16) //从6月1号0点开始算起
				}]
			});
			stockPc.render();
		});
	});
	
	/* 
	 * @最近7天数据 -- PC
	 */
	var json1 = { //图表中数值
		"name": "百分比",
		"data": [
			['自动帐篷户外装备用品1111', 51.67],
			['户外地垫野餐垫爬行垫1111', 6.09],
			['骆驼自动帐篷户外多人1111', 7.21],
			['特价速开自动帐篷户外1111', 6.09],
			['正品户外12LED野营照1111', 3.93],
			['户外地垫双人特大地席1111', 2.92],
			['户外单人双人拼接睡垫1111', 1.85],
			['正品户外12LED野营照1111', 1.13],
			['特价速开自动帐篷户外1111', 1.01],
			['其他', 18.1]
		]
	}
	var json2 = {
		"name": "百分比",
		"data": [
			['重庆', 51.67],
			['江苏', 6.09],
			['浙江', 7.21],
			['上海', 6.09],
			['四川', 3.93],
			['广东', 2.92],
			['山东', 1.85],
			['北京', 1.13],
			['河南', 1.01],
			['其他', 18.1]
		]
	}
	var graphicalWidth = $('.graphical_1').width(),
		graphicalHeight = graphicalWidth * 0.5;
	var chart1 = new AChart({
		theme: AChart.Theme.SmoothBase,
		id: 'recent-pc1',
		width: graphicalWidth,
		height: graphicalHeight,
		legend: null, //不显示图例
		seriesOptions: { //设置多个序列共同的属性
			pieCfg: {
				allowPointSelect: true,
				labels: {
					distance: 20, //文本距离圆的距离
					label: {
						//文本信息可以在此配置
					},
					renderer: function(value, item) { //格式化文本
						return value + ' ' + (item.point.percent * 100).toFixed(2) + '%';
					}
				},
				innerSize: '50%' //内部的圆，留作空白
			}
		},
		tooltip: {
			pointRenderer: function(point) {
				return (point.percent * 100).toFixed(2) + '%';
			}
		},
		series: [{
			type: 'pie',
			name: json1.name,
			data: json1.data
		}]
	});
	var chart2 = new AChart({
		theme: AChart.Theme.SmoothBase,
		id: 'recent-pc2',
		width: graphicalWidth,
		height: graphicalHeight,
		legend: null, //不显示图例
		seriesOptions: { //设置多个序列共同的属性
			pieCfg: {
				allowPointSelect: true,
				labels: {
					distance: 20, //文本距离圆的距离
					label: {
						//文本信息可以在此配置
					},
					renderer: function(value, item) { //格式化文本
						return value + ' ' + (item.point.percent * 100).toFixed(2) + '%';
					}
				},
				innerSize: '50%' //内部的圆，留作空白
			}
		},
		tooltip: {
			pointRenderer: function(point) {
				return (point.percent * 100).toFixed(2) + '%';
			}
		},
		series: [{
			type: 'pie',
			name: json2.name,
			data: json2.data
		}]
	});
	
	
	chart1.render();
	chart2.render();
	appendItem(json1,'.traffic-analysis-pc .recent .recent-item1');
	appendItem(json2,'.traffic-analysis-pc .recent .recent-item2');
	graphicalCol('.traffic-analysis-pc .recent-item1 .graphical_col');
	graphicalCol('.traffic-analysis-pc .recent-item2 .graphical_col');
	
	
	
	/*
	 * @流量统计折线图 -- mobile
	 */
	var stockMobile = null,
		initMobile = false; //移动端折现图是否初始化完成
	
	//按天统计
	$('.traffic-analysis-mobile .btn-day').on('click',function(){
		$.getJSON('assets/json/stock-dataArr.json', function(data) {
			$('.traffic-analysis-mobile .btn-day').toggleClass('active');
			$('.traffic-analysis-mobile .btn-hour').toggleClass('active');
			$('#line-chart-mobile').empty();
			stockMobile = new AStock({
				theme: AChart.Theme.Base,
				id: 'line-chart-mobile',
				width: canvasWidth,
				height: canvasHeight,
				plotCfg: {
					margin: [60, 50, 60, 50] //画板的边距
				},
				xAxis: { //格式化时间
					type: 'time',
					labels: {
						label: {
							'font-size': '10'
						}
					},
					formatter: function(value) {
						return Chart.Date.format(new Date(value), 'yyyy-mm-dd');
					},
					animate: false
				},
				yAxis: {
					animate: false
				},
				xTickCounts: [1, 8], //设置x轴tick最小数目和最大数目 
				seriesOptions: { //设置多个序列共同的属性
					lineCfg: { //如果数据序列未指定类型，则默认为指定了xxCfg的类型，否则都默认是line
						markers: {
							single: true
						},
						animate: false,
						line: {
							'stroke-width': 1
						},
						lineActived: {
							'stroke-width': 1
						}
					}
				},
				tooltip: {
					valueSuffix: ''
				},
				series: [{
					name: '浏览量',
					pointInterval: 24 * 3600 * 800,
					pointStart: Date.UTC(2016, 05, 01), //从6月1号开始算起
					data: data[0]
				}, {
					name: '访客数',
					data: data[1],
					pointInterval: 24 * 3600 * 800,
					pointStart: Date.UTC(2016, 05, 01) //从6月1号开始算起
				}]
			});
			stockMobile.render();
		});
	});
	
	//按小时统计
	$('.traffic-analysis-mobile .btn-hour').on('click',function(){
		$.getJSON('assets/json/stock-dataArr.json', function(data) {
			$('.traffic-analysis-mobile .btn-day').toggleClass('active');
			$('.traffic-analysis-mobile .btn-hour').toggleClass('active');
			$('#line-chart-mobile').empty();
			stockMobile = new AStock({
				theme: AChart.Theme.Base,
				id: 'line-chart-mobile',
				width: canvasWidth,
				height: canvasHeight,
				plotCfg: {
					margin: [60, 50, 60, 50] //画板的边距
				},
				xAxis: { //格式化时间
					type: 'time',
					labels: {
						label: {
							'font-size': '10'
						}
					},
					formatter: function(value) {
						return Chart.Date.format(new Date(value), 'yyyy-mm-dd:HH');
					},
					animate: false
				},
				yAxis: {
					animate: false
				},
				xTickCounts: [1, 8], //设置x轴tick最小数目和最大数目 
				seriesOptions: { //设置多个序列共同的属性
					lineCfg: { //如果数据序列未指定类型，则默认为指定了xxCfg的类型，否则都默认是line
						markers: {
							single: true
						},
						animate: false,
						line: {
							'stroke-width': 1
						},
						lineActived: {
							'stroke-width': 1
						}
					}
				},
				tooltip: {
					valueSuffix: ''
				},
				series: [{
					name: '浏览量',
					pointInterval: 3600 * 700,
					pointStart: Date.UTC(2016, 05, 00, 16), //从6月1号0点开始算起
					data: data[0]
				}, {
					name: '访客数',
					data: data[1],
					pointInterval: 3600 * 700,
					pointStart: Date.UTC(2016, 05, 00, 16) //从6月1号0点开始算起
				}]
			});
			stockMobile.render();
		});
	});
	
	/* 
	 * @最近7天数据 -- mobile
	 */
	var json3 = { //图表中数值
		"name": "百分比",
		"data": [
			['自动帐篷户外装备用品1111', 51.67],
			['户外地垫野餐垫爬行垫1111', 6.09],
			['骆驼自动帐篷户外多人1111', 7.21],
			['特价速开自动帐篷户外1111', 6.09],
			['正品户外12LED野营照1111', 3.93],
			['户外地垫双人特大地席1111', 2.92],
			['户外单人双人拼接睡垫1111', 1.85],
			['正品户外12LED野营照1111', 1.13],
			['特价速开自动帐篷户外1111', 1.01],
			['其他', 18.1]
		]
	}
	var json4 = {
		"name": "百分比",
		"data": [
			['重庆', 51.67],
			['江苏', 6.09],
			['浙江', 7.21],
			['上海', 6.09],
			['四川', 3.93],
			['广东', 2.92],
			['山东', 1.85],
			['北京', 1.13],
			['河南', 1.01],
			['其他', 18.1]
		]
	}
	var chart3 = new AChart({
		theme: AChart.Theme.SmoothBase,
		id: 'recent-mobile1',
		width: graphicalWidth,
		height: graphicalHeight,
		legend: null, //不显示图例
		seriesOptions: { //设置多个序列共同的属性
			pieCfg: {
				allowPointSelect: true,
				labels: {
					distance: 20, //文本距离圆的距离
					label: {
						//文本信息可以在此配置
					},
					renderer: function(value, item) { //格式化文本
						return value + ' ' + (item.point.percent * 100).toFixed(2) + '%';
					}
				},
				innerSize: '50%' //内部的圆，留作空白
			}
		},
		tooltip: {
			pointRenderer: function(point) {
				return (point.percent * 100).toFixed(2) + '%';
			}
		},
		series: [{
			type: 'pie',
			name: json3.name,
			data: json3.data
		}]
	});
	var chart4 = new AChart({
		theme: AChart.Theme.SmoothBase,
		id: 'recent-mobile2',
		width: graphicalWidth,
		height: graphicalHeight,
		legend: null, //不显示图例
		seriesOptions: { //设置多个序列共同的属性
			pieCfg: {
				allowPointSelect: true,
				labels: {
					distance: 20, //文本距离圆的距离
					label: {
						//文本信息可以在此配置
					},
					renderer: function(value, item) { //格式化文本
						return value + ' ' + (item.point.percent * 100).toFixed(2) + '%';
					}
				},
				innerSize: '50%' //内部的圆，留作空白
			}
		},
		tooltip: {
			pointRenderer: function(point) {
				return (point.percent * 100).toFixed(2) + '%';
			}
		},
		series: [{
			type: 'pie',
			name: json4.name,
			data: json4.data
		}]
	});
	


	//切换到移动端统计
	$('.traffic-analysis-pc .btn-mombile').on('click',function(){
		$('.traffic-analysis-pc').toggleClass('hide');
		$('.traffic-analysis-mobile').toggleClass('hide');
		
		if( initMobile ){ return false; }
		
		//初始化流量统计
		$.getJSON('assets/json/stock-dataArr.json', function(data) {
			stockMobile = new AStock({
				theme: AChart.Theme.Base,
				id: 'line-chart-mobile',
				width: canvasWidth,
				height: canvasHeight,
				plotCfg: {
					margin: [60, 50, 60, 50] //画板的边距
				},
				xAxis: { //格式化时间
					type: 'time',
					labels: {
						label: {
							'font-size': '10'
						}
					},
					formatter: function(value) {
						return Chart.Date.format(new Date(value), 'yyyy-mm-dd');
					},
					animate: false
				},
				yAxis: {
					animate: false
				},
				xTickCounts: [1, 8], //设置x轴tick最小数目和最大数目 
				seriesOptions: { //设置多个序列共同的属性
					lineCfg: { //如果数据序列未指定类型，则默认为指定了xxCfg的类型，否则都默认是line
						markers: {
							single: true
						},
						animate: false,
						line: {
							'stroke-width': 1
						},
						lineActived: {
							'stroke-width': 1
						}
					}
				},
				tooltip: {
					valueSuffix: ''
				},
				series: [{
					name: '浏览量',
					pointInterval: 24 * 3600 * 800,
					pointStart: Date.UTC(2016, 05, 01), //从6月1号开始算起
					data: data[0]
				}, {
					name: '访客数',
					data: data[1],
					pointInterval: 24 * 3600 * 800,
					pointStart: Date.UTC(2016, 05, 01) //从6月1号开始算起
				}]
			});
			stockMobile.render();
			chart3.render();
			chart4.render();
			appendItem(json1,'.traffic-analysis-mobile .recent .recent-item1');
			appendItem(json2,'.traffic-analysis-mobile .recent .recent-item2');
			graphicalCol('.traffic-analysis-mobile .recent-item1 .graphical_col');
			graphicalCol('.traffic-analysis-mobile .recent-item2 .graphical_col');
			initMobile = true;
		});
	});
	
	//切换到PC端统计
	$('.traffic-analysis-mobile .btn-pc').on('click',function(){
		$('.traffic-analysis-pc').toggleClass('hide');
		$('.traffic-analysis-mobile').toggleClass('hide');
	});
	
	
});