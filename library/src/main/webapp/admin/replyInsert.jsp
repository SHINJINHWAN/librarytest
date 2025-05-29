<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dao.ReplyDAO, com.library.dto.Reply, com.library.dao.QnaDAO" %>

<%
    request.setCharacterEncoding("UTF-8");

    String content = request.getParameter("content");
    String writer = request.getParameter("writer");  // 보통 "admin"으로 고정
    String qnaIdParam = request.getParameter("qnaId");

    if (content == null || content.trim().isEmpty() || writer == null || qnaIdParam == null) {
%>
        <script>
            alert("필수 입력값이 누락되었습니다.");
            history.back();
        </script>
<%
        return;
    }

    int qnaId = 0;
    try {
        qnaId = Integer.parseInt(qnaIdParam);
    } catch (NumberFormatException e) {
%>
        <script>
            alert("잘못된 접근입니다.");
            history.back();
        </script>
<%
        return;
    }

    Reply reply = new Reply();
    reply.setQnaId(qnaId);
    reply.setContent(content);
    reply.setWriter(writer);

    ReplyDAO replyDao = new ReplyDAO();
    boolean success = replyDao.insertReply(reply);

    if (success) {
        // 답글 등록 성공 시 QnA 상태 "완료"로 변경
        QnaDAO qnaDao = new QnaDAO();
        qnaDao.updateStatus(qnaId, "완료");  // 상태 변경 실패해도 답글 등록은 성공 처리

        // 답글 작성 후 상세페이지로 이동
        response.sendRedirect("adminDetail.jsp?qnaId=" + qnaId);
    } else {
%>
        <script>
            alert("답글 등록에 실패했습니다.");
            history.back();
        </script>
<%
    }
%>
