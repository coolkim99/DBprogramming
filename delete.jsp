<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<html><head><link href="style.css" rel="stylesheet" type="text/css">
<title>������û ���� </title></head>
<body>
<%@ include file="top.jsp" %>
<% if (session_id==null) response.sendRedirect("login.jsp"); %>
<br><br><br>
<table width="70%" align="center" border>
<br>
<tr><th>�����ȣ </th><th>�й� </th><th>����� </th><th>�г⵵ </th><th>�б� </th>
<th>����</th><th>�ð�</th><th>�������</th></tr>
<%
Connection myConn = null; Statement stmt = null;
ResultSet myResultSet = null; String mySQL = "";
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
mySQL = "select e.c_id,e.c_id_no,c.c_name,e_year,e_semester, t_date, t_time from enroll e, course c, teach t where s_id='" + session_id + "' and e.c_id = c.c_id and e.c_id_no = c.c_id_no and t.c_id = c.c_id and t.c_id_no = c.c_id_no and t_year = e_year and  t_semester = e_semester";
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
%>

<tr>
<td><%= c_id %></td> <td><%= c_id_no %></td><td><%= c_name %></td>
<td><%= e_year %></td><td><%= e_semester %></td><td><%= t_date %></td>
<td><%= t_time %></td>
<td><a id="Wcolor" href="delete_verify.jsp?c_id=<%= c_id %>&c_id_no=<%=c_id_no %>"> ��� </a></td>
</tr>
<%
}
}
stmt.close(); myConn.close();
%>
</table>
</body>
</html>