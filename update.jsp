<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head><link href="style.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>������û ����� ���� ����</title></head>
<body>
<%@ include file="top.jsp" %>
<br>
<center><div id = "updateMessage"></div></center>
<br><br><br>
<table width="70%" align="center" border>
<form method="post" action="update_verify.jsp">
<tr>
<td><div><b>���̵�</b></div></td>
<td><div name = "userID"><%=session_id%></div></td>
</tr>
<tr>
<td><div><b>�н�����</b></div></td>
<td><div><input type="text" name="userPassword" class="editable"></div></td>
</tr>
<tr>
<td><div><b>�̸�</b></div></td>
<td><div name = "userName"></div></td>
</tr>
<tr>
<td><div><b>����</b></div></td>
<td><div name="userMajor"></div></td>
</tr>
<!-- <tr>
<td><div><b>�̸���</b></div></td>
<td><div><input type="text" name="userEmail" class="editable"></div></td>
</tr>
<tr>
<td><div><b>�ּ�</b></div></td>
<td><div><input type="text" name="userAddress" class="editable"></div></td>
</tr>
<tr>
<td><div><b>�ŷ������</b></div></td>
<td><div><input type="text" name="userBank" class="editable"></div></td>
</tr>
<tr>
<td><div><b>���¹�ȣ</b></div></td>
<td><div><input type="text" name="userAccount" class="editable"></div></td>
</tr>
<tr>
<td><div><b>��ȭ��ȣ</b></div></td>
<td><div><input type="text" name="userPhone" class="editable"></div></td>
</tr>
<tr>
<td><div><b>����� ����</b></div></td>
<td><div name = "userElevel"></div></td>
</tr> -->
<tr>
<td colspan=2><div align="center">
<input type="SUBMIT" name="Submit" value="����">
</div></td>
</tr>
</form>
<% if(session_id == null) response.sendRedirect("login.jsp");
else{   
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
   String mySQL = "select s_pwd, s_name, s_major from student where s_id="+session_id+"";
   ResultSet rs = stmt.executeQuery(mySQL);
   if(rs.next()){
      String pwd = rs.getString("s_pwd");
      String name = rs.getString("s_name");
      String major = rs.getString("s_major");
      /* String email = rs.getString("s_email");
      String addr = rs.getString("s_addr");
      String bank = rs.getString("s_bank");
      String account = rs.getString("s_bank_acc");
      String phone = rs.getString("s_phone");
      String Elevel = rs.getString("s_Elevel"); */
      %>
      <script>
      document.getElementsByName("userPassword")[0].value = '<%=pwd%>';
      <%-- document.getElementsByName("userEmail")[0].value = '<%=email%>';
      document.getElementsByName("userAddress")[0].value = '<%=addr%>';
      document.getElementsByName("userBank")[0].value = '<%=bank%>';
      document.getElementsByName("userAccount")[0].value = '<%=account%>';
      document.getElementsByName("userPhone")[0].value = '<%=phone%>';
       --%>
      document.getElementsByName("userName")[0].innerHTML = "<%=name%>";
      document.getElementsByName("userMajor")[0].innerHTML = "<%=major%>";
      <%-- document.getElementsByName("userElevel")[0].innerHTML = "<%=Elevel%>"; --%>
      </script>
   <%}
   else{
   }
}%>
</table>
</body>
</html>