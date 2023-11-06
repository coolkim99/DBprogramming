<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<html><head><link href="style.css" rel="stylesheet" type="text/css">
<title>수강신청 조회 </title></head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id==null) response.sendRedirect("login.jsp"); %>
<br><br><br>
<table width="70%" align="center" border>
<br>
<tr><th>과목번호 </th><th>분반 </th><th>과목명 </th><th>학년도 </th><th>학기 </th><th>요일</th><th>시간</th>
</tr>
<%
Connection myConn = null; Statement stmt = null;
ResultSet myResultSet = null; String mySQL = "";
int nTotalCourse = 0; int nTotalUnit = 0;
String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
String user="c##bon"; String passwd="bon1234";
String dbdriver = "oracle.jdbc.driver.OracleDriver";
try {
Class.forName(dbdriver);
myConn = DriverManager.getConnection (dburl, user, passwd);
stmt = myConn.createStatement();
} catch(SQLException ex) {
System.err.println("SQLException: " + ex.getMessage());
}
mySQL = "select e.c_id,e.c_id_no,c.c_name,e_year,e_semester, t_date, t_time from enroll e, course c, teach t where e.s_id='" + session_id + "' and e.c_id = c.c_id and e.c_id_no = c.c_id_no and t.c_id = c.c_id and t.c_id_no = c.c_id_no and t_year = e_year and t_semester = e_semester";
myResultSet = stmt.executeQuery(mySQL);
if (myResultSet != null) {
while (myResultSet.next()) {
String c_id = myResultSet.getString("c_id");
int c_id_no = myResultSet.getInt("c_id_no");
String c_name = myResultSet.getString("c_name");
int e_year = myResultSet.getInt("e_year");
int e_semester = myResultSet.getInt("e_semester");
String t_date = myResultSet.getString("t_date");
String t_time = myResultSet.getString("t_time");
CallableStatement cstmt = myConn.prepareCall("{call CountSelected(?,?,?,?,?)}");
cstmt.setString(1, session_id);
cstmt.setInt(2, e_year);
cstmt.setInt(3,e_semester);
cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
cstmt.registerOutParameter(5, java.sql.Types.INTEGER);
try {
cstmt.execute();
nTotalUnit = cstmt.getInt(4);
nTotalCourse = cstmt.getInt(5);
%>
<%
} catch(SQLException ex) {
System.err.println("SQLException: " + ex.getMessage());
}
%>
<tr>
<td><%= c_id %></td> <td><%= c_id_no %></td><td><%= c_name %></td>
<td><%= e_year %></td><td><%= e_semester %></td><td><%= t_date %></td>
<td ><%= t_time %></td>
</tr>

<%
}
}
stmt.close(); myConn.close();
%>
</table>
<br><br>
<div id = "CountInfo" align="center" style="font-weight: bold;">수강신청한 강의 수 :  <%=nTotalCourse%>개   &nbsp;&nbsp;&nbsp;  누적 학점 수 :  <%=nTotalUnit%>학점</div>
</body>
</html>