$(document).ready(function() {
	var doc = document,
		canvas = doc.getElementById('canvas'),
		ctx = canvas.getContext('2d'),
		$gameBox = $('#gameBox'),
		$gameWrap = $('.game-box'),
		$lis = $gameBox.find('li'),
		liWidth = $lis.width(), //可移动元素的宽度
		liHeight = $lis.height(), //可移动元素的高度
		thisLeft = 0, //当前移动元素的横向偏移距离
		thisTop = 0, //当前移动元素的纵向偏移距离
		startX = 0, //开始移动时的坐标（X轴）
		startY = 0, //开始移动时的坐标（Y轴）
		moveX = 0, //手指移动的距离（X轴）
		moveY = 0, //手指移动的距离（Y轴）
		index = 0, //当前移动元素下标
		$prev = null, //当前移动元素相邻的左边元素
		$next = null, //当前移动元素相邻的右边元素
		$up = null, //当前移动元素相邻的上边元素
		$down = null, //当前移动元素相邻的下边元素
		$this = null, // 当前移动元素
		prevLeft = 0, //相邻的左边元素的横向偏移距离
		nextLeft = 0, //相邻的右边元素的横向偏移距离
		upTop = 0, //相邻的上边元素的横向偏移距离
		downTop = 0, //相邻的下边元素的横向偏移距离
		image = new Image(),
		oriArr = [1, 2, 3, 4, 5, 6, 7, 8, 9],
		imgArr = [1, 2, 3, 4, 5, 6, 7, 8, 9],
		Game = {
			timeHandle: null,
			isComplete: false,
			level: 0,
			direction: '',
			levels: [{
				time: "10.00",
				image: "assets/images/shulan.jpg"
			 }
			  //{
			// 	time: "40.00",
			// 	image: "assets/images/tuzi.jpg"
			// }, {
			// 	time: "30.00",
			// 	image: "assets/images/together.jpg"
			// }
			],
			bind: function() {
				
				//防止向下拖动页面
				$('body').on('touchstart', function(e) {
					e.preventDefault();
				});
				
				$lis.on('touchstart',function(e){
					$this = $(this);
					startX = e.touches[0].clientX;
					startY = e.touches[0].clientY;
					thisLeft = parseInt($this.css('left'));
					thisTop = parseInt($this.css('top'));
					index = $this.index();
					$prev = $this.prev() || null;
					$next = $this.next() || null;
					$down = $lis.eq(index + 3) || null;
					$up = $lis.eq(index - 3) || null;
					nextLeft = parseInt($next.css('left')) || 0;
					prevLeft = parseInt($prev.css('left')) || 0;
					upTop = parseInt($up.css('top')) || 0;
					downTop = parseInt($down.css('top')) || 0;
				});
				
				$lis.on('touchmove',function(e){
					moveX = e.touches[0].clientX - startX;
					moveY = e.touches[0].clientY - startY;
					var top = Math.abs(Math.abs(moveY) <= liHeight ? moveY : liHeight),
						left = Math.abs(Math.abs(moveX) <= liWidth ? moveX : liWidth);
						
					$this.css({'z-index': 999}).siblings().css({'z-index': 1});
					switch(true){
						//向上
						case moveY < 0 && Math.abs(moveX) < Math.abs(moveY):
							if(index > 2){
								Game.direction = 'up';
								$this.css({'left': thisLeft, 'top': thisTop - top});
								if(top == liHeight){
									$up.css({'left': thisLeft, 'top': thisTop});
									$this.trigger('touchend');
								}
							}
							break;
						//向下
						case moveY > 0 && Math.abs(moveX) < Math.abs(moveY):
							if(index < 6){
								Game.direction = 'down';
								$this.css({'left': thisLeft, 'top': thisTop + top});
								if(top == liHeight){
									$down.css({'left': thisLeft, 'top': thisTop});
									$this.trigger('touchend');
								}
							}
							break;
						//向左
						case moveX < 0 && Math.abs(moveX) > Math.abs(moveY):
							if(index != 0 && index != 3 && index != 6){
								Game.direction = 'left';
								$this.css({'left': thisLeft - left, 'top': thisTop});
								if(left == liWidth){
									$prev.css({'left': thisLeft, 'top': thisTop});
									$this.trigger('touchend');
								}
							}
							break;
						//向右
						case moveX > 0 && Math.abs(moveX) > Math.abs(moveY):
							if(index != 2 && index != 5 && index != 8){
								Game.direction = 'right';
								$this.css({'left': thisLeft + left, 'top': thisTop});
								if(left == liWidth){
									$next.css({'left': thisLeft, 'top': thisTop});
									$this.trigger('touchend');
								}
							}
							break;
						//default
					}
				});
				
				$lis.on('touchend',function(e){
					switch(true){
						case Game.direction == 'left':
							if(moveX < -40){
								Game.swipeLeft(this);
								$prev.css({'left': prevLeft});
							}
							$this.css({'left': thisLeft});
							break;
						case Game.direction == 'right':
							if(moveX > 40){
								Game.swipeRight(this);
								$next.css({'left': nextLeft});
							}
							$this.css({'left': thisLeft});
							break;
						case Game.direction == 'up':
							if(moveY < -40){
								Game.swipeUp(this);
								$up.css({'top': upTop});
							}
							$this.css({'top': thisTop});
							break;
						case Game.direction == 'down':
							if(moveY > 40){
								Game.swipeDown(this);
								$down.css({'top': downTop});
							}
							$this.css({'top': thisTop});
							break;
					}
				});
				
				//游戏开始事件绑定
				$('#start').on('tap', function() {
					$('#reset').prop('disabled', false);
					//再来一次的时候 顺序不变哦
					if($(this).html() !== '再来一次') {
						Game.randomImage(true);
					} else {
						Game.randomImage();
					}
					Game.resetData();
					Game.countdown();
					$('#layer').hide();
				});
				
				//重新开始游戏事件绑定
				$('#reset').on('tap', function() {
					if( $(this).prop('disabled') ){ return false; }
					Game.resetData();
					Game.countdown();
					Game.randomImage(true);
				});
			},
			
			//向左
			swipeLeft: function(elem){
				var $this = $(elem),
					index = $this.index(),
					html = $this.html(),
					$prev = $this.prev();
					
				if($.inArray(index, [3, 6]) > -1 || $prev.size() <= 0) {
					return false;
				}
				$this.html($prev.html());
				$prev.html(html);
				Game.check();
			},
				
			//向右
			swipeRight: function(elem){
				var $this = $(elem),
					index = $this.index(),
					html = $this.html(),
					$next = $this.next();
					
				if($.inArray(index, [2, 5]) > -1 || $next.size() <= 0) {
					return false;
				}
				$this.html($next.html());
				$next.html(html);
				Game.check();
			},
				
			//向上
			swipeUp: function(elem){
				var $this = $(elem),
					html = $this.html(),
					index = $this.index() - 3,
					$up = $lis.eq(index);
					
				if(index >= 0 && $up.size() > 0) {
					$this.html($up.html());
					$up.html(html);
					Game.check();
				}
			},
			
			//向下
			swipeDown: function(elem){
				var $this = $(elem),
					html = $this.html(),
					index = $this.index() + 3,
					$down = $lis.eq(index);
						
				if(index < 9 && $down.size() > 0) {
					$this.html($down.html());
					$down.html(html);
					Game.check();
				}
			},
			
			//计时器
			countdown: function() {
				clearInterval(this.timeHandle);
				this.timeHandle = setInterval(function() {
					var $time = $('#timing'),
						time = parseFloat($time.text()),
						currTime = (time - 0.01).toFixed(2);
						
					if(currTime < 0) {
						clearInterval(Game.timeHandle);
						$time.text(parseInt(currTime).toFixed(2));
						Game.update();
					} else {
						$time.text(currTime);
					}
				}, 10);
			},
			
			//重置游戏数据
			resetData: function() {
				var time = this.levels[this.level].time;
				$('#timing').text(time);
				$('#time').text(time);
				$('#level').text(this.level + 1);
				$('#levels').text(this.levels.length);
			},
			
			//初始化
			init: function() {
				$('#reset').prop('disabled', true);
				this.resetData();
				imgArr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
				this.render();
			},
			render: function() {
				image.onload = function() {
					Game.randomImage();
				}
				image.src = this.levels[this.level].image;
			},
			
			//打乱图片
			randomImage: function(flag) {
				flag = flag || false;
				if(flag) {
					imgArr.sort(function(a, b) {
						return Math.random() - Math.random();
					});
				}
				var index = 1;
				for(var i = 0; i < 3; i++) {
					for(var j = 0; j < 3; j++) {
						ctx.drawImage(image, 300 * j, 300 * i, 300, 300, 0, 0, 300, 300);
						$lis.eq(imgArr[index - 1] - 1).find('img').data('seq', index).attr('src', canvas.toDataURL('image/jpeg'));
						index++;
					}
				}
			},
			
			//检测是否完成拼图
			check: function() {
				var resArr = [];
				$('#gameBox img').each(function(k, v) {
					resArr.push(v.getAttribute("data-seq"));
				});
				if(resArr.join("") === oriArr.join("")) {
					setTimeout(function() {
						//Game.isComplete = true;
						window.clearInterval(Game.timeHandle);
						if(Game.level >= Game.levels.length - 1) {
							alert("哇塞,你居然通关了,好棒!");
							Game.destory();
						// } else {
						// 	if(confirm("恭喜过关,是否继续挑战?")) {
						// 		Game.level++;
						// 		$('#layer').show();
						// 		Game.init();
						// 	}
						}
					}, 300);
				}
			},
			update: function() {
				if(this.isComplete === false) {
					alert("时间到,游戏结束!");
					$('#layer').show();
					$('#start').html("再来一次");
					$('#reset').prop('disabled', true);
				}
			},
			destory: function() {
				$('#reset').prop('disabled', true);
				$lis.off("swipeLeft");
				$lis.off("swipeRight");
				$lis.off("swipeUp");
				$lis.off("swipeDown");
				$lis.css('border', 0);
				$gameBox.css('border', 0);
			},
			start: function() {
				this.init();
				this.render();
				this.bind();
			},
		};
	
	//游戏开始
	Game.start();

});
