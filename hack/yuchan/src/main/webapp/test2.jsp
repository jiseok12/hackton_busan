<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<script>
</script>
<%
Class.forName("oracle.jdbc.OracleDriver");
int pump;
int door=0;
try{
   Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
   String sql ="select shut from test_li where test_number = (select MAX(test_number) from test_li)";
   PreparedStatement pstmt = conn.prepareStatement(sql);
   ResultSet rs = pstmt.executeQuery();
   rs.next();
   //pump = rs.getInt(1);
   door = rs.getInt(1);
}catch(Exception e){
   e.printStackTrace();
}
String pst="";
if(door==2){
	pst="정상";
}
else{
	pst="비정상";
}
%>
<body>
    <article>
      <ul id="kdkd">
          <li onclick="window.location='list.jsp'" id="l">기록<br />조회</li>
          <li onclick="window.location='situation.jsp'">실시간<br />현황</li>
          <li onclick="window.location='index2.jsp'" id="r">실시간<br/>검사</li>
      </ul>
    </article>
    <h1>실시간 검사</h1>
    <form
     style=""
     id="table">
       <table border="1" style="width: 200px;">
          <tr>
             <td>펌프</td>
             <td>추후 구현</td>
          </tr>
          <tr>
             <td>차단막</td>
             <td><%=pst %></td>
          </tr>
       </table>
    </form>
</body>
</html>