$(document).ready(function(){
	var $p1 = $('.p1'),
		$p2 = $('.p2'),
		times = 0; //执行次数
	
	//第一页动画
	var pageOne = function(){
		$p1.find('div.v-line:odd').animate({'height': '100%'},800);
        $p1.find('div.h-line:odd').animate({'width': '100%'},800);
        	
        $p1.find('div.v-line:even').delay(400).animate({'height': '100%'},1200);
        $p1.find('div.h-line:even').delay(400).animate({'width': '100%'},1200);
        	
        $p1.find('.h-wrap img').delay(1500).animate({'opacity': 1},400);
        	
        $p1.find('.arrow-wrap .next').delay(1800).animate({'opacity': 1},400);
	}
	
	//第二页动画
	var pageTwo = function(index){
		if(index == 2){
        	if(times >= 1){ return false; }
        	times += 1;
        		
        	//第一部分
        	$p2.find('.v-line .line1').animate({'height': '100%'},300);
        	$p2.find('.h-line .line5').delay(300).animate({'width': '100%'},300);
        	$p2.find('.v-line .line10').delay(600).animate({'height': '100%'},300);
        	$p2.find('.h-line .line6').delay(900).animate({'width': '100%'},300);
        	$p2.find('.rect-wrap .rect1').delay(1200).animate({'opacity': 0.1},300);
        		
        	//第二部分
        	$p2.find('.v-line .line2').delay(800).animate({'height': '100%'},300);
        	$p2.find('.h-line .line1').delay(1100).animate({'width': '100%'},300);
        	$p2.find('.v-line .line9').delay(1400).animate({'height': '100%'},300);
        	$p2.find('.h-line .line10').delay(1700).animate({'width': '100%'},300);
        	$p2.find('.rect-wrap .rect2').delay(2000).animate({'opacity': 0.1},300);
        		
        	//第三部分
        	$p2.find('.v-line .line3').delay(1600).animate({'height': '100%'},300);
        	$p2.find('.h-line .line4').delay(1900).animate({'width': '100%'},300);
        	$p2.find('.v-line .line8').delay(2200).animate({'height': '100%'},300);
        	$p2.find('.h-line .line7').delay(2500).animate({'width': '100%'},300);
        	$p2.find('.rect-wrap .rect3').delay(2800).animate({'opacity': 0.1},300);
        		
        	//第四部分
        	$p2.find('.v-line .line4').delay(2400).animate({'height': '100%'},300);
        	$p2.find('.h-line .line3').delay(2700).animate({'width': '100%'},300);
        	$p2.find('.v-line .line7').delay(3000).animate({'height': '100%'},300);
        	$p2.find('.h-line .line8').delay(3300).animate({'width': '100%'},300);
        	$p2.find('.rect-wrap .rect4').delay(3600).animate({'opacity': 0.1},300);
        		
        		
        	//第五部分
        	$p2.find('.v-line .line5').delay(3200).animate({'height': '100%'},300);
        	$p2.find('.h-line .line2').delay(3500).animate({'width': '100%'},300);
        	$p2.find('.v-line .line6').delay(3800).animate({'height': '100%'},300);
        	$p2.find('.h-line .line9').delay(4100).animate({'width': '100%'},300);
        	$p2.find('.rect-wrap .rect5').delay(4400).animate({'opacity': 0.1},300);
        }
	}
	
	$('#main').fullpage({
		onLeave: function(index, nextIndex, direction){},
        afterLoad: function(anchorLink, index){
        	pageTwo(index);
        },
        afterRender: function(){
        	pageOne();
        },
        afterResize: function(){},
        afterSlideLoad: function(anchorLink, index, slideAnchor, slideIndex){},
        onSlideLeave: function(anchorLink, index, slideIndex, direction, nextSlideIndex){}
	});
	
	$('a.next').on('click',function(){
		$.fn.fullpage.moveSectionDown();
	});
	
});