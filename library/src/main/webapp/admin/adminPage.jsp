<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String adminUser = (String) session.getAttribute("adminUser");
    if(adminUser == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<html>
<head><title>관리자 페이지</title></head>
<body>
<h2>관리자 페이지에 오신 것을 환영합니다, <%= adminUser %>님!</h2>
<a href="adminLogout.jsp">로그아웃</a>
<hr>
<!-- 관리자 기능 메뉴 -->
<ul>
    <li><a href="adminQnaList.jsp">문의 관리</a></li>
    <li><a href="adminUserManagement.jsp">사용자 관리</a></li>
    <!-- 추가 기능 메뉴 넣기 -->
</ul>
</body>
</html>
