<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dao.QnaDAO, com.library.dto.Qna" %>

<%
    request.setCharacterEncoding("UTF-8");

    String method = request.getMethod();

    if ("GET".equalsIgnoreCase(method)) {
        // 삭제 비밀번호 입력 폼 화면
        String qnaIdStr = request.getParameter("qnaId");
        if (qnaIdStr == null || qnaIdStr.isEmpty()) {
            out.println("<script>alert('잘못된 접근입니다.'); location.href='list.jsp';</script>");
            return;
        }
%>
<html>
<head><title>글 삭제</title></head>
<body>
<h1>글 삭제</h1>

<form action="delete.jsp" method="post">
    <input type="hidden" name="qnaId" value="<%= qnaIdStr %>">
    비밀번호: <input type="password" name="password" required><br><br>
    <input type="submit" value="삭제하기">
</form>

<br>
<a href="list.jsp">목록으로</a>
</body>
</html>
<%
    } else if ("POST".equalsIgnoreCase(method)) {
        // 삭제 처리 로직
        int qnaId = 0;
        try {
            qnaId = Integer.parseInt(request.getParameter("qnaId"));
        } catch (Exception e) {
            out.println("<script>alert('잘못된 접근입니다.'); location.href='list.jsp';</script>");
            return;
        }

        String password = request.getParameter("password");

        QnaDAO dao = new QnaDAO();
        Qna qna = dao.getQnaById(qnaId);

        if (qna == null) {
            out.println("<script>alert('존재하지 않는 글입니다.'); location.href='list.jsp';</script>");
            return;
        }

        if (qna.getPassword() != null && !qna.getPassword().isEmpty()) {
            if (!password.equals(qna.getPassword())) {
                out.println("<script>alert('비밀번호가 틀렸습니다.'); history.back();</script>");
                return;
            }
        }

        boolean success = dao.deleteQna(qnaId);

        if (success) {
            response.sendRedirect("list.jsp");
        } else {
            out.println("<script>alert('삭제 실패'); history.back();</script>");
        }
    }
%>
