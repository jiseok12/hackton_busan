<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<% 

Class.forName("oracle.jdbc.OracleDriver");
int value = 0;
try{
	Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
	String sql ="select * from ardu where sensor_number = (select MAX(sensor_number) from ardu)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
	int count =0;
	rs.next();
	value=rs.getInt(3);
	
	%>
	{"temp":["<%=Integer.toString(value) %>"]}
	<%
}
catch(Exception e){
	e.printStackTrace();
}
%>