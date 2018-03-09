<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${agreement.name}</title>
</head>
  
<body>
    <div  style="margin: 0px auto; padding: 0px;text-align: center; ">

    <div style="width: 870px; margin-top: 15px;margin: 0px auto;">
    	${agreement.content}
    </div>
    </div>
</body>
</html>
