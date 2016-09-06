var Re = (function(o){
	//上传营业执照图片
	o.previewImage = function(file) {
				var MAXWIDTH = 100;
				var MAXHEIGHT = 80;
				var upload = document.getElementById('preview');
				if (file.files && file.files[0]) {
					upload.innerHTML = '<img id=imghead>';
					var img = document.getElementById('imghead');
					img.onload = function() {
						var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
						img.width = rect.width;
						img.height = rect.height;
						img.style.marginTop = rect.top + 'px';
					}
					var reader = new FileReader();
					reader.onload = function(evt) {
						img.src = evt.target.result;
					}
					reader.readAsDataURL(file.files[0]);
				}
			}

	o.clacImgZoomParam = function(maxWidth, maxHeight, width, height) {
				var param = {
					top: 0,
					left: 0,
					width: width,
					height: height
				};
				if (width > maxWidth || height > maxHeight) {
					rateWidth = width / maxWidth;
					rateHeight = height / maxHeight;
					if (rateWidth > rateHeight) {
						param.width = maxWidth;
						param.height = Math.round(height / rateWidth);
					} else {
						param.width = Math.round(width / rateHeight);
						param.height = maxHeight;
					}
				}
				param.left = Math.round((maxWidth - param.width) / 2);
				param.top = Math.round((maxHeight - param.height) / 2);
				return param;
			}

		$('.register-tit').on('tap',function(){ //删除
		$('.delete-alert').removeClass('hide');
		$('body').on('touchmove',function(e){
			e.preventDefault();
		});
	});

	o.removeReg = function() {
		setTimeout(function(){
			$(".delete-alert").remove();
		},1000)	
		location.href="index.html"
	};
	return o;
})(window.Re || {});
