<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">
<meta charset="EUC-KR">
</head>
</html>
<% String session_id = (String) session.getAttribute("user");
String log;
if (session_id == null)
log = "<a href=login.jsp>�α���</a>";
else log = "<a href=logout.jsp>�α׾ƿ�</a>"; %>
<br><br>
<table class="top" width="75%" align="center">
<tr>
<td><%=log%></td>
<td><a href="update.jsp">����� ���� ����</a></td>
<!-- <td><a href="all_course.jsp">��ü���� ��ȸ</a></td> -->
<td><a href="insert.jsp">������û �Է�</a></td>
<td><a href="delete.jsp">������û ����</a></td>
<td><a href="select.jsp">������û ��ȸ</a></td>
<!-- <td><a href="history.jsp">�������� �̷�</a></td> -->
</tr>
</table>
