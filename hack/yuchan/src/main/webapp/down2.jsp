<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<% 

Class.forName("oracle.jdbc.OracleDriver");
int num;
int value;
try{
Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
String sql ="select * from ardu where sensor_number = (select MAX(sensor_number) from ardu)";
PreparedStatement pstmt = conn.prepareStatement(sql);
ResultSet rs = pstmt.executeQuery();
String sql2 ="select * from rasp where people_num = (select MAX(people_num) from rasp)";
PreparedStatement pstmt2 = conn.prepareStatement(sql2);
ResultSet rs2 = pstmt2.executeQuery();
rs2.next();
int count =0;
rs.next();
num=rs.getInt(1);
value=rs.getInt(3);
String danger="";
String pe="";

if(rs.getInt(3)<=30 && rs.getInt(3)>10){
	danger = "하";
}
else if(rs.getInt(3)<=70 &&rs.getInt(3)>30){
	danger = "중";
}
else if(rs.getInt(3)>70){
	danger = "상";
}
else{
	danger="정상";
}
//System.out.println(rs2.getInt(3));
if(rs2.getInt(3)==1 && rs.getInt(3)>=20){
	pe="구조 요청";
}
else if(rs.getInt(3)>=20){
	pe="없음";
}
else{
	pe="정상";
}
%>
{"label":["<%=danger%>"],
"temp":["<%=pe%>"]}
<%
}
catch(Exception e){
	e.printStackTrace();
}
%>