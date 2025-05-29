<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dao.QnaDAO, com.library.dto.Qna" %>

<%
    request.setCharacterEncoding("UTF-8");
    int qnaId = Integer.parseInt(request.getParameter("qnaId"));
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String password = request.getParameter("password");

    if (title == null || title.trim().isEmpty() ||
        content == null || content.trim().isEmpty() ||
        password == null || password.trim().isEmpty()) {
        out.println("<script>alert('모든 항목을 입력하세요.'); history.back();</script>");
        return;
    }

    QnaDAO dao = new QnaDAO();
    Qna qna = dao.getQnaById(qnaId);

    if (qna == null) {
        out.println("<script>alert('존재하지 않는 글입니다.'); location.href='list.jsp';</script>");
        return;
    }

    // 비밀번호 체크
    if (!password.equals(qna.getPassword())) {
        out.println("<script>alert('비밀번호가 틀렸습니다.'); history.back();</script>");
        return;
    }

    qna.setTitle(title);
    qna.setContent(content);
    qna.setPassword(password);

    boolean success = dao.updateQna(qna);

    if (success) {
        response.sendRedirect("detail.jsp?qnaId=" + qnaId);
    } else {
        out.println("<script>alert('글 수정 실패'); history.back();</script>");
    }
%>
