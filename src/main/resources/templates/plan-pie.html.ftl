<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
    <title>月度计划-活动类型占比查看</title>
    <style>
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
            /* border: 1px red solid; */
        }

        html,
        body {
            padding: 10px;
            width: 100%;
            height: 100%;
        }

        .wrapper__body {
            display: -webkit-flex;
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
        }

        .wrapper__body--box {
            width: 50%;
            height: 400px;
        }

        .wrapper__title {
            font-size: 20px;
            padding: 5px;
        }

        .wrapper__title--1 {
            padding: 8px;
            font-size: 15px;
            background-color: rgb(235, 235, 235);
        }

        .wrapper__pie {
            width: 100%;
            height: 100%;
        }

        @media (max-width: 520px) {
            .wrapper__body {
                width: 100%;
                flex-direction: column;
                align-items: center;
            }

            .wrapper__body--box {
                width: 100%;
            }

            .wrapper__title {
                font-size: 15px;
            }

            .wrapper__title--1 {
                padding: 3px;
                font-size: 6px;
            }
        }
    </style>
</head>

<body>
<h1 class="wrapper__title">月度计划-活动类型占比查看（按年度累计至今）</h1>
<#list array as data>
    <div class="wrapper__title--1">
        <span>预算期间</span>
        <span style="display: inline-block; width: 10px"></span>
        <span>${(data.budgetPeriod)!""}</span>
        <span style="display: inline-block; width: 20px"></span>
        <span>成本中心</span>
        <span style="display: inline-block; width: 10px"></span>
        <span>${(data.costcenter)!""}</span>
    </div>

    <div class="wrapper__body">
        <#list data.budgetContent as budgetContent>
            <div class="wrapper__body--box">
                <div class="wrapper__pie" data-x-pie='${budgetContent}'></div>
            </div>
        </#list>
    </div>
</#list>
<#--需配置静态文件路径，页面到达浏览器后会主动请求js资源-->
<#--<script src="../static/echarts.min.js"></script>-->
<#--    后端载入js静态资源，浏览器无需再次请求js资源-->
<script>
    <#include "echarts.min.js" parse=false>
</script>
<script>
    const option = {
        title: {
            text: "月度计划-不同活动类型额度占比\n（包含当前待审批的月度计划）",
            // subtext: "（包含当前待审批的月度计划）",
            left: "center",
            top: 20,
            textStyle: {
                fontSize: 15
            }
        },
        color: ['#8994d3', '#715597', '#4a7ced', '#b2db9e', '#fbd88a', '#f39494', '#9dd3e8', '#1cbbb4', '#f37b1d', '#39b54a', '#fbbd08',
            '#8dc63f', '#2C3E50', '#6495ed', '#b0c4de', '#b0929f', '#9D2933', '#D24D57', '#EAF2D3', '#e54d42'],
        tooltip: {
            show: true,
            trigger: "item",
            formatter: '{b}'
        },
        series: [
            {
                name: "",
                type: "pie",
                radius: "50%",
                data: [
                    // {value: 40, name: "活动类型1 40%", id: '1'},
                    // {value: 40, name: "活动类型2 40%", id: '2'},
                    // {value: 5, name: "活动类型3 20%", id: '3'},
                    // {value: 5, name: "活动类型32 20%", id: '3'},
                    // {value: 5, name: "活动类型33 20%", id: '3'},
                    // {value: 5, name: "活动类型34 20%", id: '3'},
                ],
                emphasis: {
                    itemStyle: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: "rgba(0, 0, 0, 0.5)",
                    },
                },
            },
        ],
    };

    const nodes = document.getElementsByClassName("wrapper__pie");
    const pies = []
    if (nodes && nodes.length) {
        for (let node of nodes) {
            const str = node.getAttribute('data-x-pie');
            const data = JSON.parse(str)
            option.title.text = data?.title;
            option.series[0].data = data?.children.list.sort((a, b) => b.value - a.value).map((v) => {
                return {value: v.value, name: v.title};
            });
            if (window.innerWidth < 520) {
                option.title.textStyle.fontSize = 12
            } else {
                option.title.textStyle.fontSize = 15
            }
            const pie = echarts.init(node)
            pie.setOption(option)
            pies.push(pie)
        }
    }

    const debounce = (fn, delay) => {
        let timer
        return function () {
            if (timer) {
                clearTimeout(timer);
            }
            timer = setTimeout(() => {
                fn()
            }, delay)
        }
    }

    window.onresize = debounce(() => {
        for (let pie of pies) {
            let option = pie.getOption()
            if (window.innerWidth < 520) {
                option.title[0].textStyle.fontSize = 12
            } else {
                option.title[0].textStyle.fontSize = 15
            }
            pie.setOption(option)
            pie.resize()
        }
    }, 500)

</script>
</body>
</html>
