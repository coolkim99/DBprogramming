<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head><link href="style.css" rel="stylesheet" type="text/css">
<meta charset="EUC-KR">
<title>�����ͺ��̽��� Ȱ���� ������û �ý����Դϴ�.</title>
</head>
<body>
<%@include file="top.jsp"%>
<table width="75%" align="center" height="100%">
<% if (session_id != null) { %>
<tr> <td><br><br><br><br><br><br><br><br><b><%=session_id%>�� �湮�� ȯ���մϴ�.</b></td> </tr>
<% } else { %>
<tr> <td><br><br><br><br><br><br><br><br><b>�α����� �� ����ϼ���.</b></td> </tr>
<% } %>
</table>
</body>
</html>