<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>充值</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/personal/count.css">
     <style type="text/css">
    body{
        padding: 0;
        margin: 0;
        width: 100%;
        margin: 0 auto;
        text-align: center;
        border: 1px solid #D6D3CE;
        font-family: "微软雅黑";
    }
    ul p span a input td{
        font-family: "微软雅黑";
    }
    .regbt {
            width: 55px;
            height: 35px;
            border: solid 1px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            color: white;
            margin-top: 0px;
            font-size: 16px;
        }
    </style>
</head>
<body>
        <div class="withdraw_cash_wrap">
        <p class="user_data">
            <img src="/static/images/wlptfront/line-left.png"><span class="title_blue">账户</span><span class="title_orange">充值</span><img src="/static/images/wlptfront/line-right.png">
        </p>
            <table>
                <tr>
                    <td></td>
                    <td class="left_title" style="text-align: left;width:50%;float:right;">银联在线充值：</td>
                </tr>
                <tr>
                    <td></td>
                    <td class="left_title" style="text-align: left;width:50%;float:right;" id="accountName">账户名：</td>
                </tr>
                <tr>
                    <td></td>
                    <td class="left_title" style="text-align: left;width:50%;float:right;" id="bankAccount">账户号：</td>
                </tr>
                <tr>
                    <td colspan="2" class="right_con cash_type_list" style="text-align: center;padding-top: 30px;">
                        <input id="btnSubmit" class="regbt" type="button" value="返回" onclick="history.go(-1)"/>
                    </td>
                </tr>
            </table>
            <div class="kind_reminder">
                <h5>温馨提示：</h5>
                 <p>平台支持银联在线转账充值，转账成功之后可以在账户中心刷新查看充值的金额。</p>
                 
            </div>
        </div>
        <script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
        <script type="text/javascript">
        var memberId="${user.memberId}";
	        $.ajax({
	            url: "${wlpt}/wlpt/consume/virtAcctList",
	            dataType: 'json',
	            data:{"memberId":memberId,"status":'1'},
	            type: "post",
	            success: function (data) {
	               if(data.status==200){
	            	   $("#bankAccount").html("账户号："+data.body.records[0].bankAccount);
	            	   $("#accountName").html("账户名："+data.body.records[0].accountName);
	               }
	            }
	        });
        </script>
</body>
</html>
