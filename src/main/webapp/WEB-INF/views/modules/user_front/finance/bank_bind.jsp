<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>绑定银行卡</title>
    <style type="text/css">
	.col-lg-12{
		padding: 0px; 
	}
    </style>
</head>
<body style="background: #f5f5f5;">

<div style="background: #f5f5f5;" ng-app="dataHall" ng-controller="dataHallCtrl">

    <!--两列-->
    <div class="row edit-box has-js">
        <form id="inputForm" name="inputForm">
            <div class="col-lg-12">
                <div class="panel clearfix">
                    <div class="form_container">
                        <h4 class="panel-heading">
                            账户资料 (<span class="red">*</span>为必填项)
                        </h4>
                        <div class="col-sm-12 form-horizontal" style="margin-bottom: 0px;">
                            <div class="form-group col-sm-6">
                                <div class="col-sm-3 control-label text-right"><span class="red">*</span>账户名</div>
                                <div class="col-sm-9 text-left">
                                    <input type="hidden" name="user.id" value="${loginUser.id}">
                                    <input class="form-control" id="accountName" name="accountName"
                                           placeholder="请输入账户名称">
                                </div>
                            </div>
                            <div class="form-group col-sm-6 has-unit">
                                <div class="col-sm-3 control-label text-right"><span class="red">*</span>银行号</div>
                                <div class="col-sm-9 text-left">
                                    <input type="number" class="form-control" id="bankcard" name="bankcard" value="">

                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 form-horizontal" style="margin-bottom: 0px;">
                            <div class="form-group col-sm-6">
                                <div class="col-lg-3 control-label text-right">手机号码</div>
                                <div class="col-lg-9 text-left ">
                                    <input class="form-control" id="bindphone" name="bindphone" placeholder="请输入手机号码"
                                           value="${loginUser.phone}">
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <div class="col-lg-3 control-label text-right">验证码</div>
                                <div class="col-lg-9 text-left">

                                    <div class="input-group">
                                        <input type="text" class="form-control col-sm-8" id="validateCode"
                                               name="validateCode"
                                               placeholder="请输入验证码">

                                        <span class="input-group-btn">
                                      <button style="margin-top: -1px; border-bottom-right-radius: 4px; border-top-right-radius: 4px; font-size: 12px; letter-spacing: 1px; color: #FFF; background-color: rgb(9, 169, 64);"
                                              class="form-control btn btn-default" id="sendRegCode"
                                              type="button">获取验证码!</button>
                                    </span>
                                    </div><!-- /input-group -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-12">
                <div class="panel clearfix">
                    <div class="form_container">
                        <h4 class="panel-heading">
                            银行信息
                        </h4>
                        <div class="col-sm-12 form-horizontal" style="margin-bottom: 0px;">
                            <div class="form-group has-unit col-sm-6">
                                <div class="col-lg-3 control-label text-right"><span class="red">*</span>所属银行</div>
                                <div class="col-lg-9 text-left">
                                    <div class="input-group">
                                        <input type="text" class="form-control col-sm-8" id="banktype" name="banktype"
                                               readonly="readonly"
                                               placeholder="请选择银行">

                                        <span class="input-group-btn">
                                      <button style="margin-top: -1px; border-bottom-right-radius: 4px; border-top-right-radius: 4px; font-size: 12px; letter-spacing: 1px; color: #FFF; background-color: rgb(9, 169, 64);"
                                              data-toggle="modal"
                                              data-target="#myModal" class="form-control btn btn-default"
                                              ng-click="searchInfo('type');" type="button">选择银行</button>
</span>
                                    </div>  <!--/input-group -->
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-6">
                                <div class="col-sm-3 control-label text-right">支行名称</div>
                                <div class="col-sm-9 text-left">
                                    <div class="input-group">
                                        <input type="text" class="form-control col-sm-8" id="bankname" name="bankname"
                                               readonly="readonly"
                                               placeholder="请选择支行">
                                        <input type="hidden" class="form-control" id="unionpayNo" name="unionpayNo">
                                        <span class="input-group-btn">
                                      <button style="margin-top: -1px; border-bottom-right-radius: 4px; border-top-right-radius: 4px; font-size: 12px; letter-spacing: 1px; color: #FFF; background-color: rgb(9, 169, 64);"
                                              class="form-control btn btn-default" data-toggle="modal"
                                              data-target="#myModal" ng-click="searchInfo('name');"
                                              type="button">选择支行</button>
                                    </span>
                                    </div><!-- /input-group -->
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group col-sm-6">
                                <div class="col-sm-3 control-label text-right">支付密码</div>
                                <div class="col-sm-9 text-left">
                                    <input class="form-control" id="password" type="password" name="password" value="">
                                </div>
                            </div>


                            <div class="clearfix contact_hide_box">

                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-12">
                <div class="form-group" style="margin-bottom: 80px;">
                    <div class="col-sm-2 control-label text-left"></div>
                    <div class="col-sm-4">
                        <button type="button" id="submit" class="btn btn-primary col-lg-12">提  交</button>
                    </div>
                    <div class="col-sm-4">
                        <button id="" class="btn btn-warning col-lg-12" onclick="history.go(-1)">返  回</button>
                    </div>
                </div>
            </div>
        </form>
        <input type="hidden" id="banktypename" value="" />
    </div>
    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal"
         class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×
                    </button>
                    <h4 class="modal-title">选择银行</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group" style="text-align: -webkit-center;">
                        <div class="input-group" style="width:60%">
                            <form action="" method="get" class="search-bar" style="text-align: center">
                                <input id="searchinfoname" type="text" class="form-control"
                                       ng-model="searchData.searchinfoname"
                                       placeholder="请输入相关信息"/>

                                <input type="button" name="search-btn" id="search-btn"
                                       class="input-group-addon input-group-search" ng-click="getsearchInfo()"
                                       value="查询">


                            </form>
                        </div>
                    </div>
                    <table class="table" id="contact_table" data-toolbar="#toolbar"
                           data-search="true">
                        <thead>
                        <tr>
                            <th class="text-center">名称</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr ng-repeat="x in data">
                            <td class="text-center">
                                <span style="display: block;" ng-click="confrimname(x.name)">{{x.name}}</span>
                                <span style="display: block;" ng-click="confrimfullname(x.fullName,x.lineNo)">{{x.fullName}}</span>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                    <div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
                        <img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
                    </div>
                    <!-- <div class="loading text-center">
                        <img src="/static/images/loading.gif">
                        <p>加载中</p>
                    </div> -->
                    <tm-pagination conf="paginationConf"></tm-pagination>
                </div>
            </div>
        </div>
    </div>

</div>
<script type="text/javascript" src="${ctxStatic }/common/global.js?id=1"></script>

<script>
    $(function () {
        $('#inputForm').bootstrapValidator({
            message: 'This value is not valid',
            fields: {
                accountName: {
                    message: '账户名信息无效',
                    validators: {
                        notEmpty: {
                            message: '账户名不能为空'
                        },
                        stringLength: {
                            min: 2,
                            max: 30,
                            message: '账户名必须大于2，小于30个字'
                        },
                        regexp: {
                            regexp: /^[\u4e00-\u9fa5]+$/,
                            message: '账户名只能是中文'
                        }
                    }
                },
                bankcard: {
                    message: '银行卡卡号无效',
                    validators: {
                        notEmpty: {
                            message: '银行卡卡号不能为空'
                        },
                        numeric: {
                            message: '银行卡卡号只能是数字'
                        },
                        stringLength: {
                            min: 10,
                            max: 21,
                            message: '银行卡卡号格式有误'
                        }
                    }
                },
                bindphone: {
                    validators: {
                        notEmpty: {
                            message: '手机号码不能为空'
                        },
                        phone: {
                            country: 'CN',
                            message: '请输入正确的手机号码'
                        }
                    }
                },
                validateCode: {
                    message: '验证码无效',
                    validators: {
                        notEmpty: {
                            message: '验证码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 6,
                            message: '请输入长度为6位的验证码'
                        }/*,
                        post_valid: {
                            url: '${wlpt}/wlpt/personal/checkRegCode?phone=' + $("#bindphone").val(),
                            name: "regcode",
                            isran: false,
                            delay: 2000,
                            message: '验证码有误或已过期'
                        }*/
                    }
                },
                banktype: {
                    message: '请选择银行类型',
                    validators: {
                        notEmpty: {
                            message: '请选择银行类型'
                        }
                    }
                }, bankname: {
                    message: '请选择银行名称',
                    validators: {
                        notEmpty: {
                            message: '请选择银行名称'
                        }
                    }
                },
                password: {
                    message: '密码不能为空',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        }, stringLength: {
                            min: 6,
                            max: 16,
                            message: '密码必须大于6，小于16个字符'
                        },
                        passWord: {
                            message: "请填写6位以上的字母加数字或特殊符号的安全密码"
                        }/*, post_valid: {
                            url: '/a/wlpt/user/validateCashPwd?isSave=false',
                            name: "cashPwd",
                            delay: 2000,
                            message: '支付密码有误或未设置'
                        }*/
                    }
                }
            }

        });
        $("#sendRegCode").click(function () {
            var phone = $("#bindphone").val();

            if ($("#bindphone").val() != null && $("#bindphone").val() != "") {
                $.ajax({
                    type: "POST",
                    url: "${wlpt}/wlpt/personal/sendCode",
                    data: {phone: $("#bindphone").val()},
                    dataType: "json",
                    cache: false,
                    success: function (data) {
                        var message = data;
                        if (message) {
                            sendTimeBtn($("#sendRegCode"),$("#bindphone"),1);
                        } else {
                            $.MsgBox.Alert("系统提示", '请填写正确的手机号码');
                        }
                    },
                    error: function () {
                        $.MsgBox.Alert("系统提示", '请填写正确的手机号码');
                    }
                });

            } else {
                $.MsgBox.Alert("系统提示", '请填写正确的手机号码');
            }

        });
        function checkValidateCode(){
            $.ajax({
                type:"POST",
                url:"${wlpt}/wlpt/personal/checkRegCode",
                data:{phone:$("#bindphone").val(),regcode:$("#validateCode").val()},
                dataType:"json",
                async:false,
                success:function(data){
                    if (data == false) {
                        $.MsgBox.Alert("系统提示", "验证码有误或已过期");

                        $("#validateCode").focus();
                        return false;
                    }
                }
            });
        }
        $("#submit").click(function () {
            var status = '${loginUser.userinfo.status}';
            if (status == null || status == '' || status == undefined || status != '2') {
                $.MsgBox.Alert("系统提示", '请先完成资质认证');
                return false;
            }
            var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
            bootstrapValidator.validate();
            if (bootstrapValidator.isValid()) {
                checkValidateCode();

                $.MsgBox.Confirm("系统提示", "确定提交吗？", function () {
                    var isvid=false;
                    $.ajax({
                        url: "${ctx}/wlpt/user/validateCashPwd",
                        dataType: 'json',
                        data:{"cashPwd":$("#password").val(),"isSave":false},
                        async: false, ///同步请求传递
                        type: "post",
                        success: function (data) {
                            isvid=data;
                            if (data == false) {
                                $.MsgBox.Alert("系统提示", "支付密码错误或未设置支付密码");

                            }
                        }
                    })
                    if(isvid){
                        $.ajax({
                            url: "${wlpt}/wlpt/user/userBank/bankBind?" + $("#inputForm").serialize(),
                            dataType: 'json',
                            type: "post",
                            success: function (data) {
                                if (data.value.state == 1) {
                                    window.location.href = '${wlpt}/wlpt/user/userBank/userBank';
                                } else {
                                    $.MsgBox.Alert("保存提示", data.value.message);
                                }
                            }
                        });
                    }
                });
            }
        });
    });

    var app = angular.module('dataHall', ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            currentPage: 1,
            itemsPerPage: 5
        };
        $scope.post_url = "${wlpt}/wlpt/user/userBank/getBankinfoList";
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
        $scope.getsearchInfo= function (){
        	var tab = $("#banktypename").val();
        	if (tab == "name") {
                $scope.post_url = '${wlpt}/wlpt/user/userBank/getBranchBankinfoList';
            } else {
                $scope.post_url = '${wlpt}/wlpt/user/userBank/getBankinfoList';
            }
        	if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
        }
        
        $scope.searchInfo = function (tab) {
        	$("#banktypename").val(tab);
        	$("#maskloading" , parent.document).show();
            if (tab == "name") {
                if ($("#banktype").val() == "") {
                    $.MsgBox.Alert("系统提示", "请选择所属银行");
                    $("#maskloading" , parent.document).hide();
                    return false;
                }
                $scope.post_url = '${wlpt}/wlpt/user/userBank/getBranchBankinfoList';
            } else {
                $scope.post_url = '${wlpt}/wlpt/user/userBank/getBankinfoList';
            }
            
            
            var bh = $("body").height();       //获得整个body（浏览器窗口）的高度 并 赋值给 bh
            var bw = $("body").width();      //获得整个body（浏览器窗口）的宽度 并 赋值给 bw
            $("#fullbg").css({             // 通过 JQ 的css（） 事件，给选中的节点 （“#fullbg”）添加属性
                height: bh,
                width: bw,
                display: "block"
            });
            
            $("#myModal").show();
            
            if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
        };
        var GetAllEmployee = function () {
            var postData = {
                'keyword': $("#searchinfoname").val(),
                'name': $("#banktype").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: $scope.post_url,
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

        $scope.confrimname = function (name) {
            $("#banktype").val(name);
            $("#fullbg,#dialog").hide();      //关闭弹出款  通过 hide（） 方法
            $("#searchinfoname").val("");
            $("#bankname").val("");
            $("#unionpayNo").val("");
            $("#myModal").removeClass("in").css("display", "none");
            $(".modal-backdrop").remove();

        };
        $scope.confrimfullname = function (name, unionpayNo) {
            $("#bankname").val(name);
            $("#unionpayNo").val(unionpayNo);
            $("#fullbg,#dialog").hide();      //关闭弹出款  通过 hide（） 方法
            $("#searchinfoname").val("");
            $("#myModal").removeClass("in").css("display", "none");
            $(".modal-backdrop").remove();
        };
        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);


    }]);
</script>
</body>
</html>
