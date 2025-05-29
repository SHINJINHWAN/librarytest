<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dao.QnaDAO, com.library.dto.Qna" %>

<%
    // 로그인 체크 (주석 풀면 로그인 기반 권한 제어 가능)
    // String currentUser = (String) session.getAttribute("userNickname");
    // if (!"admin".equals(currentUser)) {
    //     response.sendRedirect("../login.jsp");
    //     return;
    // }

    String qnaIdStr = request.getParameter("qnaId");
    if (qnaIdStr == null) {
        response.sendRedirect("adminList.jsp");
        return;
    }

    int qnaId = Integer.parseInt(qnaIdStr);
    QnaDAO dao = new QnaDAO();
    Qna qna = dao.getQnaById(qnaId);

    if (qna == null) {
        out.println("<script>alert('존재하지 않는 글입니다.'); location.href='adminList.jsp';</script>");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 글 수정</title>
</head>
<body>

<h2>관리자 글 수정</h2>

<form action="adminEditProcess.jsp" method="post">
    <input type="hidden" name="qnaId" value="<%= qna.getQnaId() %>">

    제목: <input type="text" name="title" value="<%= qna.getTitle() %>" required><br><br>

    내용:<br>
    <textarea name="content" rows="10" cols="50" required><%= qna.getContent() %></textarea><br><br>

    공개 여부:
    <select name="openYn">
        <option value="Y" <%= "Y".equals(qna.getOpenYn()) ? "selected" : "" %>>공개</option>
        <option value="N" <%= "N".equals(qna.getOpenYn()) ? "selected" : "" %>>비공개</option>
    </select><br><br>

    비밀번호: <input type="password" name="password" value="<%= qna.getPassword() != null ? qna.getPassword() : "" %>"><br><br>

    <input type="submit" value="수정 완료">
</form>

<p><a href="adminList.jsp">목록으로</a></p>

</body>
</html>
