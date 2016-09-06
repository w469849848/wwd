jQuery(function($) {

	var canvasWidth = $('.sChart').width(),
		canvasHeight = 500;

	var chart = new AChart({
		theme: AChart.Theme.SmoothBase,
		id: 'canvas',
		width: canvasWidth,
		height: 500,
		plotCfg: {
			margin: [50, 50, 80] //画板的边距
		},
		xAxis: { //x轴坐标数据
			categories: ['A', 'B', 'C', 'D', 'E', 'F',
				'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T'
			]
		},
		yAxis: [{
			position: 'left',
		}, {
			type: 'number',
			position: 'right',
			line: null,
			tickLine: null,
			labels: {
				label: {
					x: 12
				}
			},
			title: {
				text: '',
				x: 40,
				rotate: 90
			}
		}],
		seriesOptions: { //设置多个序列共同的属性
			lineCfg: { //不同类型的图对应不同的共用属性，lineCfg,areaCfg,columnCfg等，type + Cfg 标示
				smooth: true
			}
		},
		series: [{ //柱状图数据
			name: 'AAA',
			color: '#ff8940',
			type: 'column',
			yAxis: 1,
			data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 195.6, 154.4, 160, 120, 140, 170, 200, 170, 183, 190],
			suffix: ' mm'
		}, { //曲线图1
			name: 'BBB',
			color: '#69D54E',
			type: 'line',
			data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6, 10, 11, 11.5, 13, 14.5, 15.1, 16, 15.5],
			suffix: '°C'
		}, { //曲线图2
			name: 'CCC',
			color: '#FFE57C',
			type: 'line',
			data: [6.0, 8, 7, 8, 9, 10.5, 11.4, 9.5, 14, 16, 17.5, 19, 20, 18, 16, 20, 16, 14, 11, 9],
			suffix: '°C'
		}]
	});
	
	//报表初始化
	chart.render();
});