<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dao.ReplyDAO, com.library.dto.Reply" %>

<%
    String replyIdStr = request.getParameter("replyId");
    if(replyIdStr == null || replyIdStr.trim().isEmpty()) {
        response.sendRedirect("adminList.jsp");
        return;
    }

    int replyId = Integer.parseInt(replyIdStr);
    ReplyDAO replyDao = new ReplyDAO();
    Reply reply = replyDao.getReplyById(replyId);

    if(reply == null) {
        out.println("<script>alert('존재하지 않는 답글입니다.'); location.href='adminList.jsp';</script>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 답글 수정</title>
</head>
<body>

<h2>답글 수정</h2>

<form action="adminReplyProcess.jsp" method="post">
    <input type="hidden" name="replyId" value="<%= reply.getReplyId() %>">
    <input type="hidden" name="qnaId" value="<%= reply.getQnaId() %>">

    작성자: <input type="text" name="writer" value="<%= reply.getWriter() %>" readonly><br><br>

    내용:<br>
    <textarea name="content" rows="6" cols="60" required><%= reply.getContent() %></textarea><br><br>

    <input type="submit" name="action" value="수정">
    <input type="submit" name="action" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');">
</form>

<p><a href="adminReplyList.jsp?qnaId=<%= reply.getQnaId() %>">답글 목록으로 돌아가기</a></p>

</body>
</html>
