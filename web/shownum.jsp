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
<title>嘉兴学院图书馆入馆人数统计</title>
</head>
<body>
<table border="1" align="center">
    <%
    SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
    /*SimpleDateFormat df1 = new SimpleDateFormat("HH");
    String[] x;
    x=new String[14];
    int a1,a2,i=7;
    a1 = Integer.parseInt(df1.format(new Date()));*/
    
    //a1=a1*10000;a2=a2*10000;符合sql格式
    String driverClass="com.microsoft.sqlserver.jdbc.SQLServerDriver";
    Connection conn;
    String sql="";
    int i=7;
    String[] x;
    x=new String[15];
    try{
        Class.forName(driverClass);
        conn=DriverManager.getConnection("jdbc:sqlserver://10.39.11.17;DatabaseName=SKEP_DAS;user=tsgMenjing;password=tsgMenjing" );
        Statement stmt=conn.createStatement();
        while(i<23){
              
        sql="SELECT count(*)  FROM [SKEP_DAS].[dbo].[vw_MenJingInfo]"
                + " where DataDate='"+(String)df.format(new Date())+"'"
                + " and ControllerID in (001008,001009) "
                + " and DataTime between "+i*10000+" and "+(i+1)*10000
                + " and StaffName is not NULL";
        ResultSet rs=stmt.executeQuery(sql);
        
            rs.next();
            x[i-6]=rs.getString(1);
            
    %>
    <tr>
        <td><%=i%>~<%=i+1%>时段：x[<%=i-6%>]=<%=x[i-6]%></td>
        <td><%=rs.getString(1) %>人</td>
    </tr>
    <% 
        i++;
        %>
            <tr>
        <td>sql:</td>
        <td><%=sql%></td>
    </tr>
        <%
    }
    }
    catch(Exception ex){
    ex.printStackTrace();
    }
    %>
</table>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="height:400px"></div>
    <!-- ECharts单文件引入 -->
    <script src="./echarts.js"></script>
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
                
                option = {
    title: {
        x: 'center',
        text: '嘉兴学院图书馆入馆人数统计',
        subtext: 'Rainbow bar example',
        link: 'http://echarts.baidu.com/doc/example.html'
    },
    tooltip: {
        trigger: 'item'
    },
    toolbox: {
        show: true,
        feature: {
            dataView: {show: true, readOnly: false},
            restore: {show: true},
            saveAsImage: {show: true}
        }
    },
    calculable: true,
    grid: {
        borderWidth: 0,
        y: 80,
        y2: 60
    },
    xAxis: [
        {
            type: 'category',
            show: false,
            data: ['8点', '9点', '10点', '11点', '12点', '13点', '14点', '15点', '16点', '17点', '18点', '19点', '20点', '21点', '22点']
        }
    ],
    yAxis: [
        {
            type: 'value',
            show: false
        }
    ],
    series: [
        {
            name: '嘉兴学院图书馆入馆人数统计',
            type: 'bar',
            itemStyle: {
                normal: {
                    color: function(params) {
                        // build a color map as your need.
                        var colorList = [
                          '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
                        ];
                        return colorList[params.dataIndex]
                    },
                    label: {
                        show: true,
                        position: 'top',
                        formatter: '{b}\n{c}'
                    }
                }
            },
            data: [<%=x[1]%>,<%=x[2]%>,<%=x[3]%>,<%=x[4]%>,<%=x[5]%>,<%=x[6]%>,<%=x[7]%>
                  ,<%=x[8]%>,<%=x[9]%>,<%=x[10]%>,<%=x[11]%>,<%=x[12]%>,<%=x[13]%>,<%=x[14]%>],
            markPoint: {
                tooltip: {
                    trigger: 'item',
                    backgroundColor: 'rgba(0,0,0,0)',
                    formatter: function(params){
                        return '<img src="' 
                                + params.data.symbol.replace('image://', '')
                                + '"/>';
                    }
                },
                data: [
                    {xAxis:0, y: 350, name:'8点', symbolSize:20, symbol: 'image://../asset/ico/折线图.png'},
                    {xAxis:1, y: 350, name:'9点', symbolSize:20, symbol: 'image://../asset/ico/柱状图.png'},
                    {xAxis:2, y: 350, name:'10点', symbolSize:20, symbol: 'image://../asset/ico/散点图.png'},
                    {xAxis:3, y: 350, name:'11点', symbolSize:20, symbol: 'image://../asset/ico/K线图.png'},
                    {xAxis:4, y: 350, name:'12点', symbolSize:20, symbol: 'image://../asset/ico/饼状图.png'},
                    {xAxis:5, y: 350, name:'13点', symbolSize:20, symbol: 'image://../asset/ico/雷达图.png'},
                    {xAxis:6, y: 350, name:'14点', symbolSize:20, symbol: 'image://../asset/ico/和弦图.png'},
                    {xAxis:7, y: 350, name:'15点', symbolSize:20, symbol: 'image://../asset/ico/力导向图.png'},
                    {xAxis:8, y: 350, name:'16点', symbolSize:20, symbol: 'image://../asset/ico/地图.png'},
                    {xAxis:9, y: 350, name:'17点', symbolSize:20, symbol: 'image://../asset/ico/仪表盘.png'},
                    {xAxis:10, y: 350, name:'18点', symbolSize:20, symbol: 'image://../asset/ico/漏斗图.png'},
                    {xAxis:11, y: 350, name:'19点', symbolSize:20, symbol: 'image://../asset/ico/漏斗图.png'},
                    {xAxis:12, y: 350, name:'20点', symbolSize:20, symbol: 'image://../asset/ico/漏斗图.png'},
                    {xAxis:13, y: 350, name:'21点', symbolSize:20, symbol: 'image://../asset/ico/漏斗图.png'},
                    {xAxis:14, y: 350, name:'22点', symbolSize:20, symbol: 'image://../asset/ico/漏斗图.png'}    
                ]
            }
        }
    ]
};
                    
        
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );
    </script>
</body>
</html>

