<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");
String sensor=request.getParameter("good");
System.out.println("ai"+sensor);

try{
Class.forName("oracle.jdbc.OracleDriver");
Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
String sql ="insert into test_li(test_number, shut) values((select max(test_number)+1 from test_li), ?)";
//insert into ardu(sensor_number, sensor_value) values(2,1);
PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setString(1, sensor);
pstmt.executeUpdate();
}
catch(Exception e){
	e.printStackTrace();
}
%>