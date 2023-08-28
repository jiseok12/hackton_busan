<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<body>
   <div class="progress-bar">           
      <!-- data-percent 안에 퍼센트 값을 준다. -->
      <div class="donut" data-percent="85.4"></div>
   </div>
</body>
</html>