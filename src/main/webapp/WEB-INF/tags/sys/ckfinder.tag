<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@ attribute name="input" type="java.lang.String" required="true" description="输入框" %>
<%@ attribute name="type" type="java.lang.String" required="true" description="files、images、flash、thumb" %>
<%@ attribute name="uploadPath" type="java.lang.String" required="true" description="打开文件管理的上传路径" %>
<%@ attribute name="selectMultiple" type="java.lang.Boolean" required="false" description="是否允许多选" %>
<%@ attribute name="readonly" type="java.lang.Boolean" required="false" description="是否查看模式" %>
<%@ attribute name="isdelall" type="java.lang.Boolean" required="false" description="删除所有" %>
<%@ attribute name="maxnumber" type="java.lang.String" required="false" description="图片上传张数" %>
<%@ attribute name="btnName" type="java.lang.String" required="false" description="按钮名字" %>
<%@ attribute name="maxWidth" type="java.lang.String" required="false" description="最大宽度" %>
<%@ attribute name="maxHeight" type="java.lang.String" required="false" description="最大高度" %>

<style type="text/css">
    .upbtn {
        background-color: #FFC52F;
        color: #FFFFFF;
        width: 120px;
        height: 25px;
        line-height: 25px;
        display: inline-block;
        margin-bottom: 0;
        font-size: 14px;
        font-weight: 400;
        text-align: center;
        white-space: nowrap;
        vertical-align: middle;
        cursor: pointer;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
        border: 1px solid transparent;
        border-radius: 4px;
    }
    ol {
        padding: 0;
        margin: 0 0 10px 0px;
    }
    ol li a{
        width: 17px;
        height: 18px;
        line-height: 18px;
        border-radius: 18px;
        background: rgba(255, 0, 0, 0.82);
        text-align: center;
        color: #FFFFFF;
        position: absolute;
       margin-left: -20px; 

    }
	
    ol li img {
        border: none;
        margin: 0px auto;
    }
    ol,ol li{
        list-style: none;
    }


</style>
<ol id="${input}Preview"></ol><div>
<c:if test="${!readonly}"></div><div id="clear" style="clear:both"><a href="javascript:" onclick="${input}FinderOpen();"
                             class="upbtn">${btnName !=null ? btnName:selectMultiple?'添加':'选择'}</a><div><c:if
        test="${isdelall}">&nbsp;<a href="javascript:" onclick="${input}DelAll();" class="upbtn">清除</a></c:if> </c:if>
        </div>
<script type="text/javascript">
    var maxnumber="${maxnumber}";
    function ${input}FinderOpen() {//<c:if test="${type eq 'thumb'}"><c:set var="ctype" value="images"/></c:if><c:if test="${type ne 'thumb'}"><c:set var="ctype" value="${type}"/></c:if>
        var date = new Date(), year = date.getFullYear(), month = (date.getMonth() + 1) > 9 ? date.getMonth() + 1 : "0" + (date.getMonth() + 1);
        var url = "${ctxStatic}/ckfinder/ckfinder.html?type=${ctype}&start=${ctype}:${uploadPath}/" + year + "/" + month +
                "/&action=js&func=${input}SelectAction&thumbFunc=${input}ThumbSelectAction&cb=${input}Callback&dts=${type eq 'thumb'?'1':'0'}&sm=${selectMultiple?1:0}";
        windowOpen(url, "文件管理", 1000, 700);
        //top.$.jBox("iframe:"+url+"&pwMf=1", {title: "文件管理", width: 1000, height: 500, buttons:{'关闭': true}});
    }
    function ${input}SelectAction(fileUrl, data, allFiles) {
        var url = "", files = ckfinderAPI.getSelectedFiles();
        var curnum = $("#${input}").val().split("|");
        var maxnum="${not empty maxnumber?maxnumber:0}";
        if(maxnum != ""&& maxnum*1>0){
        	if(maxnum*1<curnum.length){
            	return;
            }
        }
        
        for (var i = 0; i < files.length; i++) {//<c:if test="${type eq 'thumb'}">
            url += files[i].getThumbnailUrl();//</c:if><c:if test="${type ne 'thumb'}">
            url += files[i].getUrl();//</c:if>
            if (i < files.length - 1) url += "|";

        }//<c:if test="${selectMultiple}">
        $("#${input}").val($("#${input}").val() + ($("#${input}").val(url) == "" ? url : "|" + url));//</c:if><c:if test="${!selectMultiple}">
        $("#${input}").val(url);//</c:if>
        ${input}Preview();
        //top.$.jBox.close();
    }
    function ${input}ThumbSelectAction(fileUrl, data, allFiles) {
        var url = "", files = ckfinderAPI.getSelectedFiles();
        var curnum = $("#${input}").val().split("|");
        var maxnum="${not empty maxnumber?maxnumber:0}";
        if(maxnum != ""&& maxnum*1>0){
	        if(maxnum*1<curnum.length){
	        	return;
	        }
        }
        for (var i = 0; i < files.length; i++) {
            url += files[i].getThumbnailUrl();
            if (i < files.length - 1){
            	url += "|";
            }
            
        }//<c:if test="${selectMultiple}">
        $("#${input}").val($("#${input}").val() + ($("#${input}").val(url) == "" ? url : "|" + url));//</c:if><c:if test="${!selectMultiple}">
        $("#${input}").val(url);//</c:if>
        ${input}Preview();
        //top.$.jBox.close();
    }
    function ${input}Callback(api) {
        ckfinderAPI = api;
    }
    function ${input}Del(obj) {
        var url = $(obj).prev().attr("url");
        $("#${input}").val($("#${input}").val().replace("|" + url, "", "").replace(url + "|", "", "").replace(url, "", ""));
        ${input}Preview();
    }
    function ${input}DelAll() {
        $("#${input}").val("");
        ${input}Preview();
    }
    function ${input}Preview() {
        var li, urls = $("#${input}").val().split("|");
        var maxnum="${not empty maxnumber?maxnumber:0}";
        if(maxnum != ""&& maxnum*1>0){
	        if (maxnum*1<urls.length-1){
	            return;
	        }
        }
        $("#${input}Preview").children().remove();
        for (var i = 0; i < urls.length; i++) {
            if (urls[i] != "") {//<c:if test="${type eq 'thumb' || type eq 'images'}">
                li = "<li><a target='_blank' href=\""+urls[i]+"\"data-lightbox=\""+i+"\"></a><img  onerror=\"this.onerror=null;this.src='${ctxStatic}/images/wlptfront/photo.png'\" src=\"" + urls[i] + "\" url=\"" + urls[i] + "\" style=\"max-width:${empty maxWidth ? 200 : maxWidth}px;max-height:${empty maxHeight ? 200 : maxHeight}px;_height:${empty maxHeight ? 200 : maxHeight}px;border:0;padding:3px;\">";//</c:if><c:if test="${type ne 'thumb' && type ne 'images'}">
                li = "<li><a  href=\"" + urls[i] + "\" url=\"" + urls[i] + "\" target=\"_blank\">" + decodeURIComponent(urls[i].substring(urls[i].lastIndexOf("/") + 1)) + "</a>";//</c:if>
                li += "&nbsp;&nbsp;<c:if test="${!readonly}"><a href=\"javascript:\" onclick=\"${input}Del(this);\">×</a></c:if></li>";
                $("#${input}Preview").append(li);
            }

        }
        if ($("#${input}Preview").text() == "") {
            $("#${input}Preview").html("<li style='list-style:none;padding-top:5px;'><img  onerror=\"this.onerror=null;this.src='${ctxStatic}/images/wlptfront/photo.png'\" id='showimg' src='${ctxStatic }/images/wlptfront/photo.png' class='photo-dis'></li>");
        }
    }
    ${input}Preview();
</script>
