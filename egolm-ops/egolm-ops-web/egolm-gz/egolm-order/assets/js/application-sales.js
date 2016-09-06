			
			var check = "";
			$('.chk').on('click', function() {
				var $this = $(this),
					chk = $this.attr('checked');
				$this.attr('checked', !chk);
			});

			$(" input.radio").on('click', function() {
				var $this = $(this);
				$("input[name=address]").attr('checked', false);
				$(this).attr('checked', true);
				check = $(this)[0].value;
			});

			$('.confirmation-title p a').on('click', function() {
				if (check == "return") {
					$('.barter-infor').hide();
					$('.return-infor').hide();
					$('.select-barter').hide();
					$('.select-return').show();
				} else if (check == "barter") {
					$('.barter-infor').hide();
					$('.return-infor').hide();
					$('.select-return').hide();
					$('.select-barter').show();
				}
			})

			$('#barter-inp').on('click', function() {
				$('.cont-display').show();
				$('.return-select').hide();
				$('.confirmation-dis').show();
				$('.barter-infor').show();
				$('.return-infor').hide();
				$('.select-return').hide();
				$('.select-barter').hide();
			})

			$('#return-inp').on('click', function() {
				$('.return-select').show();
				$('.cont-display').hide();
				$('.confirmation-dis').show();
				$('.barter-infor').hide();
				$('.return-infor').show();
				$('.select-return').hide();
				$('.select-barter').hide();
			})




		/*function previewImage(file) {
          var MAXWIDTH  = 50; 
          var MAXHEIGHT = 50;
          var upload = document.getElementById('preview');
          if (file.files && file.files[0])
          {
              upload.innerHTML ='<img id=imghead>';
              var img = document.getElementById('imghead');

              img.onload = function(){
                var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
                img.width  =  rect.width;
                img.height =  rect.height;
                img.style.marginTop = rect.top+'px';
              }

              var reader = new FileReader();
              reader.onload = function(evt){img.src = evt.target.result;}
              reader.readAsDataURL(file.files[0]);
          }
        }
        
        	function clacImgZoomParam( maxWidth, maxHeight, width, height ){
            var param = {top:0, left:0, width:width, height:height};
            if( width>maxWidth || height>maxHeight )
            {
                rateWidth = width / maxWidth;
                rateHeight = height / maxHeight;
                
                if( rateWidth > rateHeight )
                {
                    param.width =  maxWidth;
                    param.height = Math.round(height / rateWidth);
                }else
                {
                    param.width = Math.round(width / rateHeight);
                    param.height = maxHeight;
                }
            }
            
            param.left = Math.round((maxWidth - param.width) / 2);
            param.top = Math.round((maxHeight - param.height) / 2);
            return param;
        }*/