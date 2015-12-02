<%-- 
    Document   : index.jsp
    Created on : 2015-11-29, 11:28:02
    Author     : Administrator
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
<title>mysql</title>
</head>
<body>
<table border="1" align="center">
    <tr>
      <td>编号</td>
      <td>名称</td>
      <td>详细</td>
    </tr>
    <%
    int[] x;
    x=new int[14];

    SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");//设置日期格式
    SimpleDateFormat df1 = new SimpleDateFormat("HH");
    int a1,a2,i=0;
    a1 = Integer.parseInt(df1.format(new Date()));
    
    //a1=a1*10000;a2=a2*10000;
    String driverClass="com.mysql.jdbc.Driver";
    String url="jdbc:mysql://10.120.123.22:3306/test";
    String user="root";
    String password="deng0313";

    Connection conn;
    try{
        Class.forName(driverClass);
        conn=DriverManager.getConnection(url,user,password);
        Statement stmt=conn.createStatement();
        String sql="select count(*) from Reply";
        ResultSet rs=stmt.executeQuery(sql);
        
        while(a1>8){
            a2 =a1-1;            
    %>
    <tr>
        <td><%=a1%></td>
        <td><%=a2%></td>
        <td><%=x[i]%></td>
    </tr>
    <%
    a1--;
    i++;
    }
    }
    catch(Exception ex){
    ex.printStackTrace();
    }
    %>
</table>
</body>
</html>

