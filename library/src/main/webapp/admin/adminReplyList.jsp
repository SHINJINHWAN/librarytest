<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List, com.library.dto.Reply, com.library.dao.ReplyDAO" %>

<%
    String qnaIdStr = request.getParameter("qnaId");
    if(qnaIdStr == null || qnaIdStr.trim().isEmpty()) {
        out.println("<script>alert('잘못된 접근입니다.'); location.href='adminList.jsp';</script>");
        return;
    }
    int qnaId = Integer.parseInt(qnaIdStr);

    ReplyDAO replyDao = new ReplyDAO();
    List<Reply> replyList = replyDao.getRepliesByQnaId(qnaId);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 답글 목록</title>
</head>
<body>

<h2>QnA ID: <%= qnaId %> - 관리자 답글 목록</h2>

<% if(replyList == null || replyList.isEmpty()) { %>
    <p>등록된 답글이 없습니다.</p>
<% } else { %>
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>답글ID</th>
            <th>작성자</th>
            <th>내용</th>
            <th>작성일</th>
            <th>수정</th>
        </tr>
        <% for(Reply r : replyList) { %>
            <tr>
                <td><%= r.getReplyId() %></td>
                <td><%= r.getWriter() %></td>
                <td><%= r.getContent().replaceAll("\n", "<br/>") %></td>
                <td><%= r.getRegDate() %></td>
                <td>
                    <a href="adminReplyEdit.jsp?replyId=<%= r.getReplyId() %>">수정</a>
                </td>
            </tr>
        <% } %>
    </table>
<% } %>

<p><a href="adminList.jsp">QnA 목록으로 돌아가기</a></p>

</body>
</html>
