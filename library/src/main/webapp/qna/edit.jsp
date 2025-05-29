<%@ page import="com.library.dao.QnaDAO" %>
<%@ page import="com.library.dto.Qna" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    int qnaId = 0;
    try {
        qnaId = Integer.parseInt(request.getParameter("qnaId"));
    } catch (Exception e) {
        out.println("<script>alert('잘못된 접근입니다.'); location.href='list.jsp';</script>");
        return;
    }

    QnaDAO dao = new QnaDAO();
    Qna qna = dao.getQnaById(qnaId);

    if (qna == null) {
        out.println("<script>alert('게시글이 존재하지 않습니다.'); location.href='list.jsp';</script>");
        return;
    }
%>

<html>
<head><title>글 수정</title></head>
<body>
<h1>글 수정</h1>

<form action="editProcess.jsp" method="post">
    <input type="hidden" name="qnaId" value="<%= qna.getQnaId() %>">
    제목: <input type="text" name="title" value="<%= qna.getTitle() %>" required><br><br>
    내용:<br>
    <textarea name="content" rows="10" cols="60" required><%= qna.getContent() %></textarea><br><br>
    공개여부:
    <select name="openYn">
        <option value="Y" <%= "Y".equals(qna.getOpenYn()) ? "selected" : "" %>>공개</option>
        <option value="N" <%= "N".equals(qna.getOpenYn()) ? "selected" : "" %>>비공개</option>
    </select><br><br>
    비밀번호(수정/삭제용): <input type="password" name="password" value="<%= qna.getPassword() %>" required><br><br>
    처리상태:
    <select name="status">
        <option value="대기중" <%= "대기중".equals(qna.getStatus()) ? "selected" : "" %>>대기중</option>
        <option value="답변완료" <%= "답변완료".equals(qna.getStatus()) ? "selected" : "" %>>답변완료</option>
    </select><br><br>
    <input type="submit" value="수정 완료">
</form>

<br>
<a href="list.jsp">목록으로</a>
</body>
</html>
