/********************************图表样式*******************************/

jQuery(function($) {
				var graphicalWidth = $('.detail-section').width();
					graphicalHeihht = 350;

			

				var json1 = {                              //图表中数值
					"name":"data1",
					"data": [
							['1.5-2.5', 60.2],
							['2.5-3.5', 15.8], 
							['5.5-6.5',8.5],
							['3.5-4.5', 4.5],
							['4.5-5.5', 7.5],
							['5.5-6.5', 4.5],
							['6.5-7.5', 5.6]
						]
				}

				var json2 = {
					"name":"data2",
					"data": [
							['1.5-2.5', 60.2],
							['2.5-3.5', 15.8],
							['5.5-6.5',8.5],
							['3.5-4.5', 4.5],
							['4.5-5.5', 7.5],
							['5.5-6.5', 4.5],
							['6.5-7.5', 5.6]
						]
				}

				function graphicalCol() {
				var graphical_color = document.getElementsByClassName("graphical_col");
				var graphicalColor = ["#FF6400", "#FECD06", "#61c681", "#74D1DB", "#2B7AB9", "#EBEBEB","red"],
					colorIndex = 0;
					for (var i = 0; i < graphical_color.length; i++) {
						if(colorIndex == graphicalColor.length - 1){ 
							colorIndex = 0; 
						}
					 	graphical_color[i].style.backgroundColor = graphicalColor[colorIndex];
					 	colorIndex++;
					 } 
				}

				 graphicalCol();


				var chart1 = new AChart({
					theme: AChart.Theme.SmoothBase,
					id: 'canvas1',
					width: graphicalWidth,
					height: graphicalHeihht,
					legend: null, //不显示图例
					seriesOptions: { //设置多个序列共同的属性
						pieCfg: {
							allowPointSelect: true,
							labels: {
								distance: 40, //文本距离圆的距离
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
					id: 'canvas2',
					width: graphicalWidth,
					height: graphicalHeihht,
					legend: null, //不显示图例
					seriesOptions: { //设置多个序列共同的属性
						pieCfg: {
							allowPointSelect: true,
							labels: {
								distance: 40, //文本距离圆的距离
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
			});