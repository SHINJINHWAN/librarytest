<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dto.User" %>
<%
    User user = (User)session.getAttribute("loginUser");
    if(user == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head><title>관리자 페이지</title></head>
<body>
    <h2>관리자 페이지에 오신 것을 환영합니다, <%= user.getNickname() %>님!</h2>
    <a href="../logout.jsp">로그아웃</a>
    <hr>
    <!-- 관리자용 메뉴 예시 -->
    <ul>
        <li><a href="../list.jsp">게시판 관리</a></li>
        <li><a href="userManagement.jsp">사용자 관리 (추후 구현)</a></li>
    </ul>
</body>
</html>
