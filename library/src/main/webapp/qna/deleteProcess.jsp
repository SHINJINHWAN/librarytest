<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dao.QnaDAO, com.library.dto.Qna" %>

<%
    request.setCharacterEncoding("UTF-8");
    int qnaId = Integer.parseInt(request.getParameter("qnaId"));
    String password = request.getParameter("password");

    QnaDAO dao = new QnaDAO();
    Qna qna = dao.getQnaById(qnaId);

    if (qna == null) {
        out.println("<script>alert('존재하지 않는 글입니다.'); location.href='list.jsp';</script>");
        return;
    }

    String currentUser = (String) session.getAttribute("userNickname");
    boolean isAdmin = "admin".equals(currentUser);
    boolean isWriter = currentUser != null && currentUser.equals(qna.getWriter());

    if (!isAdmin && !isWriter) {
        out.println("<script>alert('삭제 권한이 없습니다.'); location.href='list.jsp';</script>");
        return;
    }

    // 비밀번호가 설정되어 있는 경우 검증
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
%>
