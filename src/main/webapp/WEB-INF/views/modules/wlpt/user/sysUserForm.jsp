<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业资料管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wlpt/user/sysUser/">企业资料列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/user/sysUser/form?id=${sysUser.id}">企业资料<shiro:hasPermission name="wlpt:user:sysUser:edit">${not empty sysUser.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:user:sysUser:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="sysUser" action="${ctx}/wlpt/user/sysUser/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">归属公司：</label>
			<div class="controls">
				<form:input path="companyId" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">归属部门：</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${sysUser.office.id}" labelName="office.name" labelValue="${sysUser.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">登录名：</label>
			<div class="controls">
				<form:input path="loginName" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">密码：</label>
			<div class="controls">
				<form:input path="password" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工号：</label>
			<div class="controls">
				<form:input path="no" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱：</label>
			<div class="controls">
				<form:input path="email" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话：</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机：</label>
			<div class="controls">
				<form:input path="mobile" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户类型：</label>
			<div class="controls">
				<form:input path="userType" htmlEscape="false" maxlength="1" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户头像：</label>
			<div class="controls">
				<form:input path="photo" htmlEscape="false" maxlength="1000" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">最后登陆IP：</label>
			<div class="controls">
				<form:input path="loginIp" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">最后登陆时间：</label>
			<div class="controls">
				<input name="loginDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${sysUser.loginDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否可登录：</label>
			<div class="controls">
				<form:input path="loginFlag" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">诚信车主：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>车主姓名</th>
								<th>联系方式</th>
								<th>身份证</th>
								<th>驾驶证</th>
								<th>自有车辆证明</th>
								<th>从业资格证</th>
								<th>车牌号</th>
								<th>车身照片</th>
								<th>年审记录</th>
								<th>保险资料</th>
								<th>更新时间</th>
								<th>创建时间</th>
								<th>是否可以编辑 0 是 1否</th>
								<shiro:hasPermission name="wlpt:user:sysUser:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="integrityCarownerList">
						</tbody>
						<shiro:hasPermission name="wlpt:user:sysUser:edit"><tfoot>
							<tr><td colspan="15"><a href="javascript:" onclick="addRow('#integrityCarownerList', integrityCarownerRowIdx, integrityCarownerTpl);integrityCarownerRowIdx = integrityCarownerRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="integrityCarownerTpl">//<!--
						<tr id="integrityCarownerList{{idx}}">
							<td class="hide">
								<input id="integrityCarownerList{{idx}}_id" name="integrityCarownerList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="integrityCarownerList{{idx}}_delFlag" name="integrityCarownerList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="integrityCarownerList{{idx}}_name" name="integrityCarownerList[{{idx}}].name" type="text" value="{{row.name}}" maxlength="20" class="input-small "/>
							</td>
							<td>
								<input id="integrityCarownerList{{idx}}_linkphone" name="integrityCarownerList[{{idx}}].linkphone" type="text" value="{{row.linkphone}}" maxlength="20" class="input-small "/>
							</td>
							<td>
								<input id="integrityCarownerList{{idx}}_idcard" name="integrityCarownerList[{{idx}}].idcard" type="text" value="{{row.idcard}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityCarownerList{{idx}}_driverlicense" name="integrityCarownerList[{{idx}}].driverlicense" type="text" value="{{row.driverlicense}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityCarownerList{{idx}}_owncar" name="integrityCarownerList[{{idx}}].owncar" type="text" value="{{row.owncar}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityCarownerList{{idx}}_qualifycertficate" name="integrityCarownerList[{{idx}}].qualifycertficate" type="text" value="{{row.qualifycertficate}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityCarownerList{{idx}}_carnumber" name="integrityCarownerList[{{idx}}].carnumber" type="text" value="{{row.carnumber}}" maxlength="10" class="input-small "/>
							</td>
							<td>
								<input id="integrityCarownerList{{idx}}_bodywork" name="integrityCarownerList[{{idx}}].bodywork" type="text" value="{{row.bodywork}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityCarownerList{{idx}}_auditrecord" name="integrityCarownerList[{{idx}}].auditrecord" type="text" value="{{row.auditrecord}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityCarownerList{{idx}}_insurance" name="integrityCarownerList[{{idx}}].insurance" type="text" value="{{row.insurance}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityCarownerList{{idx}}_updatetime" name="integrityCarownerList[{{idx}}].updatetime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									value="{{row.updatetime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							</td>
							<td>
								<input id="integrityCarownerList{{idx}}_createtime" name="integrityCarownerList[{{idx}}].createtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									value="{{row.createtime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							</td>
							<td>
								<input id="integrityCarownerList{{idx}}_isedit" name="integrityCarownerList[{{idx}}].isedit" type="text" value="{{row.isedit}}" maxlength="2" class="input-small "/>
							</td>
							<shiro:hasPermission name="wlpt:user:sysUser:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#integrityCarownerList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var integrityCarownerRowIdx = 0, integrityCarownerTpl = $("#integrityCarownerTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(sysUser.integrityCarownerList)};
							for (var i=0; i<data.length; i++){
								addRow('#integrityCarownerList', integrityCarownerRowIdx, integrityCarownerTpl, data[i]);
								integrityCarownerRowIdx = integrityCarownerRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">诚信企业：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>企业法人的姓名</th>
								<th>公司联系方式</th>
								<th>身份证图片用</th>
								<th>个人地址</th>
								<th>房产证图片</th>
								<th>公司名称</th>
								<th>公司地址</th>
								<th>经营年限</th>
								<th>企业信息介绍</th>
								<th>档口和法人的照片&ldquo;,</th>
								<th>办公场所</th>
								<th>存储货物的地方</th>
								<th>员工合照</th>
								<th>营业执照</th>
								<th>银行开户许可证</th>
								<th>道路运输许可证</th>
								<th>自有车辆证明</th>
								<th>上游运输合同</th>
								<th>企业成立时间</th>
								<th>更新时间</th>
								<th>创建时间</th>
								<th>是否可以编辑 0 是 1否</th>
								<th>备注</th>
								<shiro:hasPermission name="wlpt:user:sysUser:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="integrityEnterpriseList">
						</tbody>
						<shiro:hasPermission name="wlpt:user:sysUser:edit"><tfoot>
							<tr><td colspan="25"><a href="javascript:" onclick="addRow('#integrityEnterpriseList', integrityEnterpriseRowIdx, integrityEnterpriseTpl);integrityEnterpriseRowIdx = integrityEnterpriseRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="integrityEnterpriseTpl">//<!--
						<tr id="integrityEnterpriseList{{idx}}">
							<td class="hide">
								<input id="integrityEnterpriseList{{idx}}_id" name="integrityEnterpriseList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="integrityEnterpriseList{{idx}}_delFlag" name="integrityEnterpriseList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_name" name="integrityEnterpriseList[{{idx}}].name" type="text" value="{{row.name}}" maxlength="20" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_linkphone" name="integrityEnterpriseList[{{idx}}].linkphone" type="text" value="{{row.linkphone}}" maxlength="20" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_idcard" name="integrityEnterpriseList[{{idx}}].idcard" type="text" value="{{row.idcard}}" maxlength="200" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_persionaladdress" name="integrityEnterpriseList[{{idx}}].persionaladdress" type="text" value="{{row.persionaladdress}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_certificateproperty" name="integrityEnterpriseList[{{idx}}].certificateproperty" type="text" value="{{row.certificateproperty}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_companyname" name="integrityEnterpriseList[{{idx}}].companyname" type="text" value="{{row.companyname}}" maxlength="50" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_companyaddress" name="integrityEnterpriseList[{{idx}}].companyaddress" type="text" value="{{row.companyaddress}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_operationyears" name="integrityEnterpriseList[{{idx}}].operationyears" type="text" value="{{row.operationyears}}" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_companyinfo" name="integrityEnterpriseList[{{idx}}].companyinfo" type="text" value="{{row.companyinfo}}" maxlength="500" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_stallscorporate" name="integrityEnterpriseList[{{idx}}].stallscorporate" type="text" value="{{row.stallscorporate}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_officespace" name="integrityEnterpriseList[{{idx}}].officespace" type="text" value="{{row.officespace}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_storageplace" name="integrityEnterpriseList[{{idx}}].storageplace" type="text" value="{{row.storageplace}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_staffphoto" name="integrityEnterpriseList[{{idx}}].staffphoto" type="text" value="{{row.staffphoto}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_businesslicense" name="integrityEnterpriseList[{{idx}}].businesslicense" type="text" value="{{row.businesslicense}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_bankopening" name="integrityEnterpriseList[{{idx}}].bankopening" type="text" value="{{row.bankopening}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_roadtransport" name="integrityEnterpriseList[{{idx}}].roadtransport" type="text" value="{{row.roadtransport}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_owncar" name="integrityEnterpriseList[{{idx}}].owncar" type="text" value="{{row.owncar}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_upstreamcontract" name="integrityEnterpriseList[{{idx}}].upstreamcontract" type="text" value="{{row.upstreamcontract}}" maxlength="255" class="input-small "/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_operationyearstime" name="integrityEnterpriseList[{{idx}}].operationyearstime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									value="{{row.operationyearstime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_updatetime" name="integrityEnterpriseList[{{idx}}].updatetime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									value="{{row.updatetime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_createtime" name="integrityEnterpriseList[{{idx}}].createtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									value="{{row.createtime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							</td>
							<td>
								<input id="integrityEnterpriseList{{idx}}_isedit" name="integrityEnterpriseList[{{idx}}].isedit" type="text" value="{{row.isedit}}" maxlength="2" class="input-small "/>
							</td>
							<td>
								<textarea id="integrityEnterpriseList{{idx}}_remarks" name="integrityEnterpriseList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="wlpt:user:sysUser:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#integrityEnterpriseList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var integrityEnterpriseRowIdx = 0, integrityEnterpriseTpl = $("#integrityEnterpriseTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(sysUser.integrityEnterpriseList)};
							for (var i=0; i<data.length; i++){
								addRow('#integrityEnterpriseList', integrityEnterpriseRowIdx, integrityEnterpriseTpl, data[i]);
								integrityEnterpriseRowIdx = integrityEnterpriseRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">企业资料：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>公司Logo名称</th>
								<th>公司名称</th>
								<th>企业法人</th>
								<th>企业法人身份证号码</th>
								<th>法人身份证地址</th>
								<th>负责人</th>
								<th>负责人的身份证号码</th>
								<th>负责人身份证地址</th>
								<th>负责人的固定电话</th>
								<th>负责人的手机</th>
								<th>工作年限</th>
								<th>二维码</th>
								<th>详细地址</th>
								<th>公司主页</th>
								<th>营业执照</th>
								<th>主营业务</th>
								<th>优势资源</th>
								<th>主营路线,最多三条，中间通过逗号分隔</th>
								<th>公司成立时间</th>
								<th>公司有效期</th>
								<th>公司简介</th>
								<th>公司介绍</th>
								<th>相关资质</th>
								<th>推荐企业</th>
								<th>认证状态：0未提交认证1等待认证2认证通过3.认证不通过</th>
								<th>公司传真</th>
								<th>公司QQ</th>
								<th>产品服务</th>
								<th>companyhonor</th>
								<th>companytel</th>
								<th>公司地址:只包括省市区</th>
								<th>remarks</th>
								<shiro:hasPermission name="wlpt:user:sysUser:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="userCompanyList">
						</tbody>
						<shiro:hasPermission name="wlpt:user:sysUser:edit"><tfoot>
							<tr><td colspan="34"><a href="javascript:" onclick="addRow('#userCompanyList', userCompanyRowIdx, userCompanyTpl);userCompanyRowIdx = userCompanyRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="userCompanyTpl">//<!--
						<tr id="userCompanyList{{idx}}">
							<td class="hide">
								<input id="userCompanyList{{idx}}_id" name="userCompanyList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="userCompanyList{{idx}}_delFlag" name="userCompanyList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_logoname" name="userCompanyList[{{idx}}].logoname" type="text" value="{{row.logoname}}" maxlength="200" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_companyname" name="userCompanyList[{{idx}}].companyname" type="text" value="{{row.companyname}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_legalperson" name="userCompanyList[{{idx}}].legalperson" type="text" value="{{row.legalperson}}" maxlength="20" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_legalidcardnum" name="userCompanyList[{{idx}}].legalidcardnum" type="text" value="{{row.legalidcardnum}}" maxlength="50" class="input-small "/>
							</td>
							<td>
								<textarea id="userCompanyList{{idx}}_legaladdress" name="userCompanyList[{{idx}}].legaladdress" rows="4" maxlength="100" class="input-small ">{{row.legaladdress}}</textarea>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_headerperson" name="userCompanyList[{{idx}}].headerperson" type="text" value="{{row.headerperson}}" maxlength="20" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_headeridcarno" name="userCompanyList[{{idx}}].headeridcarno" type="text" value="{{row.headeridcarno}}" maxlength="50" class="input-small "/>
							</td>
							<td>
								<textarea id="userCompanyList{{idx}}_headeraddress" name="userCompanyList[{{idx}}].headeraddress" rows="4" maxlength="100" class="input-small ">{{row.headeraddress}}</textarea>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_headertel" name="userCompanyList[{{idx}}].headertel" type="text" value="{{row.headertel}}" maxlength="50" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_headermobile" name="userCompanyList[{{idx}}].headermobile" type="text" value="{{row.headermobile}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_headerexperience" name="userCompanyList[{{idx}}].headerexperience" type="text" value="{{row.headerexperience}}" maxlength="11" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_qrencoder" name="userCompanyList[{{idx}}].qrencoder" type="text" value="{{row.qrencoder}}" maxlength="200" class="input-small "/>
							</td>
							<td>
								<textarea id="userCompanyList{{idx}}_companyaddress" name="userCompanyList[{{idx}}].companyaddress" rows="4" maxlength="200" class="input-small ">{{row.companyaddress}}</textarea>
							</td>
							<td>
								<textarea id="userCompanyList{{idx}}_homepageurl" name="userCompanyList[{{idx}}].homepageurl" rows="4" maxlength="200" class="input-small ">{{row.homepageurl}}</textarea>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_businesslicencenum" name="userCompanyList[{{idx}}].businesslicencenum" type="text" value="{{row.businesslicencenum}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_mainbusiness" name="userCompanyList[{{idx}}].mainbusiness" type="text" value="{{row.mainbusiness}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_advantagesresources" name="userCompanyList[{{idx}}].advantagesresources" type="text" value="{{row.advantagesresources}}" maxlength="100" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_mainline" name="userCompanyList[{{idx}}].mainline" type="text" value="{{row.mainline}}" maxlength="300" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_setuptime" name="userCompanyList[{{idx}}].setuptime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									value="{{row.setuptime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_companyvalidtime" name="userCompanyList[{{idx}}].companyvalidtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
									value="{{row.companyvalidtime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
							</td>
							<td>
								<textarea id="userCompanyList{{idx}}_companysummary" name="userCompanyList[{{idx}}].companysummary" rows="4" maxlength="500" class="input-small ">{{row.companysummary}}</textarea>
							</td>
							<td>
								<textarea id="userCompanyList{{idx}}_companyintroduction" name="userCompanyList[{{idx}}].companyintroduction" rows="4" maxlength="4000" class="input-small ">{{row.companyintroduction}}</textarea>
							</td>
							<td>
								<textarea id="userCompanyList{{idx}}_qualifications" name="userCompanyList[{{idx}}].qualifications" rows="4" maxlength="4000" class="input-small ">{{row.qualifications}}</textarea>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_isrecommend" name="userCompanyList[{{idx}}].isrecommend" type="text" value="{{row.isrecommend}}" maxlength="11" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_status" name="userCompanyList[{{idx}}].status" type="text" value="{{row.status}}" maxlength="11" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_companyfax" name="userCompanyList[{{idx}}].companyfax" type="text" value="{{row.companyfax}}" maxlength="20" class="input-small "/>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_companyqq" name="userCompanyList[{{idx}}].companyqq" type="text" value="{{row.companyqq}}" maxlength="20" class="input-small "/>
							</td>
							<td>
								<textarea id="userCompanyList{{idx}}_productserver" name="userCompanyList[{{idx}}].productserver" rows="4" maxlength="4000" class="input-small ">{{row.productserver}}</textarea>
							</td>
							<td>
								<textarea id="userCompanyList{{idx}}_companyhonor" name="userCompanyList[{{idx}}].companyhonor" rows="4" maxlength="4000" class="input-small ">{{row.companyhonor}}</textarea>
							</td>
							<td>
								<input id="userCompanyList{{idx}}_companytel" name="userCompanyList[{{idx}}].companytel" type="text" value="{{row.companytel}}" maxlength="50" class="input-small "/>
							</td>
							<td>
								<textarea id="userCompanyList{{idx}}_provinceCityDistrict" name="userCompanyList[{{idx}}].provinceCityDistrict" rows="4" maxlength="100" class="input-small ">{{row.provinceCityDistrict}}</textarea>
							</td>
							<td>
								<textarea id="userCompanyList{{idx}}_remarks" name="userCompanyList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="wlpt:user:sysUser:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#userCompanyList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var userCompanyRowIdx = 0, userCompanyTpl = $("#userCompanyTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(sysUser.userCompanyList)};
							for (var i=0; i<data.length; i++){
								addRow('#userCompanyList', userCompanyRowIdx, userCompanyTpl, data[i]);
								userCompanyRowIdx = userCompanyRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">user_purse：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>平台余额，账户余额</th>
								<th>可用账户余额</th>
								<th>冻结资金(运费冻结)</th>
								<th>竞标押金（用户竞标交纳的保证金存在这个字段）</th>
								<th>保证金</th>
								<th>油气金额</th>
								<th>红包金额（活动获取）</th>
								<th>用户结算获得资金（预支付存到卓大账户）</th>
								<th>结算状态：0可用1.冻结</th>
								<th>保险</th>
								<th>授信可用金额</th>
								<th>备注</th>
								<shiro:hasPermission name="wlpt:user:sysUser:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="userPurseList">
						</tbody>
						<shiro:hasPermission name="wlpt:user:sysUser:edit"><tfoot>
							<tr><td colspan="14"><a href="javascript:" onclick="addRow('#userPurseList', userPurseRowIdx, userPurseTpl);userPurseRowIdx = userPurseRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="userPurseTpl">//<!--
						<tr id="userPurseList{{idx}}">
							<td class="hide">
								<input id="userPurseList{{idx}}_id" name="userPurseList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="userPurseList{{idx}}_delFlag" name="userPurseList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<input id="userPurseList{{idx}}_webbalance" name="userPurseList[{{idx}}].webbalance" type="text" value="{{row.webbalance}}" class="input-small  number"/>
							</td>
							<td>
								<input id="userPurseList{{idx}}_availablebalance" name="userPurseList[{{idx}}].availablebalance" type="text" value="{{row.availablebalance}}" class="input-small  number"/>
							</td>
							<td>
								<input id="userPurseList{{idx}}_freezemoney" name="userPurseList[{{idx}}].freezemoney" type="text" value="{{row.freezemoney}}" class="input-small  number"/>
							</td>
							<td>
								<input id="userPurseList{{idx}}_biddingmoney" name="userPurseList[{{idx}}].biddingmoney" type="text" value="{{row.biddingmoney}}" class="input-small  number"/>
							</td>
							<td>
								<input id="userPurseList{{idx}}_guaranteemone" name="userPurseList[{{idx}}].guaranteemone" type="text" value="{{row.guaranteemone}}" class="input-small  number"/>
							</td>
							<td>
								<input id="userPurseList{{idx}}_petrolbalance" name="userPurseList[{{idx}}].petrolbalance" type="text" value="{{row.petrolbalance}}" class="input-small  number"/>
							</td>
							<td>
								<input id="userPurseList{{idx}}_redpacket" name="userPurseList[{{idx}}].redpacket" type="text" value="{{row.redpacket}}" class="input-small  number"/>
							</td>
							<td>
								<input id="userPurseList{{idx}}_settlemoney" name="userPurseList[{{idx}}].settlemoney" type="text" value="{{row.settlemoney}}" class="input-small  number"/>
							</td>
							<td>
								<input id="userPurseList{{idx}}_settlestatus" name="userPurseList[{{idx}}].settlestatus" type="text" value="{{row.settlestatus}}" maxlength="11" class="input-small  digits"/>
							</td>
							<td>
								<input id="userPurseList{{idx}}_insurance" name="userPurseList[{{idx}}].insurance" type="text" value="{{row.insurance}}" class="input-small  number"/>
							</td>
							<td>
								<input id="userPurseList{{idx}}_creditmoney" name="userPurseList[{{idx}}].creditmoney" type="text" value="{{row.creditmoney}}" class="input-small  number"/>
							</td>
							<td>
								<textarea id="userPurseList{{idx}}_remarks" name="userPurseList[{{idx}}].remarks" rows="4" maxlength="255" class="input-small ">{{row.remarks}}</textarea>
							</td>
							<shiro:hasPermission name="wlpt:user:sysUser:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#userPurseList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var userPurseRowIdx = 0, userPurseTpl = $("#userPurseTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(sysUser.userPurseList)};
							for (var i=0; i<data.length; i++){
								addRow('#userPurseList', userPurseRowIdx, userPurseTpl, data[i]);
								userPurseRowIdx = userPurseRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:user:sysUser:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>