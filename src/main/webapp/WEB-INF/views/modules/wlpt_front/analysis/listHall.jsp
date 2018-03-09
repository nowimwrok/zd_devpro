<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <meta http-equiv="refresh" content="300" /> 
    <title>货源</title>
     
     <script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
     <style type="text/css">
       <!--
       .STYLE1 {
           color: #FF0000;
       }

       .tab1 {
           border-collapse: collapse;
           margin: auto;
       }
        

        .tab1 td
        {
            border: #FF0000 solid 1px;
            height: 25px;
            border-bottom-width:0px;
        }       table tr td {
           text-align: center;
       }
       -->
         /*div
        {
            border: solid 0px #0a0;
            font-size: 12px;
            overflow: hidden;
            width: 400px;
            margin: 1em auto;
        }*/ 

          div
        {
            border: solid 0px #0a0;
            font-size: 12px;
            overflow: hidden;
            width: 400px;
        } 
       .main {
           border: solid 0px #0a0;
           font-size: 12px;
           overflow: hidden;
           margin: 1em auto;
           width: 832px;
           height: 416px;
           text-align: center;
           background-color: #000000;
           color: #FF0000;
       }

       #tabGoods tr {
           height: 30px;
       }
       
       .th {
           border-bottom-width:1px;
       }
   </style>


</head>
<body>

    <div class="main" >
         <div  style="float:left; margin-left:10px;"  >
             <div  style="height:20px; margin-top:10px; margin-bottom:5px; font-size:20px; font-weight:bold; " >
            邯钢•万事达智慧平台
             </div>
              <table width="400px" border="0" cellpadding="0" cellspacing="0" id="tabGoods" class="tab1" bordercolor="#FF0000" bgcolor="#000000">
                <tr >
                    <td   align="center"  colspan="4" style="height:28px;font-size:14px;">
                        <b>货源信息</b>
                    </td>
                </tr>
                <tr>
                    <td width="25%" style="border-bottom-width:1px;">运输日期</td>
                    <td width="25%" style="border-bottom-width:1px;">货物名称</td>
                    <td width="20%" style="border-bottom-width:1px;">吨数</td>
                    <td width="30%" style="border-bottom-width:1px;">运输方向</td>
                </tr>
            
            </table>

       <div class="seamless" name="seamless"  style="height: 295px; margin-top: 0px; margin-bottom: 0px;border-bottom:solid 1px #FF0000;" delay="50">
               <table id="data_box" width="100%" border="0" cellpadding="0" cellspacing="0" class="tab1" style="border-bottom-width:0px;border-top-width:0px;">              
               </table>
    
 </div>      
              
              <div  style="height:20px; margin-top:2px; margin-bottom:1px; font-size:14px; font-weight:bold;" >

                 监督电话：0310-3188756

             </div>
          </div>
         
        <div  style="float:right; margin-right:10px; ">
             <div  style="height:20px; margin-top:10px; margin-bottom:5px; font-size:20px; font-weight:bold;" >
                 招标信息
             </div>
              <table width="400px" border="0" cellpadding="0" cellspacing="0" id="Table1" class="tab1" bordercolor="#FF0000" bgcolor="#000000">
             
                <tr>
                      <td width="60%" style="border-bottom-width:1px;">项目名称 </td>
                      <td width="40%" style="border-bottom-width:1px;">招标状态</td>
                      
                </tr>
            
            </table> 
            
                 
<div class="seamless" name="seamless" style="height: 78px; margin-top: 0px; margin-bottom: 0px;border-bottom:solid 1px #FF0000;" delay="50">
    <table id="biddata_box" width="100%" border="0" cellpadding="0" cellspacing="0" class="tab1" style="border-bottom-width:0px;border-top-width:0px;">
    </table>
  
      
      
</div>
 
   
          </div>
         

          <div  style="float:right; margin-right:10px;">
             <div  style="height:20px;  font-size:20px; font-weight:bold; margin-bottom:5px; margin-top:5px;" >
                车源信息
             </div>
                <table width="400px" border="0" cellpadding="0" cellspacing="0" id="Table2" class="tab1" bordercolor="#FF0000" bgcolor="#000000">
                <tr>
                    <td width="25%" style="border-bottom-width:1px;">车型</td>
                    <td width="30%" style="border-bottom-width:1px;">车号</td>
                    <td width="23%" style="border-bottom-width:1px;">主要路线</td>
                    <td width="22%" style="border-bottom-width:1px;">联系电话</td>
                </tr>
            </table>

                   
 <div class="seamless" name="seamless"  style="height: 193px; margin-top: 0px; margin-bottom: 0px;border-bottom:solid 1px #FF0000;" delay="50">
    <table id="cardata_box" width="100%" border="0" cellpadding="0" cellspacing="0" class="tab1" style="border-bottom-width:0px;border-top-width:0px;">
    </table>
</div>
 
 
         
                

              <div  id="divTime" style="height:20px; margin-top:2px; margin-bottom:1px; font-size:14px; font-weight:bold;" >
                 
             </div>
          </div>
         
      
         </div>
        <div align="center" style="width:100%;"><input type="button" value="刷新" onclick="history.go(0)"><input type="button" value="返回" onclick="    javascript: history.go(-1);"></div>  



 
    <script type="text/javascript">
        (function (c) {
           // var obj = document.getElementsByTagName("div");
            var obj = document.getElementsByName("seamless");
            var _l = obj.length;
            var o;
            for (var i = 0; i < _l; i++) {
                o = obj[i];
              
                var n2 = o.clientHeight;
                var n3 = o.scrollHeight;
             
                o.s = 0;
                debugger;
                if (o.className.indexOf(c) >= 0) {
                    //                if (n3 <= n2) { return false; }
                    var delay = parseInt(o.getAttribute("delay"), 30);
                    if (isNaN(delay)) { delay = 30; }
                    if (o.className.indexOf("allowStop") >= 0) {
                        o.onmouseover = function () { this.Stop = true; }
                        o.onmouseout = function () { this.Stop = false; }
                    }
                    giveInterval(autoRun, delay, o);
                    //关键之处！！
                    o.innerHTML = o.innerHTML + o.innerHTML + o.innerHTML + o.innerHTML;
                 
                 
                }
            }
            //注册函数
            function giveInterval(funcName, time) {
                var args = [];
                for (var i = 2; i < arguments.length; i++) {
                    args.push(arguments[i]);
                }
                return window.setInterval(function (){ funcName.apply(this, args); }, time);
            }
            function autoRun(o, s) {
                if (o.Stop == true) { return false; }
                var n1 = o.scrollTop;
                var n3 = o.scrollHeight;
                o.s++;
                o.scrollTop = o.s;
                if (n1 >= n3 / 2) {
                    o.scrollTop = 0;
                    o.s = 0;
                }
            }
        })('seamless')


        $(function () {
            CurentTime();
        });
       
        function CurentTime() {
            var now = new Date();

            var year = now.getFullYear();       //年
            var month = now.getMonth() + 1;     //月
            var day = now.getDate();            //日

            var hh = now.getHours();            //时
            var mm = now.getMinutes();          //分
            var ss = now.getSeconds();
            var clock = year + "-";

            if (month < 10)
                clock += "0";

            clock += month + "-";

            if (day < 10)
                clock += "0";

            clock += day + " ";

            if (hh < 10)
                clock += "0";

            clock += hh + ":";
            if (mm < 10) clock += '0';
            clock += mm;

            clock +=":";
            if (ss < 10) clock += '0';
            clock += ss;
             
            $("#divTime").html(clock);
            setTimeout("CurentTime()", "1000");
           // return (clock);
           
        }
</script>
<script type="text/javascript">
	$(function (){
		getData();
		getBidData();
		getCarData();
		function getData() {
			var searchConditions = {};
			searchConditions.pageSize = 100;
			searchConditions.pageNo = 1;
			searchConditions.orderBy = "";
			$.ajax({
						type : "POST",
						url : '${wlpt}/wlpt/hall/getLEDGoodsList',
						data : searchConditions,
						dataType : 'json',
						cache : false,
						success : function(data) {
								if (data.value.list.length <= 0) {
									$("#data_box").show().append(
													'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
								} else {
									var fillDatas = "";
									for (var i = 0; i < data.value.list.length; i++) {
										fillDatas += fillDataOne(data.value.list[i]);
									}
									$("#data_box").html("");
									$("#data_box").append(fillDatas);
									
									
								}
							}
						
					});
		}
		function fillDataOne(data) {
			var to = data.consignAddress.province + data.consignAddress.city;
			var _date='';
			if(data.sendtime==null){
				_date="----";
			}else{
				 _date=new Date(data.sendtime);
				_date=_date.format("yyyy-MM-dd");
			}  
			var html = '<tr><td width="25%">'+_date+'</td>'
			+'<td width="25%">'+(data.goodsname!=null?data.goodsname:"暂无")+'</td>'
            +'<td width="20%">'+(data.freightvolume!=null?data.freightvolume:"暂无")+'</td>'
            +'<td width="30%">'+(to!=null?to:"暂无")+'</td></tr>';
			return html;
		}
	
		function getBidData() {
			var searchConditions = {};
			searchConditions.pageSize = 100;
			searchConditions.pageNo = 1;
			searchConditions.orderBy = "";
			$.ajax({
						type : "POST",
						url : '${wlpt}/wlpt/hall/getbidsList',
						data : searchConditions,
						dataType : 'json',
						cache : false,
						success : function(data) {
								if (data.value.list.length <= 0) {
									$("#biddata_box").show().append(
													'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
								} else {
									var fillDatas = "";
									for (var i = 0; i < data.value.list.length; i++) {
										fillDatas += fillBidDataOne(data.value.list[i]);
									}
									$("#biddata_box").html("");
									$("#biddata_box").append(fillDatas);
									/* setTimeout(getData, 3000); */
									
								}
							}
						
					});
		}
		function fillBidDataOne(data) {
			//var _dates=data.ENDTIME;
			//if(_dates==null){
			//	_dates="-----";
			//}else{
			//	_dates=new Date(_dates);
			//	_dates=_dates.format("yyyy-MM-dd");	
			//}
			var bidstatus=data.bidstatus;
			var toaddress=data.goods.shipAddress.city+"-"+data.goods.consignAddress.city;
			var html = '<tr><td width="60%">'+(data.goods.goodsname!=null?data.goods.goodsname:"暂无")+","+(data.goods.freightvolume!=null?data.goods.freightvolume:"暂无")+"吨," +(toaddress!=null?toaddress:"暂无") +'</td>'
            +'<td width="40%">'+bidstatus+'</td></tr>';
			return html;
		}
		
		function getCarData() {
			var searchConditions = {};
			searchConditions.pageSize = 100;
			searchConditions.pageNo = 1;
			searchConditions.orderBy = "";
			$.ajax({
						type : "POST",
						url : '${wlpt}/wlpt/hall/getLEDCarList',
						data : searchConditions,
						dataType : 'json',
						cache : false,
						success : function(data) {
								if (data.value.list.length <= 0) {
									$("#cardata_box").show().append(
													'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
								} else {
									var fillDatas = "";
									for (var i = 0; i < data.value.list.length; i++) {
										fillDatas += fillCarDataOne(data.value.list[i]);
									}
									$("#cardata_box").html("");
									$("#cardata_box").append(fillDatas);
									 /* setTimeout(getCarData, 3000); */ 
									
								}
							}
						
					});
		}
		

		
		function fillCarDataOne(data) {
			var phone=data.user.phone!=null?data.user.phone:"暂无";
			if(phone.length<11){
				phone="暂无";
			}
			var mainroad=data.mainroad!=null?data.mainroad:"暂无";
			if(mainroad!=null){
			if(mainroad.indexOf("-")>0&&mainroad.length>=7){
				mainroad=mainroad.split("-")[1].substring(0,7);
			}else if(mainroad.indexOf("-")>0&&mainroad.length>=3){
				if(mainroad.split("-")[1].length>=3){
					mainroad=mainroad.split("-")[1];
				}else{
					mainroad=mainroad.split("-")[0];
				}
		 	 }
			}
			if(mainroad.length<3){
				mainroad="暂无";
			}
			var html = '<tr><td width="25%">'+data.cartype+'</td>'
            +'<td width="30%">'+(data.carnumber!=null?data.carnumber:"暂无")+'</td>'
            +'<td width="23%">'+(mainroad!=null?mainroad:"暂无")+'</td>'
            +'<td width="22%">'+phone+'</td></tr>';
			return html;
		}
		
		
		
		//格式化日期
		Date.prototype.format = function(format) {
			/*
			 * eg:format="YYYY-MM-dd hh:mm:ss";
			 */
			var o = {
				"M+" : this.getMonth() + 1, //month
				"d+" : this.getDate(), //day
				"h+" : this.getHours(), //hour
				"m+" : this.getMinutes(), //minute
				"s+" : this.getSeconds(), //second
				"q+" : Math.floor((this.getMonth() + 3) / 3), //quarter
				"S" : this.getMilliseconds()
			//millisecond
			};

			if (/(y+)/.test(format)) {
				format = format.replace(RegExp.$1, (this.getFullYear() + "")
						.substr(4 - RegExp.$1.length));
			}

			for ( var k in o) {
				if (new RegExp("(" + k + ")").test(format)) {
					format = format.replace(RegExp.$1,
							RegExp.$1.length == 1 ? o[k] : ("00" + o[k])
									.substr(("" + o[k]).length));
				}
			}
			return format;
		};
	});
</script>
</body>
</html>

