<%@ page import="com.library.dao.QnaDAO" %>
<%@ page import="com.library.dto.Qna" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    request.setCharacterEncoding("UTF-8");

    int qnaId = Integer.parseInt(request.getParameter("qnaId"));
    String inputPassword = request.getParameter("password");
    String action = request.getParameter("action");

    QnaDAO dao = new QnaDAO();
    Qna qna = dao.getQnaById(qnaId);

    if (qna == null) {
        out.println("<script>alert('게시글이 존재하지 않습니다.'); location.href='list.jsp';</script>");
        return;
    }

    // 비밀번호 검사 (null 처리 포함)
    String dbPassword = qna.getPassword();
    if (dbPassword == null || !dbPassword.equals(inputPassword)) {
        out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
        return;
    }

    if ("view".equals(action)) {
        // 비밀번호 인증 성공 -> 세션에 인증 기록 후 상세보기로 이동
        session.setAttribute("authenticatedQnaId_" + qnaId, true);
        response.sendRedirect("detail.jsp?qnaId=" + qnaId);
    } else if ("edit".equals(action)) {
        // 비밀번호 인증 성공 -> 수정 페이지로 이동
        response.sendRedirect("edit.jsp?qnaId=" + qnaId);
    } else if ("delete".equals(action)) {
        // 비밀번호 인증 성공 -> 삭제 처리 후 목록으로 이동
        boolean deleted = dao.deleteQna(qnaId);
        if (deleted) {
            out.println("<script>alert('삭제되었습니다.'); location.href='list.jsp';</script>");
        } else {
            out.println("<script>alert('삭제 실패'); history.back();</script>");
        }
    } else {
        out.println("<script>alert('잘못된 요청입니다.'); location.href='list.jsp';</script>");
    }
%>
