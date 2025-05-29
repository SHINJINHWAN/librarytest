<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.library.dao.ReplyDAO, com.library.dto.Reply" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String action = request.getParameter("action");  // insert, update, delete
    String replyIdStr = request.getParameter("replyId");
    String qnaIdStr = request.getParameter("qnaId");

    if (qnaIdStr == null || action == null || qnaIdStr.trim().isEmpty() || action.trim().isEmpty()) {
        response.sendRedirect("adminList.jsp");
        return;
    }

    int qnaId = Integer.parseInt(qnaIdStr);
    ReplyDAO replyDao = new ReplyDAO();

    if (action.equals("insert")) {
        String writer = request.getParameter("writer");
        String content = request.getParameter("content");

        Reply reply = new Reply();
        reply.setQnaId(qnaId);
        reply.setWriter(writer);
        reply.setContent(content);

        boolean inserted = replyDao.insertReply(reply);

        if (inserted) {
            // ✅ 답글 등록 성공 시 해당 QnA 상태를 '완료'로 변경
            Connection conn = null;
            PreparedStatement ps = null;
            try {
                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/librarydb", "root", "1");

                String sql = "UPDATE qna SET status = '완료' WHERE id = ?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, qnaId);
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (ps != null) try { ps.close(); } catch (Exception e) {}
                if (conn != null) try { conn.close(); } catch (Exception e) {}
            }

            response.sendRedirect("adminDetail.jsp?qnaId=" + qnaId);
        } else {
            out.println("<script>alert('답글 등록 실패'); history.back();</script>");
        }

    } else if (action.equals("update")) {
        if (replyIdStr == null || replyIdStr.trim().isEmpty()) {
            response.sendRedirect("adminDetail.jsp?qnaId=" + qnaId);
            return;
        }

        int replyId = Integer.parseInt(replyIdStr);
        String content = request.getParameter("content");

        Reply reply = new Reply();
        reply.setReplyId(replyId);
        reply.setContent(content);

        boolean updated = replyDao.updateReply(reply);

        if (updated) {
            response.sendRedirect("adminDetail.jsp?qnaId=" + qnaId);
        } else {
            out.println("<script>alert('답글 수정 실패'); history.back();</script>");
        }

    } else if (action.equals("delete")) {
        if (replyIdStr == null || replyIdStr.trim().isEmpty()) {
            response.sendRedirect("adminDetail.jsp?qnaId=" + qnaId);
            return;
        }

        int replyId = Integer.parseInt(replyIdStr);

        boolean deleted = replyDao.deleteReply(replyId);

        if (deleted) {
            response.sendRedirect("adminDetail.jsp?qnaId=" + qnaId);
        } else {
            out.println("<script>alert('답글 삭제 실패'); history.back();</script>");
        }

    } else {
        response.sendRedirect("adminDetail.jsp");
    }
%>
