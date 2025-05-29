<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dao.ReplyDAO" %>

<%
    int replyId = Integer.parseInt(request.getParameter("replyId"));
    int qnaId = Integer.parseInt(request.getParameter("qnaId"));

    ReplyDAO replyDao = new ReplyDAO();
    boolean success = replyDao.deleteReply(replyId);

    if(success) {
        response.sendRedirect("adminReplyList.jsp?qnaId=" + qnaId);
    } else {
%>
        <script>
            alert("답글 삭제에 실패했습니다.");
            history.back();
        </script>
<%
    }
%>
