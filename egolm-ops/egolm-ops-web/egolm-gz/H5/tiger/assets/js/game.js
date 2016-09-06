$(document).ready(function(){
	var $indexWrap = $('.index-wrap'),
		$gameWrap = $('.game-wrap'),
		$popupWrap = $('.popup-wrap'),
		$num = $gameWrap.find('.num'),
		remSize = parseFloat($('html').css('font-size')),
		numHeight = remSize * (136/28), //抽奖框高度
		Game = {
			isBegin: false, //是否正在抽奖
			times: 3, //可抽奖次数
			upperLimit: 999, //上限
			lowLimit: 111, //下限
			anInterval: 300, //单个动画开始间隔
			baseDuration: 6000, //动画持续时间基础数值
			increaseDuration: 3000, //动画持续时间递增数值
			numCount: 60, //转过的数字基础个数（减去随机到的数字得到正确的位置）
			//事件绑定
			bind: function(){
				
				//参与游戏
				$indexWrap.find('.btn-join').on('tap',function(){
					$indexWrap.addClass('hide');
					$gameWrap.removeClass('hide');
				});
				
				//开始抽奖
				$gameWrap.find('.btn-start').on('tap',function(){
					if(Game.isBegin){ return false; }
					if(Game.times <= 0){ alert('没有次数啦！'); return false; }
					Game.isBegin = true;
					Game.setTimes();
					Game.numAnimation(Game.showResult);
				});
				
				//关闭弹窗
				$popupWrap.find('.btn-close').on('tap',function(){
					$popupWrap.addClass('hide');
				});
			},
			//随机数生成
			numRand: function() {
				var rand = parseInt(Math.random() * (this.upperLimit - this.lowLimit + 1) + this.lowLimit);
				return rand;
			},
			//抽奖动画
			numAnimation: function(callback){
				var result = this.numRand(),
					numArr = (result+'').split(''),
					animationTime = 0;
				$num.removeAttr('style').each(function(index){
					var _this = $(this);
					if(index == 2){ animationTime += (Game.baseDuration + index * Game.increaseDuration + index * Game.anInterval); }
					setTimeout(function(){
						var num = parseInt(numArr[index]),
							offset = Game.getOffset(num);
//							console.log('偏移：' + offset + 'px');
						_this.css({'transition-duration': (Game.baseDuration/1000 + index * (Game.increaseDuration/1000)) + 's', 'backgroundPositionY': (numHeight * (Game.numCount - num)) + (offset/28*remSize) });
					}, index * Game.anInterval)
				});
				setTimeout(function(){
					callback && callback(result);
				},animationTime);
			},
			//设置可抽奖次数
			setTimes: function(){
				Game.times--;
				$gameWrap.find('.times').text(Game.times);
			},
			//显示抽奖弹窗
			showResult: function(result){
				Game.isBegin = false;
				$popupWrap.removeClass('hide');
				console.log('抽奖结果：' + result);
			},
			//rem位置偏差修正
			getOffset: function(num){
				var offset = 0;
				switch(num){
					case 0:
						offset = -1.5;
						break;
					case 2:
						offset = 1;
						break;
					case 3:
					case 4:
						offset = num;
						break;
					case 5:
					case 6:
						offset = num + 1;
						break;
					case 7:
					case 8:
					case 9:
						offset = num + 2;
						break;
				}
				return offset;
			},
			//初始化
			init: function(){
				$gameWrap.find('.times').text(Game.times);
				this.bind();
			}
		}
		
	Game.init();
})
