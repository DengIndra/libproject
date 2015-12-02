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
<title>sql server</title>
</head>
<body>
  <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="height:400px"></div>
    <!-- ECharts单文件引入 -->
    <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
    <%
    SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
    SimpleDateFormat df1 = new SimpleDateFormat("HH");
    String[] x;
    x=new String[14];
    int a1,a2,i=0;
    a1 = Integer.parseInt(df1.format(new Date()));
    
    //a1=a1*10000;a2=a2*10000;符合sql格式
    String driverClass="com.microsoft.sqlserver.jdbc.SQLServerDriver";
    Connection conn;
    String sql="";
    /*try{
        Class.forName(driverClass);
        conn=DriverManager.getConnection("jdbc:sqlserver://10.39.11.17;DatabaseName=SKEP_DAS;user=tsgMenjing;password=tsgMenjing" );
        Statement stmt=conn.createStatement();
        while(a1>8){
            a2 =a1-1;   
        sql="SELECT count(*)/2  FROM [SKEP_DAS].[dbo].[vw_MenJingInfo]"
                + " where DataDate='"+(String)df.format(new Date())+"'"
                + " and ControllerID in (001008,001009) "
                + " and DataTime between "+a2*10000+" and "+a1*10000
                + " and StaffName is not NULL";
        ResultSet rs=stmt.executeQuery(sql);
        while(rs.next()){
            x[i]=rs.getString(1);   
    }
        a1--;
        i++;
    }
    }
    catch(Exception ex){
    ex.printStackTrace();
    }*/
    %>
 
    <script type="text/javascript">
        // 路径配置
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main')); 
                
                var option = {
                    tooltip: {
                        show: true
                    },
                    legend: {
                        data:['嘉兴学院图书馆入馆人数']
                    },
                    xAxis : [
                        {
                            type : 'category',
                            data : ["8点","9点","10点","11点","12点","13点","14点","15点","16点","17点","18点","19点","20点"]
                        }
                    ],
                    yAxis : [
                        {
                            type : 'value'
                        }
                    ],
                    series : [
                        {
                            "name":"嘉兴学院图书馆入馆人数",
                            "type":"bar",
                            "data":[<%=x[13]%>,<%=x[12]%>,<%=x[11]%>,<%=x[10]%>,<%=x[9]%>,<%=x[8]%>,<%=x[7]%>,<%=x[6]%>,<%=x[5]%>,<%=x[4]%>,<%=x[3]%>,<%=x[2]%>,<%=x[1]%>,<%=x[0]%>,];
		
                        }
                    ]
                };
        
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );
    </script>
</body>

