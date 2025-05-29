<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dao.QnaDAO, com.library.dao.ReplyDAO, com.library.dto.Qna, com.library.dto.Reply, java.util.List" %>

<%
    String qnaIdStr = request.getParameter("qnaId");
    if (qnaIdStr == null || qnaIdStr.trim().isEmpty()) {
        response.sendRedirect("list.jsp");
        return;
    }
    int qnaId = Integer.parseInt(qnaIdStr);

    QnaDAO qnaDao = new QnaDAO();
    ReplyDAO replyDao = new ReplyDAO();

    // QnA 상세 가져오기
    Qna qna = qnaDao.getQnaById(qnaId);
    if (qna == null) {
        out.println("<script>alert('존재하지 않는 게시글입니다.'); location.href='list.jsp';</script>");
        return;
    }

    // 답글 리스트 가져오기 (관리자 답글)
    List<Reply> replyList = replyDao.getRepliesByQnaId(qnaId);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QnA 상세보기 (사용자)</title>
    <style>
        .qna-section, .reply-section { border: 1px solid #ccc; padding: 15px; margin-bottom: 20px; }
        .reply { border-top: 1px solid #ddd; padding: 10px 0; }
        pre { white-space: pre-wrap; word-break: break-word; }
    </style>
</head>
<body>

<h2>QnA 상세보기 (사용자)</h2>

<div class="qna-section">
    <h3><%= qna.getTitle() %></h3>
    <p><strong>작성자:</strong> <%= qna.getWriter() %></p>
    <p><strong>등록일:</strong> <%= qna.getRegDate() %></p>
    <p><strong>조회수:</strong> <%= qna.getViewCount() %></p>
    <p><strong>처리상태:</strong> <%= (qna.getStatus() == null || qna.getStatus().isEmpty()) ? "대기중" : qna.getStatus() %></p>
    <hr>
    <p><%= qna.getContent().replaceAll("\n", "<br/>") %></p>
</div>

<div class="reply-section">
    <h3>관리자 답변</h3>
    <%
        if (replyList == null || replyList.isEmpty()) {
    %>
        <p>아직 답변이 등록되지 않았습니다.</p>
    <%
        } else {
            for (Reply r : replyList) {
                // 관리자가 작성한 답글만 출력 (작성자 이름이 'admin' 이라고 가정)
                if ("admin".equalsIgnoreCase(r.getWriter())) {
    %>
        <div class="reply">
            <p><strong>작성자:</strong> <%= r.getWriter() %> | <strong>작성일:</strong> <%= r.getRegDate() %></p>
            <pre><%= r.getContent().replaceAll("\n", "<br/>") %></pre>
        </div>
    <%
                }
            }
        }
    %>
</div>

<p><a href="list.jsp">목록으로 돌아가기</a></p>

</body>
</html>
