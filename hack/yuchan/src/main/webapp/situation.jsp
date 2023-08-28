<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.4/Chart.bundle.min.js"></script>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
   <script type="text/javascript" charset="utf-8" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script> 
    <title>지하 침수 알림</title>
    <script type="text/javascript">
        function showClock(){
          var currentDate = new Date();
          var divClock = document.getElementById('divClock');
          var msg = "현재 시간 : ";
          if(currentDate.getHours()>12){      //시간이 12보다 크다면 오후 아니면 오전
            msg += "오후 ";
            msg += currentDate.getHours()-12+"시 ";
         }
         else {
           msg += "오전 ";
           msg += currentDate.getHours()+"시 ";
         }
   
          msg += currentDate.getMinutes()+"분 ";
          msg += currentDate.getSeconds()+"초";
   
          divClock.innerText = msg;
          setTimeout(showClock,1000);  //1초마다 갱신
        }
    </script>
    <style>
		   .progress-bar{
		   		width: 300px;
		   }
		   .donut {
			    width: calc(100% - 16px);
			    padding-bottom: calc(100% - 16px);
			    margin: 0 auto;
			    border-radius: 50%;
			    position: relative;
			    text-align: center;
			    transition: background .3s ease-in-out;
			    background: conic-gradient(#3F8BC9 0% 72%, #F2F2F2 72% 100%);
			}
			
			.donut::before {
			    color: #fff;
			    width: 70%;
			    padding: calc(35% - .64vw) 0;
			    background: #264057;
			    border-radius: 50%;
			    position: absolute;
			    left: 15%;
			    top: 15%;
			    display: block;
			    content: attr(data-percent)'%';
			    transform: skew(-0.03deg);
			    margin: auto;
			    font-size: 1.1vw;
			    font-size: 2vw;
			    padding: calc(35% - 1.3vw) 0;
			}
	</style>
</head>
<body onload="showClock()">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <section>
        <h1 style="margin-top:30px;">실시간 현황</h1>
        <div id="divClock" class="clock"></div>
        <script>
         $(document).ready(function() {
               setInterval(function() {
                  $.ajax({
                     url: "down2.jsp",
                     method: "GET",
                     dataType: "text",
                     success: function(data) {
                     var mydata = JSON.parse(data);
                          console.log(mydata);
                     document.getElementById("peo").innerText = mydata.temp;
                     
                     if(document.getElementById("peo").innerText=="구조 요청"){
                    	 document.getElementById("peo").style.color="red";
                     }
                     else{
                    	 document.getElementById("peo").style.color="black";
                     }
                     }
                    })
              },1000);
            });
           //값을 download2에서 json값을 가져와서 받아 저장하고 그래프를 그린다
      </script>
        <table id ="test" style="text-align:center">
           <tr>
              <td>
                 <h2 style="margin-top:30px;">사람</h2>
              </td>
           </tr>
           <tr>
             <td>
                 <div id="peo">
                    정상
                 </div>
             </td>
          </tr>
        </table>
        <div class="progress-bar">           
	      <!-- data-percent 안에 퍼센트 값을 준다. -->
	      <div class="donut" id="donut" data-percent="50"></div>
	   	</div>
      <script>
         $(document).ready(function() {
               setInterval(function() {
                  $.ajax({
                     url: "down.jsp",
                     method: "GET",
                     dataType: "text",
                     success: function(data) {
                     	var mydata = JSON.parse(data);
                        console.log(mydata);
                        var water = document.getElementById('donut');
                        //donut.data.percent = mydata.temp;
                        document.documentElement.style.setProperty('percent', mydata.temp);
                        $('#donut').attr('data-percent',mydata.temp);
                        const chart3 = document.querySelector('.donut');
                        chart3.style.background = "conic-gradient(#3F8BC9 0% "+mydata.temp+"%, #F2F2F2 "+mydata.temp+"% 100%)";
                     }
                    })
              },2000);
            });
           //값을 download2에서 json값을 가져와서 받아 저장하고 그래프를 그린다
      </script>
      
    </section>
    <article>
      <ul id="kdkd">
          <li onclick="window.location='list.jsp'" id="l">기록<br />조회</li>
          <li onclick="window.location='situation.jsp'">실시간<br />현황</li>
          <li onclick="window.location='index2.jsp'" id="r">실시간<br/>검사</li>
      </ul>
    </article>
</body>
</html>