<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dao.QnaDAO" %>

<%
    request.setCharacterEncoding("UTF-8");
    String qnaIdStr = request.getParameter("qnaId");

    if (qnaIdStr == null || qnaIdStr.trim().isEmpty()) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    int qnaId = Integer.parseInt(qnaIdStr);
    QnaDAO dao = new QnaDAO();
    boolean deleted = dao.deleteQna(qnaId);

    if (deleted) {
        response.sendRedirect("adminList.jsp");
    } else {
        out.println("<script>alert('삭제 실패했습니다.'); history.back();</script>");
    }
%>
