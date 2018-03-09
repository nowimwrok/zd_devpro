<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>我的账户</title>
    <meta name="decorator" content="default"/>
    <style type="text/css">
        .detail-row{
            display: none;
        }
    </style>
</head>
<body>
<div ng-app="myAccount" ng-controller="myAccountCtrl">
    <h3 style="margin: 20px 20px">管理方：{{accountName}}</h3>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th style="text-align: center">账户号</th>
            <th style="text-align: center">账户名</th>
            <th style="text-align: center">可用余额（元）</th>
            <th style="text-align: center">在途余额（元）</th>
            <th style="text-align: center">冻结余额（元）</th>
            <th style="text-align: center">锁定余额（元）</th>
            <th style="text-align: center">合计（元）</th>
            <th style="text-align: center">操作</th>
        </tr>
        </thead>
        <tbody ng-repeat="x in data">
        <tr>
            <td style="text-align: center"><a href="javascript:;" onclick="detail(this);">{{x.accountId}}</a></td>
            <td style="text-align: center">{{x.accountName}}</td>
            <td style="text-align: center">{{availableBalance | number}}</td>
            <td style="text-align: center">{{undeterminedBalance | number}}</td>
            <td style="text-align: center">{{freezeBalance | number}}</td>
            <td style="text-align: center">{{lockBalance | number}}</td>
            <td style="text-align: center">{{availableBalance+undeterminedBalance+freezeBalance+lockBalance }}</td>
            <td style="text-align: center"><a href="${ctx}/wlpt/account/accountDetail?memberId=${memberId}" >账户明细</a></td>
        </tr>
        <tr class="detail-row" >
            <td colspan="8">
                <table class="table table-condensed">
                    <tr ng-repeat="y in x.slaveAccounts">
                        <td width="30%" colspan="2" style="text-align: center" ng-repeat="t in accountTypes" ng-if="y.accountType==t.value">{{t.label}}</td>
                        <td width="60%" colspan="5" style="text-align: center">{{y.availableBalance | number}}</td>
                        <td width="15%" style="text-align: center"> <%--<a href="${ctx}/wlpt/account/accountCash" >出金</a>--%> &nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<script>
var memberId='${memberId}';
    function detail(e){
        $(e).closest('tr').next().toggleClass('detail-row');
    }

    var app = angular.module("myAccount", []);

    app.controller('myAccountCtrl', function ($scope, $http) {

        $scope.accountTypes= ${fns:getDictListJson('account_type')};

        $scope.availableBalance = 0;
        $scope.undeterminedBalance = 0;
        $scope.freezeBalance = 0;
        $scope.lockBalance = 0;

        $scope.currentPage = 1;
        $scope.pageSize = 10;
        $scope.pages = [];

        ///初始化搜索条件
        $scope.searchData = {};

        //get first page
        $http({
            /* url: 'http://api.money56.com/acctsys/rpc/account/getList',
            method: 'post',
            params: {
                'appId': '00002',
                'memberId': memberId,
                'status': '1',
                'appSecret': 'F18FF985B682D3A0D323F9B8D604DE09'
            } */
            url: 'http://test.api.money56.com:8090/acctsys/rpc/account/getList',
            method: 'post',
            params: {
                'appId': '00001',
                'memberId': memberId,
                'status': '1',
                'appSecret': '11EE6F1140254BB0BBF8AEDB395F5908'
            }
        }).success(function (response) {
            $scope.data = response.body.records;
            angular.forEach($scope.data, function (d, index, array) {
                $scope.accountName=d.accountName;
                angular.forEach(d.slaveAccounts, function (x, i, arr) {
                    $scope.availableBalance += x.availableBalance;
                    $scope.undeterminedBalance += x.undeterminedBalance;
                    $scope.freezeBalance += x.freezeBalance;
                    $scope.lockBalance += x.lockBalance;
                });
            });
        });
    });

</script>


</body>
</html>