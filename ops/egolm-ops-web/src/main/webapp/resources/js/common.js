
Common={
		showMessage:function(message){ //显示错误信息tip
			if($("#error-tip")){
				$("#error-tip").remove();
			}
			$(document.body).prepend("<div class='error-tip' id='error-tip'><div>"+message+"</div></div>");
			$("#error-tip").fadeIn(100);
			$("#error-tip").delay(1500).fadeOut(1000);
		},
		hideMessage:function(){ //隐藏错误信息tip
			$("#error-tip").remove();
		},
		showLoading:function(){ //显示错误信息tip
			if($("#loading-whole")){
				$("#loading-whole").remove();
			}
			$(document.body).prepend("<div class='loading-whole' id='loading-whole'><div class='loader-inner ball-pulse'><div></div><div></div><div></div></div></div>");
			$("#loading-whole").fadeIn(100);
			$("#loading-whole").delay(1500).fadeOut(1000);
		},
		hideMessage:function(){ //隐藏错误信息tip
			$("#loading-whole").remove();
		}
}


/**
 * * 加法函数，用来得到精确的加法结果 * 说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。 *
 * 调用：FloatAdd(arg1,arg2) * 返回值：arg1加上arg2的精确结果
 */
function FloatAdd(arg1, arg2) {
	var r1, r2, m, c;
	try {
		r1 = arg1.toString().split(".")[1].length;
	} catch (e) {
		r1 = 0;
	}
	try {
		r2 = arg2.toString().split(".")[1].length;
	} catch (e) {
		r2 = 0;
	}
	c = Math.abs(r1 - r2);
	m = Math.pow(10, Math.max(r1, r2));
	if (c > 0) {
		var cm = Math.pow(10, c);
		if (r1 > r2) {
			arg1 = Number(arg1.toString().replace(".", ""));
			arg2 = Number(arg2.toString().replace(".", "")) * cm;
		} else {
			arg1 = Number(arg1.toString().replace(".", "")) * cm;
			arg2 = Number(arg2.toString().replace(".", ""));
		}
	} else {
		arg1 = Number(arg1.toString().replace(".", ""));
		arg2 = Number(arg2.toString().replace(".", ""));
	}
	return (arg1 + arg2) / m;
}

/**
 * * 乘法函数，用来得到精确的乘法结果 * 说明：javascript的乘法结果会有误差，在两个浮点数相乘的时候会比较明显。这个函数返回较为精确的乘法结果。 *
 * 调用：FloatMul(arg1,arg2) * 返回值：arg1乘以 arg2的精确结果
 */
function FloatMul(arg1, arg2) {
	var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
	try {
		m += s1.split(".")[1].length;
	} catch (e) {
	}
	try {
		m += s2.split(".")[1].length;
	} catch (e) {
	}
	return Number(s1.replace(".", "")) * Number(s2.replace(".", ""))
			/ Math.pow(10, m);
}

/**
 * * 除法函数，用来得到精确的除法结果 * 说明：javascript的除法结果会有误差，在两个浮点数相除的时候会比较明显。这个函数返回较为精确的除法结果。 *
 * 调用：FloatDiv(arg1,arg2) * 返回值：arg1除以arg2的精确结果
 */
function FloatDiv(arg1, arg2) {
	var t1 = 0, t2 = 0, r1, r2;
	try {
		t1 = arg1.toString().split(".")[1].length;
	} catch (e) {
	}
	try {
		t2 = arg2.toString().split(".")[1].length;
	} catch (e) {
	}
	with (Math) {
		r1 = Number(arg1.toString().replace(".", ""));
		r2 = Number(arg2.toString().replace(".", ""));
		return (r1 / r2) * pow(10, t2 - t1);
	}
}

/**
 * * 减法函数，用来得到精确的减法结果 * 说明：javascript的减法结果会有误差，在两个浮点数相减的时候会比较明显。这个函数返回较为精确的减法结果。 *
 * 调用：FloatSub(arg1,arg2) * 返回值：arg1加上arg2的精确结果
 */
function FloatSub(arg1, arg2) { 
	var r1, r2, m, n;
	try {
		r1 = arg1.toString().split(".")[1].length;
	} catch (e) {
		r1 = 0;
	}
	try {
		r2 = arg2.toString().split(".")[1].length;
	} catch (e) {
		r2 = 0;
	}
	m = Math.pow(10, Math.max(r1, r2)); // last modify by deeka //动态控制精度长度
	n = (r1 >= r2) ? r1 : r2;
	return ((arg1 * m - arg2 * m) / m).toFixed(n);
}


//制保留2位小数，如：2，会在2后面补上00.即2.00    
function toDecimal(x) {
    var f = parseFloat(x);    
    if (isNaN(f)) {    
        return false;    
    }    
    var f = Math.round(x*100)/100;    
    var s = f.toString();    
    var rs = s.indexOf('.');    
    if (rs < 0) {    
        rs = s.length;    
        s += '.';    
    }    
    while (s.length <= rs + 2) {    
        s += '0';    
    }    
    return s;    
}

/**
 * 整除
 * 
 * @param exp1
 * @param exp2
 * @returns {Number}
 */
function mathDiv(exp1, exp2) {
    var n1 = parseFloat(exp1);
    var n2 = parseFloat(exp2);

    var rslt = n1 / n2; //除  
    if (rslt >= 0) {
        rslt = Math.floor(rslt); //返回小于等于原rslt的最大整数。  
    }
    else {
        rslt = Math.ceil(rslt); //返回大于等于原rslt的最小整数。  
    }

    return rslt;
}

String.prototype.endWith=function(s){
	  if(s==null||s==""||this.length==0||s.length>this.length)
	     return false;
	  if(this.substring(this.length-s.length)==s)
	     return true;
	  else
	     return false;
	  return true;
	 }

String.prototype.startWith=function(s){
	  if(s==null||s==""||this.length==0||s.length>this.length)
	   return false;
	  if(this.substr(0,s.length)==s)
	     return true;
	  else
	     return false;
	  return true;
}

//获取.net系统返回的图片地址
function getImagePath(remoteImagePath,needwh,width,height,needLogo) { 
	var basePatb = "http://img.egolm.com";
	var size = "";
	var logo = "";
	if(needLogo){
		logo = "@!"+width+"_"+height;
	}else{
		if(needwh){
			size = "@"+height+"h_"+width+"w";
		}
	}
	var imgParentPath = basePatb+remoteImagePath+size+logo;
	return imgParentPath;
}

//日期格式化
Date.prototype.format = function(format) {
    var date = {
           "M+": this.getMonth() + 1,
           "d+": this.getDate(),
           "h+": this.getHours(),
           "m+": this.getMinutes(),
           "s+": this.getSeconds(),
           "q+": Math.floor((this.getMonth() + 3) / 3),
           "S+": this.getMilliseconds()
    };
    if (/(y+)/i.test(format)) {
           format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    }
    for (var k in date) {
           if (new RegExp("(" + k + ")").test(format)) {
                  format = format.replace(RegExp.$1, RegExp.$1.length == 1
                         ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
           }
    }
    return format;
}

function getLocalDateTime(nS,format) {
	return new Date(parseInt(nS) * 1000).format(format);
 }     

//截取字符	
function suStringStr(str){
		var resStr = "";
		if(str == ''){
			return str;
		}
		if(str.length>10){
			resStr = str.substring(0,10)+"...";
		}else{
			resStr =str
		}
		return resStr;
}

function computeLength(eleInput, maxLength, nativeCharSize) {
    var nativeCharRegexp = /[\u4E00-\u9FFF]/;
    var string, char, length = 0;
    var ele = (typeof eleInput == 'string') ? document.getElementById(eleInput) : eleInput;
  	if(maxLength == undefined) {
      maxLength = ele.maxLength || 80;
    }
    if(nativeCharSize == undefined) {
        nativeCharSize = 2;
    }
    string = (ele.value || '').split('');
    for(var i = 0, count = string.length; i < count; i ++) {
        char = string[i];
        if(nativeCharRegexp.test(char)) {
            length += nativeCharSize;
        } else {
            length ++;
        }
    }
    return length;
}

//校验输入的字符长度
function checkLength(target,maxLength) {
	if(!maxLength){
		maxLength = 80;
	}
    var targetLength = computeLength(target, maxLength, 2);
	//var leftLength =maxLength - targetLength;
    if(targetLength > 80){
    	return false;
    }
    else{
    	return true;
    }
}
//校验邮箱格式
function checkEmail(eamil){
	var reyx= /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
	return(reyx.test(eamil));
}


/****base64 encode**********/
function base64encode(base64EncodeChars,str) {
    var out, i, len;
    var c1, c2, c3;
    len = str.length;
    i = 0;
    out = "";
    while(i < len) {
	    c1 = str.charCodeAt(i++) & 0xff;
	    if(i == len){
	        out += base64EncodeChars.charAt(c1 >> 2);
	        out += base64EncodeChars.charAt((c1 & 0x3) << 4);
	        out += "==";
	        break;
	    }
	    c2 = str.charCodeAt(i++);
	    if(i == len){
	        out += base64EncodeChars.charAt(c1 >> 2);
	        out += base64EncodeChars.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4));
	        out += base64EncodeChars.charAt((c2 & 0xF) << 2);
	        out += "=";
	        break;
	    }
	    c3 = str.charCodeAt(i++);
	    out += base64EncodeChars.charAt(c1 >> 2);
	    out += base64EncodeChars.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4));
	    out += base64EncodeChars.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >>6));
	    out += base64EncodeChars.charAt(c3 & 0x3F);
    }
    return out;

}

//设置cookie
function setCookie(cname, cvalue, exdays) {
	if(!exdays){
		exdays = 1;
	}
    var d = new Date();
    d.setTime(d.getTime() + (exdays*24*60*60*1000));
    var expires = "expires="+d.toGMTString();
    document.cookie = cname + "=" + cvalue + "; " + expires+";Path=/";
}

//获取cookie
function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i=0; i<ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1);
        if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
    }
    return "";
}

//清除cookie  
function clearCookie(name) {
    setCookie(name, "", -5);  
}  

//清除当前目录下的cookie
function clearNowCookie(name) {
	var d = new Date();
	var cvalue = "";
    d.setTime(d.getTime() + (-5*24*60*60*1000));
    var expires = "expires="+d.toGMTString();
    document.cookie = name + "=" + cvalue + "; " + expires;
}

function getTargetRequestParam(target){
	var param = {};
	if(target){
		var requestParams = target.getAttribute("req-param");
		if(requestParams){
			var paramArr = requestParams.split("&");
			if(paramArr.length > 0){
				for(var i=0;i<paramArr.length;i++){
					var paramStr = paramArr[i];
					var paramStrArr = paramStr.split("|");
					if(paramStrArr.length > 0){
						param[paramStrArr[0]] = paramStrArr[1];
					}
				}
			}
		}
	}
	return param;
}

/**
 * 元素是否存在于数组中
 * 
 * @param value
 * @param arraySz
 */
function arrayEleInx(value,arraySz){
	for(var o in arraySz){
		var arrayInx = $.inArray(value, arraySz[o]);
		if(arrayInx >= 0){
			return true;
		}
	}
	return false;
}

/**
 * 取多个库存数量的最大商数
 * 
 * @param qtys
 */
function getQtysMaxqt(qtys,meetQtys){
	var qt,minqt = 1;
	for(var i=0;i<qtys.length;i++){
		qt = mathDiv(qtys[i],meetQtys[i]);
		if(i === 0){
			minqt = qt;
		}
		else{
			if(qt < minqt){
				minqt= qt;
			}
		} 
		
	}
	return minqt;
}

/**
 * 转undefined数据为""
 * 
 * @param qtys
 */
function defineUndfValue(value){
	if(value == undefined || value == "undefined" || value == null || value == "null"){
		return "";
	}
	else{
		return value;
	}
}

function showOnDevelopment(){
	Common.showMessage("待上线，敬请期待…");
}

