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
<meta http-equiv="refresh" content="600; charset=UTF-8">
<title>嘉兴学院图书馆入馆人数统计</title>
</head>
<body>
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
    int[] x;
    x=new int[15];
    try{
        Class.forName(driverClass);
        conn=DriverManager.getConnection("jdbc:sqlserver://10.39.11.17;DatabaseName=SKEP_DAS;user=tsgMenjing;password=tsgMenjing" );
        Statement stmt=conn.createStatement();
        while(i<23){
              
        sql="SELECT count(*)  FROM [SKEP_DAS].[dbo].[vw_MenJingInfo]"
                + " where DataDate='"+(String)df.format(new Date())+"'"
                + " and ControllerID=001008"
                + " and DataTime between "+i*10000+" and "+(i+1)*10000
                + " and StaffName is not NULL";
        ResultSet rs=stmt.executeQuery(sql);
        
            rs.next();
            x[i-6]=rs.getInt(1);
        i++;
    }
    }
    catch(Exception ex){
    ex.printStackTrace();
    }
    
    %>
    <%
                int sum=0;
        for(i=0;i<15;i++){
            
            sum=sum+x[i];
        }
    %>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="height:500px"></div>
    <!-- ECharts柱形图 -->
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
                            subtext: '',
                            link: 'http://echarts.baidu.com/doc/example.html',
                            textStyle:{
                                            fontSize: 50,
                                            fontWeight: 'bolder',
                                            color: '#333'
                                        }  
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
                                            formatter: '{b}\n{c}人',
                                            textStyle : {  
                                            fontStyle : 'bolder',  
                                            fontSize : 20  
                                        }
                                        }
                                    }
                                },
                                data: [<%=x[1]%>,<%=x[2]%>,<%=x[3]%>,<%=x[4]%>,<%=x[5]%>,<%=x[6]%>,<%=x[7]%>
                                      ,<%=x[8]%>,<%=x[9]%>,<%=x[10]%>,<%=x[11]%>,<%=x[12]%>,<%=x[13]%>,<%=x[14]%>],
                            }
                        ]
                    };
                // 为echarts对象加载数据 
                myChart.setOption(option); 
            }
        );
    </script>
        <div id="main1" style="height:200px"></div>
    <!-- ECharts总人数 -->
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
                var myChart = ec.init(document.getElementById('main1')); 
                
                option = {
                    tooltip : {
                        trigger: 'axis',
                        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
                            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                        }
                    },
                    legend: {
                        textStyle:{fontSize: 25,color: '#333'},
                        data:['总访问量']
                    },
                    calculable : true,
                    xAxis : [
                        {
                            type : 'value'
                        }
                    ],
                    yAxis : [
                        {
                            type : 'category',
                            data : ['']
                        }
                    ],
                    series : [
                        {
                            name:'总访问量',
                            type:'bar',
                            itemStyle : { 
                                normal: {
                                    label : {
                                        show: true,
                                        formatter: '{c}人',
                                        position: 'insideRight',
                                        textStyle : {  
                                            fontStyle : 'bolder',  
                                            fontSize : 20  
                                        }
                                    }}},
                            data:[<%=sum%>]
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

