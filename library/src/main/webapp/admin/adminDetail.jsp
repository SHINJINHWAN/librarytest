<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dao.QnaDAO, com.library.dao.ReplyDAO, com.library.dto.Qna, com.library.dto.Reply, java.util.List" %>

<%
    String qnaIdStr = request.getParameter("qnaId");
    if (qnaIdStr == null || qnaIdStr.trim().isEmpty()) {
        response.sendRedirect("adminList.jsp");
        return;
    }

    int qnaId = Integer.parseInt(qnaIdStr);

    QnaDAO qnaDao = new QnaDAO();
    ReplyDAO replyDao = new ReplyDAO();

    Qna qna = qnaDao.getQnaById(qnaId);
    if (qna == null) {
        out.println("<script>alert('존재하지 않는 게시글입니다.'); location.href='adminList.jsp';</script>");
        return;
    }

    List<Reply> replyList = replyDao.getRepliesByQnaId(qnaId);

    String editReplyIdStr = request.getParameter("editReplyId");
    int editReplyId = -1;
    if(editReplyIdStr != null && !editReplyIdStr.trim().isEmpty()) {
        try {
            editReplyId = Integer.parseInt(editReplyIdStr);
        } catch(Exception e) {
            editReplyId = -1;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QnA 상세보기 (관리자)</title>
    <style>
        .qna-section, .reply-section, .repl-section { border: 1px solid #ccc; padding: 15px; margin-bottom: 20px; }
        .reply { border-top: 1px solid #ddd; padding: 10px 0; }
        textarea { width: 100%; height: 100px; }
        input[type=text] { width: 200px; }
        form.inline { display: inline; }
        .btn { padding: 3px 8px; margin-left: 5px; cursor: pointer; }
        .btn-edit { background-color: #ffc107; border: none; color: white; border-radius: 3px; }
        .btn-delete { background-color: #dc3545; border: none; color: white; border-radius: 3px; }
        .btn-save { background-color: #28a745; border: none; color: white; border-radius: 3px; }
        .btn-cancel { background-color: #6c757d; border: none; color: white; border-radius: 3px; }
    </style>
</head>
<body>

<h2>QnA 상세보기 (관리자)</h2>

<div class="qna-section">
    <h3><%= qna.getTitle() %></h3>
    <p><strong>작성자:</strong> <%= qna.getWriter() %></p>
    <p><strong>등록일:</strong> <%= qna.getRegDate() %></p>
    <p><strong>조회수:</strong> <%= qna.getViewCount() %></p>

    <form action="updateStatusProcess.jsp" method="post" style="display:inline;">
        <input type="hidden" name="qnaId" value="<%= qna.getQnaId() %>">
        <label><strong>처리상태:</strong></label>
        <select name="status">
            <option value="대기중" <%= "대기중".equals(qna.getStatus()) ? "selected" : "" %>>대기중</option>
            <option value="진행중" <%= "진행중".equals(qna.getStatus()) ? "selected" : "" %>>진행중</option>
            <option value="완료" <%= "완료".equals(qna.getStatus()) ? "selected" : "" %>>완료</option>
        </select>
        <button type="submit">변경</button>
    </form>

    <hr>
    <p><%= qna.getContent().replaceAll("\n", "<br/>") %></p>
</div>

<div class="reply-section">
    <h3>답글 목록</h3>
    <%
        if (replyList == null || replyList.isEmpty()) {
    %>
        <p>등록된 답글이 없습니다.</p>
    <%
        } else {
            for (Reply r : replyList) {
    %>
        <div class="reply">
            <p><strong>작성자:</strong> <%= r.getWriter() %> | <strong>작성일:</strong> <%= r.getRegDate() %></p>

            <%
                if (r.getReplyId() == editReplyId) {
            %>
                <form action="adminReplyProcess.jsp" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="replyId" value="<%= r.getReplyId() %>">
                    <textarea name="content" required><%= r.getContent() %></textarea><br>
                    <input type="submit" value="저장" class="btn btn-save">
                    <a href="adminDetail.jsp?qnaId=<%= qnaId %>" class="btn btn-cancel">취소</a>
                </form>
            <%
                } else {
            %>
                <p><%= r.getContent().replaceAll("\n", "<br/>") %></p>
                <form action="adminDetail.jsp" method="get" class="inline" style="margin:0;">
                    <input type="hidden" name="qnaId" value="<%= qnaId %>">
                    <input type="hidden" name="editReplyId" value="<%= r.getReplyId() %>">
                    <input type="submit" value="수정" class="btn btn-edit">
                </form>

                <form action="adminReplyProcess.jsp" method="post" class="inline" style="margin:0;" onsubmit="return confirm('삭제하시겠습니까?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="replyId" value="<%= r.getReplyId() %>">
                    <input type="hidden" name="qnaId" value="<%= qnaId %>">
                    <input type="submit" value="삭제" class="btn btn-delete">
                </form>
            <%
                }
            %>
        </div>
    <%
            }
        }
    %>
</div>

<div class="repl-section">
    <h3>새 답글 작성</h3>
    <form action="adminReplyProcess.jsp" method="post">
        <input type="hidden" name="action" value="insert">
        <input type="hidden" name="qnaId" value="<%= qna.getQnaId() %>">
        <input type="hidden" name="writer" value="admin">
        <textarea name="content" required placeholder="답글 내용을 입력하세요."></textarea><br><br>
        <input type="submit" value="답글 등록">
    </form>
</div>

<p><a href="adminList.jsp">목록으로 돌아가기</a></p>

</body>
</html>
