<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<main>
    <section>
        <h1>기록조회</h1>
        <table border="1">
            <tr>
                <td>날짜/시간</td>
                <td>번호</td>
                <td>수위</td>
                <td>침수 상태</td>
                <td>위험도</td>
            </tr>
            <%
            Class.forName("oracle.jdbc.OracleDriver");
            try{
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
            String sql ="select * from ardu where sensor_number > (select MAX(sensor_number) from ardu)-10";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()){
               String danger="";
               String po="";
               if(rs.getInt(3)<=3 &&rs.getInt(3)>1 ){
                  danger = "하";
                  po="O";
               }
               else if(rs.getInt(3)<=9 &&rs.getInt(3)>3){
                  danger = "중";
                  po="O";
               }
               else if(rs.getInt(3)>9){
                  danger = "상";
                  po="O";
               }
               else{
                  danger="정상";
                  po="X";
               }
               %>
               <tr>
                  <td><%=rs.getString(2) %></td>
                  <td><%=rs.getString(1) %></td>
                  <td><%=rs.getString(3) %></td>
                  <td><%=po %></td>
                  <td><%=danger %></td>
               </tr>
               <%
            }
            }catch(Exception e){
               e.printStackTrace();
            }
            %>
        </table>
    </section>
        <article>
      <ul id="kdkd">
          <li onclick="window.location='list.jsp'" id="l">기록<br />조회</li>
          <li onclick="window.location='situation.jsp'">실시간<br />현황</li>
          <li onclick="window.location='index2.jsp'" id="r">실시간<br/>검사</li>
      </ul>
    </article>
</main>
</body>
</html>