<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dao.QnaDAO, com.library.dto.Qna" %>

<%
    String qnaIdStr = request.getParameter("qnaId");
    if (qnaIdStr == null) {
        response.sendRedirect("list.jsp");
        return;
    }
    int qnaId = Integer.parseInt(qnaIdStr);

    QnaDAO dao = new QnaDAO();
    Qna qna = dao.getQnaById(qnaId);

    if (qna == null) {
        out.println("<script>alert('존재하지 않는 글입니다.'); location.href='list.jsp';</script>");
        return;
    }
%>

<html>
<head><title>글 수정</title></head>
<body>
<h1>글 수정</h1>

<form action="modifyProcess.jsp" method="post">
    <input type="hidden" name="qnaId" value="<%= qna.getQnaId() %>">
    제목: <input type="text" name="title" value="<%= qna.getTitle() %>"><br>
    비밀번호: <input type="password" name="password" value="<%= qna.getPassword() %>"><br>
    내용:<br>
    <textarea name="content" rows="10" cols="50"><%= qna.getContent() %></textarea><br>
    <input type="submit" value="수정">
</form>
<a href="detail.jsp?qnaId=<%= qna.getQnaId() %>">취소</a>
</body>
</html>
