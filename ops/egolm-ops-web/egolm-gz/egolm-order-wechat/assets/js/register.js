//获取验证码倒计时
var wait = 60;
function setTime(o) {
	if (wait == 0) {
		o.removeAttribute("disabled");
		o.value = "获取验证码";
		wait = 60;
	} else {
		o.setAttribute("disabled", true);
		o.value = "重新发送(" + wait + ")";
		wait--;
		setTimeout(function() {
			setTime(o)
		},1000);
	}
};