<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String writer = request.getParameter("writer");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String openYn = request.getParameter("openYn");
    String password = request.getParameter("password");
    String category = request.getParameter("category");  // 카테고리 추가

    Connection conn = null;
    PreparedStatement ps = null;

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/librarydb", "root", "1");

        String sql = "INSERT INTO qna (title, content, writer, reg_date, status, view_count, password, open_yn, category) " +
                     "VALUES (?, ?, ?, NOW(), '대기중', 0, ?, ?, ?)";

        ps = conn.prepareStatement(sql);
        ps.setString(1, title);
        ps.setString(2, content);
        ps.setString(3, writer);
        ps.setString(4, password);
        ps.setString(5, openYn);
        ps.setString(6, category);  // 카테고리 값 세팅

        int result = ps.executeUpdate();

        if (result > 0) {
            response.sendRedirect("list.jsp");
        } else {
            out.println("<script>alert('글 작성에 실패했습니다.'); history.back();</script>");
        }

    } catch(Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다.'); history.back();</script>");
    } finally {
        if (ps != null) try { ps.close(); } catch(Exception e) {}
        if (conn != null) try { conn.close(); } catch(Exception e) {}
    }
%>
