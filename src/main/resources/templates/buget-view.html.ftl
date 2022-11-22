<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
    <title>预算查看</title>
    <style>
        /* reset */
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
            /*border: 1px red solid;*/
        }

        ul,
        ul li {
            list-style: none;
        }

        html,
        body {
            padding: 10px;
            width: 100%;
            height: 100%;
        }

        /* module */

        .wrapper__title {
            font-size: 20px;
            padding: 5px;
        }

        .wrapper__title--1 {
            padding: 8px;
            font-size: 15px;
            background-color: rgb(235, 235, 235);
        }

        table {
            width: 400px;
            margin: 0 auto;
            border: 1px solid #696969;
            border-collapse: collapse;
        }

        tr {
            height: 40px;
        }

        th,
        td {
            border: 1px solid #525252;
            text-align: center;
        }

        thead {
            background-color: rgba(190, 190, 190, 0.4);
        }

        .hzh-tb1__box {
            display: flex;
            flex-direction: column;
        }

        .hzh-tb1__chd-box {
            display: flex;
            flex-direction: row;
            flex-wrap: nowrap;
            /*flex-grow: 1;*/
        }

        .hzh-tb1__chd {
            /*width: 50%;*/
            flex-grow: 1;
        }

        @media (max-width: 520px) {

            .wrapper__table--1 {
                display: none;
            }

            .wrapper__title {
                font-size: 15px;
            }

            .wrapper__title--1 {
                padding: 3px;
                font-size: 6px;
            }

        }

        @media (min-width: 520px) {
            .wrapper__table--3 {
                display: none;
            }

        }

        /* 原子类 */
        .flx-center {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .h-20px {
            height: 20px;
        }

        .h-40px {
            height: 40px;
        }

        .h-80px {
            height: 80px;
        }

        .ftc-0 {
            color: #fff;
        }


        .color-b1 {
            background-color: #325695;
        }

        .color-b2 {
            background-color: #3676b3;
        }

        .color-b3 {
            background-color: #91abda;
        }

        .w-50p {
            width: 50%;
        }

        .w-100p {
            width: 100%;
        }
    </style>
</head>
<body>
<h1 class="wrapper__title">预算查看</h1>
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
    <#assign budgetContent = data.budgetContent>
<div class="wrapper__body">
    <div class="wrapper__body--box">
        <#if budgetContent?? && (budgetContent?size > 0)>
            <p style="padding: 10px">按年度累计至今预算进度情况</p>
            <#list budgetContent as budgetContentItem>
                <div class="wrapper__table--1">
                    <!-- hzh-tb1 可嵌套的-->
                    <div class="hzh-tb1__box ftc-0">
                        <div class="hzh-tb1__sum flx-center h-40px">
                            <p>${(budgetContentItem.title)!""} ${(budgetContentItem.value)!""}</p>
                        </div>
                        <div class="hzh-tb1__chd-box h-80px" style="width: 100%">
                            <div class="hzh-tb1__chd">
                                <div class="hzh-tb1__box">
                                    <!-- <div class="hzh-tb1__sum flx-center h-40px"><p>冻结 xxxx</p></div> -->
                                    <#if (budgetContentItem.children)?? && (budgetContentItem.children.list?size > 0)>
                                        <div class="hzh-tb1__chd-box">
                                            <#list budgetContentItem.children.list as item>
                                                <!-- 判断 是否 可分配预算 -->
                                                <#if (item.children)?? && (item.children.list)??>
                                                    <div class="hzh-tb1__chd w-50p">
                                                        <div class="hzh-tb1__box">
                                                            <div class="hzh-tb1__sum flx-center h-40px">
                                                                <p>${(item.title)!""} ${(item.value)!""}</p>
                                                            </div>
                                                            <div class="hzh-tb1__chd-box data-x-budget-sum"
                                                                 data-x-budget-sum='${(item.value)!0}'>
                                                                <#list item.children.list as a>
                                                                    <div class="hzh-tb1__chd flx-center h-40px"
                                                                         data-x-budget='${(a.value)!0}'>
                                                                        <p>${(a.title)!""} ${(a.value)!""}</p>
                                                                    </div>
                                                                </#list>
                                                            </div>
                                                        </div>
                                                    </div>
                                                <#else>
                                                    <div class="hzh-tb1__chd flx-center h-80px">
                                                        <p>${(item.title)!""} ${(item.value)!""}</p>
                                                    </div>
                                                </#if>
                                            </#list>
                                        </div>
                                    </#if>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <!--        仅移动端显示 -->
                <div class="wrapper__table--3">
                    <table class="w-100p ftc-0">
                        <tbody>
                        <tr class="color-b1">
                            <td>${(budgetContentItem.title)!""}</td>
                            <td>${(budgetContentItem.value)!""}</td>
                        </tr>
                        <#if (budgetContentItem.children)?? && (budgetContentItem.children.list?size > 0)>
                            <#list budgetContentItem.children.list as item>
                                <!-- 判断 是否 可分配预算 -->
                                <#if (item.children)?? && (item.children.list)??>
                                    <tr class="color-b2">
                                        <td>${(item.title)!""}</td>
                                        <td>${(item.value)!""}</td>
                                    </tr>
                                    <#list item.children.list as a>
                                        <tr class="color-b3 data-x-budget-mobile h-20px"
                                            data-x-budget-sum-mobile="${(item.value)!0}"
                                            data-x-budget-mobile="${(a.value)!0}">
                                            <td>${(a.title)!""}</td>
                                            <td>${(a.value)!""}</td>
                                        </tr>
                                    </#list>
                                <#else>
                                    <tr class="color-b2">
                                        <td>${(item.title)!""}</td>
                                        <td>${(item.value)!""}</td>
                                    </tr>
                                </#if>
                            </#list>
                        </#if>
                        </tbody>
                    </table>
                </div>

            </#list>
        </#if>

    </div>
    <#assign budgetUser=data.budgetUser>
    <#if budgetUser?? && (budgetUser?size > 0)>
        <div class="wrapper__body--box">
            <p style="padding: 10px">当前期间人员预算使用情况</p>
            <div class="wrapper__table--2">
                <table style="width: 100%">
                    <thead>
                    <tr>
                        <td>人员</td>
                        <td>占用额度</td>
                        <td>占比</td>
                    </tr>
                    </thead>
                    <tbody>
                    <#list budgetUser as item>
                        <tr>
                            <td>${(item.name)!""}</td>
                            <td>${(item.used)!""}</td>
                            <td>${(item.percentage)!""}</td>
                        </tr>
                    </#list>
                    </tbody>
                </table>
            </div>
        </div>
        <div style="height: 10px"></div>
    </#if>
</div>
</#list>



<script>
    const colors = [
        "#194a7a",
        "#476f95",
        "#7593af",
        "#503d5c",
        "#624b6e",
        "#6f597a",
        "#8b7991",
        // "#af92b5",
        // "#273d44",
        // "#6198aa",
        // "#453ab2",
        // "#6640a7",
        // "#87469b",
        // "#87cedc",
        // "#53b5c0",
        // "#6dc1ce",
        // "#594b4b",
    ];

    const nodes1 = document.getElementsByClassName("hzh-tb1__sum");
    const nodes2 = document.getElementsByClassName("hzh-tb1__chd");
    let j = 0;
    for (let i of [...nodes1, ...nodes2]) {
        if (j > colors.length) {
            j = 0;
        }
        i.style.backgroundColor = colors[j];
        j++;
    }

    const nodes3 = document.getElementsByClassName('data-x-budget-sum')
    if (nodes3 && nodes3.length) {
        for (let node3 of nodes3) {
            const domList = node3.getElementsByTagName('div')
            const sum = +node3.getAttribute('data-x-budget-sum').replaceAll(',', '');

            if (domList) {
                // 余额负数
                if (domList[0].getAttribute('data-x-budget').replaceAll(',', '') - 0 > sum) {
                    domList[2].style.display = 'none'
                    domList[0].style.backgroundColor = 'red'
                    domList[1].style.backgroundColor = 'red'
                } else if (domList[0].getAttribute('data-x-budget').replaceAll(',', '') - 0 + (domList[1].getAttribute('data-x-budget').replaceAll(',', '') - 0) > sum) {
                    domList[2].style.display = 'none'
                    domList[0].style.backgroundColor = 'red'
                    domList[1].style.backgroundColor = 'red'
                }

            }
        }

    }

    const containers = document.getElementsByClassName('wrapper__table--3')
    if (containers && containers.length) {
        for (let container of containers) {

            const nodes4 = container.getElementsByClassName('data-x-budget-mobile')
            const sum4 = + nodes4[0].getAttribute('data-x-budget-sum-mobile').replaceAll(',', '')

            if (nodes4) {
                // 余额负数
                if (nodes4[0].getAttribute('data-x-budget-mobile').replaceAll(',', '') - 0 > sum4) {
                    nodes4[2].style.display = 'none'
                    nodes4[0].style.backgroundColor = 'red'
                    nodes4[1].style.backgroundColor = 'red'
                } else if (nodes4[0].getAttribute('data-x-budget-mobile').replaceAll(',', '') - 0 + (nodes4[1].getAttribute('data-x-budget-mobile').replaceAll(',', '') - 0) > sum4) {
                    nodes4[2].style.display = 'none'
                    nodes4[0].style.backgroundColor = 'red'
                    nodes4[1].style.backgroundColor = 'red'
                }
            }
        }
    }

</script>
</body>
</html>
