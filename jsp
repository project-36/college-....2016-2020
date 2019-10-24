INDEX.JSP
=================

<%-- 
    Document   : index
    Created on : 18 Sep, 2018, 2:22:26 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BANK MANAGEMENT </title>
    </head>
    <body>
        <form method="post" action="login.jsp">
            <center>
            <table border="1" width="30%" cellpadding="3">
                <thead>
                    <tr>
                        <th colspan="2">Login Here</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>User Name: </td>
                        <td><input type="text" name="uname" value="" /></td>
                    </tr>
                    <tr>
                        <td>Password: </td>
                        <td><input type="password" name="pass" value="" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Login" /></td>
                        <td><input type="reset" value="Reset" /></td>
                    </tr>
                    <tr>
                        <td colspan="2">Yet Not Registered!! <a href="reg.jsp">Register Here AS A NEW EMPLOYEE  </a></td>
                    </tr>
                </tbody>
            </table>
            </center>
        </form>
    </body>
</html>

===================================================================================

LOGIN.JSP
====================================================================================
<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("uname"); 
    String pwd = request.getParameter("pass");
    out.println("<h2>welcome"+userid+"</h2>");
 
    Class.forName("org.postgresql.Driver");
    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres",
            "postgres", "root");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from data where username='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("userid", userid);
        //out.println("welcome " + userid);
        
        //out.println("<a href='logout.jsp'>Log out</a>");
        
        response.sendRedirect("transactions.jsp");
    } else {
        out.println("Invalid password <a href='index.jsp'>try again</a>");
    }
    
%>
========================================================================================
REG.JSP
========================================================================================
<%-- 
    Document   : reg
    Created on : 18 Sep, 2018, 2:24:21 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
    </head>
    <body>
        <form method="post" action="registration.jsp">
            <center>
            <table border="1" width="30%" cellpadding="5">
                <thead>
                    <tr>
                        <th colspan="2">Enter Information Here</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>First Name</td>
                        <td><input type="text" name="fname" value="" /></td>
                    </tr>
                    <tr>
                        <td>Last Name</td>
                        <td><input type="text" name="lname" value="" /></td>
                    </tr>                   
                    <tr>
                        <td>User Name</td>
                        <td><input type="text" name="uname" value="" /></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" name="pass" value="" /></td>
                    </tr>
                    <tr>
                        <td>phone</td>
                        <td><input type="text" name="phone" value="" /></td>
                    </tr>
                    <tr>
                        <td>age</td>
                        <td><input type="text" name="age" value="" /></td>
                    </tr>
                     <tr>
                        <td>accounttype</td>
                        <td><input type="text" name="accounttype" value="" /></td>
                    </tr>
                    <tr>
                        <td>account_id</td>
                        <td><input type="text" name="accid" value="" /></td>
                    </tr>
                    <tr>
                        <td>amount</td>
                        <td><input type="text" name="amount" value="" /></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Submit" /></td>
                        <td><input type="reset" value="Reset" /></td>
                    </tr>
                    <tr>
                        <td colspan="2">Already registered!! <a href="index.jsp">Login Here</a></td>
                    </tr>
                </tbody>
            </table>
            </center>
        </form>
    </body>
</html>
===================================================================================================
REGISTRATION.JSP
===================================================================================================
<%@ page import ="java.sql.*" %>
<%
    String user = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String phone = request.getParameter("phone");
    String accid = request.getParameter("accid");
    String amount = request.getParameter("amount");
    String age = request.getParameter("age");
    String accounttype = request.getParameter("accounttype");
    Class.forName("org.postgresql.Driver");
    Connection con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres",
            "postgres", "root");
    Statement st = con.createStatement();
    //ResultSet rs;
    int i = st.executeUpdate("INSERT INTO data(firstname, lastname, username, password,phone,age,accounttype,accid,amount) VALUES ('"+fname+"','"+ lname+"','"+ user+"','" + pwd +"','" + phone +"','" + age +"','" + accounttype +"','"+accid+"','"+amount+"');");
    if (i > 0) {
        //session.setAttribute("userid", user);
        response.sendRedirect("welcome.jsp");
       // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
    } else {
        response.sendRedirect("login.jsp");
    }
%>
======================================================================================================
SUCCESS.JSP
=======================================================================================================
<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("userid")%>
<a href='logout.jsp'>Log out</a>
<%
    }
%>
=========================================================================================================
TRANS.JSP
=========================================================================================================
<%-- 
    Document   : trans
    Created on : 24 Oct, 2019, 2:45:55 PM
    Author     : wad3
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<%  

  String dep=request.getParameter("dep");
  String with=request.getParameter("with");  
  String accid=request.getParameter("accid");
  String driver = "org.postgresql.Driver";
  String dbuser="postgres";
  String dbpass="root";
  String url="jdbc:postgresql://localhost:5432/postgres";
  String myQuery = "update data set amount = amount-'"+with+"'where accid='"+accid+"';";
  String myQuery1 = "update data set amount = amount+'"+dep+"'where accid='"+accid+"';";
      Connection conn = null;
      Statement stmt = null;
      ResultSet myResultSet = null;
       Class.forName(driver).newInstance();
      conn = DriverManager.getConnection(url,dbuser,dbpass);
      out.println("connected successfully");
      stmt = conn.createStatement();
     int i=stmt.executeUpdate(myQuery);
     int j=stmt.executeUpdate(myQuery1);
 out.println(i);
 out.println(j);
 conn.close();

 %>
 ========================================================================================================
 TRANSACTION.JSP
 ==========================================================================================================
 <%-- 
    Document   : transactions
    Created on : 24 Oct, 2019, 2:40:57 PM
    Author     : wad3
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>transactions</title>
    </head>
    <body>
        <h1>TRANSACTIONS</h1>
        <form method="post" action="trans.jsp">
            deposit: <input type="text" name="dep">
            withdraw:<input type="text" name="with">
            accid:<input type="text" name="accid">
            <input type="submit" name="sub" value="submit">
        </form>
    </body>
</html>
=============================================================================================================
WELCOME.JSP
=============================================================================================================
Registration is Successful.
Please Login Here <a href='index.jsp'>Go to Login</a>
============================================================
===============================================================
CREATE TABLE data (
    accountno   SERIAL  PRIMARY KEY,
    firstname    VARCHAR(40),
    lastname    VARCHAR(40),
    username    VARCHAR(40),
    password    VARCHAR(40),
    phone INTEGER,
    age INTEGER,
    accounttype VARCHAR(40);

	
);

firstname, lastname, username, password

ALTER TABLE data 
ADD COLUMN accid int
ADD COLUMN amount int;
