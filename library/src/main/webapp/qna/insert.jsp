<%@ page import="com.library.dao.QnaDAO" %>
<%@ page import="com.library.dto.Qna" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");

    String title = request.getParameter("title");
    String content = request.getParameter("content");
    // 로그인된 사용자 닉네임을 writer로 사용
    String writer = (String) session.getAttribute("userNickname");
    String password = request.getParameter("password");
    String status = request.getParameter("status");
    String category = request.getParameter("category");

    if(writer == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }

    Qna qna = new Qna();
    qna.setTitle(title);
    qna.setContent(content);
    qna.setWriter(writer);
    qna.setPassword(password);
    qna.setStatus(status);
    qna.setCategory(category);

    QnaDAO dao = new QnaDAO();
    boolean result = dao.insertQna(qna);

    if(result) {
        response.sendRedirect("list.jsp");
    } else {
        out.println("<script>alert('글 등록 실패'); history.back();</script>");
    }
%>
