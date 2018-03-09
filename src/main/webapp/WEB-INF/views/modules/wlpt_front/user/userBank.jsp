<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>

<!doctype html>
<html ng-app="userBankApp" ng-controller="userBankCtrl">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <title>银行卡管理</title>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
            font-family: "Microsoft YaHei";
        }

        ul {
            list-style: none;
        }

        a {
            text-decoration: none;
        }

        body {
            padding: 0;
            width: 100%;
            border: 1px solid #D6D3CE;
        }

        /*以下---------------银行卡列表样式*/
        .card_list_rows {
            overflow: hidden;
            zoom: 1;
            padding: 2px 0 0 10px;
            font-size: 12px;
        }

        .card_list_rows .card_box {
            float: left;
            overflow: hidden;
            width: 31%;
            height: 180px;
            margin: 0 17px 20px 0;
            background: #EFF0F1;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            _cursor: hand;
            border: 1px solid #DDDDDD;
        }

        .card_list_rows .card_box .card_box_line1 {
            border-radius: 4px 4px 0 0;
            height: 46px;
            position: relative;
        }

        .card_box_line1 .bank_logo {
            position: absolute;
            top: 13px;
            left: 12px;
            width: 16px;
            height: 16px;
        }

        .card_box_line1 .bank_name {
            position: absolute;
            top: 12px;
            left: 33px;
            overflow: hidden;
            width: 84px;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .card_box_line1 .bank_num4 {
            position: absolute;
            top: 12px;
            right: 60px;
        }

        .card_box_line1 .bank_cardType {
            background: url("${ctxStatic}/images/wlptfront/card_type.png") no-repeat left top;
            position: absolute;
            top: 12px;
            right: 5px;
            overflow: hidden;
            width: 49px;
            height: 18px;
            text-indent: -9999px;
        }

        .card_box_line1:hover {
            zoom: 1;
            background: -webkit-gradient(linear, left top, left bottom, from(#FFFFFF), to(#E6E8EB));
            background: -moz-linear-gradient(top, #FFFFFF, #E6E8EB);
            background: -o-linear-gradient(top, #FFFFFF, #E6E8EB);
            background: linear-gradient(top, #FFFFFF, #E6E8EB);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FFFFFF', endColorstr='#E6E8EB');
            background-color: #FFFFFF;
            color: #666666;
        }

        .card_box_line2 .express-status {
            float: left;
            padding: 9px 10px 0 9px;
        }

        .express-status .pay_quick {
            display: inline-block;
            vertical-align: middle;
            _vertical-align: auto;
            width: 65px;
            height: 17px;
            background: url(${ctxStatic}/images/wlptfront/card_icon_10.png) no-repeat left top;
        }

        .card_box_line2 .card-manage {
            float: right;
            padding: 9px 9px 9px 10px;
        }

        .card_box_line2 .card-manage a {
            text-decoration: none;
            color: #5454ef;
        }

        .card_box_line2 {
            height: 37px;
            margin: 0 0 15px 0;
            background: #CFD2D4;
            border-top: 1px solid #ABADAF;
        }

        /*添加卡片样式*/
        .card_box_rows .add_card {
            float: left;
            width: 232px;
            margin: 0 17px 20px 0;
            border: none;
            background: #fff;
        }

        .add_card a, .add-card a:visited {
            display: block;
            overflow: hidden;
            zoom: 1;
            height: 130px;
            padding: 48px 0 0 0;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 700;
            border: 1px dashed #AACCDD;
            background: #fafafb;
            color: #5454ef;
            outline: none;
            cursor: pointer;
            -webkit-transition: all 0.15s ease-in;
            transition: all 0.15s ease-in;
        }

        .add_icon img {
            display: block;
            margin: 0 auto;
            vertical-align: -5px;
            width: 30px;
            height: 30px;
            cursor: pointer;
        }

        /*整个包裹层*/
        .card_list_wrap {
            margin: 0 auto;
        }

        .card_detail_wrap {
            position: relative;
        }

        .bank-bind-brief {
            width: 231px;
            position: absolute;
            z-index: 100;
            top: 15px;
            left: 16px;
            border: 3px solid rgba(175, 178, 183, 0.25);
            border-radius: 7px;
        }

        .bank-bind-brief .bank-bind-logo {
            position: relative;
            padding: 10px 0 0 15px;
            border-radius: 4px 4px 0 0;
            border: 1px solid #B6B9BE;
            border-bottom: none;
            background: #fff;
        }

        .bank-bind-brief .bank-bind-logo img {
            display: block;
        }

        .bank-bind-brief .bank-bind-logo .card-type-DC {
            background: url("${ctxStatic}/images/wlptfront/card_icon_02.png") no-repeat left top;
        }

        .bank-bind-brief .bank-bind-logo .card-type {
            position: absolute;
            top: 10px;
            right: 10px;
            overflow: hidden;
            width: 49px;
            height: 18px;
            text-indent: -9999px;
        }

        .bank-bind-brief .bank-bind-name {
            padding: 7px 5px 7px 15px;
            background: #FAFAFA;
            border: 1px solid #B6B9BE;
            border-top: 1px dashed #B6B9BE;
            color: #999999;
            border-radius: 0 0 4px 4px;
        }

        .bank-bind-account {
            font-size: 14px !important;
            padding-bottom: 10px;
        }

        .bank-bind-brief .bank-bind-name {
            padding: 7px 5px 7px 15px;
            background: #FAFAFA;
            border: 1px solid #B6B9BE;
            border-top: 1px dashed #B6B9BE;
            color: #999999;
            border-radius: 0 0 4px 4px;
            font-size: 13px;
        }

        .bank-bind-info {
            position: relative;
            padding: 0 0 0 220px;
            background: -webkit-gradient(linear, left top, left bottom, from(#F8F8F8), to(#F2F2F2));
            background: -moz-linear-gradient(top, #F8F8F8, #F2F2F2);
            background: -o-linear-gradient(top, #F8F8F8, #F2F2F2);
            background: linear-gradient(top, #F8F8F8, #F2F2F2);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#F8F8F8', endColorstr='#F2F2F2');
            background-color: #F2F2F2;
            border: 1px solid #E6E6E6;
        }

        .bank-bind-info .bank-bind-info-content {
            height: 30px;
            padding: 18px 0 40px;
            color: #808080;
        }

        .bank-bind-info .unbind {
            position: absolute;
            top: 58px;
            right: 10px;
        }

        .bank-bind-info .unbind a {
            color: #808080;
            font-weight: 400;
            padding: 0 9px 0;
            height: 19px;
            line-height: 19px;
            border: 1px solid #ccc;
            text-decoration: none;
            font-size: 14px;
        }

        a.ui-button-swhite {
            color: #8E8E8E;
            background: #F3F3F3;
            box-shadow: 0px 0px 1px 0px #FFF inset;
        }

        .bank-bind-attribute {
            padding: 56px 20px 30px 20px;
            background: #FFFFFF;
            border-top: 3px solid #4B90B6;
        }

        .attribute-icon {
            display: inline-block;
            overflow: hidden;
            vertical-align: middle;
            _vertical-align: auto;
            width: 40px;
            height: 40px;
            background: url("${ctxStatic}/images/wlptfront/quick_08.png") no-repeat left top;
        }

        .bank-bind-attribute .attribute-list {
            overflow: hidden;
            _overflow: inherit;
            zoom: 1;
            position: relative;
            _height: 1px;
            padding: 42px 0;
            border-bottom: 1px dashed #D9D9D9;
        }

        .bank-bind-attribute .attribute-list .attribute-name {
            position: absolute;
            top: 49px;
            left: 50px;
            font-size: 14px;
            font-weight: 700;
        }

        .bank-bind-attribute .attribute-list .attribute-value span {
            font-size: 12px;
            font-weight: 400;
            color: #666666;
        }

        .bank-bind-attribute .attribute-list .attribute-app {
            left: 120px;
            word-break: break-all;
            word-wrap: break-word;
            position: absolute;
            top: 49px;
            right: 0px;
            text-align: right;
            color: #999999;
            font-size: 12px;
        }

        .bank-bind-attribute .attribute-list .attribute-value {
            position: absolute;
            top: 49px;
            left: 168px;
            font-size: 14px;
            font-weight: 700;
            color: #FF6600;
        }

        .tb-container {
            margin-top: 35px;
            width: 400px;
            padding-left: 10px;
            background-color: #fffbe8;
            border: 1px solid #fceee0;
        }

        .tb-content {
            line-height: 1.5;
            padding: 11px 0px 11px 36px;
            color: #000;
            font-size: 12px;
            background: url("${ctxStatic}/images/wlptfront/icon_03.jpg") no-repeat center left;
            background-size: 26px 26px;
        }

        .popup_wrap {
            width: 670px;
            z-index: 999;
            position: absolute;
            left: 333.5px;
            top: 57px;
            display: block;
            background: rgb(255, 255, 255);
            zoom: 1;
            border: 5px solid #676767;
            display: none;
        }

        .alipay-xbox-close {
            color: #999;
            cursor: pointer;
            display: block;
            font-family: tahoma;
            font-size: 24px;
            font-weight: 700;
            height: 18px;
            line-height: 14px;
            position: absolute;
            right: 16px;
            text-decoration: none;
            top: 16px;
            z-index: 10;
        }

        .del-title {
            border-bottom: 1px solid #cccccc;
            padding: 12px 8px;
            background-color: #fafafa;
        }

        .fn-clear:after {
            visibility: hidden;
            display: block;
            font-size: 0;
            content: " ";
            clear: both;
            height: 0;
        }

        .del-title span {
            font-size: 18px;
            padding: 10px 10px 0;
            color: #4D4D4D;
            font-family: 'SimSun';
        }

        .del-title span, .del-body li {
            color: #4D4D4D;
            font-family: 'SimSun';
        }

        .rogatory-container {
            margin: 15px 20px 20px;
            background-color: #fafafa;
            padding-bottom: 10px;
        }

        .rogatory-container .rogatory-title, .del-body-div .del-body-title {
            background-color: #FFFFFF;
            padding-bottom: 10px;
        }

        .ft-bank-data {
            font-weight: bold;
        }

        .rogatory-container .rogatory-list, .del-body-div .del-body {
            border-top: 1px solid #d9d9d9;
            padding-left: 8px;
        }

        .rogatory-list {
            list-style: none;
            padding-bottom: 10px;
            color: #4D4D4D;
            padding: 10px;
            line-height: 40px;
            font-size: 14px;
        }

        #J-rogatory ul li {
            padding: 6px 0;
        }

        .safe-explain {
            border-top: 1px dashed #E8E8E8;
            margin: 8px 10px 8px 25px;
            padding: 6px 0;
            display: none;
        }

        .safe-explain ul li {
            padding: 4px 0;
        }

        #J-rogatory .safe-explain ul {
            padding-bottom: 0;
        }

        #J-other-input {
            color: #999999;
            width: 200px;
            height: 22px;
        }

        #closeNextStep, .J-del-card {
            margin-left: 8px;
            font-size: 14px;
            padding: 5px 14px;
            color: #fff;
        }

        #closeNextStep, .J-del-card:hover {
            border: 1px solid #F26600;
            background-color: #F5AA2B;
            background: -webkit-gradient(linear, left top, left bottom, from(#FFB91C), to(#FFA700));
            background: -moz-linear-gradient(top, #FFB91C, #FFA700);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#FFB91C', endColorstr='#FFA700');
            background: -o-linear-gradient(top, #FFB91C, #FFA700);
            background: linear-gradient(top, #FFB91C, #FFA700);
            box-shadow: 0 -2px 2px rgba(255, 255, 255, 0.4) inset;
        }

        .rogatory-container .xbox-close-link {
            margin-left: 20px;
        }

        .cash_title {
            margin: 20px 0 50px 20px;
            height: 50px;
            line-height: 50px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }
    </style>
</head>
<body>
<div class="cash_title">
    <img src="${ctxStatic }/images/wlptfront/write.png"><span class="cash_title_con">银行卡管理</span>
</div>
<div class="card_list_wrap">
    <div class="card_list_rows">
        <div class="card_box" ng-repeat="x in datas">
            <div class="card_box_line1">
                <%--<span class="bank_logo">--%>
                <%--<img src="${ctxStatic}/images/wlptfront/chinaBank.png"/>--%>
                <%--</span>--%>
                <span class="bank_name">
                       <b>{{x.banktype}}</b>
                </span>
                <span class="bank_num4">
                   <span ng-if="x.isdefault==1"><input type="checkbox"  ng-click="change(x.id)"  checked /></span>
                   <span ng-if="x.isdefault==0"><input type="checkbox"  ng-click="change(x.id)" /></span>
                                                                  默认
                </span>
                <span class="bank_cardType">

                </span>
            </div>

            <div class="card_box_line2">
                    <span class="express-status">
                        <span class="pay_quick"></span>
                        <span class="open_state">{{x.bankcard.substr(0,4)+" **** **** "+x.bankcard.substr(x.bankcard.length-4,x.bankcard.length)}}</span>
                    </span>
                <div class="card-manage">
                    <a href="javascript:void(0)" ng-click="deteleAccount(x)">删除账户</a>
                </div>
                <div></div>
            </div>

            <div style="text-align: right;padding-right: 20px;padding-top: 10px">
                 <span>
                     预留手机号：{{x.bindphone.substr(0,3)+"****"+x.bindphone.substr(7,11)}}
                 </span>
            </div>
            <div style="text-align: right;padding-right: 20px;padding-top: 10px">
                 <span>
                     绑定时间：{{x.createDate.substr(0,10)}}
                 </span>
            </div>
        </div>

        <div class="add_card card_box" style="border:none;" ng-if="datas==null || datas.length<3 ">
            <a href="${wlpt}/wlpt/user/userBank/toBankbind">
                <i class="add_icon">
                    <img src="${ctxStatic}/images/wlptfront/add.png">
                </i>
                <span>添加银行卡</span>
            </a>
        </div>
    </div>

</div>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular.min.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>

<script type="text/javascript">

    var app = angular.module('userBankApp', []);
    app.controller('userBankCtrl', function ($scope, $http) {
        $http({
            method: 'POST',
            url: '${wlpt}/wlpt/user/userBank/bankList'
        }).success(function (data) {
            $scope.datas = data.value;
        });

        $scope.change = function (id) {
        	window.location.href = "${wlpt}/wlpt/user/userBank/isDefault?id=" + id;
        };
        $scope.deteleAccount = function (data) {
            $.MsgBox.Confirm("删除提示", "是否删除该卡?", function () {
            	
            	
            	window.location.href="${wlpt}/wlpt/user/userBank/toDelBankcard?id="+data.id;
            	
/*                 window.location.href = "${wlpt}/wlpt/user/userBank/deteleBank?id=" + id;
 */            }, function () {

            });
            return true;
        };
    });

</script>
</body>


</html>
