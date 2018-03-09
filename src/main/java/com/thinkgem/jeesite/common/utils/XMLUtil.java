package com.thinkgem.jeesite.common.utils;


import java.io.FileNotFoundException;
import java.io.FileOutputStream;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.alibaba.fastjson.JSON;


/***
 * xml帮助类
 *
 * @author whoami
 */
public class XMLUtil {


    public static void output(Node node) {//将node的XML字符串输出到控制台
        TransformerFactory transFactory = TransformerFactory.newInstance();
        try {
            Transformer transformer = transFactory.newTransformer();
            transformer.setOutputProperty("encoding", "utf-8");
            transformer.setOutputProperty("indent", "yes");
            DOMSource source = new DOMSource();
            source.setNode(node);
            StreamResult result = new StreamResult();
            result.setOutputStream(System.out);

            transformer.transform(source, result);
        } catch (TransformerConfigurationException e) {
            e.printStackTrace();
        } catch (TransformerException e) {
            e.printStackTrace();
        }
    }

    public static Node selectSingleNode(String express, Object source) {//查找节点，并返回第一个符合条件节点
        Node result = null;
        XPathFactory xpathFactory = XPathFactory.newInstance();
        XPath xpath = xpathFactory.newXPath();
        try {
            result = (Node) xpath.evaluate(express, source, XPathConstants.NODE);
        } catch (XPathExpressionException e) {
            e.printStackTrace();
        }

        return result;
    }

    public static NodeList selectNodes(String express, Object source) {//查找节点，返回符合条件的节点集。
        NodeList result = null;
        XPathFactory xpathFactory = XPathFactory.newInstance();
        XPath xpath = xpathFactory.newXPath();
        try {
            result = (NodeList) xpath.evaluate(express, source, XPathConstants.NODESET);
        } catch (XPathExpressionException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void saveXml(String fileName, Document doc) {//将Document输出到文件
        TransformerFactory transFactory = TransformerFactory.newInstance();
        try {
            Transformer transformer = transFactory.newTransformer();
            transformer.setOutputProperty("indent", "yes");
            DOMSource source = new DOMSource();
            source.setNode((Node) doc);
            StreamResult result = new StreamResult();
            result.setOutputStream(new FileOutputStream(fileName));

            transformer.transform(source, result);
        } catch (TransformerConfigurationException e) {
            e.printStackTrace();
        } catch (TransformerException e) {
            e.printStackTrace();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }


    /***
     * 根据传入的XML字符串获取属性和值
     *
     * @param @param  xmlString
     * @param @return
     * @return HashMap<String,String>
     * @throws
     * @Description: TODO
     * @author lqz
     * @date 2015年6月15日
     */
    public static HashMap<String, String> getXMLProperty(String xmlString) {
        HashMap<String, String> resultMap = new HashMap<String, String>();
        try {
            Document document = DocumentHelper.parseText(xmlString);
            Element element = document.getRootElement();
            for (Iterator i = element.elementIterator(); i.hasNext(); ) {
                Element element2 = (Element) i.next();
                String name = element2.getName();
                String value = element2.getText();


                resultMap.put(name, value);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultMap;
    }


    public static PageData getLBSXMLProperty(String xmlString) {
        PageData result = new PageData();
        try {
        	Map<String, Object> pd = JSON.parseObject(xmlString);
            //JSONObject srcJsonObjectResult = XML.toJSONObject(xmlString);
            result.putAll(pd);
//            JSONArray jsonObjectArr = srcJsonObjectResult.getJSONObject("string").getJSONObject("category").getJSONArray("property");
//            int length = jsonObjectArr.length();
//            for (int i = 0; i < length; i++) {
//                JSONObject jsonObject = jsonObjectArr.getJSONObject(i);
//                result.put(jsonObject.get("name"), jsonObject.get("value"));
//            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
