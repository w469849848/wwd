"use strict";
var Insect = (function(c) {
	c.util = {
		
		//置顶
		backTop:function(btnId){
			var btn = document.getElementById(btnId);
		    var d = document.documentElement;
		    var b = document.body;
		    window.onscroll = set;
		    btn.style.display = "none";
		    $(btn).on('tap',function(e){
		    	e.preventDefault();
		    	btn.style.display = "none";
		        window.onscroll = null;
		        this.timer = setInterval(function() {
		            d.scrollTop -= Math.ceil((d.scrollTop + b.scrollTop) * 0.1);
		            b.scrollTop -= Math.ceil((d.scrollTop + b.scrollTop) * 0.1);
		            if ((d.scrollTop + b.scrollTop) == 0) clearInterval(btn.timer, window.onscroll = set);
		        }, 10);
		    })
		    function set() {
		        btn.style.display = (d.scrollTop + b.scrollTop > 100) ? 'block': "none"
		    }
		},
		
		//选项卡
		tab: function(config) {
			var target = config.target, //目标选项卡片
				controller = config.controller, //触发器
				currentClass= config && config.currentClass ? config.currentClass : "cur";
		    target.each(function() {
		        $(this).children().eq(0).css('display','block');
		    });
		    controller.each(function() {
		        $(this).children().eq(0).addClass(currentClass);
		    });
		    controller.children().on('tap', function(e){
		    	e.preventDefault();
		        $(this).addClass(currentClass).siblings().removeClass(currentClass);
		        var index = controller.children().index(this);
		        target.children().eq(index).css('display','block').siblings().css('display','none');
		    });
		},
		imageSize:function(obj){
			var screenImage = $(obj),
		        theImage = new Image(),
		        imageWidth,
		        screenWidth=$(window).width();
			for(var i=0;i<screenImage.length;i++){
				theImage.src = screenImage.eq(i).attr("src");
		   		imageWidth =theImage.width;
		   		if(imageWidth<screenWidth){
		   			screenImage.eq(i).css({"width":imageWidth+'px'});
		   		}
			}
		},
		getArray:function(array){ //数组去重
			var hash = {},
			    len = array.length,
			    result = [];
			
			for (var i = 0; i < len; i++){
			    if (!hash[array[i]]){
			        hash[array[i]] = true;
			        result.push(array[i]);
			    } 
			}
			 return result;
		},
		patternString:function (filterString,string){
		        var s,len,res,rule,str = string.toString(),filter = filterString.toString();
		        if(filterString instanceof Array && string instanceof Array){
		            try{
		                res = false;
		                len = filterString.length;
		                for(var i = 0;i<len;i++){
		                    rule = new RegExp(filterString[i]);
		                    s = rule.test(string[i]);
		                    res = (res || s);
		                }
		            }catch(e){
		                e.message();
		            }
		        }else{
		          	var r = new RegExp(filterString),
		            	rule = r.test(string),
		            	res = rule;
		        }
		        return res;
		},
		isScrolledBottom: function() {
			var scrollTop = 0,
				clientHeight = 0,
				scrollHeight = 0;
			if (document.documentElement && document.documentElement.scrollTop) {
				scrollTop = document.documentElement.scrollTop
			} else {
				if (document.body) {
					scrollTop = document.body.scrollTop
				}
			} if (document.body.clientHeight && document.documentElement.clientHeight) {
				clientHeight = (document.body.clientHeight < document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight
			} else {
				clientHeight = (document.body.clientHeight > document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight
			}
			scrollHeight = Math.max(document.body.scrollHeight, document.documentElement.scrollHeight);
			if (scrollTop + clientHeight >= scrollHeight-40) {
				return true
			} else {
				return false
			}
		},
		visible: function(obj) {
			if ($(obj).offset().top < ($(window).height() + $("body").scrollTop()) && (($(window).height() + $("body").scrollTop()) - $(obj).offset().top) < $(window).height()) {
				return true
			} else {
				return false
			}
		},
		pageLoad:{//elem:选择器,txt:文本
			show:function(config){
				$("body").bind("touchmove tap", function(event) {
				   event.preventDefault()
				}, false); 
				var elem= (config && config.elem ? config.elem : $('body')),
					txt=(config && config.txt ? config.txt : '正在加载'),
					pageload=$('#pageload');
				if(pageload.length){
					pageload.remove();
				}
	            elem.append('<div id="pageload" class="fixed_full"><div class="box-ct"><div class="box-bd"><div><div class="cm-loading-spinner"><span class="loading-top"></span><span class="loading-right"></span><span class="loading-bottom"></span><span class="loading-left"></span></div> <div class="msg">'+txt+'</div></div></div></div></div>');
			},
			remove:function(){
				$("body").unbind("touchmove");
				$('#pageload').remove();
			}
        },  
		stopPropagation: function(e) {
			if (e && e.stopPropagation) {
				e.stopPropagation()
			} else {
				window.event.cancelBubble = true
			}
		},
		request: function(name) {
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
			var r = window.location.search.substr(1).match(reg);
			if (r != null) {
				return unescape(r[2])
			}
			return ""
		},
		goBack: function(href) {
			history.back()
		},
		alertBox: function(txt, callback, config) {
			var time = (config && config.time ? config.time : 2000);
			if ($("#_alert_bg").length) {
				$("#_alert_bg").show()
			} else {
				var _d = document;
				var _alert_bg = _d.createElement("div");
				_alert_bg.setAttribute("id", "_alert_bg");
				_d.body.appendChild(_alert_bg);
				var _alert_content = _d.createElement("div");
				_alert_content.setAttribute("id", "_alert_content");
				_alert_bg.appendChild(_alert_content)
			}
			var _this = $("#_alert_content");
			_this.html(txt).show();
			setTimeout(function() {
				$("#_alert_bg").hide();
				callback && callback()
			}, time)
		},
		popup:function(config){
			var elem=config.elem,
				move=(config && config.move ? config.move : false),
        	    state=elem.data('state');
        	if(state){
        		elem.css('display','block');
        		elem.data('state','false');
        		if(move){
        			$("body").bind("touchmove", function(event) {
						event.preventDefault()
					}, false); 
        		}
        		
        	}else{
        		elem.css('display','none');
        		elem.data('state','true');
        		if(move){
        			$("body").unbind("touchmove");
        		}
        	}
		},
		masking: function(json) {
			if ($("#maskContainer").length) {
				$("#maskBackground,#maskContainer").remove();
				return false
			}
			if (json) {
				json = json || {};
				json.isNeedMask = json.isNeedMask || true;
				json.opacity = json.opacity || 0.5;
				json.html = json.html || "";
				json.disappearTime = json.disappearTime || 0;
				json.isClickDisappear = json.isClickDisappear || true;
				var maskObj = null;
				if (json.isNeedMask) {
					var maxHeight = ($(window).height() > $(document).height() ? $(window).height() : $(document).height());
					maskObj = $('<div id="maskBackground" style="z-index:999;opacity:' + json.opacity + ";height:" + maxHeight + 'px;width:100%;top:0;left:0;position:fixed;background:#000;"></div>');
					$("body").append(maskObj);
				}
				var maskContent = $('<div id="maskContainer" style="position: fixed;z-index:99999;"></div>');
				maskContent.append(json.html);
				$("body").append(maskContent);
				json.top = (typeof json.top == "undefined" ? (($(window).height() - maskContent.height()) / 2) : json.top);
				json.left = (typeof json.left == "undefined" ? (($(window).width() - maskContent.width()) / 2) : json.left);
				maskContent.css({
					top: json.top,
					left: json.left
				});
				if (json.disappearTime) {
					setTimeout(function() {
						maskObj.remove();
						maskContent.remove()
					}, json.disappearTime)
				}
			}
			
		},
		scrollBottom: function() {
			var totalheight = parseFloat($(window).height()) + parseFloat($(window).scrollTop());
			if (($(document).height() - 80) <= totalheight) {
				return true
			}
		},
		imgScrollRequest: function(obj) {
			if( $(obj).length == 0 ){ return }
			var flag = typeof(arguments[1]) != "undefined" ? arguments[1] : false;
			$(obj).each(function() {
				var $this = $(this);
				if ($this.attr("data-src")) {
					if (flag) {
						$this.attr("src", $this.removeClass('lazy').attr("data-src")).removeAttr("data-src");
						return
					}
					if (Insect.util.visible($this)) {
						$this.attr("src", $this.removeClass('lazy').attr("data-src")).removeAttr("data-src")
					}
				}
			})
		},
		tipsImg:function(obj){
			$('body').append('<section class="tipsImg hide" data-state="true" onclick="Insect.util.tipsImg(this)"><div id="banner" class="swipe"><ul class="swipe-wrap"></ul><ul id="indicator"></ul></div></section>');
			var tipsImg=$(".tipsImg");
	    	if(tipsImg.data('state')){
	    		var img=$(obj).parent().data('img'),
	    			idx=$(obj).index(),
	    			indicator='',
	    			list='';
				
	    		for (var i=0;i<img.length;i++){
	    			list +='<li class="box box-center"><img src="../images/default.jpg" data-src="'+img[i]+'"  alt="" /></li>';
	    			if(i==0){
	    				indicator +='<li class="active">1</li>';
	    			}else{
	    				indicator +='<li>1</li>';
	    			}
				}
	    		tipsImg.find('.swipe-wrap').html(list);
	    		tipsImg.find('#indicator').html(indicator);
	    		tipsImg.show();	
				$("body").bind("touchmove", function(event) {
					event.preventDefault()
				}, false);
				var banner = document.getElementById('banner'),
		    		fristimg=$('#banner li').eq(0).find('img');
				fristimg.attr('src',fristimg.attr('data-src'));
				window.slide=InsectSlide(banner, {
					callback: function(index, element) {
						var currimg=$('#banner li').eq(index).find('img');
						currimg.attr('src',currimg.attr('data-src'));
						$('#indicator li').eq(index).addClass('active').siblings().removeClass('active');
					}
				});
				slide.slide(idx,1);
				tipsImg.data('state',false);
				
	    	}else{
	    		tipsImg.remove().hide().data('state',true);
	    		$("body").unbind("touchmove");
	    	}
		}
	};
	c.localData = {
		hname: location.hostname ? location.hostname : "localStatus",
		isLocalStorage: window.localStorage ? true : false,
		dataDom: null,
		initDom: function() {
			if (!this.dataDom) {
				try {
					this.dataDom = document.createElement("input");
					this.dataDom.type = "hidden";
					this.dataDom.style.display = "none";
					this.dataDom.addBehavior("#default#userData");
					document.body.appendChild(this.dataDom);
					var exDate = new Date();
					exDate = exDate.getDate() + 30;
					this.dataDom.expires = exDate.toUTCString()
				} catch (ex) {
					return false
				}
			}
			return true
		},
		set: function(key, value) {
			if (this.isLocalStorage) {
				window.localStorage.setItem(key, value)
			} else {
				if (this.initDom()) {
					this.dataDom.load(this.hname);
					this.dataDom.setAttribute(key, value);
					this.dataDom.save(this.hname)
				}
			}
		},
		get: function(key) {
			if (this.isLocalStorage) {
				return window.localStorage.getItem(key)
			} else {
				if (this.initDom()) {
					this.dataDom.load(this.hname);
					return this.dataDom.getAttribute(key)
				}
			}
		},
		remove: function(key) {
			if (this.isLocalStorage) {
				localStorage.removeItem(key)
			} else {
				if (this.initDom()) {
					this.dataDom.load(this.hname);
					this.dataDom.removeAttribute(key);
					this.dataDom.save(this.hname)
				}
			}
		}
		
	};
	c.cookie = {
		get: function(key) {
			try {
				var arr = document.cookie.match(new RegExp("(^| )" + key + "=([^;]*)(;|$)"));
				if (arr != null) {
					return decodeURIComponent(arr[2])
				}
			} catch (e) {}
			return null
		},
		set: function(key, value, date, domain) {
			try {
				domain = domain ? (';domain=' + domain) : '';
				var Days = date ? date * 1000 : 60 * 1000;
				var exp = new Date();
				exp.setTime(exp.getTime() + Days);
				document.cookie = key + "=" + encodeURIComponent(value) + domain + ";expires=" + exp.toGMTString() + ";path=/"
			} catch (e) {}
		},
		remove: function(key, domain) {
			this.set(key, "", -24 * 60 * 60, domain)
		}
	};
	c.net = {
		loadScript: function(url, args, callback) {
			var params = "";
			args = args || {};
			args.randomtime = Math.random();
			if (args && (typeof args === "object")) {
				var paramArr = [];
				for (var i in args) {
					paramArr.push(i + "=" + args[i])
				}
				params = paramArr.join("&")
			}
			var script = document.createElement("script");
			script.type = "text/javascript";
			script.src = url + (url.indexOf("?") <= -1 ? "?" : "&") + params;
			script.onload = script.onreadystatechange = function() {
				if (!this.readyState || (this.readyState == "complete" || this.readyState == "loaded")) {
					callback && callback();
					script.onreadystatechange = script.onload = null;
					script = null;
//                  $("#_alert_bg").hide();//隐藏浮尘
				}
			};
			document.getElementsByTagName("head")[0].appendChild(script)
		}
	};
	c.device = {
		isAndriod: /android/i.test(window.navigator.userAgent),
		isIphone: /iphone/i.test(window.navigator.userAgent),
		isIpad: /ipad/i.test(window.navigator.userAgent),
		isPC:function(){ //判断是否PC
			var userAgentInfo = navigator.userAgent; 
	        var Agents = new Array("Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"); 
	        var flag = true; 
	        for (var v = 0; v < Agents.length; v++) { 
	            if (userAgentInfo.indexOf(Agents[v]) > 0) { flag = false; break; } 
	        } 
	        return flag;
		},
		isWechat:function(){
			var ua = navigator.userAgent.toLowerCase();
    		return /micromessenger/i.test(ua) || /windows phone/i.test(ua);
		}
	};
	c.validate = {
		isEmpty: function(str) {
			return str.replace(/(^\s*)|(\s*$)/g, "") ? false : true
		},
		isEmail: function(str) {
			return /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/i.test(str)
		},
		isPhone: function(str) {
			return /^0?1[3|4|5|8][0-9]\d{8}$/.test(str)
		},
		isID: function(str) {
			return /^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(str)
		},
		betweenLength: function(str, min, max) {}
	};
	c.geo = {
		getLocation: function(callback) { //获取纬经度
			if(navigator.geolocation){
				navigator.geolocation.getCurrentPosition(
					function(p){
					    callback(p.coords.latitude, p.coords.longitude);
					    return 
					},
					function(e){
					    var msg = e.code + "\n" + e.message;
					    switch(e.code) {
							case e.PERMISSION_DENIED:
								Insect.util.alertBox("定位失败,用户拒绝请求地理定位");
								break;
							case e.POSITION_UNAVAILABLE:
								Insect.util.alertBox("定位失败,位置信息是不可用");
								break;
							case e.TIMEOUT:
								Insect.util.alertBox("定位失败,请求获取用户位置超时");
								break;
							case e.UNKNOWN_ERROR:
								Insect.util.alertBox("定位失败,定位系统失效");
								break;
						}
					}
				);
			}
			
		}
	};
	return c
})(window.Insect || {});