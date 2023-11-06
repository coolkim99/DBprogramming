<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">
<meta charset="EUC-KR">
<title>수강신청 입력</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<%@ include file = "top.jsp"%>
<br>
<% if (session_id == null) response.sendRedirect("login.jsp"); %>
<br><b><div id = "semesterInfo"></div></b>
<%
   String driver = "oracle.jdbc.driver.OracleDriver";
   String url = "jdbc:oracle:thin:@localhost:1521:xe";
   String user = "c##bon";
   String password = "bon1234";
   Connection myConn = null;
   Statement stmt = null;
   PreparedStatement pstmt = null;
   String mySQL = "";
   String majorSQL = "";
   String loginMajor = "";
   ResultSet myResultSet = null;
   ResultSet majorResultSet = null;
   int currentTab = 0;
   int sem = 0;
   try{
      Class.forName(driver);
      myConn = DriverManager.getConnection(url, user, password);
      
      stmt = myConn.createStatement();
      pstmt = myConn.prepareStatement //테이블 출력 pstmt
            ("select c.c_id, c.c_id_no, c_name, c_unit, t_date, t_time, t_prof, t_room, t_max" 
      + " from course c, teach t where c.c_id = t.c_id and c.c_id_no = t.c_id_no" 
            +" and t_semester = ? and (c.c_id, c.c_id_no) not in(select c_id, c_id_no from enroll where s_id = ?)");
   }catch(ClassNotFoundException e){
      System.out.println("jdbc driver 로딩 실패");
   }catch(SQLException e){
      System.out.println("오라클 연결 실패");
   }
   //현 학기에 해당하는 과목만 보여주기
   CallableStatement cstmt = myConn.prepareCall("{? = call Date2EnrollYear(SYSDATE)}"); //stored function 이용
   cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
   CallableStatement cstmt2 = myConn.prepareCall("{? = call Date2EnrollSemester(SYSDATE)}");
   cstmt2.registerOutParameter(1, java.sql.Types.INTEGER);
   try{
      cstmt.execute();
      cstmt2.execute();
      int year = cstmt.getInt(1);
      sem = cstmt2.getInt(1);
      
      %><script>document.getElementById('semesterInfo').innerHTML = "<%=year%>년  <%=sem%>학기";</script><%
   }catch(SQLException e){
	   
      System.err.println("SQLException: " + e.getMessage());
   }finally{
      if(cstmt != null)
         try{
        	 //myConn.commit();
        	 cstmt.close();
         }catch(SQLException e){System.err.println("SQLException: " + e.getMessage());}
   }
   %>
   <br>
     
         
         <table width = "70%" align = "center" class = "tab_box" border>
        
           <% pstmt.setInt(1, sem); pstmt.setString(2, session_id);%>
       
       
         <tr><th>과목번호</th><th>분반</th><th>과목명</th><th>학점</th>
         <th>요일</th><th>시간</th><th>교수</th><th>강의실</th><th>정원</th><th>수강신청</th></tr>
         <% myResultSet = pstmt.executeQuery();
         if(myResultSet != null){
            while(myResultSet.next()){
               String c_id = myResultSet.getString(1);
               int c_id_no = myResultSet.getInt(2);
               String c_name = myResultSet.getString(3);
               int c_unit = myResultSet.getInt(4);
               String t_date = myResultSet.getString(5);
               int t_time = myResultSet.getInt(6);
               String t_prof = myResultSet.getString(7);
               String t_room = myResultSet.getString(8);
               int t_max = myResultSet.getInt(9);
               %>
            <tr>
            <td><%=myResultSet.getString(1) %></td><td><%=c_id_no %></td>
            <td><%=c_name %></td><td><%=c_unit %></td>
            <td><%=t_date %></td><td><%=t_time %></td>
            <td><%=t_prof %></td><td><%=t_room %></td>
            <td><%=t_max %></td>
            <td><a id="Wcolor" href="insert_verify.jsp?c_id=<%=c_id%>&c_id_no=<%=c_id_no%>">신청</a></td>
            </tr>
            <%}
         }%>
         </table>
      

<%
   pstmt.close();
   stmt.close();
   myConn.close();
%>
</body>

</html>