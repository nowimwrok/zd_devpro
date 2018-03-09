<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户银行卡管理</title>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <style type="text/css">
        body {
            padding: 0;
            width: 100%;
            border: 1px solid #D6D3CE;
        }

        .cash_title {
            margin: 20px 0 50px 20px;
            height: 50px;
            line-height: 50px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }
        
        
        
        a {
        text-decoration: none;
        }
    
        body {
            padding: 0;
            margin: 0;
            width: 100%;
            margin: 0 auto;
            text-align: center;
            border: 1px solid #D6D3CE;
            font-family: "微软雅黑";
        }

        ul p span a input td {
            font-family: "微软雅黑";
        }

        .goods-manage td, .goods-manage th {
            text-align: center;
        }

        .goods-manage td p {
            text-align: center;
            margin: 10px 0px;
        }

        .car_search {
            height: 35px;
            width: 15%;
        }

        .goods-manage td a {
            padding: 3px 12px;
            width: 95px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
        }

        .loading_lock {
            display: none;
            width: 100%;
            height: 100%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }

        .loading_lock img {
            margin-top: 25%;
        }

        .datainit {
            display: none;
        }
        #dialog {
		    background-color: rgb(255, 255, 255);
		    /* height: 400px; */
		    height: initial;
		    top: 50%;
		    left: 55%;
		    width: 300px;
		    z-index: 5;
		    display: none;
		    position: fixed;
		    border-width: initial;
		    border-style: none;
		    border-color: initial;
		    border-image: initial;
		    margin: -200px 0px 0px -200px;
		    padding: 0px;
		    border-radius: 5px;
		}
		.select_title {
		    width: 100%;
		    height: 40px;
		    line-height: 40px;
		    margin-top: 5px;
		}
		.goods-manage {
		    width: 100%;
		    margin-top: 5px;
		    margin-bottom: 0px;
		}
		.pager li > a, .pager li > span {
		    display: inline-block;
		    padding: 2px 9px;
		    background-color: #fff;
		    border: 1px solid #ddd;
		    border-radius: 15px;
		    cursor: pointer;
		}
		.dialog-content {
		    padding: 5px;
		    text-align: center;
		}
		#fullbg {
		    background-color: gray;
		    left: 0;
		    opacity: 0.5;
		    position: absolute;
		    top: 0;
		    z-index: 3;
		    filter: alpha(opacity=50);
		    -moz-opacity: 0.5;
		    -khtml-opacity: 0.5;
		}
		#dialog p {
		    margin: 0 0 12px;
		    height: 24px;
		    line-height: 24px;
		}
		#dialog p.close {
		    text-align: right;
		    padding-right: 10px;
		}
        
        .pager li>a, .pager li>span {
		    display: inline-block;
		    padding: 2px 5px;
		    background-color: #fff;
		    border: 1px solid #ddd;
		    border-radius: 15px;
		    font-size: 12px;
		}
    </style>
    
</head>
<body ng-app="dataHall" ng-controller="dataHallCtrl">
<div class="cash_title">
    <img src="${ctxStatic }/images/wlptfront/write.png"><span class="cash_title_con">添加银行卡</span>
</div>

<form:form id="inputForm" modelAttribute="userBankinfo" action="${ctx}/wlpt/user/userBank/bankBind" method="post" class="col-sm-8 form-horizontal">
    <form:hidden path="id"/>

    <input type="hidden" name="user.id" value="${loginUser.id}">

    <%-- <div class="form-group">
        <label for="bindname" class="col-sm-4 control-label">持卡人：</label>
        <div class="col-sm-8">
            <input type="text" class="form-control" id="bindname" name="bindname" readonly value="${loginUser.name}" >
        </div>
    </div> --%>
	<input class="form-control" id="bindname" name="bindname" readonly value="${loginUser.name}" type="hidden" >
    <div class="form-group">
        <label for="bankcard" class="col-sm-4 control-label">账户名：</label>
        <div class="col-sm-8">
            <input type="text" class="form-control" id="accountName" name="accountName">
        </div>
    </div>
    
    <div class="form-group">
        <label for="bankcard" class="col-sm-4 control-label">卡号：</label>
        <div class="col-sm-8">
            <input type="tel" class="form-control" id="bankcard" name="bankcard">
        </div>
    </div>

    <div class="form-group">
        <label for="bindphone" class="col-sm-4 control-label">手机号：</label>
         <div class="col-sm-8 ">
            <input type="text" class="form-control" id="bindphone" name="bindphone">
         	<input  type="button" value="获取验证码" class="btn btn-primary pull-right" id="sendRegCode">
        </div>
        
    </div>
	
	<div class="form-group">
		<label class="col-sm-4 control-label">手机验证码：</label>
		<div class="col-sm-8">
            <input type="text" class="form-control" id="validateCode" name="validateCode">
		</div>
	</div> 
	
    <div class="form-group">
        <label class="col-sm-4 control-label">所属银行：</label>
        <div class="col-sm-8">
            <%-- <form:select path="unionpayNo" class="form-control">
                <form:options items="${fns:getDictList('unionpay_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select> --%>
            <input type="text" class="form-control" id="banktype" name="banktype" readonly="readonly"><span ng-click="showBg1();" class="btn pull-right"><a href="#">选择银行</a></span>
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-4 control-label">支行名称：</label>
        <div class="col-sm-8">
            <%-- <form:select path="unionpayNo" class="form-control">
                <form:options items="${fns:getDictList('unionpay_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select> --%>
            
            <input type="hidden" class="form-control" id="unionpayNo" name="unionpayNo" >
            <input type="text" class="form-control" id="bankname" name="bankname" readonly="readonly"><span ng-click="showBg2();" class="btn pull-right"><a href="#">选择支行</a></span>
        </div>
    </div>
    
    <div class="form-group">
        <label class="col-sm-4 control-label">提现密码：</label>
        <div class="col-sm-8">
            <input id="password"  type="password" name="password" class="form-control"/>
        </div>
    </div>


    <input type="button" id="submit" onclick="save();" class="btn btn-primary pull-right" value="保 存"/>
</form:form>

<script type="text/javascript" src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
<script>
/* $("#bankcard").change(function () {
	var bankcard=$("#bankcard").val();
	$.ajax({
        url: "${wlpt}/wlpt/user/userBank/getNameByCard",
        dataType: 'json',
        type: "post",
        data : {"cardNo":bankcard},
        success: function (data) {
        	if (data.state == 1) {
        		$("#banktype").val(data.message);
        	}else{
        		$("#banktype").val("");
        	}
        }
    });
}); */
var save=function save(){
	var status='${loginUser.userinfo.status}';
	if(status==null||status==''||status==undefined||status!='2'){
		$("#submit").tips({
            side: 3,
            msg: '请先完成认证',
            bg: '#00A2E9',
            time: 4
        });
        return false;
	}
	var nul = true;
	nul = nul && $("#accountName").valid({
        methods: "required"
    });
    nul = nul && $("#bankcard").valid({
        methods: "required|isBankAccountNumber"
    });
    nul = nul && $("#bindphone").valid({
    	methods: "required|isPhone"  
    });
    nul = nul && $("#banktype").valid({
    	methods: "required"
    });
    nul = nul && $("#bankname").valid({
    	methods: "required"
    });
    nul = nul && $("#password").valid({
    	methods: "required"  
    });
    nul = nul && $("#validateCode").valid({
    	methods:"required"
    });
    
	if ($("#validateCode").val().length != 6) {
		$("#validateCode").tips({
			side : 3,
			msg : '验证码长度为6位！',
			bg : '#00A2E9',
			time : 3
		});
		return false;
	}
	
	checkValidateCode();
	
     if(nul){
    	if($("#password").val()!=""&&$("#password").val()!=null){
    		$.ajax({
	            url: "${ctx}/wlpt/user/validateCashPwd",
	            dataType: 'json',
	            data:{"cashPwd":$("#password").val(),"isSave":false},
	            type: "post",
	            success: function (data) {
	                if (data == false) {
	                	$("#password").tips({
	                        side: 3,
	                        msg: '支付密码错误或未设置支付密码',
	                        bg: '#00A2E9',
	                        time: 4
	                    });
	                }else{
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
	            }
    		});
    	}
    } 
}  
       
 
</script>

<script type="text/javascript">
	$("#sendRegCode").click(function(){
		var phone = $("#bindphone").val();
		
		if($("#bindphone").val() != null && $("#bindphone").val() !="" ){
			$.ajax({
				type:"POST",
				url:"${wlpt}/wlpt/personal/sendCode",
				data:{phone : $("#bindphone").val()},
				dataType:"json",
				cache:false,
				success:function(data){
					var message = data;
					if (message){
						sendTimeBtn($("#sendRegCode"));
					}else {
						$.MsgBox.Alert("系统提示",'请填写正确的手机号码');
					}					
				},
				error : function() {
					$.MsgBox.Alert("系统提示",'请填写正确的手机号码');
				}
			}); 
			
		}else{
			$("#bindphone").tips({
				side:3,
				msg:"手机号不能为空",
				bg:'#00A2E9',
				time:4
			});
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
					$("#validateCode").tips({
						side:3,
			            msg:'验证码有误或已过期',
			            bg:'#00A2E9',
			            time:4
			        });
					$("#validateCode").focus();
					return false;
				}
			}
		});
	}
</script>




<div id="fullbg"></div>
<div id="dialog">
    <p class="close">
        <a href="#" onclick="closeBg();">X</a>
    </p>
    <div class="dialog-content">
        <br/>
        
        <div class="select_title">
		    <form action="" method="get" class="search-bar" style="text-align: center">
		        <input id="searchinfoname" type="text" class="car_search car_phone_search" style="width: 170px;height: 30px;" ng-model="searchData.keyword"/>
		        
		        <button type="button" name="search-btn" id="search-btn"
		                style="width:56px;border-radius:9px;border-color:#FFC52F;background-color:#FFC52F;color: #fff;padding: 5px 5px;"
		                class="btn btn-warning" ng-click="onSelectPage(1)">
		            <span class="glyphicon glyphicon-search"></span><span class="goods_search_btn">搜索</span>
		        </button>
		        
		    </form>
		</div>
		<table class="goods-manage">
		    <tbody class="datainit">
		    <tr ng-repeat="x in data" style="height: 40px;">
		        <td style=" border-bottom: solid 1px #d1c5c5;">
		            <span ng-click="confrimname(x.name)">{{x.name}}</span>
		            <span ng-click="confrimfullname(x.fullName,x.lineNo)">{{x.fullName}}</span>
		        </td>
		        
		    </tr>
		    
		    </tbody>
		</table>
		<div class="loadings"><img src="/static/images/loading.gif">
		    <p>加载中</p></div>
		<div class="loading_lock"><img src="${ctxStatic }/images/loading.gif">
		    <p>等待中</p></div>
		<div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">暂无数据</div>
		<div class="paging" id="paging">
		    <ul class="pagination pager" id="pagination" on-select-page="selectPage(page)">
		        <li ng-class="{active: isActive(page)}"><a ng-click="selectPage(1)">第一页</a></li>
		        <li ng-class="{disabled: noPrevious()}"><a ng-click="selectPrevious()">上一页</a></li>
		        <li ng-repeat="page in pages" ng-class="{active: isActive(page)}">
		            <a ng-click="selectPage(page)">{{page}}</a>
		        </li> 
		        <li ng-class="{disabled: noNext()}"><a ng-click="selectNext()">下一页</a></li>
		        <li ng-class="{active: isActive(page)}"><a ng-click="selectPage(numPages)">最后一页</a></li>
		    </ul>
		</div>
        
        <!-- <p class="close_content"><a href="#" onclick="closeBg1();">知道了</a></p> -->
    </div>
</div>
</body>

<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>
<script>
 
function closeBg() {
    $("#fullbg,#dialog").hide();      //关闭弹出款  通过 hide（） 方法
}
    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 5;
        $scope.name = "";
        $scope.keyword = "";
        $scope.pages = [];
        ///初始化搜索条件
        $scope.searchData = {
            drivername: '', driverphone: '', isagree: ''
        };
        
        
        var url = "getBankinfoList";
        $scope.showBg1 = function(){                    //定义 showBg1 函数
            var bh = $("body").height();       //获得整个body（浏览器窗口）的高度 并 赋值给 bh 
            var bw = $("body").width();      //获得整个body（浏览器窗口）的宽度 并 赋值给 bw
            $("#fullbg").css({             // 通过 JQ 的css（） 事件，给选中的节点 （“#fullbg”）添加属性
                height: bh,
                width: bw,
                display: "block"
            });
            $("#dialog").show();          //并且让 节点（“dialog”） show（）出来
            $scope.data = null;
            $("#searchinfoname").val("");
            url = "getBankinfoList";
            $scope.onSelectPage(1);
        }

        $scope.showBg2 = function(){                    //定义 showBg1 函数
        	if($("#banktype").val()==""){
        		$("#banktype").tips({
        			side : 3,
        			msg : '请先选择所属银行！',
        			bg : '#00A2E9',
        			time : 3
        		});
        		return false;
        	}
            var bh = $("body").height();       //获得整个body（浏览器窗口）的高度 并 赋值给 bh 
            var bw = $("body").width();      //获得整个body（浏览器窗口）的宽度 并 赋值给 bw
            $("#fullbg").css({             // 通过 JQ 的css（） 事件，给选中的节点 （“#fullbg”）添加属性
                height: bh,
                width: bw,
                display: "block"
            });
            $("#noneData").hide();
            $("#dialog").show();          //并且让 节点（“dialog”） show（）出来
            $("#searchinfoname").val("");
            $scope.data = null;
            url = "getBranchBankinfoList";
            $scope.onSelectPage(1);
        }

        
        ////isloadings ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloadings = function (isloadings) {
            if (isloadings == 1) {
                $(".loadings").show();
                $("#noneData").hide();
            } else if (isloadings == 2) {
                $(".loadings").hide();
                $("#noneData").show();
            } else {
                $(".loadings").hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        
        
        $scope.confrimname = function(name) {
        	$("#banktype").val(name)
            $("#fullbg,#dialog").hide();      //关闭弹出款  通过 hide（） 方法
        	$("#searchinfoname").val("");
        	$("#bankname").val("");
        	$("#unionpayNo").val("");
            
        }
        $scope.confrimfullname = function(name,unionpayNo) {
        	$("#bankname").val(name);
        	$("#unionpayNo").val(unionpayNo);
            $("#fullbg,#dialog").hide();      //关闭弹出款  通过 hide（） 方法
            $("#searchinfoname").val("");
            
        }
        //get first page
        $http({
            url: '${wlpt}/wlpt/user/userBank/'+url,
            method: 'post',
            params: {
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize,
                'keyword':$("#searchinfoname").val(),
                'name':$("#banktype").val()
            }
        }).success(function (response) {
        	if (!response.value || !response.value.list) {
                $scope.isloadings(2);
            } else {
                $scope.isloadings(3);
            }
            $scope.data = response.value.list;
            
            $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);

            //分页要repeat的数组
            $scope.newPages = $scope.numPages > 3 ? 3 : $scope.numPages;
            for (var i = 0; i < $scope.newPages; i++) {
                $scope.pages.push(i + 1);
            }

        });

        $scope.onSelectPage = function (page) {
            //replace your real data
            $scope.isloadings(1);
            $http({
                url: '${wlpt}/wlpt/user/userBank/'+url,
                method: 'post',
                params: {
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize,
                    'keyword':$("#searchinfoname").val(),
                    'name':$("#banktype").val()
                }
            }).success(function (response) {
            	if (!response.value.list || !response.value.list) {
                    $scope.isloadings(2);
                } else {
                    $scope.isloadings(3);
                }
                $scope.data = response.value.list;
                $scope.pages = [];
                
                $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);
                if ($scope.numPages == 0) {
                    $scope.numPages = 1;
                }
                $scope.newPages = $scope.numPages > 3 ? 3 : $scope.numPages;
                for (var i = 0; i < $scope.newPages; i++) {
                    var num = $scope.currentPage - 2;
                    if (num < 0) {
                        num = 0;
                    }
                    $scope.pages.push(num + 1);
                }
                $("#datainit").show();
            });
        };
    });

    app.directive('paging', function () {
        return {
            restrict: 'AEC',
            //scope: {
            //    numPages: '=',
            //    currentPage: '=',
            //    onSelectPage: '&'
            //},
            template: '',
            replace: true,
            link: function (scope, element, attrs) {
                scope.$watch('numPages', function (value) {

                    if (scope.currentPage > value) {
                        scope.selectPage(value);
                    }
                });
                scope.isActive = function (page) {
                    return scope.currentPage === page;
                };
                scope.selectPage = function (page) {
                    //不能小于1大于最大
                    if (page < 1 || page > scope.numPages) return;
                    //最多显示分页数5
                    if (page > 1) {
                        //因为只显示5个页数，大于2页开始分页转换
                        var newpageList = [];
                        for (var i = (page - 2); i < ((page + 1) > scope.numPages ? scope.numPages : (page +1)); i++) {
                            newpageList.push(i + 1);
                        }
                        scope.pages = newpageList;
                    }
                    if (page == 1) {
                        scope.pages = [];
                        for (var k = 0; k < scope.newPages; k++) {
                            scope.pages.push(k + 1);
                        }
                    }


                    if (!scope.isActive(page)) {
                        scope.currentPage = page;
                        scope.onSelectPage(page);
                    }
                };
                scope.selectPrevious = function () {
                    if (!scope.noPrevious()) {
                        scope.selectPage(scope.currentPage - 1);
                    }
                };
                scope.selectNext = function () {
                    if (!scope.noNext()) {
                        scope.selectPage(scope.currentPage + 1);
                    }
                };
                scope.noPrevious = function () {
                    return scope.currentPage == 1;
                };
                scope.noNext = function () {
                    return scope.currentPage == scope.numPages;
                };

            }
        };


    });

</script>

<script>


    
    


</script>
</html>

