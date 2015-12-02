<%-- 
    Document   : front
    Created on : 2015-12-1, 8:14:26
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <title>ECharts</title>
</head>
<body>
    <%
        int [] x=new int[15];
        int sum=0;
        for(int i=0;i<15;i++){
            x[i]=i;
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
        <div id="main1" style="height:200px ;width:800px"></div>
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
