<%@ page import="com.library.dao.QnaDAO" %>
<%@ page import="com.library.dto.Qna" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");

    int qnaId = Integer.parseInt(request.getParameter("qnaId"));
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String openYn = request.getParameter("openYn");
    String password = request.getParameter("password");
    String status = request.getParameter("status");

    Qna qna = new Qna();
    qna.setQnaId(qnaId);
    qna.setTitle(title);
    qna.setContent(content);
    qna.setOpenYn(openYn);
    qna.setPassword(password);
    qna.setStatus(status);

    QnaDAO dao = new QnaDAO();
    boolean updated = dao.updateQna(qna);

    if (updated) {
        out.println("<script>alert('수정이 완료되었습니다.'); location.href='list.jsp';</script>");
    } else {
        out.println("<script>alert('수정 실패했습니다.'); history.back();</script>");
    }
%>
