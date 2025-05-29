<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.library.dao.QnaDAO, com.library.dto.Qna" %>
<%
    // 기본값 설정
    int currentPage = 1; // 기본 페이지 번호
    int pageSize = 15; // 페이지 당 게시글 수
    
    // currentPage 파라미터 처리
    String currentPageParam = request.getParameter("currentPage");
    try {
        if (currentPageParam != null && !currentPageParam.isEmpty()) {
            currentPage = Integer.parseInt(currentPageParam);
        }
    } catch (NumberFormatException e) {
        // currentPage 파라미터가 잘못된 형식일 경우 기본값을 사용
        currentPage = 1;
    }

    QnaDAO dao = new QnaDAO();

    // 전체 게시글 수
    int totalCount = dao.getTotalCount();
    
    // 전체 페이지 수 계산
    int totalPages = (int) Math.ceil((double) totalCount / pageSize);

    // 페이징된 QnA 목록 조회
    List<Qna> qnaList = dao.getQnaByPage(currentPage, pageSize);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QnA 사용자 게시판</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        a {
            text-decoration: none;
            color: blue;
        }
        .pagination {
            margin-top: 20px;
            text-align: center;
        }
        .pagination a {
            margin: 0 5px;
            padding: 5px 10px;
            border: 1px solid #ccc;
            text-decoration: none;
        }
        .pagination .active {
            font-weight: bold;
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>QnA 게시판 (사용자)</h2>
    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>공개</th>
                <th>등록일</th>
                <th>처리상태</th>
                <th>조회수</th>
                <th>카테고리</th>
            </tr>
        </thead>
        <tbody>
        <%
            for (Qna qna : qnaList) {
                String writer = qna.getWriter();
                String prefix = "admin".equalsIgnoreCase(writer) ? "[관리자] " : "";
        %>
            <tr>
                <td><%= qna.getQnaId() %></td>
                <td>
                    <%
                        if ("N".equals(qna.getOpenYn())) {
                    %>
                        🔒 <a href="checkPassword.jsp?qnaId=<%= qna.getQnaId() %>">비공개 글입니다</a>
                    <%
                        } else {
                    %>
                        <a href="detail.jsp?qnaId=<%= qna.getQnaId() %>"><%= prefix + qna.getTitle() %></a>
                    <%
                        }
                    %>
                </td>
                <td><%= "Y".equals(qna.getOpenYn()) ? "공개" : "비공개" %></td>
                <td><%= qna.getRegDate() %></td>
                <td><%= qna.getStatus() %></td>
                <td><%= qna.getViewCount() %></td>
                <td><%= qna.getCategory() != null ? qna.getCategory() : "-" %></td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
    
    <!-- 페이징 네비게이션 -->
    <div class="pagination">
        <%
            if (currentPage > 1) {
        %>
            <a href="list.jsp?currentPage=<%= currentPage - 1 %>">이전</a>
        <%
            }
            for (int i = 1; i <= totalPages; i++) {
                String activeClass = (i == currentPage) ? "active" : "";
        %>
            <a href="list.jsp?currentPage=<%= i %>" class="<%= activeClass %>"><%= i %></a>
        <%
            }
            if (currentPage < totalPages) {
        %>
            <a href="list.jsp?currentPage=<%= currentPage + 1 %>">다음</a>
        <%
            }
        %>
    </div>

    <br>
    <a href="write.jsp">글쓰기</a>
</body>
</html>
