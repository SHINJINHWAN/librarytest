<%@ page import="com.library.dao.QnaDAO" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    int qnaId = 0;
    String status = request.getParameter("status");

    try {
        qnaId = Integer.parseInt(request.getParameter("qnaId"));
    } catch (Exception e) {
        out.println("<script>alert('잘못된 접근입니다.'); location.href='adminList.jsp';</script>");
        return;
    }

    QnaDAO dao = new QnaDAO();
    boolean success = dao.updateStatus(qnaId, status);

    if (success) {
        response.sendRedirect("adminDetail.jsp?qnaId=" + qnaId);
    } else {
%>
        <script>
            alert('처리상태 변경에 실패했습니다.');
            history.back();
        </script>
<%
    }
%>
