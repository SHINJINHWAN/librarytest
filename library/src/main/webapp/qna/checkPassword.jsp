<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String qnaId = request.getParameter("qnaId");
    String action = request.getParameter("action"); // edit, delete, view 중 하나
%>

<html>
<head><title>비밀번호 확인</title></head>
<body>
<h1>비밀번호 확인</h1>

<form action="checkPasswordProcess.jsp" method="post">
    <input type="hidden" name="qnaId" value="<%= qnaId %>">
    <input type="hidden" name="action" value="<%= action != null ? action : "view" %>">
    
    비밀번호: <input type="password" name="password" required><br><br>
    <input type="submit" value="확인">
</form>

<br>
<a href="list.jsp">목록으로</a>
</body>  
</html>
