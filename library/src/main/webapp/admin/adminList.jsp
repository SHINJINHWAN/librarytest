<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.library.dao.QnaDAO, com.library.dao.ReplyDAO, com.library.dto.Qna" %>

<%
    QnaDAO qnaDao = new QnaDAO();
    ReplyDAO replyDao = new ReplyDAO();
    List<Qna> qnaList = qnaDao.getAllQnas(); // 모든 QnA 글 목록 조회
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 QnA 목록</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background-color: #f2f2f2; }
        a.button { padding: 5px 10px; background: #007bff; color: white; text-decoration: none; border-radius: 4px; margin-right: 5px; }
    </style>
</head>
<body>

<h2>관리자 QnA 목록</h2>

<table>
    <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>등록일</th>
            <th>조회수</th>
            <th>답글 수</th>
            <th>처리상태</th>
            <th>댓글 관리</th>  <%-- 답글 관리 컬럼 추가 --%>
            <th>QnA 관리</th>  <%-- QnA 글 수정/삭제 등 용 --%>
        </tr>
    </thead>
    <tbody>
        <%
            if (qnaList == null || qnaList.isEmpty()) {
        %>
            <tr>
                <td colspan="9" style="text-align:center;">게시글이 없습니다.</td>
            </tr>
        <%
            } else {
                for (Qna qna : qnaList) {
                    int replyCount = replyDao.getRepliesByQnaId(qna.getQnaId()).size();
        %>
            <tr>
                <td><%= qna.getQnaId() %></td>
                <td>
                    <a href="adminDetail.jsp?qnaId=<%= qna.getQnaId() %>"><%= qna.getTitle() %></a>
                </td>
                <td><%= qna.getWriter() %></td>
                <td><%= qna.getRegDate() %></td>
                <td><%= qna.getViewCount() %></td>
                <td><%= replyCount %></td>
                <td><%= (qna.getStatus() == null || qna.getStatus().isEmpty()) ? "대기중" : qna.getStatus() %></td>
                <td>
                    <!-- 답글 관리 페이지 링크 -->
                    <a class="button" href="adminReplyList.jsp?qnaId=<%= qna.getQnaId() %>">댓글 관리</a>
                </td>
                <td>
                    <!-- QnA 글 수정/삭제 버튼 예시 -->
                  
                    <a class="button" href="adminDelete.jsp?qnaId=<%= qna.getQnaId() %>" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
                </td>
            </tr>
        <%
                }
            }
        %>
    </tbody>
</table>

</body>
</html>
