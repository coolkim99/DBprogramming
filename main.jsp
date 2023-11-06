<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head><link href="style.css" rel="stylesheet" type="text/css">
<meta charset="EUC-KR">
<title>데이터베이스를 활용한 수강신청 시스템입니다.</title>
</head>
<body>
<%@include file="top.jsp"%>
<table width="75%" align="center" height="100%">
<% if (session_id != null) { %>
<tr> <td><br><br><br><br><br><br><br><br><b><%=session_id%>님 방문을 환영합니다.</b></td> </tr>
<% } else { %>
<tr> <td><br><br><br><br><br><br><br><br><b>로그인한 후 사용하세요.</b></td> </tr>
<% } %>
</table>
</body>
</html>