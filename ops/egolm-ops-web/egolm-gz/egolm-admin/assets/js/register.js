/*
	

	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});


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
				},
				1000)
			}
		};
	$('.getCode').on('click',function(){ //获取验证码
		setTime(this)
	});
		

			$(document).ready(function() {
				var html = [];
				$(".checked-wrap").on('click','input',function(){
					var inHtml = "";
					if(this.checked){
						html.push(this.name);
					}else {
						for(var i=0;i<html.length;i++){
							if(html[i]===this.name){
								html.splice(i,1);
								i--;
							}
						}
					}
					for(var i=0;i<html.length;i++){
						inHtml+=html[i]+'&nbsp&nbsp';
					}
					$('#salesman-location').html(inHtml);
			});


			var cNode = document.getElementById("salesman-menu").getElementsByTagName("li");
				$(".salesman-position").click(function() {
					$("cNode").each(function() {
						$(".position_select").html();
					})
			});
		});
		

*/



	$('.chk').on('click', function() { //选中/取消选中
					Checked.checked(this);
				});

				$('#salesman-location').click(function() {
					$('#shop_posi').html("");
				});



				$(document).ready(function(){
				var html = [];
				 $(".checked-wrap").on('click','input',function(){
					var inHtml = "";
					if(this.checked){
						html.push(this.name);
					}else {
						for(var i=0;i<html.length;i++){
							if(html[i]===this.name){
								html.splice(i,1);
								i--;
							}
						}
					}
					for(var i=0;i<html.length;i++){
						inHtml+=html[i]+'&nbsp&nbsp';
					}
					$('#salesman-location').html(inHtml);
			});


			var cNode = document.getElementById("salesman-menu").getElementsByTagName("li");
				$(".salesman-position").click(function() {
					$("cNode").each(function() {
						$(".position_select").html();
					})
			})	
		});


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
							},
						1000)
					}
				};

