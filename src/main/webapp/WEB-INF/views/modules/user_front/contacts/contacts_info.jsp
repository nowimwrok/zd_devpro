<%@ page contentType="text/html;charset=UTF-8" %>


<div ng-app="contactsdataHall" ng-controller="contactsdataHallCtrl">
    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal"
         class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×
                    </button>
                    <h4 class="modal-title">常用联系人</h4>
                </div>
                <div class="modal-body  modal-body-h">
                    <div class="form-group" style="text-align: -webkit-center;">
                        <div class="input-group" style="width:60%">
                        <input id="searchnames" type="hidden" value=""/>
                            <form action="" method="get" class="search-bar" style="text-align: center">
                                <input id="searchinfoname" type="text" class="form-control"
                                       ng-model="searchData.searchinfoname"
                                       placeholder="登录名/手机号码"/>

                                <input type="button" name="search-btn" id="search-btn"
                                       class="input-group-addon input-group-search" ng-click="searchInfo()" value="查询">


                            </form>
                        </div>
                    </div>
                    <table class="table" id="contact_table" data-toolbar="#toolbar"
                           data-search="true">
                        <thead>
                        <tr>
                            <th>登录名</th>
                            <th>真实姓名</th>
                            <th>手机号码</th>
                            <th>创建时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr ng-repeat="x1 in data" style="height: 40px;">
                            <td style=" border: solid 1px #d1c5c5;">
                                {{x1.target.loginName}}
                            </td>
                            <td style=" border: solid 1px #d1c5c5;">
                                {{x1.target.name}}
                            </td>
                            <td style=" border: solid 1px #d1c5c5;">
                                {{x1.target.phone}}
                            </td>
                            <td style=" border: solid 1px #d1c5c5;">
                                {{x1.createDate}}
                            </td>
                            <td style=" border: solid 1px #d1c5c5;">

                                <a href="javascript:" ng-click="clickcontcts(x1.id,x1.target.loginName)"
                                   style="background: #fff;" aria-hidden="true" data-dismiss="modal" class="see oprate">选择</a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
                        <img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
                    </div>
                    <!-- <div class="loadings">
                        <img src="/static/images/loading.gif">
                        <p>加载中</p>
                    </div> -->
                    <!--分页-->
                    <tm-pagination conf="paginationConf"></tm-pagination>
                </div>
            </div>
        </div>
    </div>

</div>
<script>
    var app = angular.module('contactsdataHall', ['tm.pagination']);
    app.controller('contactsdataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            currentPage: 1,
            itemsPerPage: 10
        };
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
            	$("#maskloading" , parent.document).show();
                $("#noneData").hide();
                $(".datainit").show();
            } else if (isloading == 2) {
            	$("#maskloading" , parent.document).hide();
                $("#noneData").show();
                $(".datainit").hide();
            } else {
            	$("#maskloading" , parent.document).hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        $scope.searchInfo = function () {
            if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
        };
        var GetAllEmployee = function () {
            var postData = {
                'searchinfo': $("#searchinfoname").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/contacts/getContactsList',
                method: 'post',
                params: postData
            }).success(function (response) {
                $scope.paginationConf.totalItems = response.value.count;
                $scope.data = response.value.list;
                if (!$scope.data) {
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);

                }
            });
        };
        $scope.clickcontcts = function (id, username) {
        	var searchname = $("#searchnames").val();
        	if(searchname!="" && searchname!=''){
        		 
        		 //$("#login_user").val(id);
                 $("#"+searchname+"_user").val(username);
        	}else{
        		 $("#userid").val(id);
                 $("#searchinfo").val(username);
        	}
        	
           
            $("#fullbg,#dialog").hide();      //关闭弹出款  通过 hide（） 方法
            search(searchname);
        };
        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);


    }]);
</script>
<script>
	function setsearchname(name){
		$("#searchnames").val(name);
	}
	
    function showBg1() {                    //定义 showBg1 函数
        var bh = $("body").height();       //获得整个body（浏览器窗口）的高度 并 赋值给 bh 
        var bw = $("body").width();      //获得整个body（浏览器窗口）的宽度 并 赋值给 bw
        $("#fullbg").css({             // 通过 JQ 的css（） 事件，给选中的节点 （“#fullbg”）添加属性
            height: bh,
            width: bw,
            display: "block"
        });
        $("#dialog").show();          //并且让 节点（“dialog”） show（）出来
    }

    function closeBg() {
        $("#fullbg,#dialog").hide();      //关闭弹出款  通过 hide（） 方法
    }


</script>

