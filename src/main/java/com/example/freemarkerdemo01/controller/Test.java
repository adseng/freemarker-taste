package com.example.freemarkerdemo01.controller;

import com.alibaba.fastjson.JSON;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class Test {

    @GetMapping("/test01")
    public String get01() throws IOException, TemplateException {
        Configuration cfg = new Configuration(Configuration.getVersion());
        cfg.setDirectoryForTemplateLoading(new File("C:\\MyData\\project\\javaSpace\\freemarker-demo01\\src\\main\\resources\\templates"));
        cfg.setDefaultEncoding("utf-8");
        Template template = cfg.getTemplate("plan-pie.html.ftl");

        Map map = new HashMap();
        map.put("budgetPeriod", "2022年/11月");
        map.put("costcenter", "西北地区");
        List list1 = new ArrayList();
        list1.add("{\"title\":\"月度计划-不同活动类型额度占比\\n（包含当前待审批的月度计划）\",\"value\":100,\"children\":{\"list\":[{\"title\":\"活动类型1\",\"value\":40},{\"title\":\"活动类型2\",\"value\":40},{\"title\":\"活动类型3\",\"value\":20}]}}");
        list1.add("{\"title\":\"月度计划-不同活动类型额度占比\\n（不包含当前待审批的月度计划）\",\"value\":100,\"children\":{\"list\":[{\"title\":\"活动类型1\",\"value\":40},{\"title\":\"活动类型2\",\"value\":40},{\"title\":\"活动类型3\",\"value\":20}]}}");
        map.put("budgetContent", list1);
        Map map1 = new HashMap();
        List list = new ArrayList<>();
        list.add(map);
        list.add(map);
        map1.put("array", list);

        StringWriter stringWriter = new StringWriter();
        template.process(map1, stringWriter);
        String resultStr = stringWriter.toString();
//        System.out.println(resultStr);

        return resultStr;
    }

    @GetMapping("/test02")
    public String get02() throws IOException, TemplateException {
        Configuration cfg = new Configuration(Configuration.getVersion());
        cfg.setDirectoryForTemplateLoading(new File("C:\\MyData\\project\\javaSpace\\freemarker-demo01\\src\\main\\resources\\templates"));
        cfg.setDefaultEncoding("utf-8");
        Template template = cfg.getTemplate("buget-view.html.ftl");

        String str = "{\n" +
                "  \"budgetPeriod\": \"2022年/11月\",\n" +
                "  \"costcenter\": \"西北地区\",\n" +
                "  \"budgetContent\": [\n" +
                "    {\n" +
                "      \"title\": \"预算总额（按年度累计至今）\",\n" +
                "      \"value\": 12000,\n" +
                "      \"children\": {\n" +
                "        \"group\": \"冻结\",\n" +
                "        \"list\": [\n" +
                "          {\n" +
                "            \"title\": \"库存\",\n" +
                "            \"value\": 1000\n" +
                "          },\n" +
                "          {\n" +
                "            \"title\": \"二次议价\",\n" +
                "            \"value\": 1000\n" +
                "          },\n" +
                "          {\n" +
                "            \"title\": \"讲课税费\",\n" +
                "            \"value\": 1000\n" +
                "          },\n" +
                "          {\n" +
                "            \"title\": \"视同销售税金\",\n" +
                "            \"value\": 1000\n" +
                "          },\n" +
                "          {\n" +
                "            \"title\": \"其他\",\n" +
                "            \"value\": 1000\n" +
                "          },\n" +
                "          {\n" +
                "            \"title\": \"未分配\",\n" +
                "            \"value\": 1000\n" +
                "          },\n" +
                "          {\n" +
                "            \"title\": \"可使用预算\",\n" +
                "            \"value\": 6000,\n" +
                "            \"children\": {\n" +
                "              \"group\": \"可使用预算\",\n" +
                "              \"list\": [\n" +
                "                {\n" +
                "                  \"title\": \"占用\",\n" +
                "                  \"value\": 6000\n" +
                "                },\n" +
                "                {\n" +
                "                  \"title\": \"待审单据\",\n" +
                "                  \"value\": 2000\n" +
                "                },\n" +
                "                {\n" +
                "                  \"title\": \"剩余\",\n" +
                "                  \"value\": 3000\n" +
                "                }\n" +
                "              ]\n" +
                "            }\n" +
                "          }\n" +
                "        ]\n" +
                "      }\n" +
                "    }\n" +
                "  ],\n" +
                "  \"budgetUser\": [\n" +
                "    {\n" +
                "      \"name\": \"张三\",\n" +
                "      \"used\": 200,\n" +
                "      \"percentage\": \"8%\"\n" +
                "    },\n" +
                "    {\n" +
                "      \"name\": \"李四\",\n" +
                "      \"used\": 300,\n" +
                "      \"percentage\": \"13%\"\n" +
                "    },\n" +
                "    {\n" +
                "      \"name\": \"下属成本中心累计\",\n" +
                "      \"used\": 800,\n" +
                "      \"percentage\": \"33%\"\n" +
                "    }\n" +
                "  ]\n" +
                "}\n";
        StringWriter stringWriter = new StringWriter();
        Map map = JSON.parseObject(str, Map.class);
        List l1 = new ArrayList();
        l1.add(map);
        l1.add(map);
        Map map1 = new HashMap();
        map1.put("array", l1);
        template.process(map1, stringWriter);
        String resultStr = stringWriter.toString();
//        System.out.println(resultStr);

        return resultStr;
    }

}
