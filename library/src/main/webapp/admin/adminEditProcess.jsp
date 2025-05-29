<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dto.Qna, com.library.dao.QnaDAO" %>

<%
    request.setCharacterEncoding("UTF-8");

    // 세션 체크 예시 (주석 해제 시 적용 가능)
    // String currentUser = (String) session.getAttribute("userNickname");
    // if (!"admin".equals(currentUser)) {
    //     response.sendRedirect("../login.jsp");
    //     return;
    // }

    String qnaIdStr = request.getParameter("qnaId");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String openYn = request.getParameter("openYn");  // 공개여부
    String password = request.getParameter("password");
    String status = request.getParameter("status");  // 처리상태 (예: 완료, 대기중)

    // 필수 값 체크
    if (qnaIdStr == null || title == null || content == null || openYn == null) {
        response.sendRedirect("adminList.jsp");
        return;
    }

    int qnaId = Integer.parseInt(qnaIdStr);

    // Qna 객체 생성 및 설정
    Qna qna = new Qna();
    qna.setQnaId(qnaId);
    qna.setTitle(title);
    qna.setContent(content);
    qna.setOpenYn(openYn);
    qna.setStatus(status != null ? status : "대기중");
    qna.setPassword((password != null && !password.trim().isEmpty()) ? password : null);

    // DAO 업데이트
    QnaDAO dao = new QnaDAO();
    boolean success = dao.updateQna(qna);

    if (success) {
        response.sendRedirect("adminList.jsp");
    } else {
%>
        <script>
            alert("수정 실패했습니다.");
            history.back();
        </script>
<%
    }
%>
