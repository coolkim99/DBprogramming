<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head><title>������û ����� ���� ����</title></head>
<body>
<%
request.setCharacterEncoding("utf-8");
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "c##bon";
String password = "bon1234";
Connection myConn = null;
Statement stmt = null;
try{
   Class.forName(driver);
   myConn = DriverManager.getConnection(url, user, password);
   stmt = myConn.createStatement();
}catch(ClassNotFoundException e){
   System.out.println("jdbc driver �ε� ����");
}catch(SQLException e){
   System.out.println("����Ŭ ���� ����");
}
String session_id = (String)session.getAttribute("user");
String userPassword = request.getParameter("userPassword");
/* String userEmail = request.getParameter("userEmail");
String userAddress = request.getParameter("userAddress");
String userBank = request.getParameter("userBank");
String userAccount = request.getParameter("userAccount");
String userPhone = request.getParameter("userPhone"); */
String mySQL = "update student set s_pwd = '" + userPassword  + "' where s_id = '" + session_id + "'";
try{
   stmt.executeUpdate(mySQL);%>
   <script>alert('���� �Ϸ�');
   location.href = 'update.jsp';</script>
<%}catch(SQLException ex){
   String sMessage;
   if(ex.getErrorCode() == 20002)   sMessage = "��ȣ�� 4�ڸ� �̻��̾�� �մϴ�";
   else if(ex.getErrorCode() == 20003)   sMessage = "��ȣ�� ������ �Էµ��� �ʽ��ϴ�.";
  /*  else if(ex.getErrorCode() == 20004) sMessage = "�̸��� ������ ���� �ʽ��ϴ�.";
   else if(ex.getErrorCode() == 20005) sMessage = "�ڵ��� ������ ���� �ʽ��ϴ�. ������ �������� �־��ּ���."; */
   else   sMessage = "��� �� �ٽ� �õ��Ͻʽÿ�.";
   %><script>alert('<%=sMessage%>');
   location.href = 'update.jsp';</script>
<%}%>
</body>
</html>