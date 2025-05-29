<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dao.QnaDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    int qnaId = Integer.parseInt(request.getParameter("qnaId"));
    String answer = request.getParameter("answer");

    QnaDAO dao = new QnaDAO();
    boolean success = dao.updateAnswer(qnaId, answer);

    if(success) {
        response.sendRedirect("adminDetail.jsp?qnaId=" + qnaId);
    } else {
        out.println("<script>alert('답변 등록 실패'); history.back();</script>");
    }
%>
