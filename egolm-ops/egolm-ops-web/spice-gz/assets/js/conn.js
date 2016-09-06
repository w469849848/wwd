      
      document.onclick = check;
        function check(e) {
            var div_container = document.getElementById("containerth");
            var div_overlay = document.getElementById("overlay");

            if (div_container.style.display != "none") {
                var t = (e && e.target) || (event && event.srcElement);
                var b = document.getElementById("btn");
                if (t != div_container && t != b) {
                    div_container.style.display = "none";
                    $('.btn1').removeClass("btn2"); 
                }
            }
        }

        $(document).ready(function () {
            // Upload Attachment
            $('#btn').on('click',function (e) {
            /*    $('#overlay').show();*/
                $('#containerth').show();
                $('.btn1').addClass("btn2");

            });

           /*   $('#btn').click(function(){
                $('#btn').css("background","url(../images/common/select1.png) no-repeat right");  
            });*/

            // $(".select-img").click(function(){
            //     $("#containerth").show();
            // })

            $('#containerth').click(function (event) { 
                event.stopPropagation(); 
            });

            $('#containerth li').on('click',function(){
            	$('#val').html($(this)[0].innerHTML);
            	$('#containerth')[0].style.display='none';
            	// $('#overlay')[0].style.display='none';
                $('.btn1').removeClass("btn2"); 
            });
        });